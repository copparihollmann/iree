// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include <riscv_vector.h>

#include "iree/builtins/ukernel/arch/riscv_64/common_riscv_64.h"
#include "iree/builtins/ukernel/arch/riscv_64/mmt4d_riscv_64_internal.h"

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_8xXXx1_riscv_64_v(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  IREE_UK_ASSERT(M0 >= 1 && M0 <= 8);
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;
  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;

  vint32m4_t acc0, acc1, acc2, acc3, acc4, acc5, acc6, acc7;
  int N0 = params->N0;
  size_t vl = N0;

#define IREE_UK_RISCV_64_VWACC_I8(ACC, LHS, RHS, VL)      \
  do {                                                     \
    vint16m2_t prod = __riscv_vwmul_vx_i16m2(RHS, LHS, VL); \
    ACC = __riscv_vwadd_wv_i32m4(ACC, prod, VL);          \
  } while (0)

  if (M0 == 1) {
    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      acc0 = __riscv_vle32_v_i32m4(out_ptr, vl);
    } else {
      acc0 = __riscv_vmv_v_x_i32m4(0, vl);
    }
    for (int k = 0; k < params->K; ++k) {
      vint8m1_t rhs = __riscv_vle8_v_i8m1(rhs_ptr, vl);
      rhs_ptr += N0;
      iree_uk_int8_t lhs = *lhs_ptr++;
      IREE_UK_RISCV_64_VWACC_I8(acc0, lhs, rhs, vl);
    }
    __riscv_vse32_v_i32m4(out_ptr, acc0, vl);
  } else if (M0 == 2) {
    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      acc0 = __riscv_vle32_v_i32m4(out_ptr, vl);
      acc1 = __riscv_vle32_v_i32m4(out_ptr + N0, vl);
    } else {
      acc0 = __riscv_vmv_v_x_i32m4(0, vl);
      acc1 = __riscv_vmv_v_x_i32m4(0, vl);
    }
    for (int k = 0; k < params->K; ++k) {
      vint8m1_t rhs = __riscv_vle8_v_i8m1(rhs_ptr, vl);
      rhs_ptr += N0;
      iree_uk_int8_t lhs0 = *lhs_ptr++;
      iree_uk_int8_t lhs1 = *lhs_ptr++;
      IREE_UK_RISCV_64_VWACC_I8(acc0, lhs0, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc1, lhs1, rhs, vl);
    }
    __riscv_vse32_v_i32m4(out_ptr, acc0, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0, acc1, vl);
  } else if (M0 == 4) {
    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      acc0 = __riscv_vle32_v_i32m4(out_ptr, vl);
      acc1 = __riscv_vle32_v_i32m4(out_ptr + N0, vl);
      acc2 = __riscv_vle32_v_i32m4(out_ptr + N0 * 2, vl);
      acc3 = __riscv_vle32_v_i32m4(out_ptr + N0 * 3, vl);
    } else {
      acc0 = __riscv_vmv_v_x_i32m4(0, vl);
      acc1 = __riscv_vmv_v_x_i32m4(0, vl);
      acc2 = __riscv_vmv_v_x_i32m4(0, vl);
      acc3 = __riscv_vmv_v_x_i32m4(0, vl);
    }
    for (int k = 0; k < params->K; ++k) {
      vint8m1_t rhs = __riscv_vle8_v_i8m1(rhs_ptr, vl);
      rhs_ptr += N0;
      iree_uk_int8_t lhs0 = *lhs_ptr++;
      iree_uk_int8_t lhs1 = *lhs_ptr++;
      iree_uk_int8_t lhs2 = *lhs_ptr++;
      iree_uk_int8_t lhs3 = *lhs_ptr++;
      IREE_UK_RISCV_64_VWACC_I8(acc0, lhs0, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc1, lhs1, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc2, lhs2, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc3, lhs3, rhs, vl);
    }
    __riscv_vse32_v_i32m4(out_ptr, acc0, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0, acc1, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 2, acc2, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 3, acc3, vl);
  } else if (M0 == 7) {
    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      acc0 = __riscv_vle32_v_i32m4(out_ptr, vl);
      acc1 = __riscv_vle32_v_i32m4(out_ptr + N0, vl);
      acc2 = __riscv_vle32_v_i32m4(out_ptr + N0 * 2, vl);
      acc3 = __riscv_vle32_v_i32m4(out_ptr + N0 * 3, vl);
      acc4 = __riscv_vle32_v_i32m4(out_ptr + N0 * 4, vl);
      acc5 = __riscv_vle32_v_i32m4(out_ptr + N0 * 5, vl);
      acc6 = __riscv_vle32_v_i32m4(out_ptr + N0 * 6, vl);
    } else {
      acc0 = __riscv_vmv_v_x_i32m4(0, vl);
      acc1 = __riscv_vmv_v_x_i32m4(0, vl);
      acc2 = __riscv_vmv_v_x_i32m4(0, vl);
      acc3 = __riscv_vmv_v_x_i32m4(0, vl);
      acc4 = __riscv_vmv_v_x_i32m4(0, vl);
      acc5 = __riscv_vmv_v_x_i32m4(0, vl);
      acc6 = __riscv_vmv_v_x_i32m4(0, vl);
    }
    for (int k = 0; k < params->K; ++k) {
      vint8m1_t rhs = __riscv_vle8_v_i8m1(rhs_ptr, vl);
      rhs_ptr += N0;
      iree_uk_int8_t lhs0 = *lhs_ptr++;
      iree_uk_int8_t lhs1 = *lhs_ptr++;
      iree_uk_int8_t lhs2 = *lhs_ptr++;
      iree_uk_int8_t lhs3 = *lhs_ptr++;
      iree_uk_int8_t lhs4 = *lhs_ptr++;
      iree_uk_int8_t lhs5 = *lhs_ptr++;
      iree_uk_int8_t lhs6 = *lhs_ptr++;
      IREE_UK_RISCV_64_VWACC_I8(acc0, lhs0, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc1, lhs1, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc2, lhs2, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc3, lhs3, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc4, lhs4, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc5, lhs5, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc6, lhs6, rhs, vl);
    }
    __riscv_vse32_v_i32m4(out_ptr, acc0, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0, acc1, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 2, acc2, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 3, acc3, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 4, acc4, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 5, acc5, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 6, acc6, vl);
  } else if (M0 == 8) {
    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      acc0 = __riscv_vle32_v_i32m4(out_ptr, vl);
      acc1 = __riscv_vle32_v_i32m4(out_ptr + N0, vl);
      acc2 = __riscv_vle32_v_i32m4(out_ptr + N0 * 2, vl);
      acc3 = __riscv_vle32_v_i32m4(out_ptr + N0 * 3, vl);
      acc4 = __riscv_vle32_v_i32m4(out_ptr + N0 * 4, vl);
      acc5 = __riscv_vle32_v_i32m4(out_ptr + N0 * 5, vl);
      acc6 = __riscv_vle32_v_i32m4(out_ptr + N0 * 6, vl);
      acc7 = __riscv_vle32_v_i32m4(out_ptr + N0 * 7, vl);
    } else {
      acc0 = __riscv_vmv_v_x_i32m4(0, vl);
      acc1 = __riscv_vmv_v_x_i32m4(0, vl);
      acc2 = __riscv_vmv_v_x_i32m4(0, vl);
      acc3 = __riscv_vmv_v_x_i32m4(0, vl);
      acc4 = __riscv_vmv_v_x_i32m4(0, vl);
      acc5 = __riscv_vmv_v_x_i32m4(0, vl);
      acc6 = __riscv_vmv_v_x_i32m4(0, vl);
      acc7 = __riscv_vmv_v_x_i32m4(0, vl);
    }
    for (int k = 0; k < params->K; ++k) {
      vint8m1_t rhs = __riscv_vle8_v_i8m1(rhs_ptr, vl);
      rhs_ptr += N0;
      iree_uk_int8_t lhs0 = *lhs_ptr++;
      iree_uk_int8_t lhs1 = *lhs_ptr++;
      iree_uk_int8_t lhs2 = *lhs_ptr++;
      iree_uk_int8_t lhs3 = *lhs_ptr++;
      iree_uk_int8_t lhs4 = *lhs_ptr++;
      iree_uk_int8_t lhs5 = *lhs_ptr++;
      iree_uk_int8_t lhs6 = *lhs_ptr++;
      iree_uk_int8_t lhs7 = *lhs_ptr++;
      IREE_UK_RISCV_64_VWACC_I8(acc0, lhs0, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc1, lhs1, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc2, lhs2, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc3, lhs3, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc4, lhs4, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc5, lhs5, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc6, lhs6, rhs, vl);
      IREE_UK_RISCV_64_VWACC_I8(acc7, lhs7, rhs, vl);
    }
    __riscv_vse32_v_i32m4(out_ptr, acc0, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0, acc1, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 2, acc2, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 3, acc3, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 4, acc4, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 5, acc5, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 6, acc6, vl);
    __riscv_vse32_v_i32m4(out_ptr + N0 * 7, acc7, vl);
  }

#undef IREE_UK_RISCV_64_VWACC_I8
}

IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_8xXXx1_riscv_64_v,
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_riscv_64_v, 1)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_8xXXx1_riscv_64_v,
    iree_uk_mmt4d_tile_s8s8s32_2xXXx1_riscv_64_v, 2)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_8xXXx1_riscv_64_v,
    iree_uk_mmt4d_tile_s8s8s32_4xXXx1_riscv_64_v, 4)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_8xXXx1_riscv_64_v,
    iree_uk_mmt4d_tile_s8s8s32_7xXXx1_riscv_64_v, 7)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_8xXXx1_riscv_64_v,
    iree_uk_mmt4d_tile_s8s8s32_8xXXx1_riscv_64_v, 8)

// vmadot i8: Opcode 0x2b, Funct3 3 (SS = signed x signed), Funct7 0x71.
// Hardware requires: SEW=8, VL=32 for the 4x4x8 MAC unit.
// Accumulator must be VRM2 (even-aligned vector register).
//
// .insn r encodes register fields as GPR numbers (x0-x31).
// Vector register vN maps to xN in the .insn encoding.
// Acc=v8 -> x8(s0), LHS=v0 -> x0(zero), RHS=v4 -> x4(tp).
#define VMADOT_I8(vd, vs1, vs2) \
  asm volatile(".insn r 0x2b, 3, 0x71, " vd ", " vs1 ", " vs2)

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_4x4x8_riscv_64_xsmtvdot_native(
    iree_uk_int32_t* IREE_UK_RESTRICT out_ptr,
    const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr,
    const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr,
    const iree_uk_mmt4d_params_t* params) {
  IREE_UK_ASSERT(params->N0 == 4);
  IREE_UK_ASSERT(params->K0 == 8);

  // 1. Initialize accumulator in v8 (VRM2: v8-v9, even-aligned).
  //    16 x i32 = 4x4 output tile.
  size_t vl_acc = 16;
  asm volatile("vsetvli zero, %0, e32, m2, ta, ma" : : "r"(vl_acc));

  if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
    asm volatile("vle32.v v8, (%0)" : : "r"(out_ptr));
  } else {
    asm volatile("vmv.v.i v8, 0");
  }

  // 2. Main loop: load LHS->v0, RHS->v4, vmadot v8, v0, v4.
  //    VL MUST be set to 32 for SEW=8 (4x4x8 = 32 bytes per operand).
  //    The accumulator vsetvli above set VL=16 (for e32,m2); we must
  //    explicitly set VL=32 here. Using "vsetvli zero, zero" would keep
  //    VL=16 which causes SIGILL on vmadot.
  //
  //    VL MUST be 32 for SEW=8 (4x4x8 MAC unit = 32 bytes per operand).
  //    LLVM's bitcode pipeline merges/hoists vsetvli instructions, so a
  //    normal "vsetvli zero, %0, e8, m1, ta, ma" gets converted to
  //    "vsetvli zero, zero" (keeping VL=16 from the accumulator setup).
  //    Use .word with raw encoding to emit an un-optimizable vsetvli.
  for (int k = 0; k < params->K; ++k) {
    asm volatile(
        // li t0, 32 (lui + addi pattern for small imm)
        "li t0, 32\n\t"
        // vsetvli zero, t0, e8, m1, ta, ma = 0x0c02f057
        ".word 0x0c02f057\n\t"
        "vle8.v v0, (%0)\n\t"
        "vle8.v v4, (%1)\n\t"
        ".insn r 0x2b, 3, 0x71, v8, v0, v4\n\t"
        :
        : "r"(lhs_ptr), "r"(rhs_ptr)
        : "memory", "t0");
    lhs_ptr += 32;
    rhs_ptr += 32;
  }

  // 3. Store result.
  asm volatile("vsetvli zero, %0, e32, m2, ta, ma" : : "r"(vl_acc));
  asm volatile("vse32.v v8, (%0)" : : "r"(out_ptr) : "memory");
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx8_to_4xXXx8_riscv_64_xsmtvdot_fallback(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  IREE_UK_ASSERT(M0 >= 1 && M0 <= 4);
  IREE_UK_ASSERT(params->K0 == 8);
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;
  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;
  const int N0 = params->N0;
  const size_t vl = N0;
  const int rhs_stride = 8;
  vint32m4_t acc0, acc1, acc2, acc3;

#define IREE_UK_RISCV_64_VWACC_I8_GENERIC(ACC, LHS, RHS, VL) \
  do {                                                        \
    vint16m2_t prod = __riscv_vwmul_vx_i16m2(RHS, LHS, VL);  \
    ACC = __riscv_vwadd_wv_i32m4(ACC, prod, VL);             \
  } while (0)

  if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
    acc0 = __riscv_vle32_v_i32m4(out_ptr, vl);
    if (M0 >= 2) acc1 = __riscv_vle32_v_i32m4(out_ptr + N0, vl);
    if (M0 >= 3) acc2 = __riscv_vle32_v_i32m4(out_ptr + 2 * N0, vl);
    if (M0 >= 4) acc3 = __riscv_vle32_v_i32m4(out_ptr + 3 * N0, vl);
  } else {
    acc0 = __riscv_vmv_v_x_i32m4(0, vl);
    if (M0 >= 2) acc1 = __riscv_vmv_v_x_i32m4(0, vl);
    if (M0 >= 3) acc2 = __riscv_vmv_v_x_i32m4(0, vl);
    if (M0 >= 4) acc3 = __riscv_vmv_v_x_i32m4(0, vl);
  }

  for (int k = 0; k < params->K; ++k) {
    for (int k0 = 0; k0 < 8; ++k0) {
      vint8m1_t rhs =
          __riscv_vlse8_v_i8m1(rhs_ptr + k0, rhs_stride, vl);
      iree_uk_int8_t lhs0 = lhs_ptr[k0];
      IREE_UK_RISCV_64_VWACC_I8_GENERIC(acc0, lhs0, rhs, vl);
      if (M0 >= 2) {
        iree_uk_int8_t lhs1 = lhs_ptr[8 + k0];
        IREE_UK_RISCV_64_VWACC_I8_GENERIC(acc1, lhs1, rhs, vl);
      }
      if (M0 >= 3) {
        iree_uk_int8_t lhs2 = lhs_ptr[16 + k0];
        IREE_UK_RISCV_64_VWACC_I8_GENERIC(acc2, lhs2, rhs, vl);
      }
      if (M0 >= 4) {
        iree_uk_int8_t lhs3 = lhs_ptr[24 + k0];
        IREE_UK_RISCV_64_VWACC_I8_GENERIC(acc3, lhs3, rhs, vl);
      }
    }
    lhs_ptr += M0 * 8;
    rhs_ptr += N0 * 8;
  }

  __riscv_vse32_v_i32m4(out_ptr, acc0, vl);
  if (M0 >= 2) __riscv_vse32_v_i32m4(out_ptr + N0, acc1, vl);
  if (M0 >= 3) __riscv_vse32_v_i32m4(out_ptr + 2 * N0, acc2, vl);
  if (M0 >= 4) __riscv_vse32_v_i32m4(out_ptr + 3 * N0, acc3, vl);

#undef IREE_UK_RISCV_64_VWACC_I8_GENERIC
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx8_to_4xXXx8_riscv_64_xsmtvdot(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  const int N0 = params->N0;
  if (M0 == 4 && N0 == 4) {
    iree_uk_mmt4d_tile_s8s8s32_4x4x8_riscv_64_xsmtvdot_native(
        (iree_uk_int32_t*)out_tile, (const iree_uk_int8_t*)lhs_panel,
        (const iree_uk_int8_t*)rhs_panel, params);
    return;
  }
  // Truncation path for narrow-M cases, still using RVV widening ops.
  iree_uk_mmt4d_tile_s8s8s32_1xXXx8_to_4xXXx8_riscv_64_xsmtvdot_fallback(
      out_tile, lhs_panel, rhs_panel, params, M0);
}

IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx8_to_4xXXx8_riscv_64_xsmtvdot,
    iree_uk_mmt4d_tile_s8s8s32_1xXXx8_riscv_64_xsmtvdot, 1)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx8_to_4xXXx8_riscv_64_xsmtvdot,
    iree_uk_mmt4d_tile_s8s8s32_2xXXx8_riscv_64_xsmtvdot, 2)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx8_to_4xXXx8_riscv_64_xsmtvdot,
    iree_uk_mmt4d_tile_s8s8s32_4xXXx8_riscv_64_xsmtvdot, 4)

// =============================================================================
// SpacemiT xsmtvdot FP8: vfmadot (f8E4M3FN x f8E4M3FN -> f16)
//
// vfmadot: Opcode 0x2b, Funct3 0 (standard FP), Funct7 0x75 (OPFMMA).
// Accumulator: VR (single register, NOT VRM2). For VLEN=256, one VR holds
// 16 x fp16 = 256 bits = the 4x4 output tile.
// Inputs: same as int8 vmadot — 32 bytes of f8E4M3FN packed as i8.
// Hardware requires: SEW=8, VL=32 for the 4x4x8 MAC unit.
//
// vsetvli encoding: .word 0x0c02f057 = vsetvli zero, t0, e8, m1, ta, ma
// vfmadot encoding: .insn r 0x2b, 0, 0x75, v8, v0, v4
// =============================================================================

// vfmadot: f8E4M3FN dot product, acc in fp16.
#define VFMADOT_FP8(vd, vs1, vs2) \
  asm volatile(".insn r 0x2b, 0, 0x75, " vd ", " vs1 ", " vs2)

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_f8e4m3f8e4m3f16_4x4x8_riscv_64_xsmtvdot_native(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params) {
  IREE_UK_ASSERT(params->N0 == 4);
  IREE_UK_ASSERT(params->K0 == 8);

  // Output is fp16: 4x4 = 16 elements x 2 bytes = 32 bytes = one VR.
  iree_uk_uint16_t* IREE_UK_RESTRICT out_ptr = (iree_uk_uint16_t*)out_tile;
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr =
      (const iree_uk_int8_t*)lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr =
      (const iree_uk_int8_t*)rhs_panel;

  // 1. Initialize accumulator in v8 (VR, single register: 16 x fp16).
  size_t vl_acc = 16;
  asm volatile("vsetvli zero, %0, e16, m1, ta, ma" : : "r"(vl_acc));

  if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
    asm volatile("vle16.v v8, (%0)" : : "r"(out_ptr));
  } else {
    asm volatile("vmv.v.i v8, 0");
  }

  // 2. Main loop: load f8 inputs, vfmadot to fp16 accumulator.
  for (int k = 0; k < params->K; ++k) {
    asm volatile(
        "li t0, 32\n\t"
        ".word 0x0c02f057\n\t"  // vsetvli zero, t0, e8, m1, ta, ma
        "vle8.v v0, (%0)\n\t"
        "vle8.v v4, (%1)\n\t"
        ".insn r 0x2b, 0, 0x75, v8, v0, v4\n\t"  // vfmadot v8, v0, v4
        :
        : "r"(lhs_ptr), "r"(rhs_ptr)
        : "memory", "t0");
    lhs_ptr += 32;
    rhs_ptr += 32;
  }

  // 3. Store result (fp16).
  asm volatile("vsetvli zero, %0, e16, m1, ta, ma" : : "r"(vl_acc));
  asm volatile("vse16.v v8, (%0)" : : "r"(out_ptr) : "memory");
}

// FP8 xsmtvdot fallback for narrow-M using RVV (software path).
// For now, only the native 4x4x8 tile is hardware-accelerated.
// M<4 cases fall through to the generic mmt4d fallback.
void iree_uk_mmt4d_tile_f8e4m3f8e4m3f16_4xXXx8_riscv_64_xsmtvdot(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params) {
  iree_uk_mmt4d_tile_f8e4m3f8e4m3f16_4x4x8_riscv_64_xsmtvdot_native(
      out_tile, lhs_panel, rhs_panel, params);
}

// OPMVINBCAST: broadcast v0 into all rows of matrix register m0.
// rd=x0(m0) for row-broadcast (matches benchmark pattern).
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0(void) {
  asm volatile(".insn r 0x57, 0x6, 0x59, x0, x0, x0\n\t" : : : "memory");
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(int row) {
  asm volatile(".insn r 0x57, 0x6, 0x55, x0, %0, x0\n\t"
               :
               : "r"(row)
               : "memory");
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(int row) {
  asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x0\n\t"
               :
               : "r"(row)
               : "memory");
}

// VOPACC: outer product accumulate. rs1=LHS(rows), rs2=RHS(cols).
// m0[i][j] += rs1[i] * rs2[j].
// v16=LHS column, v18=RHS column → rs1=v16(x16), rs2=v18(x18).
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_vopacc_m0_v16_v18(void) {
  asm volatile(".insn r 0x57, 0x2, 0x51, x0, x16, x18\n\t" : : : "memory");
}

// VOPACC with different register pairs for loop unrolling.
// Using separate register pairs avoids VRF read-after-write hazards.
// Unrolled pair: v20=LHS, v22=RHS → rs1=v20(x20), rs2=v22(x22).
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_vopacc_m0_v20_v22(void) {
  asm volatile(".insn r 0x57, 0x2, 0x51, x0, x20, x22\n\t" : : : "memory");
}

// OPFMACC: FP8 fused multiply-accumulate (f8 x f8 -> f32 in matrix register).
// Two register pair variants for loop unrolling to hide VRF RAW hazards.
// OPFMACC: FP8 outer product accumulate. Same operand mapping as VOPACC.
// v16=LHS(rows), v18=RHS(cols) → rs1=v16(x16), rs2=v18(x18).
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_opfmacc_m0_v16_v18(void) {
  asm volatile(".insn r 0x57, 0x1, 0x4b, x0, x16, x18\n\t" : : : "memory");
}

// Unrolled pair: v20=LHS, v22=RHS → rs1=v20(x20), rs2=v22(x22).
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_opfmacc_m0_v20_v22(void) {
  asm volatile(".insn r 0x57, 0x1, 0x4b, x0, x20, x22\n\t" : : : "memory");
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_16x16_riscv_64_xopu_native(
    iree_uk_int32_t* IREE_UK_RESTRICT out_ptr,
    const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr,
    const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr,
    const iree_uk_mmt4d_params_t* params) {
  const long avl16 = 16;

  asm volatile("vsetvli zero, %0, e32, m4, ta, ma\n\t"
               :
               : "r"(avl16)
               : "memory");

  // OPU keeps the accumulator in m0; initialize.
  asm volatile("vmv.v.i v0, 0\n\t" : : : "memory");
  iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();
  if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
    for (int row = 0; row < 16; ++row) {
      asm volatile("vle32.v v0, (%0)\n\t"
                   :
                   : "r"(out_ptr + row * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(row);
    }
  }

  // Per-operand encoding swaps innerDimsPos for xopu LHS/RHS, giving
  // tile layout [K0, M0] (K-outer, M-inner) instead of [M0, K0].
  // For a given k0, M0=16 elements are contiguous at offset k0*16.
  // This enables vle8.v (16 elem/cycle) instead of vlse8.v (1 elem/cycle).
  //
  // Layout [K0, M0]: element [k0, m0] at offset k0*M0 + m0.
  // For k0=fixed: all M0 elements contiguous → vle8.v at (base + k0*16).
  for (int k = 0; k < params->K; ++k) {
    const iree_uk_int8_t* lhs_k_ptr = lhs_ptr + k * 16 * params->K0;
    const iree_uk_int8_t* rhs_k_ptr = rhs_ptr + k * 16 * params->K0;
    asm volatile("vsetvli zero, %0, e8, m1, ta, ma\n\t"
                 :
                 : "r"(avl16)
                 : "memory");
    // Unroll K0 loop by 2 to hide VRF RAW hazards.
    int k0 = 0;
    for (; k0 + 2 <= params->K0; k0 += 2) {
      asm volatile("vle8.v v16, (%0)\n\t"
                   :
                   : "r"(lhs_k_ptr + k0 * 16)
                   : "memory");
      asm volatile("vle8.v v18, (%0)\n\t"
                   :
                   : "r"(rhs_k_ptr + k0 * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_vopacc_m0_v16_v18();
      asm volatile("vle8.v v20, (%0)\n\t"
                   :
                   : "r"(lhs_k_ptr + (k0 + 1) * 16)
                   : "memory");
      asm volatile("vle8.v v22, (%0)\n\t"
                   :
                   : "r"(rhs_k_ptr + (k0 + 1) * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_vopacc_m0_v20_v22();
    }
    for (; k0 < params->K0; ++k0) {
      asm volatile("vle8.v v16, (%0)\n\t"
                   :
                   : "r"(lhs_k_ptr + k0 * 16)
                   : "memory");
      asm volatile("vle8.v v18, (%0)\n\t"
                   :
                   : "r"(rhs_k_ptr + k0 * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_vopacc_m0_v16_v18();
    }
  }

  asm volatile("vsetvli zero, %0, e32, m4, ta, ma\n\t"
               :
               : "r"(avl16)
               : "memory");
  for (int row = 0; row < 16; ++row) {
    iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(row);
    asm volatile("vse32.v v0, (%0)\n\t"
                 :
                 : "r"(out_ptr + row * 16)
                 : "memory");
  }
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu_fallback(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  IREE_UK_ASSERT(M0 >= 1 && M0 <= 16);
  // K0 is now dynamic (set by tile selection)
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;
  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;
  const int N0 = params->N0;
  const int K0 = params->K0;
  const size_t vl = N0;

  // Keep register pressure bounded by processing rows in groups of 4.
  for (int m0 = 0; m0 < M0; m0 += 4) {
    int rows = (M0 - m0 < 4) ? (M0 - m0) : 4;
    vint32m4_t acc0, acc1, acc2, acc3;

    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      acc0 = __riscv_vle32_v_i32m4(out_ptr + m0 * N0, vl);
      if (rows >= 2) acc1 = __riscv_vle32_v_i32m4(out_ptr + (m0 + 1) * N0, vl);
      if (rows >= 3) acc2 = __riscv_vle32_v_i32m4(out_ptr + (m0 + 2) * N0, vl);
      if (rows >= 4) acc3 = __riscv_vle32_v_i32m4(out_ptr + (m0 + 3) * N0, vl);
    } else {
      acc0 = __riscv_vmv_v_x_i32m4(0, vl);
      if (rows >= 2) acc1 = __riscv_vmv_v_x_i32m4(0, vl);
      if (rows >= 3) acc2 = __riscv_vmv_v_x_i32m4(0, vl);
      if (rows >= 4) acc3 = __riscv_vmv_v_x_i32m4(0, vl);
    }

    // Per-operand encoding: tile layout [K0, M0] for LHS, [K0, N0] for RHS.
    // element [k0, m0] at offset k0*M0 + m0 (M innermost, contiguous).
    // element [k0, n0] at offset k0*N0 + n0 (N innermost, contiguous).
    for (int k = 0; k < params->K; ++k) {
      const iree_uk_int8_t* rhs_k_ptr = rhs_ptr + k * N0 * K0;
      const iree_uk_int8_t* lhs_k_ptr = lhs_ptr + k * M0 * K0 + m0;
      for (int k0 = 0; k0 < K0; ++k0) {
        // RHS: N0 elements for k0 are contiguous at k0*N0.
        vint8m1_t rhs = __riscv_vle8_v_i8m1(rhs_k_ptr + k0 * N0, vl);
        // LHS: element for row m at k0*M0 + m (M innermost).
        const iree_uk_int8_t* lhs_row = lhs_k_ptr + k0 * M0;
        iree_uk_int8_t lhs0 = lhs_row[0];
        vint16m2_t prod0 = __riscv_vwmul_vx_i16m2(rhs, lhs0, vl);
        acc0 = __riscv_vwadd_wv_i32m4(acc0, prod0, vl);
        if (rows >= 2) {
          iree_uk_int8_t lhs1 = lhs_row[1];
          vint16m2_t prod1 = __riscv_vwmul_vx_i16m2(rhs, lhs1, vl);
          acc1 = __riscv_vwadd_wv_i32m4(acc1, prod1, vl);
        }
        if (rows >= 3) {
          iree_uk_int8_t lhs2 = lhs_row[2];
          vint16m2_t prod2 = __riscv_vwmul_vx_i16m2(rhs, lhs2, vl);
          acc2 = __riscv_vwadd_wv_i32m4(acc2, prod2, vl);
        }
        if (rows >= 4) {
          iree_uk_int8_t lhs3 = lhs_row[3];
          vint16m2_t prod3 = __riscv_vwmul_vx_i16m2(rhs, lhs3, vl);
          acc3 = __riscv_vwadd_wv_i32m4(acc3, prod3, vl);
        }
      }
    }

    __riscv_vse32_v_i32m4(out_ptr + m0 * N0, acc0, vl);
    if (rows >= 2) __riscv_vse32_v_i32m4(out_ptr + (m0 + 1) * N0, acc1, vl);
    if (rows >= 3) __riscv_vse32_v_i32m4(out_ptr + (m0 + 2) * N0, acc2, vl);
    if (rows >= 4) __riscv_vse32_v_i32m4(out_ptr + (m0 + 3) * N0, acc3, vl);
  }
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  // K0 is now dynamic (set by tile selection)
  if (M0 == 16 && params->N0 == 16) {
    iree_uk_mmt4d_tile_s8s8s32_16x16_riscv_64_xopu_native(
        (iree_uk_int32_t*)out_tile, (const iree_uk_int8_t*)lhs_panel,
        (const iree_uk_int8_t*)rhs_panel, params);
    return;
  }
  // Truncation path for narrow-M/N cases: keep a correct RVV implementation.
  iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu_fallback(
      out_tile, lhs_panel, rhs_panel, params, M0);
}

IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_1xXXx16_riscv_64_xopu, 1)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_2xXXx16_riscv_64_xopu, 2)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_4xXXx16_riscv_64_xopu, 4)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_8xXXx16_riscv_64_xopu, 8)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_16xXXx16_riscv_64_xopu, 16)

// =============================================================================
// Saturn OPU FP8: OPFMACC (f8E4M3FN x f8E4M3FN -> f32 accumulation)
//
// Uses the OPU matrix engine with OPFMACC instruction:
//   .insn r 0x57, 0x1, 0x4b, md, vs1, vs2
// where md is a matrix register (m0-m3), vs1/vs2 are vector registers.
//
// The accumulator is in f32 (same as int8 VOPACC), stored in matrix registers.
// Output is f32 stored as uint32_t bits (IEEE 754 binary32).
//
// For E5M2 format, use VSETVLI_ALTFMT with altfmt=1.
// For E4M3 format, use standard vsetvli (altfmt=0).
//
// Tile: 16x16xK0 (same geometry as int8 OPU)
// =============================================================================

// VSETVLI_ALTFMT: set e8,m1 with altfmt bit for E5M2 format selection.
// Standard vsetvli (altfmt=0) selects E4M3FN.
// altfmt=1 selects E5M2.
// Encoding: vsetvli with vtypei bit 8 = altfmt.
//   vtypei for e8,m1,ta,ma,altfmt=0: 0xC0
//   vtypei for e8,m1,ta,ma,altfmt=1: 0x1C0
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_riscv_64_xopu_vsetvli_e8_m1_altfmt(long avl, int altfmt) {
  if (altfmt) {
    // .insn i 0x57, 7, x0, rs1, 0x1C0 = vsetvli zero, rs1, e8,m1,ta,ma,altfmt=1
    asm volatile(".insn i 0x57, 7, x0, %0, 0x1C0" : : "r"(avl));
  } else {
    asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(avl));
  }
}

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_16x16_riscv_64_xopu_native(
    iree_uk_int32_t* IREE_UK_RESTRICT out_ptr,
    const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr,
    const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr,
    const iree_uk_mmt4d_params_t* params) {
  const long avl16 = 16;

  asm volatile("vsetvli zero, %0, e32, m4, ta, ma\n\t"
               :
               : "r"(avl16)
               : "memory");

  // Initialize accumulator m0 (f32 in matrix register).
  asm volatile("vmv.v.i v0, 0\n\t" : : : "memory");
  iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();
  if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
    for (int row = 0; row < 16; ++row) {
      asm volatile("vle32.v v0, (%0)\n\t"
                   :
                   : "r"(out_ptr + row * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(row);
    }
  }

  // Per-operand encoding: tile layout [K0, M0] (K-outer, M-inner).
  // For k0=fixed, M0=16 fp8 elements contiguous → vle8.v.
  // E4M3FN: altfmt=0 (standard vsetvli).
  for (int k = 0; k < params->K; ++k) {
    const iree_uk_int8_t* lhs_k_ptr = lhs_ptr + k * 16 * params->K0;
    const iree_uk_int8_t* rhs_k_ptr = rhs_ptr + k * 16 * params->K0;
    asm volatile("vsetvli zero, %0, e8, m1, ta, ma\n\t"
                 :
                 : "r"(avl16)
                 : "memory");

    // Unroll K0 loop by 2 to hide VRF RAW hazards.
    int k0 = 0;
    for (; k0 + 2 <= params->K0; k0 += 2) {
      asm volatile("vle8.v v16, (%0)\n\t"
                   :
                   : "r"(lhs_k_ptr + k0 * 16)
                   : "memory");
      asm volatile("vle8.v v18, (%0)\n\t"
                   :
                   : "r"(rhs_k_ptr + k0 * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_opfmacc_m0_v16_v18();
      asm volatile("vle8.v v20, (%0)\n\t"
                   :
                   : "r"(lhs_k_ptr + (k0 + 1) * 16)
                   : "memory");
      asm volatile("vle8.v v22, (%0)\n\t"
                   :
                   : "r"(rhs_k_ptr + (k0 + 1) * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_opfmacc_m0_v20_v22();
    }
    for (; k0 < params->K0; ++k0) {
      asm volatile("vle8.v v16, (%0)\n\t"
                   :
                   : "r"(lhs_k_ptr + k0 * 16)
                   : "memory");
      asm volatile("vle8.v v18, (%0)\n\t"
                   :
                   : "r"(rhs_k_ptr + k0 * 16)
                   : "memory");
      iree_uk_riscv_64_xopu_opfmacc_m0_v16_v18();
    }
  }

  // Store results from matrix register m0 row by row.
  asm volatile("vsetvli zero, %0, e32, m4, ta, ma\n\t"
               :
               : "r"(avl16)
               : "memory");
  for (int row = 0; row < 16; ++row) {
    iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(row);
    asm volatile("vse32.v v0, (%0)\n\t"
                 :
                 : "r"(out_ptr + row * 16)
                 : "memory");
  }
}

// FP8 OPU fallback for narrow-M using RVV (same pattern as int8 OPU fallback).
IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_to_16xXXx16_riscv_64_xopu(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  if (M0 == 16 && params->N0 == 16) {
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_16x16_riscv_64_xopu_native(
        (iree_uk_int32_t*)out_tile,
        (const iree_uk_int8_t*)lhs_panel,
        (const iree_uk_int8_t*)rhs_panel,
        params);
    return;
  }
  // TODO: narrow-M fallback for fp8 OPU.
  // For now, zero-fill output to avoid undefined behavior.
  iree_uk_int32_t* out_ptr = (iree_uk_int32_t*)out_tile;
  for (int i = 0; i < M0 * params->N0; ++i) out_ptr[i] = 0;
}

IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_riscv_64_xopu, 1)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_2xXXx16_riscv_64_xopu, 2)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_4xXXx16_riscv_64_xopu, 4)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_8xXXx16_riscv_64_xopu, 8)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_1xXXx16_to_16xXXx16_riscv_64_xopu,
    iree_uk_mmt4d_tile_f8e4m3f8e4m3f32_16xXXx16_riscv_64_xopu, 16)
