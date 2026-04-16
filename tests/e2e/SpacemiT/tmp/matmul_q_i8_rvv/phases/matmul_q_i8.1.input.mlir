module {
  util.func public @matmul_i8_quantized(%arg0: tensor<32x64xi8>, %arg1: tensor<64x32xi8>) -> tensor<32x32xi32> {
    %c0_i32 = arith.constant 0 : i32
    %0 = tensor.empty() : tensor<32x32xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<32x32xi32>) -> tensor<32x32xi32>
    %2 = linalg.quantized_matmul ins(%arg0, %arg1, %c0_i32, %c0_i32 : tensor<32x64xi8>, tensor<64x32xi8>, i32, i32) outs(%1 : tensor<32x32xi32>) -> tensor<32x32xi32>
    util.return %2 : tensor<32x32xi32>
  }
}
