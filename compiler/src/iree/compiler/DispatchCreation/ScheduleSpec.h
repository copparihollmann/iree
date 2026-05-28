// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// In-memory representation of an XPU-RT schedule.json. Loaded by the
// dispatch-creation apply-* passes and keyed by `iree.dispatch_id` (stamped by
// TagDispatchIdsPass).

#ifndef IREE_COMPILER_DISPATCHCREATION_SCHEDULESPEC_H_
#define IREE_COMPILER_DISPATCHCREATION_SCHEDULESPEC_H_

#include <string>
#include <variant>

#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/ADT/StringRef.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/Support/LogicalResult.h"

namespace mlir::iree_compiler::DispatchCreation {

enum class DirectiveKind {
  Affinity,
  Split,
  Grow,
  Shard,
  Replicate,
};

struct AffinityDirective {
  std::string device; // e.g. "@device_a"
};

struct SplitDirective {
  int64_t factor = 0;
  std::string axis; // "M", "N", "K", "batch", or numeric "0".."N"
};

struct GrowDirective {
  int64_t mergeWith = -1; // dispatch id of the producer to merge in.
};

enum class ShardReduction {
  None, // parallel-axis shard, recombine via tensor.insert_slice.
  Add,
  Max,
  Any,
};

struct ShardDirective {
  std::string axis;
  llvm::SmallVector<std::string, 4> devices;
  ShardReduction reduction = ShardReduction::None;
};

struct ReplicateDirective {
  int64_t factor = 0;
};

struct DispatchDirective {
  int64_t id = -1;
  DirectiveKind kind;
  std::variant<AffinityDirective, SplitDirective, GrowDirective, ShardDirective,
               ReplicateDirective>
      payload;
};

struct ScheduleSpec {
  int schemaVersion = 1;
  std::string anchor = "iree.dispatch_id";
  std::string defaultAffinity; // empty if not set.

  // Ordered list of machine names declared at the top level
  // (e.g. ["CPU_P", "CPU_E", "GPU", "HTP"]). Each machine corresponds to
  // an `@device_<x>` global created by ApplyAffinityDirectivesPass. When
  // absent from the JSON we infer the list from the union of
  // `hardware_target` tokens seen in the `dispatches` block plus device
  // refs seen in the `directives` block (in declaration order).
  llvm::SmallVector<std::string, 4> machines;

  // Directives keyed by dispatch id. Populated from BOTH the legacy
  // `dispatches: { name: { id, hardware_target, ... } }` block (each entry
  // becomes an implicit Affinity directive after CPU_P/CPU_E translation) and
  // the new `directives: [ ... ]` list (rich form: split/grow/shard/...). When
  // both supply a directive for the same id, the rich form wins.
  llvm::DenseMap<int64_t, DispatchDirective> directives;

  // Translation table from XPU-RT `hardware_target` tokens (e.g. "CPU_P",
  // "CPU_E") to device symbol references (e.g. "@device_a"). Auto-derived
  // from the `machines` list (in order: @device_a, @device_b, ...) when not
  // explicitly provided in the JSON. The optional `device_map` block in the
  // JSON acts as an override on top of the auto-derived mapping. The legacy
  // CPU_P -> @device_a / CPU_E -> @device_b convention is preserved when no
  // machines list is given (back-compat with hw_annotation.py).
  llvm::StringMap<std::string> deviceMap;

  // Loads + parses a schedule JSON from `path`. Returns failure (with an
  // emitted diagnostic) on missing file, malformed JSON, or unknown directive
  // kinds.
  static FailureOr<ScheduleSpec> loadFromFile(llvm::StringRef path,
                                              MLIRContext *ctx);
};

} // namespace mlir::iree_compiler::DispatchCreation

#endif // IREE_COMPILER_DISPATCHCREATION_SCHEDULESPEC_H_
