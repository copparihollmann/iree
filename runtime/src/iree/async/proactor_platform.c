// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/async/proactor.h"
#include "iree/async/proactor_platform.h"

#if defined(IREE_PLATFORM_LINUX) && !defined(IREE_PLATFORM_ANDROID)
#include "iree/async/platform/io_uring/api.h"
#endif  // IREE_PLATFORM_LINUX && !IREE_PLATFORM_ANDROID

#if !defined(IREE_PLATFORM_WINDOWS) && !defined(IREE_PLATFORM_EMSCRIPTEN)
#include "iree/async/platform/posix/api.h"
#endif  // !IREE_PLATFORM_WINDOWS && !IREE_PLATFORM_EMSCRIPTEN

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

#elif defined(IREE_PLATFORM_GENERIC)

  // Bare-metal: create a minimal no-op proactor. The sync device requires a
  // non-NULL proactor but never uses it for actual async I/O.
  {
    iree_async_proactor_t* proactor = NULL;
    status = iree_allocator_malloc(allocator, sizeof(*proactor),
                                   (void**)&proactor);
    if (iree_status_is_ok(status)) {
      extern const iree_async_proactor_vtable_t
          iree_nop_proactor_vtable_instance;
      iree_async_proactor_initialize(&iree_nop_proactor_vtable_instance,
                                     iree_make_cstring_view("nop"),
                                     allocator, proactor);
      *out_proactor = proactor;
    }
  }

#elif !defined(IREE_PLATFORM_EMSCRIPTEN)  // macOS, BSD, Android, etc.

  status = iree_async_proactor_create_posix(options, allocator, out_proactor);

#endif  // IREE_PLATFORM_*

  IREE_TRACE_ZONE_END(z0);
  return status;
}
