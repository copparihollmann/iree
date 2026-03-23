// Copyright 2025 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// Ordering matters when multiple lines have the same types and tile shape and
// are supported by the CPU. In that case, the last-enumerated line overrides
// // preceding lines. Always go from oldest to shiniest code path.

IREE_UK_MMT4D_TILE(riscv_64, f32, f32, f32, 1, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, f32, f32, f32, 2, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, f32, f32, f32, 4, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, f32, f32, f32, 7, 1, _v)

IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 1, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 2, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 4, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 7, 1, _v)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 8, 1, _v)

// SpacemiT xsmtvdot uses 4x4x8-like blocking.
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 1, 8, _xsmtvdot)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 2, 8, _xsmtvdot)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 4, 8, _xsmtvdot)

// SpacemiT xsmtvdot FP8: vfmadot (f8E4M3FN x f8E4M3FN -> f16).
IREE_UK_MMT4D_TILE(riscv_64, f8e4m3, f8e4m3, f16, 4, 8, _xsmtvdot)

// Saturn OPU int8: K0=1, M0 up to 64 (VLEN/2).
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 1, 1, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 2, 1, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 4, 1, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 8, 1, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 16, 1, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 32, 1, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 64, 1, _xopu)
// K0=128 tiles (dead code — kept for future encoding swap work)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 1, 128, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 2, 128, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 4, 128, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 8, 128, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, s8, s8, s32, 16, 128, _xopu)

// Saturn OPU FP8: OPFMACC (f8E4M3FN x f8E4M3FN -> f32 accumulation).
IREE_UK_MMT4D_TILE(riscv_64, f8e4m3, f8e4m3, f32, 1, 16, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, f8e4m3, f8e4m3, f32, 2, 16, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, f8e4m3, f8e4m3, f32, 4, 16, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, f8e4m3, f8e4m3, f32, 8, 16, _xopu)
IREE_UK_MMT4D_TILE(riscv_64, f8e4m3, f8e4m3, f32, 16, 16, _xopu)

IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 1, 1, _zvfhmin)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 2, 1, _zvfhmin)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 4, 1, _zvfhmin)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 6, 1, _zvfhmin)

IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 1, 1, _zvfhmin)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 2, 1, _zvfhmin)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 4, 1, _zvfhmin)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 6, 1, _zvfhmin)

IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 1, 1, _zvfh)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 2, 1, _zvfh)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 4, 1, _zvfh)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f32, 7, 1, _zvfh)

IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 1, 1, _zvfh)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 2, 1, _zvfh)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 4, 1, _zvfh)
IREE_UK_MMT4D_TILE(riscv_64, f16, f16, f16, 7, 1, _zvfh)
