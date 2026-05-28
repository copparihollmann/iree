// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/compiler/DispatchCreation/ScheduleSpec.h"

#include "llvm/Support/JSON.h"
#include "llvm/Support/MemoryBuffer.h"
#include "mlir/IR/Diagnostics.h"
#include "mlir/IR/Location.h"

namespace mlir::iree_compiler::DispatchCreation {

namespace {

// Twine accepts std::string / StringRef / const char* / Twine concatenations
// uniformly, so callers can write `"…" + *opt + "…"` without intermediate
// .str() materialization.
InFlightDiagnostic emitErr(MLIRContext *ctx, llvm::StringRef path,
                           const llvm::Twine &msg) {
  return mlir::emitError(UnknownLoc::get(ctx))
         << "schedule-spec '" << path << "': " << msg;
}

ShardReduction parseShardReduction(llvm::StringRef s) {
  if (s == "add")
    return ShardReduction::Add;
  if (s == "max")
    return ShardReduction::Max;
  if (s == "any")
    return ShardReduction::Any;
  return ShardReduction::None;
}

LogicalResult parseDirective(MLIRContext *ctx, llvm::StringRef path,
                             const llvm::json::Object &obj,
                             DispatchDirective &out) {
  auto idOpt = obj.getInteger("id");
  if (!idOpt) {
    emitErr(ctx, path, "directive missing integer 'id'");
    return failure();
  }
  out.id = *idOpt;

  auto opStr = obj.getString("op");
  if (!opStr) {
    emitErr(ctx, path, "directive missing string 'op'");
    return failure();
  }

  if (*opStr == "affinity") {
    AffinityDirective payload;
    auto dev = obj.getString("device");
    if (!dev) {
      emitErr(ctx, path, "affinity directive missing 'device'");
      return failure();
    }
    payload.device = dev->str();
    out.kind = DirectiveKind::Affinity;
    out.payload = std::move(payload);
    return success();
  }

  if (*opStr == "split") {
    SplitDirective payload;
    auto factor = obj.getInteger("factor");
    if (!factor) {
      emitErr(ctx, path, "split directive missing integer 'factor'");
      return failure();
    }
    payload.factor = *factor;
    if (auto axis = obj.getString("axis")) {
      payload.axis = axis->str();
    }
    out.kind = DirectiveKind::Split;
    out.payload = std::move(payload);
    return success();
  }

  if (*opStr == "grow") {
    GrowDirective payload;
    auto mergeWith = obj.getInteger("merge_with");
    if (!mergeWith) {
      emitErr(ctx, path, "grow directive missing integer 'merge_with'");
      return failure();
    }
    payload.mergeWith = *mergeWith;
    out.kind = DirectiveKind::Grow;
    out.payload = std::move(payload);
    return success();
  }

  if (*opStr == "shard") {
    ShardDirective payload;
    if (auto axis = obj.getString("axis")) {
      payload.axis = axis->str();
    }
    auto devices = obj.getArray("devices");
    if (!devices || devices->empty()) {
      emitErr(ctx, path, "shard directive missing non-empty 'devices' array");
      return failure();
    }
    for (const auto &v : *devices) {
      auto s = v.getAsString();
      if (!s) {
        emitErr(ctx, path, "shard directive device entry must be a string");
        return failure();
      }
      payload.devices.push_back(s->str());
    }
    if (auto red = obj.getString("reduction")) {
      payload.reduction = parseShardReduction(*red);
    }
    out.kind = DirectiveKind::Shard;
    out.payload = std::move(payload);
    return success();
  }

  if (*opStr == "replicate") {
    ReplicateDirective payload;
    auto factor = obj.getInteger("factor");
    if (!factor) {
      emitErr(ctx, path, "replicate directive missing integer 'factor'");
      return failure();
    }
    payload.factor = *factor;
    out.kind = DirectiveKind::Replicate;
    out.payload = std::move(payload);
    return success();
  }

  emitErr(ctx, path, "unknown directive op '" + *opStr + "'");
  return failure();
}

} // namespace

// Returns "@device_a", "@device_b", ..., "@device_z", "@device_aa", ...
// for index 0, 1, 2, ... Stable ordering for any machines list.
static std::string deviceSymbolForIndex(size_t index) {
  std::string s = "@device_";
  // Base-26 encoding using lower-case letters. index=0 -> "a", 25 -> "z",
  // 26 -> "aa", 27 -> "ab", ...
  std::string suffix;
  size_t n = index;
  while (true) {
    suffix.insert(suffix.begin(), static_cast<char>('a' + (n % 26)));
    if (n < 26)
      break;
    n = n / 26 - 1;
  }
  return s + suffix;
}

FailureOr<ScheduleSpec> ScheduleSpec::loadFromFile(llvm::StringRef path,
                                                   MLIRContext *ctx) {
  ScheduleSpec spec;

  auto bufOrErr = llvm::MemoryBuffer::getFile(path);
  if (!bufOrErr) {
    emitErr(ctx, path, "could not open file: " + bufOrErr.getError().message());
    return failure();
  }

  auto parsed = llvm::json::parse((*bufOrErr)->getBuffer());
  if (!parsed) {
    emitErr(ctx, path, "JSON parse error: " + toString(parsed.takeError()));
    return failure();
  }

  const llvm::json::Object *root = parsed->getAsObject();
  if (!root) {
    emitErr(ctx, path, "JSON root is not an object");
    return failure();
  }

  if (auto v = root->getInteger("schema_version")) {
    spec.schemaVersion = static_cast<int>(*v);
    if (spec.schemaVersion != 1) {
      emitErr(ctx, path, "unsupported schema_version (only 1 is supported)");
      return failure();
    }
  }
  if (auto a = root->getString("anchor")) {
    spec.anchor = a->str();
  }
  if (const auto *globalObj = root->getObject("global")) {
    if (auto da = globalObj->getString("default_affinity")) {
      spec.defaultAffinity = da->str();
    }
  }

  // 1. Parse explicit `machines: [...]` if present.
  if (const llvm::json::Array *machinesArr = root->getArray("machines")) {
    for (const auto &v : *machinesArr) {
      auto s = v.getAsString();
      if (!s) {
        emitErr(ctx, path, "'machines' entries must be strings");
        return failure();
      }
      spec.machines.push_back(s->str());
    }
  }

  // 2. Parse explicit `device_map` overrides (kept temporarily; merged later).
  llvm::StringMap<std::string> deviceMapOverrides;
  if (const auto *deviceMap = root->getObject("device_map")) {
    for (const auto &kv : *deviceMap) {
      auto value = kv.second.getAsString();
      if (!value) {
        emitErr(ctx, path,
                "device_map values must be strings (e.g. \"@device_a\")");
        return failure();
      }
      deviceMapOverrides[kv.first.str()] = value->str();
    }
  }

  // 3. If `machines` was not provided, infer it from the dispatches block's
  //    `hardware_target` tokens (in declaration order, deduplicated). Falls
  //    back to the legacy ["CPU_P", "CPU_E"] convention if neither machines
  //    nor dispatches gives us anything (matches hw_annotation.py).
  if (spec.machines.empty()) {
    auto contains = [&](StringRef s) {
      for (const auto &m : spec.machines) {
        if (m == s)
          return true;
      }
      return false;
    };
    if (const auto *dispatches = root->getObject("dispatches")) {
      for (const auto &kv : *dispatches) {
        const llvm::json::Object *entry = kv.second.getAsObject();
        if (!entry)
          continue;
        if (auto hw = entry->getString("hardware_target")) {
          if (!contains(*hw))
            spec.machines.push_back(hw->str());
        }
      }
    }
    if (spec.machines.empty()) {
      // Legacy two-cluster default — preserves prior hw_annotation.py setups
      // that didn't carry an explicit machines list.
      spec.machines.push_back("CPU_P");
      spec.machines.push_back("CPU_E");
    }
  }

  // 4. Auto-derive deviceMap from the (now-populated) machines list:
  //    machines[0] -> @device_a, machines[1] -> @device_b, ...
  for (size_t i = 0; i < spec.machines.size(); ++i) {
    spec.deviceMap[spec.machines[i]] = deviceSymbolForIndex(i);
  }

  // 5. Apply explicit device_map overrides on top of the auto-derivation.
  //    This lets a user pin specific symbols (e.g. "GPU" -> "@gpu_main")
  //    without giving up the rest of the auto-mapping.
  for (const auto &kv : deviceMapOverrides) {
    spec.deviceMap[kv.first()] = kv.second;
  }

  // 6. Legacy "dispatches" block: { "<name>": { "id": N, "hardware_target":
  //    ... } }. Each entry becomes an implicit Affinity directive after
  //    translating the hardware_target token through the now-final deviceMap.
  if (const auto *dispatches = root->getObject("dispatches")) {
    for (const auto &kv : *dispatches) {
      const llvm::json::Object *entry = kv.second.getAsObject();
      if (!entry) {
        emitErr(ctx, path,
                "'dispatches.<name>' must be an object: " + kv.first.str());
        return failure();
      }
      auto idOpt = entry->getInteger("id");
      if (!idOpt)
        continue; // entries without id are not addressable; skip silently.
      auto hwOpt = entry->getString("hardware_target");
      if (!hwOpt)
        continue;
      auto deviceIt = spec.deviceMap.find(*hwOpt);
      if (deviceIt == spec.deviceMap.end()) {
        emitErr(ctx, path, "unmapped hardware_target token '" + *hwOpt +
                               "' (add it to 'machines' or 'device_map')");
        return failure();
      }
      DispatchDirective d;
      d.id = *idOpt;
      d.kind = DirectiveKind::Affinity;
      d.payload = AffinityDirective{deviceIt->second};
      // Last-wins for legacy entries (matches hw_annotation.py:_parse_schedule
      // which overwrites schedule[d_id] = hw on each pass through). Multiple
      // suffixed entries (e.g. "..._dispatch_13" and "..._dispatch_13_1") can
      // share the same numeric id; whichever the JSON lists last takes.
      spec.directives[d.id] = d;
    }
  }

  // Rich "directives" list. Wins over the legacy block on conflict.
  if (const llvm::json::Array *directives = root->getArray("directives")) {
    for (const auto &v : *directives) {
      const llvm::json::Object *obj = v.getAsObject();
      if (!obj) {
        emitErr(ctx, path, "directive entries must be objects");
        return failure();
      }
      DispatchDirective d;
      if (failed(parseDirective(ctx, path, *obj, d))) {
        return failure();
      }
      // Insert-or-overwrite: rich form takes precedence.
      spec.directives[d.id] = d;
    }
  }

  return spec;
}

} // namespace mlir::iree_compiler::DispatchCreation
