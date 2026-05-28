// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Sibling to DumpExecutableBenchmarks.cpp. Emits one func.func per dispatch
// with !hal.buffer arguments, suitable for end-to-end chaining with real data
// (no synthetic batch loop, no shared global buffer). Each function performs
// exactly one dispatch using the caller-supplied buffers as bindings.
//
// A manifest.json is written alongside the per-(executable,variant) module
// listing every emitted dispatch's bindings (byte size, binding index) so that
// downstream tools can construct buffer_views from manifest data.

#include <memory>
#include <string>
#include <utility>

#include "iree/compiler/Dialect/HAL/Analysis/DeviceAnalysis.h"
#include "iree/compiler/Dialect/HAL/IR/HALDialect.h"
#include "iree/compiler/Dialect/HAL/IR/HALOps.h"
#include "iree/compiler/Dialect/HAL/Transforms/Passes.h"
#include "iree/compiler/Dialect/Stream/IR/StreamOps.h"
#include "iree/compiler/Dialect/Util/IR/UtilDialect.h"
#include "iree/compiler/Utils/IntegerSet.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/ToolOutputFile.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/Dominance.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Transforms/CSE.h"

#define DEBUG_TYPE "iree-dump-executable-dispatch-modules"

namespace mlir::iree_compiler::IREE::HAL {

#define GEN_PASS_DEF_DUMPEXECUTABLEDISPATCHMODULESPASS
#include "iree/compiler/Dialect/HAL/Transforms/Passes.h.inc"

namespace {

struct Binding {
  unsigned binding = 0;
  int64_t size = 0;
};

// Same as the DumpExecutableBenchmarks dispatch params (deliberately mirrored
// so the gather walk below stays aligned with the upstream pass; we will
// extract this into a shared helper in a follow-up).
struct DispatchParams {
  SmallVector<Location> locs;
  SetVector<IREE::Stream::AffinityAttr> affinities;
  SmallVector<unsigned> workload;
  SmallVector<Binding> bindings;
  SmallVector<TypedAttr> uniformOperands;
};

using DispatchParamsMap =
    llvm::DenseMap<SymbolRefAttr,
                   llvm::MapVector<SmallVector<unsigned>, DispatchParams>>;

static DispatchParamsMap gatherDispatchParams(mlir::ModuleOp moduleOp) {
  DispatchParamsMap map;
  for (auto funcOp : moduleOp.getOps<mlir::FunctionOpInterface>()) {
    funcOp.walk([&](IREE::Stream::CmdDispatchOp dispatchOp) {
      auto affinityAttr = dyn_cast_if_present<IREE::HAL::DeviceAffinityAttr>(
          IREE::Stream::AffinityAttr::lookup(dispatchOp));
      if (!affinityAttr) {
        return;
      }
      SmallVector<unsigned> workload;
      workload.reserve(dispatchOp.getWorkload().size());
      for (auto workloadValue : dispatchOp.getWorkload()) {
        APInt v;
        if (!matchPattern(workloadValue, m_ConstantInt(&v))) {
          return;
        }
        workload.push_back(v.getSExtValue());
      }
      SmallVector<TypedAttr> uniformOperands;
      for (auto operand : dispatchOp.getUniformOperands()) {
        TypedAttr a;
        if (!matchPattern(operand, m_Constant(&a))) {
          return;
        }
        uniformOperands.push_back(a);
      }
      dispatchOp.forEachEntryPointAttr([&](SymbolRefAttr entryPointAttr) {
        SmallVector<Binding> bindings;
        for (auto [i, resourceLength] :
             llvm::enumerate(dispatchOp.getResourceLengths())) {
          APInt v;
          if (!matchPattern(resourceLength, m_ConstantInt(&v))) {
            return;
          }
          bindings.push_back({(unsigned)i, v.getSExtValue()});
        }
        auto &set = map[entryPointAttr];
        DispatchParams &p = set[workload];
        p.locs.push_back(dispatchOp.getLoc());
        p.affinities.insert(affinityAttr);
        p.workload = workload;
        p.bindings = std::move(bindings);
        p.uniformOperands = std::move(uniformOperands);
      });
    });
  }
  return map;
}

static std::pair<Value, Value>
getDeviceAndQueueAffinity(Location loc, IREE::Stream::AffinityAttr affinityAttr,
                          OpBuilder &builder) {
  if (auto deviceAffinityAttr =
          dyn_cast_if_present<IREE::HAL::DeviceAffinityAttr>(affinityAttr)) {
    auto resolveOp = IREE::HAL::DeviceResolveOp::create(
        builder, loc,
        TypeRange{
            builder.getType<IREE::HAL::DeviceType>(),
            builder.getI64Type(),
        },
        deviceAffinityAttr);
    return std::make_pair(resolveOp.getResult(0), resolveOp.getResult(1));
  }
  auto device = IREE::HAL::DeviceType::resolveAny(loc, builder);
  auto queueAffinity = arith::ConstantIntOp::create(builder, loc, -1, 64);
  return std::make_pair(device, queueAffinity);
}

// Emits a func.func that takes one !hal.buffer arg per binding and runs the
// referenced dispatch exactly once with those buffers as the bindings.
// Returns nothing; output bindings are written in-place by the dispatch.
static func::FuncOp
appendDispatchEntryFunc(IREE::Stream::AffinityAttr affinityAttr,
                        IREE::HAL::ExecutableOp executableOp,
                        IREE::HAL::ExecutableVariantOp variantOp,
                        IREE::HAL::ExecutableExportOp exportOp,
                        const DispatchParams &dispatchParams,
                        OpBuilder &moduleBuilder) {
  auto loc = FusedLoc::get(executableOp.getContext(), dispatchParams.locs);

  std::string baseName = (executableOp.getName() + "_" + variantOp.getName() +
                          "_" + exportOp.getName())
                             .str();
  if (!dispatchParams.workload.empty()) {
    baseName += "_" + std::to_string(dispatchParams.workload[0]);
    for (size_t i = 1; i < dispatchParams.workload.size(); ++i) {
      baseName += "x" + std::to_string(dispatchParams.workload[i]);
    }
  }

  // One !hal.buffer_view arg per binding (ABI-friendly so the function can
  // be driven by iree-benchmark-module / iree_runtime_call_inputs_push_*_view).
  // Inside the function we extract the underlying !hal.buffer for the dispatch.
  SmallVector<Type> argTypes(dispatchParams.bindings.size(),
                             moduleBuilder.getType<IREE::HAL::BufferViewType>());
  auto funcType = moduleBuilder.getFunctionType(argTypes, /*results=*/{});
  auto funcOp = func::FuncOp::create(moduleBuilder, loc, baseName, funcType);
  funcOp.setVisibility(SymbolTable::Visibility::Public);
  // Help downstream tooling identify these as merlin-emitted per-dispatch
  // entry points (vs. the upstream benchmark wrappers).
  funcOp->setAttr("merlin.dispatch_entry", moduleBuilder.getUnitAttr());

  auto *entryBlock = funcOp.addEntryBlock();
  OpBuilder b = OpBuilder::atBlockBegin(entryBlock);
  IndexSet indexSet(loc, b);

  // Extract the underlying !hal.buffer from each buffer_view arg.
  SmallVector<Value> bindingBuffers;
  bindingBuffers.reserve(dispatchParams.bindings.size());
  for (auto bvArg : entryBlock->getArguments()) {
    auto bufOp = IREE::HAL::BufferViewBufferOp::create(
        b, loc, b.getType<IREE::HAL::BufferType>(), bvArg);
    bindingBuffers.push_back(bufOp.getResult());
  }

  auto [device, queueAffinity] =
      getDeviceAndQueueAffinity(loc, affinityAttr, b);

  // OneShot only. We deliberately drop AllowInlineExecution — when the
  // wrapper is standalone-recompiled for QNN, the QNN HAL device routes
  // inline command buffers through iree_hal_inline_command_buffer, whose
  // dispatch handler invalidly casts the QNN executable as a
  // local_executable and reads garbage from a dispatch_attrs[] table that
  // QNN never populates. Result: random "constant count mismatch
  // expected N provided 0" failures. With OneShot-only, QNN takes the
  // deferred-command-buffer path which doesn't do that cast.
  auto commandBufferModes = IREE::HAL::CommandBufferModeBitfield::OneShot;
  auto commandBuffer =
      IREE::HAL::CommandBufferCreateOp::create(
          b, loc, b.getType<IREE::HAL::CommandBufferType>(), device,
          commandBufferModes, IREE::HAL::CommandCategoryBitfield::Dispatch,
          queueAffinity, /*binding_capacity=*/Value{})
          .getResult();

  auto layoutAttr = exportOp.getLayoutAttr();
  SmallVector<Value> constantValues;
  if (int64_t pushConstantCount = layoutAttr.getConstants()) {
    // Variant-specific layouts (notably QNN) may declare more push
    // constants than the source dispatch provides — the QNN backend
    // injects target-specific metadata slots. Push the source-known
    // values first, then zero-pad up to the declared count.
    constantValues.reserve(pushConstantCount);
    int64_t source_count =
        (int64_t)dispatchParams.uniformOperands.size();
    int64_t take_from_source = std::min(source_count, pushConstantCount);
    for (int64_t i = 0; i < take_from_source; ++i) {
      constantValues.push_back(arith::ConstantOp::create(
          b, loc, dispatchParams.uniformOperands[i]));
    }
    for (int64_t i = take_from_source; i < pushConstantCount; ++i) {
      constantValues.push_back(arith::ConstantIntOp::create(b, loc, 0, 32));
    }
  }

  // Bindings — each is the !hal.buffer extracted from the buffer_view arg.
  SmallVector<BindingValue> bindingValues;
  for (auto [i, binding] : llvm::enumerate(dispatchParams.bindings)) {
    BindingValue bv;
    bv.buffer = bindingBuffers[i];
    bv.byteOffset = indexSet.get(0);
    bv.byteLength = indexSet.get(binding.size);
    bindingValues.push_back(bv);
  }

  auto exportRefAttr =
      SymbolRefAttr::get(executableOp.getNameAttr(),
                         {
                             SymbolRefAttr::get(variantOp.getNameAttr()),
                             SymbolRefAttr::get(exportOp.getNameAttr()),
                         });

  auto workload = llvm::map_to_vector(
      dispatchParams.workload, [&](unsigned dim) { return indexSet.get(dim); });
  auto workgroupCountOp = IREE::HAL::ExecutableCalculateWorkgroupsOp::create(
      b, loc, b.getIndexType(), b.getIndexType(), b.getIndexType(), device,
      exportRefAttr, workload);

  Value executable = IREE::HAL::ExecutableLookupOp::create(
      b, loc, b.getType<IREE::HAL::ExecutableType>(), device,
      exportRefAttr.getRootReference().getValue());
  Value ordinal = IREE::HAL::ExecutableExportOrdinalOp::create(
      b, loc, b.getIndexType(), exportRefAttr);

  IREE::HAL::CommandBufferDispatchOp::create(
      b, loc, commandBuffer, executable, ordinal,
      workgroupCountOp.getResults(), constantValues, bindingValues,
      IREE::HAL::DispatchFlags::None);

  IREE::HAL::CommandBufferFinalizeOp::create(b, loc, commandBuffer);

  Value waitFence = IREE::Util::NullOp::create(
      b, loc, b.getType<IREE::HAL::FenceType>());
  Value signalFence = IREE::HAL::FenceCreateOp::create(
      b, loc, b.getType<IREE::HAL::FenceType>(), device,
      IREE::HAL::FenceFlagBitfield::None);

  IREE::HAL::DeviceQueueExecuteOp::create(
      b, loc, device, queueAffinity, waitFence, signalFence, commandBuffer,
      IREE::HAL::ExecuteFlagBitfield::None);

  Value timeoutMillis = arith::ConstantIntOp::create(b, loc, -1, 32);
  auto fenceOp = IREE::HAL::FenceAwaitOp::create(
      b, loc, b.getI32Type(), timeoutMillis,
      IREE::HAL::WaitFlagBitfield::None, signalFence);
  IREE::Util::StatusCheckOkOp::create(b, loc, fenceOp.getStatus(),
                                      "failed to wait on dispatch fence");

  func::ReturnOp::create(b, loc);
  return funcOp;
}

// Builds a module exporting one func.func per dispatch configuration.
// Returns the module + a manifest entries list (one per emitted func) for
// the caller to write to manifest.json.
struct EmittedDispatch {
  std::string funcName;
  std::string entryPoint;
  SmallVector<int64_t> bindingSizes;
  SmallVector<unsigned> workload;
  std::string affinityStr;
};

static std::pair<mlir::OwningOpRef<mlir::ModuleOp>,
                 SmallVector<EmittedDispatch>>
buildDispatchModule(IREE::HAL::ExecutableOp sourceExecutableOp,
                    IREE::HAL::ExecutableVariantOp sourceVariantOp,
                    const DispatchParamsMap &dispatchParamsMap,
                    DeviceAnalysis &deviceAnalysis) {
  SmallVector<EmittedDispatch> manifest;

  mlir::OwningOpRef<mlir::ModuleOp> moduleOp =
      mlir::ModuleOp::create(sourceExecutableOp.getLoc());
  auto moduleBuilder = OpBuilder::atBlockBegin(moduleOp->getBody());

  for (auto globalOp : deviceAnalysis.getDeviceGlobals()) {
    moduleBuilder.clone(*globalOp.getOperation());
  }

  auto executableOp = IREE::HAL::ExecutableOp::create(
      moduleBuilder, sourceExecutableOp.getLoc(), sourceExecutableOp.getName());
  executableOp.setVisibility(sourceExecutableOp.getVisibility());
  auto variantOp = cast<IREE::HAL::ExecutableVariantOp>(
      OpBuilder::atBlockBegin(&executableOp.getBlock())
          .clone(*sourceVariantOp.getOperation()));

  bool hasAny = false;
  for (auto exportOp : variantOp.getExportOps()) {
    auto symbolRefAttr =
        SymbolRefAttr::get(executableOp.getNameAttr(),
                           {
                               FlatSymbolRefAttr::get(variantOp.getNameAttr()),
                               FlatSymbolRefAttr::get(exportOp.getNameAttr()),
                           });
    auto it = dispatchParamsMap.find(symbolRefAttr);
    if (it == dispatchParamsMap.end()) {
      continue;
    }
    for (auto &[_, dispatchParams] : it->second) {
      auto emitOne = [&](IREE::Stream::AffinityAttr affinity) {
        auto funcOp = appendDispatchEntryFunc(affinity, executableOp, variantOp,
                                              exportOp, dispatchParams,
                                              moduleBuilder);
        EmittedDispatch entry;
        entry.funcName = funcOp.getName().str();
        entry.entryPoint = symbolRefAttr.getRootReference().str() + "::" +
                           variantOp.getName().str() + "::" +
                           exportOp.getName().str();
        for (auto &b : dispatchParams.bindings) {
          entry.bindingSizes.push_back(b.size);
        }
        entry.workload = dispatchParams.workload;
        if (affinity) {
          llvm::raw_string_ostream os(entry.affinityStr);
          os << affinity;
        }
        manifest.push_back(std::move(entry));
        hasAny = true;
      };
      if (dispatchParams.affinities.empty()) {
        emitOne({});
      } else {
        for (auto affinityAttr : dispatchParams.affinities) {
          emitOne(affinityAttr);
        }
      }
    }
  }

  if (!hasAny) {
    return std::make_pair(mlir::OwningOpRef<mlir::ModuleOp>{},
                          SmallVector<EmittedDispatch>{});
  }

  IRRewriter rewriter(moduleOp->getContext());
  DominanceInfo domInfo;
  mlir::eliminateCommonSubExpressions(rewriter, domInfo, moduleOp.get());
  return {std::move(moduleOp), std::move(manifest)};
}

static void dumpModuleToFile(mlir::ModuleOp moduleOp,
                             llvm::raw_ostream &os) {
  OpPrintingFlags flags;
  flags.useLocalScope();
  moduleOp.print(os, flags);
  os << "\n";
}

static void writeManifest(StringRef filePath,
                          ArrayRef<EmittedDispatch> entries) {
  llvm::json::Array arr;
  for (auto &e : entries) {
    llvm::json::Object obj;
    obj["func"] = e.funcName;
    obj["entry_point"] = e.entryPoint;
    if (!e.affinityStr.empty()) {
      obj["affinity"] = e.affinityStr;
    }
    llvm::json::Array sizes;
    for (auto s : e.bindingSizes) {
      sizes.push_back(s);
    }
    obj["binding_byte_sizes"] = std::move(sizes);
    llvm::json::Array wl;
    for (auto w : e.workload) {
      wl.push_back((int64_t)w);
    }
    obj["workload"] = std::move(wl);
    arr.push_back(std::move(obj));
  }
  std::string error;
  auto file = mlir::openOutputFile(filePath, &error);
  if (!file) {
    llvm::errs() << "DumpExecutableDispatchModules: failed to open " << filePath
                 << ": " << error << "\n";
    return;
  }
  file->os() << llvm::formatv("{0:2}", llvm::json::Value(std::move(arr)))
             << "\n";
  file->keep();
}

//===----------------------------------------------------------------------===//
// --iree-hal-dump-executable-dispatch-modules
//===----------------------------------------------------------------------===//

struct DumpExecutableDispatchModulesPass
    : IREE::HAL::impl::DumpExecutableDispatchModulesPassBase<
          DumpExecutableDispatchModulesPass> {
  using IREE::HAL::impl::DumpExecutableDispatchModulesPassBase<
      DumpExecutableDispatchModulesPass>::
      DumpExecutableDispatchModulesPassBase;
  void runOnOperation() override {
    mlir::ModuleOp moduleOp = getOperation();
    auto moduleName = moduleOp.getName().value_or("module");

    DeviceAnalysis deviceAnalysis(moduleOp);
    if (failed(deviceAnalysis.run())) {
      return signalPassFailure();
    }
    if (deviceAnalysis.getDeviceGlobals().empty()) {
      mlir::emitRemark(moduleOp.getLoc())
          << "Per-dispatch dump requested but no devices declared.\n";
      return;
    }
    if (deviceAnalysis.getDeviceGlobals().size() != 1) {
      mlir::emitWarning(moduleOp.getLoc())
          << "Per-dispatch dump: multiple devices not yet supported.\n";
      return;
    }

    auto dispatchParamsMap = gatherDispatchParams(moduleOp);
    if (dispatchParamsMap.empty()) {
      mlir::emitRemark(moduleOp.getLoc())
          << "Per-dispatch dump requested but no dumpable dispatches found.\n";
      return;
    }

    if (!path.empty() && path != "-") {
      llvm::sys::fs::create_directories(path);
    }

    for (auto executableOp : moduleOp.getOps<IREE::HAL::ExecutableOp>()) {
      for (auto variantOp :
           executableOp.getOps<IREE::HAL::ExecutableVariantOp>()) {
        auto [dispatchModuleOp, manifest] = buildDispatchModule(
            executableOp, variantOp, dispatchParamsMap, deviceAnalysis);
        if (!dispatchModuleOp) {
          continue;
        }
        std::string baseName = (moduleName + "_" + executableOp.getName() +
                                "_" + variantOp.getName())
                                   .str();
        std::string mlirName = baseName + "_dispatches.mlir";
        std::string manifestName = baseName + "_dispatches.manifest.json";
        if (path.empty() || path == "-") {
          dumpModuleToFile(*dispatchModuleOp, llvm::outs());
        } else {
          auto sep = llvm::sys::path::get_separator();
          auto mlirPath = (path + sep + mlirName).str();
          auto manifestPath = (path + sep + manifestName).str();
          std::string error;
          auto file = mlir::openOutputFile(mlirPath, &error);
          if (!file) {
            executableOp.emitError()
                << "while dumping to " << path << ": " << error;
            return signalPassFailure();
          }
          dumpModuleToFile(*dispatchModuleOp, file->os());
          file->keep();
          writeManifest(manifestPath, manifest);
        }
      }
    }
  }
};

} // namespace

} // namespace mlir::iree_compiler::IREE::HAL
