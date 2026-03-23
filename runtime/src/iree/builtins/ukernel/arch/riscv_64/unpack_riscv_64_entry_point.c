// Copyright 2025 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/builtins/ukernel/arch/riscv_64/common_riscv_64.h"
#include "iree/builtins/ukernel/arch/riscv_64/unpack_riscv_64_internal.h"

// Vectorized unpack tile for int32 with tile_size0 <= VLMAX, tile_size1 = 1.
// Reverse of pack: contiguous load from packed data, strided scatter to output.
// The output (matmul result) is int32, so we use e32 loads/stores.
static void iree_uk_unpack_tile_i32_direct_riscv_64_v(
    void* IREE_UK_RESTRICT out_tile_ptr,
    const void* IREE_UK_RESTRICT in_tile_ptr, iree_uk_index_t outer_size1,
    iree_uk_index_t out_stride0, iree_uk_index_t in_stride1,
    iree_uk_index_t elem_size, iree_uk_index_t tile_size0,
    iree_uk_index_t tile_size1) {
  const char* IREE_UK_RESTRICT in_ptr = in_tile_ptr;
  char* IREE_UK_RESTRICT out_ptr = out_tile_ptr;
  iree_uk_index_t byte_stride0 = out_stride0 * elem_size;

  // For e32: VLMAX = VLEN*LMUL/32. On V128: m4=16, m8=32.
  // tile_size0=64 exceeds m8 capacity, so split into 2 passes of 32.
  if (tile_size0 > 32) {
    iree_uk_index_t half = tile_size0 / 2;
    iree_uk_index_t half_bytes = half * elem_size;
    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" : : "r"(half));
    for (iree_uk_index_t j = 0; j < outer_size1; ++j) {
      // First half
      asm volatile("vle32.v v0, (%0)" : : "r"(in_ptr) : "memory");
      asm volatile("vsse32.v v0, (%0), %1" : : "r"(out_ptr), "r"(byte_stride0) : "memory");
      // Second half
      asm volatile("vle32.v v0, (%0)" : : "r"(in_ptr + half_bytes) : "memory");
      asm volatile("vsse32.v v0, (%0), %1" : : "r"(out_ptr + half * byte_stride0), "r"(byte_stride0) : "memory");
      in_ptr += in_stride1 * elem_size;
      out_ptr += tile_size1 * elem_size;
    }
    return;
  }

  if (tile_size0 > 16) {
    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" : : "r"(tile_size0));
  } else {
    asm volatile("vsetvli zero, %0, e32, m4, ta, ma" : : "r"(tile_size0));
  }

  for (iree_uk_index_t j = 0; j < outer_size1; ++j) {
    // Contiguous load from packed data
    asm volatile("vle32.v v0, (%0)" : : "r"(in_ptr) : "memory");
    // Strided scatter to output
    asm volatile("vsse32.v v0, (%0), %1"
                 :
                 : "r"(out_ptr), "r"(byte_stride0)
                 : "memory");

    in_ptr += in_stride1 * elem_size;
    out_ptr += tile_size1 * elem_size;
  }
}

// Vectorized unpack tile for int8.
static void iree_uk_unpack_tile_i8_direct_riscv_64_v(
    void* IREE_UK_RESTRICT out_tile_ptr,
    const void* IREE_UK_RESTRICT in_tile_ptr, iree_uk_index_t outer_size1,
    iree_uk_index_t out_stride0, iree_uk_index_t in_stride1,
    iree_uk_index_t elem_size, iree_uk_index_t tile_size0,
    iree_uk_index_t tile_size1) {
  const char* IREE_UK_RESTRICT in_ptr = in_tile_ptr;
  char* IREE_UK_RESTRICT out_ptr = out_tile_ptr;

  asm volatile("vsetvli zero, %0, e8, m1, ta, ma" : : "r"(tile_size0));

  for (iree_uk_index_t j = 0; j < outer_size1; ++j) {
    asm volatile("vle8.v v0, (%0)" : : "r"(in_ptr) : "memory");
    asm volatile("vsse8.v v0, (%0), %1"
                 :
                 : "r"(out_ptr), "r"(out_stride0)
                 : "memory");

    in_ptr += in_stride1 * elem_size;
    out_ptr += tile_size1 * elem_size;
  }
}

iree_uk_unpack_tile_func_t iree_uk_unpack_select_tile_func_arch(
    const iree_uk_unpack_params_t* params) {
#if defined(IREE_UK_BUILD_RISCV_64_V)
  if (!iree_uk_cpu_riscv_64_v(params->cpu_data)) return 0;

  iree_uk_unpack_type_t type = iree_uk_unpack_type(params->flags);
  int esize = iree_uk_type_size(iree_uk_unpack_out_type(type));
  bool transpose = params->flags & IREE_UK_FLAG_UNPACK_TRANSPOSE_INNER;

  // Vectorized direct unpack for tile_size1 == 1 (strided scatter pattern).
  if (!transpose && params->in_size3 == 1) {
    if (esize == 4 && params->in_size2 <= 64) {
      return iree_uk_unpack_tile_i32_direct_riscv_64_v;
    }
    if (esize == 1 && params->in_size2 <= 64) {
      return iree_uk_unpack_tile_i8_direct_riscv_64_v;
    }
  }
#endif
  return 0;
}
