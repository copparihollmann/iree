// Copyright 2021 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/hal/local/loaders/embedded_elf_loader.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

#include "iree/hal/api.h"
#include "iree/hal/local/elf/elf_module.h"
#include "iree/hal/local/executable_format.h"
#include "iree/hal/local/executable_library.h"
#include "iree/hal/local/executable_library_util.h"
#include "iree/hal/local/executable_plugin_manager.h"
#include "iree/hal/local/loaders/merlin_debug_addresses.h"
#include "iree/hal/local/loaders/merlin_gemmini_counter.h"
#include "iree/hal/local/local_executable.h"

//===----------------------------------------------------------------------===//
// Merlin per-dispatch cycle log (minimal-overhead in-memory ring).
//
// Each entry is 24 bytes; a 256-entry ring covers any practical model and
// fits in ~6 KB of BSS. Recording is a tight inlined sequence: read the
// global index, store a 24-byte row, increment the index. No printf, no
// mutex, no fence (the caller already did a fence rw,rw to commit the
// preceding rdcycle/store ordering).
//
// main() in the Zephyr runner reads `merlin_dispatch_log` and
// `merlin_dispatch_log_count` after k_thread_join and prints once.
//===----------------------------------------------------------------------===//

/* 2026-05-22: bumped from 256 to 4096. yolov8n × scalar has 225 dispatches
 * and each can fan out to many workgroups (e.g. 25 for the 3136x32 elementwise
 * broadcast initializers), easily exceeding 256 (ord, wg) tuples. The ring
 * buffer is silently dropped on overflow → missing profile data. 4096 × 24
 * bytes = 96 KiB of BSS, well within our budget. */
#define MERLIN_DISPATCH_LOG_CAPACITY 4096

typedef struct {
  uint32_t ordinal;
  uint32_t wg_x;
  uint32_t wg_y;
  uint32_t wg_z;
  uint64_t cycles;
  int32_t ret;
  int32_t _pad;
} merlin_dispatch_log_entry_t;

__attribute__((visibility("default")))
merlin_dispatch_log_entry_t
    merlin_dispatch_log[MERLIN_DISPATCH_LOG_CAPACITY] = {0};

__attribute__((visibility("default")))
uint32_t merlin_dispatch_log_count = 0;

static inline void merlin_dispatch_log_record(uint32_t ordinal, uint32_t wg_x,
                                              uint32_t wg_y, uint32_t wg_z,
                                              uint64_t cycles, int ret) {
  uint32_t i = merlin_dispatch_log_count;
  if (i < MERLIN_DISPATCH_LOG_CAPACITY) {
    merlin_dispatch_log[i].ordinal = ordinal;
    merlin_dispatch_log[i].wg_x = wg_x;
    merlin_dispatch_log[i].wg_y = wg_y;
    merlin_dispatch_log[i].wg_z = wg_z;
    merlin_dispatch_log[i].cycles = cycles;
    merlin_dispatch_log[i].ret = (int32_t)ret;
    merlin_dispatch_log_count = i + 1;
  }
}

//===----------------------------------------------------------------------===//
// iree_hal_elf_executable_t
//===----------------------------------------------------------------------===//

typedef struct iree_hal_elf_executable_t {
  iree_hal_local_executable_t base;

  // Loaded ELF module.
  iree_elf_module_t module;

  // Name used for the file field in tracy and debuggers.
  iree_string_view_t identifier;

  // Queried metadata from the library.
  union {
    const iree_hal_executable_library_header_t** header;
    const iree_hal_executable_library_v0_t* v0;
  } library;
} iree_hal_elf_executable_t;

static const iree_hal_local_executable_vtable_t iree_hal_elf_executable_vtable;

static iree_status_t iree_hal_elf_executable_query_library(
    iree_hal_elf_executable_t* executable) {
  // Get the exported symbol used to get the library metadata.
  iree_hal_executable_library_query_fn_t query_fn = NULL;
  IREE_RETURN_IF_ERROR(iree_elf_module_lookup_export(
      &executable->module, IREE_HAL_EXECUTABLE_LIBRARY_EXPORT_NAME,
      (void**)&query_fn));

  // Query for a compatible version of the library.
  executable->library.header =
      (const iree_hal_executable_library_header_t**)iree_elf_call_p_ip(
          query_fn, IREE_HAL_EXECUTABLE_LIBRARY_VERSION_LATEST,
          &executable->base.environment);
  if (!executable->library.header) {
    return iree_make_status(
        IREE_STATUS_FAILED_PRECONDITION,
        "executable does not support this version of the runtime (%08X)",
        IREE_HAL_EXECUTABLE_LIBRARY_VERSION_LATEST);
  }
  const iree_hal_executable_library_header_t* header =
      *executable->library.header;

  // Ensure that if the library is built for a particular sanitizer that we also
  // were compiled with that sanitizer enabled.
  switch (header->sanitizer) {
    case IREE_HAL_EXECUTABLE_LIBRARY_SANITIZER_NONE:
      // Always safe even if the host has a sanitizer enabled; it just means
      // that we won't be able to catch anything from within the executable,
      // however checks outside will (often) still trigger when guard pages are
      // dirtied/etc.
      break;
    default:
      return iree_make_status(IREE_STATUS_UNAVAILABLE,
                              "executable requires sanitizer but they are not "
                              "yet supported with embedded libraries: %u",
                              (uint32_t)header->sanitizer);
  }

  executable->identifier = iree_make_cstring_view(header->name);
  executable->base.dispatch_attrs = executable->library.v0->exports.attrs;
  executable->base.dispatch_ptrs = executable->library.v0->exports.ptrs;
  return iree_ok_status();
}

static iree_status_t iree_hal_elf_executable_create(
    const iree_hal_executable_params_t* executable_params,
    const iree_hal_executable_import_provider_t import_provider,
    iree_allocator_t host_allocator, iree_hal_executable_t** out_executable) {
  IREE_ASSERT_ARGUMENT(executable_params);
  IREE_ASSERT_ARGUMENT(executable_params->executable_data.data &&
                       executable_params->executable_data.data_length);
  IREE_ASSERT_ARGUMENT(!executable_params->constant_count ||
                       executable_params->constants);
  IREE_ASSERT_ARGUMENT(out_executable);
  *out_executable = NULL;
  IREE_TRACE_ZONE_BEGIN(z0);

  // TODO(benvanik): rework this so that we load and query the library before
  // allocating so that we know the import count. Today since we allocate first
  // we need an additional allocation once we've seen the import table.
  iree_hal_elf_executable_t* executable = NULL;
  iree_host_size_t total_size = 0;
  iree_host_size_t constants_offset = 0;
  IREE_RETURN_AND_END_ZONE_IF_ERROR(
      z0, IREE_STRUCT_LAYOUT(sizeof(*executable), &total_size,
                             IREE_STRUCT_FIELD_ALIGNED(
                                 executable_params->constant_count, uint32_t,
                                 iree_alignof(uint32_t), &constants_offset)));
  IREE_RETURN_AND_END_ZONE_IF_ERROR(
      z0,
      iree_allocator_malloc(host_allocator, total_size, (void**)&executable));
  iree_hal_local_executable_initialize(&iree_hal_elf_executable_vtable,
                                       host_allocator, &executable->base);

  // Copy executable constants so we own them.
  if (executable_params->constant_count > 0) {
    uint32_t* target_constants =
        (uint32_t*)((uint8_t*)executable + constants_offset);
    memcpy(target_constants, executable_params->constants,
           executable_params->constant_count *
               sizeof(*executable_params->constants));
    executable->base.environment.constants = target_constants;
  }

  // Attempt to load the ELF module.
  iree_status_t status = iree_elf_module_initialize_from_memory(
      executable_params->executable_data, /*import_table=*/NULL, host_allocator,
      &executable->module);

  // Query metadata and get the entry point function pointers.
  if (iree_status_is_ok(status)) {
    status = iree_hal_elf_executable_query_library(executable);
  }

  // Resolve imports, if any.
  if (iree_status_is_ok(status)) {
    status = iree_hal_executable_library_initialize_imports(
        &executable->base.environment, import_provider,
        &executable->library.v0->imports,
        (iree_hal_executable_import_thunk_v0_t)iree_elf_thunk_i_ppp,
        host_allocator);
  }

  // Verify that the library matches the executable params.
  if (iree_status_is_ok(status)) {
    status = iree_hal_executable_library_verify(executable_params,
                                                executable->library.v0);
  }

  // Publish the executable sources with the tracing infrastructure.
  if (iree_status_is_ok(status)) {
    iree_hal_executable_library_publish_source_files(executable->library.v0);
  }

  if (iree_status_is_ok(status)) {
    *out_executable = (iree_hal_executable_t*)executable;
  } else {
    iree_hal_executable_release((iree_hal_executable_t*)executable);
  }
  IREE_TRACE_ZONE_END(z0);
  return status;
}

static void iree_hal_elf_executable_destroy(
    iree_hal_executable_t* base_executable) {
  iree_hal_elf_executable_t* executable =
      (iree_hal_elf_executable_t*)base_executable;
  iree_allocator_t host_allocator = executable->base.host_allocator;
  IREE_TRACE_ZONE_BEGIN(z0);

  iree_elf_module_deinitialize(&executable->module);

  iree_hal_executable_library_deinitialize_imports(
      &executable->base.environment, host_allocator);

  iree_hal_local_executable_deinitialize(
      (iree_hal_local_executable_t*)base_executable);
  iree_allocator_free(host_allocator, executable);

  IREE_TRACE_ZONE_END(z0);
}

static iree_status_t iree_hal_elf_executable_issue_call(
    iree_hal_local_executable_t* base_executable, iree_host_size_t ordinal,
    const iree_hal_executable_dispatch_state_v0_t* dispatch_state,
    const iree_hal_executable_workgroup_state_v0_t* workgroup_state,
    uint32_t worker_id) {
  iree_hal_elf_executable_t* executable =
      (iree_hal_elf_executable_t*)base_executable;
  const iree_hal_executable_library_v0_t* library = executable->library.v0;

  if (IREE_UNLIKELY(ordinal >= library->exports.count)) {
    return iree_make_status(IREE_STATUS_INVALID_ARGUMENT,
                            "entry point ordinal out of bounds");
  }

  IREE_HAL_EXECUTABLE_LIBRARY_CALL_TRACE_ZONE_BEGIN(z0, executable->identifier,
                                                    library, ordinal);
  IREE_HAL_EXECUTABLE_LIBRARY_CALL_HOOK_BEGIN(executable->identifier, library,
                                              ordinal);
#if defined(MERLIN_DISPATCH_DEBUG) && MERLIN_DISPATCH_DEBUG
  // Per-dispatch debug printouts. Compiled in only under
  // -DMERLIN_GEMMINI_COUNTERS=ON's sibling option MERLIN_DISPATCH_DEBUG=ON;
  // off by default. Two runtime globals further gate emission so the
  // harness can flip them on/off mid-run (e.g. skip warm-up):
  //   iree_merlin_dispatch_debug_enabled  -> [dn]/[entry]/[bcontent]/[dc]
  //   iree_merlin_binding_debug_enabled   -> [binding] alignment dump
  // On the first workgroup of a dispatch we emit "[dn] o=N sym=S
  // wg_count=X,Y,Z" so an offline parser can join the ordinal with the
  // source model_dispatch_decomposition table. After the call we emit
  // "[dc] o=N wg=x,y,z cyc=C ret=R" per workgroup.
  extern int iree_merlin_dispatch_debug_enabled;
  const bool dbg = iree_merlin_dispatch_debug_enabled;
  if (dbg && workgroup_state->workgroup_id_x == 0 &&
      workgroup_state->workgroup_id_y == 0 &&
      workgroup_state->workgroup_id_z == 0) {
    const char* sym = (library->exports.names != NULL)
                          ? library->exports.names[ordinal]
                          : "(unknown)";
    fprintf(stderr, "[dn] o=%zu sym=%s wg_count=%u,%u,%u\n", ordinal,
            sym ? sym : "(null)",
            dispatch_state->workgroup_count_x,
            dispatch_state->workgroup_count_y,
            dispatch_state->workgroup_count_z);
    fflush(stderr);
  }
  extern int iree_merlin_binding_debug_enabled;
  if (iree_merlin_binding_debug_enabled) {
    for (uint8_t i = 0; i < dispatch_state->binding_count; ++i) {
      uintptr_t p = (uintptr_t)dispatch_state->binding_ptrs[i];
      fprintf(stderr,
              "[binding] o=%zu i=%u ptr=%p mod128=%lu mod64=%lu mod16=%lu "
              "len=%lu\n",
              ordinal, i, dispatch_state->binding_ptrs[i],
              (unsigned long)(p & 0x7f), (unsigned long)(p & 0x3f),
              (unsigned long)(p & 0x0f),
              (unsigned long)dispatch_state->binding_lengths[i]);
    }
    fflush(stderr);
  }
#endif  // MERLIN_DISPATCH_DEBUG

  // Merlin Zephyr-on-FireSim correctness fences (separate from profiling).
  //
  // (1) Memory ordering barrier before entering the dispatch ELF.
  // Why: the CPU stages dispatch state and binding pointers into shared
  // memory just before calling here. Inside the ELF, the first RoCC k_MVIN
  // hands those pointers to Gemmini's DMA engine, which reads memory through
  // an independent port at the coherency point — NOT through the CPU's
  // store buffer. Without an explicit `fence rw,rw` the CPU's setup stores
  // can still be sitting in the store buffer when Gemmini's DMA starts, and
  // the accelerator either reads stale bytes or hangs waiting for data that
  // never arrives. Diagnosed 2026-05-14 on FireSimGemminiAndOPUShuttleConfig.
  //
  // (2) mstatus.VS = Dirty arm.
  // On hetero workloads where this hart's worker thread may have yielded
  // (k_mutex / k_msgq pend inside the IREE call chain → idle thread
  // context switch on this hart → mstatus restore dropped VS to Off
  // because Zephyr's CONFIG_RISCV_ISA_EXT_V=n means the kernel doesn't
  // track V state), we re-arm VS right before the dispatch entry. On
  // harts without V hardware (Shuttle hart 0 in the Gemmini bitstream)
  // the VS bits are WARL no-ops — safe.
  //
  // Per-dispatch cycle accounting is split into TWO fully independent modes
  // so they never contaminate each other's measurement:
  //   (1) MERLIN_PROFILE_CYCLES=1 — wraps every ELF call with rdcycle, sums
  //       into iree_merlin_cycles_per_ordinal[]. Used only for the OPU
  //       compute-share decomposition plot. Costs ~8 cycles of overhead
  //       per dispatch.
  //   (2) MERLIN_DISPATCH_DEBUG=1 — verbose per-workgroup [dc] print.
  //       Microtest use only; massive UART overhead.
  //   (default, neither macro set) — clean run: nothing here but the ELF
  //   call itself. Used for OPU-vs-RVV speedup measurement.
#if defined(__riscv) && (__riscv_xlen == 64)
  __asm__ volatile("csrs mstatus, %0" :: "r"(3UL << 9));
  __asm__ volatile("fence rw,rw" ::: "memory");
#endif
#if defined(MERLIN_DISPATCH_DEBUG) && MERLIN_DISPATCH_DEBUG
  // Phase-3 sub-dispatch debug: emit a marker line right before the
  // dispatch ELF jal, AND a sample of the first 16 bytes of every input
  // binding so we can see (a) the dispatch entered the ELF (vs hung in
  // the loader) and (b) input data is materialized (vs zero/garbage).
  // For a fixed ordinal list (Bug A subspan-offset diagnostic targets),
  // additionally dump 16 bytes at canonical probe offsets and clear the
  // matmul trace region with a sentinel so the post-call [mtrace] read
  // can confirm whether the compiler-emitted trace stores executed.
  if (dbg && workgroup_state->workgroup_id_x == 0 &&
      workgroup_state->workgroup_id_y == 0 &&
      workgroup_state->workgroup_id_z == 0) {
    // Dispatch ordinals covered by the Bug A bprobe + trace-clear path.
    // Tracks dronet's matmul dispatches and their immediate successors
    // (non-intermediate matmuls at 2,7,10,16,19,25,28,31,32; successors
    // 3,8,11,17,20,26,29,33; with_intermediate's 16-19 overlap). Refresh
    // when the model's dispatch ordering changes.
    static const uint32_t kBugAProbeOrdinals[] = {
        2,  3,  7,  8, 10, 11, 16, 17,
       18, 19, 20, 25, 26, 28, 29, 31, 32, 33,
    };
    bool is_bug_a_probe = false;
    for (size_t pi = 0; pi < sizeof(kBugAProbeOrdinals) /
                                 sizeof(kBugAProbeOrdinals[0]);
         ++pi) {
      if (ordinal == kBugAProbeOrdinals[pi]) {
        is_bug_a_probe = true;
        break;
      }
    }
    fprintf(stderr, "[entry] o=%zu about to jal dispatch ELF\n", ordinal);
    fflush(stderr);
    for (uint8_t i = 0; i < dispatch_state->binding_count; ++i) {
      const uint8_t *bp = (const uint8_t *)dispatch_state->binding_ptrs[i];
      const size_t bl = (size_t)dispatch_state->binding_lengths[i];
      if (bp == NULL || bl == 0) {
        fprintf(stderr, "[bcontent] o=%zu i=%u ptr=NULL/empty len=%zu\n",
                ordinal, i, bl);
      } else {
        const size_t n = bl < 16 ? bl : 16;
        unsigned long sum = 0;
        for (size_t k = 0; k < n; ++k) sum += bp[k];
        fprintf(stderr,
                "[bcontent] o=%zu i=%u ptr=%p len=%zu first16_sum=%lu "
                "bytes=%02x %02x %02x %02x %02x %02x %02x %02x "
                "%02x %02x %02x %02x %02x %02x %02x %02x\n",
                ordinal, i, bp, bl, sum,
                n>0?bp[0]:0,  n>1?bp[1]:0,  n>2?bp[2]:0,  n>3?bp[3]:0,
                n>4?bp[4]:0,  n>5?bp[5]:0,  n>6?bp[6]:0,  n>7?bp[7]:0,
                n>8?bp[8]:0,  n>9?bp[9]:0,  n>10?bp[10]:0,n>11?bp[11]:0,
                n>12?bp[12]:0,n>13?bp[13]:0,n>14?bp[14]:0,n>15?bp[15]:0);
        if (is_bug_a_probe) {
          static const size_t probe_offsets[] = {
              0, 2048, 2816, 4096, 4864, 6144, 18176};
          for (size_t pi = 0;
               pi < sizeof(probe_offsets) / sizeof(probe_offsets[0]); ++pi) {
            const size_t off = probe_offsets[pi];
            if (off + 16 > bl) continue;
            const uint8_t* q = bp + off;
            fprintf(stderr,
                    "[bprobe] o=%zu i=%u +%zu bytes=%02x %02x %02x %02x %02x %02x %02x %02x "
                    "%02x %02x %02x %02x %02x %02x %02x %02x\n",
                    ordinal, i, off,
                    q[0], q[1], q[2], q[3], q[4], q[5], q[6], q[7],
                    q[8], q[9], q[10], q[11], q[12], q[13], q[14], q[15]);
          }
          if (i == 0) {
            volatile uint64_t* trace =
                (volatile uint64_t*)MERLIN_DEBUG_MATMUL_TRACE_ADDR;
            for (int k = 0; k < 5; ++k)
              trace[k] = MERLIN_DEBUG_TRACE_CLEAR_SENTINEL;
          }
        }
      }
    }
    fflush(stderr);
  }
#endif  // MERLIN_DISPATCH_DEBUG
#if defined(MERLIN_PROFILE_CYCLES) && MERLIN_PROFILE_CYCLES
  uint64_t _c0 = 0, _c1 = 0;
#if defined(MERLIN_PROFILE_COUNTERS) && MERLIN_PROFILE_COUNTERS
  // Sample Gemmini's 8 counters BEFORE the rdcycle window so the
  // reported per-dispatch cycle count excludes counter-read RoCC
  // overhead. Each counter read is a RoCC custom-3 op (~10-20 cycles
  // through the RoCC pipeline); 8 reads pre + 8 reads post would add
  // ~150-300 cycles per dispatch, which dominates iteration deltas at
  // the 0.01% level. By moving the pre-reads outside the cycle window,
  // the `cycles=` total stays comparable to MERLIN_PROFILE_COUNTERS=0
  // builds within ~0.02% (just the 8 post-reads' contribution).
  uint32_t _ctr_pre[8];
  for (unsigned _i = 0; _i < 8; ++_i) _ctr_pre[_i] = merlin_gemmini_counter_read(_i);
#endif
#if defined(__riscv)
  __asm__ volatile("rdcycle %0" : "=r"(_c0));
#endif
  int ret = iree_elf_call_i_ppp(library->exports.ptrs[ordinal],
                                (void*)&base_executable->environment,
                                (void*)dispatch_state, (void*)workgroup_state);
#if defined(__riscv)
  __asm__ volatile("rdcycle %0" : "=r"(_c1));
#endif
  // Post-dispatch fence (matches the pre-dispatch fence above) so Gemmini's
  // DMA outputs are globally visible before subsequent CPU loads/stores.
#if defined(__riscv) && (__riscv_xlen == 64)
  __asm__ volatile("fence rw,rw" ::: "memory");
#endif
  extern uint64_t iree_merlin_cycles_per_ordinal[1024];
  extern uint64_t iree_merlin_wg_count_per_ordinal[1024];
  extern const char *iree_merlin_sym_per_ordinal[1024];
  extern uint32_t iree_merlin_max_ordinal_seen;
#if defined(MERLIN_PROFILE_COUNTERS) && MERLIN_PROFILE_COUNTERS
  extern uint64_t iree_merlin_counters_per_ordinal[1024][8];
#endif
  if (ordinal < 1024) {
    iree_merlin_cycles_per_ordinal[ordinal] += (_c1 - _c0);
    iree_merlin_wg_count_per_ordinal[ordinal] += 1;
    if (iree_merlin_sym_per_ordinal[ordinal] == NULL &&
        library->exports.names != NULL) {
      iree_merlin_sym_per_ordinal[ordinal] = library->exports.names[ordinal];
    }
    if (ordinal > iree_merlin_max_ordinal_seen) {
      iree_merlin_max_ordinal_seen = (uint32_t)ordinal;
    }
#if defined(MERLIN_PROFILE_COUNTERS) && MERLIN_PROFILE_COUNTERS
    for (unsigned _i = 0; _i < 8; ++_i) {
      uint32_t _post = merlin_gemmini_counter_read(_i);
      // Wrap-safe diff: counters are 32-bit; the post-pre cast handles
      // mid-dispatch wraparound for the small panel of cycle counters we
      // care about (LD/EX/ST cycles, plus stall events).
      iree_merlin_counters_per_ordinal[ordinal][_i] +=
          (uint64_t)(uint32_t)(_post - _ctr_pre[_i]);
    }
#endif
  }
  // 2026-05-24: merlin_dispatch_log_record() call removed from the hot
  // path. The 256-entry ring buffer was only consumed by the old
  // merlin_dispatch_dump() -> [disp] dump that we replaced with the
  // compact per-ordinal CYC dump (iree_merlin_cycles_per_ordinal is the
  // sufficient backing store). Saves ~20 cycles + 32 BSS bytes per
  // workgroup call.
#else
  // Clean mode — pure ELF call, nothing else.
  uint64_t _c0 = 0, _c1 = 0;
  (void)_c0;
  (void)_c1;
  int ret = iree_elf_call_i_ppp(library->exports.ptrs[ordinal],
                                (void*)&base_executable->environment,
                                (void*)dispatch_state, (void*)workgroup_state);
#if defined(__riscv) && (__riscv_xlen == 64)
  // Post-dispatch fence (correctness, separate from profiling).
  __asm__ volatile("fence rw,rw" ::: "memory");
#endif
#endif
#if defined(MERLIN_DISPATCH_DEBUG) && MERLIN_DISPATCH_DEBUG
  if (dbg) {
    fprintf(stderr, "[dc] o=%zu wg=%u,%u,%u cyc=%llu ret=%d\n", ordinal,
            workgroup_state->workgroup_id_x,
            workgroup_state->workgroup_id_y,
            workgroup_state->workgroup_id_z,
            (unsigned long long)(_c1 - _c0), ret);
    // Bug A trace readback: the compiler-emitted store at
    // MERLIN_DEBUG_MATMUL_TRACE_ADDR populates this region with the i64
    // A/B/C/D addresses the dispatch consumed. If the sentinel is intact,
    // the trace stores didn't execute. Limited to the FC head ordinals
    // that exercised the original subspan-offset bug.
    if (ordinal == 16 || ordinal == 18) {
      volatile uint64_t* trace =
          (volatile uint64_t*)MERLIN_DEBUG_MATMUL_TRACE_ADDR;
      fprintf(stderr,
              "[mtrace] o=%zu sentinel=0x%016llx A=0x%016llx B=0x%016llx "
              "C=0x%016llx D=0x%016llx\n",
              ordinal,
              (unsigned long long)trace[0],
              (unsigned long long)trace[1],
              (unsigned long long)trace[2],
              (unsigned long long)trace[3],
              (unsigned long long)trace[4]);
    }
    fflush(stderr);
  }
#endif  // MERLIN_DISPATCH_DEBUG
  IREE_HAL_EXECUTABLE_LIBRARY_CALL_HOOK_END(executable->identifier, library,
                                            ordinal);
  IREE_TRACE_ZONE_END(z0);

  return ret == 0 ? iree_ok_status()
                  : iree_make_status(
                        IREE_STATUS_INTERNAL,
                        "executable entry point returned catastrophic error %d",
                        ret);
}

static iree_host_size_t iree_hal_elf_executable_export_count(
    iree_hal_executable_t* base_executable) {
  iree_hal_elf_executable_t* executable =
      (iree_hal_elf_executable_t*)base_executable;
  return iree_hal_executable_library_export_count(executable->library.v0);
}

static iree_status_t iree_hal_elf_executable_export_info(
    iree_hal_executable_t* base_executable,
    iree_hal_executable_export_ordinal_t export_ordinal,
    iree_hal_executable_export_info_t* out_info) {
  iree_hal_elf_executable_t* executable =
      (iree_hal_elf_executable_t*)base_executable;
  return iree_hal_executable_library_export_info(executable->library.v0,
                                                 export_ordinal, out_info);
}

static iree_status_t iree_hal_elf_executable_export_parameters(
    iree_hal_executable_t* base_executable,
    iree_hal_executable_export_ordinal_t export_ordinal,
    iree_host_size_t capacity,
    iree_hal_executable_export_parameter_t* out_parameters) {
  iree_hal_elf_executable_t* executable =
      (iree_hal_elf_executable_t*)base_executable;
  return iree_hal_executable_library_export_parameters(
      executable->library.v0, export_ordinal, capacity, out_parameters);
}

static iree_status_t iree_hal_elf_executable_lookup_export_by_name(
    iree_hal_executable_t* base_executable, iree_string_view_t name,
    iree_hal_executable_export_ordinal_t* out_export_ordinal) {
  iree_hal_elf_executable_t* executable =
      (iree_hal_elf_executable_t*)base_executable;
  return iree_hal_executable_library_lookup_export_by_name(
      executable->library.v0, name, out_export_ordinal);
}

static const iree_hal_local_executable_vtable_t iree_hal_elf_executable_vtable =
    {
        .base =
            {
                .destroy = iree_hal_elf_executable_destroy,
                .export_count = iree_hal_elf_executable_export_count,
                .export_info = iree_hal_elf_executable_export_info,
                .export_parameters = iree_hal_elf_executable_export_parameters,
                .lookup_export_by_name =
                    iree_hal_elf_executable_lookup_export_by_name,
            },
        .issue_call = iree_hal_elf_executable_issue_call,
};

//===----------------------------------------------------------------------===//
// iree_hal_embedded_elf_loader_t
//===----------------------------------------------------------------------===//

typedef struct iree_hal_embedded_elf_loader_t {
  iree_hal_executable_loader_t base;
  iree_allocator_t host_allocator;
  iree_hal_executable_plugin_manager_t* plugin_manager;
} iree_hal_embedded_elf_loader_t;

static const iree_hal_executable_loader_vtable_t
    iree_hal_embedded_elf_loader_vtable;

iree_status_t iree_hal_embedded_elf_loader_create(
    iree_hal_executable_plugin_manager_t* plugin_manager,
    iree_allocator_t host_allocator,
    iree_hal_executable_loader_t** out_executable_loader) {
  IREE_ASSERT_ARGUMENT(out_executable_loader);
  *out_executable_loader = NULL;
  IREE_TRACE_ZONE_BEGIN(z0);

  iree_hal_embedded_elf_loader_t* executable_loader = NULL;
  iree_status_t status = iree_allocator_malloc(
      host_allocator, sizeof(*executable_loader), (void**)&executable_loader);
  if (iree_status_is_ok(status)) {
    iree_hal_executable_loader_initialize(
        &iree_hal_embedded_elf_loader_vtable,
        iree_hal_executable_plugin_manager_provider(plugin_manager),
        &executable_loader->base);
    executable_loader->host_allocator = host_allocator;
    executable_loader->plugin_manager = plugin_manager;
    iree_hal_executable_plugin_manager_retain(
        executable_loader->plugin_manager);
    *out_executable_loader = (iree_hal_executable_loader_t*)executable_loader;
  }

  IREE_TRACE_ZONE_END(z0);
  return status;
}

static void iree_hal_embedded_elf_loader_destroy(
    iree_hal_executable_loader_t* base_executable_loader) {
  iree_hal_embedded_elf_loader_t* executable_loader =
      (iree_hal_embedded_elf_loader_t*)base_executable_loader;
  iree_allocator_t host_allocator = executable_loader->host_allocator;
  IREE_TRACE_ZONE_BEGIN(z0);

  iree_hal_executable_plugin_manager_release(executable_loader->plugin_manager);
  iree_allocator_free(host_allocator, executable_loader);

  IREE_TRACE_ZONE_END(z0);
}

static iree_status_t iree_hal_embedded_elf_loader_infer_format(
    iree_hal_executable_loader_t* base_executable_loader,
    iree_hal_executable_caching_mode_t caching_mode,
    iree_const_byte_span_t executable_data,
    iree_host_size_t executable_format_capacity, char* executable_format,
    iree_host_size_t* out_inferred_size) {
  IREE_TRACE_ZONE_BEGIN(z0);
  iree_status_t status = iree_hal_executable_infer_elf_format(
      executable_data, executable_format_capacity, executable_format,
      out_inferred_size);
  IREE_TRACE_ZONE_END(z0);
  return status;
}

static bool iree_hal_embedded_elf_loader_query_support(
    iree_hal_executable_loader_t* base_executable_loader,
    iree_hal_executable_caching_mode_t caching_mode,
    iree_string_view_t executable_format) {
  return iree_string_view_starts_with(
      executable_format, iree_make_cstring_view("embedded-elf-" IREE_ARCH));
}

static iree_status_t iree_hal_embedded_elf_loader_try_load(
    iree_hal_executable_loader_t* base_executable_loader,
    const iree_hal_executable_params_t* executable_params,
    iree_host_size_t worker_capacity, iree_hal_executable_t** out_executable) {
  iree_hal_embedded_elf_loader_t* executable_loader =
      (iree_hal_embedded_elf_loader_t*)base_executable_loader;
  IREE_TRACE_ZONE_BEGIN(z0);

  // Perform the load of the ELF and wrap it in an executable handle.
  iree_status_t status = iree_hal_elf_executable_create(
      executable_params, base_executable_loader->import_provider,
      executable_loader->host_allocator, out_executable);

  IREE_TRACE_ZONE_END(z0);
  return status;
}

static const iree_hal_executable_loader_vtable_t
    iree_hal_embedded_elf_loader_vtable = {
        .destroy = iree_hal_embedded_elf_loader_destroy,
        .infer_format = iree_hal_embedded_elf_loader_infer_format,
        .query_support = iree_hal_embedded_elf_loader_query_support,
        .try_load = iree_hal_embedded_elf_loader_try_load,
};
