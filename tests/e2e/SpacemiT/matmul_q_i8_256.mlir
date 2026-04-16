func.func @matmul_i8_quantized(%lhs: tensor<256x256xi8>, %rhs: tensor<256x256xi8>) -> tensor<256x256xi32> {
  %c0 = arith.constant 0 : i32
  %lhs_zp = arith.constant 0 : i32
  %rhs_zp = arith.constant 0 : i32

  %init = tensor.empty() : tensor<256x256xi32>
  %fill = linalg.fill ins(%c0 : i32) outs(%init : tensor<256x256xi32>) -> tensor<256x256xi32>

  %res = linalg.quantized_matmul
    ins(%lhs, %rhs, %lhs_zp, %rhs_zp : tensor<256x256xi8>, tensor<256x256xi8>, i32, i32)
    outs(%fill : tensor<256x256xi32>) -> tensor<256x256xi32>

  return %res : tensor<256x256xi32>
}
