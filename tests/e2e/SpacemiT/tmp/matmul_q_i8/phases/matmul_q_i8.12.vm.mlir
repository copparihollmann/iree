module attributes {vm.toplevel} {
  vm.module public @module {
    vm.global.ref private mutable @__device_0 : !vm.ref<!hal.device>
    vm.global.ref private mutable @__device_0_executable_0_matmul_q_i8_linked : !vm.ref<!hal.executable>
    vm.global.ref private mutable @__matmul_i8_quantized_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
    vm.rodata private @_utf8_hal_device_id_C6650FF277232B5A {alignment = 1 : i64} "hal.device.id"
    vm.rodata private @_utf8_local_1A8FF0278D7661D8 {alignment = 1 : i64} "local*"
    vm.rodata private @_utf8_hal_executable_format_E03EECB63A2AAF52 {alignment = 1 : i64} "hal.executable.format"
    vm.rodata private @_utf8_embedded_elf_riscv_64_C3BA011E86B77EF5 {alignment = 1 : i64} "embedded-elf-riscv_64"
    vm.rodata private @matmul_q_i8_linked_embedded_elf_riscv_64 {alignment = 16 : i64, mime_type = "application/x-elf"} dense<"0x7F454C460201010000000000000000000300F30001000000000000000000000040000000000000000814000000000000050000004000380008004000160014000600000004000000400000000000000040000000000000004000000000000000C001000000000000C0010000000000000800000000000000010000000400000000000000000000000000000000000000000000000000000038080000000000003808000000000000001000000000000001000000050000003808000000000000381800000000000038180000000000007A020000000000007A0200000000000000100000000000000100000006000000C00A000000000000C02A000000000000C02A0000000000002002000000000000400500000000000000100000000000000200000006000000200C000000000000202C000000000000202C000000000000C000000000000000C000000000000000080000000000000052E5746404000000C00A000000000000C02A000000000000C02A00000000000020020000000000004005000000000000010000000000000051E574640600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000070040000007D1000000000000000000000000000000000000000000000D500000000000000D500000000000000010000000000000000000000000000000000000000000000000000000000000001000000120007009E1A000000000000140000000000000002000000020000000000000001000000000000000000000000697265655F68616C5F65786563757461626C655F6C6962726172795F7175657279000000000000C82A0000000000000300000000000000A004000000000000E02A00000000000003000000000000003818000000000000E82A00000000000003000000000000006019000000000000F02A0000000000000300000000000000CE19000000000000002B00000000000003000000000000008005000000000000082B0000000000000300000000000000B905000000000000102B0000000000000300000000000000E105000000000000282B00000000000003000000000000000906000000000000382B00000000000003000000000000009606000000000000482B00000000000003000000000000001007000000000000582B00000000000003000000000000009007000000000000602B00000000000003000000000000009007000000000000702B00000000000003000000000000009007000000000000782B00000000000003000000000000009007000000000000882B00000000000003000000000000009007000000000000902B00000000000003000000000000009007000000000000A02B0000000000000300000000000000C02A000000000000C02B0000000000000300000000000000E02A000000000000C82B0000000000000300000000000000C004000000000000E02B0000000000000300000000000000002B000000000000F82B0000000000000300000000000000202B000000000000002C0000000000000300000000000000502B0000000000000004080C1014181C0105090D1115191D02060A0E12161A1E03070B0F13171B1F6D61746D756C5F715F69385F6C696E6B656400000000000000000000000000000000000000000000000000020100000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000201000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000006D61746D756C5F69385F7175616E74697A65645F64697370617463685F305F6D61746D756C5F33327833327836345F693878693878693332005F656E636F64696E675F305F656E636F64655F33327836347869385F746F5F3332783634786938005F656E636F64696E675F315F656E636F64655F36347833327869385F746F5F3634783332786938002F73637261746368322F6167757374696E2F6D65726C696E2F74686972645F70617274792F697265655F6261722F74657374732F6532652F53706163656D69542F746D702F6D61746D756C5F715F69382F66696C65732F636F6E666967757265645F6D6F64756C655F6D61746D756C5F69385F7175616E74697A65645F64697370617463685F302E6D6C6972002F73637261746368322F6167757374696E2F6D65726C696E2F74686972645F70617274792F697265655F6261722F74657374732F6532652F53706163656D69542F746D702F6D61746D756C5F715F69382F66696C65732F636F6E666967757265645F6D6F64756C655F5F656E636F64696E675F302E6D6C6972002F73637261746368322F6167757374696E2F6D65726C696E2F74686972645F70617274792F697265655F6261722F74657374732F6532652F53706163656D69542F746D702F6D61746D756C5F715F69382F66696C65732F636F6E666967757265645F6D6F64756C655F5F656E636F64696E675F312E6D6C6972000000000000001000000000000000017A5200017801011B0C020028000000180000008C1000002801000000420E104481018802420C08000318010C021044C1C8420E000000002400000044000000881100006E00000000420E104481018802420C0800025E0C021044C1C8420E00240000006C000000CE110000D000000000420E104481018802420C080002C00C021044C1C8420E00100000009400000076120000140000000000000000000000411106E422E000088148887183650600577072CD5737005E930200024143130E001010610338850013D515008589131785009396A50026059A052E95B30EE60036962A981306F67F130F160025061305860093050601914301475734E09ED737E09E5735E09E5736E09EB387EE00B306EF00577004CD87860602B306E60007880602B306E50087880602B386E5005734F23A5735C23A1307070207860602577082CD87F70702577018CD5734A43A5770700CD738C43AD736043B57F0020CD736183B2B34D7E2577002CDD737823E577012CD5735843E5736863EE318C7F9939648008508130F0F101306061013050510C296577072CD27E4060213870608A767070213870610938606182765070227E6060293850510E39178F40145130104FFA260026441018280411106E422E00008887183650600106108659396D5039605E99213F705F0BA9636962E95577064CC0704060293050604930606081306060C13078500878405029305050107850602930685018705060227040502A704070227850502A78506020145130104FFA260026441018280411106E422E000088871836506001306000297F6FFFF938606AA5770060C0784060293D635009D8913972600939785003E971C610865A2069605B6953E972E95577052CC870407029305070293060704930707060785050293050708878505029305070A078605029305070C1307070E1305F57F878606020787070287870502577074C8D735C23A577052CC07060702577074C8D734A23A577076C8D735F43AD734D43A577078CCD735C63AD734E63A5770060CD734B83A570594320505270505020145130104FFA2600264410182806935971500003335A000938505107D156D8D82800000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000008C00000000000000000000000300000079000000000000000000000003000000790000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001E000000000000000800000000000000FBFFFF6F000000000100000000000000070000000000000070020000000000000800000000000000100200000000000009000000000000001800000000000000F9FFFF6F000000001600000000000000060000000000000000020000000000000B000000000000001800000000000000050000000000000048020000000000000A0000000000000023000000000000000400000000000000300200000000000000000000000000000000000000000000011101250E1305030E10171B0EB44219110112060000022E001101120640186E0E030E3A0B3B0B49133F190000032400030E3E0B0B0B0000042E001101120640186E0E030E3A0B3B0B49103F190000004B00000004000000000008013D0100002C0000000000000000003A000000381800000000000028010000023818000000000000280100000158910000009100000001014700000003360000000504004400000004000000000008013D0100002C00F2000000870000003A00000060190000000000006E0000000460190000000000006E0000000158CA000000CA000000010147000000004400000004000000000008013D0100002C0042010000EC0000003A000000CE19000000000000D000000004CE19000000000000D00000000158150100001501000001014700000000636F6E666967757265645F6D6F64756C655F6D61746D756C5F69385F7175616E74697A65645F64697370617463685F302E6D6C697200696E74002F73637261746368322F6167757374696E2F6D65726C696E2F74686972645F70617274792F697265655F6261722F74657374732F6532652F53706163656D69542F746D702F6D61746D756C5F715F69382F66696C6573006D61746D756C5F69385F7175616E74697A65645F64697370617463685F305F6D61746D756C5F33327833327836345F693878693878693332005F656E636F64696E675F305F656E636F64655F33327836347869385F746F5F333278363478693800636F6E666967757265645F6D6F64756C655F5F656E636F64696E675F302E6D6C6972005F656E636F64696E675F315F656E636F64655F36347833327869385F746F5F3634783332786938004952454500636F6E666967757265645F6D6F64756C655F5F656E636F64696E675F312E6D6C6972004B0000000200000000004F0000002A0000006D61746D756C5F69385F7175616E74697A65645F64697370617463685F305F6D61746D756C5F33327833327836345F69387869387869333200000000003A00000002004F000000480000002A0000005F656E636F64696E675F305F656E636F64655F33327836347869385F746F5F333278363478693800000000003A000000020097000000480000002A0000005F656E636F64696E675F315F656E636F64655F36347833327869385F746F5F36347833327869380000000000160000000200000000004F00000047000000696E7400000000000E00000002004F00000048000000000000000E000000020097000000480000000000000041D400000072697363760001CA00000004100572763634693270315F6D3270305F613270315F663270325F643270325F633270305F763170305F7A696373723270305F7A6D6D756C3170305F7A61616D6F3170305F7A616C7273633170305F7A63613170305F7A63643170305F7A76653332663170305F7A76653332783170305F7A76653634643170305F7A76653634663170305F7A76653634783170305F7A766C313238623170305F7A766C323536623170305F7A766C3332623170305F7A766C3634623170305F78736D7476646F74317030008300000004004D000000010101FB0E0D00010101010000000100000100636F6E666967757265645F6D6F64756C655F6D61746D756C5F69385F7175616E74697A65645F64697370617463685F302E6D6C6972000000000000090238180000000000000105080A030B9E3503790858304F06036D023001060313082002B00116060B2E020C0001016100000004003A000000010101FB0E0D00010101010000000100000100636F6E666967757265645F6D6F64756C655F5F656E636F64696E675F302E6D6C6972000000000000090260190000000000000105080A03098232462F31024E14060B2E020C0001016600000004003A000000010101FB0E0D00010101010000000100000100636F6E666967757265645F6D6F64756C655F5F656E636F64696E675F312E6D6C69720000000000000902CE190000000000000105080A030A823202280E2F31473102860114060B2E020C00010149524545000000000000000000000000000000000000000000000000000000002300000000020900202C000000000000000000000000000001000000120007009E1A0000000000001400000000000000002E64796E73796D002E68617368002E64796E737472002E72656C612E64796E002E726F64617461002E65685F6672616D65002E74657874002E646174612E72656C2E726F002E64796E616D6963002E72656C726F5F70616464696E67002E64656275675F616262726576002E64656275675F696E666F002E64656275675F737472002E64656275675F7075626E616D6573002E64656275675F7075627479706573002E72697363762E61747472696275746573002E64656275675F6C696E65002E636F6D6D656E74002E73796D746162002E7368737472746162002E7374727461620000697265655F68616C5F65786563757461626C655F6C6962726172795F7175657279005F44594E414D49430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000B0000000200000000000000000200000000000000020000000000003000000000000000030000000100000008000000000000001800000000000000090000000500000002000000000000003002000000000000300200000000000018000000000000000100000000000000040000000000000004000000000000000F00000003000000020000000000000048020000000000004802000000000000230000000000000000000000000000000100000000000000000000000000000017000000040000000200000000000000700200000000000070020000000000001002000000000000010000000000000008000000000000001800000000000000210000000100000012000000000000008004000000000000800400000000000010030000000000000000000000000000200000000000000000000000000000002900000001000000020000000000000090070000000000009007000000000000A80000000000000000000000000000000800000000000000000000000000000033000000010000000600000000000000381800000000000038080000000000007A0200000000000000000000000000000200000000000000000000000000000039000000010000000300000000000000C02A000000000000C00A000000000000600100000000000000000000000000001000000000000000000000000000000046000000060000000300000000000000202C000000000000200C000000000000C0000000000000000300000000000000080000000000000010000000000000004F000000080000000300000000000000E02C000000000000E00C00000000000020030000000000000000000000000000010000000000000000000000000000005E0000000100000000000000000000000000000000000000E00C00000000000050000000000000000000000000000000010000000000000000000000000000006C0000000100000000000000000000000000000000000000300D000000000000DF000000000000000000000000000000010000000000000000000000000000007800000001000000300000000000000000000000000000000F0E0000000000006501000000000000000000000000000001000000000000000100000000000000830000000100000000000000000000000000000000000000740F000000000000CB000000000000000000000000000000010000000000000000000000000000009300000001000000000000000000000000000000000000003F100000000000003E00000000000000000000000000000001000000000000000000000000000000A300000003000070000000000000000000000000000000007D10000000000000D500000000000000000000000000000001000000000000000000000000000000B5000000010000000000000000000000000000000000000052110000000000005601000000000000000000000000000001000000000000000000000000000000C10000000100000030000000000000000000000000000000A8120000000000000500000000000000000000000000000001000000000000000100000000000000CA0000000200000000000000000000000000000000000000B0120000000000004800000000000000150000000200000008000000000000001800000000000000D20000000300000000000000000000000000000000000000F812000000000000E400000000000000000000000000000001000000000000000000000000000000DC0000000300000000000000000000000000000000000000DC130000000000002C00000000000000000000000000000001000000000000000000000000000000"> : vector<6536xi8>
    vm.func private @__matmul_i8_quantized_memoize_apply() -> !vm.ref<!hal.command_buffer> attributes {inlining_policy = #util.inline.never, vm.unwind} {
      %c16 = vm.const.i32 16
      %c13 = vm.const.i32 13
      %c28 = vm.const.i32 28
      %c2 = vm.const.i32 2
      %null = vm.const.ref.zero : !vm.ref<!hal.buffer>
      %c64 = vm.const.i32 64
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
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_matmul_q_i8_linked, %c1, %c64, %c1, %c1, %zero_0, [], [(%zero, %zero, %null, %zero_0, %c2048), (%zero, %c3, %null, %zero_0, %c4096)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_matmul_q_i8_linked, %c2, %c64, %c1, %c1, %zero_0, [], [(%zero, %c1, %null, %zero_0, %c2048), (%zero, %c3, %null, %zero_0, %c4096)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call @hal.command_buffer.execution_barrier(%ref, %c28, %c13, %zero_0) : (!vm.ref<!hal.command_buffer>, i32, i32, i64) -> ()
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_matmul_q_i8_linked, %zero, %c16, %c1, %c1, %zero_0, [], [(%zero, %c3, %null, %zero_0, %c4096), (%zero, %c2, %null, %zero_0, %c4096)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
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
