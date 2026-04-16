module {
  util.func public @conv_i8(%arg0: tensor<1x34x34x8xi8>, %arg1: tensor<3x3x8x16xi8>) -> tensor<1x32x32x16xi32> {
    %c0_i32 = arith.constant 0 : i32
    %0 = tensor.empty() : tensor<1x32x32x16xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<1x32x32x16xi32>) -> tensor<1x32x32x16xi32>
    %2 = linalg.conv_2d_nhwc_hwcf {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<1x34x34x8xi8>, tensor<3x3x8x16xi8>) outs(%1 : tensor<1x32x32x16xi32>) -> tensor<1x32x32x16xi32>
    util.return %2 : tensor<1x32x32x16xi32>
  }
}
