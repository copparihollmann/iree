// Simple standalone test for SpacemiT IME (vmadot/vfmadot).
// Compiled WITHOUT +v in march to avoid auto-vectorization of libc.
// All vector instructions use raw .word/.insn encoding.
//
// Cross-compile:
//   $TOOLCHAIN/bin/clang --sysroot=$TOOLCHAIN/sysroot \
//     -march=rv64gc_zba_zbb_zbc_zbs -O0 ime-simple-test.c -o ime-test

#include <stdint.h>
#include <stdio.h>
#include <string.h>

// ── Raw instruction encodings ───────────────────────────────────────────────
// All encoded as .word to avoid requiring +v in the compiler march.
//
// vsetvli zero, t0, e8, m1, ta, ma  = 0x0c02f057
// vsetvli zero, t0, e16, m1, ta, ma = 0x0c82f057  (SEW=16 -> vtypei=0xC8)
// vsetvli zero, t0, e32, m2, ta, ma = 0x0c92f057  (SEW=32,LMUL=2 -> vtypei=0xC9)
//
// vmv.v.i v8, 0:
//   opcode=0x57, funct3=3(OPIVI), funct6=0x17, vd=8, imm=0, vm=1
//   = 0x5e003457
//
// vle8.v v0, (rs1):  opcode=0x07, width=0(e8), vd=0, rs1=reg, vm=1, nf=0, mew=0, mop=0
// vse8.v v0, (rs1):  opcode=0x27
// vle16.v v0, (rs1): opcode=0x07, width=5(e16)
// vse16.v v0, (rs1): opcode=0x27, width=5(e16)
// vle32.v v8, (rs1): opcode=0x07, width=6(e32), vd=8
// vse32.v v8, (rs1): opcode=0x27, width=6(e32), vd=8

static void vsetvli_e32_m2(size_t avl) {
  // vsetvli zero, avl, e32, m2, ta, ma
  // vtypei = ma:ta:0:sew:lmul = 1:1:0:010:001 = 0xC9
  __asm__ volatile(".insn i 0x57, 7, x0, %0, 0xC9" : : "r"(avl));
}

static void vsetvli_e16_m1(size_t avl) {
  // vtypei = ma:ta:0:001:000 = 0xC8
  __asm__ volatile(".insn i 0x57, 7, x0, %0, 0xC8" : : "r"(avl));
}

int main() {
  printf("=== SpacemiT IME Instruction Test ===\n\n");

  // ---- Test 1: vmadot (int8, 4x4x8) ----
  printf("Test 1: vmadot (int8 SS)...\n");
  {
    int8_t A[32], B[32];
    int32_t C[16];
    for (int i = 0; i < 32; i++) { A[i] = 1; B[i] = 1; }
    for (int i = 0; i < 16; i++) C[i] = 0;

    __asm__ volatile(
        // vsetvli zero, t0, e32, m2, ta, ma (AVL=16 for 16 x i32)
        "li t0, 16\n\t"
        ".word 0x0d12f057\n\t"
        // vmv.v.i v8, 0
        ".word 0x5e003457\n\t"
        // vsetvli zero, t0, e8, m1, ta, ma (AVL=32)
        "li t0, 32\n\t"
        ".word 0x0c02f057\n\t"
        // vle8.v v0, (A)  -- opcode=0x07, width=0, vd=0
        "vle8.v v0, (%[A])\n\t"
        // vle8.v v4, (B)  -- vd=4
        "vle8.v v4, (%[B])\n\t"
        // vmadot v8, v0, v4
        ".insn r 0x2b, 3, 0x71, v8, v0, v4\n\t"
        // vsetvli zero, t0, e32, m2, ta, ma (AVL=16)
        "li t0, 16\n\t"
        ".word 0x0d12f057\n\t"
        // vse32.v v8, (C)
        "vse32.v v8, (%[C])\n\t"
        :
        : [A] "r"(A), [B] "r"(B), [C] "r"(C)
        : "memory", "t0");

    printf("  C[0]=%d C[15]=%d (expect 8)\n", C[0], C[15]);
    printf("  vmadot: %s\n\n", (C[0] == 8 && C[15] == 8) ? "PASS" : "FAIL");
  }

  // ---- Test 2: vfmadot (fp8, 4x4x8) ----
  printf("Test 2: vfmadot (fp8 -> fp16)...\n");
  {
    // f8E4M3FN 1.0 = 0x38 (sign=0, exp=0b0111=7, mant=0b000)
    uint8_t A[32], B[32];
    uint16_t C[16];
    for (int i = 0; i < 32; i++) { A[i] = 0x38; B[i] = 0x38; }
    for (int i = 0; i < 16; i++) C[i] = 0;

    __asm__ volatile(
        // vsetvli zero, t0, e16, m1, ta, ma (AVL=16 for 16 x fp16)
        "li t0, 16\n\t"
        ".word 0x0c82f057\n\t"
        // vmv.v.i v8, 0  (zero the fp16 accumulator)
        ".word 0x5e003457\n\t"
        // vsetvli zero, t0, e8, m1, ta, ma (AVL=32)
        "li t0, 32\n\t"
        ".word 0x0c02f057\n\t"
        // vle8.v v0, (A)
        "vle8.v v0, (%[A])\n\t"
        // vle8.v v4, (B)
        "vle8.v v4, (%[B])\n\t"
        // vfmadot v8, v0, v4 (fp8 dot -> fp16)
        ".insn r 0x2b, 0, 0x75, v8, v0, v4\n\t"
        // vsetvli zero, t0, e16, m1, ta, ma (AVL=16)
        "li t0, 16\n\t"
        ".word 0x0c82f057\n\t"
        // vse16.v v8, (C)
        "vse16.v v8, (%[C])\n\t"
        :
        : [A] "r"(A), [B] "r"(B), [C] "r"(C)
        : "memory", "t0");

    // Expected: 1.0 * 1.0 * 8 = 8.0 for each element
    // f16 8.0 = 0x4800
    printf("  C[0]=0x%04x C[15]=0x%04x (expect 0x4800 = 8.0)\n", C[0], C[15]);
    printf("  vfmadot: %s\n",
           (C[0] == 0x4800 && C[15] == 0x4800) ? "PASS" : "FAIL/UNSUPPORTED");
  }

  printf("\nDone.\n");
  return 0;
}
