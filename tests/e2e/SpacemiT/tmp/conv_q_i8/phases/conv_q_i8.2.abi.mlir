module {
  util.func public @conv_i8_quantized(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @conv_i8_quantized(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}} {
    %c0_i32 = arith.constant 0 : i32
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<1x34x34x8xi8>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<3x3x8x16xi8>
    %2 = tensor.empty() : tensor<1x32x32x16xi32>
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x32x32x16xi32>) -> tensor<1x32x32x16xi32>
    %4 = linalg.conv_2d_nhwc_hwcf_q {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1, %c0_i32, %c0_i32 : tensor<1x34x34x8xi8>, tensor<3x3x8x16xi8>, i32, i32) outs(%3 : tensor<1x32x32x16xi32>) -> tensor<1x32x32x16xi32>
    %5 = hal.tensor.export %4 "output0" : tensor<1x32x32x16xi32> -> !hal.buffer_view
    util.return %5 : !hal.buffer_view
  }
}
