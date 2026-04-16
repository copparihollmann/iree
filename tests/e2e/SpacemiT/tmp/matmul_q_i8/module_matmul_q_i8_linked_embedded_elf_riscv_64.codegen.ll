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
@4 = private constant [141 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/SpacemiT/tmp/matmul_q_i8/files/configured_module_matmul_i8_quantized_dispatch_0.mlir\00", align 1
@5 = private constant [122 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/SpacemiT/tmp/matmul_q_i8/files/configured_module__encoding_0.mlir\00", align 1
@6 = private constant [122 x i8] c"/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/SpacemiT/tmp/matmul_q_i8/files/configured_module__encoding_1.mlir\00", align 1
@iree_hal_executable_library_query_v0_source_locations = private constant [3 x %iree_hal_executable_source_location_v0_t] [%iree_hal_executable_source_location_v0_t { i32 3, i32 140, ptr @4 }, %iree_hal_executable_source_location_v0_t { i32 3, i32 121, ptr @5 }, %iree_hal_executable_source_location_v0_t { i32 3, i32 121, ptr @6 }]
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
  %29 = mul nsw i64 %28, 4, !dbg !86
  %30 = mul nsw i64 %24, 4, !dbg !87
  %31 = mul nsw i64 %28, 16, !dbg !87
  br label %32, !dbg !86

32:                                               ; preds = %121, %3
  %33 = phi i64 [ %143, %121 ], [ 0, %3 ], !dbg !86
  %34 = icmp slt i64 %33, 4, !dbg !86
  br i1 %34, label %35, label %144, !dbg !86

35:                                               ; preds = %32
  %36 = add i64 %33, %29, !dbg !86
  br label %37, !dbg !86

37:                                               ; preds = %41, %35
  %38 = phi i64 [ %120, %41 ], [ 0, %35 ], !dbg !86
  %39 = phi [4 x <4 x i32>] [ %119, %41 ], [ zeroinitializer, %35 ], !dbg !86
  %40 = icmp slt i64 %38, 8, !dbg !86
  br i1 %40, label %41, label %121, !dbg !86

41:                                               ; preds = %37
  %42 = mul i64 %24, 256, !dbg !86
  %43 = mul i64 %38, 32, !dbg !86
  %44 = add i64 %42, %43, !dbg !86
  %45 = add i64 %44, 0, !dbg !86
  %46 = add i64 %45, 0, !dbg !86
  %47 = getelementptr i8, ptr %6, i64 %46, !dbg !86
  %48 = load <8 x i8>, ptr %47, align 1, !dbg !86
  %49 = add i64 %44, 8, !dbg !86
  %50 = add i64 %49, 0, !dbg !86
  %51 = getelementptr i8, ptr %6, i64 %50, !dbg !86
  %52 = load <8 x i8>, ptr %51, align 1, !dbg !86
  %53 = add i64 %44, 16, !dbg !86
  %54 = add i64 %53, 0, !dbg !86
  %55 = getelementptr i8, ptr %6, i64 %54, !dbg !86
  %56 = load <8 x i8>, ptr %55, align 1, !dbg !86
  %57 = add i64 %44, 24, !dbg !86
  %58 = add i64 %57, 0, !dbg !86
  %59 = getelementptr i8, ptr %6, i64 %58, !dbg !86
  %60 = load <8 x i8>, ptr %59, align 1, !dbg !86
  %61 = mul i64 %36, 256, !dbg !86
  %62 = add i64 %61, %43, !dbg !86
  %63 = add i64 %62, 0, !dbg !86
  %64 = add i64 %63, 0, !dbg !86
  %65 = getelementptr i8, ptr %10, i64 %64, !dbg !86
  %66 = load <8 x i8>, ptr %65, align 1, !dbg !86
  %67 = add i64 %62, 8, !dbg !86
  %68 = add i64 %67, 0, !dbg !86
  %69 = getelementptr i8, ptr %10, i64 %68, !dbg !86
  %70 = load <8 x i8>, ptr %69, align 1, !dbg !86
  %71 = add i64 %62, 16, !dbg !86
  %72 = add i64 %71, 0, !dbg !86
  %73 = getelementptr i8, ptr %10, i64 %72, !dbg !86
  %74 = load <8 x i8>, ptr %73, align 1, !dbg !86
  %75 = add i64 %62, 24, !dbg !86
  %76 = add i64 %75, 0, !dbg !86
  %77 = getelementptr i8, ptr %10, i64 %76, !dbg !86
  %78 = load <8 x i8>, ptr %77, align 1, !dbg !86
  %79 = shufflevector <8 x i8> %48, <8 x i8> %48, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %80 = shufflevector <32 x i8> %79, <32 x i8> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %81 = shufflevector <8 x i8> %52, <8 x i8> %52, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %82 = shufflevector <32 x i8> %81, <32 x i8> %80, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %83 = shufflevector <8 x i8> %56, <8 x i8> %56, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %84 = shufflevector <32 x i8> %83, <32 x i8> %82, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %85 = shufflevector <8 x i8> %60, <8 x i8> %60, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %86 = shufflevector <32 x i8> %85, <32 x i8> %84, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %87 = shufflevector <8 x i8> %66, <8 x i8> %66, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %88 = shufflevector <32 x i8> %87, <32 x i8> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %89 = shufflevector <8 x i8> %70, <8 x i8> %70, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %90 = shufflevector <32 x i8> %89, <32 x i8> %88, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %91 = shufflevector <8 x i8> %74, <8 x i8> %74, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %92 = shufflevector <32 x i8> %91, <32 x i8> %90, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %93 = shufflevector <8 x i8> %78, <8 x i8> %78, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %94 = shufflevector <32 x i8> %93, <32 x i8> %92, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %95 = extractvalue [4 x <4 x i32>] %39, 0
  %96 = shufflevector <4 x i32> %95, <4 x i32> %95, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %97 = shufflevector <16 x i32> %96, <16 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %98 = extractvalue [4 x <4 x i32>] %39, 1
  %99 = shufflevector <4 x i32> %98, <4 x i32> %98, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %100 = shufflevector <16 x i32> %99, <16 x i32> %97, <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 0, i32 1, i32 2, i32 3, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %101 = extractvalue [4 x <4 x i32>] %39, 2
  %102 = shufflevector <4 x i32> %101, <4 x i32> %101, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %103 = shufflevector <16 x i32> %102, <16 x i32> %100, <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 0, i32 1, i32 2, i32 3, i32 28, i32 29, i32 30, i32 31>
  %104 = extractvalue [4 x <4 x i32>] %39, 3
  %105 = shufflevector <4 x i32> %104, <4 x i32> %104, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %106 = shufflevector <16 x i32> %105, <16 x i32> %103, <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 0, i32 1, i32 2, i32 3>
  %107 = call <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v32i8(<vscale x 8 x i8> undef, <32 x i8> %86, i64 0)
  %108 = call <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v32i8(<vscale x 8 x i8> undef, <32 x i8> %94, i64 0)
  %109 = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> %106, i64 0)
  %110 = call <vscale x 4 x i32> @llvm.riscv.smt.vmadot.nxv4i32.nxv8i8.nxv8i8.i64(<vscale x 4 x i32> %109, <vscale x 8 x i8> %107, <vscale x 8 x i8> %108, i64 16)
  %111 = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %110, i64 0)
  %112 = shufflevector <16 x i32> %111, <16 x i32> %111, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %113 = shufflevector <16 x i32> %111, <16 x i32> %111, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %114 = shufflevector <16 x i32> %111, <16 x i32> %111, <4 x i32> <i32 8, i32 9, i32 10, i32 11>
  %115 = shufflevector <16 x i32> %111, <16 x i32> %111, <4 x i32> <i32 12, i32 13, i32 14, i32 15>
  %116 = insertvalue [4 x <4 x i32>] poison, <4 x i32> %112, 0
  %117 = insertvalue [4 x <4 x i32>] %116, <4 x i32> %113, 1
  %118 = insertvalue [4 x <4 x i32>] %117, <4 x i32> %114, 2
  %119 = insertvalue [4 x <4 x i32>] %118, <4 x i32> %115, 3
  %120 = add i64 %38, 1, !dbg !86
  br label %37, !dbg !86

121:                                              ; preds = %37
  %122 = mul nsw i64 %33, 4, !dbg !87
  %123 = extractvalue [4 x <4 x i32>] %39, 0, !dbg !86
  %124 = add i64 %31, %122, !dbg !86
  %125 = mul i64 %30, 32, !dbg !86
  %126 = add i64 %125, %124, !dbg !86
  %127 = getelementptr i32, ptr %14, i64 %126, !dbg !86
  store <4 x i32> %123, ptr %127, align 4, !dbg !86
  %128 = extractvalue [4 x <4 x i32>] %39, 1, !dbg !86
  %129 = add i64 %30, 1, !dbg !86
  %130 = mul i64 %129, 32, !dbg !86
  %131 = add i64 %130, %124, !dbg !86
  %132 = getelementptr i32, ptr %14, i64 %131, !dbg !86
  store <4 x i32> %128, ptr %132, align 4, !dbg !86
  %133 = extractvalue [4 x <4 x i32>] %39, 2, !dbg !86
  %134 = add i64 %30, 2, !dbg !86
  %135 = mul i64 %134, 32, !dbg !86
  %136 = add i64 %135, %124, !dbg !86
  %137 = getelementptr i32, ptr %14, i64 %136, !dbg !86
  store <4 x i32> %133, ptr %137, align 4, !dbg !86
  %138 = extractvalue [4 x <4 x i32>] %39, 3, !dbg !86
  %139 = add i64 %30, 3, !dbg !86
  %140 = mul i64 %139, 32, !dbg !86
  %141 = add i64 %140, %124, !dbg !86
  %142 = getelementptr i32, ptr %14, i64 %141, !dbg !86
  store <4 x i32> %138, ptr %142, align 4, !dbg !86
  %143 = add i64 %33, 1, !dbg !86
  br label %32, !dbg !86

144:                                              ; preds = %32
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
  %26 = mul nsw i64 %20, 4, !dbg !92
  %27 = mul i64 %26, 64, !dbg !92
  %28 = add i64 %27, %25, !dbg !92
  %29 = getelementptr i8, ptr %6, i64 %28, !dbg !92
  %30 = load <8 x i8>, ptr %29, align 1, !dbg !92
  %31 = add i64 %26, 1, !dbg !92
  %32 = mul i64 %31, 64, !dbg !92
  %33 = add i64 %32, %25, !dbg !92
  %34 = getelementptr i8, ptr %6, i64 %33, !dbg !92
  %35 = load <8 x i8>, ptr %34, align 1, !dbg !92
  %36 = add i64 %26, 2, !dbg !92
  %37 = mul i64 %36, 64, !dbg !92
  %38 = add i64 %37, %25, !dbg !92
  %39 = getelementptr i8, ptr %6, i64 %38, !dbg !92
  %40 = load <8 x i8>, ptr %39, align 1, !dbg !92
  %41 = add i64 %26, 3, !dbg !92
  %42 = mul i64 %41, 64, !dbg !92
  %43 = add i64 %42, %25, !dbg !92
  %44 = getelementptr i8, ptr %6, i64 %43, !dbg !92
  %45 = load <8 x i8>, ptr %44, align 1, !dbg !92
  %46 = mul i64 %20, 256, !dbg !92
  %47 = mul i64 %24, 32, !dbg !92
  %48 = add i64 %46, %47, !dbg !92
  %49 = add i64 %48, 0, !dbg !92
  %50 = add i64 %49, 0, !dbg !92
  %51 = getelementptr i8, ptr %10, i64 %50, !dbg !92
  store <8 x i8> %30, ptr %51, align 1, !dbg !92
  %52 = add i64 %48, 8, !dbg !92
  %53 = add i64 %52, 0, !dbg !92
  %54 = getelementptr i8, ptr %10, i64 %53, !dbg !92
  store <8 x i8> %35, ptr %54, align 1, !dbg !92
  %55 = add i64 %48, 16, !dbg !92
  %56 = add i64 %55, 0, !dbg !92
  %57 = getelementptr i8, ptr %10, i64 %56, !dbg !92
  store <8 x i8> %40, ptr %57, align 1, !dbg !92
  %58 = add i64 %48, 24, !dbg !92
  %59 = add i64 %58, 0, !dbg !92
  %60 = getelementptr i8, ptr %10, i64 %59, !dbg !92
  store <8 x i8> %45, ptr %60, align 1, !dbg !92
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
  %15 = sdiv i64 %14, 8, !dbg !97
  %16 = mul i64 %15, 8, !dbg !97
  %17 = icmp ne i64 %14, %16, !dbg !97
  %18 = icmp slt i64 %14, 0, !dbg !97
  %19 = and i1 %17, %18, !dbg !97
  %20 = add i64 %15, -1, !dbg !97
  %21 = select i1 %19, i64 %20, i64 %15, !dbg !97
  %22 = srem i64 %14, 8, !dbg !97
  %23 = icmp slt i64 %22, 0, !dbg !97
  %24 = add nsw i64 %22, 8, !dbg !97
  %25 = select i1 %23, i64 %24, i64 %22, !dbg !97
  %26 = mul nsw i64 %21, 4, !dbg !97
  %27 = mul nsw i64 %25, 8, !dbg !97
  %28 = mul i64 %27, 32, !dbg !97
  %29 = add i64 %28, %26, !dbg !97
  %30 = getelementptr i8, ptr %6, i64 %29, !dbg !97
  %31 = load <4 x i8>, ptr %30, align 1, !dbg !97
  %32 = add i64 %27, 1, !dbg !97
  %33 = mul i64 %32, 32, !dbg !97
  %34 = add i64 %33, %26, !dbg !97
  %35 = getelementptr i8, ptr %6, i64 %34, !dbg !97
  %36 = load <4 x i8>, ptr %35, align 1, !dbg !97
  %37 = add i64 %27, 2, !dbg !97
  %38 = mul i64 %37, 32, !dbg !97
  %39 = add i64 %38, %26, !dbg !97
  %40 = getelementptr i8, ptr %6, i64 %39, !dbg !97
  %41 = load <4 x i8>, ptr %40, align 1, !dbg !97
  %42 = add i64 %27, 3, !dbg !97
  %43 = mul i64 %42, 32, !dbg !97
  %44 = add i64 %43, %26, !dbg !97
  %45 = getelementptr i8, ptr %6, i64 %44, !dbg !97
  %46 = load <4 x i8>, ptr %45, align 1, !dbg !97
  %47 = add i64 %27, 4, !dbg !97
  %48 = mul i64 %47, 32, !dbg !97
  %49 = add i64 %48, %26, !dbg !97
  %50 = getelementptr i8, ptr %6, i64 %49, !dbg !97
  %51 = load <4 x i8>, ptr %50, align 1, !dbg !97
  %52 = add i64 %27, 5, !dbg !97
  %53 = mul i64 %52, 32, !dbg !97
  %54 = add i64 %53, %26, !dbg !97
  %55 = getelementptr i8, ptr %6, i64 %54, !dbg !97
  %56 = load <4 x i8>, ptr %55, align 1, !dbg !97
  %57 = add i64 %27, 6, !dbg !97
  %58 = mul i64 %57, 32, !dbg !97
  %59 = add i64 %58, %26, !dbg !97
  %60 = getelementptr i8, ptr %6, i64 %59, !dbg !97
  %61 = load <4 x i8>, ptr %60, align 1, !dbg !97
  %62 = add i64 %27, 7, !dbg !97
  %63 = mul i64 %62, 32, !dbg !97
  %64 = add i64 %63, %26, !dbg !97
  %65 = getelementptr i8, ptr %6, i64 %64, !dbg !97
  %66 = load <4 x i8>, ptr %65, align 1, !dbg !97
  %67 = shufflevector <4 x i8> %31, <4 x i8> %31, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %68 = shufflevector <32 x i8> %67, <32 x i8> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %69 = shufflevector <4 x i8> %36, <4 x i8> %36, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %70 = shufflevector <32 x i8> %69, <32 x i8> %68, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 0, i32 1, i32 2, i32 3, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %71 = shufflevector <4 x i8> %41, <4 x i8> %41, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %72 = shufflevector <32 x i8> %71, <32 x i8> %70, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 0, i32 1, i32 2, i32 3, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %73 = shufflevector <4 x i8> %46, <4 x i8> %46, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %74 = shufflevector <32 x i8> %73, <32 x i8> %72, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 0, i32 1, i32 2, i32 3, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %75 = shufflevector <4 x i8> %51, <4 x i8> %51, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %76 = shufflevector <32 x i8> %75, <32 x i8> %74, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 0, i32 1, i32 2, i32 3, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %77 = shufflevector <4 x i8> %56, <4 x i8> %56, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %78 = shufflevector <32 x i8> %77, <32 x i8> %76, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 0, i32 1, i32 2, i32 3, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %79 = shufflevector <4 x i8> %61, <4 x i8> %61, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %80 = shufflevector <32 x i8> %79, <32 x i8> %78, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 0, i32 1, i32 2, i32 3, i32 60, i32 61, i32 62, i32 63>, !dbg !97
  %81 = shufflevector <4 x i8> %66, <4 x i8> %66, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !97
  %82 = shufflevector <32 x i8> %81, <32 x i8> %80, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 0, i32 1, i32 2, i32 3>, !dbg !97
  %83 = shufflevector <32 x i8> %82, <32 x i8> %82, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29, i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30, i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>, !dbg !97
  %84 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, !dbg !97
  %85 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>, !dbg !97
  %86 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>, !dbg !97
  %87 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>, !dbg !97
  %88 = mul i64 %21, 256, !dbg !97
  %89 = mul i64 %25, 32, !dbg !97
  %90 = add i64 %88, %89, !dbg !97
  %91 = add i64 %90, 0, !dbg !97
  %92 = add i64 %91, 0, !dbg !97
  %93 = getelementptr i8, ptr %11, i64 %92, !dbg !97
  store <8 x i8> %84, ptr %93, align 1, !dbg !97
  %94 = add i64 %90, 8, !dbg !97
  %95 = add i64 %94, 0, !dbg !97
  %96 = getelementptr i8, ptr %11, i64 %95, !dbg !97
  store <8 x i8> %85, ptr %96, align 1, !dbg !97
  %97 = add i64 %90, 16, !dbg !97
  %98 = add i64 %97, 0, !dbg !97
  %99 = getelementptr i8, ptr %11, i64 %98, !dbg !97
  store <8 x i8> %86, ptr %99, align 1, !dbg !97
  %100 = add i64 %90, 24, !dbg !97
  %101 = add i64 %100, 0, !dbg !97
  %102 = getelementptr i8, ptr %11, i64 %101, !dbg !97
  store <8 x i8> %87, ptr %102, align 1, !dbg !97
  ret i32 0, !dbg !98
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 8 x i8> @llvm.vector.insert.nxv8i8.v32i8(<vscale x 8 x i8>, <32 x i8>, i64 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32>, <16 x i32>, i64 immarg) #2

; Function Attrs: nounwind memory(none)
declare <vscale x 4 x i32> @llvm.riscv.smt.vmadot.nxv4i32.nxv8i8.nxv8i8.i64(<vscale x 4 x i32>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64) #3

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
attributes #3 = { nounwind memory(none) "frame-pointer"="all" "hot" "no-builtins" "nonlazybind" }
attributes #4 = { uwtable "nonlazybind" }

!llvm.dbg.cu = !{!0, !2, !4}
!llvm.module.flags = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "configured_module_matmul_i8_quantized_dispatch_0.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/SpacemiT/tmp/matmul_q_i8/files")
!2 = distinct !DICompileUnit(language: DW_LANG_C17, file: !3, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!3 = !DIFile(filename: "configured_module__encoding_0.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/SpacemiT/tmp/matmul_q_i8/files")
!4 = distinct !DICompileUnit(language: DW_LANG_C17, file: !5, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!5 = !DIFile(filename: "configured_module__encoding_1.mlir", directory: "/scratch2/agustin/merlin/third_party/iree_bar/tests/e2e/SpacemiT/tmp/matmul_q_i8/files")
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
