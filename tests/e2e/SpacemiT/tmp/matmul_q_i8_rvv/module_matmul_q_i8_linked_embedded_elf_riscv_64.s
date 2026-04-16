	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl256b1p0_zvl32b1p0_zvl64b1p0"
	.file	"matmul_q_i8_linked"
	.section	.text.matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32,"ax",@progbits
	.p2align	1
	.type	matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32,@function
matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32:
.Lfunc_begin0:
	.file	1 "-"
	.loc	1 1 0
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)
	sd	s0, 0(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
.Ltmp0:
	.loc	1 1 1 prologue_end
	lwu	a2, 0(a2)
	ld	a1, 32(a1)
	vsetivli	zero, 16, e32, m2, ta, ma
	vmv.v.i	v8, 0
	andi	a7, a2, 1
	ld	a3, 0(a1)
	ld	a6, 8(a1)
	srli	t0, a2, 1
	slli	a4, a7, 10
	slli	a5, t0, 9
	add	a4, a4, a3
	add	a3, a3, a5
	addi	a4, a4, 2047
	addi	a3, a3, 3
	addi	t1, a4, 1
	li	a5, 1024
	vmv.v.i	v22, 0
	vmv.v.i	v20, 0
	vmv.v.i	v18, 0
	vmv.v.i	v16, 0
	vmv.v.i	v12, 0
	vmv.v.i	v14, 0
	vmv.v.i	v10, 0
# LLVM-MCA-BEGIN
.LBB0_1:
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
	bnez	a5, .LBB0_1
# LLVM-MCA-END
	slli	t0, t0, 10
	slli	a7, a7, 6
	add	a6, a6, t0
	add	a6, a6, a7
	vse32.v	v8, (a6)
	addi	a0, a6, 128
	addi	a1, a6, 256
	vse32.v	v22, (a0)
	addi	a0, a6, 384
	vse32.v	v20, (a1)
	addi	a1, a6, 512
	vse32.v	v18, (a0)
	addi	a0, a6, 640
	vse32.v	v16, (a1)
	addi	a1, a6, 768
	addi	a2, a6, 896
	vse32.v	v12, (a0)
	vse32.v	v14, (a1)
	vse32.v	v10, (a2)
	li	a0, 0
	.loc	1 1 1 epilogue_begin is_stmt 0
	addi	sp, s0, -16
	.cfi_def_cfa sp, 16
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Ltmp1:
.Lfunc_end0:
	.size	matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32, .Lfunc_end0-matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32
	.cfi_endproc

	.section	.text._encoding_0_encode_32x64xi8_to_32x64xi8,"ax",@progbits
	.p2align	1
	.type	_encoding_0_encode_32x64xi8_to_32x64xi8,@function
_encoding_0_encode_32x64xi8_to_32x64xi8:
.Lfunc_begin1:
	.loc	1 1 0 is_stmt 1
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)
	sd	s0, 0(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
.Ltmp2:
	.loc	1 1 1 prologue_end
	ld	a0, 32(a1)
	lwu	a2, 0(a2)
	ld	a3, 0(a0)
	ld	a1, 8(a0)
	li	a0, 128
	andi	a4, a2, 3
	slli	a4, a4, 7
	add	a1, a1, a4
	slli	a4, a2, 62
	srli	a2, a2, 2
	srli	a4, a4, 58
	slli	a2, a2, 9
	add	a3, a3, a4
	li	a4, 64
	vsetivli	zero, 8, e8, mf4, ta, ma
.LBB1_1:
	add	a5, a3, a2
	vlse8.v	v8, (a5), a4
	add	a5, a1, a2
	addi	a1, a1, 8
	addi	a0, a0, -8
	vse8.v	v8, (a5)
	addi	a3, a3, 1
	bnez	a0, .LBB1_1
	.loc	1 1 1 epilogue_begin is_stmt 0
	addi	sp, s0, -16
	.cfi_def_cfa sp, 16
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Ltmp3:
.Lfunc_end1:
	.size	_encoding_0_encode_32x64xi8_to_32x64xi8, .Lfunc_end1-_encoding_0_encode_32x64xi8_to_32x64xi8
	.cfi_endproc

	.section	.text._encoding_1_encode_64x32xi8_to_64x32xi8,"ax",@progbits
	.p2align	1
	.type	_encoding_1_encode_64x32xi8_to_64x32xi8,@function
_encoding_1_encode_64x32xi8_to_64x32xi8:
.Lfunc_begin2:
	.loc	1 1 0 is_stmt 1
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)
	sd	s0, 0(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
.Ltmp4:
	.loc	1 1 1 prologue_end
	ld	a0, 32(a1)
	lwu	a1, 0(a2)
	ld	a2, 0(a0)
	ld	a0, 8(a0)
	srli	a3, a1, 6
	andi	a1, a1, 63
	slli	a4, a3, 10
	slli	a3, a3, 4
	slli	a5, a1, 5
	slli	a1, a1, 4
	add	a3, a3, a5
	add	a2, a2, a3
	vsetivli	zero, 16, e8, mf2, ta, ma
	vle8.v	v8, (a2)
	add	a1, a1, a4
	add	a0, a0, a1
	addi	a0, a0, 2047
	addi	a0, a0, 1
	vse8.v	v8, (a0)
	li	a0, 0
	.loc	1 1 1 epilogue_begin is_stmt 0
	addi	sp, s0, -16
	.cfi_def_cfa sp, 16
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Ltmp5:
.Lfunc_end2:
	.size	_encoding_1_encode_64x32xi8_to_64x32xi8, .Lfunc_end2-_encoding_1_encode_64x32xi8_to_64x32xi8
	.cfi_endproc

	.section	.text.iree_hal_executable_library_query,"ax",@progbits
	.globl	iree_hal_executable_library_query
	.p2align	1
	.type	iree_hal_executable_library_query,@function
iree_hal_executable_library_query:
.Liree_hal_executable_library_query$local:
	.type	.Liree_hal_executable_library_query$local,@function
.Lfunc_begin3:
	.cfi_startproc
	addiw	a0, a0, -6
.Lpcrel_hi0:
	auipc	a1, %pcrel_hi(iree_hal_executable_library_query_v0)
	snez	a0, a0
	addi	a1, a1, %pcrel_lo(.Lpcrel_hi0)
	addi	a0, a0, -1
	and	a0, a0, a1
	ret
.Lfunc_end3:
	.size	iree_hal_executable_library_query, .Lfunc_end3-iree_hal_executable_library_query
	.size	.Liree_hal_executable_library_query$local, .Lfunc_end3-iree_hal_executable_library_query
	.cfi_endproc

	.section	.text.iree_h2f_ieee,"ax",@progbits
	.p2align	1
	.type	iree_h2f_ieee,@function
iree_h2f_ieee:
.Lfunc_begin4:
	.cfi_startproc
	li	a3, 31
	andi	a1, a0, 1023
	lui	a4, 8
	slli	a3, a3, 10
	and	a2, a0, a3
	and	a0, a0, a4
	slli	a0, a0, 16
	beqz	a2, .LBB4_4
	bne	a2, a3, .LBB4_5
	beqz	a1, .LBB4_6
	lui	a1, 523264
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB4_4:
	lui	a2, 210944
	or	a0, a0, a2
	fcvt.s.wu	fa5, a1
	fmv.w.x	fa4, a0
	fmul.s	fa0, fa5, fa4
	ret
.LBB4_5:
	add	a1, a1, a2
	lui	a2, 28
	add	a1, a1, a2
	slli	a1, a1, 13
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB4_6:
	lui	a1, 522240
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.Lfunc_end4:
	.size	iree_h2f_ieee, .Lfunc_end4-iree_h2f_ieee
	.cfi_endproc

	.section	.text.iree_f2h_ieee,"ax",@progbits
	.p2align	1
	.type	iree_f2h_ieee,@function
iree_f2h_ieee:
.Lfunc_begin5:
	.cfi_startproc
	fmv.x.w	a2, fa0
	lui	a4, 522240
	and	a1, a2, a4
	srliw	a0, a2, 16
	beqz	a1, .LBB5_6
	slli	a3, a2, 41
	srli	a3, a3, 41
	bne	a1, a4, .LBB5_4
	beqz	a3, .LBB5_5
	lui	a1, 8
	addi	a1, a1, -1
	or	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.LBB5_4:
	lui	a4, 290816
	bgeu	a4, a1, .LBB5_7
.LBB5_5:
	li	a1, 31
	slli	a1, a1, 10
.LBB5_6:
	lui	a2, 8
	and	a0, a0, a2
	or	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.LBB5_7:
	srli	a1, a1, 23
	li	a4, 113
	bgeu	a1, a4, .LBB5_9
	lui	a2, 8
	and	a0, a0, a2
	mv	a0, a0
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.LBB5_9:
	lui	a4, 2
	and	a2, a2, a4
	lui	a4, 1
	seqz	a2, a2
	sub	a3, a3, a2
	li	a2, 15
	add	a3, a3, a4
	srliw	a4, a3, 23
	srliw	a3, a3, 13
	add	a1, a1, a4
	snez	a4, a4
	addi	a1, a1, -127
	addi	a4, a4, -1
	slli	a1, a1, 10
	and	a3, a3, a4
	add	a1, a1, a3
	slli	a2, a2, 10
	add	a1, a1, a2
	lui	a2, 8
	and	a0, a0, a2
	or	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.Lfunc_end5:
	.size	iree_f2h_ieee, .Lfunc_end5-iree_f2h_ieee
	.cfi_endproc

	.section	.text.__gnu_h2f_ieee,"ax",@progbits
	.p2align	1
	.type	__gnu_h2f_ieee,@function
__gnu_h2f_ieee:
.Lfunc_begin6:
	.cfi_startproc
	li	a3, 31
	andi	a1, a0, 1023
	lui	a4, 8
	slli	a3, a3, 10
	and	a2, a0, a3
	and	a0, a0, a4
	slli	a0, a0, 16
	beqz	a2, .LBB6_4
	bne	a2, a3, .LBB6_5
	beqz	a1, .LBB6_6
	lui	a1, 523264
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB6_4:
	lui	a2, 210944
	or	a0, a0, a2
	fcvt.s.wu	fa5, a1
	fmv.w.x	fa4, a0
	fmul.s	fa0, fa5, fa4
	ret
.LBB6_5:
	add	a1, a1, a2
	lui	a2, 28
	add	a1, a1, a2
	slli	a1, a1, 13
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB6_6:
	lui	a1, 522240
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.Lfunc_end6:
	.size	__gnu_h2f_ieee, .Lfunc_end6-__gnu_h2f_ieee
	.cfi_endproc

	.section	.text.__extendhfsf2,"ax",@progbits
	.p2align	1
	.type	__extendhfsf2,@function
__extendhfsf2:
.Lfunc_begin7:
	.cfi_startproc
	fmv.x.w	a1, fa0
	li	a3, 31
	slli	a3, a3, 10
	andi	a2, a1, 1023
	slli	a0, a1, 16
	and	a4, a1, a3
	lui	a5, 524288
	and	a0, a0, a5
	beqz	a4, .LBB7_4
	bne	a4, a3, .LBB7_5
	beqz	a2, .LBB7_6
	lui	a1, 523264
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB7_4:
	lui	a1, 210944
	or	a0, a0, a1
	fcvt.s.wu	fa5, a2
	fmv.w.x	fa4, a0
	fmul.s	fa0, fa5, fa4
	ret
.LBB7_5:
	slli	a1, a1, 49
	srli	a1, a1, 49
	lui	a2, 28
	add	a1, a1, a2
	slli	a1, a1, 13
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB7_6:
	lui	a1, 522240
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.Lfunc_end7:
	.size	__extendhfsf2, .Lfunc_end7-__extendhfsf2
	.cfi_endproc

	.section	.text.__gnu_f2h_ieee,"ax",@progbits
	.p2align	1
	.type	__gnu_f2h_ieee,@function
__gnu_f2h_ieee:
.Lfunc_begin8:
	.cfi_startproc
	fmv.x.w	a2, fa0
	lui	a4, 522240
	and	a1, a2, a4
	srliw	a0, a2, 16
	beqz	a1, .LBB8_6
	slli	a3, a2, 41
	srli	a3, a3, 41
	bne	a1, a4, .LBB8_4
	beqz	a3, .LBB8_5
	lui	a1, 8
	addi	a1, a1, -1
	or	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.LBB8_4:
	lui	a4, 290816
	bgeu	a4, a1, .LBB8_7
.LBB8_5:
	li	a1, 31
	slli	a1, a1, 10
.LBB8_6:
	lui	a2, 8
	and	a0, a0, a2
	or	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.LBB8_7:
	srli	a1, a1, 23
	li	a4, 113
	bgeu	a1, a4, .LBB8_9
	lui	a2, 8
	and	a0, a0, a2
	mv	a0, a0
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.LBB8_9:
	lui	a4, 2
	and	a2, a2, a4
	lui	a4, 1
	seqz	a2, a2
	sub	a3, a3, a2
	li	a2, 15
	add	a3, a3, a4
	srliw	a4, a3, 23
	srliw	a3, a3, 13
	add	a1, a1, a4
	snez	a4, a4
	addi	a1, a1, -127
	addi	a4, a4, -1
	slli	a1, a1, 10
	and	a3, a3, a4
	add	a1, a1, a3
	slli	a2, a2, 10
	add	a1, a1, a2
	lui	a2, 8
	and	a0, a0, a2
	or	a0, a0, a1
	slli	a0, a0, 48
	srai	a0, a0, 48
	ret
.Lfunc_end8:
	.size	__gnu_f2h_ieee, .Lfunc_end8-__gnu_f2h_ieee
	.cfi_endproc

	.section	.text.__truncsfhf2,"ax",@progbits
	.p2align	1
	.type	__truncsfhf2,@function
__truncsfhf2:
.Lfunc_begin9:
	.cfi_startproc
	fmv.x.w	a2, fa0
	lui	a4, 522240
	and	a1, a2, a4
	srliw	a0, a2, 16
	beqz	a1, .LBB9_9
	slli	a3, a2, 41
	srli	a3, a3, 41
	bne	a1, a4, .LBB9_4
	beqz	a3, .LBB9_5
	lui	a1, 8
	addi	a1, a1, -1
	or	a0, a0, a1
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sh	a0, 12(sp)
	flw	fa0, 12(sp)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB9_4:
	lui	a4, 290816
	bgeu	a4, a1, .LBB9_6
.LBB9_5:
	li	a1, 31
	slli	a1, a1, 10
	j	.LBB9_9
.LBB9_6:
	srli	a1, a1, 23
	li	a4, 113
	bgeu	a1, a4, .LBB9_8
	li	a1, 0
	j	.LBB9_9
.LBB9_8:
	lui	a4, 2
	and	a2, a2, a4
	lui	a4, 1
	seqz	a2, a2
	sub	a3, a3, a2
	li	a2, 15
	add	a3, a3, a4
	srliw	a4, a3, 23
	srliw	a3, a3, 13
	add	a1, a1, a4
	snez	a4, a4
	addi	a1, a1, -127
	addi	a4, a4, -1
	slli	a1, a1, 10
	and	a3, a3, a4
	add	a1, a1, a3
	slli	a2, a2, 10
	add	a1, a1, a2
.LBB9_9:
	lui	a2, 8
	and	a0, a0, a2
	or	a0, a0, a1
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sh	a0, 12(sp)
	flw	fa0, 12(sp)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	__truncsfhf2, .Lfunc_end9-__truncsfhf2
	.cfi_endproc

	.section	.text.__extendhfdf2,"ax",@progbits
	.p2align	1
	.type	__extendhfdf2,@function
__extendhfdf2:
.Lfunc_begin10:
	.cfi_startproc
	fmv.x.w	a1, fa0
	li	a3, 31
	slli	a3, a3, 10
	andi	a2, a1, 1023
	slli	a0, a1, 16
	and	a4, a1, a3
	lui	a5, 524288
	and	a0, a0, a5
	beqz	a4, .LBB10_4
	bne	a4, a3, .LBB10_5
	beqz	a2, .LBB10_6
	lui	a1, 523264
	or	a0, a0, a1
	fmv.w.x	fa5, a0
	fcvt.d.s	fa0, fa5
	ret
.LBB10_4:
	lui	a1, 210944
	or	a0, a0, a1
	fcvt.s.wu	fa5, a2
	fmv.w.x	fa4, a0
	fmul.s	fa5, fa5, fa4
	fcvt.d.s	fa0, fa5
	ret
.LBB10_5:
	slli	a1, a1, 49
	srli	a1, a1, 49
	lui	a2, 28
	add	a1, a1, a2
	slli	a1, a1, 13
	or	a0, a0, a1
	fmv.w.x	fa5, a0
	fcvt.d.s	fa0, fa5
	ret
.LBB10_6:
	lui	a1, 522240
	or	a0, a0, a1
	fmv.w.x	fa5, a0
	fcvt.d.s	fa0, fa5
	ret
.Lfunc_end10:
	.size	__extendhfdf2, .Lfunc_end10-__extendhfdf2
	.cfi_endproc

	.section	.text.__truncdfhf2,"ax",@progbits
	.p2align	1
	.type	__truncdfhf2,@function
__truncdfhf2:
.Lfunc_begin11:
	.cfi_startproc
	fcvt.s.d	fa5, fa0
	fmv.x.w	a2, fa5
	lui	a4, 522240
	and	a1, a2, a4
	srliw	a0, a2, 16
	beqz	a1, .LBB11_9
	slli	a3, a2, 41
	srli	a3, a3, 41
	bne	a1, a4, .LBB11_4
	beqz	a3, .LBB11_5
	lui	a1, 8
	addi	a1, a1, -1
	or	a0, a0, a1
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sh	a0, 12(sp)
	flw	fa0, 12(sp)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB11_4:
	lui	a4, 290816
	bgeu	a4, a1, .LBB11_6
.LBB11_5:
	li	a1, 31
	slli	a1, a1, 10
	j	.LBB11_9
.LBB11_6:
	srli	a1, a1, 23
	li	a4, 113
	bgeu	a1, a4, .LBB11_8
	li	a1, 0
	j	.LBB11_9
.LBB11_8:
	lui	a4, 2
	and	a2, a2, a4
	lui	a4, 1
	seqz	a2, a2
	sub	a3, a3, a2
	li	a2, 15
	add	a3, a3, a4
	srliw	a4, a3, 23
	srliw	a3, a3, 13
	add	a1, a1, a4
	snez	a4, a4
	addi	a1, a1, -127
	addi	a4, a4, -1
	slli	a1, a1, 10
	and	a3, a3, a4
	add	a1, a1, a3
	slli	a2, a2, 10
	add	a1, a1, a2
.LBB11_9:
	lui	a2, 8
	and	a0, a0, a2
	or	a0, a0, a1
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sh	a0, 12(sp)
	flw	fa0, 12(sp)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	__truncdfhf2, .Lfunc_end11-__truncdfhf2
	.cfi_endproc

	.section	.text.fma,"ax",@progbits
	.p2align	1
	.type	fma,@function
fma:
.Lfunc_begin12:
	.cfi_startproc
	fmadd.d	fa0, fa0, fa1, fa2
	ret
.Lfunc_end12:
	.size	fma, .Lfunc_end12-fma
	.cfi_endproc

	.section	.text.__math_invalidf,"ax",@progbits
	.p2align	1
	.type	__math_invalidf,@function
__math_invalidf:
.Lfunc_begin13:
	.cfi_startproc
	fsub.s	fa5, fa0, fa0
	fdiv.s	fa0, fa5, fa5
	ret
.Lfunc_end13:
	.size	__math_invalidf, .Lfunc_end13-__math_invalidf
	.cfi_endproc

	.section	.text.__math_oflowf,"ax",@progbits
	.p2align	1
	.type	__math_oflowf,@function
__math_oflowf:
.Lfunc_begin14:
	.cfi_startproc
	sext.w	a0, a0
	lui	a1, 458752
	fmv.w.x	fa5, a1
	fmv.s	fa4, fa5
	beqz	a0, .LBB14_2
	lui	a0, 983040
	fmv.w.x	fa4, a0
.LBB14_2:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	fsw	fa4, 12(sp)
	flw	fa4, 12(sp)
	fmul.s	fa0, fa4, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	__math_oflowf, .Lfunc_end14-__math_oflowf
	.cfi_endproc

	.section	.text.__math_xflowf,"ax",@progbits
	.p2align	1
	.type	__math_xflowf,@function
__math_xflowf:
.Lfunc_begin15:
	.cfi_startproc
	sext.w	a0, a0
	fmv.s	fa5, fa0
	beqz	a0, .LBB15_2
	fneg.s	fa5, fa0
.LBB15_2:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	fsw	fa5, 12(sp)
	flw	fa5, 12(sp)
	fmul.s	fa0, fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	__math_xflowf, .Lfunc_end15-__math_xflowf
	.cfi_endproc

	.section	.text.__math_uflowf,"ax",@progbits
	.p2align	1
	.type	__math_uflowf,@function
__math_uflowf:
.Lfunc_begin16:
	.cfi_startproc
	sext.w	a0, a0
	lui	a1, 65536
	fmv.w.x	fa5, a1
	fmv.s	fa4, fa5
	beqz	a0, .LBB16_2
	lui	a0, 589824
	fmv.w.x	fa4, a0
.LBB16_2:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	fsw	fa4, 12(sp)
	flw	fa4, 12(sp)
	fmul.s	fa0, fa4, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end16:
	.size	__math_uflowf, .Lfunc_end16-__math_uflowf
	.cfi_endproc

	.section	.text.ceilf,"ax",@progbits
	.p2align	1
	.type	ceilf,@function
ceilf:
.Lfunc_begin17:
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	fmv.x.w	a0, fa0
	slli	a1, a0, 33
	srli	a1, a1, 56
	li	a2, 149
	bltu	a2, a1, .LBB17_9
	li	a2, 127
	bltu	a1, a2, .LBB17_4
	addi	a1, a1, -127
	lui	a2, 2048
	addi	a2, a2, -1
	srlw	a2, a2, a1
	and	a3, a2, a0
	beqz	a3, .LBB17_9
	lui	a3, 505856
	srli	a4, a0, 63
	fmv.w.x	fa5, a3
	lui	a3, 1046528
	sraw	a1, a3, a1
	addi	a4, a4, -1
	fadd.s	fa5, fa0, fa5
	and	a2, a2, a4
	fsw	fa5, 8(sp)
	add	a0, a0, a2
	and	a0, a0, a1
	j	.LBB17_8
.LBB17_4:
	lui	a1, 505856
	fmv.w.x	fa5, a1
	fadd.s	fa5, fa0, fa5
	fsw	fa5, 12(sp)
	bltz	a0, .LBB17_7
	beqz	a0, .LBB17_9
	lui	a0, 260096
	j	.LBB17_8
.LBB17_7:
	lui	a0, 524288
.LBB17_8:
	fmv.w.x	fa0, a0
.LBB17_9:
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end17:
	.size	ceilf, .Lfunc_end17-ceilf
	.cfi_endproc

	.section	.text.expf,"ax",@progbits
	.p2align	1
	.type	expf,@function
expf:
.Lfunc_begin18:
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	.cfi_remember_state
	fmv.x.w	a0, fa0
	slli	a0, a0, 33
	srli	a0, a0, 53
	li	a1, 1067
	bgeu	a0, a1, .LBB18_2
.LBB18_1:
	fcvt.d.s	fa5, fa0
.Lpcrel_hi1:
	auipc	a0, %pcrel_hi(.promoted_doubles.expf)
	lui	a1, 2151
	li	a2, -1945
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi1)
	fld	fa4, 0(a0)
	fld	fa3, 8(a0)
	fld	fa2, 16(a0)
	fld	fa1, 24(a0)
.Lpcrel_hi2:
	auipc	a0, %pcrel_hi(__exp2f_data)
	slli	a1, a1, 39
	fmv.d.x	fa0, a1
	li	a1, 1023
	slli	a2, a2, 51
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi2)
	slli	a1, a1, 52
	fmul.d	fa5, fa5, fa4
	fmv.d.x	fa4, a2
	fadd.d	fa0, fa5, fa0
	fmv.x.d	a2, fa0
	fadd.d	fa4, fa0, fa4
	fmv.d.x	fa0, a1
	fsub.d	fa5, fa5, fa4
	andi	a1, a2, 31
	slli	a2, a2, 47
	slli	a1, a1, 3
	add	a0, a0, a1
	ld	a0, 0(a0)
	fmadd.d	fa4, fa5, fa3, fa2
	fmul.d	fa3, fa5, fa5
	fmadd.d	fa5, fa5, fa1, fa0
	add	a0, a0, a2
	fmv.d.x	fa2, a0
	fmadd.d	fa5, fa4, fa3, fa5
	fmul.d	fa5, fa5, fa2
	fcvt.s.d	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB18_2:
	.cfi_restore_state
	.cfi_remember_state
	lui	a1, 1046528
	fmv.w.x	fa5, a1
	feq.s	a1, fa0, fa5
	beqz	a1, .LBB18_4
	fmv.w.x	fa0, zero
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB18_4:
	.cfi_restore_state
	.cfi_remember_state
	li	a1, 2040
	bgeu	a0, a1, .LBB18_7
	lui	a0, 273175
	addi	a0, a0, 535
	fmv.w.x	fa5, a0
	flt.s	a0, fa5, fa0
	beqz	a0, .LBB18_8
	lui	a0, 458752
	fmv.w.x	fa5, a0
	fsw	fa5, 8(sp)
	flw	fa4, 8(sp)
	fmul.s	fa0, fa4, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB18_7:
	.cfi_restore_state
	.cfi_remember_state
	fadd.s	fa0, fa0, fa0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB18_8:
	.cfi_restore_state
	lui	a0, 797951
	addi	a0, a0, 436
	fmv.w.x	fa5, a0
	flt.s	a0, fa0, fa5
	beqz	a0, .LBB18_1
	lui	a0, 65536
	fmv.w.x	fa5, a0
	fsw	fa5, 12(sp)
	flw	fa4, 12(sp)
	fmul.s	fa0, fa4, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end18:
	.size	expf, .Lfunc_end18-expf
	.cfi_endproc

	.section	.text.feclearexcept,"ax",@progbits
	.p2align	1
	.type	feclearexcept,@function
feclearexcept:
.Lfunc_begin19:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end19:
	.size	feclearexcept, .Lfunc_end19-feclearexcept
	.cfi_endproc

	.section	.text.feraiseexcept,"ax",@progbits
	.p2align	1
	.type	feraiseexcept,@function
feraiseexcept:
.Lfunc_begin20:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end20:
	.size	feraiseexcept, .Lfunc_end20-feraiseexcept
	.cfi_endproc

	.section	.text.fetestexcept,"ax",@progbits
	.p2align	1
	.type	fetestexcept,@function
fetestexcept:
.Lfunc_begin21:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end21:
	.size	fetestexcept, .Lfunc_end21-fetestexcept
	.cfi_endproc

	.section	.text.fegetround,"ax",@progbits
	.p2align	1
	.type	fegetround,@function
fegetround:
.Lfunc_begin22:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end22:
	.size	fegetround, .Lfunc_end22-fegetround
	.cfi_endproc

	.section	.text.__fesetround,"ax",@progbits
	.p2align	1
	.type	__fesetround,@function
__fesetround:
.Lfunc_begin23:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end23:
	.size	__fesetround, .Lfunc_end23-__fesetround
	.cfi_endproc

	.section	.text.fegetenv,"ax",@progbits
	.p2align	1
	.type	fegetenv,@function
fegetenv:
.Lfunc_begin24:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end24:
	.size	fegetenv, .Lfunc_end24-fegetenv
	.cfi_endproc

	.section	.text.fesetenv,"ax",@progbits
	.p2align	1
	.type	fesetenv,@function
fesetenv:
.Lfunc_begin25:
	.cfi_startproc
	li	a0, 0
	ret
.Lfunc_end25:
	.size	fesetenv, .Lfunc_end25-fesetenv
	.cfi_endproc

	.section	.text.floorf,"ax",@progbits
	.p2align	1
	.type	floorf,@function
floorf:
.Lfunc_begin26:
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	.cfi_remember_state
	fmv.x.w	a0, fa0
	slli	a1, a0, 33
	srli	a1, a1, 56
	li	a2, 149
	bltu	a2, a1, .LBB26_8
	li	a2, 127
	bltu	a1, a2, .LBB26_5
	addi	a1, a1, -127
	lui	a2, 2048
	addi	a2, a2, -1
	srlw	a2, a2, a1
	and	a3, a2, a0
	beqz	a3, .LBB26_8
	lui	a3, 505856
	fmv.w.x	fa5, a3
	lui	a3, 1046528
	sraw	a1, a3, a1
	srli	a3, a0, 31
	and	a2, a2, a3
	fadd.s	fa5, fa0, fa5
	add	a0, a0, a2
	fsw	fa5, 8(sp)
	and	a0, a0, a1
.LBB26_4:
	fmv.w.x	fa0, a0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB26_5:
	.cfi_restore_state
	.cfi_remember_state
	lui	a1, 505856
	fmv.w.x	fa5, a1
	fadd.s	fa5, fa0, fa5
	fsw	fa5, 12(sp)
	bltz	a0, .LBB26_7
	fmv.w.x	fa0, zero
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB26_7:
	.cfi_restore_state
	.cfi_remember_state
	fmv.w.x	fa5, zero
	feq.s	a0, fa0, fa5
	beqz	a0, .LBB26_9
.LBB26_8:
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB26_9:
	.cfi_restore_state
	lui	a0, 784384
	j	.LBB26_4
.Lfunc_end26:
	.size	floorf, .Lfunc_end26-floorf
	.cfi_endproc

	.section	.text.fmaf,"ax",@progbits
	.p2align	1
	.type	fmaf,@function
fmaf:
.Lfunc_begin27:
	.cfi_startproc
	fcvt.d.s	fa5, fa0
	fcvt.d.s	fa3, fa1
	fcvt.d.s	fa4, fa2
	fmul.d	fa3, fa5, fa3
	fadd.d	fa5, fa3, fa4
	fmv.x.d	a0, fa5
	slli	a1, a0, 35
	srli	a1, a1, 35
	lui	a2, 65536
	bne	a1, a2, .LBB27_4
	li	a1, 2047
	slli	a1, a1, 52
	and	a2, a0, a1
	beq	a2, a1, .LBB27_4
	fsub.d	fa2, fa5, fa3
	feq.d	a1, fa2, fa4
	beqz	a1, .LBB27_5
	fsub.d	fa2, fa5, fa4
	feq.d	a1, fa2, fa3
	beqz	a1, .LBB27_5
.LBB27_4:
	fcvt.s.d	fa0, fa5
	ret
.LBB27_5:
	srli	a1, a0, 63
	flt.d	a2, fa3, fa4
	xori	a2, a2, 1
	bne	a2, a1, .LBB27_8
	fsub.d	fa5, fa4, fa5
	fadd.d	fa5, fa3, fa5
	fmv.d.x	fa4, zero
	flt.d	a2, fa5, fa4
	xori	a2, a2, 1
	beq	a1, a2, .LBB27_9
.LBB27_7:
	addi	a0, a0, 1
	fmv.d.x	fa5, a0
	fcvt.s.d	fa0, fa5
	ret
.LBB27_8:
	fsub.d	fa5, fa3, fa5
	fadd.d	fa5, fa5, fa4
	fmv.d.x	fa4, zero
	flt.d	a2, fa5, fa4
	xori	a2, a2, 1
	bne	a1, a2, .LBB27_7
.LBB27_9:
	addi	a0, a0, -1
	fmv.d.x	fa5, a0
	fcvt.s.d	fa0, fa5
	ret
.Lfunc_end27:
	.size	fmaf, .Lfunc_end27-fmaf
	.cfi_endproc

	.section	.text.fmodf,"ax",@progbits
	.p2align	1
	.type	fmodf,@function
fmodf:
.Lfunc_begin28:
	.cfi_startproc
	fmv.x.w	a4, fa1
	slliw	a2, a4, 1
	beqz	a2, .LBB28_8
	slli	a3, a4, 33
	srli	a0, a3, 33
	lui	a1, 522240
	bltu	a1, a0, .LBB28_8
	fmv.x.w	a6, fa0
	slli	a1, a6, 33
	srli	a1, a1, 56
	li	a5, 255
	beq	a1, a5, .LBB28_8
	slliw	a5, a6, 1
	bgeu	a2, a5, .LBB28_9
	srli	a3, a3, 56
	lui	a2, 2048
	addi	a5, a2, -1
	beqz	a1, .LBB28_11
	and	a0, a6, a5
	or	a2, a2, a0
	beqz	a3, .LBB28_14
.LBB28_6:
	and	a4, a4, a5
	lui	a0, 2048
	or	a4, a4, a0
	blt	a3, a1, .LBB28_18
.LBB28_7:
	subw	a3, a2, a4
	bgez	a3, .LBB28_21
	j	.LBB28_22
.LBB28_8:
	fmul.s	fa5, fa0, fa1
	fdiv.s	fa0, fa5, fa5
	ret
.LBB28_9:
	beq	a5, a2, .LBB28_26
	ret
.LBB28_11:
	li	a1, 0
	slliw	a2, a6, 9
	bltz	a2, .LBB28_13
.LBB28_12:
	slliw	a2, a2, 1
	addiw	a1, a1, -1
	bgez	a2, .LBB28_12
.LBB28_13:
	li	a2, 1
	sub	a2, a2, a1
	sllw	a2, a6, a2
	bnez	a3, .LBB28_6
.LBB28_14:
	li	a3, 0
	slliw	a5, a4, 9
	bltz	a5, .LBB28_16
.LBB28_15:
	slliw	a5, a5, 1
	addiw	a3, a3, -1
	bgez	a5, .LBB28_15
.LBB28_16:
	li	a0, 1
	sub	a0, a0, a3
	sllw	a4, a4, a0
	blt	a3, a1, .LBB28_18
	j	.LBB28_7
.LBB28_17:
	addiw	a1, a1, -1
	slli	a2, a2, 1
	bge	a3, a1, .LBB28_20
.LBB28_18:
	subw	a5, a2, a4
	bltz	a5, .LBB28_17
	mv	a2, a5
	bnez	a5, .LBB28_17
	j	.LBB28_26
.LBB28_20:
	mv	a1, a3
	subw	a3, a2, a4
	bltz	a3, .LBB28_22
.LBB28_21:
	mv	a2, a3
	beqz	a3, .LBB28_26
.LBB28_22:
	srliw	a0, a2, 23
	lui	a3, 524288
	bnez	a0, .LBB28_24
.LBB28_23:
	srliw	a0, a2, 22
	slli	a2, a2, 1
	addiw	a1, a1, -1
	beqz	a0, .LBB28_23
.LBB28_24:
	and	a0, a6, a3
	blez	a1, .LBB28_27
	lui	a3, 1046528
	add	a2, a2, a3
	slli	a1, a1, 23
	or	a1, a1, a2
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.LBB28_26:
	fmv.w.x	fa5, zero
	fmul.s	fa0, fa0, fa5
	ret
.LBB28_27:
	li	a3, 1
	sub	a3, a3, a1
	srlw	a1, a2, a3
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ret
.Lfunc_end28:
	.size	fmodf, .Lfunc_end28-fmodf
	.cfi_endproc

	.section	.text.frexpf,"ax",@progbits
	.p2align	1
	.type	frexpf,@function
frexpf:
.Lfunc_begin29:
	.cfi_startproc
	fmv.x.w	a1, fa0
	srliw	a2, a1, 23
	zext.b	a2, a2
	li	a3, 255
	beq	a2, a3, .LBB29_5
	bnez	a2, .LBB29_4
	fmv.w.x	fa5, zero
	feq.s	a1, fa0, fa5
	bnez	a1, .LBB29_6
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)
	sd	s0, 0(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	lui	a1, 391168
	fmv.w.x	fa5, a1
	fmul.s	fa0, fa0, fa5
	mv	s0, a0
	call	frexpf
	mv	a0, s0
	lw	a1, 0(s0)
	addi	a1, a1, -64
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	sw	a1, 0(a0)
	ret
.LBB29_4:
	addi	a2, a2, -126
	sw	a2, 0(a0)
	lui	a0, 526336
	addi	a0, a0, -1
	and	a0, a0, a1
	lui	a1, 258048
	or	a0, a0, a1
	fmv.w.x	fa0, a0
.LBB29_5:
	ret
.LBB29_6:
	sw	zero, 0(a0)
	ret
.Lfunc_end29:
	.size	frexpf, .Lfunc_end29-frexpf
	.cfi_endproc

	.section	.text.ldexpf,"ax",@progbits
	.p2align	1
	.type	ldexpf,@function
ldexpf:
.Lfunc_begin30:
	.cfi_startproc
	sext.w	a1, a0
	li	a2, 128
	blt	a1, a2, .LBB30_6
	lui	a2, 520192
	sext.w	a1, a0
	fmv.w.x	fa5, a2
	li	a2, 255
	fmul.s	fa0, fa0, fa5
	bltu	a1, a2, .LBB30_11
	li	a0, 381
	bltu	a1, a0, .LBB30_4
	li	a1, 381
.LBB30_4:
	fmul.s	fa0, fa0, fa5
	addi	a0, a1, -254
.LBB30_5:
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.LBB30_6:
	li	a2, -127
	blt	a2, a1, .LBB30_5
	lui	a2, 51200
	fmv.w.x	fa5, a2
	li	a2, -229
	fmul.s	fa0, fa0, fa5
	bltu	a2, a1, .LBB30_12
	li	a0, -330
	bltu	a0, a1, .LBB30_10
	li	a1, -330
.LBB30_10:
	fmul.s	fa0, fa0, fa5
	addi	a0, a1, 204
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.LBB30_11:
	addi	a0, a0, -127
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.LBB30_12:
	addi	a0, a0, 102
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.Lfunc_end30:
	.size	ldexpf, .Lfunc_end30-ldexpf
	.cfi_endproc

	.section	.text.scalbnf,"ax",@progbits
	.p2align	1
	.type	scalbnf,@function
scalbnf:
.Lfunc_begin31:
	.cfi_startproc
	sext.w	a1, a0
	li	a2, 128
	blt	a1, a2, .LBB31_6
	lui	a2, 520192
	sext.w	a1, a0
	fmv.w.x	fa5, a2
	li	a2, 255
	fmul.s	fa0, fa0, fa5
	bltu	a1, a2, .LBB31_11
	li	a0, 381
	bltu	a1, a0, .LBB31_4
	li	a1, 381
.LBB31_4:
	fmul.s	fa0, fa0, fa5
	addi	a0, a1, -254
.LBB31_5:
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.LBB31_6:
	li	a2, -127
	blt	a2, a1, .LBB31_5
	lui	a2, 51200
	fmv.w.x	fa5, a2
	li	a2, -229
	fmul.s	fa0, fa0, fa5
	bltu	a2, a1, .LBB31_12
	li	a0, -330
	bltu	a0, a1, .LBB31_10
	li	a1, -330
.LBB31_10:
	fmul.s	fa0, fa0, fa5
	addi	a0, a1, 204
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.LBB31_11:
	addi	a0, a0, -127
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.LBB31_12:
	addi	a0, a0, 102
	slli	a0, a0, 23
	lui	a1, 260096
	add	a0, a0, a1
	fmv.w.x	fa5, a0
	fmul.s	fa0, fa0, fa5
	ret
.Lfunc_end31:
	.size	scalbnf, .Lfunc_end31-scalbnf
	.cfi_endproc

	.section	.text.powf,"ax",@progbits
	.p2align	1
	.type	powf,@function
powf:
.Lfunc_begin32:
	.cfi_startproc
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	.cfi_remember_state
	fmv.x.w	a1, fa0
	fmv.x.w	a0, fa1
	lui	a2, 526336
	add	a2, a2, a1
	srliw	a3, a2, 24
	li	a4, 129
	slliw	a2, a0, 1
	bltu	a3, a4, .LBB32_6
	lui	a3, 4096
	addw	a4, a2, a3
	bgeu	a3, a4, .LBB32_6
	li	a6, 0
.LBB32_3:
.Lpcrel_hi3:
	auipc	a2, %pcrel_hi(.promoted_doubles.powf)
	lui	a3, 789712
	lui	a4, 1046528
	li	a5, -1025
	slli	a5, a5, 52
	fmv.d.x	fa5, a5
.Lpcrel_hi4:
	auipc	a5, %pcrel_hi(__powf_log2_data)
	fcvt.d.s	fa4, fa1
	add	a3, a3, a1
	addi	a5, a5, %pcrel_lo(.Lpcrel_hi4)
	and	a4, a4, a3
	sub	a1, a1, a4
	srli	a4, a3, 15
	andi	a4, a4, 240
	add	a4, a4, a5
	lui	a5, 65535
	fmv.w.x	fa3, a1
	lui	a0, 16479
	addi	a1, a2, %pcrel_lo(.Lpcrel_hi3)
	slli	a5, a5, 35
	slli	a0, a0, 36
	fld	fa2, 32(a1)
	fld	fa1, 0(a1)
	fld	fa0, 8(a1)
	fld	ft0, 16(a1)
	fld	ft1, 24(a1)
	fld	ft2, 0(a4)
	sraiw	a2, a3, 23
	fld	ft3, 8(a4)
	fcvt.d.s	fa3, fa3
	fmadd.d	fa5, fa3, ft2, fa5
	fcvt.d.w	fa3, a2
	fadd.d	fa3, ft3, fa3
	fmul.d	ft2, fa5, fa5
	fmadd.d	fa1, fa5, fa1, fa0
	fmadd.d	fa0, fa5, ft0, ft1
	fmadd.d	fa5, fa5, fa2, fa3
	fmul.d	fa3, ft2, ft2
	fmadd.d	fa5, fa0, ft2, fa5
	fmadd.d	fa5, fa1, fa3, fa5
	fmul.d	fa5, fa5, fa4
	fmv.x.d	a2, fa5
	and	a2, a2, a5
	addi	a0, a0, 1
	bgeu	a2, a0, .LBB32_11
.LBB32_4:
	fld	fa4, 48(a1)
	fld	fa3, 56(a1)
	fld	fa2, 64(a1)
	lui	a0, 2141
	li	a1, -1955
.Lpcrel_hi5:
	auipc	a2, %pcrel_hi(__exp2f_data)
	slli	a0, a0, 39
	fmv.d.x	fa1, a0
	li	a0, 1023
	slli	a1, a1, 51
	addi	a2, a2, %pcrel_lo(.Lpcrel_hi5)
	slli	a0, a0, 52
	fmv.d.x	fa0, a1
	fadd.d	fa1, fa5, fa1
	fmv.x.d	a1, fa1
	fadd.d	fa1, fa1, fa0
	fmv.d.x	fa0, a0
	fsub.d	fa5, fa5, fa1
	andi	a0, a1, 31
	add	a1, a1, a6
	slli	a0, a0, 3
	slli	a1, a1, 47
	add	a0, a0, a2
	ld	a0, 0(a0)
	fmadd.d	fa4, fa5, fa4, fa3
	fmul.d	fa3, fa5, fa5
	fmadd.d	fa5, fa5, fa2, fa0
	add	a0, a0, a1
	fmv.d.x	fa2, a0
	fmadd.d	fa5, fa4, fa3, fa5
	fmul.d	fa5, fa5, fa2
	fcvt.s.d	fa5, fa5
.LBB32_5:
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_6:
	.cfi_restore_state
	.cfi_remember_state
	addiw	a4, a2, -1
	lui	a3, 1044480
	addi	a3, a3, -1
	bgeu	a4, a3, .LBB32_26
	slli	a2, a1, 1
	addiw	a2, a2, -1
	bgeu	a2, a3, .LBB32_32
	bltz	a1, .LBB32_15
	li	a6, 0
	srliw	a2, a1, 23
	bnez	a2, .LBB32_3
.LBB32_10:
	lui	a1, 307200
	fmv.w.x	fa5, a1
	fmul.s	fa5, fa0, fa5
	fmv.x.w	a1, fa5
	slli	a1, a1, 33
	srli	a1, a1, 33
	lui	a2, 1001472
	add	a1, a1, a2
	j	.LBB32_3
.LBB32_11:
	fld	fa4, 40(a1)
	flt.d	a0, fa4, fa5
	beqz	a0, .LBB32_19
	lui	a0, 458752
	fmv.w.x	fa5, a0
	fmv.s	fa4, fa5
	beqz	a6, .LBB32_14
	lui	a0, 983040
	fmv.w.x	fa4, a0
.LBB32_14:
	fsw	fa4, 8(sp)
	flw	fa4, 8(sp)
	fmul.s	fa5, fa4, fa5
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_15:
	.cfi_restore_state
	.cfi_remember_state
	slli	a2, a0, 33
	srli	a2, a2, 56
	li	a3, 127
	bltu	a2, a3, .LBB32_24
	li	a3, 150
	bgeu	a3, a2, .LBB32_23
.LBB32_17:
	li	a6, 0
.LBB32_18:
	slli	a1, a1, 33
	srli	a1, a1, 33
	srliw	a2, a1, 23
	bnez	a2, .LBB32_3
	j	.LBB32_10
.LBB32_19:
	lui	a0, 983435
	slli	a0, a0, 34
	fmv.d.x	fa4, a0
	fle.d	a0, fa5, fa4
	beqz	a0, .LBB32_4
	lui	a0, 65536
	fmv.w.x	fa5, a0
	fmv.s	fa4, fa5
	beqz	a6, .LBB32_22
	lui	a0, 589824
	fmv.w.x	fa4, a0
.LBB32_22:
	fsw	fa4, 12(sp)
	flw	fa4, 12(sp)
	fmul.s	fa5, fa4, fa5
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_23:
	.cfi_restore_state
	.cfi_remember_state
	sub	a3, a3, a2
	li	a2, 1
	sllw	a2, a2, a3
	addiw	a3, a2, -1
	and	a3, a3, a0
	beqz	a3, .LBB32_25
.LBB32_24:
	fsub.s	fa5, fa0, fa0
	fdiv.s	fa5, fa5, fa5
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_25:
	.cfi_restore_state
	.cfi_remember_state
	and	a2, a2, a0
	lui	a6, 16
	bnez	a2, .LBB32_18
	j	.LBB32_17
.LBB32_26:
	lui	a3, 260096
	fmv.w.x	fa5, a3
	beq	a1, a3, .LBB32_5
	beqz	a2, .LBB32_5
	slliw	a1, a1, 1
	lui	a3, 1044480
	bltu	a3, a1, .LBB32_38
	addi	a3, a3, 1
	bgeu	a2, a3, .LBB32_38
	lui	a2, 520192
	bne	a1, a2, .LBB32_39
	lui	a0, 260096
	fmv.w.x	fa5, a0
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_32:
	.cfi_restore_state
	.cfi_remember_state
	fmul.s	fa5, fa0, fa0
	bgez	a1, .LBB32_36
	slli	a1, a0, 33
	srli	a1, a1, 56
	addi	a2, a1, -151
	li	a3, -24
	bltu	a2, a3, .LBB32_36
	li	a2, 150
	sub	a2, a2, a1
	li	a1, 1
	sllw	a1, a1, a2
	addiw	a2, a1, -1
	and	a1, a1, a0
	and	a2, a2, a0
	snez	a2, a2
	seqz	a1, a1
	or	a1, a1, a2
	bnez	a1, .LBB32_36
	fneg.s	fa5, fa5
.LBB32_36:
	bgez	a0, .LBB32_5
	lui	a0, 260096
	fmv.w.x	fa4, a0
	fdiv.s	fa5, fa4, fa5
	fsw	fa5, 4(sp)
	flw	fa5, 4(sp)
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_38:
	.cfi_restore_state
	.cfi_remember_state
	fadd.s	fa5, fa0, fa1
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_39:
	.cfi_restore_state
	.cfi_remember_state
	srliw	a1, a1, 24
	sltiu	a1, a1, 127
	srli	a0, a0, 63
	bne	a1, a0, .LBB32_41
	fmul.s	fa5, fa1, fa1
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB32_41:
	.cfi_restore_state
	fmv.w.x	fa5, zero
	fmv.s	fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end32:
	.size	powf, .Lfunc_end32-powf
	.cfi_endproc

	.section	.text.rintf,"ax",@progbits
	.p2align	1
	.type	rintf,@function
rintf:
.Lfunc_begin33:
	.cfi_startproc
	fmv.x.w	a0, fa0
	lui	a1, 520192
	and	a1, a1, a0
	lui	a2, 305152
	bltu	a2, a1, .LBB33_3
	lui	a1, 831488
	fmv.w.x	fa5, a1
	lui	a1, 307200
	fmv.w.x	fa4, a1
	bgez	a0, .LBB33_4
	fadd.s	fa5, fa0, fa5
	fadd.s	fa0, fa5, fa4
	fmv.w.x	fa5, zero
	feq.s	a1, fa0, fa5
	bnez	a1, .LBB33_5
.LBB33_3:
	ret
.LBB33_4:
	fadd.s	fa4, fa0, fa4
	fadd.s	fa0, fa4, fa5
	fmv.w.x	fa5, zero
	feq.s	a1, fa0, fa5
	beqz	a1, .LBB33_3
.LBB33_5:
	bgez	a0, .LBB33_7
	lui	a0, 524288
	fmv.w.x	fa5, a0
.LBB33_7:
	fmv.s	fa0, fa5
	ret
.Lfunc_end33:
	.size	rintf, .Lfunc_end33-rintf
	.cfi_endproc

	.section	.text.roundf,"ax",@progbits
	.p2align	1
	.type	roundf,@function
roundf:
.Lfunc_begin34:
	.cfi_startproc
	fmv.x.w	a0, fa0
	slli	a1, a0, 33
	srli	a1, a1, 56
	li	a2, 149
	bgeu	a2, a1, .LBB34_2
.LBB34_1:
	ret
.LBB34_2:
	fabs.s	fa5, fa0
	lui	a2, 307200
	fmv.w.x	fa4, a2
	li	a2, 125
	fadd.s	fa4, fa5, fa4
	bltu	a2, a1, .LBB34_4
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	fsw	fa4, 12(sp)
	fmv.w.x	fa5, zero
	fmul.s	fa0, fa0, fa5
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.LBB34_4:
	lui	a1, 831488
	fmv.w.x	fa3, a1
	lui	a1, 258048
	fadd.s	fa4, fa4, fa3
	fsub.s	fa4, fa4, fa5
	fmv.w.x	fa3, a1
	flt.s	a1, fa3, fa4
	beqz	a1, .LBB34_6
	fadd.s	fa5, fa5, fa4
	lui	a1, 784384
	fmv.w.x	fa4, a1
	fadd.s	fa0, fa5, fa4
	j	.LBB34_8
.LBB34_6:
	lui	a1, 782336
	fmv.w.x	fa3, a1
	fle.s	a1, fa4, fa3
	fadd.s	fa0, fa5, fa4
	beqz	a1, .LBB34_8
	lui	a1, 260096
	fmv.w.x	fa5, a1
	fadd.s	fa0, fa0, fa5
.LBB34_8:
	bgez	a0, .LBB34_1
	fneg.s	fa0, fa0
	ret
.Lfunc_end34:
	.size	roundf, .Lfunc_end34-roundf
	.cfi_endproc

	.type	__unnamed_1,@object
	.section	.rodata.__unnamed_1,"a",@progbits
__unnamed_1:
	.asciz	"matmul_q_i8_linked"
	.size	__unnamed_1, 19

	.type	iree_hal_executable_library_query_v0_header,@object
	.section	.data.rel.ro.iree_hal_executable_library_query_v0_header,"aw",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0_header:
	.word	6
	.zero	4
	.quad	__unnamed_1
	.word	0
	.word	0
	.size	iree_hal_executable_library_query_v0_header, 24

	.type	iree_hal_executable_library_query_v0_funcs,@object
	.section	.data.rel.ro.iree_hal_executable_library_query_v0_funcs,"aw",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0_funcs:
	.quad	matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32
	.quad	_encoding_0_encode_32x64xi8_to_32x64xi8
	.quad	_encoding_1_encode_64x32xi8_to_64x32xi8
	.size	iree_hal_executable_library_query_v0_funcs, 24

	.type	iree_hal_executable_library_query_v0_attrs,@object
	.section	.rodata.iree_hal_executable_library_query_v0_attrs,"a",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0_attrs:
	.quad	0
	.half	0
	.byte	0
	.byte	2
	.word	1
	.word	1
	.half	1
	.half	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.half	0
	.byte	0
	.byte	2
	.word	1
	.word	1
	.half	1
	.half	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.half	0
	.byte	0
	.byte	2
	.word	1
	.word	1
	.half	1
	.half	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.size	iree_hal_executable_library_query_v0_attrs, 192

	.type	__unnamed_2,@object
	.section	.rodata.__unnamed_2,"a",@progbits
__unnamed_2:
	.asciz	"matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32"
	.size	__unnamed_2, 57

	.type	__unnamed_3,@object
	.section	.rodata.__unnamed_3,"a",@progbits
__unnamed_3:
	.asciz	"_encoding_0_encode_32x64xi8_to_32x64xi8"
	.size	__unnamed_3, 40

	.type	__unnamed_4,@object
	.section	.rodata.__unnamed_4,"a",@progbits
__unnamed_4:
	.asciz	"_encoding_1_encode_64x32xi8_to_64x32xi8"
	.size	__unnamed_4, 40

	.type	iree_hal_executable_library_query_v0_names,@object
	.section	.data.rel.ro.iree_hal_executable_library_query_v0_names,"aw",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0_names:
	.quad	__unnamed_2
	.quad	__unnamed_3
	.quad	__unnamed_4
	.size	iree_hal_executable_library_query_v0_names, 24

	.type	__unnamed_5,@object
	.section	.rodata.__unnamed_5,"a",@progbits
__unnamed_5:
	.asciz	"tests/e2e/SpacemiT/matmul_q_i8.mlir"
	.size	__unnamed_5, 36

	.type	__unnamed_6,@object
	.section	.rodata.__unnamed_6,"a",@progbits
__unnamed_6:
	.asciz	"tests/e2e/SpacemiT/matmul_q_i8.mlir"
	.size	__unnamed_6, 36

	.type	__unnamed_7,@object
	.section	.rodata.__unnamed_7,"a",@progbits
__unnamed_7:
	.asciz	"tests/e2e/SpacemiT/matmul_q_i8.mlir"
	.size	__unnamed_7, 36

	.type	iree_hal_executable_library_query_v0_source_locations,@object
	.section	.data.rel.ro.iree_hal_executable_library_query_v0_source_locations,"aw",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0_source_locations:
	.word	1
	.word	35
	.quad	__unnamed_5
	.word	1
	.word	35
	.quad	__unnamed_6
	.word	1
	.word	35
	.quad	__unnamed_7
	.size	iree_hal_executable_library_query_v0_source_locations, 48

	.type	iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names,@object
	.section	.rodata.iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names,"a",@progbits
	.p2align	3, 0x0
iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names:
	.size	iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names, 0

	.type	iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations,@object
	.section	.rodata.iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations,"a",@progbits
	.p2align	3, 0x0
iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations:
	.size	iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations, 0

	.type	iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names,@object
	.section	.rodata.iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names,"a",@progbits
	.p2align	3, 0x0
iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names:
	.size	iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names, 0

	.type	iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations,@object
	.section	.rodata.iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations,"a",@progbits
	.p2align	3, 0x0
iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations:
	.size	iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations, 0

	.type	iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names,@object
	.section	.rodata.iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names,"a",@progbits
	.p2align	3, 0x0
iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names:
	.size	iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names, 0

	.type	iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations,@object
	.section	.rodata.iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations,"a",@progbits
	.p2align	3, 0x0
iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations:
	.size	iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations, 0

	.type	iree_hal_executable_library_query_v0_stage_location_tables,@object
	.section	.data.rel.ro.iree_hal_executable_library_query_v0_stage_location_tables,"aw",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0_stage_location_tables:
	.word	0
	.zero	4
	.quad	iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names
	.quad	iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations
	.word	0
	.zero	4
	.quad	iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names
	.quad	iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations
	.word	0
	.zero	4
	.quad	iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names
	.quad	iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations
	.size	iree_hal_executable_library_query_v0_stage_location_tables, 72

	.type	iree_hal_executable_library_query_v0,@object
	.section	.data.rel.ro.iree_hal_executable_library_query_v0,"aw",@progbits
	.p2align	4, 0x0
iree_hal_executable_library_query_v0:
	.quad	iree_hal_executable_library_query_v0_header
	.zero	16
	.word	3
	.zero	4
	.quad	iree_hal_executable_library_query_v0_funcs
	.quad	iree_hal_executable_library_query_v0_attrs
	.quad	0
	.quad	0
	.quad	iree_hal_executable_library_query_v0_names
	.quad	0
	.quad	0
	.quad	iree_hal_executable_library_query_v0_source_locations
	.quad	iree_hal_executable_library_query_v0_stage_location_tables
	.zero	4
	.zero	4
	.zero	16
	.size	iree_hal_executable_library_query_v0, 128

	.type	__exp2f_data,@object
	.section	.rodata.__exp2f_data,"a",@progbits
	.p2align	3, 0x0
__exp2f_data:
	.quad	4607182418800017408
	.quad	4607140297302181236
	.quad	4607100335213349135
	.quad	4607062579818421073
	.quad	4607027079437701499
	.quad	4606993883449571754
	.quad	4606963042313658936
	.quad	4606934607594512097
	.quad	4606908631985796885
	.quad	4606885169335019979
	.quad	4606864274668794914
	.quad	4606846004218661165
	.quad	4606830415447468583
	.quad	4606817567076339586
	.quad	4606807519112221737
	.quad	4606800332876043653
	.quad	4606796071031487437
	.quad	4606794797614391156
	.quad	4606796578062795143
	.quad	4606801479247646227
	.quad	4606809569504174299
	.quad	4606820918663955941
	.quad	4606835598087680144
	.quad	4606853680698631517
	.quad	4606875241016906669
	.quad	4606900355194379847
	.quad	4606929101050434204
	.quad	4606961558108475497
	.quad	4606997807633245319
	.quad	4607037932668951391
	.quad	4607082018078232794
	.quad	4607130150581978432
	.quad	0x42e8000000000000
	.quad	0x3fac6af84b912394
	.quad	0x3fcebfce50fac4f3
	.quad	0x3fe62e42ff0c52d6
	.quad	0x4338000000000000
	.quad	0x40471547652b82fe
	.quad	0x3ebc6af84b912394
	.quad	0x3f2ebfce50fac4f3
	.quad	0x3f962e42ff0c52d6
	.size	__exp2f_data, 328

	.type	__powf_log2_data,@object
	.section	.rodata.__powf_log2_data,"a",@progbits
	.p2align	3, 0x0
__powf_log2_data:
	.quad	0x3ff661ec79f8f3be
	.quad	0xbfdefec65b963019
	.quad	0x3ff571ed4aaf883d
	.quad	0xbfdb0b6832d4fca4
	.quad	0x3ff49539f0f010b0
	.quad	0xbfd7418b0a1fb77b
	.quad	0x3ff3c995b0b80385
	.quad	0xbfd39de91a6dcf7b
	.quad	0x3ff30d190c8864a5
	.quad	0xbfd01d9bf3f2b631
	.quad	0x3ff25e227b0b8ea0
	.quad	0xbfc97c1d1b3b7af0
	.quad	0x3ff1bb4a4a1a343f
	.quad	0xbfc2f9e393af3c9f
	.quad	0x3ff12358f08ae5ba
	.quad	0xbfb960cbbf788d5c
	.quad	0x3ff0953f419900a7
	.quad	0xbfaa6f9db6475fce
	.quad	0x3ff0000000000000
	.quad	0x0000000000000000
	.quad	0x3fee608cfd9a47ac
	.quad	0x3fb338ca9f24f53d
	.quad	0x3feca4b31f026aa0
	.quad	0x3fc476a9543891ba
	.quad	0x3feb2036576afce6
	.quad	0x3fce840b4ac4e4d2
	.quad	0x3fe9c2d163a1aa2d
	.quad	0x3fd40645f0c6651c
	.quad	0x3fe886e6037841ed
	.quad	0x3fd88e9c2c1b9ff8
	.quad	0x3fe767dcf5534862
	.quad	0x3fdce0a44eb17bcc
	.quad	0x3fd27616c9496e0b
	.quad	0xbfd71969a075c67a
	.quad	0x3fdec70a6ca7badd
	.quad	0xbfe7154748bef6c8
	.quad	0x3ff71547652ab82b
	.size	__powf_log2_data, 296

	.type	.promoted_doubles.expf,@object
	.section	.rodata..promoted_doubles.expf,"a",@progbits
	.p2align	4, 0x0
.promoted_doubles.expf:
	.quad	0x40471547652b82fe
	.quad	0x3ebc6af84b912394
	.quad	0x3f2ebfce50fac4f3
	.quad	0x3f962e42ff0c52d6
	.size	.promoted_doubles.expf, 32

	.type	.promoted_doubles.powf,@object
	.section	.rodata..promoted_doubles.powf,"a",@progbits
	.p2align	4, 0x0
.promoted_doubles.powf:
	.quad	0x3fd27616c9496e0b
	.quad	0xbfd71969a075c67a
	.quad	0x3fdec70a6ca7badd
	.quad	0xbfe7154748bef6c8
	.quad	0x3ff71547652ab82b
	.quad	0x405fffffffd1d571
	.quad	0x3fac6af84b912394
	.quad	0x3fcebfce50fac4f3
	.quad	0x3fe62e42ff0c52d6
	.size	.promoted_doubles.powf, 72

	.section	.debug_abbrev,"",@progbits
	.byte	1
	.byte	17
	.byte	1
	.byte	37
	.byte	14
	.byte	19
	.byte	5
	.byte	3
	.byte	14
	.byte	16
	.byte	23
	.ascii	"\264B"
	.byte	25
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	0
	.byte	0
	.byte	2
	.byte	46
	.byte	0
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.byte	110
	.byte	14
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	73
	.byte	19
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	3
	.byte	36
	.byte	0
	.byte	3
	.byte	14
	.byte	62
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	4
	.byte	46
	.byte	0
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.byte	110
	.byte	14
	.byte	3
	.byte	14
	.byte	58
	.byte	11
	.byte	59
	.byte	11
	.byte	73
	.byte	16
	.byte	63
	.byte	25
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0
.Ldebug_info_start0:
	.half	4
	.word	.debug_abbrev
	.byte	8
	.byte	1
	.word	.Linfo_string0
	.half	44
	.word	.Linfo_string1
	.word	.Lline_table_start0

	.quad	.Lfunc_begin0
	.word	.Lfunc_end0-.Lfunc_begin0
	.byte	2
	.quad	.Lfunc_begin0
	.word	.Lfunc_end0-.Lfunc_begin0
	.byte	1
	.byte	88
	.word	.Linfo_string2
	.word	.Linfo_string2
	.byte	1
	.byte	1
	.word	67

	.byte	3
	.word	.Linfo_string3
	.byte	5
	.byte	4
	.byte	0
.Ldebug_info_end0:
.Lcu_begin1:
	.word	.Ldebug_info_end1-.Ldebug_info_start1
.Ldebug_info_start1:
	.half	4
	.word	.debug_abbrev
	.byte	8
	.byte	1
	.word	.Linfo_string0
	.half	44
	.word	.Linfo_string1
	.word	.Lline_table_start0

	.quad	.Lfunc_begin1
	.word	.Lfunc_end1-.Lfunc_begin1
	.byte	4
	.quad	.Lfunc_begin1
	.word	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	88
	.word	.Linfo_string4
	.word	.Linfo_string4
	.byte	1
	.byte	1
	.word	.debug_info+67

	.byte	0
.Ldebug_info_end1:
.Lcu_begin2:
	.word	.Ldebug_info_end2-.Ldebug_info_start2
.Ldebug_info_start2:
	.half	4
	.word	.debug_abbrev
	.byte	8
	.byte	1
	.word	.Linfo_string0
	.half	44
	.word	.Linfo_string1
	.word	.Lline_table_start0

	.quad	.Lfunc_begin2
	.word	.Lfunc_end2-.Lfunc_begin2
	.byte	4
	.quad	.Lfunc_begin2
	.word	.Lfunc_end2-.Lfunc_begin2
	.byte	1
	.byte	88
	.word	.Linfo_string5
	.word	.Linfo_string5
	.byte	1
	.byte	1
	.word	.debug_info+67

	.byte	0
.Ldebug_info_end2:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"IREE"
.Linfo_string1:
	.asciz	"-"
.Linfo_string2:
	.asciz	"matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32"
.Linfo_string3:
	.asciz	"int"
.Linfo_string4:
	.asciz	"_encoding_0_encode_32x64xi8_to_32x64xi8"
.Linfo_string5:
	.asciz	"_encoding_1_encode_64x32xi8_to_64x32xi8"
	.section	.debug_pubnames,"",@progbits
	.word	.LpubNames_end0-.LpubNames_start0
.LpubNames_start0:
	.half	2
	.word	.Lcu_begin0
	.word	75
	.word	38
	.asciz	"matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32"
	.word	0
.LpubNames_end0:
	.section	.debug_pubtypes,"",@progbits
	.word	.LpubTypes_end0-.LpubTypes_start0
.LpubTypes_start0:
	.half	2
	.word	.Lcu_begin0
	.word	75
	.word	67
	.asciz	"int"
	.word	0
.LpubTypes_end0:
	.section	.debug_pubnames,"",@progbits
	.word	.LpubNames_end1-.LpubNames_start1
.LpubNames_start1:
	.half	2
	.word	.Lcu_begin1
	.word	68
	.word	38
	.asciz	"_encoding_0_encode_32x64xi8_to_32x64xi8"
	.word	0
.LpubNames_end1:
	.section	.debug_pubtypes,"",@progbits
	.word	.LpubTypes_end1-.LpubTypes_start1
.LpubTypes_start1:
	.half	2
	.word	.Lcu_begin1
	.word	68
	.word	0
.LpubTypes_end1:
	.section	.debug_pubnames,"",@progbits
	.word	.LpubNames_end2-.LpubNames_start2
.LpubNames_start2:
	.half	2
	.word	.Lcu_begin2
	.word	68
	.word	38
	.asciz	"_encoding_1_encode_64x32xi8_to_64x32xi8"
	.word	0
.LpubNames_end2:
	.section	.debug_pubtypes,"",@progbits
	.word	.LpubTypes_end2-.LpubTypes_start2
.LpubTypes_start2:
	.half	2
	.word	.Lcu_begin2
	.word	68
	.word	0
.LpubTypes_end2:
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
