#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @matmul_i8_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @matmul_i8_dispatch_0_matmul_32x32x64_i8xi8xi32 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c16 = arith.constant 16 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c16, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @matmul_i8_dispatch_0_matmul_32x32x64_i8xi8xi32(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(8 : i64) : i64
          %2 = llvm.mlir.constant(64 : index) : i64
          %3 = llvm.mlir.constant(true) : i1
          %4 = llvm.mlir.constant(32 : index) : i64
          %5 = llvm.mlir.constant(256 : index) : i64
          %6 = llvm.mlir.poison : !llvm.array<4 x vector<4xi32>>
          %7 = llvm.mlir.constant(-1 : index) : i64
          %8 = llvm.mlir.constant(16 : index) : i64
          %9 = llvm.mlir.poison : vector<16xi32>
          %10 = llvm.mlir.poison : vector<32xi8>
          %11 = llvm.mlir.constant(3 : index) : i64
          %12 = llvm.mlir.constant(2 : index) : i64
          %13 = llvm.mlir.constant(dense<0> : vector<4x4xi32>) : !llvm.array<4 x vector<4xi32>>
          %14 = llvm.mlir.constant(16 : i64) : i64
          %15 = llvm.mlir.undef : vector<[4]xi32>
          %16 = llvm.mlir.constant(0 : i64) : i64
          %17 = llvm.mlir.undef : vector<[8]xi8>
          %18 = llvm.mlir.constant(1 : index) : i64
          %19 = llvm.mlir.constant(8 : index) : i64
          %20 = llvm.mlir.constant(4 : index) : i64
          %21 = llvm.mlir.constant(0 : index) : i64
          %22 = llvm.mlir.constant(2048 : index) : i64
          %23 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %24 = llvm.extractvalue %23[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %25 = llvm.load %24 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%25, %2 : !llvm.ptr, i64)] : i1
          %26 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %27 = llvm.extractvalue %26[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %28 = llvm.load %27 : !llvm.ptr -> !llvm.ptr
          %29 = llvm.mul %22, %1 : i64
          %30 = llvm.udiv %29, %1 : i64
          %31 = llvm.getelementptr %28[%30] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %3 ["align"(%31, %2 : !llvm.ptr, i64)] : i1
          %32 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %33 = llvm.extractvalue %32[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %34 = llvm.getelementptr %33[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %35 = llvm.load %34 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%35, %2 : !llvm.ptr, i64)] : i1
          %36 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %37 = llvm.extractvalue %36[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %38 = llvm.zext %37 : i32 to i64
          %39 = llvm.sdiv %38, %12 : i64
          %40 = llvm.mul %39, %12 : i64
          %41 = llvm.icmp "ne" %38, %40 : i64
          %42 = llvm.icmp "slt" %38, %21 : i64
          %43 = llvm.and %41, %42 : i1
          %44 = llvm.add %39, %7 : i64
          %45 = llvm.select %43, %44, %39 : i1, i64
          %46 = llvm.srem %38, %12 : i64
          %47 = llvm.icmp "slt" %46, %21 : i64
          %48 = llvm.add %46, %12 overflow<nsw> : i64
          %49 = llvm.select %47, %48, %46 : i1, i64
          %50 = llvm.mul %49, %20 overflow<nsw> : i64
          %51 = llvm.mul %45, %20 overflow<nsw> : i64
          %52 = llvm.mul %49, %8 overflow<nsw> : i64
          llvm.br ^bb1(%21 : i64)
        ^bb1(%53: i64):  // 2 preds: ^bb0, ^bb5
          %54 = llvm.icmp "slt" %53, %20 : i64
          llvm.cond_br %54, ^bb2, ^bb6
        ^bb2:  // pred: ^bb1
          %55 = llvm.add %53, %50 : i64
          llvm.br ^bb3(%21, %13 : i64, !llvm.array<4 x vector<4xi32>>)
        ^bb3(%56: i64, %57: !llvm.array<4 x vector<4xi32>>):  // 2 preds: ^bb2, ^bb4
          %58 = llvm.icmp "slt" %56, %19 : i64
          llvm.cond_br %58, ^bb4, ^bb5
        ^bb4:  // pred: ^bb3
          %59 = llvm.mul %45, %5 : i64
          %60 = llvm.mul %56, %4 : i64
          %61 = llvm.add %59, %60 : i64
          %62 = llvm.mul %21, %19 : i64
          %63 = llvm.add %61, %62 : i64
          %64 = llvm.add %63, %21 : i64
          %65 = llvm.getelementptr %25[%64] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %66 = llvm.load %65 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %67 = llvm.mul %18, %19 : i64
          %68 = llvm.add %61, %67 : i64
          %69 = llvm.add %68, %21 : i64
          %70 = llvm.getelementptr %25[%69] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %71 = llvm.load %70 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %72 = llvm.mul %12, %19 : i64
          %73 = llvm.add %61, %72 : i64
          %74 = llvm.add %73, %21 : i64
          %75 = llvm.getelementptr %25[%74] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %76 = llvm.load %75 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %77 = llvm.mul %11, %19 : i64
          %78 = llvm.add %61, %77 : i64
          %79 = llvm.add %78, %21 : i64
          %80 = llvm.getelementptr %25[%79] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %81 = llvm.load %80 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %82 = llvm.mul %55, %5 : i64
          %83 = llvm.add %82, %60 : i64
          %84 = llvm.add %83, %62 : i64
          %85 = llvm.add %84, %21 : i64
          %86 = llvm.getelementptr %31[%85] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %87 = llvm.load %86 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %88 = llvm.add %83, %67 : i64
          %89 = llvm.add %88, %21 : i64
          %90 = llvm.getelementptr %31[%89] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %91 = llvm.load %90 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %92 = llvm.add %83, %72 : i64
          %93 = llvm.add %92, %21 : i64
          %94 = llvm.getelementptr %31[%93] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %95 = llvm.load %94 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %96 = llvm.add %83, %77 : i64
          %97 = llvm.add %96, %21 : i64
          %98 = llvm.getelementptr %31[%97] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %99 = llvm.load %98 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %100 = llvm.shufflevector %66, %66 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %101 = llvm.shufflevector %100, %10 [0, 1, 2, 3, 4, 5, 6, 7, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %102 = llvm.shufflevector %71, %71 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %103 = llvm.shufflevector %102, %101 [32, 33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 4, 5, 6, 7, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %104 = llvm.shufflevector %76, %76 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %105 = llvm.shufflevector %104, %103 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 0, 1, 2, 3, 4, 5, 6, 7, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %106 = llvm.shufflevector %81, %81 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %107 = llvm.shufflevector %106, %105 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 0, 1, 2, 3, 4, 5, 6, 7] : vector<32xi8> 
          %108 = llvm.shufflevector %87, %87 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %109 = llvm.shufflevector %108, %10 [0, 1, 2, 3, 4, 5, 6, 7, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %110 = llvm.shufflevector %91, %91 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %111 = llvm.shufflevector %110, %109 [32, 33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 4, 5, 6, 7, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %112 = llvm.shufflevector %95, %95 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %113 = llvm.shufflevector %112, %111 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 0, 1, 2, 3, 4, 5, 6, 7, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %114 = llvm.shufflevector %99, %99 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi8> 
          %115 = llvm.shufflevector %114, %113 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 0, 1, 2, 3, 4, 5, 6, 7] : vector<32xi8> 
          %116 = llvm.extractvalue %57[0] : !llvm.array<4 x vector<4xi32>> 
          %117 = llvm.shufflevector %116, %116 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %118 = llvm.shufflevector %117, %9 [0, 1, 2, 3, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi32> 
          %119 = llvm.extractvalue %57[1] : !llvm.array<4 x vector<4xi32>> 
          %120 = llvm.shufflevector %119, %119 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %121 = llvm.shufflevector %120, %118 [16, 17, 18, 19, 0, 1, 2, 3, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi32> 
          %122 = llvm.extractvalue %57[2] : !llvm.array<4 x vector<4xi32>> 
          %123 = llvm.shufflevector %122, %122 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %124 = llvm.shufflevector %123, %121 [16, 17, 18, 19, 20, 21, 22, 23, 0, 1, 2, 3, 28, 29, 30, 31] : vector<16xi32> 
          %125 = llvm.extractvalue %57[3] : !llvm.array<4 x vector<4xi32>> 
          %126 = llvm.shufflevector %125, %125 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi32> 
          %127 = llvm.shufflevector %126, %124 [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 0, 1, 2, 3] : vector<16xi32> 
          %128 = llvm.call_intrinsic "llvm.vector.insert"(%17, %107, %16) : (vector<[8]xi8>, vector<32xi8>, i64) -> vector<[8]xi8>
          %129 = llvm.call_intrinsic "llvm.vector.insert"(%17, %115, %16) : (vector<[8]xi8>, vector<32xi8>, i64) -> vector<[8]xi8>
          %130 = llvm.call_intrinsic "llvm.vector.insert"(%15, %127, %16) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %131 = llvm.call_intrinsic "llvm.riscv.smt.vmadot"(%130, %128, %129, %14) : (vector<[4]xi32>, vector<[8]xi8>, vector<[8]xi8>, i64) -> vector<[4]xi32>
          %132 = llvm.call_intrinsic "llvm.vector.extract"(%131, %16) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %133 = llvm.shufflevector %132, %132 [0, 1, 2, 3] : vector<16xi32> 
          %134 = llvm.shufflevector %132, %132 [4, 5, 6, 7] : vector<16xi32> 
          %135 = llvm.shufflevector %132, %132 [8, 9, 10, 11] : vector<16xi32> 
          %136 = llvm.shufflevector %132, %132 [12, 13, 14, 15] : vector<16xi32> 
          %137 = llvm.insertvalue %133, %6[0] : !llvm.array<4 x vector<4xi32>> 
          %138 = llvm.insertvalue %134, %137[1] : !llvm.array<4 x vector<4xi32>> 
          %139 = llvm.insertvalue %135, %138[2] : !llvm.array<4 x vector<4xi32>> 
          %140 = llvm.insertvalue %136, %139[3] : !llvm.array<4 x vector<4xi32>> 
          %141 = llvm.add %56, %18 : i64
          llvm.br ^bb3(%141, %140 : i64, !llvm.array<4 x vector<4xi32>>)
        ^bb5:  // pred: ^bb3
          %142 = llvm.mul %53, %20 overflow<nsw> : i64
          %143 = llvm.extractvalue %57[0] : !llvm.array<4 x vector<4xi32>> 
          %144 = llvm.add %52, %142 : i64
          %145 = llvm.mul %51, %4 : i64
          %146 = llvm.add %145, %144 : i64
          %147 = llvm.getelementptr %35[%146] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %143, %147 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %148 = llvm.extractvalue %57[1] : !llvm.array<4 x vector<4xi32>> 
          %149 = llvm.add %51, %18 : i64
          %150 = llvm.mul %149, %4 : i64
          %151 = llvm.add %150, %144 : i64
          %152 = llvm.getelementptr %35[%151] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %148, %152 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %153 = llvm.extractvalue %57[2] : !llvm.array<4 x vector<4xi32>> 
          %154 = llvm.add %51, %12 : i64
          %155 = llvm.mul %154, %4 : i64
          %156 = llvm.add %155, %144 : i64
          %157 = llvm.getelementptr %35[%156] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %153, %157 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %158 = llvm.extractvalue %57[3] : !llvm.array<4 x vector<4xi32>> 
          %159 = llvm.add %51, %11 : i64
          %160 = llvm.mul %159, %4 : i64
          %161 = llvm.add %160, %144 : i64
          %162 = llvm.getelementptr %35[%161] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %158, %162 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
          %163 = llvm.add %53, %18 : i64
          llvm.br ^bb1(%163 : i64)
        ^bb6:  // pred: ^bb1
          llvm.return %0 : i32
        }
      }
    }
  }
  hal.executable private @_encoding_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_0_encode_32x64xi8_to_32x64xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c64 = arith.constant 64 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c64, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @_encoding_0_encode_32x64xi8_to_32x64xi8(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(256 : index) : i64
          %2 = llvm.mlir.constant(true) : i1
          %3 = llvm.mlir.constant(64 : index) : i64
          %4 = llvm.mlir.constant(32 : index) : i64
          %5 = llvm.mlir.constant(-1 : index) : i64
          %6 = llvm.mlir.constant(4 : index) : i64
          %7 = llvm.mlir.constant(8 : index) : i64
          %8 = llvm.mlir.constant(3 : index) : i64
          %9 = llvm.mlir.constant(2 : index) : i64
          %10 = llvm.mlir.constant(1 : index) : i64
          %11 = llvm.mlir.constant(0 : index) : i64
          %12 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %13 = llvm.extractvalue %12[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %14 = llvm.load %13 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %2 ["align"(%14, %3 : !llvm.ptr, i64)] : i1
          %15 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %16 = llvm.extractvalue %15[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %17 = llvm.getelementptr %16[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %18 = llvm.load %17 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %2 ["align"(%18, %3 : !llvm.ptr, i64)] : i1
          %19 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %20 = llvm.extractvalue %19[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %21 = llvm.zext %20 : i32 to i64
          %22 = llvm.sdiv %21, %7 : i64
          %23 = llvm.mul %22, %7 : i64
          %24 = llvm.icmp "ne" %21, %23 : i64
          %25 = llvm.icmp "slt" %21, %11 : i64
          %26 = llvm.and %24, %25 : i1
          %27 = llvm.add %22, %5 : i64
          %28 = llvm.select %26, %27, %22 : i1, i64
          %29 = llvm.srem %21, %7 : i64
          %30 = llvm.icmp "slt" %29, %11 : i64
          %31 = llvm.add %29, %7 overflow<nsw> : i64
          %32 = llvm.select %30, %31, %29 : i1, i64
          %33 = llvm.mul %32, %7 overflow<nsw> : i64
          %34 = llvm.mul %28, %6 overflow<nsw> : i64
          %35 = llvm.mul %34, %3 : i64
          %36 = llvm.add %35, %33 : i64
          %37 = llvm.getelementptr %14[%36] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %38 = llvm.load %37 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %39 = llvm.add %34, %10 : i64
          %40 = llvm.mul %39, %3 : i64
          %41 = llvm.add %40, %33 : i64
          %42 = llvm.getelementptr %14[%41] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %43 = llvm.load %42 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %44 = llvm.add %34, %9 : i64
          %45 = llvm.mul %44, %3 : i64
          %46 = llvm.add %45, %33 : i64
          %47 = llvm.getelementptr %14[%46] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %48 = llvm.load %47 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %49 = llvm.add %34, %8 : i64
          %50 = llvm.mul %49, %3 : i64
          %51 = llvm.add %50, %33 : i64
          %52 = llvm.getelementptr %14[%51] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %53 = llvm.load %52 {alignment = 1 : i64} : !llvm.ptr -> vector<8xi8>
          %54 = llvm.mul %28, %1 : i64
          %55 = llvm.mul %32, %4 : i64
          %56 = llvm.add %54, %55 : i64
          %57 = llvm.mul %11, %7 : i64
          %58 = llvm.add %56, %57 : i64
          %59 = llvm.add %58, %11 : i64
          %60 = llvm.getelementptr %18[%59] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %38, %60 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %61 = llvm.mul %10, %7 : i64
          %62 = llvm.add %56, %61 : i64
          %63 = llvm.add %62, %11 : i64
          %64 = llvm.getelementptr %18[%63] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %43, %64 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %65 = llvm.mul %9, %7 : i64
          %66 = llvm.add %56, %65 : i64
          %67 = llvm.add %66, %11 : i64
          %68 = llvm.getelementptr %18[%67] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %48, %68 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %69 = llvm.mul %8, %7 : i64
          %70 = llvm.add %56, %69 : i64
          %71 = llvm.add %70, %11 : i64
          %72 = llvm.getelementptr %18[%71] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %53, %72 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          llvm.return %0 : i32
        }
      }
    }
  }
  hal.executable private @_encoding_1 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_1_encode_64x32xi8_to_64x32xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c64 = arith.constant 64 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c64, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @_encoding_1_encode_64x32xi8_to_64x32xi8(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(256 : index) : i64
          %2 = llvm.mlir.constant(8 : i64) : i64
          %3 = llvm.mlir.constant(true) : i1
          %4 = llvm.mlir.constant(32 : index) : i64
          %5 = llvm.mlir.constant(64 : index) : i64
          %6 = llvm.mlir.constant(-1 : index) : i64
          %7 = llvm.mlir.constant(7 : index) : i64
          %8 = llvm.mlir.constant(6 : index) : i64
          %9 = llvm.mlir.constant(5 : index) : i64
          %10 = llvm.mlir.constant(4 : index) : i64
          %11 = llvm.mlir.constant(8 : index) : i64
          %12 = llvm.mlir.poison : vector<32xi8>
          %13 = llvm.mlir.constant(3 : index) : i64
          %14 = llvm.mlir.constant(2 : index) : i64
          %15 = llvm.mlir.constant(1 : index) : i64
          %16 = llvm.mlir.constant(0 : index) : i64
          %17 = llvm.mlir.constant(2048 : index) : i64
          %18 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %19 = llvm.extractvalue %18[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %20 = llvm.load %19 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%20, %5 : !llvm.ptr, i64)] : i1
          %21 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %22 = llvm.extractvalue %21[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %23 = llvm.getelementptr %22[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %24 = llvm.load %23 : !llvm.ptr -> !llvm.ptr
          %25 = llvm.mul %17, %2 : i64
          %26 = llvm.udiv %25, %2 : i64
          %27 = llvm.getelementptr %24[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %3 ["align"(%27, %5 : !llvm.ptr, i64)] : i1
          %28 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %29 = llvm.extractvalue %28[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %30 = llvm.zext %29 : i32 to i64
          %31 = llvm.sdiv %30, %11 : i64
          %32 = llvm.mul %31, %11 : i64
          %33 = llvm.icmp "ne" %30, %32 : i64
          %34 = llvm.icmp "slt" %30, %16 : i64
          %35 = llvm.and %33, %34 : i1
          %36 = llvm.add %31, %6 : i64
          %37 = llvm.select %35, %36, %31 : i1, i64
          %38 = llvm.srem %30, %11 : i64
          %39 = llvm.icmp "slt" %38, %16 : i64
          %40 = llvm.add %38, %11 overflow<nsw> : i64
          %41 = llvm.select %39, %40, %38 : i1, i64
          %42 = llvm.mul %37, %10 overflow<nsw> : i64
          %43 = llvm.mul %41, %11 overflow<nsw> : i64
          %44 = llvm.mul %43, %4 : i64
          %45 = llvm.add %44, %42 : i64
          %46 = llvm.getelementptr %20[%45] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %47 = llvm.load %46 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %48 = llvm.add %43, %15 : i64
          %49 = llvm.mul %48, %4 : i64
          %50 = llvm.add %49, %42 : i64
          %51 = llvm.getelementptr %20[%50] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %52 = llvm.load %51 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %53 = llvm.add %43, %14 : i64
          %54 = llvm.mul %53, %4 : i64
          %55 = llvm.add %54, %42 : i64
          %56 = llvm.getelementptr %20[%55] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %57 = llvm.load %56 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %58 = llvm.add %43, %13 : i64
          %59 = llvm.mul %58, %4 : i64
          %60 = llvm.add %59, %42 : i64
          %61 = llvm.getelementptr %20[%60] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %62 = llvm.load %61 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %63 = llvm.add %43, %10 : i64
          %64 = llvm.mul %63, %4 : i64
          %65 = llvm.add %64, %42 : i64
          %66 = llvm.getelementptr %20[%65] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %67 = llvm.load %66 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %68 = llvm.add %43, %9 : i64
          %69 = llvm.mul %68, %4 : i64
          %70 = llvm.add %69, %42 : i64
          %71 = llvm.getelementptr %20[%70] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %72 = llvm.load %71 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %73 = llvm.add %43, %8 : i64
          %74 = llvm.mul %73, %4 : i64
          %75 = llvm.add %74, %42 : i64
          %76 = llvm.getelementptr %20[%75] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %77 = llvm.load %76 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %78 = llvm.add %43, %7 : i64
          %79 = llvm.mul %78, %4 : i64
          %80 = llvm.add %79, %42 : i64
          %81 = llvm.getelementptr %20[%80] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %82 = llvm.load %81 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi8>
          %83 = llvm.shufflevector %47, %47 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %84 = llvm.shufflevector %83, %12 [0, 1, 2, 3, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %85 = llvm.shufflevector %52, %52 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %86 = llvm.shufflevector %85, %84 [32, 33, 34, 35, 0, 1, 2, 3, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %87 = llvm.shufflevector %57, %57 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %88 = llvm.shufflevector %87, %86 [32, 33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %89 = llvm.shufflevector %62, %62 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %90 = llvm.shufflevector %89, %88 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 0, 1, 2, 3, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %91 = llvm.shufflevector %67, %67 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %92 = llvm.shufflevector %91, %90 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 0, 1, 2, 3, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %93 = llvm.shufflevector %72, %72 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %94 = llvm.shufflevector %93, %92 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 0, 1, 2, 3, 56, 57, 58, 59, 60, 61, 62, 63] : vector<32xi8> 
          %95 = llvm.shufflevector %77, %77 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %96 = llvm.shufflevector %95, %94 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 0, 1, 2, 3, 60, 61, 62, 63] : vector<32xi8> 
          %97 = llvm.shufflevector %82, %82 [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi8> 
          %98 = llvm.shufflevector %97, %96 [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 0, 1, 2, 3] : vector<32xi8> 
          %99 = llvm.shufflevector %98, %98 [0, 4, 8, 12, 16, 20, 24, 28, 1, 5, 9, 13, 17, 21, 25, 29, 2, 6, 10, 14, 18, 22, 26, 30, 3, 7, 11, 15, 19, 23, 27, 31] : vector<32xi8> 
          %100 = llvm.shufflevector %99, %99 [0, 1, 2, 3, 4, 5, 6, 7] : vector<32xi8> 
          %101 = llvm.shufflevector %99, %99 [8, 9, 10, 11, 12, 13, 14, 15] : vector<32xi8> 
          %102 = llvm.shufflevector %99, %99 [16, 17, 18, 19, 20, 21, 22, 23] : vector<32xi8> 
          %103 = llvm.shufflevector %99, %99 [24, 25, 26, 27, 28, 29, 30, 31] : vector<32xi8> 
          %104 = llvm.mul %37, %1 : i64
          %105 = llvm.mul %41, %4 : i64
          %106 = llvm.add %104, %105 : i64
          %107 = llvm.mul %16, %11 : i64
          %108 = llvm.add %106, %107 : i64
          %109 = llvm.add %108, %16 : i64
          %110 = llvm.getelementptr %27[%109] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %100, %110 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %111 = llvm.mul %15, %11 : i64
          %112 = llvm.add %106, %111 : i64
          %113 = llvm.add %112, %16 : i64
          %114 = llvm.getelementptr %27[%113] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %101, %114 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %115 = llvm.mul %14, %11 : i64
          %116 = llvm.add %106, %115 : i64
          %117 = llvm.add %116, %16 : i64
          %118 = llvm.getelementptr %27[%117] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %102, %118 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %119 = llvm.mul %13, %11 : i64
          %120 = llvm.add %106, %119 : i64
          %121 = llvm.add %120, %16 : i64
          %122 = llvm.getelementptr %27[%121] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %103, %122 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          llvm.return %0 : i32
        }
      }
    }
  }
  util.func public @matmul_i8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}} {
    %c0 = arith.constant 0 : index
    %c4096 = arith.constant 4096 : index
    %c2048 = arith.constant 2048 : index
    %c64 = arith.constant 64 : index
    %c32 = arith.constant 32 : index
    %element_type_i8 = hal.element_type<i8> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([%c32, %c64]) type(%element_type_i8) encoding(%dense_row_major)
    %0 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg0 : !hal.buffer_view -> tensor<32x64xi8> in !stream.resource<external>{%c2048}
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([%c64, %c32]) type(%element_type_i8) encoding(%dense_row_major)
    %1 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg1 : !hal.buffer_view -> tensor<64x32xi8> in !stream.resource<external>{%c2048}
    %result, %result_timepoint = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<external>{%c4096} => !stream.timepoint
    %result_0, %result_timepoint_1 = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<transient>{%c4096} => !stream.timepoint
    %2 = stream.timepoint.join max(%result_timepoint, %result_timepoint_1) => !stream.timepoint
    %3 = stream.cmd.execute on(#hal.device.affinity<@__device_0>) await(%2) => with(%0 as %arg2: !stream.resource<external>{%c2048}, %1 as %arg3: !stream.resource<external>{%c2048}, %result as %arg4: !stream.resource<external>{%c4096}, %result_0 as %arg5: !stream.resource<transient>{%c4096}) {
      stream.cmd.concurrent {
        stream.cmd.dispatch @_encoding_0::@embedded_elf_riscv_64::@_encoding_0_encode_32x64xi8_to_32x64xi8 {
          ro %arg2[%c0 for %c2048] : !stream.resource<external>{%c2048},
          wo %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096}
        }
        stream.cmd.dispatch @_encoding_1::@embedded_elf_riscv_64::@_encoding_1_encode_64x32xi8_to_64x32xi8 {
          ro %arg3[%c0 for %c2048] : !stream.resource<external>{%c2048},
          wo %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096}
        }
      }
      stream.cmd.dispatch @matmul_i8_dispatch_0::@embedded_elf_riscv_64::@matmul_i8_dispatch_0_matmul_32x32x64_i8xi8xi32 {
        ro %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096},
        wo %arg4[%c0 for %c4096] : !stream.resource<external>{%c4096}
      }
    } => !stream.timepoint
    %4 = stream.resource.dealloca on(#hal.device.affinity<@__device_0>) await(%3) => %result_0 : !stream.resource<transient>{%c4096} => !stream.timepoint
    %5 = stream.timepoint.await %4 => %result : !stream.resource<external>{%c4096}
    %6 = stream.tensor.export on(#hal.device.affinity<@__device_0>) %5 : tensor<32x32xi32> in !stream.resource<external>{%c4096} -> !hal.buffer_view
    util.return %6 : !hal.buffer_view
  }
}
