#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, link_ukernel_bitcode = false, loop_vectorization = true, max_stack_allocation_size = 32768 : i64, native_vector_size = 32 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @matmul_i8_quantized_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c8 = arith.constant 8 : index
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        hal.return %c8, %c1, %c1_0 : index, index, index
      } attributes {workgroup_size = [1 : index, 1 : index, 1 : index]}
      builtin.module attributes {llvm.data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", llvm.target_triple = "riscv64-unknown-unknown-eabi-elf"} {
        llvm.func @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(%arg0: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg1: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}, %arg2: !llvm.ptr {llvm.align = 16 : i64, llvm.noalias, llvm.nonnull, llvm.noundef}) -> i32 {
          %0 = llvm.mlir.constant(0 : i32) : i32
          %1 = llvm.mlir.constant(32 : index) : i64
          %2 = llvm.mlir.constant(1024 : index) : i64
          %3 = llvm.mlir.constant(8 : i64) : i64
          %4 = llvm.mlir.constant(true) : i1
          %5 = llvm.mlir.constant(512 : index) : i64
          %6 = llvm.mlir.poison : !llvm.array<8 x vector<16xi32>>
          %7 = llvm.mlir.constant(-1 : index) : i64
          %8 = llvm.mlir.constant(7 : index) : i64
          %9 = llvm.mlir.constant(6 : index) : i64
          %10 = llvm.mlir.constant(5 : index) : i64
          %11 = llvm.mlir.constant(4 : index) : i64
          %12 = llvm.mlir.constant(3 : index) : i64
          %13 = llvm.mlir.constant(16 : index) : i64
          %14 = llvm.mlir.constant(8 : index) : i64
          %15 = llvm.mlir.constant(2 : index) : i64
          %16 = llvm.mlir.constant(dense<0> : vector<8x16xi32>) : !llvm.array<8 x vector<16xi32>>
          %17 = llvm.mlir.undef : vector<[4]xi32>
          %18 = llvm.mlir.undef : vector<[4]xi16>
          %19 = llvm.mlir.constant(16 : i64) : i64
          %20 = llvm.mlir.constant(0 : i64) : i64
          %21 = llvm.mlir.undef : vector<[4]xi8>
          %22 = llvm.mlir.constant(1 : index) : i64
          %23 = llvm.mlir.constant(64 : index) : i64
          %24 = llvm.mlir.constant(0 : index) : i64
          %25 = llvm.mlir.constant(2048 : index) : i64
          %26 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %27 = llvm.extractvalue %26[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %28 = llvm.load %27 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %4 ["align"(%28, %23 : !llvm.ptr, i64)] : i1
          %29 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %30 = llvm.extractvalue %29[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %31 = llvm.load %30 : !llvm.ptr -> !llvm.ptr
          %32 = llvm.mul %25, %3 : i64
          %33 = llvm.udiv %32, %3 : i64
          %34 = llvm.getelementptr %31[%33] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.intr.assume %4 ["align"(%34, %23 : !llvm.ptr, i64)] : i1
          %35 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %36 = llvm.extractvalue %35[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %37 = llvm.getelementptr %36[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %38 = llvm.load %37 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %4 ["align"(%38, %23 : !llvm.ptr, i64)] : i1
          %39 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %40 = llvm.extractvalue %39[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %41 = llvm.zext %40 : i32 to i64
          %42 = llvm.sdiv %41, %15 : i64
          %43 = llvm.mul %42, %15 : i64
          %44 = llvm.icmp "ne" %41, %43 : i64
          %45 = llvm.icmp "slt" %41, %24 : i64
          %46 = llvm.and %44, %45 : i1
          %47 = llvm.add %42, %7 : i64
          %48 = llvm.select %46, %47, %42 : i1, i64
          %49 = llvm.srem %41, %15 : i64
          %50 = llvm.icmp "slt" %49, %24 : i64
          %51 = llvm.add %49, %15 overflow<nsw> : i64
          %52 = llvm.select %50, %51, %49 : i1, i64
          %53 = llvm.mul %48, %14 overflow<nsw> : i64
          %54 = llvm.mul %52, %13 overflow<nsw> : i64
          llvm.br ^bb1(%24, %16 : i64, !llvm.array<8 x vector<16xi32>>)
        ^bb1(%55: i64, %56: !llvm.array<8 x vector<16xi32>>):  // 2 preds: ^bb0, ^bb2
          %57 = llvm.icmp "slt" %55, %23 : i64
          llvm.cond_br %57, ^bb2, ^bb3
        ^bb2:  // pred: ^bb1
          %58 = llvm.mul %52, %2 : i64
          %59 = llvm.mul %55, %13 : i64
          %60 = llvm.add %58, %59 : i64
          %61 = llvm.add %60, %24 : i64
          %62 = llvm.add %61, %24 : i64
          %63 = llvm.getelementptr %34[%62] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %64 = llvm.load %63 {alignment = 1 : i64} : !llvm.ptr -> vector<16xi8>
          %65 = llvm.extractvalue %56[0] : !llvm.array<8 x vector<16xi32>> 
          %66 = llvm.extractvalue %56[1] : !llvm.array<8 x vector<16xi32>> 
          %67 = llvm.extractvalue %56[2] : !llvm.array<8 x vector<16xi32>> 
          %68 = llvm.extractvalue %56[3] : !llvm.array<8 x vector<16xi32>> 
          %69 = llvm.extractvalue %56[4] : !llvm.array<8 x vector<16xi32>> 
          %70 = llvm.extractvalue %56[5] : !llvm.array<8 x vector<16xi32>> 
          %71 = llvm.extractvalue %56[6] : !llvm.array<8 x vector<16xi32>> 
          %72 = llvm.extractvalue %56[7] : !llvm.array<8 x vector<16xi32>> 
          %73 = llvm.call_intrinsic "llvm.vector.insert"(%21, %64, %20) : (vector<[4]xi8>, vector<16xi8>, i64) -> vector<[4]xi8>
          %74 = llvm.mul %48, %5 overflow<nsw, nuw> : i64
          %75 = llvm.mul %55, %14 overflow<nsw, nuw> : i64
          %76 = llvm.add %74, %75 overflow<nsw, nuw> : i64
          %77 = llvm.add %76, %24 overflow<nsw, nuw> : i64
          %78 = llvm.add %77, %24 overflow<nsw, nuw> : i64
          %79 = llvm.getelementptr inbounds|nuw %28[%78] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %80 = llvm.load %79 : !llvm.ptr -> i8
          %81 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %80, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %82 = llvm.add %76, %22 overflow<nsw, nuw> : i64
          %83 = llvm.add %82, %24 overflow<nsw, nuw> : i64
          %84 = llvm.getelementptr inbounds|nuw %28[%83] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %85 = llvm.load %84 : !llvm.ptr -> i8
          %86 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %85, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %87 = llvm.add %76, %15 overflow<nsw, nuw> : i64
          %88 = llvm.add %87, %24 overflow<nsw, nuw> : i64
          %89 = llvm.getelementptr inbounds|nuw %28[%88] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %90 = llvm.load %89 : !llvm.ptr -> i8
          %91 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %90, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %92 = llvm.add %76, %12 overflow<nsw, nuw> : i64
          %93 = llvm.add %92, %24 overflow<nsw, nuw> : i64
          %94 = llvm.getelementptr inbounds|nuw %28[%93] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %95 = llvm.load %94 : !llvm.ptr -> i8
          %96 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %95, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %97 = llvm.add %76, %11 overflow<nsw, nuw> : i64
          %98 = llvm.add %97, %24 overflow<nsw, nuw> : i64
          %99 = llvm.getelementptr inbounds|nuw %28[%98] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %100 = llvm.load %99 : !llvm.ptr -> i8
          %101 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %100, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %102 = llvm.add %76, %10 overflow<nsw, nuw> : i64
          %103 = llvm.add %102, %24 overflow<nsw, nuw> : i64
          %104 = llvm.getelementptr inbounds|nuw %28[%103] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %105 = llvm.load %104 : !llvm.ptr -> i8
          %106 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %105, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %107 = llvm.add %76, %9 overflow<nsw, nuw> : i64
          %108 = llvm.add %107, %24 overflow<nsw, nuw> : i64
          %109 = llvm.getelementptr inbounds|nuw %28[%108] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %110 = llvm.load %109 : !llvm.ptr -> i8
          %111 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %110, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %112 = llvm.add %76, %8 overflow<nsw, nuw> : i64
          %113 = llvm.add %112, %24 overflow<nsw, nuw> : i64
          %114 = llvm.getelementptr inbounds|nuw %28[%113] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %115 = llvm.load %114 : !llvm.ptr -> i8
          %116 = llvm.call_intrinsic "llvm.riscv.vwmul"(%18, %73, %115, %19) : (vector<[4]xi16>, vector<[4]xi8>, i8, i64) -> vector<[4]xi16>
          %117 = llvm.call_intrinsic "llvm.vector.insert"(%17, %65, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %118 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%117, %117, %81, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %119 = llvm.call_intrinsic "llvm.vector.extract"(%118, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %120 = llvm.call_intrinsic "llvm.vector.insert"(%17, %66, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %121 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%120, %120, %86, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %122 = llvm.call_intrinsic "llvm.vector.extract"(%121, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %123 = llvm.call_intrinsic "llvm.vector.insert"(%17, %67, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %124 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%123, %123, %91, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %125 = llvm.call_intrinsic "llvm.vector.extract"(%124, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %126 = llvm.call_intrinsic "llvm.vector.insert"(%17, %68, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %127 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%126, %126, %96, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %128 = llvm.call_intrinsic "llvm.vector.extract"(%127, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %129 = llvm.call_intrinsic "llvm.vector.insert"(%17, %69, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %130 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%129, %129, %101, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %131 = llvm.call_intrinsic "llvm.vector.extract"(%130, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %132 = llvm.call_intrinsic "llvm.vector.insert"(%17, %70, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %133 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%132, %132, %106, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %134 = llvm.call_intrinsic "llvm.vector.extract"(%133, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %135 = llvm.call_intrinsic "llvm.vector.insert"(%17, %71, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %136 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%135, %135, %111, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %137 = llvm.call_intrinsic "llvm.vector.extract"(%136, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %138 = llvm.call_intrinsic "llvm.vector.insert"(%17, %72, %20) : (vector<[4]xi32>, vector<16xi32>, i64) -> vector<[4]xi32>
          %139 = llvm.call_intrinsic "llvm.riscv.vwadd.w"(%138, %138, %116, %19) : (vector<[4]xi32>, vector<[4]xi32>, vector<[4]xi16>, i64) -> vector<[4]xi32>
          %140 = llvm.call_intrinsic "llvm.vector.extract"(%139, %20) : (vector<[4]xi32>, i64) -> vector<16xi32>
          %141 = llvm.insertvalue %119, %6[0] : !llvm.array<8 x vector<16xi32>> 
          %142 = llvm.insertvalue %122, %141[1] : !llvm.array<8 x vector<16xi32>> 
          %143 = llvm.insertvalue %125, %142[2] : !llvm.array<8 x vector<16xi32>> 
          %144 = llvm.insertvalue %128, %143[3] : !llvm.array<8 x vector<16xi32>> 
          %145 = llvm.insertvalue %131, %144[4] : !llvm.array<8 x vector<16xi32>> 
          %146 = llvm.insertvalue %134, %145[5] : !llvm.array<8 x vector<16xi32>> 
          %147 = llvm.insertvalue %137, %146[6] : !llvm.array<8 x vector<16xi32>> 
          %148 = llvm.insertvalue %140, %147[7] : !llvm.array<8 x vector<16xi32>> 
          %149 = llvm.add %55, %22 : i64
          llvm.br ^bb1(%149, %148 : i64, !llvm.array<8 x vector<16xi32>>)
        ^bb3:  // pred: ^bb1
          %150 = llvm.extractvalue %56[0] : !llvm.array<8 x vector<16xi32>> 
          %151 = llvm.mul %53, %1 : i64
          %152 = llvm.add %151, %54 : i64
          %153 = llvm.getelementptr %38[%152] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %150, %153 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %154 = llvm.extractvalue %56[1] : !llvm.array<8 x vector<16xi32>> 
          %155 = llvm.add %53, %22 : i64
          %156 = llvm.mul %155, %1 : i64
          %157 = llvm.add %156, %54 : i64
          %158 = llvm.getelementptr %38[%157] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %154, %158 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %159 = llvm.extractvalue %56[2] : !llvm.array<8 x vector<16xi32>> 
          %160 = llvm.add %53, %15 : i64
          %161 = llvm.mul %160, %1 : i64
          %162 = llvm.add %161, %54 : i64
          %163 = llvm.getelementptr %38[%162] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %159, %163 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %164 = llvm.extractvalue %56[3] : !llvm.array<8 x vector<16xi32>> 
          %165 = llvm.add %53, %12 : i64
          %166 = llvm.mul %165, %1 : i64
          %167 = llvm.add %166, %54 : i64
          %168 = llvm.getelementptr %38[%167] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %164, %168 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %169 = llvm.extractvalue %56[4] : !llvm.array<8 x vector<16xi32>> 
          %170 = llvm.add %53, %11 : i64
          %171 = llvm.mul %170, %1 : i64
          %172 = llvm.add %171, %54 : i64
          %173 = llvm.getelementptr %38[%172] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %169, %173 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %174 = llvm.extractvalue %56[5] : !llvm.array<8 x vector<16xi32>> 
          %175 = llvm.add %53, %10 : i64
          %176 = llvm.mul %175, %1 : i64
          %177 = llvm.add %176, %54 : i64
          %178 = llvm.getelementptr %38[%177] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %174, %178 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %179 = llvm.extractvalue %56[6] : !llvm.array<8 x vector<16xi32>> 
          %180 = llvm.add %53, %9 : i64
          %181 = llvm.mul %180, %1 : i64
          %182 = llvm.add %181, %54 : i64
          %183 = llvm.getelementptr %38[%182] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %179, %183 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
          %184 = llvm.extractvalue %56[7] : !llvm.array<8 x vector<16xi32>> 
          %185 = llvm.add %53, %8 : i64
          %186 = llvm.mul %185, %1 : i64
          %187 = llvm.add %186, %54 : i64
          %188 = llvm.getelementptr %38[%187] : (!llvm.ptr, i64) -> !llvm.ptr, i32
          llvm.store %184, %188 {alignment = 4 : i64} : vector<16xi32>, !llvm.ptr
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
          %1 = llvm.mlir.constant(7 : i64) : i64
          %2 = llvm.mlir.constant(6 : i64) : i64
          %3 = llvm.mlir.constant(5 : i64) : i64
          %4 = llvm.mlir.constant(4 : i64) : i64
          %5 = llvm.mlir.constant(3 : i64) : i64
          %6 = llvm.mlir.constant(2 : i64) : i64
          %7 = llvm.mlir.constant(1 : i64) : i64
          %8 = llvm.mlir.poison : vector<8xi8>
          %9 = llvm.mlir.constant(0 : i64) : i64
          %10 = llvm.mlir.constant(512 : index) : i64
          %11 = llvm.mlir.constant(true) : i1
          %12 = llvm.mlir.constant(64 : index) : i64
          %13 = llvm.mlir.constant(-1 : index) : i64
          %14 = llvm.mlir.constant(7 : index) : i64
          %15 = llvm.mlir.constant(6 : index) : i64
          %16 = llvm.mlir.constant(5 : index) : i64
          %17 = llvm.mlir.constant(3 : index) : i64
          %18 = llvm.mlir.constant(2 : index) : i64
          %19 = llvm.mlir.constant(8 : index) : i64
          %20 = llvm.mlir.constant(4 : index) : i64
          %21 = llvm.mlir.constant(16 : index) : i64
          %22 = llvm.mlir.constant(1 : index) : i64
          %23 = llvm.mlir.constant(0 : index) : i64
          %24 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %25 = llvm.extractvalue %24[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %26 = llvm.load %25 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %11 ["align"(%26, %12 : !llvm.ptr, i64)] : i1
          %27 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)>
          %28 = llvm.extractvalue %27[10] : !llvm.struct<"iree_hal_executable_dispatch_state_v0_t", (i32, i32, i16, i16, i32, i32, i16, i8, i8, ptr, ptr, ptr)> 
          %29 = llvm.getelementptr %28[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
          %30 = llvm.load %29 : !llvm.ptr -> !llvm.ptr
          llvm.intr.assume %11 ["align"(%30, %12 : !llvm.ptr, i64)] : i1
          %31 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)>
          %32 = llvm.extractvalue %31[0] : !llvm.struct<"iree_hal_executable_workgroup_state_v0_t", (i32, i32, i16, i16, i32, ptr, i32)> 
          %33 = llvm.zext %32 : i32 to i64
          %34 = llvm.sdiv %33, %20 : i64
          %35 = llvm.mul %34, %20 : i64
          %36 = llvm.icmp "ne" %33, %35 : i64
          %37 = llvm.icmp "slt" %33, %23 : i64
          %38 = llvm.and %36, %37 : i1
          %39 = llvm.add %34, %13 : i64
          %40 = llvm.select %38, %39, %34 : i1, i64
          %41 = llvm.srem %33, %20 : i64
          %42 = llvm.icmp "slt" %41, %23 : i64
          %43 = llvm.add %41, %20 overflow<nsw> : i64
          %44 = llvm.select %42, %43, %41 : i1, i64
          %45 = llvm.mul %44, %21 overflow<nsw> : i64
          llvm.br ^bb1(%23 : i64)
        ^bb1(%46: i64):  // 2 preds: ^bb0, ^bb2
          %47 = llvm.icmp "slt" %46, %21 : i64
          llvm.cond_br %47, ^bb2, ^bb3
        ^bb2:  // pred: ^bb1
          %48 = llvm.add %46, %45 : i64
          %49 = llvm.mul %40, %19 overflow<nsw> : i64
          %50 = llvm.mul %49, %12 : i64
          %51 = llvm.add %50, %48 : i64
          %52 = llvm.getelementptr %26[%51] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %53 = llvm.load %52 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %54 = llvm.add %49, %22 : i64
          %55 = llvm.mul %54, %12 : i64
          %56 = llvm.add %55, %48 : i64
          %57 = llvm.getelementptr %26[%56] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %58 = llvm.load %57 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %59 = llvm.add %49, %18 : i64
          %60 = llvm.mul %59, %12 : i64
          %61 = llvm.add %60, %48 : i64
          %62 = llvm.getelementptr %26[%61] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %63 = llvm.load %62 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %64 = llvm.add %49, %17 : i64
          %65 = llvm.mul %64, %12 : i64
          %66 = llvm.add %65, %48 : i64
          %67 = llvm.getelementptr %26[%66] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %68 = llvm.load %67 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %69 = llvm.add %49, %20 : i64
          %70 = llvm.mul %69, %12 : i64
          %71 = llvm.add %70, %48 : i64
          %72 = llvm.getelementptr %26[%71] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %73 = llvm.load %72 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %74 = llvm.add %49, %16 : i64
          %75 = llvm.mul %74, %12 : i64
          %76 = llvm.add %75, %48 : i64
          %77 = llvm.getelementptr %26[%76] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %78 = llvm.load %77 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %79 = llvm.add %49, %15 : i64
          %80 = llvm.mul %79, %12 : i64
          %81 = llvm.add %80, %48 : i64
          %82 = llvm.getelementptr %26[%81] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %83 = llvm.load %82 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %84 = llvm.add %49, %14 : i64
          %85 = llvm.mul %84, %12 : i64
          %86 = llvm.add %85, %48 : i64
          %87 = llvm.getelementptr %26[%86] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          %88 = llvm.load %87 {alignment = 1 : i64} : !llvm.ptr -> vector<1xi8>
          %89 = llvm.extractelement %53[%9 : i64] : vector<1xi8>
          %90 = llvm.extractelement %58[%9 : i64] : vector<1xi8>
          %91 = llvm.extractelement %63[%9 : i64] : vector<1xi8>
          %92 = llvm.extractelement %68[%9 : i64] : vector<1xi8>
          %93 = llvm.extractelement %73[%9 : i64] : vector<1xi8>
          %94 = llvm.extractelement %78[%9 : i64] : vector<1xi8>
          %95 = llvm.extractelement %83[%9 : i64] : vector<1xi8>
          %96 = llvm.extractelement %88[%9 : i64] : vector<1xi8>
          %97 = llvm.insertelement %89, %8[%9 : i64] : vector<8xi8>
          %98 = llvm.insertelement %90, %97[%7 : i64] : vector<8xi8>
          %99 = llvm.insertelement %91, %98[%6 : i64] : vector<8xi8>
          %100 = llvm.insertelement %92, %99[%5 : i64] : vector<8xi8>
          %101 = llvm.insertelement %93, %100[%4 : i64] : vector<8xi8>
          %102 = llvm.insertelement %94, %101[%3 : i64] : vector<8xi8>
          %103 = llvm.insertelement %95, %102[%2 : i64] : vector<8xi8>
          %104 = llvm.insertelement %96, %103[%1 : i64] : vector<8xi8>
          %105 = llvm.mul %40, %10 : i64
          %106 = llvm.mul %48, %19 : i64
          %107 = llvm.add %105, %106 : i64
          %108 = llvm.add %107, %23 : i64
          %109 = llvm.add %108, %23 : i64
          %110 = llvm.getelementptr %30[%109] : (!llvm.ptr, i64) -> !llvm.ptr, i8
          llvm.store %104, %110 {alignment = 1 : i64} : vector<8xi8>, !llvm.ptr
          %111 = llvm.add %46, %22 : i64
          llvm.br ^bb1(%111 : i64)
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
