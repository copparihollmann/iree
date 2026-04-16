#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl128b,+xopu", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, link_ukernel_bitcode = false, max_stack_allocation_size = 32768 : i64, native_vector_size = 16 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @matmul_i8_quantized_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c4 = arith.constant 4 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c4, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(15 : index) : i64
          %2 = llvm.mlir.constant(14 : index) : i64
          %3 = llvm.mlir.constant(13 : index) : i64
          %4 = llvm.mlir.constant(12 : index) : i64
          %5 = llvm.mlir.constant(11 : index) : i64
          %6 = llvm.mlir.constant(10 : index) : i64
          %7 = llvm.mlir.constant(9 : index) : i64
          %8 = llvm.mlir.constant(8 : index) : i64
          %9 = llvm.mlir.constant(7 : index) : i64
          %10 = llvm.mlir.constant(6 : index) : i64
          %11 = llvm.mlir.constant(5 : index) : i64
          %12 = llvm.mlir.constant(4 : index) : i64
          %13 = llvm.mlir.constant(3 : index) : i64
          %14 = llvm.mlir.constant(32 : index) : i64
          %15 = llvm.mlir.constant(true) : i1
          %16 = llvm.mlir.constant(1024 : index) : i64
          %17 = llvm.mlir.poison : !llvm.array<16 x vector<16xi32>>
          %18 = llvm.mlir.constant(-1 : index) : i64
          %19 = llvm.mlir.constant(16 : index) : i64
          %20 = llvm.mlir.constant(2 : index) : i64
          %21 = llvm.mlir.constant(dense<0> : vector<16x16xi32>) : !llvm.array<16 x vector<16xi32>>
          %22 = llvm.mlir.constant(15 : i64) : i64
          %23 = llvm.mlir.constant(14 : i64) : i64
          %24 = llvm.mlir.constant(13 : i64) : i64
          %25 = llvm.mlir.constant(12 : i64) : i64
          %26 = llvm.mlir.constant(11 : i64) : i64
          %27 = llvm.mlir.constant(10 : i64) : i64
          %28 = llvm.mlir.constant(9 : i64) : i64
          %29 = llvm.mlir.constant(8 : i64) : i64
          %30 = llvm.mlir.constant(7 : i64) : i64
          %31 = llvm.mlir.constant(6 : i64) : i64
          %32 = llvm.mlir.constant(5 : i64) : i64
          %33 = llvm.mlir.constant(4 : i64) : i64
          %34 = llvm.mlir.constant(3 : i64) : i64
          %35 = llvm.mlir.constant(2 : i64) : i64
          %36 = llvm.mlir.constant(1 : i64) : i64
          %37 = llvm.mlir.undef : vector<[8]xi32>
          %38 = llvm.mlir.constant(dense<0> : vector<16xi32>) : vector<16xi32>
          %39 = llvm.mlir.constant(0 : i64) : i64
          %40 = llvm.mlir.undef : vector<[8]xi8>
          %41 = llvm.mlir.constant(16 : i64) : i64
          %42 = llvm.mlir.constant(1 : index) : i64
          %43 = llvm.mlir.constant(64 : index) : i64
          %44 = llvm.mlir.constant(0 : index) : i64
          %45 = llvm.mlir.constant(2048 : index) : i64
          %46 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %47 = llvm.extractvalue %46[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %48 = llvm.load %47 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %15 ["align"(%48, %43 : !llvm.ptr, i64)] : i1
          %49 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %50 = llvm.extractvalue %49[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %51 = llvm.load %50 : !llvm.ptr -> !llvm.ptr
          %52 = llvm.mul %45, %29 : i64
          %53 = llvm.udiv %52, %29 : i64
          %54 = llvm.getelementptr %51[%53] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %15 ["align"(%54, %43 : !llvm.ptr, i64)] : i1
          %55 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %56 = llvm.extractvalue %55[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %57 = llvm.getelementptr %56[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %58 = llvm.load %57 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %15 ["align"(%58, %43 : !llvm.ptr, i64)] : i1
          %59 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %60 = llvm.extractvalue %59[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %61 = llvm.zext %60 : i32 to i64
          %62 = llvm.sdiv %61, %20 : i64
          %63 = llvm.mul %62, %20 : i64
          %64 = llvm.icmp "ne" %61, %63 : i64
          %65 = llvm.icmp "slt" %61, %44 : i64
          %66 = llvm.and %64, %65 : i1
          %67 = llvm.add %62, %18 : i64
          %68 = llvm.select %66, %67, %62 : i1, i64
          %69 = llvm.srem %61, %20 : i64
          %70 = llvm.icmp "slt" %69, %44 : i64
          %71 = llvm.add %69, %20 overflow<nsw> : i64
          %72 = llvm.select %70, %71, %69 : i1, i64
          %73 = llvm.mul %68, %19 overflow<nsw> : i64
          %74 = llvm.mul %72, %19 overflow<nsw> : i64
          llvm.br ^bb1(%44, %21 : i64, !llvm.array<16 x vector<16xi32>>)
        ^bb1(%75: i64, %76: !llvm.array<16 x vector<16xi32>>):  // 2 preds: ^bb0, ^bb2
          %77 = llvm.icmp "slt" %75, %43 : i64
          llvm.cond_br %77, ^bb2, ^bb3
        ^bb2:  // pred: ^bb1
          %78 = llvm.mul %68, %16 : i64
          %79 = llvm.mul %75, %19 : i64
          %80 = llvm.add %78, %79 : i64
          %81 = llvm.add %80, %44 : i64
          %82 = llvm.add %81, %44 : i64
          %83 = llvm.getelementptr %48[%82] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %84 = llvm.load %83 {alignment = 1 : i64} : !llvm.ptr -> vector<16xi8>
          %85 = llvm.mul %72, %16 : i64
          %86 = llvm.add %85, %79 : i64
          %87 = llvm.add %86, %44 : i64
          %88 = llvm.add %87, %44 : i64
          %89 = llvm.getelementptr %54[%88] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %90 = llvm.load %89 {alignment = 1 : i64} : !llvm.ptr -> vector<16xi8>
          %91 = llvm.extractvalue %76[0] : !llvm.array<16 x vector<16xi32>> 
          %92 = llvm.extractvalue %76[1] : !llvm.array<16 x vector<16xi32>> 
          %93 = llvm.extractvalue %76[2] : !llvm.array<16 x vector<16xi32>> 
          %94 = llvm.extractvalue %76[3] : !llvm.array<16 x vector<16xi32>> 
          %95 = llvm.extractvalue %76[4] : !llvm.array<16 x vector<16xi32>> 
          %96 = llvm.extractvalue %76[5] : !llvm.array<16 x vector<16xi32>> 
          %97 = llvm.extractvalue %76[6] : !llvm.array<16 x vector<16xi32>> 
          %98 = llvm.extractvalue %76[7] : !llvm.array<16 x vector<16xi32>> 
          %99 = llvm.extractvalue %76[8] : !llvm.array<16 x vector<16xi32>> 
          %100 = llvm.extractvalue %76[9] : !llvm.array<16 x vector<16xi32>> 
          %101 = llvm.extractvalue %76[10] : !llvm.array<16 x vector<16xi32>> 
          %102 = llvm.extractvalue %76[11] : !llvm.array<16 x vector<16xi32>> 
          %103 = llvm.extractvalue %76[12] : !llvm.array<16 x vector<16xi32>> 
          %104 = llvm.extractvalue %76[13] : !llvm.array<16 x vector<16xi32>> 
          %105 = llvm.extractvalue %76[14] : !llvm.array<16 x vector<16xi32>> 
          %106 = llvm.extractvalue %76[15] : !llvm.array<16 x vector<16xi32>> 
          %107 = llvm.call_intrinsic "llvm.vector.insert"(%40, %84, %39) : (vector<[8]xi8>, vector<16xi8>, i64) -> vector<[8]xi8>
          %108 = llvm.call_intrinsic "llvm.vector.insert"(%40, %90, %39) : (vector<[8]xi8>, vector<16xi8>, i64) -> vector<[8]xi8>
          %109 = llvm.call_intrinsic "llvm.vector.insert"(%37, %38, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.bcast"(%109, %41) : (vector<[8]xi32>, i64) -> ()
          %110 = llvm.call_intrinsic "llvm.vector.insert"(%37, %91, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%39, %110, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %111 = llvm.call_intrinsic "llvm.vector.insert"(%37, %92, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%36, %111, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %112 = llvm.call_intrinsic "llvm.vector.insert"(%37, %93, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%35, %112, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %113 = llvm.call_intrinsic "llvm.vector.insert"(%37, %94, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%34, %113, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %114 = llvm.call_intrinsic "llvm.vector.insert"(%37, %95, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%33, %114, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %115 = llvm.call_intrinsic "llvm.vector.insert"(%37, %96, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%32, %115, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %116 = llvm.call_intrinsic "llvm.vector.insert"(%37, %97, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%31, %116, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %117 = llvm.call_intrinsic "llvm.vector.insert"(%37, %98, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%30, %117, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %118 = llvm.call_intrinsic "llvm.vector.insert"(%37, %99, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%29, %118, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %119 = llvm.call_intrinsic "llvm.vector.insert"(%37, %100, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%28, %119, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %120 = llvm.call_intrinsic "llvm.vector.insert"(%37, %101, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%27, %120, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %121 = llvm.call_intrinsic "llvm.vector.insert"(%37, %102, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%26, %121, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %122 = llvm.call_intrinsic "llvm.vector.insert"(%37, %103, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%25, %122, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %123 = llvm.call_intrinsic "llvm.vector.insert"(%37, %104, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%24, %123, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %124 = llvm.call_intrinsic "llvm.vector.insert"(%37, %105, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%23, %124, %41) : (i64, vector<[8]xi32>, i64) -> ()
          %125 = llvm.call_intrinsic "llvm.vector.insert"(%37, %106, %39) : (vector<[8]xi32>, vector<16xi32>, i64) -> vector<[8]xi32>
          llvm.call_intrinsic "llvm.riscv.opu.vmv.rv"(%22, %125, %41) : (i64, vector<[8]xi32>, i64) -> ()
          llvm.call_intrinsic "llvm.riscv.opu.vopacc"(%107, %108, %41) : (vector<[8]xi8>, vector<[8]xi8>, i64) -> ()
          %126 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%39, %41) : (i64, i64) -> vector<[8]xi32>
          %127 = llvm.call_intrinsic "llvm.vector.extract"(%126, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %128 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%36, %41) : (i64, i64) -> vector<[8]xi32>
          %129 = llvm.call_intrinsic "llvm.vector.extract"(%128, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %130 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%35, %41) : (i64, i64) -> vector<[8]xi32>
          %131 = llvm.call_intrinsic "llvm.vector.extract"(%130, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %132 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%34, %41) : (i64, i64) -> vector<[8]xi32>
          %133 = llvm.call_intrinsic "llvm.vector.extract"(%132, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %134 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%33, %41) : (i64, i64) -> vector<[8]xi32>
          %135 = llvm.call_intrinsic "llvm.vector.extract"(%134, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %136 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%32, %41) : (i64, i64) -> vector<[8]xi32>
          %137 = llvm.call_intrinsic "llvm.vector.extract"(%136, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %138 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%31, %41) : (i64, i64) -> vector<[8]xi32>
          %139 = llvm.call_intrinsic "llvm.vector.extract"(%138, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %140 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%30, %41) : (i64, i64) -> vector<[8]xi32>
          %141 = llvm.call_intrinsic "llvm.vector.extract"(%140, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %142 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%29, %41) : (i64, i64) -> vector<[8]xi32>
          %143 = llvm.call_intrinsic "llvm.vector.extract"(%142, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %144 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%28, %41) : (i64, i64) -> vector<[8]xi32>
          %145 = llvm.call_intrinsic "llvm.vector.extract"(%144, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %146 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%27, %41) : (i64, i64) -> vector<[8]xi32>
          %147 = llvm.call_intrinsic "llvm.vector.extract"(%146, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %148 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%26, %41) : (i64, i64) -> vector<[8]xi32>
          %149 = llvm.call_intrinsic "llvm.vector.extract"(%148, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %150 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%25, %41) : (i64, i64) -> vector<[8]xi32>
          %151 = llvm.call_intrinsic "llvm.vector.extract"(%150, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %152 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%24, %41) : (i64, i64) -> vector<[8]xi32>
          %153 = llvm.call_intrinsic "llvm.vector.extract"(%152, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %154 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%23, %41) : (i64, i64) -> vector<[8]xi32>
          %155 = llvm.call_intrinsic "llvm.vector.extract"(%154, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %156 = llvm.call_intrinsic "llvm.riscv.opu.vmv.vr"(%22, %41) : (i64, i64) -> vector<[8]xi32>
          %157 = llvm.call_intrinsic "llvm.vector.extract"(%156, %39) : (vector<[8]xi32>, i64) -> vector<16xi32>
          %158 = llvm.insertvalue %127, %17[0] : !llvm.array<16 x vector<16xi32>> 
          %159 = llvm.insertvalue %129, %158[1] : !llvm.array<16 x vector<16xi32>> 
          %160 = llvm.insertvalue %131, %159[2] : !llvm.array<16 x vector<16xi32>> 
          %161 = llvm.insertvalue %133, %160[3] : !llvm.array<16 x vector<16xi32>> 
          %162 = llvm.insertvalue %135, %161[4] : !llvm.array<16 x vector<16xi32>> 
          %163 = llvm.insertvalue %137, %162[5] : !llvm.array<16 x vector<16xi32>> 
          %164 = llvm.insertvalue %139, %163[6] : !llvm.array<16 x vector<16xi32>> 
          %165 = llvm.insertvalue %141, %164[7] : !llvm.array<16 x vector<16xi32>> 
          %166 = llvm.insertvalue %143, %165[8] : !llvm.array<16 x vector<16xi32>> 
          %167 = llvm.insertvalue %145, %166[9] : !llvm.array<16 x vector<16xi32>> 
          %168 = llvm.insertvalue %147, %167[10] : !llvm.array<16 x vector<16xi32>> 
          %169 = llvm.insertvalue %149, %168[11] : !llvm.array<16 x vector<16xi32>> 
          %170 = llvm.insertvalue %151, %169[12] : !llvm.array<16 x vector<16xi32>> 
          %171 = llvm.insertvalue %153, %170[13] : !llvm.array<16 x vector<16xi32>> 
          %172 = llvm.insertvalue %155, %171[14] : !llvm.array<16 x vector<16xi32>> 
          %173 = llvm.insertvalue %157, %172[15] : !llvm.array<16 x vector<16xi32>> 
          %174 = llvm.add %75, %42 : i64
          llvm.br ^bb1(%174, %173 : i64, !llvm.array<16 x vector<16xi32>>)
        ^bb3:  // pred: ^bb1
          %175 = llvm.extractvalue %76[0] : !llvm.array<16 x vector<16xi32>> 
          %176 = llvm.mul %73, %14 : i64
          %177 = llvm.add %176, %74 : i64
          %178 = llvm.getelementptr %58[%177] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %175, %178 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %179 = llvm.extractvalue %76[1] : !llvm.array<16 x vector<16xi32>> 
          %180 = llvm.add %73, %42 : i64
          %181 = llvm.mul %180, %14 : i64
          %182 = llvm.add %181, %74 : i64
          %183 = llvm.getelementptr %58[%182] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %179, %183 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %184 = llvm.extractvalue %76[2] : !llvm.array<16 x vector<16xi32>> 
          %185 = llvm.add %73, %20 : i64
          %186 = llvm.mul %185, %14 : i64
          %187 = llvm.add %186, %74 : i64
          %188 = llvm.getelementptr %58[%187] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %184, %188 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %189 = llvm.extractvalue %76[3] : !llvm.array<16 x vector<16xi32>> 
          %190 = llvm.add %73, %13 : i64
          %191 = llvm.mul %190, %14 : i64
          %192 = llvm.add %191, %74 : i64
          %193 = llvm.getelementptr %58[%192] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %189, %193 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %194 = llvm.extractvalue %76[4] : !llvm.array<16 x vector<16xi32>> 
          %195 = llvm.add %73, %12 : i64
          %196 = llvm.mul %195, %14 : i64
          %197 = llvm.add %196, %74 : i64
          %198 = llvm.getelementptr %58[%197] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %194, %198 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %199 = llvm.extractvalue %76[5] : !llvm.array<16 x vector<16xi32>> 
          %200 = llvm.add %73, %11 : i64
          %201 = llvm.mul %200, %14 : i64
          %202 = llvm.add %201, %74 : i64
          %203 = llvm.getelementptr %58[%202] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %199, %203 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %204 = llvm.extractvalue %76[6] : !llvm.array<16 x vector<16xi32>> 
          %205 = llvm.add %73, %10 : i64
          %206 = llvm.mul %205, %14 : i64
          %207 = llvm.add %206, %74 : i64
          %208 = llvm.getelementptr %58[%207] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %204, %208 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %209 = llvm.extractvalue %76[7] : !llvm.array<16 x vector<16xi32>> 
          %210 = llvm.add %73, %9 : i64
          %211 = llvm.mul %210, %14 : i64
          %212 = llvm.add %211, %74 : i64
          %213 = llvm.getelementptr %58[%212] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %209, %213 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %214 = llvm.extractvalue %76[8] : !llvm.array<16 x vector<16xi32>> 
          %215 = llvm.add %73, %8 : i64
          %216 = llvm.mul %215, %14 : i64
          %217 = llvm.add %216, %74 : i64
          %218 = llvm.getelementptr %58[%217] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %214, %218 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %219 = llvm.extractvalue %76[9] : !llvm.array<16 x vector<16xi32>> 
          %220 = llvm.add %73, %7 : i64
          %221 = llvm.mul %220, %14 : i64
          %222 = llvm.add %221, %74 : i64
          %223 = llvm.getelementptr %58[%222] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %219, %223 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %224 = llvm.extractvalue %76[10] : !llvm.array<16 x vector<16xi32>> 
          %225 = llvm.add %73, %6 : i64
          %226 = llvm.mul %225, %14 : i64
          %227 = llvm.add %226, %74 : i64
          %228 = llvm.getelementptr %58[%227] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %224, %228 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %229 = llvm.extractvalue %76[11] : !llvm.array<16 x vector<16xi32>> 
          %230 = llvm.add %73, %5 : i64
          %231 = llvm.mul %230, %14 : i64
          %232 = llvm.add %231, %74 : i64
          %233 = llvm.getelementptr %58[%232] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %229, %233 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %234 = llvm.extractvalue %76[12] : !llvm.array<16 x vector<16xi32>> 
          %235 = llvm.add %73, %4 : i64
          %236 = llvm.mul %235, %14 : i64
          %237 = llvm.add %236, %74 : i64
          %238 = llvm.getelementptr %58[%237] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %234, %238 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %239 = llvm.extractvalue %76[13] : !llvm.array<16 x vector<16xi32>> 
          %240 = llvm.add %73, %3 : i64
          %241 = llvm.mul %240, %14 : i64
          %242 = llvm.add %241, %74 : i64
          %243 = llvm.getelementptr %58[%242] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %239, %243 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %244 = llvm.extractvalue %76[14] : !llvm.array<16 x vector<16xi32>> 
          %245 = llvm.add %73, %2 : i64
          %246 = llvm.mul %245, %14 : i64
          %247 = llvm.add %246, %74 : i64
          %248 = llvm.getelementptr %58[%247] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %244, %248 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %249 = llvm.extractvalue %76[15] : !llvm.array<16 x vector<16xi32>> 
          %250 = llvm.add %73, %1 : i64
          %251 = llvm.mul %250, %14 : i64
          %252 = llvm.add %251, %74 : i64
          %253 = llvm.getelementptr %58[%252] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %249, %253 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          llvm.return %0 : i32
        }
      }
    }
  }
  hal.executable private @_encoding_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_0_encode_32x64xi8_to_32x64xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c16 = arith.constant 16 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c16, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @_encoding_0_encode_32x64xi8_to_32x64xi8(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(15 : i64) : i64
          %2 = llvm.mlir.constant(14 : i64) : i64
          %3 = llvm.mlir.constant(13 : i64) : i64
          %4 = llvm.mlir.constant(12 : i64) : i64
          %5 = llvm.mlir.constant(11 : i64) : i64
          %6 = llvm.mlir.constant(10 : i64) : i64
          %7 = llvm.mlir.constant(9 : i64) : i64
          %8 = llvm.mlir.constant(8 : i64) : i64
          %9 = llvm.mlir.constant(7 : i64) : i64
          %10 = llvm.mlir.constant(6 : i64) : i64
          %11 = llvm.mlir.constant(5 : i64) : i64
          %12 = llvm.mlir.constant(4 : i64) : i64
          %13 = llvm.mlir.constant(3 : i64) : i64
          %14 = llvm.mlir.constant(2 : i64) : i64
          %15 = llvm.mlir.constant(1 : i64) : i64
          %16 = llvm.mlir.poison : vector<16xi8>
          %17 = llvm.mlir.constant(0 : i64) : i64
          %18 = llvm.mlir.constant(1024 : index) : i64
          %19 = llvm.mlir.constant(true) : i1
          %20 = llvm.mlir.constant(64 : index) : i64
          %21 = llvm.mlir.constant(-1 : index) : i64
          %22 = llvm.mlir.constant(15 : index) : i64
          %23 = llvm.mlir.constant(14 : index) : i64
          %24 = llvm.mlir.constant(13 : index) : i64
          %25 = llvm.mlir.constant(12 : index) : i64
          %26 = llvm.mlir.constant(11 : index) : i64
          %27 = llvm.mlir.constant(10 : index) : i64
          %28 = llvm.mlir.constant(9 : index) : i64
          %29 = llvm.mlir.constant(7 : index) : i64
          %30 = llvm.mlir.constant(6 : index) : i64
          %31 = llvm.mlir.constant(5 : index) : i64
          %32 = llvm.mlir.constant(4 : index) : i64
          %33 = llvm.mlir.constant(3 : index) : i64
          %34 = llvm.mlir.constant(2 : index) : i64
          %35 = llvm.mlir.constant(16 : index) : i64
          %36 = llvm.mlir.constant(8 : index) : i64
          %37 = llvm.mlir.constant(1 : index) : i64
          %38 = llvm.mlir.constant(0 : index) : i64
          %39 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %40 = llvm.extractvalue %39[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %41 = llvm.load %40 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %19 ["align"(%41, %20 : !llvm.ptr, i64)] : i1
          %42 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %43 = llvm.extractvalue %42[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %44 = llvm.getelementptr %43[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %45 = llvm.load %44 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %19 ["align"(%45, %20 : !llvm.ptr, i64)] : i1
          %46 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %47 = llvm.extractvalue %46[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %48 = llvm.zext %47 : i32 to i64
          %49 = llvm.sdiv %48, %36 : i64
          %50 = llvm.mul %49, %36 : i64
          %51 = llvm.icmp "ne" %48, %50 : i64
          %52 = llvm.icmp "slt" %48, %38 : i64
          %53 = llvm.and %51, %52 : i1
          %54 = llvm.add %49, %21 : i64
          %55 = llvm.select %53, %54, %49 : i1, i64
          %56 = llvm.srem %48, %36 : i64
          %57 = llvm.icmp "slt" %56, %38 : i64
          %58 = llvm.add %56, %36 overflow<nsw> : i64
          %59 = llvm.select %57, %58, %56 : i1, i64
          %60 = llvm.mul %59, %36 overflow<nsw> : i64
          llvm.br ^bb1(%38 : i64)
        ^bb1(%61: i64):  // 2 preds: ^bb0, ^bb2
          %62 = llvm.icmp "slt" %61, %36 : i64
          llvm.cond_br %62, ^bb2, ^bb3
        ^bb2:  // pred: ^bb1
          %63 = llvm.add %61, %60 : i64
          %64 = llvm.mul %55, %35 overflow<nsw> : i64
          %65 = llvm.mul %64, %20 : i64
          %66 = llvm.add %65, %63 : i64
          %67 = llvm.getelementptr %41[%66] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %68 = llvm.load %67 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %69 = llvm.add %64, %37 : i64
          %70 = llvm.mul %69, %20 : i64
          %71 = llvm.add %70, %63 : i64
          %72 = llvm.getelementptr %41[%71] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %73 = llvm.load %72 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %74 = llvm.add %64, %34 : i64
          %75 = llvm.mul %74, %20 : i64
          %76 = llvm.add %75, %63 : i64
          %77 = llvm.getelementptr %41[%76] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %78 = llvm.load %77 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %79 = llvm.add %64, %33 : i64
          %80 = llvm.mul %79, %20 : i64
          %81 = llvm.add %80, %63 : i64
          %82 = llvm.getelementptr %41[%81] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %83 = llvm.load %82 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %84 = llvm.add %64, %32 : i64
          %85 = llvm.mul %84, %20 : i64
          %86 = llvm.add %85, %63 : i64
          %87 = llvm.getelementptr %41[%86] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %88 = llvm.load %87 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %89 = llvm.add %64, %31 : i64
          %90 = llvm.mul %89, %20 : i64
          %91 = llvm.add %90, %63 : i64
          %92 = llvm.getelementptr %41[%91] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %93 = llvm.load %92 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %94 = llvm.add %64, %30 : i64
          %95 = llvm.mul %94, %20 : i64
          %96 = llvm.add %95, %63 : i64
          %97 = llvm.getelementptr %41[%96] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %98 = llvm.load %97 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %99 = llvm.add %64, %29 : i64
          %100 = llvm.mul %99, %20 : i64
          %101 = llvm.add %100, %63 : i64
          %102 = llvm.getelementptr %41[%101] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %103 = llvm.load %102 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %104 = llvm.add %64, %36 : i64
          %105 = llvm.mul %104, %20 : i64
          %106 = llvm.add %105, %63 : i64
          %107 = llvm.getelementptr %41[%106] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %108 = llvm.load %107 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %109 = llvm.add %64, %28 : i64
          %110 = llvm.mul %109, %20 : i64
          %111 = llvm.add %110, %63 : i64
          %112 = llvm.getelementptr %41[%111] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %113 = llvm.load %112 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %114 = llvm.add %64, %27 : i64
          %115 = llvm.mul %114, %20 : i64
          %116 = llvm.add %115, %63 : i64
          %117 = llvm.getelementptr %41[%116] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %118 = llvm.load %117 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %119 = llvm.add %64, %26 : i64
          %120 = llvm.mul %119, %20 : i64
          %121 = llvm.add %120, %63 : i64
          %122 = llvm.getelementptr %41[%121] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %123 = llvm.load %122 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %124 = llvm.add %64, %25 : i64
          %125 = llvm.mul %124, %20 : i64
          %126 = llvm.add %125, %63 : i64
          %127 = llvm.getelementptr %41[%126] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %128 = llvm.load %127 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %129 = llvm.add %64, %24 : i64
          %130 = llvm.mul %129, %20 : i64
          %131 = llvm.add %130, %63 : i64
          %132 = llvm.getelementptr %41[%131] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %133 = llvm.load %132 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %134 = llvm.add %64, %23 : i64
          %135 = llvm.mul %134, %20 : i64
          %136 = llvm.add %135, %63 : i64
          %137 = llvm.getelementptr %41[%136] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %138 = llvm.load %137 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %139 = llvm.add %64, %22 : i64
          %140 = llvm.mul %139, %20 : i64
          %141 = llvm.add %140, %63 : i64
          %142 = llvm.getelementptr %41[%141] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %143 = llvm.load %142 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %144 = llvm.extractelement %68[%17 : i64] : vector<1xi8>
          %145 = llvm.extractelement %73[%17 : i64] : vector<1xi8>
          %146 = llvm.extractelement %78[%17 : i64] : vector<1xi8>
          %147 = llvm.extractelement %83[%17 : i64] : vector<1xi8>
          %148 = llvm.extractelement %88[%17 : i64] : vector<1xi8>
          %149 = llvm.extractelement %93[%17 : i64] : vector<1xi8>
          %150 = llvm.extractelement %98[%17 : i64] : vector<1xi8>
          %151 = llvm.extractelement %103[%17 : i64] : vector<1xi8>
          %152 = llvm.extractelement %108[%17 : i64] : vector<1xi8>
          %153 = llvm.extractelement %113[%17 : i64] : vector<1xi8>
          %154 = llvm.extractelement %118[%17 : i64] : vector<1xi8>
          %155 = llvm.extractelement %123[%17 : i64] : vector<1xi8>
          %156 = llvm.extractelement %128[%17 : i64] : vector<1xi8>
          %157 = llvm.extractelement %133[%17 : i64] : vector<1xi8>
          %158 = llvm.extractelement %138[%17 : i64] : vector<1xi8>
          %159 = llvm.extractelement %143[%17 : i64] : vector<1xi8>
          %160 = llvm.insertelement %144, %16[%17 : i64] : vector<16xi8>
          %161 = llvm.insertelement %145, %160[%15 : i64] : vector<16xi8>
          %162 = llvm.insertelement %146, %161[%14 : i64] : vector<16xi8>
          %163 = llvm.insertelement %147, %162[%13 : i64] : vector<16xi8>
          %164 = llvm.insertelement %148, %163[%12 : i64] : vector<16xi8>
          %165 = llvm.insertelement %149, %164[%11 : i64] : vector<16xi8>
          %166 = llvm.insertelement %150, %165[%10 : i64] : vector<16xi8>
          %167 = llvm.insertelement %151, %166[%9 : i64] : vector<16xi8>
          %168 = llvm.insertelement %152, %167[%8 : i64] : vector<16xi8>
          %169 = llvm.insertelement %153, %168[%7 : i64] : vector<16xi8>
          %170 = llvm.insertelement %154, %169[%6 : i64] : vector<16xi8>
          %171 = llvm.insertelement %155, %170[%5 : i64] : vector<16xi8>
          %172 = llvm.insertelement %156, %171[%4 : i64] : vector<16xi8>
          %173 = llvm.insertelement %157, %172[%3 : i64] : vector<16xi8>
          %174 = llvm.insertelement %158, %173[%2 : i64] : vector<16xi8>
          %175 = llvm.insertelement %159, %174[%1 : i64] : vector<16xi8>
          %176 = llvm.mul %55, %18 : i64
          %177 = llvm.mul %63, %35 : i64
          %178 = llvm.add %176, %177 : i64
          %179 = llvm.add %178, %38 : i64
          %180 = llvm.add %179, %38 : i64
          %181 = llvm.getelementptr %45[%180] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %175, %181 {alignment = 1 : i64} : vector<16xi8>, !llvm.ptr
          %182 = llvm.add %61, %37 : i64
          llvm.br ^bb1(%182 : i64)
        ^bb3:  // pred: ^bb1
          llvm.return %0 : i32
        }
      }
    }
  }
  hal.executable private @_encoding_1 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_1_encode_64x32xi8_to_64x32xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c128 = arith.constant 128 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c128, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @_encoding_1_encode_64x32xi8_to_64x32xi8(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(1024 : index) : i64
          %2 = llvm.mlir.constant(8 : i64) : i64
          %3 = llvm.mlir.constant(true) : i1
          %4 = llvm.mlir.constant(32 : index) : i64
          %5 = llvm.mlir.constant(-1 : index) : i64
          %6 = llvm.mlir.constant(16 : index) : i64
          %7 = llvm.mlir.constant(64 : index) : i64
          %8 = llvm.mlir.constant(0 : index) : i64
          %9 = llvm.mlir.constant(2048 : index) : i64
          %10 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %11 = llvm.extractvalue %10[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %12 = llvm.load %11 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %3 ["align"(%12, %7 : !llvm.ptr, i64)] : i1
          %13 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %14 = llvm.extractvalue %13[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %15 = llvm.getelementptr %14[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %16 = llvm.load %15 : !llvm.ptr -> !llvm.ptr
          %17 = llvm.mul %9, %2 : i64
          %18 = llvm.udiv %17, %2 : i64
          %19 = llvm.getelementptr %16[%18] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %3 ["align"(%19, %7 : !llvm.ptr, i64)] : i1
          %20 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %21 = llvm.extractvalue %20[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %22 = llvm.zext %21 : i32 to i64
          %23 = llvm.sdiv %22, %7 : i64
          %24 = llvm.mul %23, %7 : i64
          %25 = llvm.icmp "ne" %22, %24 : i64
          %26 = llvm.icmp "slt" %22, %8 : i64
          %27 = llvm.and %25, %26 : i1
          %28 = llvm.add %23, %5 : i64
          %29 = llvm.select %27, %28, %23 : i1, i64
          %30 = llvm.srem %22, %7 : i64
          %31 = llvm.icmp "slt" %30, %8 : i64
          %32 = llvm.add %30, %7 overflow<nsw> : i64
          %33 = llvm.select %31, %32, %30 : i1, i64
          %34 = llvm.mul %29, %6 overflow<nsw> : i64
          %35 = llvm.mul %33, %4 : i64
          %36 = llvm.add %35, %34 : i64
          %37 = llvm.getelementptr %12[%36] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %38 = llvm.load %37 {alignment = 1 : i64} : !llvm.ptr -> vector<16xi8>
          %39 = llvm.mul %29, %1 : i64
          %40 = llvm.mul %33, %6 : i64
          %41 = llvm.add %39, %40 : i64
          %42 = llvm.add %41, %8 : i64
          %43 = llvm.add %42, %8 : i64
          %44 = llvm.getelementptr %19[%43] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %38, %44 {alignment = 1 : i64} : vector<16xi8>, !llvm.ptr
          llvm.return %0 : i32
        }
      }
    }
  }
  util.func public @matmul_i8_quantized(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8_quantized(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}} {
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
      stream.cmd.dispatch @matmul_i8_quantized_dispatch_0::@embedded_elf_riscv_64::@matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 {
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
