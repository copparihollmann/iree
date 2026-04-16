	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl256b1p0_zvl32b1p0_zvl64b1p0"

# Run:
# llvm-mca -mtriple=riscv64 -mcpu=spacemit-x60 -mattr=+v,+zvl256b \
#   -timeline -iterations=100 tests/e2e/SpacemiT/mca/riscv_x60_rvv_i8_candidates.s

###############################################################################
# Region 0: Baseline K=1 loop (the known ~0.77 IPC shape).
###############################################################################

	.globl	rvv_i8_baseline_k1
	.type	rvv_i8_baseline_k1,@function
rvv_i8_baseline_k1:
.Lbaseline_k1_loop:
	vsetvli	zero, zero, e8, mf2, ta, ma
	vle8.v	v24, (t1)
	lbu	a1, -3(a3)
	lbu	a0, -2(a3)
	lbu	a2, -1(a3)
	lbu	a4, 0(a3)
	vwmul.vx	v25, v24, a1
	vwmul.vx	v26, v24, a0
	vwmul.vx	v27, v24, a2
	vwmul.vx	v28, v24, a4
	lbu	a0, 1(a3)
	lbu	a1, 2(a3)
	lbu	a2, 3(a3)
	lbu	a4, 4(a3)
	vwmul.vx	v29, v24, a0
	vwmul.vx	v30, v24, a1
	vwmul.vx	v31, v24, a2
	addi	t1, t1, 16
	addi	a5, a5, -16
	vwmul.vx	v7, v24, a4
	vsetvli	zero, zero, e16, m1, tu, ma
	vwadd.wv	v8, v8, v25
	vwadd.wv	v22, v22, v26
	vwadd.wv	v20, v20, v27
	vwadd.wv	v18, v18, v28
	vwadd.wv	v16, v16, v29
	vwadd.wv	v12, v12, v30
	vwadd.wv	v14, v14, v31
	vwadd.wv	v10, v10, v7
	addi	a3, a3, 8
	bnez	a5, .Lbaseline_k1_loop
	ret

###############################################################################
# Region 1: Candidate "K-unroll-by-2" loop.
# - Still K=1 tile semantics in compiler terms; this is just a hand-written
#   loop body that performs two K steps per iteration to amortize control/setup.
# - Goal: reduce non-VIEU overhead per effective MAC work.
# - Assumes a5 is a multiple of 32 bytes.
###############################################################################

	.globl	rvv_i8_candidate_unroll2
	.type	rvv_i8_candidate_unroll2,@function
rvv_i8_candidate_unroll2:
# LLVM-MCA-BEGIN
.Lcandidate_unroll2_loop:
	vsetvli	zero, zero, e8, mf2, ta, ma
	vle8.v	v24, (t1)
	addi	t3, t1, 16
	vle8.v	v6, (t3)

	lbu	a0, 0(a3)
	lbu	a1, 1(a3)
	lbu	a2, 2(a3)
	lbu	a4, 3(a3)
	lbu	a6, 4(a3)
	lbu	a7, 5(a3)
	lbu	t0, 6(a3)
	lbu	t2, 7(a3)
	vwmul.vx	v25, v24, a0
	vwmul.vx	v26, v24, a1
	vwmul.vx	v27, v24, a2
	vwmul.vx	v28, v24, a4
	vwmul.vx	v29, v24, a6
	vwmul.vx	v30, v24, a7
	vwmul.vx	v31, v24, t0
	vwmul.vx	v7, v24, t2

	lbu	a0, 8(a3)
	lbu	a1, 9(a3)
	lbu	a2, 10(a3)
	lbu	a4, 11(a3)
	lbu	a6, 12(a3)
	lbu	a7, 13(a3)
	lbu	t0, 14(a3)
	lbu	t2, 15(a3)
	vwmul.vx	v9, v6, a0
	vwmul.vx	v11, v6, a1
	vwmul.vx	v13, v6, a2
	vwmul.vx	v15, v6, a4
	vwmul.vx	v17, v6, a6
	vwmul.vx	v19, v6, a7
	vwmul.vx	v21, v6, t0
	vwmul.vx	v23, v6, t2

	addi	t1, t1, 32
	addi	a3, a3, 16
	addi	a5, a5, -32

	vsetvli	zero, zero, e16, m1, tu, ma
	vwadd.wv	v8, v8, v25
	vwadd.wv	v22, v22, v26
	vwadd.wv	v20, v20, v27
	vwadd.wv	v18, v18, v28
	vwadd.wv	v16, v16, v29
	vwadd.wv	v12, v12, v30
	vwadd.wv	v14, v14, v31
	vwadd.wv	v10, v10, v7

	vwadd.wv	v8, v8, v9
	vwadd.wv	v22, v22, v11
	vwadd.wv	v20, v20, v13
	vwadd.wv	v18, v18, v15
	vwadd.wv	v16, v16, v17
	vwadd.wv	v12, v12, v19
	vwadd.wv	v14, v14, v21
	vwadd.wv	v10, v10, v23
	bnez	a5, .Lcandidate_unroll2_loop
# LLVM-MCA-END
	ret
