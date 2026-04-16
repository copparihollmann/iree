# SpacemiT X60 RVV i8 Matmul Tuning Notes (M/N/K)

This document explains the tuning choices for the RVV int8 path (`i8 x i8 -> i32`)
on SpacemiT X60 and how those choices map to code.

It covers:
- `M=8` vs `M=4`
- `N=16` vs `N=32`
- `K=2` vs `K=1`
- why changes must be synchronized across encoding, dispatch tiling, and custom
  kernel generation.

## 1) Hardware-Driven Math

For X60:
- `VLEN = 256` bits
- target op: `i8 x i8 -> i32`

For accumulator vectors (i32 lanes):

`LMUL_acc = (N * 32) / 256`

- `N=32` => `LMUL_acc = 4`
- `N=16` => `LMUL_acc = 2`

For RHS i8 vectors:

`LMUL_rhs_i8 = (N * 8) / 256`

- `N=32` => `LMUL_rhs_i8 = 1`
- `N=16` => `LMUL_rhs_i8 = 1/2`

Implication:
- `N=32` consumes much more accumulator register capacity per output row.
- `N=16` reduces accumulator pressure and allows larger `M` without spills.

## 2) Why M=8 helped vs M=4

`M` controls how many output rows are accumulated in parallel per inner step.

- `M=8` reuses the same RHS vector against 8 LHS scalars.
- This increases useful work per loop/control overhead and better hides scalar
  load latency (`lbu`) on this in-order core.
- The tradeoff is register pressure; this is why pairing `M=8` with `N=16`
  (LMUL2 accumulators) is important.

With `N=32` (LMUL4), high `M` quickly pushes register pressure and tends to
reintroduce spill/reload patterns.

## 3) Why N=16 often beats N=32 here

`N=32` has wider vectors, but on X60 it also:
- increases LMUL for accumulators (`LMUL4`)
- increases per-instruction pressure/latency for this instruction mix
- can trigger spill/reload and extra shuffle/sliding overhead

`N=16` reduces accumulator LMUL to 2 and leaves more headroom for `M=8`,
which improved sustained IPC in practice for this kernel shape.

## 4) Why test K=2

`K=2` can improve arithmetic intensity per loop iteration by amortizing control
overhead (`branch`, pointer updates, setup) across two K contributions.

Potential win:
- fewer loop-control instructions per effective MAC work.

Potential downside:
- higher live range pressure.
- for RHS packed as `[N x K]` with `K` as innermost, data appears interleaved
  in flattened form. For `K=2`, the kernel must deinterleave RHS into two
  N-lane vectors before `vwmul.vx`.

So `K=2` is a valid experiment, but not guaranteed to beat `K=1`.

## 5) Why all 3 files must change

These 3 layers must agree on tile shape:

1. **Packing/Layout choice**:
   `compiler/src/iree/compiler/Codegen/ExternalInterfaces/CPUEncodingExternalModels.cpp`
   - chooses candidate `TileMxNxK`.
   - affects how LHS/RHS tiles are materialized in memory.

2. **Dispatch/vector tiling**:
   `compiler/src/iree/compiler/Codegen/LLVMCPU/KernelDispatch.cpp`
   - sets vector tile sizes used to form vector.contract shapes.
   - must request the same `M/N/K` the kernel pattern expects.

3. **Kernel pattern/generation**:
   `compiler/src/iree/compiler/Codegen/LLVMCPU/VectorContractCustomKernels.cpp`
   - defines which `M/N/K` shapes are recognized.
   - emits instruction sequence implementing exactly that shape.

If these are inconsistent, custom kernel matching fails or memory layout no
longer matches compute assumptions.

## 6) Current compiler state

### A) Encoding candidates
File: `CPUEncodingExternalModels.cpp`

RVV int8 candidates:
- `8x16x1`, `7x16x1`, `4x16x1`, `2x16x1`, `1x16x1`

### B) Dispatch vector sizes
File: `KernelDispatch.cpp`

Widening int8 path requests:
- `sizes.append({8, nSize, 1})`
- with `nSize` still derived from LMUL2 target (`N=16` on VLEN256).

### C) RVV custom kernels
File: `VectorContractCustomKernels.cpp`

Kept kernels:
- `MMTKernel_RVV_8x16x1_Int8`
- `MMTKernel_RVV_7x16x1_Int8`

Generator behavior:
- RVV matcher targets `k0 == 1` for this family.
- The kernel path is focused on the proven `K=1` configuration.

## 7) M/N/K-to-code mapping

- `m0`:
  - number of accumulators (`accRegs = m0` in this RVV family).
  - number of LHS scalar contributions per K slice.

- `n0`:
  - vector lane count for i32 output.
  - drives scalable lane count (`n0 / 4` for VLEN=256 in this path).

- `k0`:
  - number of K contributions per loop body.
  - increases LHS/RHS packed register sizes (`lhsRegSize = m0*k0`,
    `rhsRegSize = n0*k0` for single-register flattened input in this path).

## 8) K=2 experiment result and A/B

The `K=2` variant was tested and did not improve over the best `K=1` result
for this target/problem. The compiler path was reverted to `K=1`.

To force K-only experiments:
- In `KernelDispatch.cpp`, switch `{8, nSize, 1}` <-> `{8, nSize, 2}`.
- In `CPUEncodingExternalModels.cpp`, keep desired `TileMxNxK` set first.
- Keep matching kernel variants/patterns aligned in
  `VectorContractCustomKernels.cpp` if enabling a non-default K.

Recommended metrics to compare:
- end-to-end cycles for fixed problem size
- spill/reload presence (`vs4r`/`vl4r`)
- `llvm-mca` resource pressure and throughput
- IPC as secondary indicator (not the only one)

Reference MCA micro-kernel candidates are in:
- `tests/e2e/SpacemiT/mca/riscv_x60_rvv_i8_candidates.s`
