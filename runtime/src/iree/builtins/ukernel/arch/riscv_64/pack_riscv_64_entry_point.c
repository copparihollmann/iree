// Copyright 2025 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/builtins/ukernel/arch/riscv_64/common_riscv_64.h"
#include "iree/builtins/ukernel/arch/riscv_64/pack_riscv_64_internal.h"

// Vectorized pack tile for int8 with tile_size0 <= VLMAX, tile_size1 = 1.
// Uses vlse8.v (strided gather) to load tile_size0 elements at stride
// in_stride0, then vse8.v to store contiguously. This replaces tile_size0
// scalar load+store pairs with a single vector gather+scatter.
//
// Layout: inner_tiles=[tile_size0, 1], inner_dims_pos=[0, 1] (direct, no
// transpose). This is the standard mmt4d K0=1 packing for the M dimension.
static void iree_uk_pack_tile_i8_direct_riscv_64_v(
    void* IREE_UK_RESTRICT out_tile_ptr,
    const void* IREE_UK_RESTRICT in_tile_ptr, iree_uk_index_t outer_size1,
    iree_uk_index_t out_stride1, iree_uk_index_t in_stride0,
    iree_uk_index_t elem_size, iree_uk_index_t tile_size0,
    iree_uk_index_t tile_size1) {
  const char* IREE_UK_RESTRICT in_ptr = in_tile_ptr;
  char* IREE_UK_RESTRICT out_ptr = out_tile_ptr;

  // Set VL to tile_size0. Scale LMUL to fit: m1=16, m2=32, m4=64 on V128.
  if (tile_size0 > 32) {
    asm volatile("vsetvli zero, %0, e8, m4, ta, ma" : : "r"(tile_size0));
  } else if (tile_size0 > 16) {
    asm volatile("vsetvli zero, %0, e8, m2, ta, ma" : : "r"(tile_size0));
  } else {
    asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(tile_size0));
  }

  for (iree_uk_index_t j = 0; j < outer_size1; ++j) {
    // Strided gather: load tile_size0 bytes at stride in_stride0
    asm volatile("vlse8.v v0, (%0), %1"
                 :
                 : "r"(in_ptr), "r"(in_stride0)
                 : "memory");
    // Contiguous store
    asm volatile("vse8.v v0, (%0)" : : "r"(out_ptr) : "memory");

    in_ptr += tile_size1 * elem_size;  // advance to next column in source
    out_ptr += out_stride1 * elem_size;  // advance to next column in packed
  }
}

// Vectorized pack tile for int32 with tile_size0 <= VLMAX, tile_size1 = 1.
// Same pattern as i8 but with e32 element width.
static void iree_uk_pack_tile_i32_direct_riscv_64_v(
    void* IREE_UK_RESTRICT out_tile_ptr,
    const void* IREE_UK_RESTRICT in_tile_ptr, iree_uk_index_t outer_size1,
    iree_uk_index_t out_stride1, iree_uk_index_t in_stride0,
    iree_uk_index_t elem_size, iree_uk_index_t tile_size0,
    iree_uk_index_t tile_size1) {
  const char* IREE_UK_RESTRICT in_ptr = in_tile_ptr;
  char* IREE_UK_RESTRICT out_ptr = out_tile_ptr;
  iree_uk_index_t byte_stride0 = in_stride0 * elem_size;

  asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(tile_size0));

  for (iree_uk_index_t j = 0; j < outer_size1; ++j) {
    asm volatile("vlse32.v v0, (%0), %1"
                 :
                 : "r"(in_ptr), "r"(byte_stride0)
                 : "memory");
    asm volatile("vse32.v v0, (%0)" : : "r"(out_ptr) : "memory");

    in_ptr += tile_size1 * elem_size;
    out_ptr += out_stride1 * elem_size;
  }
}

iree_uk_pack_tile_func_t iree_uk_pack_select_tile_func_arch(
    const iree_uk_pack_params_t* params) {
#if defined(IREE_UK_BUILD_RISCV_64_V)
  if (!iree_uk_cpu_riscv_64_v(params->cpu_data)) return 0;

  iree_uk_pack_type_t type = iree_uk_pack_type(params->flags);
  int esize = iree_uk_type_size(iree_uk_pack_out_type(type));
  bool transpose = params->flags & IREE_UK_FLAG_PACK_TRANSPOSE_INNER;

  // Vectorized direct pack for tile_size1 == 1 (strided gather pattern).
  // This covers the common mmt4d K0=1 packing case where the M dimension
  // is gathered from strided positions.
  if (!transpose && params->out_size3 == 1) {
    if (esize == 1 && params->out_size2 <= 64) {
      return iree_uk_pack_tile_i8_direct_riscv_64_v;
    }
    if (esize == 4 && params->out_size2 <= 64) {
      return iree_uk_pack_tile_i32_direct_riscv_64_v;
    }
  }
#endif
  return 0;
}
