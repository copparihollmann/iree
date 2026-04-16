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
@4 = private constant [36 x i8] c"tests/e2e/SpacemiT/matmul_q_i8.mlir\00", align 1
@5 = private constant [36 x i8] c"tests/e2e/SpacemiT/matmul_q_i8.mlir\00", align 1
@6 = private constant [36 x i8] c"tests/e2e/SpacemiT/matmul_q_i8.mlir\00", align 1
@iree_hal_executable_library_query_v0_source_locations = private constant [3 x %iree_hal_executable_source_location_v0_t] [%iree_hal_executable_source_location_v0_t { i32 1, i32 35, ptr @4 }, %iree_hal_executable_source_location_v0_t { i32 1, i32 35, ptr @5 }, %iree_hal_executable_source_location_v0_t { i32 1, i32 35, ptr @6 }]
@iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0_stage_location_tables = private constant [3 x %iree_hal_executable_stage_location_table_v0_t] [%iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_names, ptr @iree_hal_executable_library_query_v0_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_32x64xi8_to_32x64xi8_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_1_encode_64x32xi8_to_64x32xi8_stage_source_locations }]
@iree_hal_executable_library_query_v0 = private constant %iree_hal_executable_library_v0_t { ptr @iree_hal_executable_library_query_v0_header, %iree_hal_executable_import_table_v0_t zeroinitializer, %iree_hal_executable_export_table_v0_t { i32 3, ptr @iree_hal_executable_library_query_v0_funcs, ptr @iree_hal_executable_library_query_v0_attrs, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_names, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_source_locations, ptr @iree_hal_executable_library_query_v0_stage_location_tables }, %iree_hal_executable_constant_table_v0_t zeroinitializer, %iree_hal_executable_source_file_table_v0_t zeroinitializer }

define internal i32 @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !5 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !81
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !81
  %6 = load ptr, ptr %5, align 8, !dbg !81
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !81
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !81
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !81
  %9 = load ptr, ptr %8, align 8, !dbg !81
  %10 = getelementptr i8, ptr %9, i64 2048, !dbg !81
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !81
  %11 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !81
  %12 = extractvalue %iree_hal_executable_dispatch_state_v0_t %11, 10, !dbg !81
  %13 = getelementptr ptr, ptr %12, i32 1, !dbg !81
  %14 = load ptr, ptr %13, align 8, !dbg !81
  call void @llvm.assume(i1 true) [ "align"(ptr %14, i64 64) ], !dbg !81
  %15 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !81
  %16 = extractvalue %iree_hal_executable_workgroup_state_v0_t %15, 0, !dbg !81
  %17 = zext i32 %16 to i64, !dbg !81
  %18 = sdiv i64 %17, 2, !dbg !81
  %19 = mul i64 %18, 2, !dbg !81
  %20 = icmp ne i64 %17, %19, !dbg !81
  %21 = icmp slt i64 %17, 0, !dbg !81
  %22 = and i1 %20, %21, !dbg !81
  %23 = add i64 %18, -1, !dbg !81
  %24 = select i1 %22, i64 %23, i64 %18, !dbg !81
  %25 = srem i64 %17, 2, !dbg !81
  %26 = icmp slt i64 %25, 0, !dbg !81
  %27 = add nsw i64 %25, 2, !dbg !81
  %28 = select i1 %26, i64 %27, i64 %25, !dbg !81
  %29 = mul nsw i64 %24, 8, !dbg !81
  %30 = mul nsw i64 %28, 16, !dbg !81
  br label %31, !dbg !81

31:                                               ; preds = %35, %3
  %32 = phi i64 [ %127, %35 ], [ 0, %3 ], !dbg !81
  %33 = phi [8 x <16 x i32>] [ %126, %35 ], [ zeroinitializer, %3 ], !dbg !81
  %34 = icmp slt i64 %32, 64, !dbg !81
  br i1 %34, label %35, label %128, !dbg !81

35:                                               ; preds = %31
  %36 = mul i64 %28, 1024, !dbg !81
  %37 = mul i64 %32, 16, !dbg !81
  %38 = add i64 %36, %37, !dbg !81
  %39 = add i64 %38, 0, !dbg !81
  %40 = add i64 %39, 0, !dbg !81
  %41 = getelementptr i8, ptr %10, i64 %40, !dbg !81
  %42 = load <16 x i8>, ptr %41, align 1, !dbg !81
  %43 = extractvalue [8 x <16 x i32>] %33, 0
  %44 = extractvalue [8 x <16 x i32>] %33, 1
  %45 = extractvalue [8 x <16 x i32>] %33, 2
  %46 = extractvalue [8 x <16 x i32>] %33, 3
  %47 = extractvalue [8 x <16 x i32>] %33, 4
  %48 = extractvalue [8 x <16 x i32>] %33, 5
  %49 = extractvalue [8 x <16 x i32>] %33, 6
  %50 = extractvalue [8 x <16 x i32>] %33, 7
  %51 = call <vscale x 4 x i8> @llvm.vector.insert.nxv4i8.v16i8(<vscale x 4 x i8> undef, <16 x i8> %42, i64 0)
  %52 = mul nuw nsw i64 %24, 512
  %53 = mul nuw nsw i64 %32, 8
  %54 = add nuw nsw i64 %52, %53
  %55 = add nuw nsw i64 %54, 0
  %56 = add nuw nsw i64 %55, 0
  %57 = getelementptr inbounds nuw i8, ptr %6, i64 %56
  %58 = load i8, ptr %57, align 1
  %59 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %58, i64 16)
  %60 = add nuw nsw i64 %54, 1
  %61 = add nuw nsw i64 %60, 0
  %62 = getelementptr inbounds nuw i8, ptr %6, i64 %61
  %63 = load i8, ptr %62, align 1
  %64 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %63, i64 16)
  %65 = add nuw nsw i64 %54, 2
  %66 = add nuw nsw i64 %65, 0
  %67 = getelementptr inbounds nuw i8, ptr %6, i64 %66
  %68 = load i8, ptr %67, align 1
  %69 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %68, i64 16)
  %70 = add nuw nsw i64 %54, 3
  %71 = add nuw nsw i64 %70, 0
  %72 = getelementptr inbounds nuw i8, ptr %6, i64 %71
  %73 = load i8, ptr %72, align 1
  %74 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %73, i64 16)
  %75 = add nuw nsw i64 %54, 4
  %76 = add nuw nsw i64 %75, 0
  %77 = getelementptr inbounds nuw i8, ptr %6, i64 %76
  %78 = load i8, ptr %77, align 1
  %79 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %78, i64 16)
  %80 = add nuw nsw i64 %54, 5
  %81 = add nuw nsw i64 %80, 0
  %82 = getelementptr inbounds nuw i8, ptr %6, i64 %81
  %83 = load i8, ptr %82, align 1
  %84 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %83, i64 16)
  %85 = add nuw nsw i64 %54, 6
  %86 = add nuw nsw i64 %85, 0
  %87 = getelementptr inbounds nuw i8, ptr %6, i64 %86
  %88 = load i8, ptr %87, align 1
  %89 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %88, i64 16)
  %90 = add nuw nsw i64 %54, 7
  %91 = add nuw nsw i64 %90, 0
  %92 = getelementptr inbounds nuw i8, ptr %6, i64 %91
  %93 = load i8, ptr %92, align 1
  %94 = call <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16> undef, <vscale x 4 x i8> %51, i8 %93, i64 16)
  %95 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %43, i64 0)
  %96 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %95, <vscale x 4 x i32> %95, <vscale x 4 x i16> %59, i64 16)
  %97 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %96, i64 0)
  %98 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %44, i64 0)
  %99 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %98, <vscale x 4 x i32> %98, <vscale x 4 x i16> %64, i64 16)
  %100 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %99, i64 0)
  %101 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %45, i64 0)
  %102 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %101, <vscale x 4 x i32> %101, <vscale x 4 x i16> %69, i64 16)
  %103 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %102, i64 0)
  %104 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %46, i64 0)
  %105 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %104, <vscale x 4 x i32> %104, <vscale x 4 x i16> %74, i64 16)
  %106 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %105, i64 0)
  %107 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %47, i64 0)
  %108 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %107, <vscale x 4 x i32> %107, <vscale x 4 x i16> %79, i64 16)
  %109 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %108, i64 0)
  %110 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %48, i64 0)
  %111 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %110, <vscale x 4 x i32> %110, <vscale x 4 x i16> %84, i64 16)
  %112 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %111, i64 0)
  %113 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %49, i64 0)
  %114 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %113, <vscale x 4 x i32> %113, <vscale x 4 x i16> %89, i64 16)
  %115 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %114, i64 0)
  %116 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %50, i64 0)
  %117 = call <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32> %116, <vscale x 4 x i32> %116, <vscale x 4 x i16> %94, i64 16)
  %118 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %117, i64 0)
  %119 = insertvalue [8 x <16 x i32>] poison, <16 x i32> %97, 0
  %120 = insertvalue [8 x <16 x i32>] %119, <16 x i32> %100, 1
  %121 = insertvalue [8 x <16 x i32>] %120, <16 x i32> %103, 2
  %122 = insertvalue [8 x <16 x i32>] %121, <16 x i32> %106, 3
  %123 = insertvalue [8 x <16 x i32>] %122, <16 x i32> %109, 4
  %124 = insertvalue [8 x <16 x i32>] %123, <16 x i32> %112, 5
  %125 = insertvalue [8 x <16 x i32>] %124, <16 x i32> %115, 6
  %126 = insertvalue [8 x <16 x i32>] %125, <16 x i32> %118, 7
  %127 = add i64 %32, 1, !dbg !81
  br label %31, !dbg !81

128:                                              ; preds = %31
  %129 = extractvalue [8 x <16 x i32>] %33, 0, !dbg !81
  %130 = mul i64 %29, 32, !dbg !81
  %131 = add i64 %130, %30, !dbg !81
  %132 = getelementptr i32, ptr %14, i64 %131, !dbg !81
  store <16 x i32> %129, ptr %132, align 4, !dbg !81
  %133 = extractvalue [8 x <16 x i32>] %33, 1, !dbg !81
  %134 = add i64 %29, 1, !dbg !81
  %135 = mul i64 %134, 32, !dbg !81
  %136 = add i64 %135, %30, !dbg !81
  %137 = getelementptr i32, ptr %14, i64 %136, !dbg !81
  store <16 x i32> %133, ptr %137, align 4, !dbg !81
  %138 = extractvalue [8 x <16 x i32>] %33, 2, !dbg !81
  %139 = add i64 %29, 2, !dbg !81
  %140 = mul i64 %139, 32, !dbg !81
  %141 = add i64 %140, %30, !dbg !81
  %142 = getelementptr i32, ptr %14, i64 %141, !dbg !81
  store <16 x i32> %138, ptr %142, align 4, !dbg !81
  %143 = extractvalue [8 x <16 x i32>] %33, 3, !dbg !81
  %144 = add i64 %29, 3, !dbg !81
  %145 = mul i64 %144, 32, !dbg !81
  %146 = add i64 %145, %30, !dbg !81
  %147 = getelementptr i32, ptr %14, i64 %146, !dbg !81
  store <16 x i32> %143, ptr %147, align 4, !dbg !81
  %148 = extractvalue [8 x <16 x i32>] %33, 4, !dbg !81
  %149 = add i64 %29, 4, !dbg !81
  %150 = mul i64 %149, 32, !dbg !81
  %151 = add i64 %150, %30, !dbg !81
  %152 = getelementptr i32, ptr %14, i64 %151, !dbg !81
  store <16 x i32> %148, ptr %152, align 4, !dbg !81
  %153 = extractvalue [8 x <16 x i32>] %33, 5, !dbg !81
  %154 = add i64 %29, 5, !dbg !81
  %155 = mul i64 %154, 32, !dbg !81
  %156 = add i64 %155, %30, !dbg !81
  %157 = getelementptr i32, ptr %14, i64 %156, !dbg !81
  store <16 x i32> %153, ptr %157, align 4, !dbg !81
  %158 = extractvalue [8 x <16 x i32>] %33, 6, !dbg !81
  %159 = add i64 %29, 6, !dbg !81
  %160 = mul i64 %159, 32, !dbg !81
  %161 = add i64 %160, %30, !dbg !81
  %162 = getelementptr i32, ptr %14, i64 %161, !dbg !81
  store <16 x i32> %158, ptr %162, align 4, !dbg !81
  %163 = extractvalue [8 x <16 x i32>] %33, 7, !dbg !81
  %164 = add i64 %29, 7, !dbg !81
  %165 = mul i64 %164, 32, !dbg !81
  %166 = add i64 %165, %30, !dbg !81
  %167 = getelementptr i32, ptr %14, i64 %166, !dbg !81
  store <16 x i32> %163, ptr %167, align 4, !dbg !81
  ret i32 0, !dbg !81
}

define internal i32 @_encoding_0_encode_32x64xi8_to_32x64xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !82 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !83
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !83
  %6 = load ptr, ptr %5, align 8, !dbg !83
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !83
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !83
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !83
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !83
  %10 = load ptr, ptr %9, align 8, !dbg !83
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !83
  %11 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !83
  %12 = extractvalue %iree_hal_executable_workgroup_state_v0_t %11, 0, !dbg !83
  %13 = zext i32 %12 to i64, !dbg !83
  %14 = sdiv i64 %13, 4, !dbg !83
  %15 = mul i64 %14, 4, !dbg !83
  %16 = icmp ne i64 %13, %15, !dbg !83
  %17 = icmp slt i64 %13, 0, !dbg !83
  %18 = and i1 %16, %17, !dbg !83
  %19 = add i64 %14, -1, !dbg !83
  %20 = select i1 %18, i64 %19, i64 %14, !dbg !83
  %21 = srem i64 %13, 4, !dbg !83
  %22 = icmp slt i64 %21, 0, !dbg !83
  %23 = add nsw i64 %21, 4, !dbg !83
  %24 = select i1 %22, i64 %23, i64 %21, !dbg !83
  %25 = mul nsw i64 %24, 16, !dbg !83
  br label %26, !dbg !83

26:                                               ; preds = %29, %3
  %27 = phi i64 [ %93, %29 ], [ 0, %3 ], !dbg !83
  %28 = icmp slt i64 %27, 16, !dbg !83
  br i1 %28, label %29, label %94, !dbg !83

29:                                               ; preds = %26
  %30 = add i64 %27, %25, !dbg !83
  %31 = mul nsw i64 %20, 8, !dbg !83
  %32 = mul i64 %31, 64, !dbg !83
  %33 = add i64 %32, %30, !dbg !83
  %34 = getelementptr i8, ptr %6, i64 %33, !dbg !83
  %35 = load <1 x i8>, ptr %34, align 1, !dbg !83
  %36 = add i64 %31, 1, !dbg !83
  %37 = mul i64 %36, 64, !dbg !83
  %38 = add i64 %37, %30, !dbg !83
  %39 = getelementptr i8, ptr %6, i64 %38, !dbg !83
  %40 = load <1 x i8>, ptr %39, align 1, !dbg !83
  %41 = add i64 %31, 2, !dbg !83
  %42 = mul i64 %41, 64, !dbg !83
  %43 = add i64 %42, %30, !dbg !83
  %44 = getelementptr i8, ptr %6, i64 %43, !dbg !83
  %45 = load <1 x i8>, ptr %44, align 1, !dbg !83
  %46 = add i64 %31, 3, !dbg !83
  %47 = mul i64 %46, 64, !dbg !83
  %48 = add i64 %47, %30, !dbg !83
  %49 = getelementptr i8, ptr %6, i64 %48, !dbg !83
  %50 = load <1 x i8>, ptr %49, align 1, !dbg !83
  %51 = add i64 %31, 4, !dbg !83
  %52 = mul i64 %51, 64, !dbg !83
  %53 = add i64 %52, %30, !dbg !83
  %54 = getelementptr i8, ptr %6, i64 %53, !dbg !83
  %55 = load <1 x i8>, ptr %54, align 1, !dbg !83
  %56 = add i64 %31, 5, !dbg !83
  %57 = mul i64 %56, 64, !dbg !83
  %58 = add i64 %57, %30, !dbg !83
  %59 = getelementptr i8, ptr %6, i64 %58, !dbg !83
  %60 = load <1 x i8>, ptr %59, align 1, !dbg !83
  %61 = add i64 %31, 6, !dbg !83
  %62 = mul i64 %61, 64, !dbg !83
  %63 = add i64 %62, %30, !dbg !83
  %64 = getelementptr i8, ptr %6, i64 %63, !dbg !83
  %65 = load <1 x i8>, ptr %64, align 1, !dbg !83
  %66 = add i64 %31, 7, !dbg !83
  %67 = mul i64 %66, 64, !dbg !83
  %68 = add i64 %67, %30, !dbg !83
  %69 = getelementptr i8, ptr %6, i64 %68, !dbg !83
  %70 = load <1 x i8>, ptr %69, align 1, !dbg !83
  %71 = extractelement <1 x i8> %35, i64 0, !dbg !83
  %72 = extractelement <1 x i8> %40, i64 0, !dbg !83
  %73 = extractelement <1 x i8> %45, i64 0, !dbg !83
  %74 = extractelement <1 x i8> %50, i64 0, !dbg !83
  %75 = extractelement <1 x i8> %55, i64 0, !dbg !83
  %76 = extractelement <1 x i8> %60, i64 0, !dbg !83
  %77 = extractelement <1 x i8> %65, i64 0, !dbg !83
  %78 = extractelement <1 x i8> %70, i64 0, !dbg !83
  %79 = insertelement <8 x i8> poison, i8 %71, i64 0, !dbg !83
  %80 = insertelement <8 x i8> %79, i8 %72, i64 1, !dbg !83
  %81 = insertelement <8 x i8> %80, i8 %73, i64 2, !dbg !83
  %82 = insertelement <8 x i8> %81, i8 %74, i64 3, !dbg !83
  %83 = insertelement <8 x i8> %82, i8 %75, i64 4, !dbg !83
  %84 = insertelement <8 x i8> %83, i8 %76, i64 5, !dbg !83
  %85 = insertelement <8 x i8> %84, i8 %77, i64 6, !dbg !83
  %86 = insertelement <8 x i8> %85, i8 %78, i64 7, !dbg !83
  %87 = mul i64 %20, 512, !dbg !83
  %88 = mul i64 %30, 8, !dbg !83
  %89 = add i64 %87, %88, !dbg !83
  %90 = add i64 %89, 0, !dbg !83
  %91 = add i64 %90, 0, !dbg !83
  %92 = getelementptr i8, ptr %10, i64 %91, !dbg !83
  store <8 x i8> %86, ptr %92, align 1, !dbg !83
  %93 = add i64 %27, 1, !dbg !83
  br label %26, !dbg !83

94:                                               ; preds = %26
  ret i32 0, !dbg !83
}

define internal i32 @_encoding_1_encode_64x32xi8_to_64x32xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !84 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !85
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !85
  %6 = load ptr, ptr %5, align 8, !dbg !85
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !85
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !85
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !85
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !85
  %10 = load ptr, ptr %9, align 8, !dbg !85
  %11 = getelementptr i8, ptr %10, i64 2048, !dbg !85
  call void @llvm.assume(i1 true) [ "align"(ptr %11, i64 64) ], !dbg !85
  %12 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !85
  %13 = extractvalue %iree_hal_executable_workgroup_state_v0_t %12, 0, !dbg !85
  %14 = zext i32 %13 to i64, !dbg !85
  %15 = sdiv i64 %14, 64, !dbg !85
  %16 = mul i64 %15, 64, !dbg !85
  %17 = icmp ne i64 %14, %16, !dbg !85
  %18 = icmp slt i64 %14, 0, !dbg !85
  %19 = and i1 %17, %18, !dbg !85
  %20 = add i64 %15, -1, !dbg !85
  %21 = select i1 %19, i64 %20, i64 %15, !dbg !85
  %22 = srem i64 %14, 64, !dbg !85
  %23 = icmp slt i64 %22, 0, !dbg !85
  %24 = add nsw i64 %22, 64, !dbg !85
  %25 = select i1 %23, i64 %24, i64 %22, !dbg !85
  %26 = mul nsw i64 %21, 16, !dbg !85
  %27 = mul i64 %25, 32, !dbg !85
  %28 = add i64 %27, %26, !dbg !85
  %29 = getelementptr i8, ptr %6, i64 %28, !dbg !85
  %30 = load <16 x i8>, ptr %29, align 1, !dbg !85
  %31 = mul i64 %21, 1024, !dbg !85
  %32 = mul i64 %25, 16, !dbg !85
  %33 = add i64 %31, %32, !dbg !85
  %34 = add i64 %33, 0, !dbg !85
  %35 = add i64 %34, 0, !dbg !85
  %36 = getelementptr i8, ptr %11, i64 %35, !dbg !85
  store <16 x i8> %30, ptr %36, align 1, !dbg !85
  ret i32 0, !dbg !85
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i8> @llvm.vector.insert.nxv4i8.v16i8(<vscale x 4 x i8>, <16 x i8>, i64 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i16> @llvm.riscv.vwmul.nxv4i16.nxv4i8.i8.i64(<vscale x 4 x i16>, <vscale x 4 x i8>, i8, i64) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32>, <16 x i32>, i64 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i32> @llvm.riscv.vwadd.w.nxv4i32.nxv4i16.i64(<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i16>, i64) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32>, i64 immarg) #2

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
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #4 = { uwtable "nonlazybind" }

!llvm.dbg.cu = !{!0, !2, !3}
!llvm.module.flags = !{!4}

!0 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "-", directory: "")
!2 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!3 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = distinct !DISubprogram(name: "matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32", linkageName: "matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32", scope: !1, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!6 = !DISubroutineType(cc: DW_CC_normal, types: !7)
!7 = !{!8, !9, !40, !69}
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_environment_v0_t", baseType: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_environment_v0_t", scope: !13, file: !13, line: 246, size: 768, elements: !14)
!13 = !DIFile(filename: "runtime/src/iree/hal/local/executable_library.h", directory: ".")
!14 = !{!15, !23, !26, !29, !31}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "constants", baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, scope: !13, file: !13, line: 227, baseType: !19, size: 2048, elements: !21)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", baseType: !20)
!20 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!21 = !{!22}
!22 = !DISubrange(count: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "import_thunk", baseType: !24, size: 64, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIBasicType(name: "void", encoding: DW_ATE_address)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "import_funcs", baseType: !27, size: 64, offset: 128)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !24)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "import_contexts", baseType: !30, size: 64, offset: 192)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "processor", baseType: !32, offset: 256)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_processor_v0_t", scope: !13, file: !13, line: 227, size: 512, elements: !33)
!33 = !{!34}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "data", baseType: !35)
!35 = !DICompositeType(tag: DW_TAG_array_type, scope: !13, file: !13, line: 227, baseType: !36, size: 512, elements: !38)
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", baseType: !37)
!37 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!38 = !{!39}
!39 = !DISubrange(count: 8)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !42)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_dispatch_state_v0_t", baseType: !43)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_dispatch_state_v0_t", scope: !13, file: !13, line: 275, size: 384, elements: !44)
!44 = !{!45, !46, !47, !50, !51, !52, !53, !54, !57, !58, !59, !64}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_x", baseType: !19, size: 32)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_y", baseType: !19, size: 32, offset: 32)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_size_z", baseType: !48, size: 16, offset: 64)
!48 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", baseType: !49)
!49 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "constant_count", baseType: !48, size: 16, offset: 80)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_x", baseType: !19, size: 32, offset: 96)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_y", baseType: !19, size: 32, offset: 128)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_count_z", baseType: !48, size: 16, offset: 160)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "max_concurrency", baseType: !55, size: 8, offset: 176)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", baseType: !56)
!56 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "binding_count", baseType: !55, size: 8, offset: 184)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "constants", baseType: !16, size: 64, offset: 192)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "binding_ptrs", baseType: !60, size: 64, offset: 256)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !62)
!62 = !DICompositeType(tag: DW_TAG_array_type, scope: !13, file: !13, line: 227, baseType: !63, size: 4096, elements: !21)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "binding_lengths", baseType: !65, size: 64, offset: 320)
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64)
!66 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !67)
!67 = !DICompositeType(tag: DW_TAG_array_type, scope: !13, file: !13, line: 227, baseType: !68, size: 4096, elements: !21)
!68 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", baseType: !36)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !71)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "iree_hal_executable_workgroup_state_v0_t", baseType: !72)
!72 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iree_hal_executable_workgroup_state_v0_t", scope: !13, file: !13, line: 321, size: 256, elements: !73)
!73 = !{!74, !75, !76, !77, !78, !79, !80}
!74 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_x", baseType: !19, size: 32)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_y", baseType: !19, size: 32, offset: 32)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "workgroup_id_z", baseType: !48, size: 16, offset: 64)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", baseType: !48, size: 16, offset: 80)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "processor_id", baseType: !19, size: 32, offset: 96)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "local_memory", baseType: !24, size: 64, offset: 128)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "local_memory_size", baseType: !19, size: 32, offset: 192)
!81 = !DILocation(line: 1, column: 1, scope: !5)
!82 = distinct !DISubprogram(name: "_encoding_0_encode_32x64xi8_to_32x64xi8", linkageName: "_encoding_0_encode_32x64xi8_to_32x64xi8", scope: !1, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2)
!83 = !DILocation(line: 1, column: 1, scope: !82)
!84 = distinct !DISubprogram(name: "_encoding_1_encode_64x32xi8_to_64x32xi8", linkageName: "_encoding_1_encode_64x32xi8_to_64x32xi8", scope: !1, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !3)
!85 = !DILocation(line: 1, column: 1, scope: !84)
