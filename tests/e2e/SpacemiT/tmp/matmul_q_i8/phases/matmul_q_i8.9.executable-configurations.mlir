#config = #iree_cpu.lowering_config<vector_common_parallel = [1, 1, 4, 4]>
#config1 = #iree_cpu.lowering_config<distribution = [1, 4, 0, 0, 0, 0], vector_common_parallel = [1, 1, 0, 4, 4, 0], vector_reduction = [0, 0, 1, 0, 0, 8]>
#config2 = #iree_cpu.lowering_config<vector_common_parallel = [1, 1]>
#config3 = #iree_cpu.lowering_config<distribution = [1, 1], vector_common_parallel = [1, 1]>
#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#translation = #iree_codegen.translation_info<pipeline = Mmt4dTilingExpert>
#translation1 = #iree_codegen.translation_info<pipeline = CPUDataTiling>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @matmul_i8_quantized_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32() attributes {translation_info = #translation} {
          %c0_i32 = arith.constant 0 : i32
          %c0 = arith.constant 0 : index
          %c2048 = arith.constant 2048 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c2048) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>>
          %2 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
          %3 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0, 0, 0], sizes = [8, 8, 4, 8], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>> -> tensor<8x8x4x8xi8>
          %4 = iree_tensor_ext.dispatch.tensor.load %1, offsets = [0, 0, 0, 0], sizes = [8, 8, 4, 8], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<8x8x4x8xi8>> -> tensor<8x8x4x8xi8>
          %5 = tensor.empty() : tensor<8x8x4x4xi32>
          %6 = linalg.fill {lowering_config = #config} ins(%c0_i32 : i32) outs(%5 : tensor<8x8x4x4xi32>) -> tensor<8x8x4x4xi32>
          %7 = linalg.mmt4d {lowering_config = #config1} ins(%3, %4 : tensor<8x8x4x8xi8>, tensor<8x8x4x8xi8>) outs(%6 : tensor<8x8x4x4xi32>) -> tensor<8x8x4x4xi32>
          %8 = tensor.empty() : tensor<32x32xi32>
          %unpack = linalg.unpack %7 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [4, 4] into %8 {lowering_config = #config2} : tensor<8x8x4x4xi32> -> tensor<32x32xi32>
          iree_tensor_ext.dispatch.tensor.store %unpack, %2, offsets = [0, 0], sizes = [32, 32], strides = [1, 1] : tensor<32x32xi32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xi32>>
          return
        }
      }
    }
  }
  hal.executable private @_encoding_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_0_encode_32x64xi8_to_32x64xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @_encoding_0_encode_32x64xi8_to_32x64xi8() attributes {translation_info = #translation1} {
          %c0 = arith.constant 0 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xi8>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<8x8x4x8xi8>>
          %2 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0], sizes = [32, 64], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xi8>> -> tensor<32x64xi8>
          %3 = tensor.empty() : tensor<8x8x4x8xi8>
          %pack = linalg.pack %2 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [4, 8] into %3 {lowering_config = #config3} : tensor<32x64xi8> -> tensor<8x8x4x8xi8>
          iree_tensor_ext.dispatch.tensor.store %pack, %1, offsets = [0, 0, 0, 0], sizes = [8, 8, 4, 8], strides = [1, 1, 1, 1] : tensor<8x8x4x8xi8> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<8x8x4x8xi8>>
          return
        }
      }
    }
  }
  hal.executable private @_encoding_1 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_1_encode_64x32xi8_to_64x32xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @_encoding_1_encode_64x32xi8_to_64x32xi8() attributes {translation_info = #translation1} {
          %c0 = arith.constant 0 : index
          %c2048 = arith.constant 2048 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xi8>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c2048) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<8x8x4x8xi8>>
          %2 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0], sizes = [64, 32], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xi8>> -> tensor<64x32xi8>
          %3 = tensor.empty() : tensor<8x8x4x8xi8>
          %pack = linalg.pack %2 outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [4, 8] into %3 {lowering_config = #config3} : tensor<64x32xi8> -> tensor<8x8x4x8xi8>
          iree_tensor_ext.dispatch.tensor.store %pack, %1, offsets = [0, 0, 0, 0], sizes = [8, 8, 4, 8], strides = [1, 1, 1, 1] : tensor<8x8x4x8xi8> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<8x8x4x8xi8>>
          return
        }
      }
    }
  }
  util.func public @matmul_i8_quantized(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8_quantized(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}} {
    %c0 = arith.constant 0 : index
    %c4096 = arith.constant 4096 : index
    %c2048 = arith.constant 2048 : index
    %c64 = arith.constant 64 : index
    %c32 = arith.constant 32 : index
    %element_type_i8 = hal.element_type<i8> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([%c32, %c64]) type(%element_type_i8) encoding(%dense_row_major)
    %0 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg0 : !hal.buffer_view -> tensor<32x64xi8> in !stream.resource<external>{%c2048}
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([%c64, %c32]) type(%element_type_i8) encoding(%dense_row_major)
    %1 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg1 : !hal.buffer_view -> tensor<64x32xi8> in !stream.resource<external>{%c2048}
    %result, %result_timepoint = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<external>{%c4096} => !stream.timepoint
    %result_0, %result_timepoint_1 = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<transient>{%c4096} => !stream.timepoint
    %2 = stream.timepoint.join max(%result_timepoint, %result_timepoint_1) => !stream.timepoint
    %3 = stream.cmd.execute on(#hal.device.affinity<@__device_0>) await(%2) => with(%0 as %arg2: !stream.resource<external>{%c2048}, %1 as %arg3: !stream.resource<external>{%c2048}, %result as %arg4: !stream.resource<external>{%c4096}, %result_0 as %arg5: !stream.resource<transient>{%c4096}) {
      stream.cmd.concurrent {
        stream.cmd.dispatch @_encoding_0::@embedded_elf_riscv_64::@_encoding_0_encode_32x64xi8_to_32x64xi8 {
          ro %arg2[%c0 for %c2048] : !stream.resource<external>{%c2048},
          wo %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096}
        }
        stream.cmd.dispatch @_encoding_1::@embedded_elf_riscv_64::@_encoding_1_encode_64x32xi8_to_64x32xi8 {
          ro %arg3[%c0 for %c2048] : !stream.resource<external>{%c2048},
          wo %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096}
        }
      }
      stream.cmd.dispatch @matmul_i8_quantized_dispatch_0::@embedded_elf_riscv_64::@matmul_i8_quantized_dispatch_0_matmul_32x32x64_i8xi8xi32 {
        ro %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096},
        wo %arg4[%c0 for %c4096] : !stream.resource<external>{%c4096}
      }
    } => !stream.timepoint
    %4 = stream.resource.dealloca on(#hal.device.affinity<@__device_0>) await(%3) => %result_0 : !stream.resource<transient>{%c4096} => !stream.timepoint
    %5 = stream.timepoint.await %4 => %result : !stream.resource<external>{%c4096}
    %6 = stream.tensor.export on(#hal.device.affinity<@__device_0>) %5 : tensor<32x32xi32> in !stream.resource<external>{%c4096} -> !hal.buffer_view
    util.return %6 : !hal.buffer_view
  }
}
