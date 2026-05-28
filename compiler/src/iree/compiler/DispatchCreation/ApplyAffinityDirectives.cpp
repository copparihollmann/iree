// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// Applies the `affinity` directives from an XPU-RT schedule.json onto
// `flow.dispatch.workgroups` ops by stamping `stream.affinity =
// #hal.device.affinity<@<device>>`. Replaces the regex-based
// samples/research/promise_schedule_multi_model/hw_annotation.py.

#include "iree/compiler/Dialect/Flow/IR/FlowOps.h"
#include "iree/compiler/Dialect/HAL/IR/HALDialect.h"
#include "iree/compiler/Dialect/HAL/IR/HALTypes.h"
#include "iree/compiler/Dialect/Util/IR/UtilDialect.h"
#include "iree/compiler/Dialect/Util/IR/UtilOps.h"
#include "iree/compiler/Dialect/Util/IR/UtilTypes.h"
#include "iree/compiler/DispatchCreation/Passes.h"
#include "iree/compiler/DispatchCreation/ScheduleSpec.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/SymbolTable.h"

#define DEBUG_TYPE "iree-dispatch-creation-apply-affinity-directives"

namespace mlir::iree_compiler::DispatchCreation {

#define GEN_PASS_DEF_APPLYAFFINITYDIRECTIVESPASS
#include "iree/compiler/DispatchCreation/Passes.h.inc"

// CLI flag declared (and parsed) here. Other apply-* passes (split, grow,
// shard) read the same path via `extern`; the loader is cheap enough to
// re-run per pass. Non-static so it has external linkage.
llvm::cl::opt<std::string> clScheduleSpecPath(
    "iree-merlin-schedule-spec",
    llvm::cl::desc(
        "Path to a JSON schedule produced by XPU-RT. When set, dispatch "
        "creation applies affinity / split / grow / shard / replicate "
        "directives keyed by iree.dispatch_id."),
    llvm::cl::init(""));

// Heterogeneous-target override. CSV of `<machine_name>:<target>` pairs,
// where `<machine_name>` matches an entry in the schedule's `machines` list
// (case-insensitive — we normalize both sides to lower-case before matching)
// and `<target>` is an IREE HAL target string (`local`, `vulkan`,
// `qnn-htp`, ...). When unset, all device globals share the prototype
// `#hal.device.target` from the existing module global (homogeneous; the
// pre-C2 behavior). Names not in the CSV fall back to the prototype.
//
// Example:
//   --iree-hal-target-devices=cpu_p:local,cpu_e:local,gpu:vulkan,htp:qnn-htp
llvm::cl::opt<std::string> clHalTargetDevices(
    "iree-hal-target-devices",
    llvm::cl::desc(
        "CSV of <machine>:<hal-target> pairs used to assign per-device target "
        "attributes when the schedule's machines list is heterogeneous. "
        "Unmatched machines fall back to the module's prototype target."),
    llvm::cl::init(""));

namespace {

struct ApplyAffinityDirectivesPass final
    : impl::ApplyAffinityDirectivesPassBase<ApplyAffinityDirectivesPass> {
  using Base::Base;
  void runOnOperation() override;
};

} // namespace

// Parses a device reference string (e.g. "@device_a" or
// "#hal.device.affinity<@device_a>") into an Attribute conforming to the
// stream affinity interface. Bare "@symbol" forms are wrapped in
// `#hal.device.affinity<...>` for convenience.
static Attribute buildAffinityAttr(MLIRContext *ctx, llvm::StringRef device) {
  device = device.trim();
  if (device.empty())
    return {};
  std::string text;
  if (device.front() == '@') {
    text = ("#hal.device.affinity<" + device + ">").str();
  } else {
    text = device.str();
  }
  return parseAttribute(text, ctx);
}

// Extracts the bare symbol name (e.g. "device_a") from an affinity Attribute
// like #hal.device.affinity<@device_a>. Returns empty StringRef if the input
// isn't a recognized affinity form.
static StringRef extractDeviceSymbol(Attribute attr) {
  if (auto da = dyn_cast_or_null<IREE::HAL::DeviceAffinityAttr>(attr)) {
    SymbolRefAttr ref = da.getDevice();
    if (ref)
      return ref.getLeafReference().getValue();
  }
  return {};
}

// Per-symbol target-override map: device symbol (e.g. "device_a") to a HAL
// target token (e.g. "local", "vulkan", "qnn-htp"). When a symbol is in this
// map, the cloned global's initializer is rewritten to `#hal.device.target<
// "<token>">`; otherwise the prototype's initializer is preserved verbatim
// (homogeneous fallback).
using TargetOverrideMap = llvm::StringMap<std::string>;

// Ensures `moduleOp` has a `util.global private @<name> = <init> :
// !hal.device` declaration for each `requiredSymbols` entry. If missing,
// clones the value of any existing util.global of !hal.device type — that's
// the device target the module was configured for. When a symbol appears in
// `targetOverrides`, the cloned global's initializer is rewritten to a fresh
// `#hal.device.target<"<token>">` attr so heterogeneous setups can pin
// different machines to different HAL targets. Returns failure if no
// existing device global is found and no override is provided (which means
// the user passed a schedule on a single-device pipeline that hasn't been
// told what the target should be).
static LogicalResult
ensureDeviceGlobals(ModuleOp moduleOp, ArrayRef<StringRef> requiredSymbols,
                    const TargetOverrideMap &targetOverrides) {
  if (requiredSymbols.empty())
    return success();

  // Scan once: collect existing device globals + remember the prototype +
  // build a target-name → prototype map. The map lets us find a prototype
  // whose target name matches a CSV override (e.g. CSV says "HTA:qnn",
  // we look up the qnn prototype that has the full executable.target
  // attrs and clone IT instead of synthesizing a stripped-down target).
  SymbolTable symbolTable(moduleOp);
  IREE::Util::GlobalOp prototype;
  llvm::SmallDenseSet<StringRef> existing;
  // Map prototype globals by BOTH their global name (e.g. @hta_qnn from
  // a named --iree-hal-target-device declaration) AND the underlying
  // target backend name (e.g. "qnn"). The CSV value can refer to either:
  // user-named devices use the global name; bare aliases use the
  // backend name. Prefer global-name match.
  llvm::StringMap<IREE::Util::GlobalOp> prototypesByName;
  llvm::StringMap<IREE::Util::GlobalOp> prototypesByTargetName;
  for (auto globalOp : moduleOp.getOps<IREE::Util::GlobalOp>()) {
    if (!isa<IREE::HAL::DeviceType>(globalOp.getType()))
      continue;
    existing.insert(globalOp.getSymName());
    if (!prototype)
      prototype = globalOp;
    prototypesByName.try_emplace(globalOp.getSymName(), globalOp);
    if (auto t = dyn_cast_or_null<IREE::HAL::DeviceTargetAttr>(
            globalOp.getInitialValueAttr())) {
      prototypesByTargetName.try_emplace(t.getDeviceID().getValue(), globalOp);
    }
  }

  SmallVector<StringRef, 4> missing;
  for (StringRef sym : requiredSymbols) {
    if (!existing.contains(sym))
      missing.push_back(sym);
  }
  if (missing.empty())
    return success();

  if (!prototype) {
    std::string symbolList;
    llvm::raw_string_ostream os(symbolList);
    llvm::interleaveComma(missing, os, [&](StringRef s) { os << "@" << s; });
    os.flush();
    moduleOp.emitError()
        << "schedule-spec references device symbols (" << symbolList
        << ") but the module has no util.global of !hal.device type to clone "
           "from. Pass an explicit --iree-hal-target-device or seed the module "
           "with device declarations before applying the schedule.";
    return failure();
  }

  // Homogeneous-or-mixed path: when the CSV maps a machine to a target
  // name that matches an existing prototype (preserved through global
  // fold/fuse), clone that prototype verbatim so the new global gets the
  // full executable.target attrs registered for that target. Otherwise
  // fall back to the first prototype (homogeneous) — the result is a
  // bare clone that may need downstream materialization to fill in the
  // executable.target details.
  //
  // Note: if --iree-hal-target-device=<token> is declared but the
  // corresponding global is fold-eliminated before this pass runs (as
  // happens when nothing in the IR yet references the schedule-spec's
  // @device_<x> globals), the prototype map will be missing that token.
  // We still proceed by cloning whatever prototype survived; the user
  // sees the failure mode where downstream HAL conversion can't find
  // the right executable variant.
  OpBuilder builder(prototype);
  builder.setInsertionPointAfter(prototype);
  for (StringRef sym : missing) {
    IREE::Util::GlobalOp source = prototype;
    auto it = targetOverrides.find(sym);
    if (it != targetOverrides.end()) {
      // Prefer matching by global name (named device decl), fall back
      // to target backend name (bare alias).
      auto byNameIt = prototypesByName.find(it->getValue());
      if (byNameIt != prototypesByName.end()) {
        source = byNameIt->getValue();
      } else {
        auto byTargetIt = prototypesByTargetName.find(it->getValue());
        if (byTargetIt != prototypesByTargetName.end()) {
          source = byTargetIt->getValue();
        }
      }
    }
    auto cloned = cast<IREE::Util::GlobalOp>(builder.clone(*source));
    cloned.setSymName(sym);
    symbolTable.insert(cloned);
  }
  return success();
}

// Parses --iree-hal-target-devices=cpu_p:local,gpu:vulkan,... into a
// machine-name -> target-token map. Names are kept verbatim; matching against
// machines is performed case-insensitively at the call site.
static TargetOverrideMap parseTargetDevicesCsv(StringRef csv) {
  TargetOverrideMap out;
  if (csv.empty())
    return out;
  SmallVector<StringRef, 4> entries;
  csv.split(entries, ',', /*MaxSplit=*/-1, /*KeepEmpty=*/false);
  for (StringRef entry : entries) {
    auto colon = entry.find(':');
    if (colon == StringRef::npos)
      continue; // silently ignore malformed; the caller can validate.
    StringRef name = entry.substr(0, colon).trim();
    StringRef target = entry.substr(colon + 1).trim();
    if (name.empty() || target.empty())
      continue;
    out[name] = target.str();
  }
  return out;
}

void ApplyAffinityDirectivesPass::runOnOperation() {
  if (clScheduleSpecPath.empty())
    return; // no-op when no spec is provided.

  ModuleOp moduleOp = getOperation();
  MLIRContext *ctx = moduleOp.getContext();

  auto specOr = ScheduleSpec::loadFromFile(clScheduleSpecPath, ctx);
  if (failed(specOr)) {
    return signalPassFailure();
  }
  const ScheduleSpec &spec = *specOr;

  Attribute defaultAffinityAttr;
  if (!spec.defaultAffinity.empty()) {
    defaultAffinityAttr = buildAffinityAttr(ctx, spec.defaultAffinity);
    if (!defaultAffinityAttr) {
      moduleOp.emitError() << "schedule-spec '" << clScheduleSpecPath
                           << "': could not parse global default_affinity '"
                           << spec.defaultAffinity << "'";
      return signalPassFailure();
    }
  }

  // First pass: build all directive affinity attributes and collect the set
  // of device symbols they reference. We need the symbol set BEFORE walking
  // the IR so we can pre-create any missing util.global !hal.device decls;
  // otherwise the late HAL DeviceAnalysis pass would fail to resolve them.
  llvm::DenseMap<int64_t, Attribute> directiveAttrs;
  llvm::SmallSetVector<StringRef, 4> referencedSymbols;

  // Stable storage for symbol StringRefs derived from the spec.machines list:
  // we materialize "@device_X" symbols and stash the bare symbol names in this
  // SmallVector so the StringRefs in `referencedSymbols` remain valid for the
  // lifetime of the pass. Without this anchor, the StringRefs would dangle on
  // temporary std::strings.
  SmallVector<std::string, 4> machineSymStorage;
  auto addSymbol = [&](Attribute attr) {
    StringRef sym = extractDeviceSymbol(attr);
    if (!sym.empty())
      referencedSymbols.insert(sym);
  };
  addSymbol(defaultAffinityAttr);

  // Seed referencedSymbols from the spec's machines list so a schedule that
  // only declares machines (without per-dispatch directives) still creates
  // every global the runtime will look up. Each machines[i] maps to its
  // deviceMap entry (e.g. @device_a) and the bare leaf symbol becomes the
  // util.global name (device_a).
  for (const auto &m : spec.machines) {
    auto it = spec.deviceMap.find(m);
    if (it == spec.deviceMap.end())
      continue;
    StringRef devRef = it->second; // "@device_X"
    if (devRef.starts_with("@"))
      devRef = devRef.drop_front();
    machineSymStorage.emplace_back(devRef.str());
    referencedSymbols.insert(machineSymStorage.back());
  }

  for (const auto &kv : spec.directives) {
    if (kv.second.kind != DirectiveKind::Affinity)
      continue; // split/grow/shard handled elsewhere; ignore here.
    const auto &p = std::get<AffinityDirective>(kv.second.payload);
    Attribute attr = buildAffinityAttr(ctx, p.device);
    if (!attr) {
      moduleOp.emitError() << "schedule-spec '" << clScheduleSpecPath
                           << "': could not parse device '" << p.device
                           << "' for dispatch id " << kv.first;
      return signalPassFailure();
    }
    directiveAttrs[kv.first] = attr;
    addSymbol(attr);
  }

  // Build the per-symbol target-attr override map by intersecting the CSV
  // flag with the spec's machines list. Match machines case-insensitively
  // (CPU_P / cpu_p both work). The map keys are the bare symbol names
  // (e.g. "device_a"), so ensureDeviceGlobals can look them up directly.
  TargetOverrideMap csvByMachine = parseTargetDevicesCsv(clHalTargetDevices);
  TargetOverrideMap symbolTargets;
  for (const auto &m : spec.machines) {
    auto devIt = spec.deviceMap.find(m);
    if (devIt == spec.deviceMap.end())
      continue;
    StringRef devRef = devIt->second;
    if (devRef.starts_with("@"))
      devRef = devRef.drop_front();
    // First try exact, then lowercase match.
    auto csvIt = csvByMachine.find(m);
    if (csvIt == csvByMachine.end()) {
      csvIt = csvByMachine.find(StringRef(m).lower());
    }
    if (csvIt != csvByMachine.end()) {
      symbolTargets[devRef] = csvIt->getValue();
    }
  }

  if (failed(ensureDeviceGlobals(moduleOp, referencedSymbols.getArrayRef(),
                                 symbolTargets))) {
    return signalPassFailure();
  }

  // Default `stream.topology` for shared-DRAM platforms (QRB5165 class):
  // declare every schedule-spec device as having transparent access to
  // every other. Without this, ResolveTopologyQueriesPass cannot
  // resolve `hal.allocator.resolve_memory_properties` ops whose
  // affinity is `#hal.device.optimal<[a, b, ...]>` because it has no
  // way to know whether a buffer can be shared.
  //
  // Only set the attr if it isn't already user-provided. Materialize
  // bidirectional links between every pair of referenced symbols.
  if (!moduleOp->hasAttr("stream.topology")) {
    // Collect all hal.device globals (both prototypes and schedule-spec
    // synthesized) — cross-device buffer ops can reference any of them.
    SmallVector<std::string, 4> allDeviceSyms;
    for (auto globalOp : moduleOp.getOps<IREE::Util::GlobalOp>()) {
      if (isa<IREE::HAL::DeviceType>(globalOp.getType())) {
        allDeviceSyms.emplace_back(globalOp.getSymName().str());
      }
    }
    if (allDeviceSyms.size() > 1) {
      SmallVector<IREE::HAL::DeviceLinkAttr> links;
      for (size_t i = 0; i < allDeviceSyms.size(); ++i) {
        auto srcRef = FlatSymbolRefAttr::get(ctx, allDeviceSyms[i]);
        for (size_t j = 0; j < allDeviceSyms.size(); ++j) {
          if (i == j) continue;
          auto dstRef = FlatSymbolRefAttr::get(ctx, allDeviceSyms[j]);
          links.push_back(IREE::HAL::DeviceLinkAttr::get(
              ctx, srcRef, dstRef,
              /*unified_memory=*/true,
              /*transparent_access=*/true,
              /*extra_properties=*/DictionaryAttr{}));
        }
      }
      moduleOp->setAttr("stream.topology",
                         IREE::HAL::DeviceTopologyAttr::get(ctx, links));
    }
  }

  moduleOp.walk([&](IREE::Flow::DispatchWorkgroupsOp wg) {
    auto idAttr = wg->getAttrOfType<IntegerAttr>("iree.dispatch_id");
    if (!idAttr)
      return;

    int64_t id = idAttr.getInt();
    Attribute toApply = defaultAffinityAttr;

    auto it = directiveAttrs.find(id);
    if (it != directiveAttrs.end()) {
      toApply = it->second;
    }

    if (toApply) {
      wg->setAttr("stream.affinity", toApply);
    }
  });
}

} // namespace mlir::iree_compiler::DispatchCreation
