module {
  util.func public @matmul_fp8(%arg0: tensor<32x64xf8E4M3FN>, %arg1: tensor<64x32xf8E4M3FN>) -> tensor<32x32xf16> {
    %cst = arith.constant 0.000000e+00 : f16
    %0 = tensor.empty() : tensor<32x32xf16>
    %1 = linalg.fill ins(%cst : f16) outs(%0 : tensor<32x32xf16>) -> tensor<32x32xf16>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<32x64xf8E4M3FN>, tensor<64x32xf8E4M3FN>) outs(%1 : tensor<32x32xf16>) -> tensor<32x32xf16>
    util.return %2 : tensor<32x32xf16>
  }
}
