module {
  util.func public @matmul_fp8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_fp8(%input0: tensor<32x64xf8E4M3FN>, %input1: tensor<64x32xf8E4M3FN>) -> (%output0: tensor<32x32xf16>)"}} {
    %cst = arith.constant 0.000000e+00 : f16
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<32x64xf8E4M3FN>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<64x32xf8E4M3FN>
    %2 = tensor.empty() : tensor<32x32xf16>
    %3 = linalg.fill ins(%cst : f16) outs(%2 : tensor<32x32xf16>) -> tensor<32x32xf16>
    %4 = linalg.matmul ins(%0, %1 : tensor<32x64xf8E4M3FN>, tensor<64x32xf8E4M3FN>) outs(%3 : tensor<32x32xf16>) -> tensor<32x32xf16>
    %5 = hal.tensor.export %4 "output0" : tensor<32x32xf16> -> !hal.buffer_view
    util.return %5 : !hal.buffer_view
  }
}
