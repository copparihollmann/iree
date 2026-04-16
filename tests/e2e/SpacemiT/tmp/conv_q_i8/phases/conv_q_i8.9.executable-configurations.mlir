#config = #iree_cpu.lowering_config<distribution = [4, 16, 3, 3, 8], vector_common_parallel = [1, 1, 1, 1, 8]>
#config1 = #iree_cpu.lowering_config<vector_common_parallel = [1, 1, 4, 4]>
#config2 = #iree_cpu.lowering_config<distribution = [1, 64, 0, 0, 0, 0], vector_common_parallel = [1, 1, 0, 4, 4, 0], vector_reduction = [0, 0, 1, 0, 0, 8]>
#config3 = #iree_cpu.lowering_config<vector_common_parallel = [1, 1]>
#config4 = #iree_cpu.lowering_config<distribution = [1, 1], vector_common_parallel = [1, 1]>
#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0 + d2, d1 + d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#translation = #iree_codegen.translation_info<pipeline = CPUDoubleTilingExpert>
#translation1 = #iree_codegen.translation_info<pipeline = Mmt4dTilingExpert>
#translation2 = #iree_codegen.translation_info<pipeline = CPUDataTiling>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @conv_i8_quantized_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @conv_i8_quantized_dispatch_0_generic_32x32x3x3x8_i8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @conv_i8_quantized_dispatch_0_generic_32x32x3x3x8_i8() attributes {translation_info = #translation} {
          %c0 = arith.constant 0 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<34x34x8xi8>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<256x9x4x8xi8>>
          %2 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0, 0], sizes = [34, 34, 8], strides = [1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<34x34x8xi8>> -> tensor<34x34x8xi8>
          %3 = tensor.empty() : tensor<32x32x3x3x8xi8>
          %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<34x34x8xi8>) outs(%3 : tensor<32x32x3x3x8xi8>) attrs =  {lowering_config = #config} {
          ^bb0(%in: i8, %out: i8):
            linalg.yield %in : i8
          } -> tensor<32x32x3x3x8xi8>
          %collapsed = tensor.collapse_shape %4 [[0, 1], [2, 3, 4]] : tensor<32x32x3x3x8xi8> into tensor<1024x72xi8>
          %5 = tensor.empty() : tensor<256x9x4x8xi8>
          %pack = linalg.pack %collapsed outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [4, 8] into %5 : tensor<1024x72xi8> -> tensor<256x9x4x8xi8>
          iree_tensor_ext.dispatch.tensor.store %pack, %1, offsets = [0, 0, 0, 0], sizes = [256, 9, 4, 8], strides = [1, 1, 1, 1] : tensor<256x9x4x8xi8> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<256x9x4x8xi8>>
          return
        }
      }
    }
  }
  hal.executable private @conv_i8_quantized_dispatch_1 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @conv_i8_quantized_dispatch_1_matmul_1024x16x72_i8xi8xi32 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @conv_i8_quantized_dispatch_1_matmul_1024x16x72_i8xi8xi32() attributes {translation_info = #translation1} {
          %c0_i32 = arith.constant 0 : i32
          %c0 = arith.constant 0 : index
          %c73728 = arith.constant 73728 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<256x9x4x8xi8>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c73728) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<4x9x4x8xi8>>
          %2 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<1024x16xi32>>
          %3 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0, 0, 0], sizes = [256, 9, 4, 8], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<256x9x4x8xi8>> -> tensor<256x9x4x8xi8>
          %4 = iree_tensor_ext.dispatch.tensor.load %1, offsets = [0, 0, 0, 0], sizes = [4, 9, 4, 8], strides = [1, 1, 1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<4x9x4x8xi8>> -> tensor<4x9x4x8xi8>
          %5 = tensor.empty() : tensor<4x256x4x4xi32>
          %6 = linalg.fill {lowering_config = #config1} ins(%c0_i32 : i32) outs(%5 : tensor<4x256x4x4xi32>) -> tensor<4x256x4x4xi32>
          %7 = linalg.mmt4d {lowering_config = #config2} ins(%4, %3 : tensor<4x9x4x8xi8>, tensor<256x9x4x8xi8>) outs(%6 : tensor<4x256x4x4xi32>) -> tensor<4x256x4x4xi32>
          %8 = tensor.empty() : tensor<1024x16xi32>
          %unpack = linalg.unpack %7 outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [4, 4] into %8 {lowering_config = #config3} : tensor<4x256x4x4xi32> -> tensor<1024x16xi32>
          iree_tensor_ext.dispatch.tensor.store %unpack, %2, offsets = [0, 0], sizes = [1024, 16], strides = [1, 1] : tensor<1024x16xi32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<1024x16xi32>>
          return
        }
      }
    }
  }
  hal.executable private @_encoding_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_0_encode_72x16xi8_to_72x16xi8 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @_encoding_0_encode_72x16xi8_to_72x16xi8() attributes {translation_info = #translation2} {
          %c0 = arith.constant 0 : index
          %c73728 = arith.constant 73728 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<72x16xi8>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c73728) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<4x9x4x8xi8>>
          %2 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0], sizes = [72, 16], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<72x16xi8>> -> tensor<72x16xi8>
          %3 = tensor.empty() : tensor<4x9x4x8xi8>
          %pack = linalg.pack %2 outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [4, 8] into %3 {lowering_config = #config4} : tensor<72x16xi8> -> tensor<4x9x4x8xi8>
          iree_tensor_ext.dispatch.tensor.store %pack, %1, offsets = [0, 0, 0, 0], sizes = [4, 9, 4, 8], strides = [1, 1, 1, 1] : tensor<4x9x4x8xi8> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<4x9x4x8xi8>>
          return
        }
      }
    }
  }
  util.func public @conv_i8_quantized(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @conv_i8_quantized(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}} {
    %c74880 = arith.constant 74880 : index
    %c65536 = arith.constant 65536 : index
    %c0 = arith.constant 0 : index
    %c1152 = arith.constant 1152 : index
    %c9248 = arith.constant 9248 : index
    %c16 = arith.constant 16 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c34 = arith.constant 34 : index
    %c1 = arith.constant 1 : index
    %element_type_i8 = hal.element_type<i8> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([%c1, %c34, %c34, %c8]) type(%element_type_i8) encoding(%dense_row_major)
    %0 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg0 : !hal.buffer_view -> tensor<1x34x34x8xi8> in !stream.resource<external>{%c9248}
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([%c3, %c3, %c8, %c16]) type(%element_type_i8) encoding(%dense_row_major)
    %1 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg1 : !hal.buffer_view -> tensor<3x3x8x16xi8> in !stream.resource<external>{%c1152}
    %result, %result_timepoint = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<external>{%c65536} => !stream.timepoint
    %result_0, %result_timepoint_1 = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<transient>{%c74880} => !stream.timepoint
    %2 = stream.timepoint.join max(%result_timepoint, %result_timepoint_1) => !stream.timepoint
    %3 = stream.cmd.execute on(#hal.device.affinity<@__device_0>) await(%2) => with(%0 as %arg2: !stream.resource<external>{%c9248}, %1 as %arg3: !stream.resource<external>{%c1152}, %result as %arg4: !stream.resource<external>{%c65536}, %result_0 as %arg5: !stream.resource<transient>{%c74880}) {
      stream.cmd.concurrent {
        stream.cmd.dispatch @conv_i8_quantized_dispatch_0::@embedded_elf_riscv_64::@conv_i8_quantized_dispatch_0_generic_32x32x3x3x8_i8 {
          ro %arg2[%c0 for %c9248] : !stream.resource<external>{%c9248},
          wo %arg5[%c0 for %c74880] : !stream.resource<transient>{%c74880}
        }
        stream.cmd.dispatch @_encoding_0::@embedded_elf_riscv_64::@_encoding_0_encode_72x16xi8_to_72x16xi8 {
          ro %arg3[%c0 for %c1152] : !stream.resource<external>{%c1152},
          wo %arg5[%c0 for %c74880] : !stream.resource<transient>{%c74880}
        }
      }
      stream.cmd.dispatch @conv_i8_quantized_dispatch_1::@embedded_elf_riscv_64::@conv_i8_quantized_dispatch_1_matmul_1024x16x72_i8xi8xi32 {
        ro %arg5[%c0 for %c74880] : !stream.resource<transient>{%c74880},
        wo %arg4[%c0 for %c65536] : !stream.resource<external>{%c65536}
      }
    } => !stream.timepoint
    %4 = stream.resource.dealloca on(#hal.device.affinity<@__device_0>) await(%3) => %result_0 : !stream.resource<transient>{%c74880} => !stream.timepoint
    %5 = stream.timepoint.await %4 => %result : !stream.resource<external>{%c65536}
    %6 = stream.tensor.export on(#hal.device.affinity<@__device_0>) %5 : tensor<1x32x32x16xi32> in !stream.resource<external>{%c65536} -> !hal.buffer_view
    util.return %6 : !hal.buffer_view
  }
}
