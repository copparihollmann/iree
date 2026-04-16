func.func @matmul_fp8_f32(%lhs: tensor<32x64xf8E4M3FN>, %rhs: tensor<64x32xf8E4M3FN>) -> tensor<32x32xf32> {
  %c0 = arith.constant 0.0 : f32
  %init = tensor.empty() : tensor<32x32xf32>
  %fill = linalg.fill ins(%c0 : f32) outs(%init : tensor<32x32xf32>) -> tensor<32x32xf32>
  %res = linalg.matmul ins(%lhs, %rhs : tensor<32x64xf8E4M3FN>, tensor<64x32xf8E4M3FN>) outs(%fill : tensor<32x32xf32>) -> tensor<32x32xf32>
  return %res : tensor<32x32xf32>
}
