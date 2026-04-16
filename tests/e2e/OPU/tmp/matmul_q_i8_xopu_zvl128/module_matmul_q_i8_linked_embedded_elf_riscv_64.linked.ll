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
%iree_hal_executable_dispatch_state_v0_t = type { i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr }
%iree_hal_executable_workgroup_state_v0_t = type { i32, i32, i16, i16, i32, ptr, i32 }

@0 = private constant [19 x i8] c"matmul_q_i8_linked\00", align 1
@iree_hal_executable_library_query_v0_header = private constant %iree_hal_executable_library_header_t { i32 6, ptr @0, i32 0, i32 0 }
@iree_hal_executable_library_query_v0_funcs = private constant [3 x ptr] [ptr @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32, ptr @_encoding_0_encode_32x64xi8_to_32x64xi8, ptr @_encoding_1_encode_64x32xi8_to_64x32xi8]
@iree_hal_executable_library_query_v0_attrs = private constant [3 x %iree_hal_executable_dispatch_attrs_v0_t] [%iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }, %iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }, %iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }]
@1 = private constant [57 x i8] c"matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32\00", align 1
@2 = private constant [40 x i8] c"_encoding_0_encode_32x64xi8_to_32x64xi8\00", align 1
@3 = private constant [40 x i8] c"_encoding_1_encode_64x32xi8_to_64x32xi8\00", align 1
@iree_hal_executable_library_query_v0_names = private constant [3 x ptr] [ptr @1, ptr @2, ptr @3]
@4 = private constant [148 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files/configured_module_matmul_i8_quantized_dispatch_0.mlir\00", align 1
@5 = private constant [129 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files/configured_module__encoding_0.mlir\00", align 1
@6 = private constant [129 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files/configured_module__encoding_1.mlir\00", align 1
@iree_hal_executable_library_query_v0_source_locations = private constant [3 x %iree_hal_executable_source_location_v0_t] [%iree_hal_executable_source_location_v0_t { i32 3, i32 147, ptr @4 }, %iree_hal_executable_source_location_v0_t { i32 3, i32 128, ptr @5 }, %iree_hal_executable_source_location_v0_t { i32 3, i32 128, ptr @6 }]
@iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0_stage_location_tables = private constant [3 x %iree_hal_executable_stage_location_table_v0_t] [%iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names, ptr @iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations }]
@iree_hal_executable_library_query_v0 = private constant %iree_hal_executable_library_v0_t { ptr @iree_hal_executable_library_query_v0_header, %iree_hal_executable_import_table_v0_t zeroinitializer, %iree_hal_executable_export_table_v0_t { i32 3, ptr @iree_hal_executable_library_query_v0_funcs, ptr @iree_hal_executable_library_query_v0_attrs, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_names, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_source_locations, ptr @iree_hal_executable_library_query_v0_stage_location_tables }, %iree_hal_executable_constant_table_v0_t zeroinitializer, %iree_hal_executable_source_file_table_v0_t zeroinitializer }
@__exp2f_data = hidden local_unnamed_addr constant %struct.exp2f_data { [32 x i64] [i64 4607182418800017408, i64 4607140297302181236, i64 4607100335213349135, i64 4607062579818421073, i64 4607027079437701499, i64 4606993883449571754, i64 4606963042313658936, i64 4606934607594512097, i64 4606908631985796885, i64 4606885169335019979, i64 4606864274668794914, i64 4606846004218661165, i64 4606830415447468583, i64 4606817567076339586, i64 4606807519112221737, i64 4606800332876043653, i64 4606796071031487437, i64 4606794797614391156, i64 4606796578062795143, i64 4606801479247646227, i64 4606809569504174299, i64 4606820918663955941, i64 4606835598087680144, i64 4606853680698631517, i64 4606875241016906669, i64 4606900355194379847, i64 4606929101050434204, i64 4606961558108475497, i64 4606997807633245319, i64 4607037932668951391, i64 4607082018078232794, i64 4607130150581978432], double 0x42E8000000000000, [3 x double] [double 0x3FAC6AF84B912394, double 0x3FCEBFCE50FAC4F3, double 0x3FE62E42FF0C52D6], double 0x4338000000000000, double 0x40471547652B82FE, [3 x double] [double 0x3EBC6AF84B912394, double 0x3F2EBFCE50FAC4F3, double 0x3F962E42FF0C52D6] }, align 8
@__powf_log2_data = hidden local_unnamed_addr constant %struct.powf_log2_data { [16 x %struct.anon] [%struct.anon { double 0x3FF661EC79F8F3BE, double 0xBFDEFEC65B963019 }, %struct.anon { double 0x3FF571ED4AAF883D, double 0xBFDB0B6832D4FCA4 }, %struct.anon { double 0x3FF49539F0F010B0, double 0xBFD7418B0A1FB77B }, %struct.anon { double 0x3FF3C995B0B80385, double 0xBFD39DE91A6DCF7B }, %struct.anon { double 0x3FF30D190C8864A5, double 0xBFD01D9BF3F2B631 }, %struct.anon { double 0x3FF25E227B0B8EA0, double 0xBFC97C1D1B3B7AF0 }, %struct.anon { double 0x3FF1BB4A4A1A343F, double 0xBFC2F9E393AF3C9F }, %struct.anon { double 0x3FF12358F08AE5BA, double 0xBFB960CBBF788D5C }, %struct.anon { double 0x3FF0953F419900A7, double 0xBFAA6F9DB6475FCE }, %struct.anon { double 1.000000e+00, double 0.000000e+00 }, %struct.anon { double 0x3FEE608CFD9A47AC, double 0x3FB338CA9F24F53D }, %struct.anon { double 0x3FECA4B31F026AA0, double 0x3FC476A9543891BA }, %struct.anon { double 0x3FEB2036576AFCE6, double 0x3FCE840B4AC4E4D2 }, %struct.anon { double 0x3FE9C2D163A1AA2D, double 0x3FD40645F0C6651C }, %struct.anon { double 0x3FE886E6037841ED, double 0x3FD88E9C2C1B9FF8 }, %struct.anon { double 0x3FE767DCF5534862, double 0x3FDCE0A44EB17BCC }], [5 x double] [double 0x3FD27616C9496E0B, double 0xBFD71969A075C67A, double 0x3FDEC70A6CA7BADD, double 0xBFE7154748BEF6C8, double 0x3FF71547652AB82B] }, align 8

define internal i32 @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !12 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !88
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !88
  %6 = load ptr, ptr %5, align 8, !dbg !88
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !88
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !89
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !89
  %9 = load ptr, ptr %8, align 8, !dbg !89
  %10 = getelementptr i8, ptr %9, i64 2048, !dbg !89
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !89
  %11 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !90
  %12 = extractvalue %iree_hal_executable_dispatch_state_v0_t %11, 10, !dbg !90
  %13 = getelementptr ptr, ptr %12, i32 1, !dbg !90
  %14 = load ptr, ptr %13, align 8, !dbg !90
  call void @llvm.assume(i1 true) [ "align"(ptr %14, i64 64) ], !dbg !90
  %15 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !91
  %16 = extractvalue %iree_hal_executable_workgroup_state_v0_t %15, 0, !dbg !91
  %17 = zext i32 %16 to i64, !dbg !91
  %18 = sdiv i64 %17, 2, !dbg !91
  %19 = mul i64 %18, 2, !dbg !91
  %20 = icmp ne i64 %17, %19, !dbg !91
  %21 = icmp slt i64 %17, 0, !dbg !91
  %22 = and i1 %20, %21, !dbg !91
  %23 = add i64 %18, -1, !dbg !91
  %24 = select i1 %22, i64 %23, i64 %18, !dbg !91
  %25 = srem i64 %17, 2, !dbg !91
  %26 = icmp slt i64 %25, 0, !dbg !91
  %27 = add nsw i64 %25, 2, !dbg !91
  %28 = select i1 %26, i64 %27, i64 %25, !dbg !91
  %29 = mul nsw i64 %24, 16, !dbg !92
  %30 = mul nsw i64 %28, 16, !dbg !92
  br label %31, !dbg !91

31:                                               ; preds = %35, %3
  %32 = phi i64 [ %132, %35 ], [ 0, %3 ], !dbg !91
  %33 = phi [16 x <16 x i32>] [ %131, %35 ], [ zeroinitializer, %3 ], !dbg !91
  %34 = icmp slt i64 %32, 64, !dbg !91
  br i1 %34, label %35, label %133, !dbg !91

35:                                               ; preds = %31
  %36 = mul i64 %24, 1024, !dbg !91
  %37 = mul i64 %32, 16, !dbg !91
  %38 = add i64 %36, %37, !dbg !91
  %39 = add i64 %38, 0, !dbg !91
  %40 = add i64 %39, 0, !dbg !91
  %41 = getelementptr i8, ptr %6, i64 %40, !dbg !91
  %42 = load <16 x i8>, ptr %41, align 1, !dbg !91
  %43 = mul i64 %28, 1024, !dbg !91
  %44 = add i64 %43, %37, !dbg !91
  %45 = add i64 %44, 0, !dbg !91
  %46 = add i64 %45, 0, !dbg !91
  %47 = getelementptr i8, ptr %10, i64 %46, !dbg !91
  %48 = load <16 x i8>, ptr %47, align 1, !dbg !91
  %49 = extractvalue [16 x <16 x i32>] %33, 0
  %50 = extractvalue [16 x <16 x i32>] %33, 1
  %51 = extractvalue [16 x <16 x i32>] %33, 2
  %52 = extractvalue [16 x <16 x i32>] %33, 3
  %53 = extractvalue [16 x <16 x i32>] %33, 4
  %54 = extractvalue [16 x <16 x i32>] %33, 5
  %55 = extractvalue [16 x <16 x i32>] %33, 6
  %56 = extractvalue [16 x <16 x i32>] %33, 7
  %57 = extractvalue [16 x <16 x i32>] %33, 8
  %58 = extractvalue [16 x <16 x i32>] %33, 9
  %59 = extractvalue [16 x <16 x i32>] %33, 10
  %60 = extractvalue [16 x <16 x i32>] %33, 11
  %61 = extractvalue [16 x <16 x i32>] %33, 12
  %62 = extractvalue [16 x <16 x i32>] %33, 13
  %63 = extractvalue [16 x <16 x i32>] %33, 14
  %64 = extractvalue [16 x <16 x i32>] %33, 15
  %65 = call <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v16i8(<vscale x 8 x i8> undef, <16 x i8> %42, i64 0)
  %66 = call <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v16i8(<vscale x 8 x i8> undef, <16 x i8> %48, i64 0)
  %67 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> zeroinitializer, i64 0)
  call void @llvm.riscv.opu.bcast.nxv8i32.i64(<vscale x 8 x i32> %67, i64 16)
  %68 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %49, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 0, <vscale x 8 x i32> %68, i64 16)
  %69 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %50, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 1, <vscale x 8 x i32> %69, i64 16)
  %70 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %51, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 2, <vscale x 8 x i32> %70, i64 16)
  %71 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %52, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 3, <vscale x 8 x i32> %71, i64 16)
  %72 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %53, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 4, <vscale x 8 x i32> %72, i64 16)
  %73 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %54, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 5, <vscale x 8 x i32> %73, i64 16)
  %74 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %55, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 6, <vscale x 8 x i32> %74, i64 16)
  %75 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %56, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 7, <vscale x 8 x i32> %75, i64 16)
  %76 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %57, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 8, <vscale x 8 x i32> %76, i64 16)
  %77 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %58, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 9, <vscale x 8 x i32> %77, i64 16)
  %78 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %59, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 10, <vscale x 8 x i32> %78, i64 16)
  %79 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %60, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 11, <vscale x 8 x i32> %79, i64 16)
  %80 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %61, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 12, <vscale x 8 x i32> %80, i64 16)
  %81 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %62, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 13, <vscale x 8 x i32> %81, i64 16)
  %82 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %63, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 14, <vscale x 8 x i32> %82, i64 16)
  %83 = call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32> undef, <16 x i32> %64, i64 0)
  call void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64 15, <vscale x 8 x i32> %83, i64 16)
  call void @llvm.riscv.opu.vopacc.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> %65, <vscale x 8 x i8> %66, i64 16)
  %84 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 0, i64 16)
  %85 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %84, i64 0)
  %86 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 1, i64 16)
  %87 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %86, i64 0)
  %88 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 2, i64 16)
  %89 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %88, i64 0)
  %90 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 3, i64 16)
  %91 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %90, i64 0)
  %92 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 4, i64 16)
  %93 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %92, i64 0)
  %94 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 5, i64 16)
  %95 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %94, i64 0)
  %96 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 6, i64 16)
  %97 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %96, i64 0)
  %98 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 7, i64 16)
  %99 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %98, i64 0)
  %100 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 8, i64 16)
  %101 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %100, i64 0)
  %102 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 9, i64 16)
  %103 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %102, i64 0)
  %104 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 10, i64 16)
  %105 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %104, i64 0)
  %106 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 11, i64 16)
  %107 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %106, i64 0)
  %108 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 12, i64 16)
  %109 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %108, i64 0)
  %110 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 13, i64 16)
  %111 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %110, i64 0)
  %112 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 14, i64 16)
  %113 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %112, i64 0)
  %114 = call <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64 15, i64 16)
  %115 = call <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32> %114, i64 0)
  %116 = insertvalue [16 x <16 x i32>] poison, <16 x i32> %85, 0
  %117 = insertvalue [16 x <16 x i32>] %116, <16 x i32> %87, 1
  %118 = insertvalue [16 x <16 x i32>] %117, <16 x i32> %89, 2
  %119 = insertvalue [16 x <16 x i32>] %118, <16 x i32> %91, 3
  %120 = insertvalue [16 x <16 x i32>] %119, <16 x i32> %93, 4
  %121 = insertvalue [16 x <16 x i32>] %120, <16 x i32> %95, 5
  %122 = insertvalue [16 x <16 x i32>] %121, <16 x i32> %97, 6
  %123 = insertvalue [16 x <16 x i32>] %122, <16 x i32> %99, 7
  %124 = insertvalue [16 x <16 x i32>] %123, <16 x i32> %101, 8
  %125 = insertvalue [16 x <16 x i32>] %124, <16 x i32> %103, 9
  %126 = insertvalue [16 x <16 x i32>] %125, <16 x i32> %105, 10
  %127 = insertvalue [16 x <16 x i32>] %126, <16 x i32> %107, 11
  %128 = insertvalue [16 x <16 x i32>] %127, <16 x i32> %109, 12
  %129 = insertvalue [16 x <16 x i32>] %128, <16 x i32> %111, 13
  %130 = insertvalue [16 x <16 x i32>] %129, <16 x i32> %113, 14
  %131 = insertvalue [16 x <16 x i32>] %130, <16 x i32> %115, 15
  %132 = add i64 %32, 1, !dbg !91
  br label %31, !dbg !91

133:                                              ; preds = %31
  %134 = extractvalue [16 x <16 x i32>] %33, 0, !dbg !92
  %135 = mul i64 %29, 32, !dbg !92
  %136 = add i64 %135, %30, !dbg !92
  %137 = getelementptr i32, ptr %14, i64 %136, !dbg !92
  store <16 x i32> %134, ptr %137, align 4, !dbg !92
  %138 = extractvalue [16 x <16 x i32>] %33, 1, !dbg !92
  %139 = add i64 %29, 1, !dbg !92
  %140 = mul i64 %139, 32, !dbg !92
  %141 = add i64 %140, %30, !dbg !92
  %142 = getelementptr i32, ptr %14, i64 %141, !dbg !92
  store <16 x i32> %138, ptr %142, align 4, !dbg !92
  %143 = extractvalue [16 x <16 x i32>] %33, 2, !dbg !92
  %144 = add i64 %29, 2, !dbg !92
  %145 = mul i64 %144, 32, !dbg !92
  %146 = add i64 %145, %30, !dbg !92
  %147 = getelementptr i32, ptr %14, i64 %146, !dbg !92
  store <16 x i32> %143, ptr %147, align 4, !dbg !92
  %148 = extractvalue [16 x <16 x i32>] %33, 3, !dbg !92
  %149 = add i64 %29, 3, !dbg !92
  %150 = mul i64 %149, 32, !dbg !92
  %151 = add i64 %150, %30, !dbg !92
  %152 = getelementptr i32, ptr %14, i64 %151, !dbg !92
  store <16 x i32> %148, ptr %152, align 4, !dbg !92
  %153 = extractvalue [16 x <16 x i32>] %33, 4, !dbg !92
  %154 = add i64 %29, 4, !dbg !92
  %155 = mul i64 %154, 32, !dbg !92
  %156 = add i64 %155, %30, !dbg !92
  %157 = getelementptr i32, ptr %14, i64 %156, !dbg !92
  store <16 x i32> %153, ptr %157, align 4, !dbg !92
  %158 = extractvalue [16 x <16 x i32>] %33, 5, !dbg !92
  %159 = add i64 %29, 5, !dbg !92
  %160 = mul i64 %159, 32, !dbg !92
  %161 = add i64 %160, %30, !dbg !92
  %162 = getelementptr i32, ptr %14, i64 %161, !dbg !92
  store <16 x i32> %158, ptr %162, align 4, !dbg !92
  %163 = extractvalue [16 x <16 x i32>] %33, 6, !dbg !92
  %164 = add i64 %29, 6, !dbg !92
  %165 = mul i64 %164, 32, !dbg !92
  %166 = add i64 %165, %30, !dbg !92
  %167 = getelementptr i32, ptr %14, i64 %166, !dbg !92
  store <16 x i32> %163, ptr %167, align 4, !dbg !92
  %168 = extractvalue [16 x <16 x i32>] %33, 7, !dbg !92
  %169 = add i64 %29, 7, !dbg !92
  %170 = mul i64 %169, 32, !dbg !92
  %171 = add i64 %170, %30, !dbg !92
  %172 = getelementptr i32, ptr %14, i64 %171, !dbg !92
  store <16 x i32> %168, ptr %172, align 4, !dbg !92
  %173 = extractvalue [16 x <16 x i32>] %33, 8, !dbg !92
  %174 = add i64 %29, 8, !dbg !92
  %175 = mul i64 %174, 32, !dbg !92
  %176 = add i64 %175, %30, !dbg !92
  %177 = getelementptr i32, ptr %14, i64 %176, !dbg !92
  store <16 x i32> %173, ptr %177, align 4, !dbg !92
  %178 = extractvalue [16 x <16 x i32>] %33, 9, !dbg !92
  %179 = add i64 %29, 9, !dbg !92
  %180 = mul i64 %179, 32, !dbg !92
  %181 = add i64 %180, %30, !dbg !92
  %182 = getelementptr i32, ptr %14, i64 %181, !dbg !92
  store <16 x i32> %178, ptr %182, align 4, !dbg !92
  %183 = extractvalue [16 x <16 x i32>] %33, 10, !dbg !92
  %184 = add i64 %29, 10, !dbg !92
  %185 = mul i64 %184, 32, !dbg !92
  %186 = add i64 %185, %30, !dbg !92
  %187 = getelementptr i32, ptr %14, i64 %186, !dbg !92
  store <16 x i32> %183, ptr %187, align 4, !dbg !92
  %188 = extractvalue [16 x <16 x i32>] %33, 11, !dbg !92
  %189 = add i64 %29, 11, !dbg !92
  %190 = mul i64 %189, 32, !dbg !92
  %191 = add i64 %190, %30, !dbg !92
  %192 = getelementptr i32, ptr %14, i64 %191, !dbg !92
  store <16 x i32> %188, ptr %192, align 4, !dbg !92
  %193 = extractvalue [16 x <16 x i32>] %33, 12, !dbg !92
  %194 = add i64 %29, 12, !dbg !92
  %195 = mul i64 %194, 32, !dbg !92
  %196 = add i64 %195, %30, !dbg !92
  %197 = getelementptr i32, ptr %14, i64 %196, !dbg !92
  store <16 x i32> %193, ptr %197, align 4, !dbg !92
  %198 = extractvalue [16 x <16 x i32>] %33, 13, !dbg !92
  %199 = add i64 %29, 13, !dbg !92
  %200 = mul i64 %199, 32, !dbg !92
  %201 = add i64 %200, %30, !dbg !92
  %202 = getelementptr i32, ptr %14, i64 %201, !dbg !92
  store <16 x i32> %198, ptr %202, align 4, !dbg !92
  %203 = extractvalue [16 x <16 x i32>] %33, 14, !dbg !92
  %204 = add i64 %29, 14, !dbg !92
  %205 = mul i64 %204, 32, !dbg !92
  %206 = add i64 %205, %30, !dbg !92
  %207 = getelementptr i32, ptr %14, i64 %206, !dbg !92
  store <16 x i32> %203, ptr %207, align 4, !dbg !92
  %208 = extractvalue [16 x <16 x i32>] %33, 15, !dbg !92
  %209 = add i64 %29, 15, !dbg !92
  %210 = mul i64 %209, 32, !dbg !92
  %211 = add i64 %210, %30, !dbg !92
  %212 = getelementptr i32, ptr %14, i64 %211, !dbg !92
  store <16 x i32> %208, ptr %212, align 4, !dbg !92
  ret i32 0, !dbg !93
}

define internal i32 @_encoding_0_encode_32x64xi8_to_32x64xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !94 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !95
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !95
  %6 = load ptr, ptr %5, align 8, !dbg !95
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !95
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !96
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !96
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !96
  %10 = load ptr, ptr %9, align 8, !dbg !96
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !96
  %11 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !97
  %12 = extractvalue %iree_hal_executable_workgroup_state_v0_t %11, 0, !dbg !97
  %13 = zext i32 %12 to i64, !dbg !97
  %14 = sdiv i64 %13, 8, !dbg !97
  %15 = mul i64 %14, 8, !dbg !97
  %16 = icmp ne i64 %13, %15, !dbg !97
  %17 = icmp slt i64 %13, 0, !dbg !97
  %18 = and i1 %16, %17, !dbg !97
  %19 = add i64 %14, -1, !dbg !97
  %20 = select i1 %18, i64 %19, i64 %14, !dbg !97
  %21 = srem i64 %13, 8, !dbg !97
  %22 = icmp slt i64 %21, 0, !dbg !97
  %23 = add nsw i64 %21, 8, !dbg !97
  %24 = select i1 %22, i64 %23, i64 %21, !dbg !97
  %25 = mul nsw i64 %24, 8, !dbg !97
  br label %26, !dbg !97

26:                                               ; preds = %29, %3
  %27 = phi i64 [ %149, %29 ], [ 0, %3 ], !dbg !97
  %28 = icmp slt i64 %27, 8, !dbg !97
  br i1 %28, label %29, label %150, !dbg !97

29:                                               ; preds = %26
  %30 = add i64 %27, %25, !dbg !97
  %31 = mul nsw i64 %20, 16, !dbg !97
  %32 = mul i64 %31, 64, !dbg !97
  %33 = add i64 %32, %30, !dbg !97
  %34 = getelementptr i8, ptr %6, i64 %33, !dbg !97
  %35 = load <1 x i8>, ptr %34, align 1, !dbg !97
  %36 = add i64 %31, 1, !dbg !97
  %37 = mul i64 %36, 64, !dbg !97
  %38 = add i64 %37, %30, !dbg !97
  %39 = getelementptr i8, ptr %6, i64 %38, !dbg !97
  %40 = load <1 x i8>, ptr %39, align 1, !dbg !97
  %41 = add i64 %31, 2, !dbg !97
  %42 = mul i64 %41, 64, !dbg !97
  %43 = add i64 %42, %30, !dbg !97
  %44 = getelementptr i8, ptr %6, i64 %43, !dbg !97
  %45 = load <1 x i8>, ptr %44, align 1, !dbg !97
  %46 = add i64 %31, 3, !dbg !97
  %47 = mul i64 %46, 64, !dbg !97
  %48 = add i64 %47, %30, !dbg !97
  %49 = getelementptr i8, ptr %6, i64 %48, !dbg !97
  %50 = load <1 x i8>, ptr %49, align 1, !dbg !97
  %51 = add i64 %31, 4, !dbg !97
  %52 = mul i64 %51, 64, !dbg !97
  %53 = add i64 %52, %30, !dbg !97
  %54 = getelementptr i8, ptr %6, i64 %53, !dbg !97
  %55 = load <1 x i8>, ptr %54, align 1, !dbg !97
  %56 = add i64 %31, 5, !dbg !97
  %57 = mul i64 %56, 64, !dbg !97
  %58 = add i64 %57, %30, !dbg !97
  %59 = getelementptr i8, ptr %6, i64 %58, !dbg !97
  %60 = load <1 x i8>, ptr %59, align 1, !dbg !97
  %61 = add i64 %31, 6, !dbg !97
  %62 = mul i64 %61, 64, !dbg !97
  %63 = add i64 %62, %30, !dbg !97
  %64 = getelementptr i8, ptr %6, i64 %63, !dbg !97
  %65 = load <1 x i8>, ptr %64, align 1, !dbg !97
  %66 = add i64 %31, 7, !dbg !97
  %67 = mul i64 %66, 64, !dbg !97
  %68 = add i64 %67, %30, !dbg !97
  %69 = getelementptr i8, ptr %6, i64 %68, !dbg !97
  %70 = load <1 x i8>, ptr %69, align 1, !dbg !97
  %71 = add i64 %31, 8, !dbg !97
  %72 = mul i64 %71, 64, !dbg !97
  %73 = add i64 %72, %30, !dbg !97
  %74 = getelementptr i8, ptr %6, i64 %73, !dbg !97
  %75 = load <1 x i8>, ptr %74, align 1, !dbg !97
  %76 = add i64 %31, 9, !dbg !97
  %77 = mul i64 %76, 64, !dbg !97
  %78 = add i64 %77, %30, !dbg !97
  %79 = getelementptr i8, ptr %6, i64 %78, !dbg !97
  %80 = load <1 x i8>, ptr %79, align 1, !dbg !97
  %81 = add i64 %31, 10, !dbg !97
  %82 = mul i64 %81, 64, !dbg !97
  %83 = add i64 %82, %30, !dbg !97
  %84 = getelementptr i8, ptr %6, i64 %83, !dbg !97
  %85 = load <1 x i8>, ptr %84, align 1, !dbg !97
  %86 = add i64 %31, 11, !dbg !97
  %87 = mul i64 %86, 64, !dbg !97
  %88 = add i64 %87, %30, !dbg !97
  %89 = getelementptr i8, ptr %6, i64 %88, !dbg !97
  %90 = load <1 x i8>, ptr %89, align 1, !dbg !97
  %91 = add i64 %31, 12, !dbg !97
  %92 = mul i64 %91, 64, !dbg !97
  %93 = add i64 %92, %30, !dbg !97
  %94 = getelementptr i8, ptr %6, i64 %93, !dbg !97
  %95 = load <1 x i8>, ptr %94, align 1, !dbg !97
  %96 = add i64 %31, 13, !dbg !97
  %97 = mul i64 %96, 64, !dbg !97
  %98 = add i64 %97, %30, !dbg !97
  %99 = getelementptr i8, ptr %6, i64 %98, !dbg !97
  %100 = load <1 x i8>, ptr %99, align 1, !dbg !97
  %101 = add i64 %31, 14, !dbg !97
  %102 = mul i64 %101, 64, !dbg !97
  %103 = add i64 %102, %30, !dbg !97
  %104 = getelementptr i8, ptr %6, i64 %103, !dbg !97
  %105 = load <1 x i8>, ptr %104, align 1, !dbg !97
  %106 = add i64 %31, 15, !dbg !97
  %107 = mul i64 %106, 64, !dbg !97
  %108 = add i64 %107, %30, !dbg !97
  %109 = getelementptr i8, ptr %6, i64 %108, !dbg !97
  %110 = load <1 x i8>, ptr %109, align 1, !dbg !97
  %111 = extractelement <1 x i8> %35, i64 0, !dbg !97
  %112 = extractelement <1 x i8> %40, i64 0, !dbg !97
  %113 = extractelement <1 x i8> %45, i64 0, !dbg !97
  %114 = extractelement <1 x i8> %50, i64 0, !dbg !97
  %115 = extractelement <1 x i8> %55, i64 0, !dbg !97
  %116 = extractelement <1 x i8> %60, i64 0, !dbg !97
  %117 = extractelement <1 x i8> %65, i64 0, !dbg !97
  %118 = extractelement <1 x i8> %70, i64 0, !dbg !97
  %119 = extractelement <1 x i8> %75, i64 0, !dbg !97
  %120 = extractelement <1 x i8> %80, i64 0, !dbg !97
  %121 = extractelement <1 x i8> %85, i64 0, !dbg !97
  %122 = extractelement <1 x i8> %90, i64 0, !dbg !97
  %123 = extractelement <1 x i8> %95, i64 0, !dbg !97
  %124 = extractelement <1 x i8> %100, i64 0, !dbg !97
  %125 = extractelement <1 x i8> %105, i64 0, !dbg !97
  %126 = extractelement <1 x i8> %110, i64 0, !dbg !97
  %127 = insertelement <16 x i8> poison, i8 %111, i64 0, !dbg !97
  %128 = insertelement <16 x i8> %127, i8 %112, i64 1, !dbg !97
  %129 = insertelement <16 x i8> %128, i8 %113, i64 2, !dbg !97
  %130 = insertelement <16 x i8> %129, i8 %114, i64 3, !dbg !97
  %131 = insertelement <16 x i8> %130, i8 %115, i64 4, !dbg !97
  %132 = insertelement <16 x i8> %131, i8 %116, i64 5, !dbg !97
  %133 = insertelement <16 x i8> %132, i8 %117, i64 6, !dbg !97
  %134 = insertelement <16 x i8> %133, i8 %118, i64 7, !dbg !97
  %135 = insertelement <16 x i8> %134, i8 %119, i64 8, !dbg !97
  %136 = insertelement <16 x i8> %135, i8 %120, i64 9, !dbg !97
  %137 = insertelement <16 x i8> %136, i8 %121, i64 10, !dbg !97
  %138 = insertelement <16 x i8> %137, i8 %122, i64 11, !dbg !97
  %139 = insertelement <16 x i8> %138, i8 %123, i64 12, !dbg !97
  %140 = insertelement <16 x i8> %139, i8 %124, i64 13, !dbg !97
  %141 = insertelement <16 x i8> %140, i8 %125, i64 14, !dbg !97
  %142 = insertelement <16 x i8> %141, i8 %126, i64 15, !dbg !97
  %143 = mul i64 %20, 1024, !dbg !97
  %144 = mul i64 %30, 16, !dbg !97
  %145 = add i64 %143, %144, !dbg !97
  %146 = add i64 %145, 0, !dbg !97
  %147 = add i64 %146, 0, !dbg !97
  %148 = getelementptr i8, ptr %10, i64 %147, !dbg !97
  store <16 x i8> %142, ptr %148, align 1, !dbg !97
  %149 = add i64 %27, 1, !dbg !97
  br label %26, !dbg !97

150:                                              ; preds = %26
  ret i32 0, !dbg !98
}

define internal i32 @_encoding_1_encode_64x32xi8_to_64x32xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !99 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !100
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !100
  %6 = load ptr, ptr %5, align 8, !dbg !100
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !100
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !101
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !101
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !101
  %10 = load ptr, ptr %9, align 8, !dbg !101
  %11 = getelementptr i8, ptr %10, i64 2048, !dbg !101
  call void @llvm.assume(i1 true) [ "align"(ptr %11, i64 64) ], !dbg !101
  %12 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !102
  %13 = extractvalue %iree_hal_executable_workgroup_state_v0_t %12, 0, !dbg !102
  %14 = zext i32 %13 to i64, !dbg !102
  %15 = sdiv i64 %14, 64, !dbg !102
  %16 = mul i64 %15, 64, !dbg !102
  %17 = icmp ne i64 %14, %16, !dbg !102
  %18 = icmp slt i64 %14, 0, !dbg !102
  %19 = and i1 %17, %18, !dbg !102
  %20 = add i64 %15, -1, !dbg !102
  %21 = select i1 %19, i64 %20, i64 %15, !dbg !102
  %22 = srem i64 %14, 64, !dbg !102
  %23 = icmp slt i64 %22, 0, !dbg !102
  %24 = add nsw i64 %22, 64, !dbg !102
  %25 = select i1 %23, i64 %24, i64 %22, !dbg !102
  %26 = mul nsw i64 %21, 16, !dbg !102
  %27 = mul i64 %25, 32, !dbg !102
  %28 = add i64 %27, %26, !dbg !102
  %29 = getelementptr i8, ptr %6, i64 %28, !dbg !102
  %30 = load <16 x i8>, ptr %29, align 1, !dbg !102
  %31 = mul i64 %21, 1024, !dbg !102
  %32 = mul i64 %25, 16, !dbg !102
  %33 = add i64 %31, %32, !dbg !102
  %34 = add i64 %33, 0, !dbg !102
  %35 = add i64 %34, 0, !dbg !102
  %36 = getelementptr i8, ptr %11, i64 %35, !dbg !102
  store <16 x i8> %30, ptr %36, align 1, !dbg !102
  ret i32 0, !dbg !103
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v16i8(<vscale x 8 x i8>, <16 x i8>, i64 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.v16i32(<vscale x 8 x i32>, <16 x i32>, i64 immarg) #2

; Function Attrs: nounwind willreturn
declare void @llvm.riscv.opu.bcast.nxv8i32.i64(<vscale x 8 x i32>, i64) #3

; Function Attrs: nounwind willreturn
declare void @llvm.riscv.opu.vmv.rv.i64.nxv8i32.i64(i64, <vscale x 8 x i32>, i64) #3

; Function Attrs: nounwind willreturn
declare void @llvm.riscv.opu.vopacc.nxv8i8.nxv8i8.i64(<vscale x 8 x i8>, <vscale x 8 x i8>, i64) #3

; Function Attrs: nounwind willreturn
declare <vscale x 8 x i32> @llvm.riscv.opu.vmv.vr.nxv8i32.i64.i64(i64, i64) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x i32> @llvm.vector.extract.v16i32.nxv8i32(<vscale x 8 x i32>, i64 immarg) #2

; Function Attrs: uwtable
define dso_local dllexport ptr @iree_hal_executable_library_query(i32 %0, ptr %1) #4 {
entry:
  %2 = icmp eq i32 %0, 6
  %3 = select i1 %2, ptr @iree_hal_executable_library_query_v0, ptr null
  ret ptr %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define hidden float @iree_h2f_ieee(i16 noundef signext %0) local_unnamed_addr #5 {
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
define hidden signext i16 @iree_f2h_ieee(float noundef %0) local_unnamed_addr #5 {
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
  %26 = add nsw i32 %25, 15360
  %27 = lshr i32 %21, 13
  %28 = select i1 %22, i32 0, i32 %27
  %29 = add nuw nsw i32 %26, %28
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
define hidden float @__gnu_h2f_ieee(i16 noundef signext %0) local_unnamed_addr #5 {
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
define hidden float @__extendhfsf2(float noundef %0) local_unnamed_addr #5 {
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
define hidden signext i16 @__gnu_f2h_ieee(float noundef %0) local_unnamed_addr #5 {
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
define hidden float @__truncsfhf2(float noundef %0) local_unnamed_addr #5 {
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
  %30 = add nsw i32 %29, %26
  br label %31

31:                                               ; preds = %18, %16, %13, %8, %1
  %32 = phi i32 [ 31744, %8 ], [ %4, %1 ], [ %30, %18 ], [ 31744, %13 ], [ 0, %16 ]
  %33 = or i32 %32, %7
  %34 = trunc i32 %33 to i16
  br label %35

35:                                               ; preds = %10, %31
  %36 = phi i16 [ %12, %10 ], [ %34, %31 ]
  store i16 %36, ptr %2, align 4, !tbaa !104
  %37 = load float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  ret float %37
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #6

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define hidden double @__extendhfdf2(float noundef %0) local_unnamed_addr #5 {
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
define hidden float @__truncdfhf2(double noundef %0) local_unnamed_addr #5 {
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
  %38 = load float, ptr %2, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %2)
  ret float %38
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define hidden noundef double @fma(double noundef %0, double noundef %1, double noundef %2) local_unnamed_addr #5 {
  %4 = tail call double @llvm.fmuladd.f64(double %0, double %1, double %2)
  ret double %4
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #7

; Function Attrs: inlinehint
define hidden noundef float @__math_invalidf(float noundef %0) local_unnamed_addr #8 {
  %2 = fsub float %0, %0
  %3 = fdiv float %2, %2
  ret float %3
}

; Function Attrs: inlinehint
define hidden float @__math_oflowf(i32 noundef %0) local_unnamed_addr #8 {
  %2 = tail call float @__math_xflowf(i32 noundef %0, float noundef 0x4600000000000000) #8
  ret float %2
}

; Function Attrs: inlinehint
define hidden float @__math_xflowf(i32 noundef %0, float noundef %1) local_unnamed_addr #8 {
  %3 = alloca float, align 4
  %.not = icmp eq i32 %0, 0
  %4 = fneg float %1
  %5 = select i1 %.not, float %1, float %4
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float %5, ptr %3, align 4, !tbaa !106
  %.0..0..0..0..0..0..i = load volatile float, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  %6 = fmul float %1, %.0..0..0..0..0..0..i
  ret float %6
}

; Function Attrs: inlinehint
define hidden float @__math_uflowf(i32 noundef %0) local_unnamed_addr #8 {
  %2 = tail call float @__math_xflowf(i32 noundef %0, float noundef 0x3A00000000000000) #8
  ret float %2
}

; Function Attrs: inlinehint
define hidden float @ceilf(float noundef %0) local_unnamed_addr #8 {
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

; Function Attrs: inlinehint
define hidden float @expf(float noundef %0) local_unnamed_addr #8 {
  %2 = fpext float %0 to double
  %3 = bitcast float %0 to i32
  %4 = lshr i32 %3, 20
  %5 = and i32 %4, 2047
  %.not = icmp samesign ult i32 %5, 1067
  br i1 %.not, label %19, label %6, !prof !108

6:                                                ; preds = %1
  %7 = fcmp oeq float %0, 0xFFF0000000000000
  br i1 %7, label %42, label %8

8:                                                ; preds = %6
  %.not34 = icmp samesign ult i32 %5, 2040
  br i1 %.not34, label %11, label %9

9:                                                ; preds = %8
  %10 = fadd float %0, %0
  br label %42

11:                                               ; preds = %8
  %12 = fcmp ogt float %0, 0x40562E42E0000000
  br i1 %12, label %13, label %15

13:                                               ; preds = %11
  %14 = tail call float @__math_oflowf(i32 noundef 0) #8
  br label %42

15:                                               ; preds = %11
  %16 = fcmp olt float %0, 0xC059FE3680000000
  br i1 %16, label %17, label %19

17:                                               ; preds = %15
  %18 = tail call float @__math_uflowf(i32 noundef 0) #8
  br label %42

19:                                               ; preds = %15, %1
  %20 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 296), align 8, !tbaa !109
  %21 = fmul double %20, %2
  %22 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 288), align 8, !tbaa !112
  %23 = fadd double %21, %22
  %24 = bitcast double %23 to i64
  %25 = fsub double %23, %22
  %26 = fsub double %21, %25
  %27 = and i64 %24, 31
  %28 = getelementptr inbounds nuw i64, ptr @__exp2f_data, i64 %27
  %29 = load i64, ptr %28, align 8, !tbaa !113
  %30 = shl i64 %24, 47
  %31 = add i64 %30, %29
  %32 = bitcast i64 %31 to double
  %33 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 304), align 8, !tbaa !115
  %34 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 312), align 8, !tbaa !115
  %35 = tail call double @llvm.fmuladd.f64(double %33, double %26, double %34)
  %36 = fmul double %26, %26
  %37 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 320), align 8, !tbaa !115
  %38 = tail call double @llvm.fmuladd.f64(double %37, double %26, double 1.000000e+00)
  %39 = tail call double @llvm.fmuladd.f64(double %35, double %36, double %38)
  %40 = fmul double %39, %32
  %41 = fptrunc double %40 to float
  br label %42

42:                                               ; preds = %19, %17, %13, %9, %6
  %.0 = phi float [ %10, %9 ], [ %14, %13 ], [ %18, %17 ], [ %41, %19 ], [ 0.000000e+00, %6 ]
  ret float %.0
}

; Function Attrs: inlinehint
define hidden noundef i32 @feclearexcept(i32 noundef %0) local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden noundef i32 @feraiseexcept(i32 noundef %0) local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden noundef i32 @fetestexcept(i32 noundef %0) local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden noundef i32 @fegetround() local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden noundef i32 @__fesetround(i32 noundef %0) local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden noundef i32 @fegetenv(ptr noundef readnone captures(none) %0) local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden noundef i32 @fesetenv(ptr noundef readnone captures(none) %0) local_unnamed_addr #8 {
  ret i32 0
}

; Function Attrs: inlinehint
define hidden float @floorf(float noundef %0) local_unnamed_addr #8 {
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

; Function Attrs: inlinehint
define hidden float @fmaf(float noundef %0, float noundef %1, float noundef %2) local_unnamed_addr #8 {
  %4 = alloca float, align 4
  %5 = fpext float %0 to double
  %6 = fpext float %1 to double
  %7 = fmul double %5, %6
  %8 = fpext float %2 to double
  %9 = fadd double %7, %8
  %10 = bitcast double %9 to i64
  %11 = lshr i64 %10, 52
  %12 = trunc nuw nsw i64 %11 to i32
  %13 = and i32 %12, 2047
  %14 = and i64 %10, 536870911
  %15 = icmp ne i64 %14, 268435456
  %16 = icmp eq i32 %13, 2047
  %or.cond = select i1 %15, i1 true, i1 %16
  br i1 %or.cond, label %24, label %17

17:                                               ; preds = %3
  %18 = fsub double %9, %7
  %19 = fcmp oeq double %18, %8
  %20 = fsub double %9, %8
  %21 = fcmp oeq double %20, %7
  %or.cond44 = and i1 %19, %21
  br i1 %or.cond44, label %24, label %22

22:                                               ; preds = %17
  %23 = tail call i32 @fegetround() #8
  %.not = icmp eq i32 %23, 0
  br i1 %.not, label %34, label %24

24:                                               ; preds = %22, %17, %3
  %25 = add nsw i32 %13, -874
  %or.cond3 = icmp ult i32 %25, 23
  br i1 %or.cond3, label %26, label %46

26:                                               ; preds = %24
  %27 = tail call i32 @fetestexcept(i32 noundef 32) #8
  %.not41 = icmp eq i32 %27, 0
  br i1 %.not41, label %46, label %28

28:                                               ; preds = %26
  %29 = tail call i32 @feclearexcept(i32 noundef 32) #8
  call void @llvm.lifetime.start.p0(ptr nonnull %4)
  store volatile float %2, ptr %4, align 4, !tbaa !106
  %.0..0..0..0.5 = load volatile float, ptr %4, align 4, !tbaa !106
  %30 = fpext float %.0..0..0..0.5 to double
  %31 = fadd double %7, %30
  %32 = tail call i32 @fetestexcept(i32 noundef 32) #8
  %.not42 = icmp eq i32 %32, 0
  %. = select i1 %.not42, i32 32, i32 16
  %33 = tail call i32 @feraiseexcept(i32 noundef %.) #8
  call void @llvm.lifetime.end.p0(ptr nonnull %4)
  br label %46

34:                                               ; preds = %22
  %35 = icmp slt i64 %10, 0
  %36 = fcmp uge double %7, %8
  %37 = xor i1 %36, %35
  %38 = fsub double %7, %9
  %39 = fadd double %38, %8
  %40 = fsub double %8, %9
  %41 = fadd double %7, %40
  %.038 = select i1 %37, double %39, double %41
  %42 = fcmp uge double %.038, 0.000000e+00
  %43 = xor i1 %35, %42
  %44 = or disjoint i64 %10, 1
  %45 = add nsw i64 %10, -1
  %.sroa.0.0.in = select i1 %43, i64 %44, i64 %45
  %.sroa.0.0 = bitcast i64 %.sroa.0.0.in to double
  br label %46

46:                                               ; preds = %34, %28, %26, %24
  %.0.in = phi double [ %.sroa.0.0, %34 ], [ %31, %28 ], [ %9, %26 ], [ %9, %24 ]
  %.0 = fptrunc double %.0.in to float
  ret float %.0
}

; Function Attrs: inlinehint
define hidden float @fmodf(float noundef %0, float noundef %1) local_unnamed_addr #8 {
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

.lr.ph:                                           ; preds = %.lr.ph, %26
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

.lr.ph90:                                         ; preds = %.lr.ph90, %38
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

.lr.ph96:                                         ; preds = %57, %49
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

.lr.ph103:                                        ; preds = %.lr.ph103, %67
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

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fabs.f32(float) #7

; Function Attrs: inlinehint
define hidden float @frexpf(float noundef %0, ptr noundef captures(none) %1) local_unnamed_addr #8 {
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
  %9 = tail call float @frexpf(float noundef %8, ptr noundef %1) #8
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

; Function Attrs: inlinehint
define hidden float @ldexpf(float noundef %0, i32 noundef %1) local_unnamed_addr #8 {
  %3 = tail call float @scalbnf(float noundef %0, i32 noundef %1) #8
  ret float %3
}

; Function Attrs: inlinehint
define hidden float @scalbnf(float noundef %0, i32 noundef %1) local_unnamed_addr #8 {
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

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #7

; Function Attrs: inlinehint
define hidden float @powf(float noundef %0, float noundef %1) local_unnamed_addr #8 {
  %3 = alloca float, align 4
  %4 = bitcast float %0 to i32
  %5 = bitcast float %1 to i32
  %6 = add i32 %4, -2139095040
  %7 = icmp ult i32 %6, -2130706432
  %.pre = shl i32 %5, 1
  %8 = add i32 %.pre, 16777216
  %9 = icmp ult i32 %8, 16777217
  %or.cond99 = or i1 %7, %9
  br i1 %or.cond99, label %.critedge, label %73, !prof !116

.critedge:                                        ; preds = %2
  %10 = add i32 %.pre, -1
  %11 = icmp ult i32 %10, -16777217
  br i1 %11, label %28, label %12, !prof !108

12:                                               ; preds = %.critedge
  %13 = icmp eq i32 %.pre, 0
  %14 = icmp eq i32 %4, 1065353216
  %or.cond70 = or i1 %14, %13
  br i1 %or.cond70, label %138, label %15

15:                                               ; preds = %12
  %16 = shl i32 %4, 1
  %17 = icmp ugt i32 %16, -16777216
  %18 = icmp samesign ugt i32 %.pre, -16777216
  %or.cond = or i1 %17, %18
  br i1 %or.cond, label %19, label %21

19:                                               ; preds = %15
  %20 = fadd float %0, %1
  br label %138

21:                                               ; preds = %15
  %22 = icmp eq i32 %16, 2130706432
  br i1 %22, label %138, label %23

23:                                               ; preds = %21
  %24 = icmp ult i32 %16, 2130706432
  %25 = icmp slt i32 %5, 0
  %26 = xor i1 %24, %25
  %27 = fmul float %1, %1
  %spec.select71 = select i1 %26, float 0.000000e+00, float %27
  br label %138

28:                                               ; preds = %.critedge
  %29 = shl i32 %4, 1
  %30 = add i32 %29, -1
  %31 = icmp ult i32 %30, -16777217
  br i1 %31, label %47, label %32, !prof !108

32:                                               ; preds = %28
  %33 = fmul float %0, %0
  %.not66 = icmp sgt i32 %4, -1
  br i1 %.not66, label %checkint.exit.thread, label %34

34:                                               ; preds = %32
  %35 = lshr i32 %5, 23
  %36 = and i32 %35, 255
  %37 = add nsw i32 %36, -151
  %or.cond92 = icmp ult i32 %37, -24
  br i1 %or.cond92, label %checkint.exit.thread, label %38

38:                                               ; preds = %34
  %39 = sub nuw nsw i32 150, %36
  %40 = shl nuw nsw i32 1, %39
  %41 = add nsw i32 %40, -1
  %42 = and i32 %41, %5
  %.not.i = icmp ne i32 %42, 0
  %43 = and i32 %40, %5
  %.not9.i = icmp eq i32 %43, 0
  %or.cond93 = or i1 %.not9.i, %.not.i
  %44 = fneg float %33
  %spec.select = select i1 %or.cond93, float %33, float %44
  br label %checkint.exit.thread

checkint.exit.thread:                             ; preds = %38, %34, %32
  %.057 = phi float [ %33, %32 ], [ %33, %34 ], [ %spec.select, %38 ]
  %.not67 = icmp sgt i32 %5, -1
  br i1 %.not67, label %138, label %45

45:                                               ; preds = %checkint.exit.thread
  %46 = fdiv float 1.000000e+00, %.057
  call void @llvm.lifetime.start.p0(ptr nonnull %3)
  store volatile float %46, ptr %3, align 4, !tbaa !106
  %.0..0..0..0..0..0..i = load volatile float, ptr %3, align 4, !tbaa !106
  call void @llvm.lifetime.end.p0(ptr nonnull %3)
  br label %138

47:                                               ; preds = %28
  %.not64 = icmp sgt i32 %4, -1
  br i1 %.not64, label %66, label %48

48:                                               ; preds = %47
  %49 = lshr i32 %5, 23
  %50 = and i32 %49, 255
  %51 = icmp samesign ult i32 %50, 127
  br i1 %51, label %.thread, label %52

52:                                               ; preds = %48
  %53 = icmp samesign ugt i32 %50, 150
  br i1 %53, label %checkint.exit76.thread85, label %54

54:                                               ; preds = %52
  %55 = sub nuw nsw i32 150, %50
  %56 = shl nuw nsw i32 1, %55
  %57 = add nsw i32 %56, -1
  %58 = and i32 %57, %5
  %.not.i72 = icmp eq i32 %58, 0
  br i1 %.not.i72, label %59, label %.thread

59:                                               ; preds = %54
  %60 = and i32 %56, %5
  %.not9.i74 = icmp eq i32 %60, 0
  br i1 %.not9.i74, label %checkint.exit76.thread85, label %62

.thread:                                          ; preds = %54, %48
  %61 = tail call float @__math_invalidf(float noundef %0) #8
  br label %138

checkint.exit76.thread85:                         ; preds = %59, %52
  br label %62

62:                                               ; preds = %checkint.exit76.thread85, %59
  %63 = phi i32 [ 0, %checkint.exit76.thread85 ], [ 65536, %59 ]
  %64 = tail call float @llvm.fabs.f32(float %0)
  %65 = bitcast float %64 to i32
  br label %66

66:                                               ; preds = %62, %47
  %.154 = phi i32 [ %65, %62 ], [ %4, %47 ]
  %.151 = phi i32 [ %63, %62 ], [ 0, %47 ]
  %67 = icmp ult i32 %.154, 8388608
  br i1 %67, label %68, label %73

68:                                               ; preds = %66
  %69 = fmul float %0, 0x4160000000000000
  %70 = tail call float @llvm.fabs.f32(float %69)
  %71 = bitcast float %70 to i32
  %72 = add nsw i32 %71, -192937984
  br label %73

73:                                               ; preds = %68, %66, %2
  %.053 = phi i32 [ %72, %68 ], [ %.154, %66 ], [ %4, %2 ]
  %.050 = phi i32 [ %.151, %68 ], [ %.151, %66 ], [ 0, %2 ]
  %74 = add i32 %.053, -1060306944
  %75 = lshr i32 %74, 19
  %76 = and i32 %75, 15
  %77 = and i32 %74, -8388608
  %78 = sub i32 %.053, %77
  %79 = ashr i32 %74, 23
  %80 = zext nneg i32 %76 to i64
  %81 = getelementptr inbounds nuw %struct.anon, ptr @__powf_log2_data, i64 %80
  %82 = load double, ptr %81, align 8, !tbaa !117
  %83 = getelementptr inbounds nuw i8, ptr %81, i64 8
  %84 = load double, ptr %83, align 8, !tbaa !119
  %85 = bitcast i32 %78 to float
  %86 = fpext float %85 to double
  %87 = tail call double @llvm.fmuladd.f64(double %86, double %82, double -1.000000e+00)
  %88 = sitofp i32 %79 to double
  %89 = fadd double %84, %88
  %90 = fmul double %87, %87
  %91 = load double, ptr getelementptr inbounds nuw (i8, ptr @__powf_log2_data, i64 256), align 8, !tbaa !115
  %92 = load double, ptr getelementptr inbounds nuw (i8, ptr @__powf_log2_data, i64 264), align 8, !tbaa !115
  %93 = tail call double @llvm.fmuladd.f64(double %91, double %87, double %92)
  %94 = load double, ptr getelementptr inbounds nuw (i8, ptr @__powf_log2_data, i64 272), align 8, !tbaa !115
  %95 = load double, ptr getelementptr inbounds nuw (i8, ptr @__powf_log2_data, i64 280), align 8, !tbaa !115
  %96 = tail call double @llvm.fmuladd.f64(double %94, double %87, double %95)
  %97 = fmul double %90, %90
  %98 = load double, ptr getelementptr inbounds nuw (i8, ptr @__powf_log2_data, i64 288), align 8, !tbaa !115
  %99 = tail call double @llvm.fmuladd.f64(double %98, double %87, double %89)
  %100 = tail call double @llvm.fmuladd.f64(double %96, double %90, double %99)
  %101 = tail call double @llvm.fmuladd.f64(double %93, double %97, double %100)
  %102 = fpext float %1 to double
  %103 = fmul double %101, %102
  %104 = bitcast double %103 to i64
  %105 = and i64 %104, 9223231299366420480
  %106 = icmp samesign ugt i64 %105, 4638426141214900224
  br i1 %106, label %107, label %115, !prof !120

107:                                              ; preds = %73
  %108 = fcmp ogt double %103, 0x405FFFFFFFD1D571
  br i1 %108, label %109, label %111

109:                                              ; preds = %107
  %110 = tail call float @__math_oflowf(i32 noundef %.050) #8
  br label %138

111:                                              ; preds = %107
  %112 = fcmp ugt double %103, -1.500000e+02
  br i1 %112, label %115, label %113

113:                                              ; preds = %111
  %114 = tail call float @__math_uflowf(i32 noundef %.050) #8
  br label %138

115:                                              ; preds = %111, %73
  %116 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 256), align 8, !tbaa !121
  %117 = fadd double %103, %116
  %118 = bitcast double %117 to i64
  %119 = fsub double %117, %116
  %120 = fsub double %103, %119
  %121 = and i64 %118, 31
  %122 = getelementptr inbounds nuw i64, ptr @__exp2f_data, i64 %121
  %123 = load i64, ptr %122, align 8, !tbaa !113
  %124 = zext nneg i32 %.050 to i64
  %125 = add i64 %118, %124
  %126 = shl i64 %125, 47
  %127 = add i64 %126, %123
  %128 = bitcast i64 %127 to double
  %129 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 264), align 8, !tbaa !115
  %130 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 272), align 8, !tbaa !115
  %131 = tail call double @llvm.fmuladd.f64(double %129, double %120, double %130)
  %132 = fmul double %120, %120
  %133 = load double, ptr getelementptr inbounds nuw (i8, ptr @__exp2f_data, i64 280), align 8, !tbaa !115
  %134 = tail call double @llvm.fmuladd.f64(double %133, double %120, double 1.000000e+00)
  %135 = tail call double @llvm.fmuladd.f64(double %131, double %132, double %134)
  %136 = fmul double %135, %128
  %137 = fptrunc double %136 to float
  br label %138

138:                                              ; preds = %115, %113, %109, %.thread, %45, %checkint.exit.thread, %23, %21, %19, %12
  %.0 = phi float [ %20, %19 ], [ 1.000000e+00, %12 ], [ 1.000000e+00, %21 ], [ %.0..0..0..0..0..0..i, %45 ], [ %.057, %checkint.exit.thread ], [ %110, %109 ], [ %114, %113 ], [ %137, %115 ], [ %spec.select71, %23 ], [ %61, %.thread ]
  ret float %.0
}

; Function Attrs: inlinehint
define hidden noundef float @rintf(float noundef %0) local_unnamed_addr #8 {
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

; Function Attrs: inlinehint
define hidden float @roundf(float noundef %0) local_unnamed_addr #8 {
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

attributes #0 = { "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #3 = { nounwind willreturn "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #4 = { uwtable "nonlazybind" }
attributes #5 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { inlinehint }

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
!109 = !{!110, !111, i64 296}
!110 = !{!"exp2f_data", !10, i64 0, !111, i64 256, !10, i64 264, !111, i64 288, !111, i64 296, !10, i64 304}
!111 = !{!"double", !10, i64 0}
!112 = !{!110, !111, i64 288}
!113 = !{!114, !114, i64 0}
!114 = !{!"long", !10, i64 0}
!115 = !{!111, !111, i64 0}
!116 = !{!"branch_weights", i32 4001, i32 4000000}
!117 = !{!118, !111, i64 0}
!118 = !{!"", !111, i64 0, !111, i64 8}
!119 = !{!118, !111, i64 8}
!120 = !{!"branch_weights", !"expected", i32 1, i32 2000}
!121 = !{!110, !111, i64 256}
