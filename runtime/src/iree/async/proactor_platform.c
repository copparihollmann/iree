// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/async/proactor.h"
#include "iree/async/proactor_platform.h"

#include "iree/async/proactor.h"

#if defined(IREE_PLATFORM_GENERIC) || defined(IREE_PLATFORM_ZEPHYR)
// Bare-metal / Zephyr stub proactor: the HAL holds a proactor pointer for
// semaphore + frontier accounting but never invokes any vtable method (no
// async I/O). All vtable entries assert if called. local-task on Zephyr
// uses iree_task_executor for actual scheduling, not the proactor.
static void iree_async_proactor_stub_destroy(iree_async_proactor_t* proactor) {
  iree_allocator_free(proactor->allocator, proactor);
}
static iree_async_proactor_capabilities_t
iree_async_proactor_stub_query_capabilities(iree_async_proactor_t* proactor) {
  (void)proactor;
  iree_async_proactor_capabilities_t caps;
  memset(&caps, 0, sizeof(caps));
  return caps;
}
// No-op wake. Called by iree_async_proactor_thread_request_stop during
// teardown to nudge a polling thread; in the stub backend there's no
// poll loop running so a no-op is correct.
static void iree_async_proactor_stub_wake(iree_async_proactor_t* proactor) {
  (void)proactor;
}
// No-op poll. The proactor runner thread (iree_async_proactor_thread_main)
// loops calling vtable->poll() with a timeout, expecting it to block until
// some I/O completes (then writes out_completed_count). In the stub
// backend there's no I/O so we just sleep briefly and return 0 completions.
// IMPORTANT: must not be a tight no-op — that would spin the runner
// thread at 100% CPU. We yield via the iree threading primitive instead.
extern void iree_thread_yield(void);
static iree_status_t iree_async_proactor_stub_poll(
    iree_async_proactor_t* proactor, iree_timeout_t timeout,
    iree_host_size_t* out_completed_count) {
  (void)proactor;
  (void)timeout;
  // iree_async_proactor_thread_main passes NULL for out_completed_count;
  // the deadline-exceeded check below is the runner's intended progress
  // mechanism (it ignores deadline-exceeded and re-polls). So we return
  // DEADLINE_EXCEEDED with no completion side-effect, yielding to other
  // threads to avoid spinning the hart.
  if (out_completed_count) *out_completed_count = 0;
  iree_thread_yield();
  return iree_status_from_code(IREE_STATUS_DEADLINE_EXCEEDED);
}
// No-op submit. Stub backend has no I/O submission queue.
static iree_status_t iree_async_proactor_stub_submit(
    iree_async_proactor_t* proactor,
    iree_async_operation_list_t operations) {
  (void)proactor;
  (void)operations;
  return iree_ok_status();
}
// No-op cancel.
static iree_status_t iree_async_proactor_stub_cancel(
    iree_async_proactor_t* proactor, iree_async_operation_t* operation) {
  (void)proactor;
  (void)operation;
  return iree_ok_status();
}
static const iree_async_proactor_vtable_t iree_async_proactor_stub_vtable = {
    .destroy = iree_async_proactor_stub_destroy,
    .query_capabilities = iree_async_proactor_stub_query_capabilities,
    .wake = iree_async_proactor_stub_wake,
    .poll = iree_async_proactor_stub_poll,
    .submit = iree_async_proactor_stub_submit,
    .cancel = iree_async_proactor_stub_cancel,
    // Other methods (socket/file/event/notification/relay/buffer/fence)
    // remain NULL — local-sync/local-task HAL paths don't call them.
    // If a future workload hits a different NULL slot, add a stub here.
};
static iree_status_t iree_async_proactor_create_stub(
    iree_async_proactor_options_t options, iree_allocator_t allocator,
    iree_async_proactor_t** out_proactor) {
  iree_async_proactor_t* proactor = NULL;
  IREE_RETURN_IF_ERROR(
      iree_allocator_malloc(allocator, sizeof(*proactor), (void**)&proactor));
  iree_async_proactor_initialize(&iree_async_proactor_stub_vtable,
                                 options.debug_name, allocator, proactor);
  *out_proactor = proactor;
  return iree_ok_status();
}
#endif  // IREE_PLATFORM_GENERIC || IREE_PLATFORM_ZEPHYR

#if defined(IREE_PLATFORM_LINUX) && !defined(IREE_PLATFORM_ANDROID)
#include "iree/async/platform/io_uring/api.h"
#endif  // IREE_PLATFORM_LINUX && !IREE_PLATFORM_ANDROID

#if !defined(IREE_PLATFORM_WINDOWS) && !defined(IREE_PLATFORM_EMSCRIPTEN) && \
    !defined(IREE_PLATFORM_GENERIC)
#include "iree/async/platform/posix/api.h"
#endif  // !IREE_PLATFORM_WINDOWS && !IREE_PLATFORM_EMSCRIPTEN &&
        // !IREE_PLATFORM_GENERIC

#if defined(IREE_PLATFORM_WINDOWS)
#include "iree/async/platform/iocp/api.h"
#endif  // IREE_PLATFORM_WINDOWS

#if defined(IREE_PLATFORM_GENERIC)
static void iree_nop_proactor_destroy(iree_async_proactor_t* proactor) {
  iree_allocator_free(proactor->allocator, proactor);
}
const iree_async_proactor_vtable_t iree_nop_proactor_vtable_instance = {
    .destroy = iree_nop_proactor_destroy,
};
#endif  // IREE_PLATFORM_GENERIC

iree_status_t iree_async_proactor_create_platform(
    iree_async_proactor_options_t options, iree_allocator_t allocator,
    iree_async_proactor_t** out_proactor) {
  IREE_TRACE_ZONE_BEGIN(z0);
  IREE_ASSERT_ARGUMENT(out_proactor);
  *out_proactor = NULL;

  iree_status_t status = iree_status_from_code(IREE_STATUS_UNAVAILABLE);

#if defined(IREE_PLATFORM_WINDOWS)

  status = iree_async_proactor_create_iocp(options, allocator, out_proactor);

#elif defined(IREE_PLATFORM_LINUX) && !defined(IREE_PLATFORM_ANDROID)

  // Try io_uring first (kernel 5.1+, enabled). Falls back to POSIX proactor
  // if io_uring is not usable (kernel too old, blocked by seccomp/sysctl,
  // insufficient locked memory, etc.).
  status =
      iree_async_proactor_create_io_uring(options, allocator, out_proactor);
  if (iree_status_is_unavailable(status)) {
    iree_status_ignore(status);
    status = iree_async_proactor_create_posix(options, allocator, out_proactor);
  }

#elif defined(IREE_PLATFORM_GENERIC) || defined(IREE_PLATFORM_ZEPHYR)

  // Bare-metal / embedded / Zephyr: create the stub proactor. The HAL
  // holds a proactor pointer for semaphore + frontier accounting but
  // never invokes any vtable method for I/O.
  //
  // We use our `iree_async_proactor_stub_vtable` (defined at the top of
  // this file) rather than upstream's `iree_nop_proactor_vtable_instance`
  // because the latter leaves poll/submit/cancel/wake as NULL — which
  // the proactor runner thread (`iree_async_proactor_thread_main`)
  // dereferences without a NULL check, causing an Instruction Access
  // Fault (mcause=1 mepc=0) on FireSim Shuttle. The stub vtable has
  // poll returning DEADLINE_EXCEEDED + iree_thread_yield() so the
  // runner just spins idle until shutdown.
  status = iree_async_proactor_create_stub(options, allocator, out_proactor);

#elif !defined(IREE_PLATFORM_EMSCRIPTEN)  // macOS, BSD, Android, etc.

  status = iree_async_proactor_create_posix(options, allocator, out_proactor);

#endif  // IREE_PLATFORM_*

  IREE_TRACE_ZONE_END(z0);
  return status;
}
