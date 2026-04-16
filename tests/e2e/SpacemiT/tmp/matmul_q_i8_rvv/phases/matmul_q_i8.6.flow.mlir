#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, link_ukernel_bitcode = false, loop_vectorization = true, max_stack_allocation_size = 32768 : i64, native_vector_size = 32 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
#encoding = #iree_encoding.encoding<operand_index = 0 : index, op_type =  matmul, element_types = [i8, i8, i32], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [32, 32, 64]>
#encoding1 = #iree_encoding.encoding<operand_index = 1 : index, op_type =  matmul, element_types = [i8, i8, i32], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [32, 32, 64]>
#encoding2 = #iree_encoding.encoding<operand_index = 2 : index, op_type =  matmul, element_types = [i8, i8, i32], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [32, 32, 64]>
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  flow.executable private @matmul_i8_quantized_dispatch_0 {
    flow.executable.export public @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 workgroups() -> (index, index, index) {
      %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(%arg0: !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xi8, #encoding>>, %arg1: !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xi8, #encoding1>>, %arg2: !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>) {
        %c0_i32 = arith.constant 0 : i32
        %0 = iree_tensor_ext.dispatch.tensor.load %arg0, offsets = [0, 0], sizes = [32, 64], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xi8, #encoding>> -> tensor<32x64xi8, #encoding>
        %1 = iree_tensor_ext.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [64, 32], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xi8, #encoding1>> -> tensor<64x32xi8, #encoding1>
        %2 = tensor.empty() : tensor<32x32xi32, #encoding2>
        %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<32x32xi32, #encoding2>) -> tensor<32x32xi32, #encoding2>
        %4 = linalg.matmul ins(%0, %1 : tensor<32x64xi8, #encoding>, tensor<64x32xi8, #encoding1>) outs(%3 : tensor<32x32xi32, #encoding2>) -> tensor<32x32xi32, #encoding2>
        %5 = iree_encoding.unset_encoding %4 : tensor<32x32xi32, #encoding2> -> tensor<32x32xi32>
        iree_tensor_ext.dispatch.tensor.store %5, %arg2, offsets = [0, 0], sizes = [32, 32], strides = [1, 1] : tensor<32x32xi32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
        return
      }
    }
  }
  util.func public @matmul_i8_quantized(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8_quantized(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}} {
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<32x64xi8>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<64x32xi8>
    %2 = flow.tensor.encode %0 : tensor<32x64xi8> -> tensor<32x64xi8, #encoding>
    %3 = flow.tensor.encode %1 : tensor<64x32xi8> -> tensor<64x32xi8, #encoding1>
    %4 = flow.dispatch @matmul_i8_quantized_dispatch_0::@matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(%2, %3) : (tensor<32x64xi8, #encoding>, tensor<64x32xi8, #encoding1>) -> tensor<32x32xi32>
    %5 = hal.tensor.export %4 "output0" : tensor<32x32xi32> -> !hal.buffer_view
    util.return %5 : !hal.buffer_view
  }
}
