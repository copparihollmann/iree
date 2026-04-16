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

define internal i32 @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !7 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !83
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !83
  %6 = load ptr, ptr %5, align 8, !dbg !83
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !83
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !84
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !84
  %9 = load ptr, ptr %8, align 8, !dbg !84
  %10 = getelementptr i8, ptr %9, i64 2048, !dbg !84
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !84
  %11 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !85
  %12 = extractvalue %iree_hal_executable_dispatch_state_v0_t %11, 10, !dbg !85
  %13 = getelementptr ptr, ptr %12, i32 1, !dbg !85
  %14 = load ptr, ptr %13, align 8, !dbg !85
  call void @llvm.assume(i1 true) [ "align"(ptr %14, i64 64) ], !dbg !85
  %15 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !86
  %16 = extractvalue %iree_hal_executable_workgroup_state_v0_t %15, 0, !dbg !86
  %17 = zext i32 %16 to i64, !dbg !86
  %18 = sdiv i64 %17, 2, !dbg !86
  %19 = mul i64 %18, 2, !dbg !86
  %20 = icmp ne i64 %17, %19, !dbg !86
  %21 = icmp slt i64 %17, 0, !dbg !86
  %22 = and i1 %20, %21, !dbg !86
  %23 = add i64 %18, -1, !dbg !86
  %24 = select i1 %22, i64 %23, i64 %18, !dbg !86
  %25 = srem i64 %17, 2, !dbg !86
  %26 = icmp slt i64 %25, 0, !dbg !86
  %27 = add nsw i64 %25, 2, !dbg !86
  %28 = select i1 %26, i64 %27, i64 %25, !dbg !86
  %29 = mul nsw i64 %24, 16, !dbg !87
  %30 = mul nsw i64 %28, 16, !dbg !87
  br label %31, !dbg !86

31:                                               ; preds = %35, %3
  %32 = phi i64 [ %132, %35 ], [ 0, %3 ], !dbg !86
  %33 = phi [16 x <16 x i32>] [ %131, %35 ], [ zeroinitializer, %3 ], !dbg !86
  %34 = icmp slt i64 %32, 64, !dbg !86
  br i1 %34, label %35, label %133, !dbg !86

35:                                               ; preds = %31
  %36 = mul i64 %24, 1024, !dbg !86
  %37 = mul i64 %32, 16, !dbg !86
  %38 = add i64 %36, %37, !dbg !86
  %39 = add i64 %38, 0, !dbg !86
  %40 = add i64 %39, 0, !dbg !86
  %41 = getelementptr i8, ptr %6, i64 %40, !dbg !86
  %42 = load <16 x i8>, ptr %41, align 1, !dbg !86
  %43 = mul i64 %28, 1024, !dbg !86
  %44 = add i64 %43, %37, !dbg !86
  %45 = add i64 %44, 0, !dbg !86
  %46 = add i64 %45, 0, !dbg !86
  %47 = getelementptr i8, ptr %10, i64 %46, !dbg !86
  %48 = load <16 x i8>, ptr %47, align 1, !dbg !86
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
  %132 = add i64 %32, 1, !dbg !86
  br label %31, !dbg !86

133:                                              ; preds = %31
  %134 = extractvalue [16 x <16 x i32>] %33, 0, !dbg !87
  %135 = mul i64 %29, 32, !dbg !87
  %136 = add i64 %135, %30, !dbg !87
  %137 = getelementptr i32, ptr %14, i64 %136, !dbg !87
  store <16 x i32> %134, ptr %137, align 4, !dbg !87
  %138 = extractvalue [16 x <16 x i32>] %33, 1, !dbg !87
  %139 = add i64 %29, 1, !dbg !87
  %140 = mul i64 %139, 32, !dbg !87
  %141 = add i64 %140, %30, !dbg !87
  %142 = getelementptr i32, ptr %14, i64 %141, !dbg !87
  store <16 x i32> %138, ptr %142, align 4, !dbg !87
  %143 = extractvalue [16 x <16 x i32>] %33, 2, !dbg !87
  %144 = add i64 %29, 2, !dbg !87
  %145 = mul i64 %144, 32, !dbg !87
  %146 = add i64 %145, %30, !dbg !87
  %147 = getelementptr i32, ptr %14, i64 %146, !dbg !87
  store <16 x i32> %143, ptr %147, align 4, !dbg !87
  %148 = extractvalue [16 x <16 x i32>] %33, 3, !dbg !87
  %149 = add i64 %29, 3, !dbg !87
  %150 = mul i64 %149, 32, !dbg !87
  %151 = add i64 %150, %30, !dbg !87
  %152 = getelementptr i32, ptr %14, i64 %151, !dbg !87
  store <16 x i32> %148, ptr %152, align 4, !dbg !87
  %153 = extractvalue [16 x <16 x i32>] %33, 4, !dbg !87
  %154 = add i64 %29, 4, !dbg !87
  %155 = mul i64 %154, 32, !dbg !87
  %156 = add i64 %155, %30, !dbg !87
  %157 = getelementptr i32, ptr %14, i64 %156, !dbg !87
  store <16 x i32> %153, ptr %157, align 4, !dbg !87
  %158 = extractvalue [16 x <16 x i32>] %33, 5, !dbg !87
  %159 = add i64 %29, 5, !dbg !87
  %160 = mul i64 %159, 32, !dbg !87
  %161 = add i64 %160, %30, !dbg !87
  %162 = getelementptr i32, ptr %14, i64 %161, !dbg !87
  store <16 x i32> %158, ptr %162, align 4, !dbg !87
  %163 = extractvalue [16 x <16 x i32>] %33, 6, !dbg !87
  %164 = add i64 %29, 6, !dbg !87
  %165 = mul i64 %164, 32, !dbg !87
  %166 = add i64 %165, %30, !dbg !87
  %167 = getelementptr i32, ptr %14, i64 %166, !dbg !87
  store <16 x i32> %163, ptr %167, align 4, !dbg !87
  %168 = extractvalue [16 x <16 x i32>] %33, 7, !dbg !87
  %169 = add i64 %29, 7, !dbg !87
  %170 = mul i64 %169, 32, !dbg !87
  %171 = add i64 %170, %30, !dbg !87
  %172 = getelementptr i32, ptr %14, i64 %171, !dbg !87
  store <16 x i32> %168, ptr %172, align 4, !dbg !87
  %173 = extractvalue [16 x <16 x i32>] %33, 8, !dbg !87
  %174 = add i64 %29, 8, !dbg !87
  %175 = mul i64 %174, 32, !dbg !87
  %176 = add i64 %175, %30, !dbg !87
  %177 = getelementptr i32, ptr %14, i64 %176, !dbg !87
  store <16 x i32> %173, ptr %177, align 4, !dbg !87
  %178 = extractvalue [16 x <16 x i32>] %33, 9, !dbg !87
  %179 = add i64 %29, 9, !dbg !87
  %180 = mul i64 %179, 32, !dbg !87
  %181 = add i64 %180, %30, !dbg !87
  %182 = getelementptr i32, ptr %14, i64 %181, !dbg !87
  store <16 x i32> %178, ptr %182, align 4, !dbg !87
  %183 = extractvalue [16 x <16 x i32>] %33, 10, !dbg !87
  %184 = add i64 %29, 10, !dbg !87
  %185 = mul i64 %184, 32, !dbg !87
  %186 = add i64 %185, %30, !dbg !87
  %187 = getelementptr i32, ptr %14, i64 %186, !dbg !87
  store <16 x i32> %183, ptr %187, align 4, !dbg !87
  %188 = extractvalue [16 x <16 x i32>] %33, 11, !dbg !87
  %189 = add i64 %29, 11, !dbg !87
  %190 = mul i64 %189, 32, !dbg !87
  %191 = add i64 %190, %30, !dbg !87
  %192 = getelementptr i32, ptr %14, i64 %191, !dbg !87
  store <16 x i32> %188, ptr %192, align 4, !dbg !87
  %193 = extractvalue [16 x <16 x i32>] %33, 12, !dbg !87
  %194 = add i64 %29, 12, !dbg !87
  %195 = mul i64 %194, 32, !dbg !87
  %196 = add i64 %195, %30, !dbg !87
  %197 = getelementptr i32, ptr %14, i64 %196, !dbg !87
  store <16 x i32> %193, ptr %197, align 4, !dbg !87
  %198 = extractvalue [16 x <16 x i32>] %33, 13, !dbg !87
  %199 = add i64 %29, 13, !dbg !87
  %200 = mul i64 %199, 32, !dbg !87
  %201 = add i64 %200, %30, !dbg !87
  %202 = getelementptr i32, ptr %14, i64 %201, !dbg !87
  store <16 x i32> %198, ptr %202, align 4, !dbg !87
  %203 = extractvalue [16 x <16 x i32>] %33, 14, !dbg !87
  %204 = add i64 %29, 14, !dbg !87
  %205 = mul i64 %204, 32, !dbg !87
  %206 = add i64 %205, %30, !dbg !87
  %207 = getelementptr i32, ptr %14, i64 %206, !dbg !87
  store <16 x i32> %203, ptr %207, align 4, !dbg !87
  %208 = extractvalue [16 x <16 x i32>] %33, 15, !dbg !87
  %209 = add i64 %29, 15, !dbg !87
  %210 = mul i64 %209, 32, !dbg !87
  %211 = add i64 %210, %30, !dbg !87
  %212 = getelementptr i32, ptr %14, i64 %211, !dbg !87
  store <16 x i32> %208, ptr %212, align 4, !dbg !87
  ret i32 0, !dbg !88
}

define internal i32 @_encoding_0_encode_32x64xi8_to_32x64xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !89 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !90
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !90
  %6 = load ptr, ptr %5, align 8, !dbg !90
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !90
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !91
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !91
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !91
  %10 = load ptr, ptr %9, align 8, !dbg !91
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !91
  %11 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !92
  %12 = extractvalue %iree_hal_executable_workgroup_state_v0_t %11, 0, !dbg !92
  %13 = zext i32 %12 to i64, !dbg !92
  %14 = sdiv i64 %13, 8, !dbg !92
  %15 = mul i64 %14, 8, !dbg !92
  %16 = icmp ne i64 %13, %15, !dbg !92
  %17 = icmp slt i64 %13, 0, !dbg !92
  %18 = and i1 %16, %17, !dbg !92
  %19 = add i64 %14, -1, !dbg !92
  %20 = select i1 %18, i64 %19, i64 %14, !dbg !92
  %21 = srem i64 %13, 8, !dbg !92
  %22 = icmp slt i64 %21, 0, !dbg !92
  %23 = add nsw i64 %21, 8, !dbg !92
  %24 = select i1 %22, i64 %23, i64 %21, !dbg !92
  %25 = mul nsw i64 %24, 8, !dbg !92
  br label %26, !dbg !92

26:                                               ; preds = %29, %3
  %27 = phi i64 [ %149, %29 ], [ 0, %3 ], !dbg !92
  %28 = icmp slt i64 %27, 8, !dbg !92
  br i1 %28, label %29, label %150, !dbg !92

29:                                               ; preds = %26
  %30 = add i64 %27, %25, !dbg !92
  %31 = mul nsw i64 %20, 16, !dbg !92
  %32 = mul i64 %31, 64, !dbg !92
  %33 = add i64 %32, %30, !dbg !92
  %34 = getelementptr i8, ptr %6, i64 %33, !dbg !92
  %35 = load <1 x i8>, ptr %34, align 1, !dbg !92
  %36 = add i64 %31, 1, !dbg !92
  %37 = mul i64 %36, 64, !dbg !92
  %38 = add i64 %37, %30, !dbg !92
  %39 = getelementptr i8, ptr %6, i64 %38, !dbg !92
  %40 = load <1 x i8>, ptr %39, align 1, !dbg !92
  %41 = add i64 %31, 2, !dbg !92
  %42 = mul i64 %41, 64, !dbg !92
  %43 = add i64 %42, %30, !dbg !92
  %44 = getelementptr i8, ptr %6, i64 %43, !dbg !92
  %45 = load <1 x i8>, ptr %44, align 1, !dbg !92
  %46 = add i64 %31, 3, !dbg !92
  %47 = mul i64 %46, 64, !dbg !92
  %48 = add i64 %47, %30, !dbg !92
  %49 = getelementptr i8, ptr %6, i64 %48, !dbg !92
  %50 = load <1 x i8>, ptr %49, align 1, !dbg !92
  %51 = add i64 %31, 4, !dbg !92
  %52 = mul i64 %51, 64, !dbg !92
  %53 = add i64 %52, %30, !dbg !92
  %54 = getelementptr i8, ptr %6, i64 %53, !dbg !92
  %55 = load <1 x i8>, ptr %54, align 1, !dbg !92
  %56 = add i64 %31, 5, !dbg !92
  %57 = mul i64 %56, 64, !dbg !92
  %58 = add i64 %57, %30, !dbg !92
  %59 = getelementptr i8, ptr %6, i64 %58, !dbg !92
  %60 = load <1 x i8>, ptr %59, align 1, !dbg !92
  %61 = add i64 %31, 6, !dbg !92
  %62 = mul i64 %61, 64, !dbg !92
  %63 = add i64 %62, %30, !dbg !92
  %64 = getelementptr i8, ptr %6, i64 %63, !dbg !92
  %65 = load <1 x i8>, ptr %64, align 1, !dbg !92
  %66 = add i64 %31, 7, !dbg !92
  %67 = mul i64 %66, 64, !dbg !92
  %68 = add i64 %67, %30, !dbg !92
  %69 = getelementptr i8, ptr %6, i64 %68, !dbg !92
  %70 = load <1 x i8>, ptr %69, align 1, !dbg !92
  %71 = add i64 %31, 8, !dbg !92
  %72 = mul i64 %71, 64, !dbg !92
  %73 = add i64 %72, %30, !dbg !92
  %74 = getelementptr i8, ptr %6, i64 %73, !dbg !92
  %75 = load <1 x i8>, ptr %74, align 1, !dbg !92
  %76 = add i64 %31, 9, !dbg !92
  %77 = mul i64 %76, 64, !dbg !92
  %78 = add i64 %77, %30, !dbg !92
  %79 = getelementptr i8, ptr %6, i64 %78, !dbg !92
  %80 = load <1 x i8>, ptr %79, align 1, !dbg !92
  %81 = add i64 %31, 10, !dbg !92
  %82 = mul i64 %81, 64, !dbg !92
  %83 = add i64 %82, %30, !dbg !92
  %84 = getelementptr i8, ptr %6, i64 %83, !dbg !92
  %85 = load <1 x i8>, ptr %84, align 1, !dbg !92
  %86 = add i64 %31, 11, !dbg !92
  %87 = mul i64 %86, 64, !dbg !92
  %88 = add i64 %87, %30, !dbg !92
  %89 = getelementptr i8, ptr %6, i64 %88, !dbg !92
  %90 = load <1 x i8>, ptr %89, align 1, !dbg !92
  %91 = add i64 %31, 12, !dbg !92
  %92 = mul i64 %91, 64, !dbg !92
  %93 = add i64 %92, %30, !dbg !92
  %94 = getelementptr i8, ptr %6, i64 %93, !dbg !92
  %95 = load <1 x i8>, ptr %94, align 1, !dbg !92
  %96 = add i64 %31, 13, !dbg !92
  %97 = mul i64 %96, 64, !dbg !92
  %98 = add i64 %97, %30, !dbg !92
  %99 = getelementptr i8, ptr %6, i64 %98, !dbg !92
  %100 = load <1 x i8>, ptr %99, align 1, !dbg !92
  %101 = add i64 %31, 14, !dbg !92
  %102 = mul i64 %101, 64, !dbg !92
  %103 = add i64 %102, %30, !dbg !92
  %104 = getelementptr i8, ptr %6, i64 %103, !dbg !92
  %105 = load <1 x i8>, ptr %104, align 1, !dbg !92
  %106 = add i64 %31, 15, !dbg !92
  %107 = mul i64 %106, 64, !dbg !92
  %108 = add i64 %107, %30, !dbg !92
  %109 = getelementptr i8, ptr %6, i64 %108, !dbg !92
  %110 = load <1 x i8>, ptr %109, align 1, !dbg !92
  %111 = extractelement <1 x i8> %35, i64 0, !dbg !92
  %112 = extractelement <1 x i8> %40, i64 0, !dbg !92
  %113 = extractelement <1 x i8> %45, i64 0, !dbg !92
  %114 = extractelement <1 x i8> %50, i64 0, !dbg !92
  %115 = extractelement <1 x i8> %55, i64 0, !dbg !92
  %116 = extractelement <1 x i8> %60, i64 0, !dbg !92
  %117 = extractelement <1 x i8> %65, i64 0, !dbg !92
  %118 = extractelement <1 x i8> %70, i64 0, !dbg !92
  %119 = extractelement <1 x i8> %75, i64 0, !dbg !92
  %120 = extractelement <1 x i8> %80, i64 0, !dbg !92
  %121 = extractelement <1 x i8> %85, i64 0, !dbg !92
  %122 = extractelement <1 x i8> %90, i64 0, !dbg !92
  %123 = extractelement <1 x i8> %95, i64 0, !dbg !92
  %124 = extractelement <1 x i8> %100, i64 0, !dbg !92
  %125 = extractelement <1 x i8> %105, i64 0, !dbg !92
  %126 = extractelement <1 x i8> %110, i64 0, !dbg !92
  %127 = insertelement <16 x i8> poison, i8 %111, i64 0, !dbg !92
  %128 = insertelement <16 x i8> %127, i8 %112, i64 1, !dbg !92
  %129 = insertelement <16 x i8> %128, i8 %113, i64 2, !dbg !92
  %130 = insertelement <16 x i8> %129, i8 %114, i64 3, !dbg !92
  %131 = insertelement <16 x i8> %130, i8 %115, i64 4, !dbg !92
  %132 = insertelement <16 x i8> %131, i8 %116, i64 5, !dbg !92
  %133 = insertelement <16 x i8> %132, i8 %117, i64 6, !dbg !92
  %134 = insertelement <16 x i8> %133, i8 %118, i64 7, !dbg !92
  %135 = insertelement <16 x i8> %134, i8 %119, i64 8, !dbg !92
  %136 = insertelement <16 x i8> %135, i8 %120, i64 9, !dbg !92
  %137 = insertelement <16 x i8> %136, i8 %121, i64 10, !dbg !92
  %138 = insertelement <16 x i8> %137, i8 %122, i64 11, !dbg !92
  %139 = insertelement <16 x i8> %138, i8 %123, i64 12, !dbg !92
  %140 = insertelement <16 x i8> %139, i8 %124, i64 13, !dbg !92
  %141 = insertelement <16 x i8> %140, i8 %125, i64 14, !dbg !92
  %142 = insertelement <16 x i8> %141, i8 %126, i64 15, !dbg !92
  %143 = mul i64 %20, 1024, !dbg !92
  %144 = mul i64 %30, 16, !dbg !92
  %145 = add i64 %143, %144, !dbg !92
  %146 = add i64 %145, 0, !dbg !92
  %147 = add i64 %146, 0, !dbg !92
  %148 = getelementptr i8, ptr %10, i64 %147, !dbg !92
  store <16 x i8> %142, ptr %148, align 1, !dbg !92
  %149 = add i64 %27, 1, !dbg !92
  br label %26, !dbg !92

150:                                              ; preds = %26
  ret i32 0, !dbg !93
}

define internal i32 @_encoding_1_encode_64x32xi8_to_64x32xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !94 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !95
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !95
  %6 = load ptr, ptr %5, align 8, !dbg !95
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !95
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !96
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !96
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !96
  %10 = load ptr, ptr %9, align 8, !dbg !96
  %11 = getelementptr i8, ptr %10, i64 2048, !dbg !96
  call void @llvm.assume(i1 true) [ "align"(ptr %11, i64 64) ], !dbg !96
  %12 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !97
  %13 = extractvalue %iree_hal_executable_workgroup_state_v0_t %12, 0, !dbg !97
  %14 = zext i32 %13 to i64, !dbg !97
  %15 = sdiv i64 %14, 64, !dbg !97
  %16 = mul i64 %15, 64, !dbg !97
  %17 = icmp ne i64 %14, %16, !dbg !97
  %18 = icmp slt i64 %14, 0, !dbg !97
  %19 = and i1 %17, %18, !dbg !97
  %20 = add i64 %15, -1, !dbg !97
  %21 = select i1 %19, i64 %20, i64 %15, !dbg !97
  %22 = srem i64 %14, 64, !dbg !97
  %23 = icmp slt i64 %22, 0, !dbg !97
  %24 = add nsw i64 %22, 64, !dbg !97
  %25 = select i1 %23, i64 %24, i64 %22, !dbg !97
  %26 = mul nsw i64 %21, 16, !dbg !97
  %27 = mul i64 %25, 32, !dbg !97
  %28 = add i64 %27, %26, !dbg !97
  %29 = getelementptr i8, ptr %6, i64 %28, !dbg !97
  %30 = load <16 x i8>, ptr %29, align 1, !dbg !97
  %31 = mul i64 %21, 1024, !dbg !97
  %32 = mul i64 %25, 16, !dbg !97
  %33 = add i64 %31, %32, !dbg !97
  %34 = add i64 %33, 0, !dbg !97
  %35 = add i64 %34, 0, !dbg !97
  %36 = getelementptr i8, ptr %11, i64 %35, !dbg !97
  store <16 x i8> %30, ptr %36, align 1, !dbg !97
  ret i32 0, !dbg !98
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

attributes #0 = { "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #3 = { nounwind willreturn "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #4 = { uwtable "nonlazybind" }

!llvm.dbg.cu = !{!0, !2, !4}
!llvm.module.flags = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "configured_module_matmul_i8_quantized_dispatch_0.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files")
!2 = distinct !DICompileUnit(language: DW_LANG_C17, file: !3, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!3 = !DIFile(filename: "configured_module__encoding_0.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files")
!4 = distinct !DICompileUnit(language: DW_LANG_C17, file: !5, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!5 = !DIFile(filename: "configured_module__encoding_1.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/OPU/tmp/matmul_q_i8_xopu_zvl128/files")
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = distinct !DISubprogram(name: "matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32", linkageName: "matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32", scope: !1, file: !1, line: 1, type: !8, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!8 = !DISubroutineType(cc: DW_CC_normal, types: !9)
!9 = !{!10, !11, !42, !71}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_environment_v0_t", baseType: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_environment_v0_t", scope: !15, file: !15, line: 246, size: 768, elements: !16)
!15 = !DIFile(filename: "runtime/src/iree/hal/local/executable_library.h", directory: ".")
!16 = !{!17, !25, !28, !31, !33}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "constants", baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !20)
!20 = !DICompositeType(tag: DW_TAG_array_type, scope: !15, file: !15, line: 227, baseType: !21, size: 2048, elements: !23)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", baseType: !22)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !{!24}
!24 = !DISubrange(count: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "import_thunk", baseType: !26, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIBasicType(name: "void", encoding: DW_ATE_address)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "import_funcs", baseType: !29, size: 64, offset: 128)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !26)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "import_contexts", baseType: !32, size: 64, offset: 192)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "processor", baseType: !34, offset: 256)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_processor_v0_t", scope: !15, file: !15, line: 227, size: 512, elements: !35)
!35 = !{!36}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "data", baseType: !37)
!37 = !DICompositeType(tag: DW_TAG_array_type, scope: !15, file: !15, line: 227, baseType: !38, size: 512, elements: !40)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", baseType: !39)
!39 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!40 = !{!41}
!41 = !DISubrange(count: 8)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !44)
!44 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_dispatch_state_v0_t", baseType: !45)
!45 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_dispatch_state_v0_t", scope: !15, file: !15, line: 275, size: 384, elements: !46)
!46 = !{!47, !48, !49, !52, !53, !54, !55, !56, !59, !60, !61, !66}
!47 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_x", baseType: !21, size: 32)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_y", baseType: !21, size: 32, offset: 32)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_z", baseType: !50, size: 16, offset: 64)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", baseType: !51)
!51 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "constant_count", baseType: !50, size: 16, offset: 80)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_x", baseType: !21, size: 32, offset: 96)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_y", baseType: !21, size: 32, offset: 128)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_z", baseType: !50, size: 16, offset: 160)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "max_concurrency", baseType: !57, size: 8, offset: 176)
!57 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", baseType: !58)
!58 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "binding_count", baseType: !57, size: 8, offset: 184)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "constants", baseType: !18, size: 64, offset: 192)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "binding_ptrs", baseType: !62, size: 64, offset: 256)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !63, size: 64)
!63 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !64)
!64 = !DICompositeType(tag: DW_TAG_array_type, scope: !15, file: !15, line: 227, baseType: !65, size: 4096, elements: !23)
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !57, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "binding_lengths", baseType: !67, size: 64, offset: 320)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !69)
!69 = !DICompositeType(tag: DW_TAG_array_type, scope: !15, file: !15, line: 227, baseType: !70, size: 4096, elements: !23)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", baseType: !38)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !73)
!73 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_workgroup_state_v0_t", baseType: !74)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_workgroup_state_v0_t", scope: !15, file: !15, line: 321, size: 256, elements: !75)
!75 = !{!76, !77, !78, !79, !80, !81, !82}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_x", baseType: !21, size: 32)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_y", baseType: !21, size: 32, offset: 32)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_z", baseType: !50, size: 16, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", baseType: !50, size: 16, offset: 80)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "processor_id", baseType: !21, size: 32, offset: 96)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "local_memory", baseType: !26, size: 64, offset: 128)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "local_memory_size", baseType: !21, size: 32, offset: 192)
!83 = !DILocation(line: 12, column: 8, scope: !7)
!84 = !DILocation(line: 13, column: 8, scope: !7)
!85 = !DILocation(line: 14, column: 8, scope: !7)
!86 = !DILocation(line: 19, column: 8, scope: !7)
!87 = !DILocation(line: 21, column: 8, scope: !7)
!88 = !DILocation(line: 23, column: 8, scope: !7)
!89 = distinct !DISubprogram(name: "_encoding_0_encode_32x64xi8_to_32x64xi8", linkageName: "_encoding_0_encode_32x64xi8_to_32x64xi8", scope: !3, file: !3, line: 1, type: !8, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2)
!90 = !DILocation(line: 10, column: 8, scope: !89)
!91 = !DILocation(line: 11, column: 8, scope: !89)
!92 = !DILocation(line: 14, column: 8, scope: !89)
!93 = !DILocation(line: 16, column: 8, scope: !89)
!94 = distinct !DISubprogram(name: "_encoding_1_encode_64x32xi8_to_64x32xi8", linkageName: "_encoding_1_encode_64x32xi8_to_64x32xi8", scope: !5, file: !5, line: 1, type: !8, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!95 = !DILocation(line: 11, column: 8, scope: !94)
!96 = !DILocation(line: 12, column: 8, scope: !94)
!97 = !DILocation(line: 15, column: 8, scope: !94)
!98 = !DILocation(line: 17, column: 8, scope: !94)
