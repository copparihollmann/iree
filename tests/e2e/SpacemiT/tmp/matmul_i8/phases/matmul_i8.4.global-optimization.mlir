#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  util.func public @matmul_i8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}} {
    %c0_i32 = arith.constant 0 : i32
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<32x64xi8>
    %1 = iree_tensor_ext.compute_barrier.start %0 : tensor<32x64xi8> -> tensor<32x64xi8>
    %2 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<64x32xi8>
    %3 = iree_tensor_ext.compute_barrier.start %2 : tensor<64x32xi8> -> tensor<64x32xi8>
    %4 = tensor.empty() : tensor<32x32xi32>
    %5 = linalg.fill ins(%c0_i32 : i32) outs(%4 : tensor<32x32xi32>) -> tensor<32x32xi32>
    %6 = linalg.matmul ins(%1, %3 : tensor<32x64xi8>, tensor<64x32xi8>) outs(%5 : tensor<32x32xi32>) -> tensor<32x32xi32>
    %7 = iree_tensor_ext.compute_barrier.end %6 : tensor<32x32xi32> -> tensor<32x32xi32>
    %8 = hal.tensor.export %7 "output0" : tensor<32x32xi32> -> !hal.buffer_view
    util.return %8 : !hal.buffer_view
  }
}
