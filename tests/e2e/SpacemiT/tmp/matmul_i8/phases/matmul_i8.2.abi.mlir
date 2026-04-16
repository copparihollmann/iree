module {
  util.func public @matmul_i8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}} {
    %c0_i32 = arith.constant 0 : i32
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<32x64xi8>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<64x32xi8>
    %2 = tensor.empty() : tensor<32x32xi32>
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<32x32xi32>) -> tensor<32x32xi32>
    %4 = linalg.matmul ins(%0, %1 : tensor<32x64xi8>, tensor<64x32xi8>) outs(%3 : tensor<32x32xi32>) -> tensor<32x32xi32>
    %5 = hal.tensor.export %4 "output0" : tensor<32x32xi32> -> !hal.buffer_view
    util.return %5 : !hal.buffer_view
  }
}
