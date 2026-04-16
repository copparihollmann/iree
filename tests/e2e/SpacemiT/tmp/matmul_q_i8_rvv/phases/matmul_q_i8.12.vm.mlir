module attributes {vm.toplevel} {
  vm.module public @module {
    vm.global.ref private mutable @__device_0 : !vm.ref<!hal.device>
    vm.global.ref private mutable @__device_0_executable_0_matmul_q_i8_linked : !vm.ref<!hal.executable>
    vm.global.ref private mutable @__matmul_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
    vm.rodata private @_utf8_hal_device_id_C6650FF277232B5A {alignment = 1 : i64} "hal.device.id"
    vm.rodata private @_utf8_local_1A8FF0278D7661D8 {alignment = 1 : i64} "local*"
    vm.rodata private @_utf8_hal_executable_format_E03EECB63A2AAF52 {alignment = 1 : i64} "hal.executable.format"
    vm.rodata private @_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5 {alignment = 1 : i64} "embedded-elf-riscv_64"
    vm.rodata private @matmul_q_i8_linked_embedded_elf_riscv_64 {alignment = 16 : i64, mime_type = "application/x-elf"} dense<"0x7F454C460201010000000000000000000300F30001000000000000000000000040000000000000006010000000000000050000004000380008004000160014000600000004000000400000000000000040000000000000004000000000000000C001000000000000C00100000000000008000000000000000100000004000000000000000000000000000000000000000000000000000000B806000000000000B80600000000000000100000000000000100000005000000B806000000000000B816000000000000B816000000000000DE01000000000000DE0100000000000000100000000000000100000006000000A008000000000000A028000000000000A0280000000000002002000000000000600700000000000000100000000000000200000006000000000A000000000000002A000000000000002A000000000000C000000000000000C000000000000000080000000000000052E5746404000000A008000000000000A028000000000000A02800000000000020020000000000006007000000000000010000000000000051E574640600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000070040000007E0D00000000000000000000000000000000000000000000C900000000000000C900000000000000010000000000000000000000000000000000000000000000000000000000000001000000120007008218000000000000140000000000000002000000020000000000000001000000000000000000000000697265655F68616C5F65786563757461626C655F6C6962726172795F7175657279000000000000A82800000000000003000000000000008004000000000000C0280000000000000300000000000000B816000000000000C8280000000000000300000000000000D817000000000000D02800000000000003000000000000003418000000000000E02800000000000003000000000000006005000000000000E82800000000000003000000000000009905000000000000F0280000000000000300000000000000C10500000000000008290000000000000300000000000000E90500000000000018290000000000000300000000000000E90500000000000028290000000000000300000000000000E90500000000000038290000000000000300000000000000100600000000000040290000000000000300000000000000100600000000000050290000000000000300000000000000100600000000000058290000000000000300000000000000100600000000000068290000000000000300000000000000100600000000000070290000000000000300000000000000100600000000000080290000000000000300000000000000A028000000000000A0290000000000000300000000000000C028000000000000A8290000000000000300000000000000A004000000000000C0290000000000000300000000000000E028000000000000D82900000000000003000000000000000029000000000000E029000000000000030000000000000030290000000000006D61746D756C5F715F69385F6C696E6B656400000000000000000000000000000000000000000000000000020100000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000201000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000006D61746D756C5F69385F7175616E74697A65645F64697370617463685F305F6D61746D756C5F33327833327836345F693878693878693332005F656E636F64696E675F305F656E636F64655F33327836347869385F746F5F3332783634786938005F656E636F64696E675F315F656E636F64655F36347833327869385F746F5F36347833327869380074657374732F6532652F53706163656D69542F6D61746D756C5F715F69382E6D6C6972000000001000000000000000017A5200017801011B0C020028000000180000008C1000002001000000420E104481018802420C08000310010C021044C1C8420E000000002400000044000000801100005C00000000420E104481018802420C0800024C0C021044C1C8420E00240000006C000000B41100004E00000000420E104481018802420C08007E0C021044C1C8420E00001000000094000000DA110000140000000000000000000000411106E422E00008887183650600577018CD5734005E14610338850093D2150093F815001397A800939792003697BE969307F77F8D061387170013831740573B005E573A005E5739005E5738005E5736005E5737005E5735005E5770700C070C070203C5D6FF83C5E6FF03C6F6FF83C70600D76C85EF57ED85EFD76D86EF57EE87EF03C5160083C5260003C6360083C74600D76E85EF57EF85EFD76F86EF4107D7E387EF5770800857A48CD6572B6DD757AA4DD757292ED757A80ED75726CFD657A7EFD657A5A3D6A106E31867F8AA029A0816984698276408021305080893050810276B05021305081827EA050293050820276905021305082827E8050293050830130608382766050227E70502276506020145130104FFA260026441018280411106E422E00008887183650600106114651395E50313D725008D899357A503131597009E05B6953E969386050813070004577064CCB307A6000784E70AB387A500A105278407020506E396D5FE0145130104FFA260026441018280411106E422E000088871836506001061086593D6650093F5F5031397A6009206939755009205BE963696577078CC07040602BA952E951305F57F0505270405020145130104FFA2600264410182806935971500003335A0009385C50F7D156D8D828000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000002300000000000000000000000100000023000000000000000000000001000000230000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001E000000000000000800000000000000FBFFFF6F000000000100000000000000070000000000000070020000000000000800000000000000100200000000000009000000000000001800000000000000F9FFFF6F000000001600000000000000060000000000000000020000000000000B000000000000001800000000000000050000000000000048020000000000000A0000000000000023000000000000000400000000000000300200000000000000000000000000000000000000000000011101250E1305030E1017B44219110112060000022E001101120640186E0E030E3A0B3B0B49133F190000032400030E3E0B0B0B0000042E001101120640186E0E030E3A0B3B0B49103F190000004700000004000000000008018F0000002C006500000000000000B8160000000000002001000002B816000000000000200100000158040000000400000001014300000003000000000504004000000004000000000008018F0000002C00650000003E000000D8170000000000005C00000004D8170000000000005C00000001583D0000003D000000010143000000004000000004000000000008018F0000002C00650000007B00000034180000000000004E0000000434180000000000004E0000000158670000006700000001014300000000696E74006D61746D756C5F69385F7175616E74697A65645F64697370617463685F305F6D61746D756C5F33327833327836345F693878693878693332005F656E636F64696E675F305F656E636F64655F33327836347869385F746F5F3332783634786938002D005F656E636F64696E675F315F656E636F64655F36347833327869385F746F5F36347833327869380049524545004B0000000200000000004B000000260000006D61746D756C5F69385F7175616E74697A65645F64697370617463685F305F6D61746D756C5F33327833327836345F69387869387869333200000000003A00000002004B00000044000000260000005F656E636F64696E675F305F656E636F64655F33327836347869385F746F5F333278363478693800000000003A00000002008F00000044000000260000005F656E636F64696E675F315F656E636F64655F36347833327869385F746F5F36347833327869380000000000160000000200000000004B00000043000000696E7400000000000E00000002004B00000044000000000000000E00000002008F000000440000000000000041C800000072697363760001BE00000004100572763634693270315F6D3270305F613270315F663270325F643270325F633270305F763170305F7A696373723270305F7A6D6D756C3170305F7A61616D6F3170305F7A616C7273633170305F7A63613170305F7A63643170305F7A76653332663170305F7A76653332783170305F7A76653634643170305F7A76653634663170305F7A76653634783170305F7A766C313238623170305F7A766C323536623170305F7A766C3332623170305F7A766C363462317030003A000000040019000000010101FB0E0D000101010100000001000001002D0000000000000902B8160000000000000105010A82060B028C0212020C00010139000000040019000000010101FB0E0D000101010100000001000001002D0000000000000902D8170000000000000105010A82060B024812020C00010139000000040019000000010101FB0E0D000101010100000001000001002D000000000000090234180000000000000105010A82060B023A12020C0001014952454500000000000000000000000000000000000000000000000000000000002300000000020900002A0000000000000000000000000000010000001200070082180000000000001400000000000000002E64796E73796D002E68617368002E64796E737472002E72656C612E64796E002E726F64617461002E65685F6672616D65002E74657874002E646174612E72656C2E726F002E64796E616D6963002E72656C726F5F70616464696E67002E64656275675F616262726576002E64656275675F696E666F002E64656275675F737472002E64656275675F7075626E616D6573002E64656275675F7075627479706573002E72697363762E61747472696275746573002E64656275675F6C696E65002E636F6D6D656E74002E73796D746162002E7368737472746162002E7374727461620000697265655F68616C5F65786563757461626C655F6C6962726172795F7175657279005F44594E414D49430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000B0000000200000000000000000200000000000000020000000000003000000000000000030000000100000008000000000000001800000000000000090000000500000002000000000000003002000000000000300200000000000018000000000000000100000000000000040000000000000004000000000000000F00000003000000020000000000000048020000000000004802000000000000230000000000000000000000000000000100000000000000000000000000000017000000040000000200000000000000700200000000000070020000000000001002000000000000010000000000000008000000000000001800000000000000210000000100000002000000000000008004000000000000800400000000000090010000000000000000000000000000100000000000000000000000000000002900000001000000020000000000000010060000000000001006000000000000A80000000000000000000000000000000800000000000000000000000000000033000000010000000600000000000000B816000000000000B806000000000000DE0100000000000000000000000000000200000000000000000000000000000039000000010000000300000000000000A028000000000000A008000000000000600100000000000000000000000000001000000000000000000000000000000046000000060000000300000000000000002A000000000000000A000000000000C0000000000000000300000000000000080000000000000010000000000000004F000000080000000300000000000000C02A000000000000C00A00000000000040050000000000000000000000000000010000000000000000000000000000005E0000000100000000000000000000000000000000000000C00A0000000000004E000000000000000000000000000000010000000000000000000000000000006C00000001000000000000000000000000000000000000000E0B000000000000D300000000000000000000000000000001000000000000000000000000000000780000000100000030000000000000000000000000000000E10B0000000000009400000000000000000000000000000001000000000000000100000000000000830000000100000000000000000000000000000000000000750C000000000000CB00000000000000000000000000000001000000000000000000000000000000930000000100000000000000000000000000000000000000400D0000000000003E00000000000000000000000000000001000000000000000000000000000000A300000003000070000000000000000000000000000000007E0D000000000000C900000000000000000000000000000001000000000000000000000000000000B50000000100000000000000000000000000000000000000470E000000000000B800000000000000000000000000000001000000000000000000000000000000C10000000100000030000000000000000000000000000000FF0E0000000000000500000000000000000000000000000001000000000000000100000000000000CA0000000200000000000000000000000000000000000000080F0000000000004800000000000000150000000200000008000000000000001800000000000000D20000000300000000000000000000000000000000000000500F000000000000E400000000000000000000000000000001000000000000000000000000000000DC000000030000000000000000000000000000000000000034100000000000002C00000000000000000000000000000001000000000000000000000000000000"> : vector<5600xi8>
    vm.func private @__matmul_i8_quantized_memoize_apply() -> !vm.ref<!hal.command_buffer> attributes {inlining_policy = #util.inline.never, vm.unwind} {
      %c8 = vm.const.i32 8
      %c13 = vm.const.i32 13
      %c28 = vm.const.i32 28
      %c128 = vm.const.i32 128
      %c2 = vm.const.i32 2
      %null = vm.const.ref.zero : !vm.ref<!hal.buffer>
      %c16 = vm.const.i32 16
      %c1 = vm.const.i32 1
      %c4 = vm.const.i32 4
      %c3 = vm.const.i32 3
      %zero = vm.const.i32.zero
      %c4096 = vm.const.i64 4096
      %c2048 = vm.const.i64 2048
      %zero_0 = vm.const.i64.zero
      %c-1 = vm.const.i64 -1
      %__device_0 = vm.global.load.ref @__device_0 : !vm.ref<!hal.device>
      %__device_0_executable_0_matmul_q_i8_linked = vm.global.load.ref @__device_0_executable_0_matmul_q_i8_linked : !vm.ref<!hal.executable>
      %ref = vm.call @hal.command_buffer.create(%__device_0, %zero, %c3, %c-1, %c4) : (!vm.ref<!hal.device>, i32, i32, i64, i32) -> !vm.ref<!hal.command_buffer>
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_matmul_q_i8_linked, %c1, %c16, %c1, %c1, %zero_0, [], [(%zero, %zero, %null, %zero_0, %c2048), (%zero, %c3, %null, %zero_0, %c4096)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_matmul_q_i8_linked, %c2, %c128, %c1, %c1, %zero_0, [], [(%zero, %c1, %null, %zero_0, %c2048), (%zero, %c3, %null, %zero_0, %c4096)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call @hal.command_buffer.execution_barrier(%ref, %c28, %c13, %zero_0) : (!vm.ref<!hal.command_buffer>, i32, i32, i64) -> ()
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_matmul_q_i8_linked, %zero, %c8, %c1, %c1, %zero_0, [], [(%zero, %c3, %null, %zero_0, %c4096), (%zero, %c2, %null, %zero_0, %c4096)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call @hal.command_buffer.execution_barrier(%ref, %c28, %c13, %zero_0) : (!vm.ref<!hal.command_buffer>, i32, i32, i64) -> ()
      vm.call @hal.command_buffer.finalize(%ref) : (!vm.ref<!hal.command_buffer>) -> ()
      vm.return %ref : !vm.ref<!hal.command_buffer>
    }
    vm.import private @hal.buffer.assert(%buffer : !vm.ref<!hal.buffer>, %message : !vm.buffer, %allocator : !vm.ref<!hal.allocator>, %minimum_length : i64, %memory_types : i32, %buffer_usage : i32)
    vm.import private @hal.buffer_view.create(%buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %source_length : i64, %element_type : i32, %encoding_type : i32, %shape : i64 ...) -> !vm.ref<!hal.buffer_view> attributes {nosideeffects}
    vm.import private @hal.buffer_view.assert(%buffer_view : !vm.ref<!hal.buffer_view>, %message : !vm.buffer, %element_type : i32, %encoding_type : i32, %shape : i64 ...)
    vm.import private @hal.buffer_view.buffer(%buffer_view : !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer> attributes {nosideeffects}
    vm.import private @hal.command_buffer.create(%device : !vm.ref<!hal.device>, %modes : i32, %command_categories : i32, %queue_affinity : i64, %binding_capacity : i32) -> !vm.ref<!hal.command_buffer> attributes {minimum_version = 6 : i32}
    vm.import private @hal.command_buffer.finalize(%command_buffer : !vm.ref<!hal.command_buffer>)
    vm.import private @hal.command_buffer.execution_barrier(%command_buffer : !vm.ref<!hal.command_buffer>, %source_stage_mask : i32, %target_stage_mask : i32, %flags : i64)
    vm.import private @hal.command_buffer.dispatch(%command_buffer : !vm.ref<!hal.command_buffer>, %executable : !vm.ref<!hal.executable>, %entry_point : i32, %workgroup_x : i32, %workgroup_y : i32, %workgroup_z : i32, %flags : i64, %constants : i32 ..., %bindings : tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
    vm.import private @hal.device.allocator(%device : !vm.ref<!hal.device>) -> !vm.ref<!hal.allocator> attributes {nosideeffects}
    vm.import private @hal.device.query.i64(%device : !vm.ref<!hal.device>, %category : !vm.buffer, %key : !vm.buffer) -> (i32, i64) attributes {nosideeffects}
    vm.import private @hal.device.queue.alloca(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %pool : i64, %memory_types : i32, %buffer_usage : i32, %allocation_size : i64, %flags : i64) -> !vm.ref<!hal.buffer>
    vm.import private @hal.device.queue.dealloca(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %buffer : !vm.ref<!hal.buffer>, %flags : i64)
    vm.import private @hal.device.queue.execute.indirect(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %command_buffer : !vm.ref<!hal.command_buffer>, %flags : i64, %binding_table : tuple<!vm.ref<!hal.buffer>, i64, i64> ...)
    vm.import private @hal.devices.count() -> i32 attributes {nosideeffects}
    vm.import private @hal.devices.get(%index : i32) -> !vm.ref<!hal.device> attributes {nosideeffects}
    vm.import private @hal.executable.create(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %executable_format : !vm.buffer, %executable_data : !vm.buffer, %constants : !vm.buffer) -> !vm.ref<!hal.executable> attributes {nosideeffects}
    vm.import private @hal.fence.create(%device : !vm.ref<!hal.device>, %flags : i64) -> !vm.ref<!hal.fence>
    vm.import private @hal.fence.join(%flags : i64, %fences : !vm.ref<!hal.fence> ...) -> !vm.ref<!hal.fence> attributes {nosideeffects}
    vm.import private @hal.fence.await(%timeout_millis : i32, %flags : i64, %fences : !vm.ref<!hal.fence> ...) -> i32 attributes {vm.yield}
    vm.rodata private @_utf8_input0_DCE99660CEB3F6B {alignment = 1 : i64} "input0"
    vm.rodata private @_utf8_tensor_FC1814BC4A58F22A {alignment = 1 : i64} "tensor"
    vm.rodata private @_utf8_input1_B898B726583C85DA {alignment = 1 : i64} "input1"
    vm.func private @matmul_i8_quantized(%arg0: !vm.ref<!hal.buffer_view>, %arg1: !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer_view> attributes {iree.reflection = {iree.abi.declaration = "sync func @matmul_i8_quantized(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}, vm.unwind, vm.yield} {
      %c268435488 = vm.const.i32 268435488
      %c16 = vm.const.i32 16
      %c1 = vm.const.i32 1
      %c268435464 = vm.const.i32 268435464
      %c3075 = vm.const.i32 3075
      %c48 = vm.const.i32 48
      %c32 = vm.const.i64 32
      %c64 = vm.const.i64 64
      %c2048 = vm.const.i64 2048
      %c4096 = vm.const.i64 4096
      %zero = vm.const.i64.zero
      %c-1 = vm.const.i64 -1
      %null = vm.const.ref.zero : !vm.ref<!hal.fence>
      %c-1_0 = vm.const.i32 -1
      %__device_0 = vm.global.load.ref @__device_0 : !vm.ref<!hal.device>
      %__matmul_i8_quantized_memoize_result_0_device_0 = vm.global.load.ref @__matmul_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
      %_utf8_input0_DCE99660CEB3F6B = vm.const.ref.rodata @_utf8_input0_DCE99660CEB3F6B : !vm.buffer
      vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input0_DCE99660CEB3F6B, %c268435464, %c1, [%c32, %c64]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
      %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
      %ref_1 = vm.call @hal.device.allocator(%__device_0) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
      %_utf8_tensor_FC1814BC4A58F22A = vm.const.ref.rodata @_utf8_tensor_FC1814BC4A58F22A : !vm.buffer
      vm.call @hal.buffer.assert(%ref, %_utf8_tensor_FC1814BC4A58F22A, %ref_1, %c2048, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
      %_utf8_input1_B898B726583C85DA = vm.const.ref.rodata @_utf8_input1_B898B726583C85DA : !vm.buffer
      vm.call.variadic @hal.buffer_view.assert(%arg1, %_utf8_input1_B898B726583C85DA, %c268435464, %c1, [%c64, %c32]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
      %ref_2 = vm.call @hal.buffer_view.buffer(%arg1) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
      vm.call @hal.buffer.assert(%ref_2, %_utf8_tensor_FC1814BC4A58F22A, %ref_1, %c2048, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
      %ref_3 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      %ref_4 = vm.call @hal.device.queue.alloca(%__device_0, %c-1, %null, %ref_3, %zero, %c48, %c3075, %c4096, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i64, i32, i32, i64, i64) -> !vm.ref<!hal.buffer>
      %ref_5 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      %ref_6 = vm.call @hal.device.queue.alloca(%__device_0, %c-1, %null, %ref_5, %zero, %c48, %c3075, %c4096, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i64, i32, i32, i64, i64) -> !vm.ref<!hal.buffer>
      %ref_7 = vm.call.variadic @hal.fence.join(%zero, [%ref_3, %ref_5]) {nosideeffects} : (i64, !vm.ref<!hal.fence> ...) -> !vm.ref<!hal.fence>
      %ref_8 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      vm.call.variadic @hal.device.queue.execute.indirect(%__device_0, %c-1, %ref_7, %ref_8, %__matmul_i8_quantized_memoize_result_0_device_0, %zero, [(%ref, %zero, %c2048), (%ref_2, %zero, %c2048), (%ref_4, %zero, %c4096), (%ref_6, %zero, %c4096)]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer>, i64, tuple<!vm.ref<!hal.buffer>, i64, i64> ...)
      %ref_9 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      vm.call @hal.device.queue.dealloca(%__device_0, %c-1, %ref_8, %ref_9, %ref_6, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.buffer>, i64) -> ()
      vm.call.variadic.yieldable @hal.fence.await(%c-1_0, %zero, %ref_9) {segment_sizes = dense<[-1, -1, 1]> : vector<3xi16>, segment_types = [i32, i64, !vm.ref<!hal.fence>]} : (i32, i64, !vm.ref<!hal.fence>) -> ^bb1 (i32)
    ^bb1(%0: i32):  // pred: ^bb0
      vm.cond_br %0, ^bb3, ^bb2
    ^bb2:  // pred: ^bb1
      %ref_10 = vm.call.variadic @hal.buffer_view.create(%ref_4, %zero, %c4096, %c268435488, %c1, [%c32, %c32]) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
      vm.return %ref_10 : !vm.ref<!hal.buffer_view>
    ^bb3:  // pred: ^bb1
      vm.discard.refs %ref_4 : !vm.ref<!hal.buffer>
      vm.fail %0, "failed to wait on timepoint"
    }
    vm.export @matmul_i8_quantized attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_i8_quantized(%input0: tensor<32x64xi8>, %input1: tensor<64x32xi8>) -> (%output0: tensor<32x32xi32>)"}}
    vm.export @__init
    vm.func private @__init() attributes {vm.unwind} {
      %c1 = vm.const.i32 1
      %null = vm.const.ref.zero : !vm.buffer
      %c14 = vm.const.i32 14
      %c-1 = vm.const.i64 -1
      %c18 = vm.const.i32 18
      %zero = vm.const.i32.zero
      %zero_0 = vm.const.i64.zero
      %c1_1 = vm.const.i64 1
      %null_2 = vm.const.ref.zero : !vm.ref<!hal.device>
      %0 = vm.call @hal.devices.count() {nosideeffects} : () -> i32
      %1 = vm.ext.i32.i64.s %0 : i32 -> i64
      vm.br ^bb1(%zero_0, %zero_0, %null_2 : i64, i64, !vm.ref<!hal.device>)
    ^bb1(%2: i64, %3: i64, %4: !vm.ref<!hal.device>):  // 2 preds: ^bb0, ^bb4
      %rnz = vm.cmp.nz.ref %4 : !vm.ref<!hal.device>
      %5 = vm.xor.i32 %rnz, %c1 : i32
      %slt = vm.cmp.lt.i64.s %2, %1 : i64
      %6 = vm.and.i32 %5, %slt : i32
      vm.cond_br %6, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      vm.discard.refs %4 : !vm.ref<!hal.device>
      %7 = vm.trunc.i64.i32 %2 : i64 -> i32
      %ref = vm.call @hal.devices.get(%7) {nosideeffects} : (i32) -> !vm.ref<!hal.device>
      %_utf8_hal_device_id_C6650FF277232B5A = vm.const.ref.rodata @_utf8_hal_device_id_C6650FF277232B5A : !vm.buffer
      %_utf8_local_1A8FF0278D7661D8 = vm.const.ref.rodata @_utf8_local_1A8FF0278D7661D8 : !vm.buffer
      %8:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_device_id_C6650FF277232B5A, %_utf8_local_1A8FF0278D7661D8) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
      %nz = vm.cmp.nz.i64 %8#1 : i64
      %9 = vm.select.i32 %8#0, %nz, %zero : i32
      vm.cond_br %9, ^bb3, ^bb4(%zero : i32)
    ^bb3:  // pred: ^bb2
      %_utf8_hal_executable_format_E03EECB63A2AAF52 = vm.const.ref.rodata @_utf8_hal_executable_format_E03EECB63A2AAF52 : !vm.buffer
      %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5 = vm.const.ref.rodata @_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5 : !vm.buffer
      %10:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_executable_format_E03EECB63A2AAF52, %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
      %nz_3 = vm.cmp.nz.i64 %10#1 : i64
      %11 = vm.select.i32 %10#0, %nz_3, %zero : i32
      vm.br ^bb4(%11 : i32)
    ^bb4(%12: i32):  // 2 preds: ^bb2, ^bb3
      %eq = vm.cmp.eq.i64 %3, %zero_0 : i64
      %13 = vm.select.i64 %12, %c1_1, %zero_0 : i64
      %14 = vm.add.i64 %3, %13 : i64
      %15 = vm.and.i32 %12, %eq : i32
      %ref_4 = vm.select.ref %15, %ref, %null_2 : !vm.ref<!hal.device>
      %16 = vm.add.i64 %2, %c1_1 : i64
      vm.br ^bb1(%16, %14, %ref_4 : i64, i64, !vm.ref<!hal.device>)
    ^bb5:  // pred: ^bb1
      vm.discard.refs %null_2 : !vm.ref<!hal.device>
      vm.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      vm.discard.refs %null, %4 : !vm.buffer, !vm.ref<!hal.device>
      vm.fail %c18, "HAL device `__device_0` not found or unavailable: #hal.device.target<\22local\22, [#hal.executable.target<\22llvm-cpu\22, \22embedded-elf-riscv_64\22, {cpu = \22\22, cpu_features = \22+m,+a,+f,+d,+c,+v,+zvl256b\22, data_layout = \22e-m:e-p:64:64-i64:64-i128:128-n32:64-S128\22, iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, link_ukernel_bitcode = false, loop_vectorization = true, max_stack_allocation_size = 32768 : i64, native_vector_size = 32 : i64, target_abi = \22lp64d\22, target_triple = \22riscv64-unknown-unknown-eabi-elf\22, ukernels = \22none\22}>]>"
    ^bb7:  // pred: ^bb5
      %_utf8_hal_executable_format_E03EECB63A2AAF52_5 = vm.const.ref.rodata @_utf8_hal_executable_format_E03EECB63A2AAF52 : !vm.buffer
      %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5_6 = vm.const.ref.rodata @_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5 : !vm.buffer
      %17:2 = vm.call @hal.device.query.i64(%4, %_utf8_hal_executable_format_E03EECB63A2AAF52_5, %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5_6) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
      %nz_7 = vm.cmp.nz.i64 %17#1 : i64
      %18 = vm.select.i32 %17#0, %nz_7, %zero : i32
      %19 = vm.select.i64 %18, %zero_0, %c-1 : i64
      %eq_8 = vm.cmp.eq.i64 %19, %zero_0 : i64
      vm.global.store.ref %4, @__device_0 : !vm.ref<!hal.device>
      vm.cond_br %eq_8, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %matmul_q_i8_linked_embedded_elf_riscv_64 = vm.const.ref.rodata @matmul_q_i8_linked_embedded_elf_riscv_64 : !vm.buffer
      %ref_9 = vm.call @hal.executable.create(%4, %c-1, %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5_6, %matmul_q_i8_linked_embedded_elf_riscv_64, %null) {nosideeffects} : (!vm.ref<!hal.device>, i64, !vm.buffer, !vm.buffer, !vm.buffer) -> !vm.ref<!hal.executable>
      vm.global.store.ref %ref_9, @__device_0_executable_0_matmul_q_i8_linked : !vm.ref<!hal.executable>
      %ref_10 = vm.call @__matmul_i8_quantized_memoize_apply() : () -> !vm.ref<!hal.command_buffer>
      vm.global.store.ref %ref_10, @__matmul_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
      vm.return
    ^bb9:  // pred: ^bb7
      vm.discard.refs %null, %4, %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5_6 : !vm.buffer, !vm.ref<!hal.device>, !vm.buffer
      vm.fail %c14, "HAL device `__device_0` does not support any variant of executable `matmul_q_i8_linked`; available formats: [embedded-elf-riscv_64]"
    }
  }
}
