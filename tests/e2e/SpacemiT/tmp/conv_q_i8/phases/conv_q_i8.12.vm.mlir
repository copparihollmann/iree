module attributes {vm.toplevel} {
  vm.module public @module {
    vm.global.ref private mutable @__device_0 : !vm.ref<!hal.device>
    vm.global.ref private mutable @__device_0_executable_0_conv_q_i8_linked : !vm.ref<!hal.executable>
    vm.global.ref private mutable @__conv_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
    vm.rodata private @_utf8_hal_device_id_C6650FF277232B5A {alignment = 1 : i64} "hal.device.id"
    vm.rodata private @_utf8_local_1A8FF0278D7661D8 {alignment = 1 : i64} "local*"
    vm.rodata private @_utf8_hal_executable_format_E03EECB63A2AAF52 {alignment = 1 : i64} "hal.executable.format"
    vm.rodata private @_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5 {alignment = 1 : i64} "embedded-elf-riscv_64"
    vm.rodata private @conv_q_i8_linked_embedded_elf_riscv_64 {alignment = 16 : i64, mime_type = "application/x-elf"} dense<"0x7F454C460201010000000000000000000300F3000100000000000000000000004000000000000000D812000000000000050000004000380008004000160014000600000004000000400000000000000040000000000000004000000000000000C001000000000000C001000000000000080000000000000001000000040000000000000000000000000000000000000000000000000000003407000000000000340700000000000000100000000000000100000005000000340700000000000034170000000000003417000000000000A003000000000000A00300000000000000100000000000000100000006000000E00A000000000000E02A000000000000E02A0000000000002002000000000000200500000000000000100000000000000200000006000000400C000000000000402C000000000000402C000000000000C000000000000000C000000000000000080000000000000052E5746404000000E00A000000000000E02A000000000000E02A00000000000020020000000000002005000000000000010000000000000051E57464060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300007004000000D60F00000000000000000000000000000000000000000000D500000000000000D50000000000000001000000000000000000000000000000000000000000000000000000000000000100000012000700C01A000000000000140000000000000002000000020000000000000001000000000000000000000000697265655F68616C5F65786563757461626C655F6C6962726172795F7175657279000000000000E82A0000000000000300000000000000E004000000000000002B00000000000003000000000000003417000000000000082B0000000000000300000000000000D618000000000000102B0000000000000300000000000000421A000000000000202B0000000000000300000000000000C005000000000000282B0000000000000300000000000000F405000000000000302B00000000000003000000000000002D06000000000000482B00000000000003000000000000005506000000000000582B00000000000003000000000000005506000000000000682B00000000000003000000000000005506000000000000782B00000000000003000000000000006806000000000000802B00000000000003000000000000006806000000000000902B00000000000003000000000000006806000000000000982B00000000000003000000000000006806000000000000A82B00000000000003000000000000006806000000000000B02B00000000000003000000000000006806000000000000C02B0000000000000300000000000000E02A000000000000E02B0000000000000300000000000000002B000000000000E82B00000000000003000000000000000005000000000000002C0000000000000300000000000000202B000000000000182C0000000000000300000000000000402B000000000000202C0000000000000300000000000000702B0000000000008FE3388EE3388EE30000000000000000000000000000000000000000000000000000040008000C000100050009000D00020006000A000E00030007000B000F000004080C1014181C0105090D1115191D02060A0E12161A1E03070B0F13171B1F636F6E765F715F69385F6C696E6B656400000000000000000000000000000000000000000000000000000002010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020100000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000201000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000636F6E765F69385F7175616E74697A65645F64697370617463685F305F67656E657269635F33327833327833783378385F693800636F6E765F69385F7175616E74697A65645F64697370617463685F315F6D61746D756C5F313032347831367837325F693878693878693332005F656E636F64696E675F305F656E636F64655F37327831367869385F746F5F373278313678693800636F6E765F715F69382E6D6C697200000000001000000000000000017A5200017801011B0C02004800000018000000B0100000A201000000420EC00158810188029203930494059506960797089809990A9A0B9B0C420C0800036A010C02C00158C1C8D2D3D4D5D6D7D8D9DADB420E000000002800000064000000061200006C01000000420E104481018802420C0800035C010C021044C1C8420E000000002400000090000000461300007E00000000420E104481018802420C0800026E0C021044C1C8420E0010000000B80000009C130000140000000000000000000000317106FD22F94AF54EF152ED56E95AE55EE1E2FCE6F8EAF4EEF08001137101FC014583B8050203630600AC0097F2FFFF930090030D48935613009377130093936600139EC6001396F60013979700329E1396C700598E1397A6009E06BA93BA96139777009207D98F1E977296A543B389F60083BE080003BF02D2AA031EEC83B88800B383EE00931613001203F19A36E8937F0301338EC800014B2AFC42662A9613195600220632994EF872F01EF4814D3306FB01931236004A96B2924E8C728A9E8A014713961D006E96B38BC2006286D28C568DB336E6038D8213935600A20636939400EA8703C507002380A60085068507E39AB6FEB386EB00B3B7E60393DE5700819B93982E009D8EA20EB3861641F697B3861602B38767409982E69793F6860FBE969C0003C5070085072380A6008506E39AB7FE0507210D938C0C020506E31A07F9850D938A0A11130A0A060D0CE3990DF7050BA103130E0E12A5094145E317ABF462750505A273938303116266027E329EC279938909121146E31EC5F00145130104F4EA704A742A798A796A6ACA6A2A6B8A6B667CC67C267D867D29618280411106E422E000088142887183650600496E577072CD5737005E13030002C143930E001217F6FFFF93068E00130666BA577088CC8757060213D6250013F835001317560022069317B8003A961317E8005D8F1C6183388500F19922088A053305F600AE983E97B307C5013695130F850013060501130E0004814557F000CC5734E09E5738E09E5735E09E5736E09EB386B700577004CD87860602B306B50087880602B306BF0007890602B306B60087890602B306B7005734023B5735C23A93850502577082CD07F60602577018CD5734A43A5770700C5739343BD736143B5770030CD736283B2B34C6E2577002CD5738823E577012CD5735843E5736863EE398D5F9939522008502577016C95734A43AC295577018CD5734C63A9A055785873AC695577002CD5738A23E577012CD5734A43E5736A63E577072CD27E505029386050427E80602938605089385050C27E4060227E6050213070712E39FC2F10145130104FFA260026441018280411106E422E0000888710C423796E338C146130696E30216186108659397050233B6C702059293173600918D9D9D931726003E97939775003E9793070002577004CD0764D70A97F6FFFF4967938686A357F0070C878406029316560022063696329596052E95578584323A95270505020145130104FFA2600264410182806935971500003335A0009385E50F7D156D8D8280000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000E0000000000000000000000010000000E0000000000000000000000010000000E0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001E000000000000000800000000000000FBFFFF6F000000000100000000000000070000000000000070020000000000000800000000000000100200000000000009000000000000001800000000000000F9FFFF6F000000001600000000000000060000000000000000020000000000000B000000000000001800000000000000050000000000000048020000000000000A0000000000000023000000000000000400000000000000300200000000000000000000000000000000000000000000011101250E1305030E1017B44219110112060000022E001101120640186E0E030E3A0B3B0B49133F190000032400030E3E0B0B0B0000042E001101120640186E0E030E3A0B3B0B49103F190000004700000004000000000008019B0000002C0099000000000000003417000000000000A2010000023417000000000000A201000001580000000000000000010143000000036D0000000504004000000004000000000008019B0000002C00990000004E000000D6180000000000006C01000004D6180000000000006C01000001583400000034000000010143000000004000000004000000000008019B0000002C009900000093000000421A0000000000007E00000004421A0000000000007E0000000158710000007100000001014300000000636F6E765F69385F7175616E74697A65645F64697370617463685F305F67656E657269635F33327833327833783378385F693800636F6E765F69385F7175616E74697A65645F64697370617463685F315F6D61746D756C5F313032347831367837325F69387869387869333200696E74005F656E636F64696E675F305F656E636F64655F37327831367869385F746F5F3732783136786938002D004952454500460000000200000000004B00000026000000636F6E765F69385F7175616E74697A65645F64697370617463685F305F67656E657269635F33327833327833783378385F693800000000004B00000002004B0000004400000026000000636F6E765F69385F7175616E74697A65645F64697370617463685F315F6D61746D756C5F313032347831367837325F69387869387869333200000000003A00000002008F00000044000000260000005F656E636F64696E675F305F656E636F64655F37327831367869385F746F5F37327831367869380000000000160000000200000000004B00000043000000696E7400000000000E00000002004B00000044000000000000000E00000002008F000000440000000000000041D400000072697363760001CA00000004100572763634693270315F6D3270305F613270315F663270325F643270325F633270305F763170305F7A696373723270305F7A6D6D756C3170305F7A61616D6F3170305F7A616C7273633170305F7A63613170305F7A63643170305F7A76653332663170305F7A76653332783170305F7A76653634643170305F7A76653634663170305F7A76653634783170305F7A766C313238623170305F7A766C323536623170305F7A766C3332623170305F7A766C3634623170305F78736D7476646F74317030004A000000040019000000010101FB0E0D000101010100000001000001002D000000000000090234170000000000000105010A0222120602761106023C130608FF08E5024E112F0B08AC022000010141000000040019000000010101FB0E0D000101010100000001000001002D0000000000000902D6180000000000000105010A9E06026E11060859060B02D20112020C00010139000000040019000000010101FB0E0D000101010100000001000001002D0000000000000902421A0000000000000105010A82060B026A12020C00010149524545000000000000000000000000000000000000000000000000002300000000020900402C00000000000000000000000000000100000012000700C01A0000000000001400000000000000002E64796E73796D002E68617368002E64796E737472002E72656C612E64796E002E726F64617461002E65685F6672616D65002E74657874002E646174612E72656C2E726F002E64796E616D6963002E72656C726F5F70616464696E67002E64656275675F616262726576002E64656275675F696E666F002E64656275675F737472002E64656275675F7075626E616D6573002E64656275675F7075627479706573002E72697363762E61747472696275746573002E64656275675F6C696E65002E636F6D6D656E74002E73796D746162002E7368737472746162002E7374727461620000697265655F68616C5F65786563757461626C655F6C6962726172795F7175657279005F44594E414D49430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000B0000000200000000000000000200000000000000020000000000003000000000000000030000000100000008000000000000001800000000000000090000000500000002000000000000003002000000000000300200000000000018000000000000000100000000000000040000000000000004000000000000000F000000030000000200000000000000480200000000000048020000000000002300000000000000000000000000000001000000000000000000000000000000170000000400000002000000000000007002000000000000700200000000000010020000000000000100000000000000080000000000000018000000000000002100000001000000120000000000000080040000000000008004000000000000E8010000000000000000000000000000200000000000000000000000000000002900000001000000020000000000000068060000000000006806000000000000CC000000000000000000000000000000080000000000000000000000000000003300000001000000060000000000000034170000000000003407000000000000A00300000000000000000000000000000200000000000000000000000000000039000000010000000300000000000000E02A000000000000E00A000000000000600100000000000000000000000000001000000000000000000000000000000046000000060000000300000000000000402C000000000000400C000000000000C0000000000000000300000000000000080000000000000010000000000000004F000000080000000300000000000000002D000000000000000D00000000000000030000000000000000000000000000010000000000000000000000000000005E0000000100000000000000000000000000000000000000000D0000000000004E000000000000000000000000000000010000000000000000000000000000006C00000001000000000000000000000000000000000000004E0D000000000000D300000000000000000000000000000001000000000000000000000000000000780000000100000030000000000000000000000000000000210E000000000000A000000000000000000000000000000001000000000000000100000000000000830000000100000000000000000000000000000000000000C10E000000000000D700000000000000000000000000000001000000000000000000000000000000930000000100000000000000000000000000000000000000980F0000000000003E00000000000000000000000000000001000000000000000000000000000000A30000000300007000000000000000000000000000000000D60F000000000000D500000000000000000000000000000001000000000000000000000000000000B50000000100000000000000000000000000000000000000AB10000000000000D000000000000000000000000000000001000000000000000000000000000000C100000001000000300000000000000000000000000000007B110000000000000500000000000000000000000000000001000000000000000100000000000000CA000000020000000000000000000000000000000000000080110000000000004800000000000000150000000200000008000000000000001800000000000000D20000000300000000000000000000000000000000000000C811000000000000E400000000000000000000000000000001000000000000000000000000000000DC0000000300000000000000000000000000000000000000AC120000000000002C00000000000000000000000000000001000000000000000000000000000000"> : vector<6232xi8>
    vm.func private @__conv_i8_quantized_memoize_apply() -> !vm.ref<!hal.command_buffer> attributes {inlining_policy = #util.inline.never, vm.unwind} {
      %c13 = vm.const.i32 13
      %c28 = vm.const.i32 28
      %c36 = vm.const.i32 36
      %c2 = vm.const.i32 2
      %null = vm.const.ref.zero : !vm.ref<!hal.buffer>
      %c1 = vm.const.i32 1
      %c16 = vm.const.i32 16
      %c4 = vm.const.i32 4
      %c3 = vm.const.i32 3
      %zero = vm.const.i32.zero
      %c65536 = vm.const.i64 65536
      %c1152 = vm.const.i64 1152
      %c74880 = vm.const.i64 74880
      %c9248 = vm.const.i64 9248
      %zero_0 = vm.const.i64.zero
      %c-1 = vm.const.i64 -1
      %__device_0 = vm.global.load.ref @__device_0 : !vm.ref<!hal.device>
      %__device_0_executable_0_conv_q_i8_linked = vm.global.load.ref @__device_0_executable_0_conv_q_i8_linked : !vm.ref<!hal.executable>
      %ref = vm.call @hal.command_buffer.create(%__device_0, %zero, %c3, %c-1, %c4) : (!vm.ref<!hal.device>, i32, i32, i64, i32) -> !vm.ref<!hal.command_buffer>
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_conv_q_i8_linked, %zero, %c16, %c1, %c1, %zero_0, [], [(%zero, %zero, %null, %zero_0, %c9248), (%zero, %c3, %null, %zero_0, %c74880)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_conv_q_i8_linked, %c2, %c36, %c1, %c1, %zero_0, [], [(%zero, %c1, %null, %zero_0, %c1152), (%zero, %c3, %null, %zero_0, %c74880)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call @hal.command_buffer.execution_barrier(%ref, %c28, %c13, %zero_0) : (!vm.ref<!hal.command_buffer>, i32, i32, i64) -> ()
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_conv_q_i8_linked, %c1, %c16, %c1, %c1, %zero_0, [], [(%zero, %c3, %null, %zero_0, %c74880), (%zero, %c2, %null, %zero_0, %c65536)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
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
    vm.func private @conv_i8_quantized(%arg0: !vm.ref<!hal.buffer_view>, %arg1: !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer_view> attributes {iree.reflection = {iree.abi.declaration = "sync func @conv_i8_quantized(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}, vm.unwind, vm.yield} {
      %c268435488 = vm.const.i32 268435488
      %c16 = vm.const.i32 16
      %c1 = vm.const.i32 1
      %c268435464 = vm.const.i32 268435464
      %c3075 = vm.const.i32 3075
      %c48 = vm.const.i32 48
      %c1_0 = vm.const.i64 1
      %c34 = vm.const.i64 34
      %c8 = vm.const.i64 8
      %c3 = vm.const.i64 3
      %c16_1 = vm.const.i64 16
      %c9248 = vm.const.i64 9248
      %c1152 = vm.const.i64 1152
      %zero = vm.const.i64.zero
      %c65536 = vm.const.i64 65536
      %c74880 = vm.const.i64 74880
      %c-1 = vm.const.i64 -1
      %null = vm.const.ref.zero : !vm.ref<!hal.fence>
      %c-1_2 = vm.const.i32 -1
      %c32 = vm.const.i64 32
      %__device_0 = vm.global.load.ref @__device_0 : !vm.ref<!hal.device>
      %__conv_i8_quantized_memoize_result_0_device_0 = vm.global.load.ref @__conv_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
      %_utf8_input0_DCE99660CEB3F6B = vm.const.ref.rodata @_utf8_input0_DCE99660CEB3F6B : !vm.buffer
      vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input0_DCE99660CEB3F6B, %c268435464, %c1, [%c1_0, %c34, %c34, %c8]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
      %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
      %ref_3 = vm.call @hal.device.allocator(%__device_0) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
      %_utf8_tensor_FC1814BC4A58F22A = vm.const.ref.rodata @_utf8_tensor_FC1814BC4A58F22A : !vm.buffer
      vm.call @hal.buffer.assert(%ref, %_utf8_tensor_FC1814BC4A58F22A, %ref_3, %c9248, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
      %_utf8_input1_B898B726583C85DA = vm.const.ref.rodata @_utf8_input1_B898B726583C85DA : !vm.buffer
      vm.call.variadic @hal.buffer_view.assert(%arg1, %_utf8_input1_B898B726583C85DA, %c268435464, %c1, [%c3, %c3, %c8, %c16_1]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
      %ref_4 = vm.call @hal.buffer_view.buffer(%arg1) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
      vm.call @hal.buffer.assert(%ref_4, %_utf8_tensor_FC1814BC4A58F22A, %ref_3, %c1152, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
      %ref_5 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      %ref_6 = vm.call @hal.device.queue.alloca(%__device_0, %c-1, %null, %ref_5, %zero, %c48, %c3075, %c65536, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i64, i32, i32, i64, i64) -> !vm.ref<!hal.buffer>
      %ref_7 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      %ref_8 = vm.call @hal.device.queue.alloca(%__device_0, %c-1, %null, %ref_7, %zero, %c48, %c3075, %c74880, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i64, i32, i32, i64, i64) -> !vm.ref<!hal.buffer>
      %ref_9 = vm.call.variadic @hal.fence.join(%zero, [%ref_5, %ref_7]) {nosideeffects} : (i64, !vm.ref<!hal.fence> ...) -> !vm.ref<!hal.fence>
      %ref_10 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      vm.call.variadic @hal.device.queue.execute.indirect(%__device_0, %c-1, %ref_9, %ref_10, %__conv_i8_quantized_memoize_result_0_device_0, %zero, [(%ref, %zero, %c9248), (%ref_4, %zero, %c1152), (%ref_6, %zero, %c65536), (%ref_8, %zero, %c74880)]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer>, i64, tuple<!vm.ref<!hal.buffer>, i64, i64> ...)
      %ref_11 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      vm.call @hal.device.queue.dealloca(%__device_0, %c-1, %ref_10, %ref_11, %ref_8, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.buffer>, i64) -> ()
      vm.call.variadic.yieldable @hal.fence.await(%c-1_2, %zero, %ref_11) {segment_sizes = dense<[-1, -1, 1]> : vector<3xi16>, segment_types = [i32, i64, !vm.ref<!hal.fence>]} : (i32, i64, !vm.ref<!hal.fence>) -> ^bb1 (i32)
    ^bb1(%0: i32):  // pred: ^bb0
      vm.cond_br %0, ^bb3, ^bb2
    ^bb2:  // pred: ^bb1
      %ref_12 = vm.call.variadic @hal.buffer_view.create(%ref_6, %zero, %c65536, %c268435488, %c1, [%c1_0, %c32, %c32, %c16_1]) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
      vm.return %ref_12 : !vm.ref<!hal.buffer_view>
    ^bb3:  // pred: ^bb1
      vm.discard.refs %ref_6 : !vm.ref<!hal.buffer>
      vm.fail %0, "failed to wait on timepoint"
    }
    vm.export @conv_i8_quantized attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @conv_i8_quantized(%input0: tensor<1x34x34x8xi8>, %input1: tensor<3x3x8x16xi8>) -> (%output0: tensor<1x32x32x16xi32>)"}}
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
      vm.fail %c18, "HAL device `__device_0` not found or unavailable: #hal.device.target<\22local\22, [#hal.executable.target<\22llvm-cpu\22, \22embedded-elf-riscv_64\22, {cpu = \22\22, cpu_features = \22+m,+a,+f,+d,+c,+v,+zvl256b,+xsmtvdot\22, data_layout = \22e-m:e-p:64:64-i64:64-i128:128-n32:64-S128\22, iree.encoding.resolver = #iree_cpu.cpu_encoding_resolver<>, max_stack_allocation_size = 32768 : i64, native_vector_size = 64 : i64, target_abi = \22lp64d\22, target_triple = \22riscv64-unknown-unknown-eabi-elf\22, ukernels = \22none\22}>]>"
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
      %conv_q_i8_linked_embedded_elf_riscv_64 = vm.const.ref.rodata @conv_q_i8_linked_embedded_elf_riscv_64 : !vm.buffer
      %ref_9 = vm.call @hal.executable.create(%4, %c-1, %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5_6, %conv_q_i8_linked_embedded_elf_riscv_64, %null) {nosideeffects} : (!vm.ref<!hal.device>, i64, !vm.buffer, !vm.buffer, !vm.buffer) -> !vm.ref<!hal.executable>
      vm.global.store.ref %ref_9, @__device_0_executable_0_conv_q_i8_linked : !vm.ref<!hal.executable>
      %ref_10 = vm.call @__conv_i8_quantized_memoize_apply() : () -> !vm.ref<!hal.command_buffer>
      vm.global.store.ref %ref_10, @__conv_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
      vm.return
    ^bb9:  // pred: ^bb7
      vm.discard.refs %null, %4, %_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5_6 : !vm.buffer, !vm.ref<!hal.device>, !vm.buffer
      vm.fail %c14, "HAL device `__device_0` does not support any variant of executable `conv_q_i8_linked`; available formats: [embedded-elf-riscv_64]"
    }
  }
}
