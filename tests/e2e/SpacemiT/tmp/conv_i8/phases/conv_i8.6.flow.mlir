#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0 + d2, d1 + d3, d4)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
#encoding = #iree_encoding.encoding<operand_index = 0 : index, op_type =  matmul, element_types = [i8, i8, i32], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [1024, 16, 72]>
#encoding1 = #iree_encoding.encoding<operand_index = 1 : index, op_type =  matmul, element_types = [i8, i8, i32], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [1024, 16, 72]>
#encoding2 = #iree_encoding.encoding<operand_index = 2 : index, op_type =  matmul, element_types = [i8, i8, i32], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [1024, 16, 72]>
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  flow.executable private @conv_i8_dispatch_0 {
    flow.executable.export public @conv_i8_dispatch_0_generic_32x32x3x3x8_i8 workgroups() -> (index, index, index) {
      %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @conv_i8_dispatch_0_generic_32x32x3x3x8_i8(%arg0: !iree_tensor_ext.dispatch.tensor<readonly:tensor<34x34x8xi8>>, %arg1: !iree_tensor_ext.dispatch.tensor<writeonly:tensor<1024x72xi8, #encoding>>) {
        %0 = iree_tensor_ext.dispatch.tensor.load %arg0, offsets = [0, 0, 0], sizes = [34, 34, 8], strides = [1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<34x34x8xi8>> -> tensor<34x34x8xi8>
        %1 = tensor.empty() : tensor<32x32x3x3x8xi8>
        %2 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%0 : tensor<34x34x8xi8>) outs(%1 : tensor<32x32x3x3x8xi8>) {
        ^bb0(%in: i8, %out: i8):
          linalg.yield %in : i8
        } -> tensor<32x32x3x3x8xi8>
        %collapsed = tensor.collapse_shape %2 [[0, 1], [2, 3, 4]] : tensor<32x32x3x3x8xi8> into tensor<1024x72xi8>
        %3 = iree_encoding.set_encoding %collapsed : tensor<1024x72xi8> -> tensor<1024x72xi8, #encoding>
        iree_tensor_ext.dispatch.tensor.store %3, %arg1, offsets = [0, 0], sizes = [1024, 72], strides = [1, 1] : tensor<1024x72xi8, #encoding> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<1024x72xi8, #encoding>>
        return
      }
    }
  }
  flow.executable private @conv_i8_dispatch_1 {
    flow.executable.export public @conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32 workgroups() -> (index, index, index) {
      %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32(%arg0: !iree_tensor_ext.dispatch.tensor<readonly:tensor<1024x72xi8, #encoding>>, %arg1: !iree_tensor_ext.dispatch.tensor<readonly:tensor<72x16xi8, #encoding1>>, %arg2: !iree_tensor_ext.dispatch.tensor<writeonly:tensor<1024x16xi32>>) {
        %c0_i32 = arith.constant 0 : i32
        %0 = iree_tensor_ext.dispatch.tensor.load %arg0, offsets = [0, 0], sizes = [1024, 72], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<1024x72xi8, #encoding>> -> tensor<1024x72xi8, #encoding>
        %1 = iree_tensor_ext.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [72, 16], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<72x16xi8, #encoding1>> -> tensor<72x16xi8, #encoding1>
        %2 = tensor.empty() : tensor<1024x16xi32, #encoding2>
        %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1024x16xi32, #encoding2>) -> tensor<1024x16xi32, #encoding2>
        %4 = linalg.matmul ins(%0, %1 : tensor<1024x72xi8, #encoding>, tensor<72x16xi8, #encoding1>) outs(%3 : tensor<1024x16xi32, #encoding2>) -> tensor<1024x16xi32, #encoding2>
        %5 = iree_encoding.unset_encoding %4 : tensor<1024x16xi32, #encoding2> -> tensor<1024x16xi32>
        iree_tensor_ext.dispatch.tensor.store %5, %arg2, offsets = [0, 0], sizes = [1024, 16], strides = [1, 1] : tensor<1024x16xi32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<1024x16xi32>>
        return
      }
    }
  }
  util.func public @conv_i8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @conv_i8(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}} {
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<1x34x34x8xi8>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<3x3x8x16xi8>
    %2 = flow.tensor.reshape %0 : tensor<1x34x34x8xi8> -> tensor<34x34x8xi8>
    %3 = flow.dispatch @conv_i8_dispatch_0::@conv_i8_dispatch_0_generic_32x32x3x3x8_i8(%2) : (tensor<34x34x8xi8>) -> tensor<1024x72xi8, #encoding>
    %4 = flow.tensor.reshape %1 : tensor<3x3x8x16xi8> -> tensor<72x16xi8>
    %5 = flow.tensor.encode %4 : tensor<72x16xi8> -> tensor<72x16xi8, #encoding1>
    %6 = flow.dispatch @conv_i8_dispatch_1::@conv_i8_dispatch_1_matmul_1024x16x72_i8xi8xi32(%3, %5) : (tensor<1024x72xi8, #encoding>, tensor<72x16xi8, #encoding1>) -> tensor<1024x16xi32>
    %7 = flow.tensor.reshape %6 : tensor<1024x16xi32> -> tensor<1x32x32x16xi32>
    %8 = hal.tensor.export %7 "output0" : tensor<1x32x32x16xi32> -> !hal.buffer_view
    util.return %8 : !hal.buffer_view
  }
}
