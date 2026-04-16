; ModuleID = 'matmul_q_i8_linked'
source_filename = "matmul_q_i8_linked"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown-eabi-elf"

%iree_hal_executable_library_header_t = type { i32, ptr, i32, i32 }
%iree_hal_executable_dispatch_attrs_v0_t = type { i64, i16, i8, i8, i32, i32, i16, i16, i64, i64, i64, i64, i64 }
%iree_hal_executable_source_location_v0_t = type { i32, i32, ptr }
%iree_hal_executable_stage_location_table_v0_t = type { i32, ptr, ptr }
%iree_hal_executable_library_v0_t = type { ptr, %iree_hal_executable_import_table_v0_t, %iree_hal_executable_export_table_v0_t, %iree_hal_executable_constant_table_v0_t, %iree_hal_executable_source_file_table_v0_t }
%iree_hal_executable_import_table_v0_t = type { i32, ptr }
%iree_hal_executable_export_table_v0_t = type { i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr }
%iree_hal_executable_constant_table_v0_t = type { i32 }
%iree_hal_executable_source_file_table_v0_t = type { i32, ptr }
%struct.exp2f_data = type { [32 x i64], double, [3 x double], double, double, [3 x double] }
%struct.powf_log2_data = type { [16 x %struct.anon], [5 x double] }
%struct.anon = type { double, double }

@0 = internal constant [19 x i8] c"matmul_q_i8_linked\00", align 1
@iree_hal_executable_library_query_v0_header = internal constant %iree_hal_executable_library_header_t { i32 6, ptr @0, i32 0, i32 0 }
@iree_hal_executable_library_query_v0_funcs = internal constant [3 x ptr] [ptr @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32, ptr @_encoding_0_encode_32x64xi8_to_32x64xi8, ptr @_encoding_1_encode_64x32xi8_to_64x32xi8]
@iree_hal_executable_library_query_v0_attrs = internal constant [3 x %iree_hal_executable_dispatch_attrs_v0_t] [%iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }, %iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }, %iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }]
@1 = internal constant [57 x i8] c"matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32\00", align 1
@2 = internal constant [40 x i8] c"_encoding_0_encode_32x64xi8_to_32x64xi8\00", align 1
@3 = internal constant [40 x i8] c"_encoding_1_encode_64x32xi8_to_64x32xi8\00", align 1
@iree_hal_executable_library_query_v0_names = internal constant [3 x ptr] [ptr @1, ptr @2, ptr @3]
@4 = internal constant [148 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files/configured_module_matmul_i8_quantized_dispatch_0.mlir\00", align 1
@5 = internal constant [129 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files/configured_module__encoding_0.mlir\00", align 1
@6 = internal constant [129 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files/configured_module__encoding_1.mlir\00", align 1
@iree_hal_executable_library_query_v0_source_locations = internal constant [3 x %iree_hal_executable_source_location_v0_t] [%iree_hal_executable_source_location_v0_t { i32 3, i32 147, ptr @4 }, %iree_hal_executable_source_location_v0_t { i32 3, i32 128, ptr @5 }, %iree_hal_executable_source_location_v0_t { i32 3, i32 128, ptr @6 }]
@iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names = internal constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations = internal constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names = internal constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations = internal constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names = internal constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations = internal constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0_stage_location_tables = internal constant [3 x %iree_hal_executable_stage_location_table_v0_t] [%iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names, ptr @iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations }]
@iree_hal_executable_library_query_v0 = internal constant %iree_hal_executable_library_v0_t { ptr @iree_hal_executable_library_query_v0_header, %iree_hal_executable_import_table_v0_t zeroinitializer, %iree_hal_executable_export_table_v0_t { i32 3, ptr @iree_hal_executable_library_query_v0_funcs, ptr @iree_hal_executable_library_query_v0_attrs, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_names, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_source_locations, ptr @iree_hal_executable_library_query_v0_stage_location_tables }, %iree_hal_executable_constant_table_v0_t zeroinitializer, %iree_hal_executable_source_file_table_v0_t zeroinitializer }
@__exp2f_data = internal local_unnamed_addr constant %struct.exp2f_data { [32 x i64] [i64 4607182418800017408, i64 4607140297302181236, i64 4607100335213349135, i64 4607062579818421073, i64 4607027079437701499, i64 4606993883449571754, i64 4606963042313658936, i64 4606934607594512097, i64 4606908631985796885, i64 4606885169335019979, i64 4606864274668794914, i64 4606846004218661165, i64 4606830415447468583, i64 4606817567076339586, i64 4606807519112221737, i64 4606800332876043653, i64 4606796071031487437, i64 4606794797614391156, i64 4606796578062795143, i64 4606801479247646227, i64 4606809569504174299, i64 4606820918663955941, i64 4606835598087680144, i64 4606853680698631517, i64 4606875241016906669, i64 4606900355194379847, i64 4606929101050434204, i64 4606961558108475497, i64 4606997807633245319, i64 4607037932668951391, i64 4607082018078232794, i64 4607130150581978432], double 0x42E8000000000000, [3 x double] [double 0x3FAC6AF84B912394, double 0x3FCEBFCE50FAC4F3, double 0x3FE62E42FF0C52D6], double 0x4338000000000000, double 0x40471547652B82FE, [3 x double] [double 0x3EBC6AF84B912394, double 0x3F2EBFCE50FAC4F3, double 0x3F962E42FF0C52D6] }, align 8
@__powf_log2_data = internal local_unnamed_addr constant %struct.powf_log2_data { [16 x %struct.anon] [%struct.anon { double 0x3FF661EC79F8F3BE, double 0xBFDEFEC65B963019 }, %struct.anon { double 0x3FF571ED4AAF883D, double 0xBFDB0B6832D4FCA4 }, %struct.anon { double 0x3FF49539F0F010B0, double 0xBFD7418B0A1FB77B }, %struct.anon { double 0x3FF3C995B0B80385, double 0xBFD39DE91A6DCF7B }, %struct.anon { double 0x3FF30D190C8864A5, double 0xBFD01D9BF3F2B631 }, %struct.anon { double 0x3FF25E227B0B8EA0, double 0xBFC97C1D1B3B7AF0 }, %struct.anon { double 0x3FF1BB4A4A1A343F, double 0xBFC2F9E393AF3C9F }, %struct.anon { double 0x3FF12358F08AE5BA, double 0xBFB960CBBF788D5C }, %struct.anon { double 0x3FF0953F419900A7, double 0xBFAA6F9DB6475FCE }, %struct.anon { double 1.000000e+00, double 0.000000e+00 }, %struct.anon { double 0x3FEE608CFD9A47AC, double 0x3FB338CA9F24F53D }, %struct.anon { double 0x3FECA4B31F026AA0, double 0x3FC476A9543891BA }, %struct.anon { double 0x3FEB2036576AFCE6, double 0x3FCE840B4AC4E4D2 }, %struct.anon { double 0x3FE9C2D163A1AA2D, double 0x3FD40645F0C6651C }, %struct.anon { double 0x3FE886E6037841ED, double 0x3FD88E9C2C1B9FF8 }, %struct.anon { double 0x3FE767DCF5534862, double 0x3FDCE0A44EB17BCC }], [5 x double] [double 0x3FD27616C9496E0B, double 0xBFD71969A075C67A, double 0x3FDEC70A6CA7BADD, double 0xBFE7154748BEF6C8, double 0x3FF71547652AB82B] }, align 8

; Function Attrs: nounwind
define internal noundef i32 @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(ptr noalias nonnull readnone align 16 captures(none) %0, ptr noalias noundef nonnull readonly align 16 captures(none) %1, ptr noalias noundef nonnull readonly align 16 captures(none) %2) #0 !dbg !12 {
  %.elt19 = getelementptr inbounds nuw i8, ptr %1, i64 32, !dbg !88
  %.unpack20 = load ptr, ptr %.elt19, align 16, !dbg !88
  %4 = load ptr, ptr %.unpack20, align 8, !dbg !88
  call void @llvm.assume(i1 true) [ "align"(ptr %4, i64 64) ], !dbg !88
  %5 = getelementptr i8, ptr %4, i64 2048, !dbg !89
  call void @llvm.assume(i1 true) [ "align"(ptr %5, i64 64) ], !dbg !89
  %6 = getelementptr i8, ptr %.unpack20, i64 8, !dbg !90
  %7 = load ptr, ptr %6, align 8, !dbg !90
  call void @llvm.assume(i1 true) [ "align"(ptr %7, i64 64) ], !dbg !90
  %8 = load i32, ptr %2, align 16, !dbg !91
  %9 = zext i32 %8 to i64, !dbg !91
  %10 = lshr i64 %9, 1, !dbg !91
  %11 = and i64 %9, 1, !dbg !91
  %12 = shl nuw nsw i64 %10, 10
  %13 = getelementptr i8, ptr %4, i64 %12
  %14 = shl nuw nsw i64 %11, 10
  %15 = getelementptr i8, ptr %5, i64 %14
  %16 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> zeroinitializer, i64 0)
  br label %17, !dbg !91

17:                                               ; preds = %3, %17
  %18 = phi [16 x <16 x i32>] [ zeroinitializer, %3 ], [ %106, %17 ]
  %19 = phi i64 [ 0, %3 ], [ %107, %17 ]
  %20 = shl nuw nsw i64 %19, 4, !dbg !91
  %21 = getelementptr i8, ptr %13, i64 %20, !dbg !91
  %22 = load <16 x i8>, ptr %21, align 16, !dbg !91
  %23 = getelementptr i8, ptr %15, i64 %20, !dbg !91
  %24 = load <16 x i8>, ptr %23, align 16, !dbg !91
  %25 = extractvalue [16 x <16 x i32>] %18, 0
  %26 = extractvalue [16 x <16 x i32>] %18, 1
  %27 = extractvalue [16 x <16 x i32>] %18, 2
  %28 = extractvalue [16 x <16 x i32>] %18, 3
  %29 = extractvalue [16 x <16 x i32>] %18, 4
  %30 = extractvalue [16 x <16 x i32>] %18, 5
  %31 = extractvalue [16 x <16 x i32>] %18, 6
  %32 = extractvalue [16 x <16 x i32>] %18, 7
  %33 = extractvalue [16 x <16 x i32>] %18, 8
  %34 = extractvalue [16 x <16 x i32>] %18, 9
  %35 = extractvalue [16 x <16 x i32>] %18, 10
  %36 = extractvalue [16 x <16 x i32>] %18, 11
  %37 = extractvalue [16 x <16 x i32>] %18, 12
  %38 = extractvalue [16 x <16 x i32>] %18, 13
  %39 = extractvalue [16 x <16 x i32>] %18, 14
  %40 = extractvalue [16 x <16 x i32>] %18, 15
  %41 = tail call <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v16i8(<vscale x 8 x i8> undef, <16 x i8> %22, i64 0)
  %42 = tail call <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v16i8(<vscale x 8 x i8> undef, <16 x i8> %24, i64 0)
  tail call void @llvm.riscv.opu.bcast.nxv8i32.i64(<vscale x 8 x i32> %16, i64 16)
  %43 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %25, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 0, <vscale x 8 x i32> %43, i64 16)
  %44 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %26, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 1, <vscale x 8 x i32> %44, i64 16)
  %45 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %27, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 2, <vscale x 8 x i32> %45, i64 16)
  %46 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %28, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 3, <vscale x 8 x i32> %46, i64 16)
  %47 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %29, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 4, <vscale x 8 x i32> %47, i64 16)
  %48 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %30, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 5, <vscale x 8 x i32> %48, i64 16)
  %49 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %31, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 6, <vscale x 8 x i32> %49, i64 16)
  %50 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %32, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 7, <vscale x 8 x i32> %50, i64 16)
  %51 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %33, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 8, <vscale x 8 x i32> %51, i64 16)
  %52 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %34, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 9, <vscale x 8 x i32> %52, i64 16)
  %53 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %35, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 10, <vscale x 8 x i32> %53, i64 16)
  %54 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %36, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 11, <vscale x 8 x i32> %54, i64 16)
  %55 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %37, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 12, <vscale x 8 x i32> %55, i64 16)
  %56 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %38, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 13, <vscale x 8 x i32> %56, i64 16)
  %57 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %39, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 14, <vscale x 8 x i32> %57, i64 16)
  %58 = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %40, i64 0)
  tail call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 15, <vscale x 8 x i32> %58, i64 16)
  tail call void @llvm.riscv.opu.vopacc.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> %41, <vscale x 8 x i8> %42, i64 16)
  %59 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 0, i64 16)
  %60 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %59, i64 0)
  %61 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 1, i64 16)
  %62 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %61, i64 0)
  %63 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 2, i64 16)
  %64 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %63, i64 0)
  %65 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 3, i64 16)
  %66 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %65, i64 0)
  %67 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 4, i64 16)
  %68 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %67, i64 0)
  %69 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 5, i64 16)
  %70 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %69, i64 0)
  %71 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 6, i64 16)
  %72 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %71, i64 0)
  %73 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 7, i64 16)
  %74 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %73, i64 0)
  %75 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 8, i64 16)
  %76 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %75, i64 0)
  %77 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 9, i64 16)
  %78 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %77, i64 0)
  %79 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 10, i64 16)
  %80 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %79, i64 0)
  %81 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 11, i64 16)
  %82 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %81, i64 0)
  %83 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 12, i64 16)
  %84 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %83, i64 0)
  %85 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 13, i64 16)
  %86 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %85, i64 0)
  %87 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 14, i64 16)
  %88 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %87, i64 0)
  %89 = tail call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 15, i64 16)
  %90 = tail call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %89, i64 0)
  %91 = insertvalue [16 x <16 x i32>] poison, <16 x i32> %60, 0
  %92 = insertvalue [16 x <16 x i32>] %91, <16 x i32> %62, 1
  %93 = insertvalue [16 x <16 x i32>] %92, <16 x i32> %64, 2
  %94 = insertvalue [16 x <16 x i32>] %93, <16 x i32> %66, 3
  %95 = insertvalue [16 x <16 x i32>] %94, <16 x i32> %68, 4
  %96 = insertvalue [16 x <16 x i32>] %95, <16 x i32> %70, 5
  %97 = insertvalue [16 x <16 x i32>] %96, <16 x i32> %72, 6
  %98 = insertvalue [16 x <16 x i32>] %97, <16 x i32> %74, 7
  %99 = insertvalue [16 x <16 x i32>] %98, <16 x i32> %76, 8
  %100 = insertvalue [16 x <16 x i32>] %99, <16 x i32> %78, 9
  %101 = insertvalue [16 x <16 x i32>] %100, <16 x i32> %80, 10
  %102 = insertvalue [16 x <16 x i32>] %101, <16 x i32> %82, 11
  %103 = insertvalue [16 x <16 x i32>] %102, <16 x i32> %84, 12
  %104 = insertvalue [16 x <16 x i32>] %103, <16 x i32> %86, 13
  %105 = insertvalue [16 x <16 x i32>] %104, <16 x i32> %88, 14
  %106 = insertvalue [16 x <16 x i32>] %105, <16 x i32> %90, 15
  %107 = add nuw nsw i64 %19, 1, !dbg !91
  %exitcond.not = icmp eq i64 %107, 64, !dbg !91
  br i1 %exitcond.not, label %108, label %17, !dbg !91

108:                                              ; preds = %17
  %.idx = shl nuw nsw i64 %10, 11, !dbg !92
  %109 = getelementptr i8, ptr %7, i64 %.idx, !dbg !92
  %.idx38 = shl nuw nsw i64 %11, 6, !dbg !92
  %110 = getelementptr i8, ptr %109, i64 %.idx38, !dbg !92
  store <16 x i32> %60, ptr %110, align 64, !dbg !92
  %111 = getelementptr i8, ptr %110, i64 128, !dbg !92
  store <16 x i32> %62, ptr %111, align 64, !dbg !92
  %112 = getelementptr i8, ptr %110, i64 256, !dbg !92
  store <16 x i32> %64, ptr %112, align 64, !dbg !92
  %113 = getelementptr i8, ptr %110, i64 384, !dbg !92
  store <16 x i32> %66, ptr %113, align 64, !dbg !92
  %114 = getelementptr i8, ptr %110, i64 512, !dbg !92
  store <16 x i32> %68, ptr %114, align 64, !dbg !92
  %115 = getelementptr i8, ptr %110, i64 640, !dbg !92
  store <16 x i32> %70, ptr %115, align 64, !dbg !92
  %116 = getelementptr i8, ptr %110, i64 768, !dbg !92
  store <16 x i32> %72, ptr %116, align 64, !dbg !92
  %117 = getelementptr i8, ptr %110, i64 896, !dbg !92
  store <16 x i32> %74, ptr %117, align 64, !dbg !92
  %118 = getelementptr i8, ptr %110, i64 1024, !dbg !92
  store <16 x i32> %76, ptr %118, align 64, !dbg !92
  %119 = getelementptr i8, ptr %110, i64 1152, !dbg !92
  store <16 x i32> %78, ptr %119, align 64, !dbg !92
  %120 = getelementptr i8, ptr %110, i64 1280, !dbg !92
  store <16 x i32> %80, ptr %120, align 64, !dbg !92
  %121 = getelementptr i8, ptr %110, i64 1408, !dbg !92
  store <16 x i32> %82, ptr %121, align 64, !dbg !92
  %122 = getelementptr i8, ptr %110, i64 1536, !dbg !92
  store <16 x i32> %84, ptr %122, align 64, !dbg !92
  %123 = getelementptr i8, ptr %110, i64 1664, !dbg !92
  store <16 x i32> %86, ptr %123, align 64, !dbg !92
  %124 = getelementptr i8, ptr %110, i64 1792, !dbg !92
  store <16 x i32> %88, ptr %124, align 64, !dbg !92
  %125 = getelementptr i8, ptr %110, i64 1920, !dbg !92
  store <16 x i32> %90, ptr %125, align 64, !dbg !92
  ret i32 0, !dbg !93
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: write, target_mem0: none, target_mem1: none)
define internal noundef i32 @_encoding_0_encode_32x64xi8_to_32x64xi8(ptr noalias nonnull readnone align 16 captures(none) %0, ptr noalias noundef nonnull readonly align 16 captures(none) %1, ptr noalias noundef nonnull readonly align 16 captures(none) %2) #1 !dbg !94 {
  %.elt19 = getelementptr inbounds nuw i8, ptr %1, i64 32, !dbg !95
  %.unpack20 = load ptr, ptr %.elt19, align 16, !dbg !95
  %4 = load ptr, ptr %.unpack20, align 8, !dbg !95
  call void @llvm.assume(i1 true) [ "align"(ptr %4, i64 64) ], !dbg !95
  %5 = getelementptr i8, ptr %.unpack20, i64 8, !dbg !96
  %6 = load ptr, ptr %5, align 8, !dbg !96
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !96
  %7 = load i32, ptr %2, align 16, !dbg !97
  %8 = zext i32 %7 to i64, !dbg !97
  %9 = shl nuw nsw i64 %8, 3, !dbg !97
  %10 = and i64 %9, 56, !dbg !97
  %11 = shl nuw nsw i64 %8, 7
  %12 = and i64 %11, 549755812864
  %13 = getelementptr i8, ptr %4, i64 %12
  %14 = getelementptr i8, ptr %6, i64 %12
  br label %15, !dbg !97

15:                                               ; preds = %3, %15
  %16 = phi i64 [ 0, %3 ], [ %81, %15 ]
  %17 = or disjoint i64 %16, %10, !dbg !97
  %18 = getelementptr i8, ptr %13, i64 %17, !dbg !97
  %19 = load <1 x i8>, ptr %18, align 1, !dbg !97
  %20 = getelementptr i8, ptr %18, i64 64, !dbg !97
  %21 = load <1 x i8>, ptr %20, align 1, !dbg !97
  %22 = getelementptr i8, ptr %18, i64 128, !dbg !97
  %23 = load <1 x i8>, ptr %22, align 1, !dbg !97
  %24 = shufflevector <1 x i8> %23, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %25 = getelementptr i8, ptr %18, i64 192, !dbg !97
  %26 = load <1 x i8>, ptr %25, align 1, !dbg !97
  %27 = shufflevector <1 x i8> %26, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %28 = getelementptr i8, ptr %18, i64 256, !dbg !97
  %29 = load <1 x i8>, ptr %28, align 1, !dbg !97
  %30 = shufflevector <1 x i8> %29, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %31 = getelementptr i8, ptr %18, i64 320, !dbg !97
  %32 = load <1 x i8>, ptr %31, align 1, !dbg !97
  %33 = shufflevector <1 x i8> %32, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %34 = getelementptr i8, ptr %18, i64 384, !dbg !97
  %35 = load <1 x i8>, ptr %34, align 1, !dbg !97
  %36 = shufflevector <1 x i8> %35, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %37 = getelementptr i8, ptr %18, i64 448, !dbg !97
  %38 = load <1 x i8>, ptr %37, align 1, !dbg !97
  %39 = shufflevector <1 x i8> %38, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %40 = getelementptr i8, ptr %18, i64 512, !dbg !97
  %41 = load <1 x i8>, ptr %40, align 1, !dbg !97
  %42 = shufflevector <1 x i8> %41, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %43 = getelementptr i8, ptr %18, i64 576, !dbg !97
  %44 = load <1 x i8>, ptr %43, align 1, !dbg !97
  %45 = shufflevector <1 x i8> %44, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %46 = getelementptr i8, ptr %18, i64 640, !dbg !97
  %47 = load <1 x i8>, ptr %46, align 1, !dbg !97
  %48 = shufflevector <1 x i8> %47, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %49 = getelementptr i8, ptr %18, i64 704, !dbg !97
  %50 = load <1 x i8>, ptr %49, align 1, !dbg !97
  %51 = shufflevector <1 x i8> %50, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %52 = getelementptr i8, ptr %18, i64 768, !dbg !97
  %53 = load <1 x i8>, ptr %52, align 1, !dbg !97
  %54 = shufflevector <1 x i8> %53, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %55 = getelementptr i8, ptr %18, i64 832, !dbg !97
  %56 = load <1 x i8>, ptr %55, align 1, !dbg !97
  %57 = shufflevector <1 x i8> %56, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %58 = getelementptr i8, ptr %18, i64 896, !dbg !97
  %59 = load <1 x i8>, ptr %58, align 1, !dbg !97
  %60 = shufflevector <1 x i8> %59, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %61 = getelementptr i8, ptr %18, i64 960, !dbg !97
  %62 = load <1 x i8>, ptr %61, align 1, !dbg !97
  %63 = shufflevector <1 x i8> %62, <1 x i8> poison, <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %64 = shufflevector <1 x i8> %19, <1 x i8> %21, <16 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %65 = shufflevector <16 x i8> %64, <16 x i8> %24, <16 x i32> <i32 0, i32 1, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %66 = shufflevector <16 x i8> %65, <16 x i8> %27, <16 x i32> <i32 0, i32 1, i32 2, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %67 = shufflevector <16 x i8> %66, <16 x i8> %30, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %68 = shufflevector <16 x i8> %67, <16 x i8> %33, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %69 = shufflevector <16 x i8> %68, <16 x i8> %36, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %70 = shufflevector <16 x i8> %69, <16 x i8> %39, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %71 = shufflevector <16 x i8> %70, <16 x i8> %42, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %72 = shufflevector <16 x i8> %71, <16 x i8> %45, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %73 = shufflevector <16 x i8> %72, <16 x i8> %48, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 16, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %74 = shufflevector <16 x i8> %73, <16 x i8> %51, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 16, i32 poison, i32 poison, i32 poison, i32 poison>, !dbg !97
  %75 = shufflevector <16 x i8> %74, <16 x i8> %54, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 16, i32 poison, i32 poison, i32 poison>, !dbg !97
  %76 = shufflevector <16 x i8> %75, <16 x i8> %57, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 16, i32 poison, i32 poison>, !dbg !97
  %77 = shufflevector <16 x i8> %76, <16 x i8> %60, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 16, i32 poison>, !dbg !97
  %78 = shufflevector <16 x i8> %77, <16 x i8> %63, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 16>, !dbg !97
  %79 = shl nuw nsw i64 %17, 4, !dbg !97
  %80 = getelementptr i8, ptr %14, i64 %79, !dbg !97
  store <16 x i8> %78, ptr %80, align 16, !dbg !97
  %81 = add nuw nsw i64 %16, 1, !dbg !97
  %exitcond.not = icmp eq i64 %81, 8, !dbg !97
  br i1 %exitcond.not, label %82, label %15, !dbg !97

82:                                               ; preds = %15
  ret i32 0, !dbg !98
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: write, target_mem0: none, target_mem1: none)
define internal noundef i32 @_encoding_1_encode_64x32xi8_to_64x32xi8(ptr noalias nonnull readnone align 16 captures(none) %0, ptr noalias noundef nonnull readonly align 16 captures(none) %1, ptr noalias noundef nonnull readonly align 16 captures(none) %2) #2 !dbg !99 {
  %.elt19 = getelementptr inbounds nuw i8, ptr %1, i64 32, !dbg !100
  %.unpack20 = load ptr, ptr %.elt19, align 16, !dbg !100
  %4 = load ptr, ptr %.unpack20, align 8, !dbg !100
  call void @llvm.assume(i1 true) [ "align"(ptr %4, i64 64) ], !dbg !100
  %5 = getelementptr i8, ptr %.unpack20, i64 8, !dbg !101
  %6 = load ptr, ptr %5, align 8, !dbg !101
  %7 = getelementptr i8, ptr %6, i64 2048, !dbg !101
  call void @llvm.assume(i1 true) [ "align"(ptr %7, i64 64) ], !dbg !101
  %8 = load i32, ptr %2, align 16, !dbg !102
  %9 = zext i32 %8 to i64, !dbg !102
  %10 = lshr i64 %9, 6, !dbg !102
  %11 = and i64 %9, 63, !dbg !102
  %12 = shl nuw nsw i64 %10, 4, !dbg !102
  %13 = shl nuw nsw i64 %11, 5, !dbg !102
  %14 = getelementptr i8, ptr %4, i64 %13, !dbg !102
  %15 = getelementptr i8, ptr %14, i64 %12, !dbg !102
  %16 = load <16 x i8>, ptr %15, align 16, !dbg !102
  %17 = shl nuw nsw i64 %10, 10, !dbg !102
  %18 = shl nuw nsw i64 %11, 4, !dbg !102
  %19 = getelementptr i8, ptr %7, i64 %17, !dbg !102
  %20 = getelementptr i8, ptr %19, i64 %18, !dbg !102
  store <16 x i8> %16, ptr %20, align 16, !dbg !102
  ret i32 0, !dbg !103
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v16i8(<vscale x 8 x i8>, <16 x i8>, i64 immarg) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32>, <16 x i32>, i64 immarg) #4

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.riscv.opu.bcast.nxv8i32.i64(<vscale x 8 x i32>, i64) #5

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64, <vscale x 8 x i32>, i64) #5

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.riscv.opu.vopacc.nxv8i8.nxv8i8.i64(<vscale x 8 x i8>, <vscale x 8 x i8>, i64) #5

; Function Attrs: mustprogress nounwind willreturn
declare <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64, i64) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32>, i64 immarg) #4

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport ptr @iree_hal_executable_library_query(i32 %0, ptr readnone captures(none) %1) local_unnamed_addr #6 {
entry:
  %2 = icmp eq i32 %0, 6
  %3 = select i1 %2, ptr @iree_hal_executable_library_query_v0, ptr null
  ret ptr %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @iree_h2f_ieee(i16 noundef signext %0) local_unnamed_addr #7 {
  %2 = and i16 %0, 31744
  %3 = and i16 %0, 1023
  %4 = and i16 %0, -32768
  %5 = zext i16 %4 to i32
  %6 = shl nuw i32 %5, 16
  switch i16 %2, label %15 [
    i16 31744, label %7
    i16 0, label %23
  ]

7:                                                ; preds = %1
  %8 = icmp eq i16 %3, 0
  br i1 %8, label %12, label %9

9:                                                ; preds = %7
  %10 = or disjoint i32 %6, 2143289344
  %11 = bitcast i32 %10 to float
  br label %28

12:                                               ; preds = %7
  %13 = or disjoint i32 %6, 2139095040
  %14 = bitcast i32 %13 to float
  br label %28

15:                                               ; preds = %1
  %16 = zext nneg i16 %3 to i32
  %17 = zext nneg i16 %2 to i32
  %18 = add nuw nsw i32 %17, 114688
  %19 = or disjoint i32 %18, %16
  %20 = shl nuw nsw i32 %19, 13
  %21 = or disjoint i32 %20, %6
  %22 = bitcast i32 %21 to float
  br label %28

23:                                               ; preds = %1
  %24 = or disjoint i32 %6, 864026624
  %25 = uitofp nneg i16 %3 to float
  %26 = bitcast i32 %24 to float
  %27 = fmul float %25, %26
  br label %28

28:                                               ; preds = %23, %15, %12, %9
  %29 = phi float [ %11, %9 ], [ %14, %12 ], [ %22, %15 ], [ %27, %23 ]
  ret float %29
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal signext i16 @iree_f2h_ieee(float noundef %0) local_unnamed_addr #7 {
  %2 = bitcast float %0 to i32
  %3 = and i32 %2, 2139095040
  %4 = and i32 %2, 8388607
  %5 = lshr i32 %2, 16
  %6 = and i32 %5, 32768
  switch i32 %3, label %12 [
    i32 2139095040, label %7
    i32 0, label %30
  ]

7:                                                ; preds = %1
  %8 = icmp eq i32 %4, 0
  br i1 %8, label %30, label %9

9:                                                ; preds = %7
  %10 = trunc nuw i32 %5 to i16
  %11 = or i16 %10, 32767
  br label %34

12:                                               ; preds = %1
  %13 = lshr exact i32 %3, 23
  %14 = icmp samesign ugt i32 %3, 1191182336
  br i1 %14, label %30, label %15

15:                                               ; preds = %12
  %16 = icmp samesign ult i32 %3, 947912704
  br i1 %16, label %30, label %17

17:                                               ; preds = %15
  %18 = and i32 %2, 8192
  %19 = icmp eq i32 %18, 0
  %20 = select i1 %19, i32 4095, i32 4096
  %21 = add nuw nsw i32 %20, %4
  %22 = icmp samesign ugt i32 %21, 8388607
  %23 = select i1 %22, i32 -126, i32 -127
  %24 = add nsw i32 %23, %13
  %25 = shl nsw i32 %24, 10
  %26 = lshr i32 %21, 13
  %27 = add nuw nsw i32 %26, 15360
  %28 = select i1 %22, i32 15360, i32 %27
  %29 = add nsw i32 %28, %25
  br label %30

30:                                               ; preds = %17, %12, %15, %1, %7
  %31 = phi i32 [ 31744, %7 ], [ %3, %1 ], [ %29, %17 ], [ 31744, %12 ], [ 0, %15 ]
  %32 = or i32 %31, %6
  %33 = trunc i32 %32 to i16
  br label %34

34:                                               ; preds = %30, %9
  %35 = phi i16 [ %11, %9 ], [ %33, %30 ]
  ret i16 %35
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @__gnu_h2f_ieee(i16 noundef signext %0) local_unnamed_addr #7 {
  %2 = and i16 %0, 31744
  %3 = and i16 %0, 1023
  %4 = and i16 %0, -32768
  %5 = zext i16 %4 to i32
  %6 = shl nuw i32 %5, 16
  switch i16 %2, label %15 [
    i16 31744, label %7
    i16 0, label %23
  ]

7:                                                ; preds = %1
  %8 = icmp eq i16 %3, 0
  br i1 %8, label %12, label %9

9:                                                ; preds = %7
  %10 = or disjoint i32 %6, 2143289344
  %11 = bitcast i32 %10 to float
  br label %28

12:                                               ; preds = %7
  %13 = or disjoint i32 %6, 2139095040
  %14 = bitcast i32 %13 to float
  br label %28

15:                                               ; preds = %1
  %16 = zext nneg i16 %3 to i32
  %17 = zext nneg i16 %2 to i32
  %18 = add nuw nsw i32 %17, 114688
  %19 = or disjoint i32 %18, %16
  %20 = shl nuw nsw i32 %19, 13
  %21 = or disjoint i32 %20, %6
  %22 = bitcast i32 %21 to float
  br label %28

23:                                               ; preds = %1
  %24 = or disjoint i32 %6, 864026624
  %25 = uitofp nneg i16 %3 to float
  %26 = bitcast i32 %24 to float
  %27 = fmul float %25, %26
  br label %28

28:                                               ; preds = %9, %12, %15, %23
  %29 = phi float [ %11, %9 ], [ %14, %12 ], [ %22, %15 ], [ %27, %23 ]
  ret float %29
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @__extendhfsf2(float noundef %0) local_unnamed_addr #7 {
  %2 = bitcast float %0 to i32
  %3 = trunc i32 %2 to i16
  %4 = and i16 %3, 31744
  %5 = and i16 %3, 1023
  %6 = shl i32 %2, 16
  %7 = and i32 %6, -2147483648
  switch i16 %4, label %16 [
    i16 31744, label %8
    i16 0, label %24
  ]

8:                                                ; preds = %1
  %9 = icmp eq i16 %5, 0
  br i1 %9, label %13, label %10

10:                                               ; preds = %8
  %11 = or disjoint i32 %7, 2143289344
  %12 = bitcast i32 %11 to float
  br label %29

13:                                               ; preds = %8
  %14 = or disjoint i32 %7, 2139095040
  %15 = bitcast i32 %14 to float
  br label %29

16:                                               ; preds = %1
  %17 = and i32 %2, 1023
  %18 = and i32 %2, 31744
  %19 = add nuw nsw i32 %18, 114688
  %20 = or disjoint i32 %19, %17
  %21 = shl nuw nsw i32 %20, 13
  %22 = or disjoint i32 %21, %7
  %23 = bitcast i32 %22 to float
  br label %29

24:                                               ; preds = %1
  %25 = or disjoint i32 %7, 864026624
  %26 = uitofp nneg i16 %5 to float
  %27 = bitcast i32 %25 to float
  %28 = fmul float %26, %27
  br label %29

29:                                               ; preds = %10, %13, %16, %24
  %30 = phi float [ %12, %10 ], [ %15, %13 ], [ %23, %16 ], [ %28, %24 ]
  ret float %30
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal signext i16 @__gnu_f2h_ieee(float noundef %0) local_unnamed_addr #7 {
  %2 = bitcast float %0 to i32
  %3 = and i32 %2, 2139095040
  %4 = and i32 %2, 8388607
  %5 = lshr i32 %2, 16
  %6 = and i32 %5, 32768
  switch i32 %3, label %12 [
    i32 2139095040, label %7
    i32 0, label %30
  ]

7:                                                ; preds = %1
  %8 = icmp eq i32 %4, 0
  br i1 %8, label %30, label %9

9:                                                ; preds = %7
  %10 = trunc nuw i32 %5 to i16
  %11 = or i16 %10, 32767
  br label %34

12:                                               ; preds = %1
  %13 = lshr exact i32 %3, 23
  %14 = icmp samesign ugt i32 %3, 1191182336
  br i1 %14, label %30, label %15

15:                                               ; preds = %12
  %16 = icmp samesign ult i32 %3, 947912704
  br i1 %16, label %30, label %17

17:                                               ; preds = %15
  %18 = and i32 %2, 8192
  %19 = icmp eq i32 %18, 0
  %20 = select i1 %19, i32 4095, i32 4096
  %21 = add nuw nsw i32 %20, %4
  %22 = icmp samesign ugt i32 %21, 8388607
  %23 = select i1 %22, i32 -126, i32 -127
  %24 = add nsw i32 %23, %13
  %25 = shl nsw i32 %24, 10
  %26 = lshr i32 %21, 13
  %27 = add nuw nsw i32 %26, 15360
  %28 = select i1 %22, i32 15360, i32 %27
  %29 = add nsw i32 %25, %28
  br label %30

30:                                               ; preds = %17, %15, %12, %7, %1
  %31 = phi i32 [ 31744, %7 ], [ %3, %1 ], [ %29, %17 ], [ 31744, %12 ], [ 0, %15 ]
  %32 = or i32 %31, %6
  %33 = trunc i32 %32 to i16
  br label %34

34:                                               ; preds = %9, %30
  %35 = phi i16 [ %11, %9 ], [ %33, %30 ]
  ret i16 %35
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @__truncsfhf2(float noundef %0) local_unnamed_addr #7 {
  %2 = alloca i16, align 4
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  %3 = bitcast float %0 to i32
  %4 = and i32 %3, 2139095040
  %5 = and i32 %3, 8388607
  %6 = lshr i32 %3, 16
  %7 = and i32 %6, 32768
  switch i32 %4, label %13 [
    i32 2139095040, label %8
    i32 0, label %31
  ]

8:                                                ; preds = %1
  %9 = icmp eq i32 %5, 0
  br i1 %9, label %31, label %10

10:                                               ; preds = %8
  %11 = trunc nuw i32 %6 to i16
  %12 = or i16 %11, 32767
  br label %35

13:                                               ; preds = %1
  %14 = lshr exact i32 %4, 23
  %15 = icmp samesign ugt i32 %4, 1191182336
  br i1 %15, label %31, label %16

16:                                               ; preds = %13
  %17 = icmp samesign ult i32 %4, 947912704
  br i1 %17, label %31, label %18

18:                                               ; preds = %16
  %19 = and i32 %3, 8192
  %20 = icmp eq i32 %19, 0
  %21 = select i1 %20, i32 4095, i32 4096
  %22 = add nuw nsw i32 %21, %5
  %23 = icmp samesign ugt i32 %22, 8388607
  %24 = select i1 %23, i32 -126, i32 -127
  %25 = add nsw i32 %24, %14
  %26 = shl nsw i32 %25, 10
  %27 = lshr i32 %22, 13
  %28 = add nuw nsw i32 %27, 15360
  %29 = select i1 %23, i32 15360, i32 %28
  %30 = add nsw i32 %26, %29
  br label %31

31:                                               ; preds = %18, %16, %13, %8, %1
  %32 = phi i32 [ 31744, %8 ], [ %4, %1 ], [ %30, %18 ], [ 31744, %13 ], [ 0, %16 ]
  %33 = or i32 %32, %7
  %34 = trunc i32 %33 to i16
  br label %35

35:                                               ; preds = %10, %31
  %36 = phi i16 [ %12, %10 ], [ %34, %31 ]
  store i16 %36, ptr %2, align 4, !tbaa !104
  %.0..0..0..0. = load float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  ret float %.0..0..0..0.
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal double @__extendhfdf2(float noundef %0) local_unnamed_addr #7 {
  %2 = bitcast float %0 to i32
  %3 = trunc i32 %2 to i16
  %4 = and i16 %3, 31744
  %5 = and i16 %3, 1023
  %6 = shl i32 %2, 16
  %7 = and i32 %6, -2147483648
  switch i16 %4, label %16 [
    i16 31744, label %8
    i16 0, label %24
  ]

8:                                                ; preds = %1
  %9 = icmp eq i16 %5, 0
  br i1 %9, label %13, label %10

10:                                               ; preds = %8
  %11 = or disjoint i32 %7, 2143289344
  %12 = bitcast i32 %11 to float
  br label %29

13:                                               ; preds = %8
  %14 = or disjoint i32 %7, 2139095040
  %15 = bitcast i32 %14 to float
  br label %29

16:                                               ; preds = %1
  %17 = and i32 %2, 1023
  %18 = and i32 %2, 31744
  %19 = add nuw nsw i32 %18, 114688
  %20 = or disjoint i32 %19, %17
  %21 = shl nuw nsw i32 %20, 13
  %22 = or disjoint i32 %21, %7
  %23 = bitcast i32 %22 to float
  br label %29

24:                                               ; preds = %1
  %25 = or disjoint i32 %7, 864026624
  %26 = uitofp nneg i16 %5 to float
  %27 = bitcast i32 %25 to float
  %28 = fmul float %26, %27
  br label %29

29:                                               ; preds = %10, %13, %16, %24
  %30 = phi float [ %12, %10 ], [ %15, %13 ], [ %23, %16 ], [ %28, %24 ]
  %31 = fpext float %30 to double
  ret double %31
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @__truncdfhf2(double noundef %0) local_unnamed_addr #7 {
  %2 = alloca i16, align 4
  %3 = fptrunc double %0 to float
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  %4 = bitcast float %3 to i32
  %5 = and i32 %4, 2139095040
  %6 = and i32 %4, 8388607
  %7 = lshr i32 %4, 16
  %8 = and i32 %7, 32768
  switch i32 %5, label %14 [
    i32 2139095040, label %9
    i32 0, label %32
  ]

9:                                                ; preds = %1
  %10 = icmp eq i32 %6, 0
  br i1 %10, label %32, label %11

11:                                               ; preds = %9
  %12 = trunc nuw i32 %7 to i16
  %13 = or i16 %12, 32767
  br label %36

14:                                               ; preds = %1
  %15 = lshr exact i32 %5, 23
  %16 = icmp samesign ugt i32 %5, 1191182336
  br i1 %16, label %32, label %17

17:                                               ; preds = %14
  %18 = icmp samesign ult i32 %5, 947912704
  br i1 %18, label %32, label %19

19:                                               ; preds = %17
  %20 = and i32 %4, 8192
  %21 = icmp eq i32 %20, 0
  %22 = select i1 %21, i32 4095, i32 4096
  %23 = add nuw nsw i32 %22, %6
  %24 = icmp samesign ugt i32 %23, 8388607
  %25 = select i1 %24, i32 -126, i32 -127
  %26 = add nsw i32 %25, %15
  %27 = shl nsw i32 %26, 10
  %28 = lshr i32 %23, 13
  %29 = add nuw nsw i32 %28, 15360
  %30 = select i1 %24, i32 15360, i32 %29
  %31 = add nsw i32 %27, %30
  br label %32

32:                                               ; preds = %19, %17, %14, %9, %1
  %33 = phi i32 [ 31744, %9 ], [ %5, %1 ], [ %31, %19 ], [ 31744, %14 ], [ 0, %17 ]
  %34 = or i32 %33, %8
  %35 = trunc i32 %34 to i16
  br label %36

36:                                               ; preds = %11, %32
  %37 = phi i16 [ %13, %11 ], [ %35, %32 ]
  store i16 %37, ptr %2, align 4, !tbaa !104
  %.0..0..0..0. = load float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  ret float %.0..0..0..0.
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef double @fma(double noundef %0, double noundef %1, double noundef %2) local_unnamed_addr #7 {
  %4 = tail call double @llvm.fmuladd.f64(double %0, double %1, double %2)
  ret double %4
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #9

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef float @__math_invalidf(float noundef %0) local_unnamed_addr #10 {
  %2 = fsub float %0, %0
  %3 = fdiv float %2, %2
  ret float %3
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @__math_oflowf(i32 noundef %0) local_unnamed_addr #11 {
  %2 = alloca float, align 4
  %.not.i = icmp eq i32 %0, 0
  %3 = select i1 %.not.i, float 0x4600000000000000, float 0xC600000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store volatile float %3, ptr %2, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..0..0..i.i = load volatile float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %4 = fmul float %.0..0..0..0..0..0..0..0..0..0..0..0..i.i, 0x4600000000000000
  ret float %4
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @__math_xflowf(i32 noundef %0, float noundef %1) local_unnamed_addr #11 {
  %3 = alloca float, align 4
  %.not = icmp eq i32 %0, 0
  %4 = fneg float %1
  %5 = select i1 %.not, float %1, float %4
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float %5, ptr %3, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..i = load volatile float, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  %6 = fmul float %1, %.0..0..0..0..0..0..0..0..0..0..i
  ret float %6
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @__math_uflowf(i32 noundef %0) local_unnamed_addr #11 {
  %2 = alloca float, align 4
  %.not.i = icmp eq i32 %0, 0
  %3 = select i1 %.not.i, float 0x3A00000000000000, float 0xBA00000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store volatile float %3, ptr %2, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..0..0..i.i = load volatile float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %4 = fmul float %.0..0..0..0..0..0..0..0..0..0..0..0..i.i, 0x3A00000000000000
  ret float %4
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @ceilf(float noundef %0) local_unnamed_addr #11 {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = bitcast float %0 to i32
  %5 = lshr i32 %4, 23
  %6 = and i32 %5, 255
  %7 = add nsw i32 %6, -127
  %8 = icmp samesign ugt i32 %6, 149
  br i1 %8, label %26, label %9

9:                                                ; preds = %1
  %10 = icmp samesign ugt i32 %6, 126
  br i1 %10, label %11, label %23

11:                                               ; preds = %9
  %12 = lshr i32 8388607, %7
  %13 = and i32 %12, %4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %26, label %15

15:                                               ; preds = %11
  %16 = fadd float %0, 0x4770000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float %16, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  %17 = icmp slt i32 %4, 0
  %18 = ashr i32 -8388608, %7
  %19 = select i1 %17, i32 0, i32 %12
  %20 = add nuw i32 %19, %4
  %21 = and i32 %20, %18
  %22 = bitcast i32 %21 to float
  br label %26

23:                                               ; preds = %9
  %24 = fadd float %0, 0x4770000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store volatile float %24, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %.not = icmp sgt i32 %4, -1
  br i1 %.not, label %25, label %26

25:                                               ; preds = %23
  %.not18 = icmp eq i32 %4, 0
  %spec.select = select i1 %.not18, float %0, float 1.000000e+00
  br label %26

26:                                               ; preds = %25, %23, %15, %11, %1
  %.0 = phi float [ %0, %1 ], [ %0, %11 ], [ %22, %15 ], [ -0.000000e+00, %23 ], [ %spec.select, %25 ]
  ret float %.0
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @expf(float noundef %0) local_unnamed_addr #11 {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = fpext float %0 to double
  %5 = bitcast float %0 to i32
  %6 = lshr i32 %5, 20
  %7 = and i32 %6, 2047
  %.not = icmp samesign ult i32 %7, 1067
  br i1 %.not, label %21, label %8, !prof !108

8:                                                ; preds = %1
  %9 = fcmp oeq float %0, 0xFFF0000000000000
  br i1 %9, label %39, label %10

10:                                               ; preds = %8
  %.not34 = icmp samesign ult i32 %7, 2040
  br i1 %.not34, label %13, label %11

11:                                               ; preds = %10
  %12 = fadd float %0, %0
  br label %39

13:                                               ; preds = %10
  %14 = fcmp ogt float %0, 0x40562E42E0000000
  br i1 %14, label %15, label %17

15:                                               ; preds = %13
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float 0x4600000000000000, ptr %3, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i = load volatile float, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  %16 = fmul float %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i, 0x4600000000000000
  br label %39

17:                                               ; preds = %13
  %18 = fcmp olt float %0, 0xC059FE3680000000
  br i1 %18, label %19, label %21

19:                                               ; preds = %17
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store volatile float 0x3A00000000000000, ptr %2, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i3 = load volatile float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %20 = fmul float %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i3, 0x3A00000000000000
  br label %39

21:                                               ; preds = %17, %1
  %22 = fmul double %4, 0x40471547652B82FE
  %23 = fadd double %22, 0x4338000000000000
  %24 = bitcast double %23 to i64
  %25 = fadd double %23, 0xC338000000000000
  %26 = fsub double %22, %25
  %27 = and i64 %24, 31
  %28 = getelementptr inbounds nuw i64, ptr @__exp2f_data, i64 %27
  %29 = load i64, ptr %28, align 8, !tbaa !109
  %30 = shl i64 %24, 47
  %31 = add i64 %29, %30
  %32 = bitcast i64 %31 to double
  %33 = tail call double @llvm.fmuladd.f64(double %26, double 0x3EBC6AF84B912394, double 0x3F2EBFCE50FAC4F3)
  %34 = fmul double %26, %26
  %35 = tail call double @llvm.fmuladd.f64(double %26, double 0x3F962E42FF0C52D6, double 1.000000e+00)
  %36 = tail call double @llvm.fmuladd.f64(double %33, double %34, double %35)
  %37 = fmul double %36, %32
  %38 = fptrunc double %37 to float
  br label %39

39:                                               ; preds = %21, %19, %15, %11, %8
  %.0 = phi float [ %12, %11 ], [ %16, %15 ], [ %20, %19 ], [ %38, %21 ], [ 0.000000e+00, %8 ]
  ret float %.0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @feclearexcept(i32 noundef %0) local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @feraiseexcept(i32 noundef %0) local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @fetestexcept(i32 noundef %0) local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @fegetround() local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @__fesetround(i32 noundef %0) local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @fegetenv(ptr noundef readnone captures(none) %0) local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef i32 @fesetenv(ptr noundef readnone captures(none) %0) local_unnamed_addr #10 {
  ret i32 0
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @floorf(float noundef %0) local_unnamed_addr #11 {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = bitcast float %0 to i32
  %5 = lshr i32 %4, 23
  %6 = and i32 %5, 255
  %7 = add nsw i32 %6, -127
  %8 = icmp samesign ugt i32 %6, 149
  br i1 %8, label %27, label %9

9:                                                ; preds = %1
  %10 = icmp samesign ugt i32 %6, 126
  br i1 %10, label %11, label %22

11:                                               ; preds = %9
  %12 = lshr i32 8388607, %7
  %13 = and i32 %12, %4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %27, label %15

15:                                               ; preds = %11
  %16 = fadd float %0, 0x4770000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float %16, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  %.not1819 = icmp slt i32 %4, 0
  %17 = ashr i32 -8388608, %7
  %18 = select i1 %.not1819, i32 %12, i32 0
  %19 = add nsw i32 %18, %4
  %20 = and i32 %19, %17
  %21 = bitcast i32 %20 to float
  br label %27

22:                                               ; preds = %9
  %23 = fadd float %0, 0x4770000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store volatile float %23, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %24 = icmp sgt i32 %4, -1
  br i1 %24, label %27, label %25

25:                                               ; preds = %22
  %.not = fcmp oeq float %0, 0.000000e+00
  br i1 %.not, label %27, label %26

26:                                               ; preds = %25
  br label %27

27:                                               ; preds = %26, %25, %22, %15, %11, %1
  %.0 = phi float [ %0, %1 ], [ %0, %11 ], [ %21, %15 ], [ -1.000000e+00, %26 ], [ %0, %25 ], [ 0.000000e+00, %22 ]
  ret float %.0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @fmaf(float noundef %0, float noundef %1, float noundef %2) local_unnamed_addr #10 {
  %4 = fpext float %0 to double
  %5 = fpext float %1 to double
  %6 = fmul double %4, %5
  %7 = fpext float %2 to double
  %8 = fadd double %6, %7
  %9 = bitcast double %8 to i64
  %10 = and i64 %9, 536870911
  %11 = icmp ne i64 %10, 268435456
  %12 = and i64 %9, 9218868437227405312
  %13 = icmp eq i64 %12, 9218868437227405312
  %or.cond = or i1 %11, %13
  br i1 %or.cond, label %31, label %14

14:                                               ; preds = %3
  %15 = fsub double %8, %6
  %16 = fcmp oeq double %15, %7
  %17 = fsub double %8, %7
  %18 = fcmp oeq double %17, %6
  %or.cond44 = and i1 %16, %18
  br i1 %or.cond44, label %31, label %19

19:                                               ; preds = %14
  %20 = icmp slt i64 %9, 0
  %21 = fcmp uge double %6, %7
  %22 = xor i1 %21, %20
  %23 = fsub double %6, %8
  %24 = fadd double %23, %7
  %25 = fsub double %7, %8
  %26 = fadd double %6, %25
  %.038 = select i1 %22, double %24, double %26
  %27 = fcmp uge double %.038, 0.000000e+00
  %28 = xor i1 %20, %27
  %29 = or disjoint i64 %9, 1
  %30 = add nsw i64 %9, -1
  %.sroa.0.0.in = select i1 %28, i64 %29, i64 %30
  %.sroa.0.0 = bitcast i64 %.sroa.0.0.in to double
  br label %31

31:                                               ; preds = %3, %14, %19
  %.0.in = phi double [ %.sroa.0.0, %19 ], [ %8, %14 ], [ %8, %3 ]
  %.0 = fptrunc double %.0.in to float
  ret float %.0
}

; Function Attrs: inlinehint nofree norecurse nosync nounwind memory(none)
define internal float @fmodf(float noundef %0, float noundef %1) local_unnamed_addr #12 {
  %3 = bitcast float %0 to i32
  %4 = lshr i32 %3, 23
  %5 = and i32 %4, 255
  %6 = bitcast float %1 to i32
  %7 = lshr i32 %6, 23
  %8 = and i32 %7, 255
  %9 = and i32 %3, -2147483648
  %10 = shl i32 %6, 1
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %17, label %12

12:                                               ; preds = %2
  %13 = tail call float @llvm.fabs.f32(float %1)
  %14 = bitcast float %13 to i32
  %15 = icmp samesign ugt i32 %14, 2139095040
  %16 = icmp eq i32 %5, 255
  %or.cond = or i1 %15, %16
  br i1 %or.cond, label %17, label %20

17:                                               ; preds = %12, %2
  %18 = fmul float %0, %1
  %19 = fdiv float %18, %18
  br label %83

20:                                               ; preds = %12
  %21 = shl i32 %3, 1
  %.not = icmp ugt i32 %21, %10
  br i1 %.not, label %25, label %22

22:                                               ; preds = %20
  %23 = icmp eq i32 %21, %10
  %24 = fmul float %0, 0.000000e+00
  %spec.select = select i1 %23, float %24, float %0
  br label %83

25:                                               ; preds = %20
  %.not81 = icmp eq i32 %5, 0
  br i1 %.not81, label %26, label %34

26:                                               ; preds = %25
  %27 = shl i32 %3, 9
  %28 = icmp sgt i32 %27, -1
  br i1 %28, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %26, %.lr.ph
  %.06586 = phi i32 [ %30, %.lr.ph ], [ %27, %26 ]
  %.07085 = phi i32 [ %29, %.lr.ph ], [ 0, %26 ]
  %29 = add nsw i32 %.07085, -1
  %30 = shl nuw i32 %.06586, 1
  %31 = icmp sgt i32 %30, -1
  br i1 %31, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %26
  %.070.lcssa = phi i32 [ 0, %26 ], [ %29, %.lr.ph ]
  %32 = sub i32 1, %.070.lcssa
  %33 = shl i32 %3, %32
  br label %37

34:                                               ; preds = %25
  %35 = and i32 %3, 8388607
  %36 = or disjoint i32 %35, 8388608
  br label %37

37:                                               ; preds = %34, %._crit_edge
  %.171 = phi i32 [ %5, %34 ], [ %.070.lcssa, %._crit_edge ]
  %.0 = phi i32 [ %36, %34 ], [ %33, %._crit_edge ]
  %.not82 = icmp eq i32 %8, 0
  br i1 %.not82, label %38, label %46

38:                                               ; preds = %37
  %39 = shl i32 %6, 9
  %40 = icmp sgt i32 %39, -1
  br i1 %40, label %.lr.ph90, label %._crit_edge91

.lr.ph90:                                         ; preds = %38, %.lr.ph90
  %.16688 = phi i32 [ %42, %.lr.ph90 ], [ %39, %38 ]
  %.06887 = phi i32 [ %41, %.lr.ph90 ], [ 0, %38 ]
  %41 = add nsw i32 %.06887, -1
  %42 = shl nuw i32 %.16688, 1
  %43 = icmp sgt i32 %42, -1
  br i1 %43, label %.lr.ph90, label %._crit_edge91

._crit_edge91:                                    ; preds = %.lr.ph90, %38
  %.068.lcssa = phi i32 [ 0, %38 ], [ %41, %.lr.ph90 ]
  %44 = sub i32 1, %.068.lcssa
  %45 = shl i32 %6, %44
  br label %49

46:                                               ; preds = %37
  %47 = and i32 %6, 8388607
  %48 = or disjoint i32 %47, 8388608
  br label %49

49:                                               ; preds = %46, %._crit_edge91
  %.sroa.0.0.in = phi i32 [ %48, %46 ], [ %45, %._crit_edge91 ]
  %.169 = phi i32 [ %8, %46 ], [ %.068.lcssa, %._crit_edge91 ]
  %50 = icmp sgt i32 %.171, %.169
  br i1 %50, label %.lr.ph96, label %._crit_edge97

.lr.ph96:                                         ; preds = %49, %57
  %.194 = phi i32 [ %58, %57 ], [ %.0, %49 ]
  %.27293 = phi i32 [ %59, %57 ], [ %.171, %49 ]
  %51 = sub i32 %.194, %.sroa.0.0.in
  %52 = icmp sgt i32 %51, -1
  br i1 %52, label %53, label %57

53:                                               ; preds = %.lr.ph96
  %54 = icmp eq i32 %51, 0
  br i1 %54, label %55, label %57

55:                                               ; preds = %53
  %56 = fmul float %0, 0.000000e+00
  br label %83

57:                                               ; preds = %53, %.lr.ph96
  %.2 = phi i32 [ %.194, %.lr.ph96 ], [ %51, %53 ]
  %58 = shl i32 %.2, 1
  %59 = add nsw i32 %.27293, -1
  %60 = icmp sgt i32 %59, %.169
  br i1 %60, label %.lr.ph96, label %._crit_edge97

._crit_edge97:                                    ; preds = %57, %49
  %.272.lcssa = phi i32 [ %.171, %49 ], [ %.169, %57 ]
  %.1.lcssa = phi i32 [ %.0, %49 ], [ %58, %57 ]
  %61 = sub i32 %.1.lcssa, %.sroa.0.0.in
  %62 = icmp sgt i32 %61, -1
  br i1 %62, label %63, label %67

63:                                               ; preds = %._crit_edge97
  %64 = icmp eq i32 %61, 0
  br i1 %64, label %65, label %67

65:                                               ; preds = %63
  %66 = fmul float %0, 0.000000e+00
  br label %83

67:                                               ; preds = %63, %._crit_edge97
  %.3 = phi i32 [ %.1.lcssa, %._crit_edge97 ], [ %61, %63 ]
  %68 = icmp ult i32 %.3, 8388608
  br i1 %68, label %.lr.ph103, label %._crit_edge104

.lr.ph103:                                        ; preds = %67, %.lr.ph103
  %.4101 = phi i32 [ %69, %.lr.ph103 ], [ %.3, %67 ]
  %.373100 = phi i32 [ %70, %.lr.ph103 ], [ %.272.lcssa, %67 ]
  %69 = shl nuw nsw i32 %.4101, 1
  %70 = add nsw i32 %.373100, -1
  %71 = icmp samesign ult i32 %.4101, 4194304
  br i1 %71, label %.lr.ph103, label %._crit_edge104

._crit_edge104:                                   ; preds = %.lr.ph103, %67
  %.373.lcssa = phi i32 [ %.272.lcssa, %67 ], [ %70, %.lr.ph103 ]
  %.4.lcssa = phi i32 [ %.3, %67 ], [ %69, %.lr.ph103 ]
  %72 = icmp sgt i32 %.373.lcssa, 0
  br i1 %72, label %73, label %77

73:                                               ; preds = %._crit_edge104
  %74 = add i32 %.4.lcssa, -8388608
  %75 = shl i32 %.373.lcssa, 23
  %76 = or i32 %74, %75
  br label %80

77:                                               ; preds = %._crit_edge104
  %78 = sub i32 1, %.373.lcssa
  %79 = lshr i32 %.4.lcssa, %78
  br label %80

80:                                               ; preds = %77, %73
  %.5 = phi i32 [ %76, %73 ], [ %79, %77 ]
  %81 = or i32 %.5, %9
  %82 = bitcast i32 %81 to float
  br label %83

83:                                               ; preds = %80, %65, %55, %22, %17
  %.067 = phi float [ %19, %17 ], [ %56, %55 ], [ %66, %65 ], [ %82, %80 ], [ %spec.select, %22 ]
  ret float %.067
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fabs.f32(float) #9

; Function Attrs: inlinehint nofree nosync nounwind memory(argmem: readwrite)
define internal float @frexpf(float noundef %0, ptr noundef captures(none) %1) local_unnamed_addr #13 {
  %3 = bitcast float %0 to i32
  %4 = lshr i32 %3, 23
  %trunc = trunc i32 %4 to i8
  switch i8 %trunc, label %13 [
    i8 0, label %5
    i8 -1, label %19
  ]

5:                                                ; preds = %2
  %6 = fcmp une float %0, 0.000000e+00
  br i1 %6, label %7, label %12

7:                                                ; preds = %5
  %8 = fmul float %0, 0x43F0000000000000
  %9 = tail call float @frexpf(float noundef %8, ptr noundef %1) #14
  %10 = load i32, ptr %1, align 4, !tbaa !8
  %11 = add nsw i32 %10, -64
  br label %12

12:                                               ; preds = %7, %5
  %storemerge = phi i32 [ %11, %7 ], [ 0, %5 ]
  %.014 = phi float [ %9, %7 ], [ %0, %5 ]
  store i32 %storemerge, ptr %1, align 4, !tbaa !8
  br label %19

13:                                               ; preds = %2
  %14 = and i32 %4, 255
  %15 = add nsw i32 %14, -126
  store i32 %15, ptr %1, align 4, !tbaa !8
  %16 = and i32 %3, -2139095041
  %17 = or disjoint i32 %16, 1056964608
  %18 = bitcast i32 %17 to float
  br label %19

19:                                               ; preds = %13, %12, %2
  %.0 = phi float [ %18, %13 ], [ %.014, %12 ], [ %0, %2 ]
  ret float %.0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @ldexpf(float noundef %0, i32 noundef %1) local_unnamed_addr #10 {
  %3 = icmp sgt i32 %1, 127
  br i1 %3, label %4, label %11

4:                                                ; preds = %2
  %5 = fmul float %0, 0x47E0000000000000
  %6 = add nsw i32 %1, -127
  %7 = icmp samesign ugt i32 %1, 254
  br i1 %7, label %8, label %scalbnf.exit

8:                                                ; preds = %4
  %9 = fmul float %5, 0x47E0000000000000
  %10 = tail call i32 @llvm.umin.i32(i32 %1, i32 381)
  %spec.store.select.i = add nsw i32 %10, -254
  br label %scalbnf.exit

11:                                               ; preds = %2
  %12 = icmp slt i32 %1, -126
  br i1 %12, label %13, label %scalbnf.exit

13:                                               ; preds = %11
  %14 = fmul float %0, 0x3990000000000000
  %15 = add nuw nsw i32 %1, 102
  %16 = icmp samesign ult i32 %1, -228
  br i1 %16, label %17, label %scalbnf.exit

17:                                               ; preds = %13
  %18 = fmul float %14, 0x3990000000000000
  %19 = tail call i32 @llvm.umax.i32(i32 %1, i32 -330)
  %spec.store.select1.i = add nuw nsw i32 %19, 204
  br label %scalbnf.exit

scalbnf.exit:                                     ; preds = %4, %8, %11, %13, %17
  %.018.i = phi i32 [ %spec.store.select.i, %8 ], [ %6, %4 ], [ %spec.store.select1.i, %17 ], [ %15, %13 ], [ %1, %11 ]
  %.0.i = phi float [ %9, %8 ], [ %5, %4 ], [ %18, %17 ], [ %14, %13 ], [ %0, %11 ]
  %20 = shl nsw i32 %.018.i, 23
  %21 = add nsw i32 %20, 1065353216
  %22 = bitcast i32 %21 to float
  %23 = fmul float %.0.i, %22
  ret float %23
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal float @scalbnf(float noundef %0, i32 noundef %1) local_unnamed_addr #10 {
  %3 = icmp sgt i32 %1, 127
  br i1 %3, label %4, label %11

4:                                                ; preds = %2
  %5 = fmul float %0, 0x47E0000000000000
  %6 = add nsw i32 %1, -127
  %7 = icmp samesign ugt i32 %1, 254
  br i1 %7, label %8, label %20

8:                                                ; preds = %4
  %9 = fmul float %5, 0x47E0000000000000
  %10 = tail call i32 @llvm.umin.i32(i32 %1, i32 381)
  %spec.store.select = add nsw i32 %10, -254
  br label %20

11:                                               ; preds = %2
  %12 = icmp slt i32 %1, -126
  br i1 %12, label %13, label %20

13:                                               ; preds = %11
  %14 = fmul float %0, 0x3990000000000000
  %15 = add nuw nsw i32 %1, 102
  %16 = icmp samesign ult i32 %1, -228
  br i1 %16, label %17, label %20

17:                                               ; preds = %13
  %18 = fmul float %14, 0x3990000000000000
  %19 = tail call i32 @llvm.umax.i32(i32 %1, i32 -330)
  %spec.store.select1 = add nuw nsw i32 %19, 204
  br label %20

20:                                               ; preds = %17, %13, %11, %8, %4
  %.018 = phi i32 [ %spec.store.select, %8 ], [ %6, %4 ], [ %spec.store.select1, %17 ], [ %15, %13 ], [ %1, %11 ]
  %.0 = phi float [ %9, %8 ], [ %5, %4 ], [ %18, %17 ], [ %14, %13 ], [ %0, %11 ]
  %21 = shl nsw i32 %.018, 23
  %22 = add nsw i32 %21, 1065353216
  %23 = bitcast i32 %22 to float
  %24 = fmul float %.0, %23
  ret float %24
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #9

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #9

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @powf(float noundef %0, float noundef %1) local_unnamed_addr #11 {
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = bitcast float %0 to i32
  %7 = bitcast float %1 to i32
  %8 = add i32 %6, -2139095040
  %9 = icmp ult i32 %8, -2130706432
  %.pre = shl i32 %7, 1
  %10 = add i32 %.pre, 16777216
  %11 = icmp ult i32 %10, 16777217
  %or.cond99 = or i1 %9, %11
  br i1 %or.cond99, label %.critedge, label %76, !prof !111

.critedge:                                        ; preds = %2
  %12 = add i32 %.pre, -1
  %13 = icmp ult i32 %12, -16777217
  br i1 %13, label %30, label %14, !prof !108

14:                                               ; preds = %.critedge
  %15 = icmp eq i32 %.pre, 0
  %16 = icmp eq i32 %6, 1065353216
  %or.cond70 = or i1 %16, %15
  br i1 %or.cond70, label %134, label %17

17:                                               ; preds = %14
  %18 = shl i32 %6, 1
  %19 = icmp ugt i32 %18, -16777216
  %20 = icmp samesign ugt i32 %.pre, -16777216
  %or.cond = or i1 %19, %20
  br i1 %or.cond, label %21, label %23

21:                                               ; preds = %17
  %22 = fadd float %0, %1
  br label %134

23:                                               ; preds = %17
  %24 = icmp eq i32 %18, 2130706432
  br i1 %24, label %134, label %25

25:                                               ; preds = %23
  %26 = icmp ult i32 %18, 2130706432
  %27 = icmp slt i32 %7, 0
  %28 = xor i1 %26, %27
  %29 = fmul float %1, %1
  %spec.select71 = select i1 %28, float 0.000000e+00, float %29
  br label %134

30:                                               ; preds = %.critedge
  %31 = shl i32 %6, 1
  %32 = add i32 %31, -1
  %33 = icmp ult i32 %32, -16777217
  br i1 %33, label %49, label %34, !prof !108

34:                                               ; preds = %30
  %35 = fmul float %0, %0
  %.not66 = icmp sgt i32 %6, -1
  br i1 %.not66, label %checkint.exit.thread, label %36

36:                                               ; preds = %34
  %37 = lshr i32 %7, 23
  %38 = and i32 %37, 255
  %39 = add nsw i32 %38, -151
  %or.cond92 = icmp ult i32 %39, -24
  br i1 %or.cond92, label %checkint.exit.thread, label %40

40:                                               ; preds = %36
  %41 = sub nuw nsw i32 150, %38
  %42 = shl nuw nsw i32 1, %41
  %43 = add nsw i32 %42, -1
  %44 = and i32 %43, %7
  %.not.i = icmp ne i32 %44, 0
  %45 = and i32 %42, %7
  %.not9.i = icmp eq i32 %45, 0
  %or.cond93 = or i1 %.not9.i, %.not.i
  %46 = fneg float %35
  %spec.select = select i1 %or.cond93, float %35, float %46
  br label %checkint.exit.thread

checkint.exit.thread:                             ; preds = %40, %36, %34
  %.057 = phi float [ %35, %34 ], [ %35, %36 ], [ %spec.select, %40 ]
  %.not67 = icmp sgt i32 %7, -1
  br i1 %.not67, label %134, label %47

47:                                               ; preds = %checkint.exit.thread
  %48 = fdiv float 1.000000e+00, %.057
  call void @llvm.lifetime.start.p0(ptr nonnull %5)
  store volatile float %48, ptr %5, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..i = load volatile float, ptr %5, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %5)
  br label %134

49:                                               ; preds = %30
  %.not64 = icmp sgt i32 %6, -1
  br i1 %.not64, label %69, label %50

50:                                               ; preds = %49
  %51 = lshr i32 %7, 23
  %52 = and i32 %51, 255
  %53 = icmp samesign ult i32 %52, 127
  br i1 %53, label %.thread, label %54

54:                                               ; preds = %50
  %55 = icmp samesign ugt i32 %52, 150
  br i1 %55, label %checkint.exit76.thread85, label %56

56:                                               ; preds = %54
  %57 = sub nuw nsw i32 150, %52
  %58 = shl nuw nsw i32 1, %57
  %59 = add nsw i32 %58, -1
  %60 = and i32 %59, %7
  %.not.i72 = icmp eq i32 %60, 0
  br i1 %.not.i72, label %61, label %.thread

61:                                               ; preds = %56
  %62 = and i32 %58, %7
  %.not9.i74 = icmp eq i32 %62, 0
  br i1 %.not9.i74, label %checkint.exit76.thread85, label %65

.thread:                                          ; preds = %56, %50
  %63 = fsub float %0, %0
  %64 = fdiv float %63, %63
  br label %134

checkint.exit76.thread85:                         ; preds = %61, %54
  br label %65

65:                                               ; preds = %checkint.exit76.thread85, %61
  %66 = phi i32 [ 0, %checkint.exit76.thread85 ], [ 65536, %61 ]
  %67 = tail call float @llvm.fabs.f32(float %0)
  %68 = bitcast float %67 to i32
  br label %69

69:                                               ; preds = %65, %49
  %.154 = phi i32 [ %68, %65 ], [ %6, %49 ]
  %.151 = phi i32 [ %66, %65 ], [ 0, %49 ]
  %70 = icmp ult i32 %.154, 8388608
  br i1 %70, label %71, label %76

71:                                               ; preds = %69
  %72 = fmul float %0, 0x4160000000000000
  %73 = tail call float @llvm.fabs.f32(float %72)
  %74 = bitcast float %73 to i32
  %75 = add nsw i32 %74, -192937984
  br label %76

76:                                               ; preds = %71, %69, %2
  %.053 = phi i32 [ %75, %71 ], [ %.154, %69 ], [ %6, %2 ]
  %.050 = phi i32 [ %.151, %71 ], [ %.151, %69 ], [ 0, %2 ]
  %77 = add i32 %.053, -1060306944
  %78 = lshr i32 %77, 19
  %79 = and i32 %78, 15
  %80 = and i32 %77, -8388608
  %81 = sub i32 %.053, %80
  %82 = ashr i32 %77, 23
  %83 = zext nneg i32 %79 to i64
  %84 = getelementptr inbounds nuw %struct.anon, ptr @__powf_log2_data, i64 %83
  %85 = load double, ptr %84, align 8, !tbaa !112
  %86 = getelementptr inbounds nuw i8, ptr %84, i64 8
  %87 = load double, ptr %86, align 8, !tbaa !115
  %88 = bitcast i32 %81 to float
  %89 = fpext float %88 to double
  %90 = tail call double @llvm.fmuladd.f64(double %89, double %85, double -1.000000e+00)
  %91 = sitofp i32 %82 to double
  %92 = fadd double %87, %91
  %93 = fmul double %90, %90
  %94 = tail call double @llvm.fmuladd.f64(double %90, double 0x3FD27616C9496E0B, double 0xBFD71969A075C67A)
  %95 = tail call double @llvm.fmuladd.f64(double %90, double 0x3FDEC70A6CA7BADD, double 0xBFE7154748BEF6C8)
  %96 = fmul double %93, %93
  %97 = tail call double @llvm.fmuladd.f64(double %90, double 0x3FF71547652AB82B, double %92)
  %98 = tail call double @llvm.fmuladd.f64(double %95, double %93, double %97)
  %99 = tail call double @llvm.fmuladd.f64(double %94, double %96, double %98)
  %100 = fpext float %1 to double
  %101 = fmul double %99, %100
  %102 = bitcast double %101 to i64
  %103 = and i64 %102, 9223231299366420480
  %104 = icmp samesign ugt i64 %103, 4638426141214900224
  br i1 %104, label %105, label %115, !prof !116

105:                                              ; preds = %76
  %106 = fcmp ogt double %101, 0x405FFFFFFFD1D571
  br i1 %106, label %107, label %110

107:                                              ; preds = %105
  %.not.i.i = icmp eq i32 %.050, 0
  %108 = select i1 %.not.i.i, float 0x4600000000000000, float 0xC600000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %4)
  store volatile float %108, ptr %4, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i = load volatile float, ptr %4, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %4)
  %109 = fmul float %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i, 0x4600000000000000
  br label %134

110:                                              ; preds = %105
  %111 = fcmp ugt double %101, -1.500000e+02
  br i1 %111, label %115, label %112

112:                                              ; preds = %110
  %.not.i.i5 = icmp eq i32 %.050, 0
  %113 = select i1 %.not.i.i5, float 0x3A00000000000000, float 0xBA00000000000000
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float %113, ptr %3, align 4, !tbaa !106
  %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i6 = load volatile float, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  %114 = fmul float %.0..0..0..0..0..0..0..0..0..0..0..0..0..0..i.i.i6, 0x3A00000000000000
  br label %134

115:                                              ; preds = %110, %76
  %116 = fadd double %101, 0x42E8000000000000
  %117 = bitcast double %116 to i64
  %118 = fadd double %116, 0xC2E8000000000000
  %119 = fsub double %101, %118
  %120 = and i64 %117, 31
  %121 = getelementptr inbounds nuw i64, ptr @__exp2f_data, i64 %120
  %122 = load i64, ptr %121, align 8, !tbaa !109
  %123 = zext nneg i32 %.050 to i64
  %124 = add i64 %117, %123
  %125 = shl i64 %124, 47
  %126 = add i64 %122, %125
  %127 = bitcast i64 %126 to double
  %128 = tail call double @llvm.fmuladd.f64(double %119, double 0x3FAC6AF84B912394, double 0x3FCEBFCE50FAC4F3)
  %129 = fmul double %119, %119
  %130 = tail call double @llvm.fmuladd.f64(double %119, double 0x3FE62E42FF0C52D6, double 1.000000e+00)
  %131 = tail call double @llvm.fmuladd.f64(double %128, double %129, double %130)
  %132 = fmul double %131, %127
  %133 = fptrunc double %132 to float
  br label %134

134:                                              ; preds = %115, %112, %107, %.thread, %47, %checkint.exit.thread, %25, %23, %21, %14
  %.0 = phi float [ %22, %21 ], [ 1.000000e+00, %14 ], [ 1.000000e+00, %23 ], [ %.0..0..0..0..0..0..0..0..0..0..i, %47 ], [ %.057, %checkint.exit.thread ], [ %109, %107 ], [ %114, %112 ], [ %133, %115 ], [ %spec.select71, %25 ], [ %64, %.thread ]
  ret float %.0
}

; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define internal noundef float @rintf(float noundef %0) local_unnamed_addr #10 {
  %2 = bitcast float %0 to i32
  %3 = and i32 %2, 2130706432
  %4 = icmp samesign ugt i32 %3, 1249902592
  br i1 %4, label %13, label %5

5:                                                ; preds = %1
  %.not = icmp sgt i32 %2, -1
  %6 = fadd float %0, 0xC160000000000000
  %7 = fadd float %6, 0x4160000000000000
  %8 = fadd float %0, 0x4160000000000000
  %9 = fadd float %8, 0xC160000000000000
  %.0 = select i1 %.not, float %9, float %7
  %10 = fcmp oeq float %.0, 0.000000e+00
  br i1 %10, label %11, label %13

11:                                               ; preds = %5
  %12 = select i1 %.not, float 0.000000e+00, float -0.000000e+00
  br label %13

13:                                               ; preds = %11, %5, %1
  %.010 = phi float [ %12, %11 ], [ %0, %1 ], [ %.0, %5 ]
  ret float %.010
}

; Function Attrs: inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite)
define internal float @roundf(float noundef %0) local_unnamed_addr #11 {
  %2 = alloca float, align 4
  %3 = bitcast float %0 to i32
  %4 = lshr i32 %3, 23
  %5 = and i32 %4, 255
  %6 = icmp samesign ugt i32 %5, 149
  br i1 %6, label %26, label %7

7:                                                ; preds = %1
  %spec.select = tail call float @llvm.fabs.f32(float %0)
  %8 = icmp samesign ult i32 %5, 126
  %9 = fadd float %spec.select, 0x4160000000000000
  br i1 %8, label %10, label %12

10:                                               ; preds = %7
  call void @llvm.lifetime.start.p0(ptr nonnull %2)
  store volatile float %9, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  %11 = fmul float %0, 0.000000e+00
  br label %26

12:                                               ; preds = %7
  %13 = fadd float %9, 0xC160000000000000
  %14 = fsub float %13, %spec.select
  %15 = fcmp ogt float %14, 5.000000e-01
  br i1 %15, label %16, label %19

16:                                               ; preds = %12
  %17 = fadd float %spec.select, %14
  %18 = fadd float %17, -1.000000e+00
  br label %24

19:                                               ; preds = %12
  %20 = fcmp ugt float %14, -5.000000e-01
  %21 = fadd float %spec.select, %14
  br i1 %20, label %24, label %22

22:                                               ; preds = %19
  %23 = fadd float %21, 1.000000e+00
  br label %24

24:                                               ; preds = %22, %19, %16
  %.0 = phi float [ %18, %16 ], [ %23, %22 ], [ %21, %19 ]
  %25 = fneg float %.0
  %.not26 = icmp slt i32 %3, 0
  %spec.select25 = select i1 %.not26, float %25, float %.0
  br label %26

26:                                               ; preds = %24, %10, %1
  %.020 = phi float [ %11, %10 ], [ %spec.select25, %24 ], [ %0, %1 ]
  ret float %.020
}

attributes #0 = { nounwind "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #1 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: write, target_mem0: none, target_mem1: none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: write, target_mem0: none, target_mem1: none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #5 = { mustprogress nounwind willreturn "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #6 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "nonlazybind" }
attributes #7 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #8 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #9 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { inlinehint mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #11 = { inlinehint nofree norecurse nounwind memory(inaccessiblemem: readwrite) }
attributes #12 = { inlinehint nofree norecurse nosync nounwind memory(none) }
attributes #13 = { inlinehint nofree nosync nounwind memory(argmem: readwrite) }
attributes #14 = { inlinehint }

!llvm.dbg.cu = !{!0, !2, !4}
!llvm.module.flags = !{!6, !7}
!llvm.errno.tbaa = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "configured_module_matmul_i8_quantized_dispatch_0.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files")
!2 = distinct !DICompileUnit(language: DW_LANG_C17, file: !3, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!3 = !DIFile(filename: "configured_module__encoding_0.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files")
!4 = distinct !DICompileUnit(language: DW_LANG_C17, file: !5, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!5 = !DIFile(filename: "configured_module__encoding_1.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files")
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = distinct !DISubprogram(name: "matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32", linkageName: "matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32", scope: !1, file: !1, line: 1, type: !13, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!13 = !DISubroutineType(cc: DW_CC_normal, types: !14)
!14 = !{!15, !16, !47, !76}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_environment_v0_t", baseType: !19)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_environment_v0_t", scope: !20, file: !20, line: 246, size: 768, elements: !21)
!20 = !DIFile(filename: "runtime/src/iree/hal/local/executable_library.h", directory: ".")
!21 = !{!22, !30, !33, !36, !38}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "constants", baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !25)
!25 = !DICompositeType(tag: DW_TAG_array_type, scope: !20, file: !20, line: 227, baseType: !26, size: 2048, elements: !28)
!26 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", baseType: !27)
!27 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!28 = !{!29}
!29 = !DISubrange(count: 64)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "import_thunk", baseType: !31, size: 64, offset: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DIBasicType(name: "void", encoding: DW_ATE_address)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "import_funcs", baseType: !34, size: 64, offset: 128)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "import_contexts", baseType: !37, size: 64, offset: 192)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "processor", baseType: !39, offset: 256)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_processor_v0_t", scope: !20, file: !20, line: 227, size: 512, elements: !40)
!40 = !{!41}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "data", baseType: !42)
!42 = !DICompositeType(tag: DW_TAG_array_type, scope: !20, file: !20, line: 227, baseType: !43, size: 512, elements: !45)
!43 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", baseType: !44)
!44 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!45 = !{!46}
!46 = !DISubrange(count: 8)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !49)
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_dispatch_state_v0_t", baseType: !50)
!50 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_dispatch_state_v0_t", scope: !20, file: !20, line: 275, size: 384, elements: !51)
!51 = !{!52, !53, !54, !57, !58, !59, !60, !61, !64, !65, !66, !71}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_x", baseType: !26, size: 32)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_y", baseType: !26, size: 32, offset: 32)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_z", baseType: !55, size: 16, offset: 64)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", baseType: !56)
!56 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "constant_count", baseType: !55, size: 16, offset: 80)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_x", baseType: !26, size: 32, offset: 96)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_y", baseType: !26, size: 32, offset: 128)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_z", baseType: !55, size: 16, offset: 160)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "max_concurrency", baseType: !62, size: 8, offset: 176)
!62 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", baseType: !63)
!63 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "binding_count", baseType: !62, size: 8, offset: 184)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "constants", baseType: !23, size: 64, offset: 192)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "binding_ptrs", baseType: !67, size: 64, offset: 256)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !69)
!69 = !DICompositeType(tag: DW_TAG_array_type, scope: !20, file: !20, line: 227, baseType: !70, size: 4096, elements: !28)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !62, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "binding_lengths", baseType: !72, size: 64, offset: 320)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !74)
!74 = !DICompositeType(tag: DW_TAG_array_type, scope: !20, file: !20, line: 227, baseType: !75, size: 4096, elements: !28)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", baseType: !43)
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !78)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_workgroup_state_v0_t", baseType: !79)
!79 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_workgroup_state_v0_t", scope: !20, file: !20, line: 321, size: 256, elements: !80)
!80 = !{!81, !82, !83, !84, !85, !86, !87}
!81 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_x", baseType: !26, size: 32)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_y", baseType: !26, size: 32, offset: 32)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_z", baseType: !55, size: 16, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", baseType: !55, size: 16, offset: 80)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "processor_id", baseType: !26, size: 32, offset: 96)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "local_memory", baseType: !31, size: 64, offset: 128)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "local_memory_size", baseType: !26, size: 32, offset: 192)
!88 = !DILocation(line: 12, column: 8, scope: !12)
!89 = !DILocation(line: 13, column: 8, scope: !12)
!90 = !DILocation(line: 14, column: 8, scope: !12)
!91 = !DILocation(line: 19, column: 8, scope: !12)
!92 = !DILocation(line: 21, column: 8, scope: !12)
!93 = !DILocation(line: 23, column: 8, scope: !12)
!94 = distinct !DISubprogram(name: "_encoding_0_encode_32x64xi8_to_32x64xi8", linkageName: "_encoding_0_encode_32x64xi8_to_32x64xi8", scope: !3, file: !3, line: 1, type: !13, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2)
!95 = !DILocation(line: 10, column: 8, scope: !94)
!96 = !DILocation(line: 11, column: 8, scope: !94)
!97 = !DILocation(line: 14, column: 8, scope: !94)
!98 = !DILocation(line: 16, column: 8, scope: !94)
!99 = distinct !DISubprogram(name: "_encoding_1_encode_64x32xi8_to_64x32xi8", linkageName: "_encoding_1_encode_64x32xi8_to_64x32xi8", scope: !5, file: !5, line: 1, type: !13, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!100 = !DILocation(line: 11, column: 8, scope: !99)
!101 = !DILocation(line: 12, column: 8, scope: !99)
!102 = !DILocation(line: 15, column: 8, scope: !99)
!103 = !DILocation(line: 17, column: 8, scope: !99)
!104 = !{!105, !105, i64 0}
!105 = !{!"short", !10, i64 0}
!106 = !{!107, !107, i64 0}
!107 = !{!"float", !10, i64 0}
!108 = !{!"branch_weights", !"expected", i32 2000, i32 1}
!109 = !{!110, !110, i64 0}
!110 = !{!"long", !10, i64 0}
!111 = !{!"branch_weights", i32 4001, i32 4000000}
!112 = !{!113, !114, i64 0}
!113 = !{!"", !114, i64 0, !114, i64 8}
!114 = !{!"double", !10, i64 0}
!115 = !{!113, !114, i64 8}
!116 = !{!"branch_weights", !"expected", i32 1, i32 2000}
