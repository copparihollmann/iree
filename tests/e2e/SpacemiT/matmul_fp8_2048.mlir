func.func @matmul_fp8_2048(
    %lhs: tensor<2048x2048xf8E4M3FN>, %rhs: tensor<2048x2048xf8E4M3FN>)
    -> tensor<2048x2048xf16> {
  %c0 = arith.constant 0.0 : f16
  %init = tensor.empty() : tensor<2048x2048xf16>
  %fill = linalg.fill ins(%c0 : f16) outs(%init : tensor<2048x2048xf16>) -> tensor<2048x2048xf16>
  %res = linalg.matmul ins(%lhs, %rhs : tensor<2048x2048xf8E4M3FN>, tensor<2048x2048xf8E4M3FN>) outs(%fill : tensor<2048x2048xf16>) -> tensor<2048x2048xf16>
  return %res : tensor<2048x2048xf16>
}
