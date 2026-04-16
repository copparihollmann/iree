; ModuleID = 'conv_i8_linked'
source_filename = "conv_i8_linked"
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

@0 = private constant [15 x i8] c"conv_i8_linked\00", align 1
@iree_hal_executable_library_query_v0_header = private constant %iree_hal_executable_library_header_t { i32 6, ptr @0, i32 0, i32 0 }
@iree_hal_executable_library_query_v0_funcs = private constant [3 x ptr] [ptr @conv_i8_dispatch_0_generic_32x32x3x3x8_i8, ptr @conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32, ptr @_encoding_0_encode_72x16xi8_to_72x16xi8]
@iree_hal_executable_library_query_v0_attrs = private constant [3 x %iree_hal_executable_dispatch_attrs_v0_t] [%iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }, %iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }, %iree_hal_executable_dispatch_attrs_v0_t { i64 0, i16 0, i8 0, i8 2, i32 1, i32 1, i16 1, i16 0, i64 0, i64 0, i64 0, i64 0, i64 0 }]
@1 = private constant [42 x i8] c"conv_i8_dispatch_0_generic_32x32x3x3x8_i8\00", align 1
@2 = private constant [47 x i8] c"conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32\00", align 1
@3 = private constant [40 x i8] c"_encoding_0_encode_72x16xi8_to_72x16xi8\00", align 1
@iree_hal_executable_library_query_v0_names = private constant [3 x ptr] [ptr @1, ptr @2, ptr @3]
@4 = private constant [13 x i8] c"conv_i8.mlir\00", align 1
@5 = private constant [13 x i8] c"conv_i8.mlir\00", align 1
@6 = private constant [13 x i8] c"conv_i8.mlir\00", align 1
@iree_hal_executable_library_query_v0_source_locations = private constant [3 x %iree_hal_executable_source_location_v0_t] [%iree_hal_executable_source_location_v0_t { i32 1, i32 12, ptr @4 }, %iree_hal_executable_source_location_v0_t { i32 1, i32 12, ptr @5 }, %iree_hal_executable_source_location_v0_t { i32 1, i32 12, ptr @6 }]
@iree_hal_executable_library_query_v0_conv_i8_dispatch_0_generic_32x32x3x3x8_i8_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0_conv_i8_dispatch_0_generic_32x32x3x3x8_i8_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0_conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0_conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_72x16xi8_to_72x16xi8_stage_names = private constant [0 x ptr] zeroinitializer
@iree_hal_executable_library_query_v0__encoding_0_encode_72x16xi8_to_72x16xi8_stage_source_locations = private constant [0 x %iree_hal_executable_source_location_v0_t] zeroinitializer
@iree_hal_executable_library_query_v0_stage_location_tables = private constant [3 x %iree_hal_executable_stage_location_table_v0_t] [%iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0_conv_i8_dispatch_0_generic_32x32x3x3x8_i8_stage_names, ptr @iree_hal_executable_library_query_v0_conv_i8_dispatch_0_generic_32x32x3x3x8_i8_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0_conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32_stage_names, ptr @iree_hal_executable_library_query_v0_conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32_stage_source_locations }, %iree_hal_executable_stage_location_table_v0_t { i32 0, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_72x16xi8_to_72x16xi8_stage_names, ptr @iree_hal_executable_library_query_v0__encoding_0_encode_72x16xi8_to_72x16xi8_stage_source_locations }]
@iree_hal_executable_library_query_v0 = private constant %iree_hal_executable_library_v0_t { ptr @iree_hal_executable_library_query_v0_header, %iree_hal_executable_import_table_v0_t zeroinitializer, %iree_hal_executable_export_table_v0_t { i32 3, ptr @iree_hal_executable_library_query_v0_funcs, ptr @iree_hal_executable_library_query_v0_attrs, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_names, ptr null, ptr null, ptr @iree_hal_executable_library_query_v0_source_locations, ptr @iree_hal_executable_library_query_v0_stage_location_tables }, %iree_hal_executable_constant_table_v0_t zeroinitializer, %iree_hal_executable_source_file_table_v0_t zeroinitializer }

define internal i32 @conv_i8_dispatch_0_generic_32x32x3x3x8_i8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !5 {
  %4 = alloca i8, i64 8, align 64, !dbg !81
  %5 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !81
  %6 = extractvalue %iree_hal_executable_dispatch_state_v0_t %5, 10, !dbg !81
  %7 = load ptr, ptr %6, align 8, !dbg !81
  call void @llvm.assume(i1 true) [ "align"(ptr %7, i64 64) ], !dbg !81
  %8 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !81
  %9 = extractvalue %iree_hal_executable_dispatch_state_v0_t %8, 10, !dbg !81
  %10 = getelementptr ptr, ptr %9, i32 1, !dbg !81
  %11 = load ptr, ptr %10, align 8, !dbg !81
  call void @llvm.assume(i1 true) [ "align"(ptr %11, i64 64) ], !dbg !81
  %12 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !81
  %13 = extractvalue %iree_hal_executable_workgroup_state_v0_t %12, 0, !dbg !81
  %14 = zext i32 %13 to i64, !dbg !81
  %15 = sdiv i64 %14, 2, !dbg !81
  %16 = mul i64 %15, 2, !dbg !81
  %17 = icmp ne i64 %14, %16, !dbg !81
  %18 = icmp slt i64 %14, 0, !dbg !81
  %19 = and i1 %17, %18, !dbg !81
  %20 = add i64 %15, -1, !dbg !81
  %21 = select i1 %19, i64 %20, i64 %15, !dbg !81
  %22 = srem i64 %14, 2, !dbg !81
  %23 = icmp slt i64 %22, 0, !dbg !81
  %24 = add nsw i64 %22, 2, !dbg !81
  %25 = select i1 %23, i64 %24, i64 %22, !dbg !81
  %26 = mul nsw i64 %21, 4, !dbg !81
  %27 = mul nsw i64 %25, 16, !dbg !81
  br label %28, !dbg !81

28:                                               ; preds = %104, %3
  %29 = phi i64 [ %105, %104 ], [ 0, %3 ], !dbg !81
  %30 = icmp slt i64 %29, 4, !dbg !81
  br i1 %30, label %31, label %106, !dbg !81

31:                                               ; preds = %102, %28
  %32 = phi i64 [ %103, %102 ], [ 0, %28 ], !dbg !81
  %33 = icmp slt i64 %32, 16, !dbg !81
  br i1 %33, label %34, label %104, !dbg !81

34:                                               ; preds = %100, %31
  %35 = phi i64 [ %101, %100 ], [ 0, %31 ], !dbg !81
  %36 = icmp slt i64 %35, 3, !dbg !81
  br i1 %36, label %37, label %102, !dbg !81

37:                                               ; preds = %34
  %38 = add i64 %29, %35, !dbg !81
  %39 = add i64 %38, %26, !dbg !81
  br label %40, !dbg !81

40:                                               ; preds = %98, %37
  %41 = phi i64 [ %99, %98 ], [ 0, %37 ], !dbg !81
  %42 = icmp slt i64 %41, 3, !dbg !81
  br i1 %42, label %43, label %100, !dbg !81

43:                                               ; preds = %40
  %44 = add i64 %32, %41, !dbg !81
  %45 = add i64 %44, %27, !dbg !81
  br label %46, !dbg !81

46:                                               ; preds = %49, %43
  %47 = phi i64 [ %58, %49 ], [ 0, %43 ], !dbg !81
  %48 = icmp slt i64 %47, 8, !dbg !81
  br i1 %48, label %49, label %59, !dbg !81

49:                                               ; preds = %46
  %50 = mul nuw nsw i64 %39, 272, !dbg !81
  %51 = mul nuw nsw i64 %45, 8, !dbg !81
  %52 = add nuw nsw i64 %50, %51, !dbg !81
  %53 = add nuw nsw i64 %52, %47, !dbg !81
  %54 = getelementptr inbounds nuw i8, ptr %7, i64 %53, !dbg !81
  %55 = load i8, ptr %54, align 1, !dbg !81
  %56 = add nuw nsw i64 0, %47, !dbg !81
  %57 = getelementptr inbounds nuw i8, ptr %4, i64 %56, !dbg !81
  store i8 %55, ptr %57, align 1, !dbg !81
  %58 = add i64 %47, 1, !dbg !81
  br label %46, !dbg !81

59:                                               ; preds = %62, %46
  %60 = phi i64 [ %97, %62 ], [ 0, %46 ], !dbg !81
  %61 = icmp slt i64 %60, 8, !dbg !81
  br i1 %61, label %62, label %98, !dbg !81

62:                                               ; preds = %59
  %63 = add i64 %26, %29, !dbg !81
  %64 = add i64 %27, %32, !dbg !81
  %65 = mul nsw i64 %63, 288, !dbg !81
  %66 = mul nsw i64 %64, 9, !dbg !81
  %67 = mul nsw i64 %35, 3, !dbg !81
  %68 = add nsw i64 %65, %66, !dbg !81
  %69 = add nsw i64 %68, %67, !dbg !81
  %70 = add nsw i64 %69, %41, !dbg !81
  %71 = sdiv i64 %70, 36, !dbg !81
  %72 = mul i64 %71, 36, !dbg !81
  %73 = icmp ne i64 %70, %72, !dbg !81
  %74 = icmp slt i64 %70, 0, !dbg !81
  %75 = and i1 %73, %74, !dbg !81
  %76 = add i64 %71, -1, !dbg !81
  %77 = select i1 %75, i64 %76, i64 %71, !dbg !81
  %78 = srem i64 %70, 36, !dbg !81
  %79 = icmp slt i64 %78, 0, !dbg !81
  %80 = add nsw i64 %78, 36, !dbg !81
  %81 = select i1 %79, i64 %80, i64 %78, !dbg !81
  %82 = sdiv i64 %81, 9, !dbg !81
  %83 = srem i64 %70, 9, !dbg !81
  %84 = icmp slt i64 %83, 0, !dbg !81
  %85 = add nsw i64 %83, 9, !dbg !81
  %86 = select i1 %84, i64 %85, i64 %83, !dbg !81
  %87 = add nuw nsw i64 0, %60, !dbg !81
  %88 = getelementptr inbounds nuw i8, ptr %4, i64 %87, !dbg !81
  %89 = load i8, ptr %88, align 1, !dbg !81
  %90 = mul nuw nsw i64 %77, 288, !dbg !81
  %91 = mul nuw nsw i64 %86, 32, !dbg !81
  %92 = add nuw nsw i64 %90, %91, !dbg !81
  %93 = mul nuw nsw i64 %82, 8, !dbg !81
  %94 = add nuw nsw i64 %92, %93, !dbg !81
  %95 = add nuw nsw i64 %94, %60, !dbg !81
  %96 = getelementptr inbounds nuw i8, ptr %11, i64 %95, !dbg !81
  store i8 %89, ptr %96, align 1, !dbg !81
  %97 = add i64 %60, 1, !dbg !81
  br label %59, !dbg !81

98:                                               ; preds = %59
  %99 = add i64 %41, 1, !dbg !81
  br label %40, !dbg !81

100:                                              ; preds = %40
  %101 = add i64 %35, 1, !dbg !81
  br label %34, !dbg !81

102:                                              ; preds = %34
  %103 = add i64 %32, 1, !dbg !81
  br label %31, !dbg !81

104:                                              ; preds = %31
  %105 = add i64 %29, 1, !dbg !81
  br label %28, !dbg !81

106:                                              ; preds = %28
  ret i32 0, !dbg !81
}

define internal i32 @conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !82 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !83
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !83
  %6 = load ptr, ptr %5, align 8, !dbg !83
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !83
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !83
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !83
  %9 = load ptr, ptr %8, align 8, !dbg !83
  %10 = getelementptr i8, ptr %9, i64 73728, !dbg !83
  call void @llvm.assume(i1 true) [ "align"(ptr %10, i64 64) ], !dbg !83
  %11 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !83
  %12 = extractvalue %iree_hal_executable_dispatch_state_v0_t %11, 10, !dbg !83
  %13 = getelementptr ptr, ptr %12, i32 1, !dbg !83
  %14 = load ptr, ptr %13, align 8, !dbg !83
  call void @llvm.assume(i1 true) [ "align"(ptr %14, i64 64) ], !dbg !83
  %15 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !83
  %16 = extractvalue %iree_hal_executable_workgroup_state_v0_t %15, 0, !dbg !83
  %17 = zext i32 %16 to i64, !dbg !83
  %18 = sdiv i64 %17, 4, !dbg !83
  %19 = mul i64 %18, 4, !dbg !83
  %20 = icmp ne i64 %17, %19, !dbg !83
  %21 = icmp slt i64 %17, 0, !dbg !83
  %22 = and i1 %20, %21, !dbg !83
  %23 = add i64 %18, -1, !dbg !83
  %24 = select i1 %22, i64 %23, i64 %18, !dbg !83
  %25 = srem i64 %17, 4, !dbg !83
  %26 = icmp slt i64 %25, 0, !dbg !83
  %27 = add nsw i64 %25, 4, !dbg !83
  %28 = select i1 %26, i64 %27, i64 %25, !dbg !83
  %29 = mul nsw i64 %28, 64, !dbg !83
  %30 = mul nsw i64 %28, 256, !dbg !83
  %31 = mul nsw i64 %24, 4, !dbg !83
  br label %32, !dbg !83

32:                                               ; preds = %121, %3
  %33 = phi i64 [ %159, %121 ], [ 0, %3 ], !dbg !83
  %34 = icmp slt i64 %33, 64, !dbg !83
  br i1 %34, label %35, label %160, !dbg !83

35:                                               ; preds = %32
  %36 = add i64 %33, %29, !dbg !83
  br label %37, !dbg !83

37:                                               ; preds = %41, %35
  %38 = phi i64 [ %120, %41 ], [ 0, %35 ], !dbg !83
  %39 = phi [4 x <4 x i32>] [ %119, %41 ], [ zeroinitializer, %35 ], !dbg !83
  %40 = icmp slt i64 %38, 9, !dbg !83
  br i1 %40, label %41, label %121, !dbg !83

41:                                               ; preds = %37
  %42 = mul i64 %24, 288, !dbg !83
  %43 = mul i64 %38, 32, !dbg !83
  %44 = add i64 %42, %43, !dbg !83
  %45 = add i64 %44, 0, !dbg !83
  %46 = add i64 %45, 0, !dbg !83
  %47 = getelementptr i8, ptr %10, i64 %46, !dbg !83
  %48 = load <8 x i8>, ptr %47, align 1, !dbg !83
  %49 = add i64 %44, 8, !dbg !83
  %50 = add i64 %49, 0, !dbg !83
  %51 = getelementptr i8, ptr %10, i64 %50, !dbg !83
  %52 = load <8 x i8>, ptr %51, align 1, !dbg !83
  %53 = add i64 %44, 16, !dbg !83
  %54 = add i64 %53, 0, !dbg !83
  %55 = getelementptr i8, ptr %10, i64 %54, !dbg !83
  %56 = load <8 x i8>, ptr %55, align 1, !dbg !83
  %57 = add i64 %44, 24, !dbg !83
  %58 = add i64 %57, 0, !dbg !83
  %59 = getelementptr i8, ptr %10, i64 %58, !dbg !83
  %60 = load <8 x i8>, ptr %59, align 1, !dbg !83
  %61 = mul i64 %36, 288, !dbg !83
  %62 = add i64 %61, %43, !dbg !83
  %63 = add i64 %62, 0, !dbg !83
  %64 = add i64 %63, 0, !dbg !83
  %65 = getelementptr i8, ptr %6, i64 %64, !dbg !83
  %66 = load <8 x i8>, ptr %65, align 1, !dbg !83
  %67 = add i64 %62, 8, !dbg !83
  %68 = add i64 %67, 0, !dbg !83
  %69 = getelementptr i8, ptr %6, i64 %68, !dbg !83
  %70 = load <8 x i8>, ptr %69, align 1, !dbg !83
  %71 = add i64 %62, 16, !dbg !83
  %72 = add i64 %71, 0, !dbg !83
  %73 = getelementptr i8, ptr %6, i64 %72, !dbg !83
  %74 = load <8 x i8>, ptr %73, align 1, !dbg !83
  %75 = add i64 %62, 24, !dbg !83
  %76 = add i64 %75, 0, !dbg !83
  %77 = getelementptr i8, ptr %6, i64 %76, !dbg !83
  %78 = load <8 x i8>, ptr %77, align 1, !dbg !83
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
  %120 = add i64 %38, 1, !dbg !83
  br label %37, !dbg !83

121:                                              ; preds = %37
  %122 = extractvalue [4 x <4 x i32>] %39, 0, !dbg !83
  %123 = shufflevector <4 x i32> %122, <4 x i32> %122, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !83
  %124 = shufflevector <16 x i32> %123, <16 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>, !dbg !83
  %125 = extractvalue [4 x <4 x i32>] %39, 1, !dbg !83
  %126 = shufflevector <4 x i32> %125, <4 x i32> %125, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !83
  %127 = shufflevector <16 x i32> %126, <16 x i32> %124, <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 0, i32 1, i32 2, i32 3, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>, !dbg !83
  %128 = extractvalue [4 x <4 x i32>] %39, 2, !dbg !83
  %129 = shufflevector <4 x i32> %128, <4 x i32> %128, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !83
  %130 = shufflevector <16 x i32> %129, <16 x i32> %127, <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 0, i32 1, i32 2, i32 3, i32 28, i32 29, i32 30, i32 31>, !dbg !83
  %131 = extractvalue [4 x <4 x i32>] %39, 3, !dbg !83
  %132 = shufflevector <4 x i32> %131, <4 x i32> %131, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !83
  %133 = shufflevector <16 x i32> %132, <16 x i32> %130, <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 0, i32 1, i32 2, i32 3>, !dbg !83
  %134 = shufflevector <16 x i32> %133, <16 x i32> %133, <16 x i32> <i32 0, i32 4, i32 8, i32 12, i32 1, i32 5, i32 9, i32 13, i32 2, i32 6, i32 10, i32 14, i32 3, i32 7, i32 11, i32 15>, !dbg !83
  %135 = shufflevector <16 x i32> %134, <16 x i32> %134, <4 x i32> <i32 0, i32 1, i32 2, i32 3>, !dbg !83
  %136 = shufflevector <16 x i32> %134, <16 x i32> %134, <4 x i32> <i32 4, i32 5, i32 6, i32 7>, !dbg !83
  %137 = shufflevector <16 x i32> %134, <16 x i32> %134, <4 x i32> <i32 8, i32 9, i32 10, i32 11>, !dbg !83
  %138 = shufflevector <16 x i32> %134, <16 x i32> %134, <4 x i32> <i32 12, i32 13, i32 14, i32 15>, !dbg !83
  %139 = mul nsw i64 %33, 4, !dbg !83
  %140 = add i64 %30, %139, !dbg !83
  %141 = mul i64 %140, 16, !dbg !83
  %142 = add i64 %141, %31, !dbg !83
  %143 = getelementptr i32, ptr %14, i64 %142, !dbg !83
  store <4 x i32> %135, ptr %143, align 4, !dbg !83
  %144 = add i64 %139, 1, !dbg !83
  %145 = add i64 %30, %144, !dbg !83
  %146 = mul i64 %145, 16, !dbg !83
  %147 = add i64 %146, %31, !dbg !83
  %148 = getelementptr i32, ptr %14, i64 %147, !dbg !83
  store <4 x i32> %136, ptr %148, align 4, !dbg !83
  %149 = add i64 %139, 2, !dbg !83
  %150 = add i64 %30, %149, !dbg !83
  %151 = mul i64 %150, 16, !dbg !83
  %152 = add i64 %151, %31, !dbg !83
  %153 = getelementptr i32, ptr %14, i64 %152, !dbg !83
  store <4 x i32> %137, ptr %153, align 4, !dbg !83
  %154 = add i64 %139, 3, !dbg !83
  %155 = add i64 %30, %154, !dbg !83
  %156 = mul i64 %155, 16, !dbg !83
  %157 = add i64 %156, %31, !dbg !83
  %158 = getelementptr i32, ptr %14, i64 %157, !dbg !83
  store <4 x i32> %138, ptr %158, align 4, !dbg !83
  %159 = add i64 %33, 1, !dbg !83
  br label %32, !dbg !83

160:                                              ; preds = %32
  ret i32 0, !dbg !83
}

define internal i32 @_encoding_0_encode_72x16xi8_to_72x16xi8(ptr noalias noundef nonnull align 16 %0, ptr noalias noundef nonnull align 16 %1, ptr noalias noundef nonnull align 16 %2) #0 !dbg !84 {
  %4 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !85
  %5 = extractvalue %iree_hal_executable_dispatch_state_v0_t %4, 10, !dbg !85
  %6 = load ptr, ptr %5, align 8, !dbg !85
  call void @llvm.assume(i1 true) [ "align"(ptr %6, i64 64) ], !dbg !85
  %7 = load %iree_hal_executable_dispatch_state_v0_t, ptr %1, align 8, !dbg !85
  %8 = extractvalue %iree_hal_executable_dispatch_state_v0_t %7, 10, !dbg !85
  %9 = getelementptr ptr, ptr %8, i32 1, !dbg !85
  %10 = load ptr, ptr %9, align 8, !dbg !85
  %11 = getelementptr i8, ptr %10, i64 73728, !dbg !85
  call void @llvm.assume(i1 true) [ "align"(ptr %11, i64 64) ], !dbg !85
  %12 = load %iree_hal_executable_workgroup_state_v0_t, ptr %2, align 8, !dbg !85
  %13 = extractvalue %iree_hal_executable_workgroup_state_v0_t %12, 0, !dbg !85
  %14 = zext i32 %13 to i64, !dbg !85
  %15 = sdiv i64 %14, 9, !dbg !85
  %16 = mul i64 %15, 9, !dbg !85
  %17 = icmp ne i64 %14, %16, !dbg !85
  %18 = icmp slt i64 %14, 0, !dbg !85
  %19 = and i1 %17, %18, !dbg !85
  %20 = add i64 %15, -1, !dbg !85
  %21 = select i1 %19, i64 %20, i64 %15, !dbg !85
  %22 = srem i64 %14, 9, !dbg !85
  %23 = icmp slt i64 %22, 0, !dbg !85
  %24 = add nsw i64 %22, 9, !dbg !85
  %25 = select i1 %23, i64 %24, i64 %22, !dbg !85
  %26 = mul nsw i64 %21, 4, !dbg !85
  %27 = mul nsw i64 %25, 8, !dbg !85
  %28 = mul i64 %27, 16, !dbg !85
  %29 = add i64 %28, %26, !dbg !85
  %30 = getelementptr i8, ptr %6, i64 %29, !dbg !85
  %31 = load <4 x i8>, ptr %30, align 1, !dbg !85
  %32 = add i64 %27, 1, !dbg !85
  %33 = mul i64 %32, 16, !dbg !85
  %34 = add i64 %33, %26, !dbg !85
  %35 = getelementptr i8, ptr %6, i64 %34, !dbg !85
  %36 = load <4 x i8>, ptr %35, align 1, !dbg !85
  %37 = add i64 %27, 2, !dbg !85
  %38 = mul i64 %37, 16, !dbg !85
  %39 = add i64 %38, %26, !dbg !85
  %40 = getelementptr i8, ptr %6, i64 %39, !dbg !85
  %41 = load <4 x i8>, ptr %40, align 1, !dbg !85
  %42 = add i64 %27, 3, !dbg !85
  %43 = mul i64 %42, 16, !dbg !85
  %44 = add i64 %43, %26, !dbg !85
  %45 = getelementptr i8, ptr %6, i64 %44, !dbg !85
  %46 = load <4 x i8>, ptr %45, align 1, !dbg !85
  %47 = add i64 %27, 4, !dbg !85
  %48 = mul i64 %47, 16, !dbg !85
  %49 = add i64 %48, %26, !dbg !85
  %50 = getelementptr i8, ptr %6, i64 %49, !dbg !85
  %51 = load <4 x i8>, ptr %50, align 1, !dbg !85
  %52 = add i64 %27, 5, !dbg !85
  %53 = mul i64 %52, 16, !dbg !85
  %54 = add i64 %53, %26, !dbg !85
  %55 = getelementptr i8, ptr %6, i64 %54, !dbg !85
  %56 = load <4 x i8>, ptr %55, align 1, !dbg !85
  %57 = add i64 %27, 6, !dbg !85
  %58 = mul i64 %57, 16, !dbg !85
  %59 = add i64 %58, %26, !dbg !85
  %60 = getelementptr i8, ptr %6, i64 %59, !dbg !85
  %61 = load <4 x i8>, ptr %60, align 1, !dbg !85
  %62 = add i64 %27, 7, !dbg !85
  %63 = mul i64 %62, 16, !dbg !85
  %64 = add i64 %63, %26, !dbg !85
  %65 = getelementptr i8, ptr %6, i64 %64, !dbg !85
  %66 = load <4 x i8>, ptr %65, align 1, !dbg !85
  %67 = shufflevector <4 x i8> %31, <4 x i8> %31, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %68 = shufflevector <32 x i8> %67, <32 x i8> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %69 = shufflevector <4 x i8> %36, <4 x i8> %36, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %70 = shufflevector <32 x i8> %69, <32 x i8> %68, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 0, i32 1, i32 2, i32 3, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %71 = shufflevector <4 x i8> %41, <4 x i8> %41, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %72 = shufflevector <32 x i8> %71, <32 x i8> %70, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 0, i32 1, i32 2, i32 3, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %73 = shufflevector <4 x i8> %46, <4 x i8> %46, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %74 = shufflevector <32 x i8> %73, <32 x i8> %72, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 0, i32 1, i32 2, i32 3, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %75 = shufflevector <4 x i8> %51, <4 x i8> %51, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %76 = shufflevector <32 x i8> %75, <32 x i8> %74, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 0, i32 1, i32 2, i32 3, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %77 = shufflevector <4 x i8> %56, <4 x i8> %56, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %78 = shufflevector <32 x i8> %77, <32 x i8> %76, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 0, i32 1, i32 2, i32 3, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %79 = shufflevector <4 x i8> %61, <4 x i8> %61, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %80 = shufflevector <32 x i8> %79, <32 x i8> %78, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 0, i32 1, i32 2, i32 3, i32 60, i32 61, i32 62, i32 63>, !dbg !85
  %81 = shufflevector <4 x i8> %66, <4 x i8> %66, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, !dbg !85
  %82 = shufflevector <32 x i8> %81, <32 x i8> %80, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 0, i32 1, i32 2, i32 3>, !dbg !85
  %83 = shufflevector <32 x i8> %82, <32 x i8> %82, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29, i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30, i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>, !dbg !85
  %84 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, !dbg !85
  %85 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>, !dbg !85
  %86 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>, !dbg !85
  %87 = shufflevector <32 x i8> %83, <32 x i8> %83, <8 x i32> <i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>, !dbg !85
  %88 = mul i64 %21, 288, !dbg !85
  %89 = mul i64 %25, 32, !dbg !85
  %90 = add i64 %88, %89, !dbg !85
  %91 = add i64 %90, 0, !dbg !85
  %92 = add i64 %91, 0, !dbg !85
  %93 = getelementptr i8, ptr %11, i64 %92, !dbg !85
  store <8 x i8> %84, ptr %93, align 1, !dbg !85
  %94 = add i64 %90, 8, !dbg !85
  %95 = add i64 %94, 0, !dbg !85
  %96 = getelementptr i8, ptr %11, i64 %95, !dbg !85
  store <8 x i8> %85, ptr %96, align 1, !dbg !85
  %97 = add i64 %90, 16, !dbg !85
  %98 = add i64 %97, 0, !dbg !85
  %99 = getelementptr i8, ptr %11, i64 %98, !dbg !85
  store <8 x i8> %86, ptr %99, align 1, !dbg !85
  %100 = add i64 %90, 24, !dbg !85
  %101 = add i64 %100, 0, !dbg !85
  %102 = getelementptr i8, ptr %11, i64 %101, !dbg !85
  store <8 x i8> %87, ptr %102, align 1, !dbg !85
  ret i32 0, !dbg !85
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

!llvm.dbg.cu = !{!0, !2, !3}
!llvm.module.flags = !{!4}

!0 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "-", directory: "")
!2 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!3 = distinct !DICompileUnit(language: DW_LANG_C17, file: !1, producer: "IREE", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = distinct !DISubprogram(name: "conv_i8_dispatch_0_generic_32x32x3x3x8_i8", linkageName: "conv_i8_dispatch_0_generic_32x32x3x3x8_i8", scope: !1, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
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
!82 = distinct !DISubprogram(name: "conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32", linkageName: "conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32", scope: !1, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2)
!83 = !DILocation(line: 1, column: 1, scope: !82)
!84 = distinct !DISubprogram(name: "_encoding_0_encode_72x16xi8_to_72x16xi8", linkageName: "_encoding_0_encode_72x16xi8_to_72x16xi8", scope: !1, file: !1, line: 1, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !3)
!85 = !DILocation(line: 1, column: 1, scope: !84)
