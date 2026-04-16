func.func @matmul_i8_2048(
    %lhs: tensor<2048x2048xi8>, %rhs: tensor<2048x2048xi8>)
    -> tensor<2048x2048xi32> {
  %c0 = arith.constant 0 : i32
  %init = tensor.empty() : tensor<2048x2048xi32>
  %fill = linalg.fill ins(%c0 : i32) outs(%init : tensor<2048x2048xi32>) -> tensor<2048x2048xi32>
  %res = linalg.matmul ins(%lhs, %rhs : tensor<2048x2048xi8>, tensor<2048x2048xi8>) outs(%fill : tensor<2048x2048xi32>) -> tensor<2048x2048xi32>
  return %res : tensor<2048x2048xi32>
}
