#encoding = #iree_encoding.layout<[#iree_cpu.cpu_encoding_resolver<configuration = {encoding_info = {innerDimsPos = [], innerTileSizes = [], outerDimsPerm = []}}>]>
#executable_target_embedded_elf_riscv_64 = #hal.executable.target<"llvm-cpu", "embedded-elf-riscv_64", {cpu = "", cpu_features = "+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot", data_layout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128", iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = "lp64d", target_triple = "riscv64-unknown-unknown-eabi-elf", ukernels = "none"}>
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_local = #hal.device.target<"local", [#executable_target_embedded_elf_riscv_64]> : !hal.device
#encoding1 = #iree_encoding.encoding<operand_index = 0 : index, op_type =  matmul, element_types = [f8E4M3FN, f8E4M3FN, f16], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [32, 32, 64]>
#encoding2 = #iree_encoding.encoding<operand_index = 1 : index, op_type =  matmul, element_types = [f8E4M3FN, f8E4M3FN, f16], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [32, 32, 64]>
#encoding3 = #iree_encoding.encoding<operand_index = 2 : index, op_type =  matmul, element_types = [f8E4M3FN, f8E4M3FN, f16], user_indexing_maps = [#map, #map1, #map2], iteration_sizes = [32, 32, 64]>
module attributes {stream.affinity.default = #hal.device.affinity<@__device_0>} {
  util.global private @__device_0 = #device_target_local
  hal.executable private @matmul_fp8_dispatch_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @matmul_fp8_dispatch_0_matmul_32x32x64_f8E4M3FNxf8E4M3FNxf16 ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @matmul_fp8_dispatch_0_matmul_32x32x64_f8E4M3FNxf8E4M3FNxf16() {
          %cst = arith.constant 0.000000e+00 : f16
          %c0 = arith.constant 0 : index
          %c2048 = arith.constant 2048 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xf8E4M3FN, #encoding>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c2048) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xf8E4M3FN, #encoding>>
          %2 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xf16>>
          %3 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0], sizes = [32, 64], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xf8E4M3FN, #encoding>> -> tensor<32x64xf8E4M3FN, #encoding1>
          %4 = iree_tensor_ext.dispatch.tensor.load %1, offsets = [0, 0], sizes = [64, 32], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xf8E4M3FN, #encoding>> -> tensor<64x32xf8E4M3FN, #encoding2>
          %5 = tensor.empty() : tensor<32x32xf16, #encoding3>
          %6 = linalg.fill ins(%cst : f16) outs(%5 : tensor<32x32xf16, #encoding3>) -> tensor<32x32xf16, #encoding3>
          %7 = linalg.matmul ins(%3, %4 : tensor<32x64xf8E4M3FN, #encoding1>, tensor<64x32xf8E4M3FN, #encoding2>) outs(%6 : tensor<32x32xf16, #encoding3>) -> tensor<32x32xf16, #encoding3>
          %8 = iree_encoding.unset_encoding %7 : tensor<32x32xf16, #encoding3> -> tensor<32x32xf16>
          iree_tensor_ext.dispatch.tensor.store %8, %2, offsets = [0, 0], sizes = [32, 32], strides = [1, 1] : tensor<32x32xf16> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x32xf16>>
          return
        }
      }
    }
  }
  hal.executable private @_encoding_0 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_0_encode_32x64xf8E4M3FN_to_32x64xf8E4M3FN ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @_encoding_0_encode_32x64xf8E4M3FN_to_32x64xf8E4M3FN() {
          %c0 = arith.constant 0 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xf8E4M3FN>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x64xf8E4M3FN, #encoding>>
          %2 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0], sizes = [32, 64], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<32x64xf8E4M3FN>> -> tensor<32x64xf8E4M3FN>
          %3 = iree_encoding.set_encoding %2 : tensor<32x64xf8E4M3FN> -> tensor<32x64xf8E4M3FN, #encoding>
          iree_tensor_ext.dispatch.tensor.store %3, %1, offsets = [0, 0], sizes = [32, 64], strides = [1, 1] : tensor<32x64xf8E4M3FN, #encoding> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<32x64xf8E4M3FN, #encoding>>
          return
        }
      }
    }
  }
  hal.executable private @_encoding_1 {
    hal.executable.variant public @embedded_elf_riscv_64 target(#executable_target_embedded_elf_riscv_64) {
      hal.executable.export public @_encoding_1_encode_64x32xf8E4M3FN_to_64x32xf8E4M3FN ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @_encoding_1_encode_64x32xf8E4M3FN_to_64x32xf8E4M3FN() {
          %c0 = arith.constant 0 : index
          %c2048 = arith.constant 2048 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(64) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xf8E4M3FN>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(64) offset(%c2048) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<64x32xf8E4M3FN, #encoding>>
          %2 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [0, 0], sizes = [64, 32], strides = [1, 1] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<64x32xf8E4M3FN>> -> tensor<64x32xf8E4M3FN>
          %3 = iree_encoding.set_encoding %2 : tensor<64x32xf8E4M3FN> -> tensor<64x32xf8E4M3FN, #encoding>
          iree_tensor_ext.dispatch.tensor.store %3, %1, offsets = [0, 0], sizes = [64, 32], strides = [1, 1] : tensor<64x32xf8E4M3FN, #encoding> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<64x32xf8E4M3FN, #encoding>>
          return
        }
      }
    }
  }
  util.func public @matmul_fp8(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_fp8(%input0: tensor<32x64xf8E4M3FN>, %input1: tensor<64x32xf8E4M3FN>) -> (%output0: tensor<32x32xf16>)"}} {
    %c4096 = arith.constant 4096 : index
    %c0 = arith.constant 0 : index
    %c2048 = arith.constant 2048 : index
    %c64 = arith.constant 64 : index
    %c32 = arith.constant 32 : index
    %element_type_f8E4M3FN = hal.element_type<f8E4M3FN> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([%c32, %c64]) type(%element_type_f8E4M3FN) encoding(%dense_row_major)
    %0 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg0 : !hal.buffer_view -> tensor<32x64xf8E4M3FN> in !stream.resource<external>{%c2048}
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([%c64, %c32]) type(%element_type_f8E4M3FN) encoding(%dense_row_major)
    %1 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg1 : !hal.buffer_view -> tensor<64x32xf8E4M3FN> in !stream.resource<external>{%c2048}
    %result, %result_timepoint = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<external>{%c2048} => !stream.timepoint
    %result_0, %result_timepoint_1 = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<transient>{%c4096} => !stream.timepoint
    %2 = stream.timepoint.join max(%result_timepoint, %result_timepoint_1) => !stream.timepoint
    %3 = stream.cmd.execute on(#hal.device.affinity<@__device_0>) await(%2) => with(%0 as %arg2: !stream.resource<external>{%c2048}, %1 as %arg3: !stream.resource<external>{%c2048}, %result as %arg4: !stream.resource<external>{%c2048}, %result_0 as %arg5: !stream.resource<transient>{%c4096}) {
      stream.cmd.concurrent {
        stream.cmd.dispatch @_encoding_0::@embedded_elf_riscv_64::@_encoding_0_encode_32x64xf8E4M3FN_to_32x64xf8E4M3FN {
          ro %arg2[%c0 for %c2048] : !stream.resource<external>{%c2048},
          wo %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096}
        }
        stream.cmd.dispatch @_encoding_1::@embedded_elf_riscv_64::@_encoding_1_encode_64x32xf8E4M3FN_to_64x32xf8E4M3FN {
          ro %arg3[%c0 for %c2048] : !stream.resource<external>{%c2048},
          wo %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096}
        }
      }
      stream.cmd.dispatch @matmul_fp8_dispatch_0::@embedded_elf_riscv_64::@matmul_fp8_dispatch_0_matmul_32x32x64_f8E4M3FNxf8E4M3FNxf16 {
        ro %arg5[%c0 for %c4096] : !stream.resource<transient>{%c4096},
        wo %arg4[%c0 for %c2048] : !stream.resource<external>{%c2048}
      }
    } => !stream.timepoint
    %4 = stream.resource.dealloca on(#hal.device.affinity<@__device_0>) await(%3) => %result_0 : !stream.resource<transient>{%c4096} => !stream.timepoint
    %5 = stream.timepoint.await %4 => %result : !stream.resource<external>{%c2048}
    %6 = stream.tensor.export on(#hal.device.affinity<@__device_0>) %5 : tensor<32x32xf16> in !stream.resource<external>{%c2048} -> !hal.buffer_view
    util.return %6 : !hal.buffer_view
  }
}
