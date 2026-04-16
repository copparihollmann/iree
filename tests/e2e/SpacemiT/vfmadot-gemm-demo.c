// Cross-compile:
//   riscv64-unknown-linux-gnu-gcc -march=rv64gcv -O2 vfmadot-gemm-demo.c -o vfmadot-fp8-demo -lm
//
// Or with the SpacemiT toolchain:
//   $RISCV_TOOLCHAIN_ROOT/bin/clang --sysroot=$RISCV_TOOLCHAIN_ROOT/sysroot \
//     -march=rv64gc_zba_zbb_zbc_zbs -O2 vfmadot-gemm-demo.c -o vfmadot-fp8-demo -lm
//
// Simple demo: vfmadot for FP8 (f8E4M3FN) matrix multiply.
// A_{4x8} * B_{8x4} -> C_{4x4}
// Input:  f8E4M3FN (8-bit float, 4-bit exponent, 3-bit mantissa)
// Output: f16 (16-bit float)
//
// The vfmadot instruction does:
//   C[4x4] += A[4x8] . B[8x4]   (fp8 x fp8 -> fp16 accumulation)

#include <assert.h>
#include <math.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ── f8E4M3FN conversion helpers ─────────────────────────────────────────────
// E4M3FN: 1 sign, 4 exponent, 3 mantissa, bias=7, no inf, NaN=0x7F/0xFF

static float fp8e4m3fn_to_float(uint8_t bits) {
  uint32_t sign = (bits >> 7) & 1;
  uint32_t exp = (bits >> 3) & 0xF;
  uint32_t mant = bits & 0x7;

  if (exp == 0xF && mant == 0x7) return NAN; // NaN
  float val;
  if (exp == 0) {
    // Subnormal: (-1)^s * 2^(1-7) * (0.mant)
    val = ldexpf((float)mant / 8.0f, 1 - 7);
  } else {
    // Normal: (-1)^s * 2^(exp-7) * (1 + mant/8)
    val = ldexpf(1.0f + (float)mant / 8.0f, (int)exp - 7);
  }
  return sign ? -val : val;
}

static uint8_t float_to_fp8e4m3fn(float val) {
  if (isnan(val)) return 0x7F;
  uint32_t bits;
  memcpy(&bits, &val, 4);
  uint32_t sign = (bits >> 31) & 1;
  int32_t exp = ((bits >> 23) & 0xFF) - 127;
  uint32_t frac = bits & 0x7FFFFF;

  // Clamp to E4M3FN range: max normal = 448.0
  float absval = fabsf(val);
  if (absval == 0.0f) return sign << 7;
  if (absval > 448.0f) {
    // Saturate to max representable (0x7E = 448.0)
    return (sign << 7) | 0x7E;
  }

  int32_t e4_exp = exp + 7; // bias=7
  if (e4_exp <= 0) {
    // Subnormal
    int shift = 1 - e4_exp;
    uint32_t m = (0x800000 | frac) >> (20 + shift);
    return (sign << 7) | (m & 0x7);
  }
  if (e4_exp >= 15) e4_exp = 14; // Clamp exponent

  uint32_t m = frac >> 20; // Keep top 3 mantissa bits
  return (sign << 7) | (e4_exp << 3) | (m & 0x7);
}

// ── Reference GEMM in float ─────────────────────────────────────────────────

static void reference_gemm_fp8(size_t M, size_t N, size_t K,
                                const uint8_t* A, const uint8_t* B,
                                uint16_t* C_f16) {
  for (size_t m = 0; m < M; ++m) {
    for (size_t n = 0; n < N; ++n) {
      float acc = 0.0f;
      for (size_t k = 0; k < K; ++k) {
        float a = fp8e4m3fn_to_float(A[m * K + k]);
        float b = fp8e4m3fn_to_float(B[k * N + n]);
        acc += a * b;
      }
      // Convert float to f16 (IEEE 754 binary16)
      // Simple truncation
      uint32_t fbits;
      memcpy(&fbits, &acc, 4);
      uint32_t sign = (fbits >> 31) & 1;
      int32_t exp = ((fbits >> 23) & 0xFF) - 127 + 15;
      uint32_t frac = fbits & 0x7FFFFF;
      uint16_t h;
      if (exp <= 0) {
        h = (sign << 15);
      } else if (exp >= 31) {
        h = (sign << 15) | 0x7C00;
      } else {
        h = (sign << 15) | (exp << 10) | (frac >> 13);
      }
      C_f16[m * N + n] = h;
    }
  }
}

static float f16_to_float(uint16_t h) {
  uint32_t sign = (h >> 15) & 1;
  uint32_t exp = (h >> 10) & 0x1F;
  uint32_t frac = h & 0x3FF;
  float val;
  if (exp == 0) {
    val = ldexpf((float)frac / 1024.0f, -14);
  } else if (exp == 31) {
    return frac ? NAN : (sign ? -INFINITY : INFINITY);
  } else {
    val = ldexpf(1.0f + (float)frac / 1024.0f, (int)exp - 15);
  }
  return sign ? -val : val;
}

// ── Pack B (transpose) ──────────────────────────────────────────────────────
// B is KxN row-major. Pack to N-groups-of-K for vmadot input layout.

static void pack_b(size_t K, size_t N, const uint8_t* B, uint8_t* packedB) {
  for (size_t n = 0; n < N; ++n) {
    for (size_t k = 0; k < K; ++k) {
      packedB[n * K + k] = B[k * N + n];
    }
  }
}

// ── vfmadot GEMM ───────────────────────────────────────────────────────────
// A is packed as 4x8 (32 bytes), packedB is packed as 4x8 (32 bytes)
// Output C is 4x4 fp16 (16 values = 32 bytes = one VR)

static void gemm_vfmadot(size_t M, size_t N, size_t K,
                          const uint8_t* A, const uint8_t* packedB,
                          uint16_t* C) {
  size_t vl_acc = 16;
  size_t vl_in = 32;

  // Zero the accumulator (v8, VR, 16 x fp16)
  __asm__ volatile("vsetvli zero, %0, e16, m1, ta, ma\n\t"
                   "vmv.v.i v8, 0"
                   :
                   : "r"(vl_acc));

  // Loop over K dimension
  __asm__ volatile(
      "li t0, 32\n\t"
      ".word 0x0c02f057\n\t" // vsetvli zero, t0, e8, m1, ta, ma

      "vle8.v v0, (%[A])\n\t"
      "vle8.v v4, (%[B])\n\t"

      // vfmadot v8, v0, v4
      ".insn r 0x2b, 0, 0x75, v8, v0, v4\n\t"
      :
      : [A] "r"(A), [B] "r"(packedB)
      : "memory", "t0");

  // Store result (fp16)
  __asm__ volatile("vsetvli zero, %0, e16, m1, ta, ma\n\t"
                   "vse16.v v8, (%1)"
                   :
                   : "r"(vl_acc), "r"(C)
                   : "memory");
}

// ── Also test vmadot (int8) for comparison ──────────────────────────────────

static void gemm_vmadot(size_t M, size_t N, size_t K,
                         const int8_t* A, const int8_t* packedB,
                         int32_t* C) {
  size_t vl_acc = 16;

  // Zero the accumulator (v8, VRM2, 16 x i32)
  __asm__ volatile("vsetvli zero, %0, e32, m2, ta, ma\n\t"
                   "vmv.v.i v8, 0"
                   :
                   : "r"(vl_acc));

  __asm__ volatile(
      "li t0, 32\n\t"
      ".word 0x0c02f057\n\t" // vsetvli zero, t0, e8, m1, ta, ma

      "vle8.v v0, (%[A])\n\t"
      "vle8.v v4, (%[B])\n\t"

      // vmadot v8, v0, v4 (integer SS)
      ".insn r 0x2b, 3, 0x71, v8, v0, v4\n\t"
      :
      : [A] "r"(A), [B] "r"(packedB)
      : "memory", "t0");

  // Store result (i32)
  __asm__ volatile("vsetvli zero, %0, e32, m2, ta, ma\n\t"
                   "vse32.v v8, (%1)"
                   :
                   : "r"(vl_acc), "r"(C)
                   : "memory");
}

// ── Display helpers ─────────────────────────────────────────────────────────

static void display_fp8(size_t rows, size_t cols, const uint8_t* data) {
  for (size_t r = 0; r < rows; ++r) {
    for (size_t c = 0; c < cols; ++c) {
      printf("%8.3f", fp8e4m3fn_to_float(data[r * cols + c]));
    }
    printf("\n");
  }
}

static void display_f16(size_t rows, size_t cols, const uint16_t* data) {
  for (size_t r = 0; r < rows; ++r) {
    for (size_t c = 0; c < cols; ++c) {
      printf("%8.3f", f16_to_float(data[r * cols + c]));
    }
    printf("\n");
  }
}

static void display_i32(size_t rows, size_t cols, const int32_t* data) {
  for (size_t r = 0; r < rows; ++r) {
    for (size_t c = 0; c < cols; ++c) {
      printf("%7d ", data[r * cols + c]);
    }
    printf("\n");
  }
}

// ── Main ────────────────────────────────────────────────────────────────────

int main() {
  printf("=== SpacemiT IME Demo: vmadot (int8) + vfmadot (fp8) ===\n\n");

  // ---- INT8 test first (known working) ----
  printf("--- INT8 vmadot test ---\n");
  int8_t A_i8[32], B_i8[32], packB_i8[32];
  int32_t C_i8[16] = {0}, CRef_i8[16] = {0};

  srand(42);
  for (int i = 0; i < 32; i++) {
    A_i8[i] = (rand() % 10) - 5;
    B_i8[i] = (rand() % 10) - 5;
  }

  // Pack B
  pack_b(8, 4, (const uint8_t*)B_i8, (uint8_t*)packB_i8);

  // Reference
  for (int m = 0; m < 4; m++)
    for (int n = 0; n < 4; n++) {
      int32_t acc = 0;
      for (int k = 0; k < 8; k++)
        acc += (int32_t)A_i8[m * 8 + k] * (int32_t)B_i8[k * 4 + n];
      CRef_i8[m * 4 + n] = acc;
    }

  // vmadot
  gemm_vmadot(4, 4, 8, A_i8, packB_i8, C_i8);

  printf("A (4x8 i8):\n");
  for (int r = 0; r < 4; r++) {
    for (int c = 0; c < 8; c++) printf("%4d", A_i8[r * 8 + c]);
    printf("\n");
  }
  printf("Reference C (4x4 i32):\n");
  display_i32(4, 4, CRef_i8);
  printf("vmadot C (4x4 i32):\n");
  display_i32(4, 4, C_i8);

  int i8_ok = 1;
  for (int i = 0; i < 16; i++) {
    if (CRef_i8[i] != C_i8[i]) { i8_ok = 0; break; }
  }
  printf("INT8 vmadot: %s\n\n", i8_ok ? "PASS" : "FAIL");

  // ---- FP8 test ----
  printf("--- FP8 vfmadot test ---\n");

  // Use small known values: 1.0, 2.0, 0.5 etc.
  // f8E4M3FN: 1.0 = 0x38, 2.0 = 0x40, 0.5 = 0x30
  uint8_t A_fp8[32], B_fp8[32], packB_fp8[32];
  uint16_t C_fp8[16] = {0}, CRef_fp8[16] = {0};

  for (int i = 0; i < 32; i++) {
    float v = (float)((rand() % 5) + 1); // 1..5
    A_fp8[i] = float_to_fp8e4m3fn(v);
    v = (float)((rand() % 5) + 1);
    B_fp8[i] = float_to_fp8e4m3fn(v);
  }

  pack_b(8, 4, B_fp8, packB_fp8);

  // Reference
  reference_gemm_fp8(4, 4, 8, A_fp8, B_fp8, CRef_fp8);

  printf("A (4x8 fp8 as float):\n");
  display_fp8(4, 8, A_fp8);
  printf("B (8x4 fp8 as float):\n");
  display_fp8(8, 4, B_fp8);

  // vfmadot
  printf("Calling vfmadot...\n");
  gemm_vfmadot(4, 4, 8, A_fp8, packB_fp8, C_fp8);

  printf("Reference C (4x4 f16 as float):\n");
  display_f16(4, 4, CRef_fp8);
  printf("vfmadot C (4x4 f16 as float):\n");
  display_f16(4, 4, C_fp8);

  printf("\nDone.\n");
  return 0;
}
