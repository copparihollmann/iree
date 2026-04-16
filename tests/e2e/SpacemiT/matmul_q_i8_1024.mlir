func.func @matmul_i8_quantized(%lhs: tensor<1024x1024xi8>, %rhs: tensor<1024x1024xi8>) -> tensor<1024x1024xi32> {
  %c0 = arith.constant 0 : i32
  %lhs_zp = arith.constant 0 : i32
  %rhs_zp = arith.constant 0 : i32
  %init = tensor.empty() : tensor<1024x1024xi32>
  %fill = linalg.fill ins(%c0 : i32) outs(%init : tensor<1024x1024xi32>) -> tensor<1024x1024xi32>
  %res = linalg.quantized_matmul
    ins(%lhs, %rhs, %lhs_zp, %rhs_zp : tensor<1024x1024xi8>, tensor<1024x1024xi8>, i32, i32)
    outs(%fill : tensor<1024x1024xi32>) -> tensor<1024x1024xi32>
  return %res : tensor<1024x1024xi32>
}
