// Copyright 2026
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include <memory>
#include <utility>

#include "iree/compiler/Dialect/HAL/Analysis/DeviceAnalysis.h"
#include "iree/compiler/Dialect/HAL/IR/HALDialect.h"
#include "iree/compiler/Dialect/HAL/IR/HALOps.h"
#include "iree/compiler/Dialect/HAL/Transforms/Passes.h"
#include "iree/compiler/Dialect/Stream/IR/StreamOps.h"
#include "iree/compiler/Dialect/Util/IR/UtilDialect.h"
#include "iree/compiler/Utils/IntegerSet.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/ToolOutputFile.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Dominance.h"
#include "mlir/IR/Builders.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Transforms/CSE.h"
#include "mlir/Transforms/Passes.h"

#define DEBUG_TYPE "iree-dump-executable-async-dispatches"

namespace mlir::iree_compiler::IREE::HAL {

#define GEN_PASS_DEF_DUMPEXECUTABLEASYNCDISPATCHESPASS
#include "iree/compiler/Dialect/HAL/Transforms/Passes.h.inc"

namespace {

// We could use the resource constraints in the module when we have them.
static const int64_t kBufferAlignment = 256;

struct Binding {
  unsigned binding = 0;
  int64_t size = 0;
};

// Combined data for all dispatches of a particular static workload size.
struct DispatchParams {
  // All locations that dispatch with these parameters.
  SmallVector<Location> locs;
  // All affinities that dispatch with these parameters.
  // Empty if no affinities were specified.
  SetVector<IREE::Stream::AffinityAttr> affinities;
  // Workload used as input to the workgroup count calculation function.
  SmallVector<unsigned> workload;
  // Analyzed minimum binding sizes.
  SmallVector<Binding> bindings;
  // Push constant operands that are known constant. May be null if dynamic.
  SmallVector<TypedAttr> uniformOperands;
};

// Nested map of entry point -> workload -> DispatchParams.
using DispatchParamsMap =
    llvm::DenseMap<SymbolRefAttr,
                   llvm::MapVector<SmallVector<unsigned>, DispatchParams>>;

// Walk |moduleOp| and gather all of the dispatches to each executable.
// Dispatch parameters are deduplicated by workload so that there's only ever
// one entry for all dispatches with a given workgroup count.
// Dispatches will be ignored if they have a dynamic workload or any dynamically
// sized resources.
static DispatchParamsMap gatherDispatchParams(mlir::ModuleOp moduleOp,
                                              SymbolTable &symbolTable) {
  DispatchParamsMap map;

  for (auto funcOp : moduleOp.getOps<mlir::FunctionOpInterface>()) {
    funcOp.walk([&](IREE::Stream::CmdDispatchOp dispatchOp) {
      auto affinityAttr = dyn_cast_if_present<IREE::HAL::DeviceAffinityAttr>(
          IREE::Stream::AffinityAttr::lookup(dispatchOp));
      if (!affinityAttr) {
        LLVM_DEBUG(
            llvm::dbgs()
            << "skipping dispatch because it has no affinity specified\n");
        return;
      }

      auto workloadValues = dispatchOp.getWorkload();
      SmallVector<unsigned> workload;
      workload.reserve(workloadValues.size());
      for (auto workloadValue : workloadValues) {
        APInt workloadConstValue;
        if (!matchPattern(workloadValue, m_ConstantInt(&workloadConstValue))) {
          LLVM_DEBUG({
            auto firstEntryPoint = *dispatchOp.getEntryPointRefs().begin();
            llvm::dbgs() << "skipping dispatch of entry point `"
                         << firstEntryPoint << "` (non-constant workload)\n";
          });
          return;
        }
        workload.push_back(workloadConstValue.getSExtValue());
      }

      SmallVector<TypedAttr> uniformOperands;
      for (auto operand : dispatchOp.getUniformOperands()) {
        TypedAttr uniformOperand;
        if (!matchPattern(operand, m_Constant(&uniformOperand))) {
          LLVM_DEBUG({
            auto firstEntryPoint = *dispatchOp.getEntryPointRefs().begin();
            llvm::dbgs() << "Skipping dispatch of entry point `"
                         << firstEntryPoint
                         << "` (non-constant uniform operand)\n";
          });
          return;
        }
        uniformOperands.push_back(uniformOperand);
      }

      dispatchOp.forEachEntryPointAttr([&](SymbolRefAttr entryPointAttr) {
        SmallVector<Binding> bindings;
        for (auto [i, resourceLength] :
             llvm::enumerate(dispatchOp.getResourceLengths())) {
          APInt resourceLengthInt;
          if (!matchPattern(resourceLength, m_ConstantInt(&resourceLengthInt))) {
            LLVM_DEBUG({
              llvm::dbgs() << "skipping dispatch of entry point `"
                           << entryPointAttr
                           << "` (non-constant resource length)\n";
            });
            return;
          }
          bindings.push_back({(unsigned)i, resourceLengthInt.getSExtValue()});
        }

        auto &dispatchParamsSet = map[entryPointAttr];
        DispatchParams &dispatchParams = dispatchParamsSet[workload];
        dispatchParams.locs.push_back(dispatchOp.getLoc());
        dispatchParams.affinities.insert(affinityAttr);
        dispatchParams.workload = workload;
        dispatchParams.bindings = std::move(bindings);
        dispatchParams.uniformOperands = std::move(uniformOperands);
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

// Appends a global hal.buffer initialized to the size required for all
// of the bindings in |dispatchParams| (plus alignment).
static IREE::Util::GlobalOp appendGlobalBuffer(
    Location loc, StringRef baseName, const DispatchParams &dispatchParams,
    IREE::Stream::AffinityAttr affinityAttr, OpBuilder &moduleBuilder) {
  // Create a global to hold the HAL buffer.
  auto globalOp = IREE::Util::GlobalOp::create(
      moduleBuilder, loc, (baseName + "_buffer").str(),
      /*isMutable=*/true,
      IREE::HAL::BufferType::get(moduleBuilder.getContext()));
  globalOp.setPrivate();

  // Compute the total size of the buffer based on all binding sizes when
  // aligned.
  int64_t totalLength = 0;
  for (auto binding : dispatchParams.bindings) {
    totalLength =
        IREE::Util::align(totalLength + binding.size, kBufferAlignment);
  }

  // Build an initializer to allocate the buffer.
  moduleBuilder.setInsertionPointAfter(globalOp);
  auto initOp = IREE::Util::InitializerOp::create(moduleBuilder, loc);
  auto initBuilder = OpBuilder::atBlockBegin(initOp.addEntryBlock());
  IndexSet indexSet(loc, initBuilder);

  auto [device, queueAffinity] =
      getDeviceAndQueueAffinity(loc, affinityAttr, initBuilder);
  auto allocator =
      IREE::HAL::DeviceAllocatorOp::create(initBuilder, loc, device)
          .getResult();

  auto memoryTypes = IREE::HAL::MemoryTypeBitfield::DeviceLocal;
  auto bufferUsage = IREE::HAL::BufferUsageBitfield::Transfer |
                     IREE::HAL::BufferUsageBitfield::DispatchStorage;
  Value memoryTypeOp =
      IREE::HAL::MemoryTypeOp::create(initBuilder, loc, memoryTypes);
  Value bufferUsageOp =
      IREE::HAL::BufferUsageOp::create(initBuilder, loc, bufferUsage);
  auto allocateOp = IREE::HAL::AllocatorAllocateOp::create(
      initBuilder, loc, globalOp.getType(), allocator, queueAffinity,
      memoryTypeOp, bufferUsageOp, indexSet.get(totalLength));

  globalOp.createStoreOp(loc, allocateOp.getResult(), initBuilder);
  IREE::Util::ReturnOp::create(initBuilder, loc);

  return globalOp;
}

// Appends an async scheduler wrapper calling the given |exportOp| with
// |dispatchParams|.
//
// ABI:
//   (%iters: i32, %wait_fence: !hal.fence, %signal_fence: !hal.fence) -> ()
//
// Unlike the benchmark wrapper, this does NOT create or await fences internally.
// The caller is responsible for timeline/fence orchestration.
static void appendDispatchAsyncWrapper(
    IREE::Stream::AffinityAttr affinityAttr,
    IREE::HAL::ExecutableOp executableOp,
    IREE::HAL::ExecutableVariantOp variantOp,
    IREE::HAL::ExecutableExportOp exportOp,
    DispatchParams dispatchParams,
    OpBuilder &moduleBuilder) {
  auto loc = FusedLoc::get(executableOp.getContext(), dispatchParams.locs);

  std::string baseName = (executableOp.getName() + "_" + variantOp.getName() +
                          "_" + exportOp.getName() + "_async")
                             .str();
  if (!dispatchParams.workload.empty()) {
    baseName += "_" + std::to_string(dispatchParams.workload[0]);
    for (size_t i = 1; i < dispatchParams.workload.size(); ++i) {
      baseName += "x" + std::to_string(dispatchParams.workload[i]);
    }
  }

  auto bufferGlobalOp = appendGlobalBuffer(
      loc, baseName, dispatchParams, affinityAttr, moduleBuilder);

  auto fenceType = IREE::HAL::FenceType::get(moduleBuilder.getContext());
  auto funcType = moduleBuilder.getFunctionType(
      {moduleBuilder.getI32Type(), fenceType, fenceType}, {});
  auto funcOp =
      IREE::Util::FuncOp::create(moduleBuilder, loc, baseName, funcType);
  funcOp.setVisibility(SymbolTable::Visibility::Public);

  // Required for ABI lowering.
  funcOp->setAttr("iree.abi.stub", moduleBuilder.getUnitAttr());
  // Optional marker to make these easy to identify downstream.
  funcOp->setAttr(
      "iree.reflection",
      moduleBuilder.getDictionaryAttr({
          moduleBuilder.getNamedAttr("merlin.scheduler",
                                     moduleBuilder.getStringAttr("dispatch_async")),
      }));

  auto *entryBlock = funcOp.addEntryBlock();
  OpBuilder funcBuilder = OpBuilder::atBlockBegin(entryBlock);
  IndexSet indexSet(loc, funcBuilder);

  auto batchSizeArg = arith::IndexCastOp::create(
      funcBuilder, loc, funcBuilder.getIndexType(), entryBlock->getArgument(0));
  Value waitFence = entryBlock->getArgument(1);
  Value signalFence = entryBlock->getArgument(2);

  auto [device, queueAffinity] =
      getDeviceAndQueueAffinity(loc, affinityAttr, funcBuilder);

  auto commandBufferModes =
      IREE::HAL::CommandBufferModeBitfield::OneShot;
  auto commandBuffer =
      IREE::HAL::CommandBufferCreateOp::create(
          funcBuilder, loc, funcBuilder.getType<IREE::HAL::CommandBufferType>(),
          device, commandBufferModes,
          IREE::HAL::CommandCategoryBitfield::Dispatch, queueAffinity,
          /*binding_capacity=*/Value{})
          .getResult();

  // Constant values.
  auto layoutAttr = exportOp.getLayoutAttr();
  SmallVector<Value> constantValues;
  if (int64_t pushConstantCount = layoutAttr.getConstants()) {
    constantValues.reserve(pushConstantCount);
    for (int64_t i = 0; i < pushConstantCount; ++i) {
      constantValues.push_back(arith::ConstantOp::create(
          funcBuilder, loc, dispatchParams.uniformOperands[i]));
    }
  }

  // Binding values.
  Value buffer =
      bufferGlobalOp.createLoadOp(loc, funcBuilder).getLoadedGlobalValue();
  SmallVector<BindingValue> bindingValues;
  int64_t bufferOffset = 0;
  for (auto binding : dispatchParams.bindings) {
    BindingValue bindingValue;
    bindingValue.buffer = buffer;
    bindingValue.byteOffset = indexSet.get(bufferOffset);
    bindingValue.byteLength = indexSet.get(binding.size);
    bindingValues.push_back(bindingValue);
    bufferOffset =
        IREE::Util::align(bufferOffset + binding.size, kBufferAlignment);
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
      funcBuilder, loc, funcBuilder.getIndexType(), funcBuilder.getIndexType(),
      funcBuilder.getIndexType(), device, exportRefAttr, workload);

  Value executable = IREE::HAL::ExecutableLookupOp::create(
      funcBuilder, loc, funcBuilder.getType<IREE::HAL::ExecutableType>(),
      device, exportRefAttr.getRootReference().getValue());
  Value ordinal = IREE::HAL::ExecutableExportOrdinalOp::create(
      funcBuilder, loc, funcBuilder.getIndexType(), exportRefAttr);

  // Loop around dispatches based on batch size.
  // Keep the same execution barrier behavior as the benchmark pass so one
  // wrapper call still serializes repeated iterations within that call.
  scf::ForOp::create(
      funcBuilder, loc, indexSet.get(0), batchSizeArg, indexSet.get(1),
      ValueRange{},
      [&](OpBuilder &forBuilder, Location loopLoc, Value iv,
          ValueRange iterArgs) {
        IREE::HAL::CommandBufferDispatchOp::create(
            forBuilder, loopLoc, commandBuffer, executable, ordinal,
            workgroupCountOp.getResults(), constantValues, bindingValues,
            IREE::HAL::DispatchFlags::None);

        auto sourceStage = IREE::HAL::ExecutionStageBitfield::CommandRetire |
                           IREE::HAL::ExecutionStageBitfield::Dispatch;
        auto targetStage = IREE::HAL::ExecutionStageBitfield::CommandIssue |
                           IREE::HAL::ExecutionStageBitfield::Dispatch;
        auto barrierFlags = IREE::HAL::ExecutionBarrierFlagBitfield::None;
        IREE::HAL::CommandBufferExecutionBarrierOp::create(
            forBuilder, loopLoc, commandBuffer, sourceStage, targetStage,
            barrierFlags);

        scf::YieldOp::create(forBuilder, loopLoc);
      });

  IREE::HAL::CommandBufferFinalizeOp::create(funcBuilder, loc, commandBuffer);

  // Submit using caller-provided fences and return immediately.
  IREE::HAL::DeviceQueueExecuteOp::create(
      funcBuilder, loc, device, queueAffinity, waitFence, signalFence,
      commandBuffer, IREE::HAL::ExecuteFlagBitfield::None);

  IREE::Util::ReturnOp::create(funcBuilder, loc);
}

// Builds a module exporting one function for each dispatch configuration
// targeting |sourceExecutableOp|.
static mlir::OwningOpRef<mlir::ModuleOp>
buildAsyncModule(IREE::HAL::ExecutableOp sourceExecutableOp,
                 IREE::HAL::ExecutableVariantOp sourceVariantOp,
                 const DispatchParamsMap &dispatchParamsMap,
                 DeviceAnalysis &deviceAnalysis) {
  mlir::OwningOpRef<mlir::ModuleOp> moduleOp =
      mlir::ModuleOp::create(sourceExecutableOp.getLoc());
  auto moduleBuilder = OpBuilder::atBlockBegin(moduleOp->getBody());

  // Copy device globals from the original module.
  for (auto globalOp : deviceAnalysis.getDeviceGlobals()) {
    moduleBuilder.clone(*globalOp.getOperation());
  }

  // Clone the executable variant into the new module.
  auto executableOp = IREE::HAL::ExecutableOp::create(
      moduleBuilder, sourceExecutableOp.getLoc(), sourceExecutableOp.getName());
  executableOp.setVisibility(sourceExecutableOp.getVisibility());
  auto variantOp = cast<IREE::HAL::ExecutableVariantOp>(
      OpBuilder::atBlockBegin(&executableOp.getBlock())
          .clone(*sourceVariantOp.getOperation()));

  bool hasAnyWrappers = false;
  for (auto exportOp : variantOp.getExportOps()) {
    auto symbolRefAttr =
        SymbolRefAttr::get(executableOp.getNameAttr(),
                           {
                               FlatSymbolRefAttr::get(variantOp.getNameAttr()),
                               FlatSymbolRefAttr::get(exportOp.getNameAttr()),
                           });
    auto dispatchParamsSet = dispatchParamsMap.find(symbolRefAttr);
    if (dispatchParamsSet == dispatchParamsMap.end()) continue;

    for (auto &[_, dispatchParams] : dispatchParamsSet->second) {
      if (dispatchParams.affinities.empty()) {
        appendDispatchAsyncWrapper({}, executableOp, variantOp, exportOp,
                                   dispatchParams, moduleBuilder);
      } else {
        for (auto affinityAttr : dispatchParams.affinities) {
          appendDispatchAsyncWrapper(affinityAttr, executableOp, variantOp,
                                     exportOp, dispatchParams, moduleBuilder);
        }
      }
      hasAnyWrappers = true;
    }
  }

  if (!hasAnyWrappers) {
    return {};
  }

  IRRewriter rewriter(moduleOp->getContext());
  DominanceInfo domInfo;
  mlir::eliminateCommonSubExpressions(rewriter, domInfo, moduleOp.get());

  return moduleOp;
}

static void dumpModuleToStream(mlir::ModuleOp moduleOp, StringRef fileName,
                               llvm::raw_ostream &os) {
  OpPrintingFlags flags;
  flags.useLocalScope();
  moduleOp.print(os, flags);
  os << "\n";
}

//===----------------------------------------------------------------------===//
// --iree-hal-dump-executable-async-dispatches
//===----------------------------------------------------------------------===//

struct DumpExecutableAsyncDispatchesPass
    : public IREE::HAL::impl::DumpExecutableAsyncDispatchesPassBase<
          DumpExecutableAsyncDispatchesPass> {
  using IREE::HAL::impl::DumpExecutableAsyncDispatchesPassBase<
      DumpExecutableAsyncDispatchesPass>::DumpExecutableAsyncDispatchesPassBase;

  void runOnOperation() override {
    mlir::ModuleOp moduleOp = getOperation();
    auto moduleName = moduleOp.getName().value_or("module");
    SymbolTable symbolTable(moduleOp);

    DeviceAnalysis deviceAnalysis(moduleOp);
    if (failed(deviceAnalysis.run())) {
      return signalPassFailure();
    }
    if (deviceAnalysis.getDeviceGlobals().empty()) {
      mlir::emitRemark(moduleOp.getLoc())
          << "Executable async dispatch wrappers were requested but no devices "
             "were declared in the module.\n";
      return;
    } else if (deviceAnalysis.getDeviceGlobals().size() != 1) {
      mlir::emitWarning(moduleOp.getLoc())
          << "Executable async dispatch wrappers were requested but there are "
             "multiple devices in the module and the pass does not support "
             "that yet.\n";
      return;
    }

    auto dispatchParamsMap = gatherDispatchParams(moduleOp, symbolTable);
    if (dispatchParamsMap.empty()) {
      mlir::emitRemark(moduleOp.getLoc())
          << "Executable async dispatch wrappers were requested but none were "
             "generated.\n";
      return;
    }

    if (!path.empty() && path != "-") {
      llvm::sys::fs::create_directories(path);
    }

    for (auto executableOp : moduleOp.getOps<IREE::HAL::ExecutableOp>()) {
      for (auto variantOp :
           executableOp.getOps<IREE::HAL::ExecutableVariantOp>()) {
        auto asyncModuleOp = buildAsyncModule(
            executableOp, variantOp, dispatchParamsMap, deviceAnalysis);
        if (!asyncModuleOp) continue;

        auto fileName = (moduleName + "_" + executableOp.getName() + "_" +
                         variantOp.getName() + "_async.mlir")
                            .str();
        if (path.empty() || path == "-") {
          dumpModuleToStream(*asyncModuleOp, fileName, llvm::outs());
        } else {
          auto filePath =
              (path + llvm::sys::path::get_separator() + fileName).str();
          std::string error;
          auto file = mlir::openOutputFile(filePath, &error);
          if (!file) {
            executableOp.emitError()
                << "while dumping to " << path << ": " << error;
            return signalPassFailure();
          }
          dumpModuleToStream(*asyncModuleOp, fileName, file->os());
          file->keep();
        }
      }
    }
  }
};

}  // namespace

}  // namespace mlir::iree_compiler::IREE::HAL