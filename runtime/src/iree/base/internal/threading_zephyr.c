// Copyright 2026
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/base/internal/threading_impl.h"

#if defined(IREE_PLATFORM_ZEPHYR)

#include <zephyr/posix/pthread.h>
#include <string.h>

#include "iree/base/internal/atomics.h"
#include "iree/base/internal/call_once.h"
#include "iree/base/internal/threading.h"

// Zephyr provides pthread APIs in <zephyr/posix/pthread.h>, but that header is
// included via the toolchain's <pthread.h> shim in many configurations. When
// building in a standalone sub-build, ensure Zephyr include paths are provided.

struct iree_thread_t {
  iree_atomic_ref_count_t ref_count;
  iree_allocator_t allocator;

  char name[32];
  pthread_t handle;

  iree_thread_entry_t entry;
  void* entry_arg;

  iree_atomic_int32_t suspend_count;
  iree_notification_t suspend_barrier;

  // Thread-safe (has its own synchronization).
  iree_thread_override_list_t qos_override_list;
};

static void iree_thread_set_priority_class(
    iree_thread_t* thread, iree_thread_priority_class_t priority_class) {
  (void)thread;
  (void)priority_class;
  // Priority control is optional and may be ignored by the platform.
}

static bool iree_thread_resumed_predicate(void* arg) {
  iree_thread_t* thread = (iree_thread_t*)arg;
  return iree_atomic_load(&thread->suspend_count, iree_memory_order_acquire) ==
         0;
}

static void* iree_thread_main(void* arg) {
  iree_thread_t* thread = (iree_thread_t*)arg;

  // If created suspended, wait until resumed.
  if (iree_atomic_load(&thread->suspend_count, iree_memory_order_acquire) != 0) {
    iree_notification_await(&thread->suspend_barrier,
                            (iree_condition_fn_t)iree_thread_resumed_predicate,
                            thread, iree_infinite_timeout());
  }

  // Run entry.
  (void)thread->entry(thread->entry_arg);
  return NULL;
}

iree_status_t iree_thread_create(iree_thread_entry_t entry, void* entry_arg,
                                 iree_thread_create_params_t params,
                                 iree_allocator_t allocator,
                                 iree_thread_t** out_thread) {
  IREE_ASSERT_ARGUMENT(out_thread);
  *out_thread = NULL;

  iree_thread_t* thread = NULL;
  IREE_RETURN_IF_ERROR(
      iree_allocator_malloc(allocator, sizeof(*thread), (void**)&thread));
  memset(thread, 0, sizeof(*thread));
  iree_atomic_ref_count_init(&thread->ref_count);
  thread->allocator = allocator;
  thread->entry = entry;
  thread->entry_arg = entry_arg;

  iree_thread_override_list_initialize(iree_thread_set_priority_class,
                                       params.priority_class, allocator,
                                       &thread->qos_override_list);

  iree_notification_initialize(&thread->suspend_barrier);
  iree_atomic_store(&thread->suspend_count, params.create_suspended ? 1 : 0,
                    iree_memory_order_release);

  if (params.name.data && params.name.size > 0) {
    iree_host_size_t n = iree_min(params.name.size, sizeof(thread->name) - 1);
    memcpy(thread->name, params.name.data, n);
    thread->name[n] = 0;
  } else {
    thread->name[0] = 0;
  }

  pthread_attr_t attr;
  pthread_attr_init(&attr);
  if (params.stack_size) {
    // Best-effort; some Zephyr configs may ignore this.
    (void)pthread_attr_setstacksize(&attr, params.stack_size);
  }

  int rc = pthread_create(&thread->handle, &attr, iree_thread_main, thread);
  pthread_attr_destroy(&attr);
  if (rc != 0) {
    iree_thread_override_list_deinitialize(&thread->qos_override_list);
    iree_notification_deinitialize(&thread->suspend_barrier);
    iree_allocator_free(allocator, thread);
    return iree_make_status(IREE_STATUS_RESOURCE_EXHAUSTED,
                            "pthread_create failed (rc=%d)", rc);
  }

  // Affinity is best-effort; ignore if unsupported.
  iree_thread_request_affinity(thread, params.initial_affinity);

  if (!params.create_suspended) {
    // Ensure thread is resumed.
    iree_thread_resume(thread);
  }

  *out_thread = thread;
  return iree_ok_status();
}

void iree_thread_retain(iree_thread_t* thread) {
  if (thread) iree_atomic_ref_count_inc(&thread->ref_count);
}

void iree_thread_release(iree_thread_t* thread) {
  if (!thread) return;
  if (iree_atomic_ref_count_dec(&thread->ref_count) != 1) return;

  // Best-effort join on final release. Callers may have already joined.
  (void)pthread_join(thread->handle, NULL);

  iree_thread_override_list_deinitialize(&thread->qos_override_list);
  iree_notification_deinitialize(&thread->suspend_barrier);
  iree_allocator_free(thread->allocator, thread);
}

uintptr_t iree_thread_id(iree_thread_t* thread) {
  if (!thread) return 0;
  // pthread_t is opaque; this is for diagnostics only.
  return (uintptr_t)thread->handle;
}

iree_thread_override_t* iree_thread_priority_class_override_begin(
    iree_thread_t* thread, iree_thread_priority_class_t priority_class) {
  if (!thread) return NULL;
  return iree_thread_override_list_add(&thread->qos_override_list, thread,
                                       priority_class);
}

void iree_thread_override_end(iree_thread_override_t* override_token) {
  if (!override_token) return;
  iree_thread_override_remove_self(override_token);
}

void iree_thread_request_affinity(iree_thread_t* thread,
                                  iree_thread_affinity_t affinity) {
  (void)thread;
  (void)affinity;
  // Zephyr affinity support varies by arch/config; ignore by default.
}

void iree_thread_resume(iree_thread_t* thread) {
  if (!thread) return;
  if (iree_atomic_exchange(&thread->suspend_count, 0,
                           iree_memory_order_release) != 0) {
    iree_notification_post(&thread->suspend_barrier, IREE_ALL_WAITERS);
  }
}

void iree_thread_join(iree_thread_t* thread) {
  if (!thread) return;
  (void)pthread_join(thread->handle, NULL);
}

void iree_thread_yield(void) {
  // sched_yield may not be available in all Zephyr libc configs.
  // Zephyr provides k_yield(), but that requires Zephyr headers here.
  // As a fallback, do nothing.
}

#endif  // IREE_PLATFORM_ZEPHYR

