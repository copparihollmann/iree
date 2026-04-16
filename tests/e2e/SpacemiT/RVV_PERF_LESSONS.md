# RVV i8 Matmul Performance Lessons (SpacemiT X60)

Date: 2026-02-24
Scope: `matmul_q_i8.mlir` (`32x64 * 64x32 -> 32x32`, i8*i8->i32), RVV path on X60.

## 1. What hurt performance initially

- The older lowered loop used costly widen+permute patterns (`vsext`, `vrgather`, `vslide*`) around `vmacc`.
- On this core/schedule model, that sequence produced very low throughput and IPC.
- Typical symptom set in assembly/MCA:
  - many `vsetvli` mode changes,
  - `vrgather`/`vslide` in the inner loop,
  - register move/spill noise (`vmv`, `vl4r/vs4r`) when constraints are tight.

## 2. What improved it

- Switching to a standard RVV widening sequence in the custom kernel path:
  - `vwmul.vx` + `vwadd.wv`.
- Current inner-loop profile now shows:
  - mostly `vwmul.vx`/`vwadd.wv`,
  - no gather-heavy sequence,
  - significantly better modeled throughput.

Observed (from your latest MCA snippet):
- `Block RThroughput: 24.0`
- `IPC: ~0.56`

## 3. LMUL lesson (important)

- For this specific kernel shape (`N=32` accumulators in `i32`), `RVV_LMUL_MAX=4` is beneficial.
- Why:
  - `vector<32xi32>` naturally maps to wide accumulator groups on VLEN=256.
  - Forcing `RVV_LMUL_MAX=1` causes legalization/splitting and extra data movement.
- So:
  - `LMUL_MAX=4` is best for this kernel.
  - This is not a universal rule for all kernels.

## 4. Where M/N/K are selected in this flow

For this mmt4d/data-tiling path:
- Primary packed tile selection (`M0/N0/K0`) comes from:
  - `compiler/src/iree/compiler/Codegen/ExternalInterfaces/CPUEncodingExternalModels.cpp`
  - `enumerateMatmulTileRiscv64(...)`
- Vector-level contraction sizing heuristics are also in:
  - `compiler/src/iree/compiler/Codegen/LLVMCPU/KernelDispatch.cpp`
  - `getMatmulRISCVVectorSizes(...)`

Practical implication:
- If you want to change packed `M0/N0/K0` for this workload, update `CPUEncodingExternalModels.cpp`.
- If you change shape, ensure custom kernel matcher/generator in
  `VectorContractCustomKernels.cpp` supports that same shape.

## 5. Kernel-family separation rule

Keep paths disjoint:
- `+xsmtvdot` -> SpacemiT vendor kernels.
- plain `+v` (no `+xsmtvdot`) -> standard RVV kernels.

This prevents ambiguous pattern selection and makes comparisons cleaner.

## 6. Recommended next experiments

Baseline (current good one):
- `(M,N,K) = (4,32,1)`, `RVV_LMUL_MAX=4`

Controlled experiments (one variable at a time):
1. `(4,32,2)` with dedicated kernel support (`vwmacc`-based), keep `LMUL_MAX=4`.
2. `(8,16,1)` as an alternative shape, keep `LMUL_MAX=4`.
3. Re-check `(4,32,1)` with small scalar-load refinements only after fixing shape.

Do not compare mixed changes together; change one variable per run.

## 7. Commands used for reproducibility

Compile/run script sweep:
- `RVV_LMUL_MAX=1 bash tests/e2e/SpacemiT/compile_rvv.sh tests/e2e/SpacemiT/matmul_q_i8.mlir`
- `RVV_LMUL_MAX=2 bash tests/e2e/SpacemiT/compile_rvv.sh tests/e2e/SpacemiT/matmul_q_i8.mlir`
- `RVV_LMUL_MAX=4 bash tests/e2e/SpacemiT/compile_rvv.sh tests/e2e/SpacemiT/matmul_q_i8.mlir`

MCA:
- `llvm-mca -mtriple=riscv64 -mcpu=spacemit-x60 -mattr=+v,+zvl256b -timeline -iterations=100 <kernel.s>`

## 8. Current takeaway

- You are no longer in the original "bad lowering" regime.
- Current loop is much healthier and near the expected vector-pipeline bound for this shape.
- Further gains now require targeted shape/scheduling experiments, not just generic LMUL lowering.

