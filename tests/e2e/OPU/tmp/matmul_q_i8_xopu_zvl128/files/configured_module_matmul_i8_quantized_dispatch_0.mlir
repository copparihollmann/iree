hal.executable public @matmul_i8_quantized_dispatch_0 {
  hal.executable.variant public @embedded_elf_riscv_64 target(<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl128b,+xopu", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, link_ukernel_bitcode = false, max_stack_allocation_size = 32768 : i64, native_vector_size = 16 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>) {
    hal.executable.export public @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 ordinal(0) layout(#hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) count(%arg0: !hal.device) -> (index, index, index) {
      %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
      hal.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32() attributes {translation_info = #iree_codegen.translation_info<pipeline = Mmt4dTilingExpert>} {
        %c0_i32 = arith.constant 0 : i32
        %c0 = arith.constant 0 : index
        %c2048 = arith.constant 2048 : index
        %0 = hal.interface.binding.subspan layout(<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<2x64x16x1xi8>>
        %1 = hal.interface.binding.subspan layout(<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) binding(0) alignment(64) offset(%c2048) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<2x64x16x1xi8>>
        %2 = hal.interface.binding.subspan layout(<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
        %3 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0, 0, 0], sizes = [2, 64, 16, 1], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<2x64x16x1xi8>> -> tensor<2x64x16x1xi8>
        %4 = iree_tensor_ext.dispatch.tensor.load %1, offsets = [0, 0, 0, 0], sizes = [2, 64, 16, 1], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<2x64x16x1xi8>> -> tensor<2x64x16x1xi8>
        %5 = tensor.empty() : tensor<2x2x16x16xi32>
        %6 = linalg.fill {lowering_config = #iree_cpu.lowering_config<vector_common_parallel = [1, 1, 16, 16]>} ins(%c0_i32 : i32) outs(%5 : tensor<2x2x16x16xi32>) -> tensor<2x2x16x16xi32>
        %7 = linalg.mmt4d {lowering_config = #iree_cpu.lowering_config<distribution = [1, 1, 0, 0, 0, 0], vector_common_parallel = [1, 1, 0, 16, 16, 0], vector_reduction = [0, 0, 1, 0, 0, 1]>} ins(%3, %4 : tensor<2x64x16x1xi8>, tensor<2x64x16x1xi8>) outs(%6 : tensor<2x2x16x16xi32>) -> tensor<2x2x16x16xi32>
        %8 = tensor.empty() : tensor<32x32xi32>
        %unpack = linalg.unpack %7 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [16, 16] into %8 {lowering_config = #iree_cpu.lowering_config<vector_common_parallel = [1, 1]>} : tensor<2x2x16x16xi32> -> tensor<32x32xi32>
        iree_tensor_ext.dispatch.tensor.store %unpack, %2, offsets = [0, 0], sizes = [32, 32], strides = [1, 1] : tensor<32x32xi32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
        return
      }
    }
  }
}
