#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d3, d2 + d4, d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3, d4, d5)>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  util.func public @conv_i8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @conv_i8(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}} {
    %c0_i32 = arith.constant 0 : i32
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<1x34x34x8xi8>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<3x3x8x16xi8>
    %2 = tensor.empty() : tensor<1x32x32x16xi32>
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x32x32x16xi32>) -> tensor<1x32x32x16xi32>
    %4 = tensor.empty() : tensor<1x32x32x3x3x8xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%0 : tensor<1x34x34x8xi8>) outs(%4 : tensor<1x32x32x3x3x8xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<1x32x32x3x3x8xi8>
    %collapsed = tensor.collapse_shape %5 [[0, 1, 2], [3, 4, 5]] : tensor<1x32x32x3x3x8xi8> into tensor<1024x72xi8>
    %collapsed_0 = tensor.collapse_shape %1 [[0, 1, 2], [3]] : tensor<3x3x8x16xi8> into tensor<72x16xi8>
    %collapsed_1 = tensor.collapse_shape %3 [[0, 1, 2], [3]] : tensor<1x32x32x16xi32> into tensor<1024x16xi32>
    %6 = linalg.matmul ins(%collapsed, %collapsed_0 : tensor<1024x72xi8>, tensor<72x16xi8>) outs(%collapsed_1 : tensor<1024x16xi32>) -> tensor<1024x16xi32>
    %expanded = tensor.expand_shape %6 [[0, 1, 2], [3]] output_shape [1, 32, 32, 16] : tensor<1024x16xi32> into tensor<1x32x32x16xi32>
    %7 = hal.tensor.export %expanded "output0" : tensor<1x32x32x16xi32> -> !hal.buffer_view
    util.return %7 : !hal.buffer_view
  }
}
