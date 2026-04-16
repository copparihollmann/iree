#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @conv_i8_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @conv_i8_dispatch_0_generic_32x32x3x3x8_i8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c16 = arith.constant 16 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c16, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @conv_i8_dispatch_0_generic_32x32x3x3x8_i8(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(32 : index) : i64
          %2 = llvm.mlir.constant(64 : index) : i64
          %3 = llvm.mlir.constant(true) : i1
          %4 = llvm.mlir.constant(272 : index) : i64
          %5 = llvm.mlir.constant(-1 : index) : i64
          %6 = llvm.mlir.constant(8 : index) : i64
          %7 = llvm.mlir.constant(36 : index) : i64
          %8 = llvm.mlir.constant(288 : index) : i64
          %9 = llvm.mlir.constant(9 : index) : i64
          %10 = llvm.mlir.constant(2 : index) : i64
          %11 = llvm.mlir.constant(0 : index) : i64
          %12 = llvm.mlir.constant(4 : index) : i64
          %13 = llvm.mlir.constant(16 : index) : i64
          %14 = llvm.mlir.constant(3 : index) : i64
          %15 = llvm.mlir.constant(1 : index) : i64
          %16 = llvm.alloca %6 x i8 {alignment = 64 : i64} : (i64) -> !llvm.ptr
          %17 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %18 = llvm.extractvalue %17[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %19 = llvm.load %18 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%19, %2 : !llvm.ptr, i64)] : i1
          %20 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %21 = llvm.extractvalue %20[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %22 = llvm.getelementptr %21[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %23 = llvm.load %22 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%23, %2 : !llvm.ptr, i64)] : i1
          %24 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %25 = llvm.extractvalue %24[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %26 = llvm.zext %25 : i32 to i64
          %27 = llvm.sdiv %26, %10 : i64
          %28 = llvm.mul %27, %10 : i64
          %29 = llvm.icmp "ne" %26, %28 : i64
          %30 = llvm.icmp "slt" %26, %11 : i64
          %31 = llvm.and %29, %30 : i1
          %32 = llvm.add %27, %5 : i64
          %33 = llvm.select %31, %32, %27 : i1, i64
          %34 = llvm.srem %26, %10 : i64
          %35 = llvm.icmp "slt" %34, %11 : i64
          %36 = llvm.add %34, %10 overflow<nsw> : i64
          %37 = llvm.select %35, %36, %34 : i1, i64
          %38 = llvm.mul %33, %12 overflow<nsw> : i64
          %39 = llvm.mul %37, %13 overflow<nsw> : i64
          llvm.br ^bb1(%11 : i64)
        ^bb1(%40: i64):  // 2 preds: ^bb0, ^bb14
          %41 = llvm.icmp "slt" %40, %12 : i64
          llvm.cond_br %41, ^bb2(%11 : i64), ^bb15
        ^bb2(%42: i64):  // 2 preds: ^bb1, ^bb13
          %43 = llvm.icmp "slt" %42, %13 : i64
          llvm.cond_br %43, ^bb3(%11 : i64), ^bb14
        ^bb3(%44: i64):  // 2 preds: ^bb2, ^bb12
          %45 = llvm.icmp "slt" %44, %14 : i64
          llvm.cond_br %45, ^bb4, ^bb13
        ^bb4:  // pred: ^bb3
          %46 = llvm.add %40, %44 : i64
          %47 = llvm.add %46, %38 : i64
          llvm.br ^bb5(%11 : i64)
        ^bb5(%48: i64):  // 2 preds: ^bb4, ^bb11
          %49 = llvm.icmp "slt" %48, %14 : i64
          llvm.cond_br %49, ^bb6, ^bb12
        ^bb6:  // pred: ^bb5
          %50 = llvm.add %42, %48 : i64
          %51 = llvm.add %50, %39 : i64
          llvm.br ^bb7(%11 : i64)
        ^bb7(%52: i64):  // 2 preds: ^bb6, ^bb8
          %53 = llvm.icmp "slt" %52, %6 : i64
          llvm.cond_br %53, ^bb8, ^bb9(%11 : i64)
        ^bb8:  // pred: ^bb7
          %54 = llvm.mul %47, %4 overflow<nsw, nuw> : i64
          %55 = llvm.mul %51, %6 overflow<nsw, nuw> : i64
          %56 = llvm.add %54, %55 overflow<nsw, nuw> : i64
          %57 = llvm.add %56, %52 overflow<nsw, nuw> : i64
          %58 = llvm.getelementptr inbounds|nuw %19[%57] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %59 = llvm.load %58 : !llvm.ptr -> i8
          %60 = llvm.mul %11, %6 overflow<nsw, nuw> : i64
          %61 = llvm.add %60, %60 overflow<nsw, nuw> : i64
          %62 = llvm.add %61, %60 overflow<nsw, nuw> : i64
          %63 = llvm.add %62, %60 overflow<nsw, nuw> : i64
          %64 = llvm.add %63, %52 overflow<nsw, nuw> : i64
          %65 = llvm.getelementptr inbounds|nuw %16[%64] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %59, %65 : i8, !llvm.ptr
          %66 = llvm.add %52, %15 : i64
          llvm.br ^bb7(%66 : i64)
        ^bb9(%67: i64):  // 2 preds: ^bb7, ^bb10
          %68 = llvm.icmp "slt" %67, %6 : i64
          llvm.cond_br %68, ^bb10, ^bb11
        ^bb10:  // pred: ^bb9
          %69 = llvm.add %38, %40 : i64
          %70 = llvm.add %39, %42 : i64
          %71 = llvm.mul %69, %8 overflow<nsw> : i64
          %72 = llvm.mul %70, %9 overflow<nsw> : i64
          %73 = llvm.mul %44, %14 overflow<nsw> : i64
          %74 = llvm.add %71, %72 overflow<nsw> : i64
          %75 = llvm.add %74, %73 overflow<nsw> : i64
          %76 = llvm.add %75, %48 overflow<nsw> : i64
          %77 = llvm.sdiv %76, %7 : i64
          %78 = llvm.mul %77, %7 : i64
          %79 = llvm.icmp "ne" %76, %78 : i64
          %80 = llvm.icmp "slt" %76, %11 : i64
          %81 = llvm.and %79, %80 : i1
          %82 = llvm.add %77, %5 : i64
          %83 = llvm.select %81, %82, %77 : i1, i64
          %84 = llvm.srem %76, %7 : i64
          %85 = llvm.icmp "slt" %84, %11 : i64
          %86 = llvm.add %84, %7 overflow<nsw> : i64
          %87 = llvm.select %85, %86, %84 : i1, i64
          %88 = llvm.sdiv %87, %9 : i64
          %89 = llvm.srem %76, %9 : i64
          %90 = llvm.icmp "slt" %89, %11 : i64
          %91 = llvm.add %89, %9 overflow<nsw> : i64
          %92 = llvm.select %90, %91, %89 : i1, i64
          %93 = llvm.mul %11, %6 overflow<nsw, nuw> : i64
          %94 = llvm.add %93, %93 overflow<nsw, nuw> : i64
          %95 = llvm.add %94, %93 overflow<nsw, nuw> : i64
          %96 = llvm.add %95, %93 overflow<nsw, nuw> : i64
          %97 = llvm.add %96, %67 overflow<nsw, nuw> : i64
          %98 = llvm.getelementptr inbounds|nuw %16[%97] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %99 = llvm.load %98 : !llvm.ptr -> i8
          %100 = llvm.mul %83, %8 overflow<nsw, nuw> : i64
          %101 = llvm.mul %92, %1 overflow<nsw, nuw> : i64
          %102 = llvm.add %100, %101 overflow<nsw, nuw> : i64
          %103 = llvm.mul %88, %6 overflow<nsw, nuw> : i64
          %104 = llvm.add %102, %103 overflow<nsw, nuw> : i64
          %105 = llvm.add %104, %67 overflow<nsw, nuw> : i64
          %106 = llvm.getelementptr inbounds|nuw %23[%105] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %99, %106 : i8, !llvm.ptr
          %107 = llvm.add %67, %15 : i64
          llvm.br ^bb9(%107 : i64)
        ^bb11:  // pred: ^bb9
          %108 = llvm.add %48, %15 : i64
          llvm.br ^bb5(%108 : i64)
        ^bb12:  // pred: ^bb5
          %109 = llvm.add %44, %15 : i64
          llvm.br ^bb3(%109 : i64)
        ^bb13:  // pred: ^bb3
          %110 = llvm.add %42, %15 : i64
          llvm.br ^bb2(%110 : i64)
        ^bb14:  // pred: ^bb2
          %111 = llvm.add %40, %15 : i64
          llvm.br ^bb1(%111 : i64)
        ^bb15:  // pred: ^bb1
          llvm.return %0 : i32
        }
      }
    }
  }
  hal.executable private @conv_i8_dispatch_1 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c16 = arith.constant 16 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c16, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(16 : index) : i64
          %2 = llvm.mlir.constant(8 : i64) : i64
          %3 = llvm.mlir.constant(true) : i1
          %4 = llvm.mlir.constant(8 : index) : i64
          %5 = llvm.mlir.constant(32 : index) : i64
          %6 = llvm.mlir.constant(288 : index) : i64
          %7 = llvm.mlir.poison : !llvm.array<4 x vector<4xi32>>
          %8 = llvm.mlir.constant(-1 : index) : i64
          %9 = llvm.mlir.constant(256 : index) : i64
          %10 = llvm.mlir.constant(4 : index) : i64
          %11 = llvm.mlir.poison : vector<16xi32>
          %12 = llvm.mlir.poison : vector<32xi8>
          %13 = llvm.mlir.constant(3 : index) : i64
          %14 = llvm.mlir.constant(2 : index) : i64
          %15 = llvm.mlir.constant(dense<0> : vector<4x4xi32>) : !llvm.array<4 x vector<4xi32>>
          %16 = llvm.mlir.constant(16 : i64) : i64
          %17 = llvm.mlir.undef : vector<[4]xi32>
          %18 = llvm.mlir.constant(0 : i64) : i64
          %19 = llvm.mlir.undef : vector<[8]xi8>
          %20 = llvm.mlir.constant(64 : index) : i64
          %21 = llvm.mlir.constant(1 : index) : i64
          %22 = llvm.mlir.constant(9 : index) : i64
          %23 = llvm.mlir.constant(0 : index) : i64
          %24 = llvm.mlir.constant(73728 : index) : i64
          %25 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %26 = llvm.extractvalue %25[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %27 = llvm.load %26 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%27, %20 : !llvm.ptr, i64)] : i1
          %28 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %29 = llvm.extractvalue %28[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %30 = llvm.load %29 : !llvm.ptr -> !llvm.ptr
          %31 = llvm.mul %24, %2 : i64
          %32 = llvm.udiv %31, %2 : i64
          %33 = llvm.getelementptr %30[%32] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %3 ["align"(%33, %20 : !llvm.ptr, i64)] : i1
          %34 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %35 = llvm.extractvalue %34[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %36 = llvm.getelementptr %35[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %37 = llvm.load %36 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%37, %20 : !llvm.ptr, i64)] : i1
          %38 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %39 = llvm.extractvalue %38[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %40 = llvm.zext %39 : i32 to i64
          %41 = llvm.sdiv %40, %10 : i64
          %42 = llvm.mul %41, %10 : i64
          %43 = llvm.icmp "ne" %40, %42 : i64
          %44 = llvm.icmp "slt" %40, %23 : i64
          %45 = llvm.and %43, %44 : i1
          %46 = llvm.add %41, %8 : i64
          %47 = llvm.select %45, %46, %41 : i1, i64
          %48 = llvm.srem %40, %10 : i64
          %49 = llvm.icmp "slt" %48, %23 : i64
          %50 = llvm.add %48, %10 overflow<nsw> : i64
          %51 = llvm.select %49, %50, %48 : i1, i64
          %52 = llvm.mul %51, %20 overflow<nsw> : i64
          %53 = llvm.mul %51, %9 overflow<nsw> : i64
          %54 = llvm.mul %47, %10 overflow<nsw> : i64
          llvm.br ^bb1(%23 : i64)
        ^bb1(%55: i64):  // 2 preds: ^bb0, ^bb5
          %56 = llvm.icmp "slt" %55, %20 : i64
          llvm.cond_br %56, ^bb2, ^bb6
        ^bb2:  // pred: ^bb1
          %57 = llvm.add %55, %52 : i64
          llvm.br ^bb3(%23, %15 : i64, !llvm.array<4 x vector<4xi32>>)
        ^bb3(%58: i64, %59: !llvm.array<4 x vector<4xi32>>):  // 2 preds: ^bb2, ^bb4
          %60 = llvm.icmp "slt" %58, %22 : i64
          llvm.cond_br %60, ^bb4, ^bb5
        ^bb4:  // pred: ^bb3
          %61 = llvm.mul %47, %6 : i64
          %62 = llvm.mul %58, %5 : i64
          %63 = llvm.add %61, %62 : i64
          %64 = llvm.mul %23, %4 : i64
          %65 = llvm.add %63, %64 : i64
          %66 = llvm.add %65, %23 : i64
          %67 = llvm.getelementptr %33[%66] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %68 = llvm.load %67 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %69 = llvm.mul %21, %4 : i64
          %70 = llvm.add %63, %69 : i64
          %71 = llvm.add %70, %23 : i64
          %72 = llvm.getelementptr %33[%71] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %73 = llvm.load %72 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %74 = llvm.mul %14, %4 : i64
          %75 = llvm.add %63, %74 : i64
          %76 = llvm.add %75, %23 : i64
          %77 = llvm.getelementptr %33[%76] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %78 = llvm.load %77 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %79 = llvm.mul %13, %4 : i64
          %80 = llvm.add %63, %79 : i64
          %81 = llvm.add %80, %23 : i64
          %82 = llvm.getelementptr %33[%81] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %83 = llvm.load %82 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %84 = llvm.mul %57, %6 : i64
          %85 = llvm.add %84, %62 : i64
          %86 = llvm.add %85, %64 : i64
          %87 = llvm.add %86, %23 : i64
          %88 = llvm.getelementptr %27[%87] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %89 = llvm.load %88 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %90 = llvm.add %85, %69 : i64
          %91 = llvm.add %90, %23 : i64
          %92 = llvm.getelementptr %27[%91] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %93 = llvm.load %92 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %94 = llvm.add %85, %74 : i64
          %95 = llvm.add %94, %23 : i64
          %96 = llvm.getelementptr %27[%95] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %97 = llvm.load %96 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %98 = llvm.add %85, %79 : i64
          %99 = llvm.add %98, %23 : i64
          %100 = llvm.getelementptr %27[%99] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %101 = llvm.load %100 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %102 = llvm.shufflevector %68, %68 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %103 = llvm.shufflevector %102, %12 [0, 1, 2, 3, 4, 5, 6, 7, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %104 = llvm.shufflevector %73, %73 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %105 = llvm.shufflevector %104, %103 [32, 33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 4, 5, 6, 7, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %106 = llvm.shufflevector %78, %78 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %107 = llvm.shufflevector %106, %105 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 0, 1, 2, 3, 4, 5, 6, 7, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %108 = llvm.shufflevector %83, %83 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %109 = llvm.shufflevector %108, %107 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 0, 1, 2, 3, 4, 5, 6, 7] : vector<32xi8> 
          %110 = llvm.shufflevector %89, %89 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %111 = llvm.shufflevector %110, %12 [0, 1, 2, 3, 4, 5, 6, 7, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %112 = llvm.shufflevector %93, %93 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %113 = llvm.shufflevector %112, %111 [32, 33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 4, 5, 6, 7, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %114 = llvm.shufflevector %97, %97 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %115 = llvm.shufflevector %114, %113 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 0, 1, 2, 3, 4, 5, 6, 7, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %116 = llvm.shufflevector %101, %101 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %117 = llvm.shufflevector %116, %115 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 0, 1, 2, 3, 4, 5, 6, 7] : vector<32xi8> 
          %118 = llvm.extractvalue %59[0] : !llvm.array<4 x vector<4xi32>> 
          %119 = llvm.shufflevector %118, %118 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %120 = llvm.shufflevector %119, %11 [0, 1, 2, 3, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi32> 
          %121 = llvm.extractvalue %59[1] : !llvm.array<4 x vector<4xi32>> 
          %122 = llvm.shufflevector %121, %121 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %123 = llvm.shufflevector %122, %120 [16, 17, 18, 19, 0, 1, 2, 3, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi32> 
          %124 = llvm.extractvalue %59[2] : !llvm.array<4 x vector<4xi32>> 
          %125 = llvm.shufflevector %124, %124 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %126 = llvm.shufflevector %125, %123 [16, 17, 18, 19, 20, 21, 22, 23, 0, 1, 2, 3, 28, 29, 30, 31] : vector<16xi32> 
          %127 = llvm.extractvalue %59[3] : !llvm.array<4 x vector<4xi32>> 
          %128 = llvm.shufflevector %127, %127 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %129 = llvm.shufflevector %128, %126 [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 0, 1, 2, 3] : vector<16xi32> 
          %130 = llvm.call_intrinsic "llvm.vector.insert"(%19, %109, %18) : (vector<[8]xi8>, vector<32xi8>, i64) -> vector<[8]xi8>
          %131 = llvm.call_intrinsic "llvm.vector.insert"(%19, %117, %18) : (vector<[8]xi8>, vector<32xi8>, i64) -> vector<[8]xi8>
          %132 = llvm.call_intrinsic "llvm.vector.insert"(%17, %129, %18) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %133 = llvm.call_intrinsic "llvm.riscv.smt.vmadot"(%132, %130, %131, %16) : (vector<[4]xi32>, vector<[8]xi8>, vector<[8]xi8>, i64) -> vector<[4]xi32>
          %134 = llvm.call_intrinsic "llvm.vector.extract"(%133, %18) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %135 = llvm.shufflevector %134, %134 [0, 1, 2, 3] : vector<16xi32> 
          %136 = llvm.shufflevector %134, %134 [4, 5, 6, 7] : vector<16xi32> 
          %137 = llvm.shufflevector %134, %134 [8, 9, 10, 11] : vector<16xi32> 
          %138 = llvm.shufflevector %134, %134 [12, 13, 14, 15] : vector<16xi32> 
          %139 = llvm.insertvalue %135, %7[0] : !llvm.array<4 x vector<4xi32>> 
          %140 = llvm.insertvalue %136, %139[1] : !llvm.array<4 x vector<4xi32>> 
          %141 = llvm.insertvalue %137, %140[2] : !llvm.array<4 x vector<4xi32>> 
          %142 = llvm.insertvalue %138, %141[3] : !llvm.array<4 x vector<4xi32>> 
          %143 = llvm.add %58, %21 : i64
          llvm.br ^bb3(%143, %142 : i64, !llvm.array<4 x vector<4xi32>>)
        ^bb5:  // pred: ^bb3
          %144 = llvm.extractvalue %59[0] : !llvm.array<4 x vector<4xi32>> 
          %145 = llvm.shufflevector %144, %144 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %146 = llvm.shufflevector %145, %11 [0, 1, 2, 3, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi32> 
          %147 = llvm.extractvalue %59[1] : !llvm.array<4 x vector<4xi32>> 
          %148 = llvm.shufflevector %147, %147 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %149 = llvm.shufflevector %148, %146 [16, 17, 18, 19, 0, 1, 2, 3, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi32> 
          %150 = llvm.extractvalue %59[2] : !llvm.array<4 x vector<4xi32>> 
          %151 = llvm.shufflevector %150, %150 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %152 = llvm.shufflevector %151, %149 [16, 17, 18, 19, 20, 21, 22, 23, 0, 1, 2, 3, 28, 29, 30, 31] : vector<16xi32> 
          %153 = llvm.extractvalue %59[3] : !llvm.array<4 x vector<4xi32>> 
          %154 = llvm.shufflevector %153, %153 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %155 = llvm.shufflevector %154, %152 [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 0, 1, 2, 3] : vector<16xi32> 
          %156 = llvm.shufflevector %155, %155 [0, 4, 8, 12, 1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15] : vector<16xi32> 
          %157 = llvm.shufflevector %156, %156 [0, 1, 2, 3] : vector<16xi32> 
          %158 = llvm.shufflevector %156, %156 [4, 5, 6, 7] : vector<16xi32> 
          %159 = llvm.shufflevector %156, %156 [8, 9, 10, 11] : vector<16xi32> 
          %160 = llvm.shufflevector %156, %156 [12, 13, 14, 15] : vector<16xi32> 
          %161 = llvm.mul %55, %10 overflow<nsw> : i64
          %162 = llvm.add %53, %161 : i64
          %163 = llvm.mul %162, %1 : i64
          %164 = llvm.add %163, %54 : i64
          %165 = llvm.getelementptr %37[%164] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %157, %165 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %166 = llvm.add %161, %21 : i64
          %167 = llvm.add %53, %166 : i64
          %168 = llvm.mul %167, %1 : i64
          %169 = llvm.add %168, %54 : i64
          %170 = llvm.getelementptr %37[%169] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %158, %170 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %171 = llvm.add %161, %14 : i64
          %172 = llvm.add %53, %171 : i64
          %173 = llvm.mul %172, %1 : i64
          %174 = llvm.add %173, %54 : i64
          %175 = llvm.getelementptr %37[%174] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %159, %175 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %176 = llvm.add %161, %13 : i64
          %177 = llvm.add %53, %176 : i64
          %178 = llvm.mul %177, %1 : i64
          %179 = llvm.add %178, %54 : i64
          %180 = llvm.getelementptr %37[%179] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %160, %180 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %181 = llvm.add %55, %21 : i64
          llvm.br ^bb1(%181 : i64)
        ^bb6:  // pred: ^bb1
          llvm.return %0 : i32
        }
      }
    }
  }
  hal.executable private @_encoding_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_0_encode_72x16xi8_to_72x16xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c36 = arith.constant 36 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c36, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @_encoding_0_encode_72x16xi8_to_72x16xi8(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(288 : index) : i64
          %2 = llvm.mlir.constant(32 : index) : i64
          %3 = llvm.mlir.constant(8 : i64) : i64
          %4 = llvm.mlir.constant(64 : index) : i64
          %5 = llvm.mlir.constant(true) : i1
          %6 = llvm.mlir.constant(16 : index) : i64
          %7 = llvm.mlir.constant(-1 : index) : i64
          %8 = llvm.mlir.constant(7 : index) : i64
          %9 = llvm.mlir.constant(6 : index) : i64
          %10 = llvm.mlir.constant(5 : index) : i64
          %11 = llvm.mlir.constant(8 : index) : i64
          %12 = llvm.mlir.constant(4 : index) : i64
          %13 = llvm.mlir.constant(9 : index) : i64
          %14 = llvm.mlir.poison : vector<32xi8>
          %15 = llvm.mlir.constant(3 : index) : i64
          %16 = llvm.mlir.constant(2 : index) : i64
          %17 = llvm.mlir.constant(1 : index) : i64
          %18 = llvm.mlir.constant(0 : index) : i64
          %19 = llvm.mlir.constant(73728 : index) : i64
          %20 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %21 = llvm.extractvalue %20[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %22 = llvm.load %21 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %5 ["align"(%22, %4 : !llvm.ptr, i64)] : i1
          %23 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %24 = llvm.extractvalue %23[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %25 = llvm.getelementptr %24[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %26 = llvm.load %25 : !llvm.ptr -> !llvm.ptr
          %27 = llvm.mul %19, %3 : i64
          %28 = llvm.udiv %27, %3 : i64
          %29 = llvm.getelementptr %26[%28] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %5 ["align"(%29, %4 : !llvm.ptr, i64)] : i1
          %30 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %31 = llvm.extractvalue %30[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %32 = llvm.zext %31 : i32 to i64
          %33 = llvm.sdiv %32, %13 : i64
          %34 = llvm.mul %33, %13 : i64
          %35 = llvm.icmp "ne" %32, %34 : i64
          %36 = llvm.icmp "slt" %32, %18 : i64
          %37 = llvm.and %35, %36 : i1
          %38 = llvm.add %33, %7 : i64
          %39 = llvm.select %37, %38, %33 : i1, i64
          %40 = llvm.srem %32, %13 : i64
          %41 = llvm.icmp "slt" %40, %18 : i64
          %42 = llvm.add %40, %13 overflow<nsw> : i64
          %43 = llvm.select %41, %42, %40 : i1, i64
          %44 = llvm.mul %39, %12 overflow<nsw> : i64
          %45 = llvm.mul %43, %11 overflow<nsw> : i64
          %46 = llvm.mul %45, %6 : i64
          %47 = llvm.add %46, %44 : i64
          %48 = llvm.getelementptr %22[%47] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %49 = llvm.load %48 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %50 = llvm.add %45, %17 : i64
          %51 = llvm.mul %50, %6 : i64
          %52 = llvm.add %51, %44 : i64
          %53 = llvm.getelementptr %22[%52] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %54 = llvm.load %53 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %55 = llvm.add %45, %16 : i64
          %56 = llvm.mul %55, %6 : i64
          %57 = llvm.add %56, %44 : i64
          %58 = llvm.getelementptr %22[%57] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %59 = llvm.load %58 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %60 = llvm.add %45, %15 : i64
          %61 = llvm.mul %60, %6 : i64
          %62 = llvm.add %61, %44 : i64
          %63 = llvm.getelementptr %22[%62] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %64 = llvm.load %63 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %65 = llvm.add %45, %12 : i64
          %66 = llvm.mul %65, %6 : i64
          %67 = llvm.add %66, %44 : i64
          %68 = llvm.getelementptr %22[%67] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %69 = llvm.load %68 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %70 = llvm.add %45, %10 : i64
          %71 = llvm.mul %70, %6 : i64
          %72 = llvm.add %71, %44 : i64
          %73 = llvm.getelementptr %22[%72] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %74 = llvm.load %73 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %75 = llvm.add %45, %9 : i64
          %76 = llvm.mul %75, %6 : i64
          %77 = llvm.add %76, %44 : i64
          %78 = llvm.getelementptr %22[%77] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %79 = llvm.load %78 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %80 = llvm.add %45, %8 : i64
          %81 = llvm.mul %80, %6 : i64
          %82 = llvm.add %81, %44 : i64
          %83 = llvm.getelementptr %22[%82] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %84 = llvm.load %83 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %85 = llvm.shufflevector %49, %49 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %86 = llvm.shufflevector %85, %14 [0, 1, 2, 3, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %87 = llvm.shufflevector %54, %54 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %88 = llvm.shufflevector %87, %86 [32, 33, 34, 35, 0, 1, 2, 3, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %89 = llvm.shufflevector %59, %59 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %90 = llvm.shufflevector %89, %88 [32, 33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %91 = llvm.shufflevector %64, %64 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %92 = llvm.shufflevector %91, %90 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 0, 1, 2, 3, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %93 = llvm.shufflevector %69, %69 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %94 = llvm.shufflevector %93, %92 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 0, 1, 2, 3, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %95 = llvm.shufflevector %74, %74 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %96 = llvm.shufflevector %95, %94 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 0, 1, 2, 3, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %97 = llvm.shufflevector %79, %79 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %98 = llvm.shufflevector %97, %96 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 0, 1, 2, 3, 60, 61, 62, 63] : vector<32xi8> 
          %99 = llvm.shufflevector %84, %84 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %100 = llvm.shufflevector %99, %98 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 0, 1, 2, 3] : vector<32xi8> 
          %101 = llvm.shufflevector %100, %100 [0, 4, 8, 12, 16, 20, 24, 28, 1, 5, 9, 13, 17, 21, 25, 29, 2, 6, 10, 14, 18, 22, 26, 30, 3, 7, 11, 15, 19, 23, 27, 31] : vector<32xi8> 
          %102 = llvm.shufflevector %101, %101 [0, 1, 2, 3, 4, 5, 6, 7] : vector<32xi8> 
          %103 = llvm.shufflevector %101, %101 [8, 9, 10, 11, 12, 13, 14, 15] : vector<32xi8> 
          %104 = llvm.shufflevector %101, %101 [16, 17, 18, 19, 20, 21, 22, 23] : vector<32xi8> 
          %105 = llvm.shufflevector %101, %101 [24, 25, 26, 27, 28, 29, 30, 31] : vector<32xi8> 
          %106 = llvm.mul %39, %1 : i64
          %107 = llvm.mul %43, %2 : i64
          %108 = llvm.add %106, %107 : i64
          %109 = llvm.mul %18, %11 : i64
          %110 = llvm.add %108, %109 : i64
          %111 = llvm.add %110, %18 : i64
          %112 = llvm.getelementptr %29[%111] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %102, %112 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %113 = llvm.mul %17, %11 : i64
          %114 = llvm.add %108, %113 : i64
          %115 = llvm.add %114, %18 : i64
          %116 = llvm.getelementptr %29[%115] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %103, %116 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %117 = llvm.mul %16, %11 : i64
          %118 = llvm.add %108, %117 : i64
          %119 = llvm.add %118, %18 : i64
          %120 = llvm.getelementptr %29[%119] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %104, %120 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %121 = llvm.mul %15, %11 : i64
          %122 = llvm.add %108, %121 : i64
          %123 = llvm.add %122, %18 : i64
          %124 = llvm.getelementptr %29[%123] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %105, %124 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          llvm.return %0 : i32
        }
      }
    }
  }
  util.func public @conv_i8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @conv_i8(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}} {
    %c74880 = arith.constant 74880 : index
    %c65536 = arith.constant 65536 : index
    %c0 = arith.constant 0 : index
    %c1152 = arith.constant 1152 : index
    %c9248 = arith.constant 9248 : index
    %c16 = arith.constant 16 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c34 = arith.constant 34 : index
    %c1 = arith.constant 1 : index
    %element_type_i8 = hal.element_type<i8> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([%c1, %c34, %c34, %c8]) type(%element_type_i8) encoding(%dense_row_major)
    %0 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg0 : !hal.buffer_view -> tensor<1x34x34x8xi8> in !stream.resource<external>{%c9248}
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([%c3, %c3, %c8, %c16]) type(%element_type_i8) encoding(%dense_row_major)
    %1 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg1 : !hal.buffer_view -> tensor<3x3x8x16xi8> in !stream.resource<external>{%c1152}
    %result, %result_timepoint = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<external>{%c65536} => !stream.timepoint
    %result_0, %result_timepoint_1 = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<transient>{%c74880} => !stream.timepoint
    %2 = stream.timepoint.join max(%result_timepoint, %result_timepoint_1) => !stream.timepoint
    %3 = stream.cmd.execute on(#hal.device.affinity<@__device_0>) await(%2) => with(%0 as %arg2: !stream.resource<external>{%c9248}, %1 as %arg3: !stream.resource<external>{%c1152}, %result as %arg4: !stream.resource<external>{%c65536}, %result_0 as %arg5: !stream.resource<transient>{%c74880}) {
      stream.cmd.concurrent {
        stream.cmd.dispatch @conv_i8_dispatch_0::@embedded_elf_riscv_64::@conv_i8_dispatch_0_generic_32x32x3x3x8_i8 {
          ro %arg2[%c0 for %c9248] : !stream.resource<external>{%c9248},
          wo %arg5[%c0 for %c74880] : !stream.resource<transient>{%c74880}
        }
        stream.cmd.dispatch @_encoding_0::@embedded_elf_riscv_64::@_encoding_0_encode_72x16xi8_to_72x16xi8 {
          ro %arg3[%c0 for %c1152] : !stream.resource<external>{%c1152},
          wo %arg5[%c0 for %c74880] : !stream.resource<transient>{%c74880}
        }
      }
      stream.cmd.dispatch @conv_i8_dispatch_1::@embedded_elf_riscv_64::@conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32 {
        ro %arg5[%c0 for %c74880] : !stream.resource<transient>{%c74880},
        wo %arg4[%c0 for %c65536] : !stream.resource<external>{%c65536}
      }
    } => !stream.timepoint
    %4 = stream.resource.dealloca on(#hal.device.affinity<@__device_0>) await(%3) => %result_0 : !stream.resource<transient>{%c74880} => !stream.timepoint
    %5 = stream.timepoint.await %4 => %result : !stream.resource<external>{%c65536}
    %6 = stream.tensor.export on(#hal.device.affinity<@__device_0>) %5 : tensor<1x32x32x16xi32> in !stream.resource<external>{%c65536} -> !hal.buffer_view
    util.return %6 : !hal.buffer_view
  }
}
