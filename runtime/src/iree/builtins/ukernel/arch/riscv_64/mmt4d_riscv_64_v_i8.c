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

// =============================================================================
// Saturn OPU int8 K0=1 path: uses VOPACC outer-product instructions.
//
// With K0=1 the compiler uses the standard RVV tile pipeline (no special
// packing). params->K equals the full reduction dimension. The OPU
// advantage comes entirely from using VOPACC instead of vwmul+vwadd.
// =============================================================================

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_16xXXx1_riscv_64_xopu(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  IREE_UK_ASSERT(M0 >= 1 && M0 <= 16);
  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;

  const int N0 = params->N0;
  const int K = params->K;
  const int HW_WIDTH = 16;

  for (int n_start = 0; n_start < N0; n_start += HW_WIDTH) {
    int n_rem = N0 - n_start;
    size_t vl = (n_rem < HW_WIDTH) ? n_rem : HW_WIDTH;
    size_t ml = M0;

    const iree_uk_int8_t* sub_rhs = rhs_ptr + n_start;
    iree_uk_int32_t* sub_out = out_ptr + n_start;

    // --- PATH A: High Performance (M0=16) ---
    if (M0 == 16) {
      asm volatile("vsetvli zero, %0, e32, m8, ta, ma" : : "r"(vl));
      asm volatile("vmv.v.i v0, 0" : : : "memory");
      iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();

      if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
        for (int row = 0; row < 16; ++row) {
          asm volatile("vle32.v v0, (%0)" : : "r"(&sub_out[row * N0]) : "memory");
          iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(row);
        }
      }

      // K loop: single asm block per iteration to prevent compiler from
      // inserting redundant vsetvli. Unrolled by 4 for reduced loop overhead
      // and better load/compute overlap.
      const iree_uk_int8_t* lhs_k = lhs_ptr;
      const iree_uk_int8_t* rhs_k = sub_rhs;
      size_t k = 0;
      asm volatile("vsetvli zero, %0, e8, m2, ta, ma" : : "r"(ml));
      for (; k + 4 <= (size_t)K; k += 4) {
        asm volatile(
            "vle8.v v16, (%0)\n\t"
            "vle8.v v18, (%1)\n\t"
            ".insn r 0x57, 0x2, 0x51, x0, x18, x16\n\t"
            "vle8.v v20, (%2)\n\t"
            "vle8.v v22, (%3)\n\t"
            ".insn r 0x57, 0x2, 0x51, x0, x22, x20\n\t"
            "vle8.v v24, (%4)\n\t"
            "vle8.v v26, (%5)\n\t"
            ".insn r 0x57, 0x2, 0x51, x0, x26, x24\n\t"
            "vle8.v v28, (%6)\n\t"
            "vle8.v v30, (%7)\n\t"
            ".insn r 0x57, 0x2, 0x51, x0, x30, x28\n\t"
            :
            : "r"(lhs_k), "r"(rhs_k),
              "r"(lhs_k + M0), "r"(rhs_k + N0),
              "r"(lhs_k + 2 * M0), "r"(rhs_k + 2 * N0),
              "r"(lhs_k + 3 * M0), "r"(rhs_k + 3 * N0)
            : "memory");
        lhs_k += 4 * M0;
        rhs_k += 4 * N0;
      }
      // Handle remaining 1-3 iterations
      for (; k < (size_t)K; ++k) {
        asm volatile(
            "vle8.v v16, (%0)\n\t"
            "vle8.v v18, (%1)\n\t"
            ".insn r 0x57, 0x2, 0x51, x0, x18, x16\n\t"
            :
            : "r"(lhs_k), "r"(rhs_k)
            : "memory");
        lhs_k += M0;
        rhs_k += N0;
      }

      asm volatile("vsetvli zero, %0, e32, m8, ta, ma" : : "r"(vl));
      for (size_t r = 0; r < ml; r++) {
        iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(r);
        asm volatile("vse32.v v0, (%0)" : : "r"(&sub_out[r * N0]) : "memory");
      }
    }
    // --- PATH B: Tail Case (M0 <= 8) ---
    else {
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl));
      asm volatile("vmv.v.i v0, 0" : : : "memory");
      iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();

      if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
        for (size_t row = 0; row < ml; ++row) {
          asm volatile("vle32.v v0, (%0)" : : "r"(&sub_out[row * N0]) : "memory");
          iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(row);
        }
      }

      for (int k = 0; k < K; ++k) {
        asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(ml));
        asm volatile("vle8.v v4, (%0)" : : "r"(&lhs_ptr[k * M0]) : "memory");
        asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(vl));
        asm volatile("vle8.v v5, (%0)" : : "r"(&sub_rhs[k * N0]) : "memory");
        asm volatile(".insn r 0x57, 0x2, 0x51, x0, x5, x4" : : : "memory");
      }

      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl));
      for (size_t r = 0; r < ml; r++) {
        iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(r);
        asm volatile("vse32.v v0, (%0)" : : "r"(&sub_out[r * N0]) : "memory");
      }
    }
  }
}

IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_16xXXx1_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_riscv_64_xopu, 1)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_16xXXx1_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_2xXXx1_riscv_64_xopu, 2)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_16xXXx1_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_4xXXx1_riscv_64_xopu, 4)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_16xXXx1_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_8xXXx1_riscv_64_xopu, 8)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx1_to_16xXXx1_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_16xXXx1_riscv_64_xopu, 16)

// =============================================================================
// Saturn OPU int8 K0=1, M0=32: 2x2 output tiling using all 4 matrix registers.
//
// Processes a 32x32 output tile as four 16x16 sub-tiles:
//   m0: sub-tile (0,0)  m1: sub-tile (0,1)
//   m2: sub-tile (1,0)  m3: sub-tile (1,1)
//
// Per K iteration: 2 A-loads + 2 B-loads → 4 VOPACCs (1.0 loads/VOPACC).
// This is 2x better than the M0=16 path (2.0 loads/VOPACC).
// =============================================================================

void iree_uk_mmt4d_tile_s8s8s32_32xXXx1_riscv_64_xopu(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params) {
  const int M0 = 32;
  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;

  const int N0 = params->N0;
  const int K = params->K;
  const int HW = 16;  // OPU hardware width

  // Process N0 in chunks of 2*HW (32), each chunk uses m0+m1 (or m2+m3)
  for (int n_start = 0; n_start < N0; n_start += 2 * HW) {
    int n_chunk = (N0 - n_start < 2 * HW) ? (N0 - n_start) : (2 * HW);
    int vl0 = (n_chunk < HW) ? n_chunk : HW;
    int vl1 = (n_chunk > HW) ? (n_chunk - HW) : 0;

    const iree_uk_int8_t* rhs0 = rhs_ptr + n_start;
    const iree_uk_int8_t* rhs1 = rhs_ptr + n_start + HW;
    iree_uk_int32_t* out0 = out_ptr + n_start;

    // --- Init all 4 accumulators ---
    // m0 = sub-tile(row0, col0), m1 = sub-tile(row0, col1)
    // m2 = sub-tile(row1, col0), m3 = sub-tile(row1, col1)
    asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl0));
    asm volatile("vmv.v.i v0, 0" : : : "memory");
    iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();
    // m1
    asm volatile(".insn r 0x57, 0x6, 0x59, x1, x0, x0" : : : "memory");
    // m2
    asm volatile(".insn r 0x57, 0x6, 0x59, x2, x0, x0" : : : "memory");
    // m3
    asm volatile(".insn r 0x57, 0x6, 0x59, x3, x0, x0" : : : "memory");

    if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
      // Load existing accumulators for all 4 sub-tiles
      for (int r = 0; r < HW; ++r) {
        // m0: rows 0..15, cols 0..15
        asm volatile("vle32.v v0, (%0)" : : "r"(&out0[r * N0]) : "memory");
        iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(r);
        // m2: rows 16..31, cols 0..15
        asm volatile("vle32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0]) : "memory");
        asm volatile(".insn r 0x57, 0x6, 0x55, x2, %0, x0" : : "r"(r) : "memory");
      }
      if (vl1 > 0) {
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl1));
        for (int r = 0; r < HW; ++r) {
          // m1: rows 0..15, cols 16..31
          asm volatile("vle32.v v0, (%0)" : : "r"(&out0[r * N0 + HW]) : "memory");
          asm volatile(".insn r 0x57, 0x6, 0x55, x1, %0, x0" : : "r"(r) : "memory");
          // m3: rows 16..31, cols 16..31
          asm volatile("vle32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0 + HW]) : "memory");
          asm volatile(".insn r 0x57, 0x6, 0x55, x3, %0, x0" : : "r"(r) : "memory");
        }
      }
    }

    // --- K loop: 2x2 tiling, 4 VOPACCs per 4 loads ---
    const iree_uk_int8_t* lhs_k = lhs_ptr;
    const iree_uk_int8_t* rhs0_k = rhs0;
    const iree_uk_int8_t* rhs1_k = rhs1;

    asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(HW));

    for (int k = 0; k < K; ++k) {
      // Load A row 0 (M elements 0..15)
      // Load B col 0
      // VOPACC m0 (sub-tile 0,0)
      // Load B col 1
      // VOPACC m1 (sub-tile 0,1) — reuse A row 0
      // Load A row 1 (M elements 16..31)
      // VOPACC m2 (sub-tile 1,0) — reuse B col 0
      // VOPACC m3 (sub-tile 1,1) — reuse B col 1
      asm volatile(
          "vle8.v v16, (%0)\n\t"   // A row 0
          "vle8.v v17, (%1)\n\t"   // B col 0
          ".insn r 0x57, 0x2, 0x51, x0, x17, x16\n\t"  // VOPACC m0
          "vle8.v v18, (%2)\n\t"   // B col 1
          ".insn r 0x57, 0x2, 0x51, x1, x18, x16\n\t"  // VOPACC m1
          "vle8.v v19, (%3)\n\t"   // A row 1
          ".insn r 0x57, 0x2, 0x51, x2, x17, x19\n\t"  // VOPACC m2 (reuse B col 0)
          ".insn r 0x57, 0x2, 0x51, x3, x18, x19\n\t"  // VOPACC m3 (reuse B col 1)
          :
          : "r"(lhs_k), "r"(rhs0_k),
            "r"(rhs1_k), "r"(lhs_k + HW)
          : "memory");

      lhs_k += M0;  // advance by 32 (full M0 stride)
      rhs0_k += N0;
      rhs1_k += N0;
    }

    // --- Store all 4 sub-tiles ---
    asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl0));

    // m0: rows 0..15, cols 0..vl0
    for (int r = 0; r < HW; ++r) {
      iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(r);
      asm volatile("vse32.v v0, (%0)" : : "r"(&out0[r * N0]) : "memory");
    }
    // m2: rows 16..31, cols 0..vl0
    for (int r = 0; r < HW; ++r) {
      asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x2" : : "r"(r) : "memory");
      asm volatile("vse32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0]) : "memory");
    }

    if (vl1 > 0) {
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl1));
      // m1: rows 0..15, cols HW..HW+vl1
      for (int r = 0; r < HW; ++r) {
        asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x1" : : "r"(r) : "memory");
        asm volatile("vse32.v v0, (%0)" : : "r"(&out0[r * N0 + HW]) : "memory");
      }
      // m3: rows 16..31, cols HW..HW+vl1
      for (int r = 0; r < HW; ++r) {
        asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x3" : : "r"(r) : "memory");
        asm volatile("vse32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0 + HW]) : "memory");
      }
    }
  }
}

// M0=32 tile function is registered directly via tiles.inl.

// =============================================================================
// Saturn OPU int8 K0=1, M0=64: processes 64x64 output tiles in 4 passes
// of 32x32 sub-blocks, each using the 2x2 tiling with m0-m3.
// =============================================================================

void iree_uk_mmt4d_tile_s8s8s32_64xXXx1_riscv_64_xopu(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params) {
  const int M0 = 64;
  const int N0 = params->N0;
  const int K = params->K;
  const int HW = 16;
  const int BLK = 2 * HW;  // 32: size of each 2x2 sub-block

  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;

  // Process 64x64 in 4 passes of 32x32 sub-blocks
  for (int m_blk = 0; m_blk < M0; m_blk += BLK) {
    for (int n_blk = 0; n_blk < N0; n_blk += BLK) {
      int n_chunk = (N0 - n_blk < BLK) ? (N0 - n_blk) : BLK;
      int vl0 = (n_chunk < HW) ? n_chunk : HW;
      int vl1 = (n_chunk > HW) ? (n_chunk - HW) : 0;

      const iree_uk_int8_t* rhs0 = rhs_ptr + n_blk;
      const iree_uk_int8_t* rhs1 = rhs_ptr + n_blk + HW;
      iree_uk_int32_t* out0 = out_ptr + m_blk * N0 + n_blk;

      // Init all 4 accumulators to zero
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl0));
      asm volatile("vmv.v.i v0, 0" : : : "memory");
      // m0, m1, m2, m3
      asm volatile(".insn r 0x57, 0x6, 0x59, x0, x0, x0" : : : "memory");
      asm volatile(".insn r 0x57, 0x6, 0x59, x1, x0, x0" : : : "memory");
      asm volatile(".insn r 0x57, 0x6, 0x59, x2, x0, x0" : : : "memory");
      asm volatile(".insn r 0x57, 0x6, 0x59, x3, x0, x0" : : : "memory");

      if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
        for (int r = 0; r < HW; ++r) {
          asm volatile("vle32.v v0, (%0)" : : "r"(&out0[r * N0]) : "memory");
          asm volatile(".insn r 0x57, 0x6, 0x55, x0, %0, x0" : : "r"(r) : "memory");
          asm volatile("vle32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0]) : "memory");
          asm volatile(".insn r 0x57, 0x6, 0x55, x2, %0, x0" : : "r"(r) : "memory");
        }
        if (vl1 > 0) {
          asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl1));
          for (int r = 0; r < HW; ++r) {
            asm volatile("vle32.v v0, (%0)" : : "r"(&out0[r * N0 + HW]) : "memory");
            asm volatile(".insn r 0x57, 0x6, 0x55, x1, %0, x0" : : "r"(r) : "memory");
            asm volatile("vle32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0 + HW]) : "memory");
            asm volatile(".insn r 0x57, 0x6, 0x55, x3, %0, x0" : : "r"(r) : "memory");
          }
        }
      }

      // K loop: 2x2 tiling with A-load reuse
      const iree_uk_int8_t* lhs_k = lhs_ptr + m_blk;
      const iree_uk_int8_t* rhs0_k = rhs0;
      const iree_uk_int8_t* rhs1_k = rhs1;

      asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(HW));

      for (int k = 0; k < K; ++k) {
        asm volatile(
            "vle8.v v16, (%0)\n\t"   // A row 0 (m_blk..m_blk+15)
            "vle8.v v17, (%1)\n\t"   // B col 0 (n_blk..n_blk+15)
            ".insn r 0x57, 0x2, 0x51, x0, x17, x16\n\t"  // m0
            "vle8.v v18, (%2)\n\t"   // B col 1 (n_blk+16..n_blk+31)
            ".insn r 0x57, 0x2, 0x51, x1, x18, x16\n\t"  // m1
            "vle8.v v19, (%3)\n\t"   // A row 1 (m_blk+16..m_blk+31)
            ".insn r 0x57, 0x2, 0x51, x2, x17, x19\n\t"  // m2
            ".insn r 0x57, 0x2, 0x51, x3, x18, x19\n\t"  // m3
            :
            : "r"(lhs_k), "r"(rhs0_k),
              "r"(rhs1_k), "r"(lhs_k + HW)
            : "memory");

        lhs_k += M0;   // stride by full M0=64
        rhs0_k += N0;
        rhs1_k += N0;
      }

      // Store all 4 sub-tiles
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl0));
      for (int r = 0; r < HW; ++r) {
        asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x0" : : "r"(r) : "memory");
        asm volatile("vse32.v v0, (%0)" : : "r"(&out0[r * N0]) : "memory");
      }
      for (int r = 0; r < HW; ++r) {
        asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x2" : : "r"(r) : "memory");
        asm volatile("vse32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0]) : "memory");
      }
      if (vl1 > 0) {
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl1));
        for (int r = 0; r < HW; ++r) {
          asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x1" : : "r"(r) : "memory");
          asm volatile("vse32.v v0, (%0)" : : "r"(&out0[r * N0 + HW]) : "memory");
        }
        for (int r = 0; r < HW; ++r) {
          asm volatile(".insn r 0x57, 0x6, 0x5d, x0, %0, x3" : : "r"(r) : "memory");
          asm volatile("vse32.v v0, (%0)" : : "r"(&out0[(r + HW) * N0 + HW]) : "memory");
        }
      }
    }
  }
}

// =============================================================================
// Saturn OPU int8 K0=128 path with encoding swap.
//
// With the encoding swap, each K1 tile has layout [K0=128, M0=16] for LHS
// and [K0=128, N0=16] for RHS. M0/N0 are innermost (contiguous), so
// vle8.v loads 16 elements per K0 step — no strided loads needed.
// The pack becomes a contiguous memcpy instead of strided gather.
// =============================================================================

IREE_UK_ATTRIBUTE_ALWAYS_INLINE static inline void
iree_uk_mmt4d_tile_s8s8s32_1xXXx128_to_16xXXx128_riscv_64_xopu(
    void* IREE_UK_RESTRICT out_tile, const void* IREE_UK_RESTRICT lhs_panel,
    const void* IREE_UK_RESTRICT rhs_panel,
    const iree_uk_mmt4d_params_t* params, int M0) {
  IREE_UK_ASSERT(M0 >= 1 && M0 <= 16);
  IREE_UK_ASSERT(params->K0 == 128);
  iree_uk_int32_t* IREE_UK_RESTRICT out_ptr = out_tile;
  const iree_uk_int8_t* IREE_UK_RESTRICT lhs_ptr = lhs_panel;
  const iree_uk_int8_t* IREE_UK_RESTRICT rhs_ptr = rhs_panel;

  const int N0 = params->N0;
  const int K0 = 128;
  const int HW_WIDTH = 16;

  for (int n_start = 0; n_start < N0; n_start += HW_WIDTH) {
    int n_rem = N0 - n_start;
    size_t vl = (n_rem < HW_WIDTH) ? n_rem : HW_WIDTH;
    size_t ml = M0;

    const iree_uk_int8_t* sub_rhs = rhs_ptr + n_start * K0;
    iree_uk_int32_t* sub_out = out_ptr + n_start;

    if (M0 == 16) {
      // Init accumulator
      asm volatile("vsetvli zero, %0, e32, m8, ta, ma" : : "r"(vl));
      asm volatile("vmv.v.i v0, 0" : : : "memory");
      iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();

      if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
        for (int row = 0; row < 16; ++row) {
          asm volatile("vle32.v v0, (%0)" : : "r"(&sub_out[row * N0]) : "memory");
          iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(row);
        }
      }

      // K loop: iterate over K1 tiles, each with K0=128 inner steps.
      // With encoding swap: LHS layout is [K0, M0] = M0 contiguous per K0 step.
      asm volatile("vsetvli zero, %0, e8, m2, ta, ma" : : "r"(ml));
      for (int k1 = 0; k1 < params->K; ++k1) {
        const iree_uk_int8_t* lhs_k = lhs_ptr + k1 * M0 * K0;
        const iree_uk_int8_t* rhs_k = sub_rhs + k1 * N0 * K0;

        // Inner K0=128 loop, 4x unrolled
        int k0 = 0;
        for (; k0 + 4 <= K0; k0 += 4) {
          asm volatile(
              "vle8.v v16, (%0)\n\t"
              "vle8.v v18, (%1)\n\t"
              ".insn r 0x57, 0x2, 0x51, x0, x18, x16\n\t"
              "vle8.v v20, (%2)\n\t"
              "vle8.v v22, (%3)\n\t"
              ".insn r 0x57, 0x2, 0x51, x0, x22, x20\n\t"
              "vle8.v v24, (%4)\n\t"
              "vle8.v v26, (%5)\n\t"
              ".insn r 0x57, 0x2, 0x51, x0, x26, x24\n\t"
              "vle8.v v28, (%6)\n\t"
              "vle8.v v30, (%7)\n\t"
              ".insn r 0x57, 0x2, 0x51, x0, x30, x28\n\t"
              :
              : "r"(lhs_k + k0 * M0), "r"(rhs_k + k0 * N0),
                "r"(lhs_k + (k0 + 1) * M0), "r"(rhs_k + (k0 + 1) * N0),
                "r"(lhs_k + (k0 + 2) * M0), "r"(rhs_k + (k0 + 2) * N0),
                "r"(lhs_k + (k0 + 3) * M0), "r"(rhs_k + (k0 + 3) * N0)
              : "memory");
        }
        for (; k0 < K0; ++k0) {
          asm volatile(
              "vle8.v v16, (%0)\n\t"
              "vle8.v v18, (%1)\n\t"
              ".insn r 0x57, 0x2, 0x51, x0, x18, x16\n\t"
              :
              : "r"(lhs_k + k0 * M0), "r"(rhs_k + k0 * N0)
              : "memory");
        }
      }

      // Store results
      asm volatile("vsetvli zero, %0, e32, m8, ta, ma" : : "r"(vl));
      for (size_t r = 0; r < ml; r++) {
        iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(r);
        asm volatile("vse32.v v0, (%0)" : : "r"(&sub_out[r * N0]) : "memory");
      }
    } else {
      // Tail case (M0 <= 8): use smaller LMUL
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl));
      asm volatile("vmv.v.i v0, 0" : : : "memory");
      iree_uk_riscv_64_xopu_opmvinbcast_m0_from_v0();

      if (params->flags & IREE_UK_FLAG_MMT4D_ACCUMULATE) {
        for (size_t row = 0; row < ml; ++row) {
          asm volatile("vle32.v v0, (%0)" : : "r"(&sub_out[row * N0]) : "memory");
          iree_uk_riscv_64_xopu_vmv_rv_m0_from_v0(row);
        }
      }

      asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(ml));
      for (int k1 = 0; k1 < params->K; ++k1) {
        const iree_uk_int8_t* lhs_k = lhs_ptr + k1 * M0 * K0;
        const iree_uk_int8_t* rhs_k = sub_rhs + k1 * N0 * K0;
        for (int k0 = 0; k0 < K0; ++k0) {
          asm volatile(
              "vle8.v v4, (%0)\n\t"
              "vle8.v v5, (%1)\n\t"
              ".insn r 0x57, 0x2, 0x51, x0, x5, x4\n\t"
              :
              : "r"(lhs_k + k0 * M0), "r"(rhs_k + k0 * N0)
              : "memory");
        }
      }

      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(vl));
      for (size_t r = 0; r < ml; r++) {
        iree_uk_riscv_64_xopu_vmv_vr_v0_from_m0(r);
        asm volatile("vse32.v v0, (%0)" : : "r"(&sub_out[r * N0]) : "memory");
      }
    }
  }
}

IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx128_to_16xXXx128_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_1xXXx128_riscv_64_xopu, 1)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx128_to_16xXXx128_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_2xXXx128_riscv_64_xopu, 2)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx128_to_16xXXx128_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_4xXXx128_riscv_64_xopu, 4)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx128_to_16xXXx128_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_8xXXx128_riscv_64_xopu, 8)
IREE_UK_MMT4D_TILE_FUNC_IMPL_FOR_M0(
    iree_uk_mmt4d_tile_s8s8s32_1xXXx128_to_16xXXx128_riscv_64_xopu,
    iree_uk_mmt4d_tile_s8s8s32_16xXXx128_riscv_64_xopu, 16)

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
