module {
  util.global private @__device_0 = #hal.device.target<"local", [#hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>]> : !hal.device
  hal.executable private @matmul_i8_quantized_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>) {
      hal.executable.export public @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 ordinal(0) layout(#hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32() attributes {translation_info = #iree_codegen.translation_info<pipeline = Mmt4dTilingExpert>} {
          %c0_i32 = arith.constant 0 : i32
          %c0 = arith.constant 0 : index
          %c2048 = arith.constant 2048 : index
          %0 = hal.interface.binding.subspan layout(<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>>
          %1 = hal.interface.binding.subspan layout(<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) binding(0) alignment(64) offset(%c2048) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>>
          %2 = hal.interface.binding.subspan layout(<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
          %3 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0, 0, 0], sizes = [8, 8, 4, 8], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>> -> tensor<8x8x4x8xi8>
          %4 = iree_tensor_ext.dispatch.tensor.load %1, offsets = [0, 0, 0, 0], sizes = [8, 8, 4, 8], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>> -> tensor<8x8x4x8xi8>
          %5 = tensor.empty() : tensor<8x8x4x4xi32>
          %6 = linalg.fill {lowering_config = #iree_cpu.lowering_config<vector_common_parallel = [1, 1, 4, 4]>} ins(%c0_i32 : i32) outs(%5 : tensor<8x8x4x4xi32>) -> tensor<8x8x4x4xi32>
          %7 = linalg.mmt4d {lowering_config = #iree_cpu.lowering_config<distribution = [1, 4, 0, 0, 0, 0], vector_common_parallel = [1, 1, 0, 4, 4, 0], vector_reduction = [0, 0, 1, 0, 0, 8]>} ins(%3, %4 : tensor<8x8x4x8xi8>, tensor<8x8x4x8xi8>) outs(%6 : tensor<8x8x4x4xi32>) -> tensor<8x8x4x4xi32>
          %8 = tensor.empty() : tensor<32x32xi32>
          %unpack = linalg.unpack %7 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [4, 4] into %8 {lowering_config = #iree_cpu.lowering_config<vector_common_parallel = [1, 1]>} : tensor<8x8x4x4xi32> -> tensor<32x32xi32>
          iree_tensor_ext.dispatch.tensor.store %unpack, %2, offsets = [0, 0], sizes = [32, 32], strides = [1, 1] : tensor<32x32xi32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
          return
        }
      }
    }
  }
  util.global private mutable @matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_buffer : !hal.buffer
  util.initializer {
    %device, %queue_affinity = hal.device.resolve on(#hal.device.affinity<@__device_0>) : !hal.device, i64
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    %memory_type = hal.memory_type<"DeviceVisible|DeviceLocal"> : i32
    %buffer_usage = hal.buffer_usage<"TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage"> : i32
    %c8192 = arith.constant 8192 : index
    %buffer = hal.allocator.allocate<%allocator : !hal.allocator> affinity(%queue_affinity) type(%memory_type) usage(%buffer_usage) : !hal.buffer{%c8192}
    util.global.store %buffer, @matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_buffer : !hal.buffer
    util.return
  }
  util.func public @matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32(%arg0: i32) attributes {iree.abi.stub, iree.reflection = {iree.benchmark = "dispatch"}} {
    %0 = arith.index_cast %arg0 : i32 to index
    %device, %queue_affinity = hal.device.resolve on(#hal.device.affinity<@__device_0>) : !hal.device, i64
    %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories(Dispatch) affinity(%queue_affinity) : !hal.command_buffer
    %matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_buffer = util.global.load @matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_buffer : !hal.buffer
    %c0 = arith.constant 0 : index
    %c4096 = arith.constant 4096 : index
    %workgroup_x, %workgroup_y, %workgroup_z = hal.executable.calculate_workgroups device(%device : !hal.device) target(@matmul_i8_quantized_dispatch_0::@embedded_elf_riscv_64::@matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32) : index, index, index
    %exe = hal.executable.lookup device(%device : !hal.device) executable(@matmul_i8_quantized_dispatch_0) : !hal.executable
    %ordinal = hal.executable.export.ordinal target(@matmul_i8_quantized_dispatch_0::@embedded_elf_riscv_64::@matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32) : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %0 step %c1 {
      hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%exe : !hal.executable)[%ordinal] workgroups([%workgroup_x, %workgroup_y, %workgroup_z]) bindings([
        (%matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_buffer : !hal.buffer)[%c0, %c4096], 
        (%matmul_i8_quantized_dispatch_0_embedded_elf_riscv_64_matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32_buffer : !hal.buffer)[%c4096, %c4096]
      ]) flags("None")
      hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|CommandRetire") target("CommandIssue|Dispatch") flags("None")
    }
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    %1 = util.null : !hal.fence
    %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    hal.device.queue.execute<%device : !hal.device> affinity(%queue_affinity) wait(%1) signal(%fence) commands(%cmd) flags("None")
    %c-1_i32 = arith.constant -1 : i32
    %status = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) flags("None") : i32
    util.status.check_ok %status, "failed to wait on timepoint"
    util.return
  }
}
