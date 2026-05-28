// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// Applies `split` and `grow` schedule directives onto `flow.dispatch.region`
// ops, keyed by the `iree.dispatch_id` attribute that TagDispatchIdsPass
// stamped earlier in the pipeline. `affinity` directives are handled by the
// later `apply-affinity-directives` pass (which runs on workgroups, not
// regions). `shard` and `replicate` are not yet implemented; this pass
// emits a diagnostic and continues if it sees them.

#include "iree/compiler/Dialect/Flow/IR/FlowOps.h"
#include "iree/compiler/Dialect/Flow/Transforms/RegionOpUtils.h"
#include "iree/compiler/Dialect/HAL/IR/HALDialect.h"
#include "iree/compiler/Dialect/HAL/IR/HALTypes.h"
#include "iree/compiler/DispatchCreation/Passes.h"
#include "iree/compiler/DispatchCreation/ScheduleSpec.h"
#include "llvm/Support/CommandLine.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/Transforms/Transforms.h"
#include "mlir/Dialect/Linalg/Utils/Utils.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/IRMapping.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Interfaces/FunctionInterfaces.h"
#include "mlir/Interfaces/TilingInterface.h"

#define DEBUG_TYPE "iree-dispatch-creation-apply-schedule-directives"

namespace mlir::iree_compiler::DispatchCreation {

#define GEN_PASS_DEF_APPLYSCHEDULEDIRECTIVESPASS
#include "iree/compiler/DispatchCreation/Passes.h.inc"

// CLI flag is shared with the affinity sub-pass — declared once at file
// scope in ApplyAffinityDirectives.cpp via `cl::opt`. We re-declare here as
// `extern` to avoid a duplicate registration; LLVM's option registry uniques
// by name regardless of where the variable lives, so a mismatch would be
// surfaced at runtime.
extern llvm::cl::opt<std::string> clScheduleSpecPath;

namespace {

struct ApplyScheduleDirectivesPass final
    : impl::ApplyScheduleDirectivesPassBase<ApplyScheduleDirectivesPass> {
  using Base::Base;
  void runOnOperation() override;
};

} // namespace

// Maps a directive's named axis (e.g. "M", "N", "K", "batch") to an iteration
// dimension index for the given root linalg op. Numeric strings ("0", "1",
// ...) are passed through. Falls back to dimension 0 for fully-parallel ops
// when the axis name doesn't refer to a contraction dim.
static FailureOr<unsigned>
resolveAxisDim(linalg::LinalgOp linalgOp, llvm::StringRef axisName) {
  if (axisName.empty()) {
    // Default: outermost parallel iterator.
    auto iters = linalgOp.getIteratorTypesArray();
    for (auto [idx, kind] : llvm::enumerate(iters)) {
      if (linalg::isParallelIterator(kind))
        return static_cast<unsigned>(idx);
    }
    return failure();
  }

  unsigned numericDim = 0;
  if (!axisName.getAsInteger(10, numericDim))
    return numericDim;

  if (linalg::isaContractionOpInterface(linalgOp)) {
    auto cDimsOr = linalg::inferContractionDims(linalgOp);
    if (succeeded(cDimsOr)) {
      const auto &cDims = *cDimsOr;
      if (axisName == "M" && !cDims.m.empty())
        return cDims.m.front();
      if (axisName == "N" && !cDims.n.empty())
        return cDims.n.front();
      if (axisName == "K" && !cDims.k.empty())
        return cDims.k.front();
      if (axisName == "batch" && !cDims.batch.empty())
        return cDims.batch.front();
    }
  }

  return failure();
}

// Locates the root linalg op inside `regionOp`: the op whose results are
// yielded by `flow.return`. This is the canonical "dispatch root" — the op
// FormDispatchRegions wrapped the region around. Producers like
// `linalg.fill` typically precede it but are not the root.
static linalg::LinalgOp findRootLinalg(IREE::Flow::DispatchRegionOp regionOp) {
  // Locate the terminator and walk back from its operands.
  if (regionOp.getBody().empty())
    return {};
  auto returnOp = dyn_cast<IREE::Flow::ReturnOp>(
      regionOp.getBody().front().getTerminator());
  if (!returnOp)
    return {};
  for (Value operand : returnOp.getOperands()) {
    if (auto linalgOp = operand.getDefiningOp<linalg::LinalgOp>())
      return linalgOp;
  }
  // Fallback: last linalg op in walk order (closer to the yield than fills).
  linalg::LinalgOp last;
  regionOp.walk([&](linalg::LinalgOp op) { last = op; });
  return last;
}

// Splits `regionOp`'s root linalg op into `factor` peer ops along
// `dimension`, wrapping each peer in a fresh dispatch.region cloned from the
// original. Sub-id `iree.dispatch_subid` (0..factor-1) is stamped per peer.
// The original region is erased.
//
// Implementation approach (factor=2 first; higher factors recurse):
//   1. Hoist the root linalg above the dispatch region (hoistOutOfDispatch).
//   2. Apply linalg::splitOp at the midpoint of the named iteration domain.
//   3. Wrap each half in a fresh dispatch.region (wrapOpInDispatchRegion).
//   4. Stamp dispatch_id + subid on each fresh region.
//   5. Erase the now-empty original region.
static LogicalResult applySplitDirective(RewriterBase &rewriter,
                                         IREE::Flow::DispatchRegionOp regionOp,
                                         int64_t dispatchId,
                                         const SplitDirective &split) {
  if (split.factor < 2) {
    regionOp.emitWarning()
        << "schedule-spec split factor < 2 is a no-op for dispatch id "
        << dispatchId;
    return success();
  }
  if (split.factor != 2) {
    // Recursive split for factor > 2 is the obvious extension; flag that
    // it's not yet implemented so the caller can decompose manually.
    regionOp.emitWarning()
        << "schedule-spec split factor=" << split.factor
        << " is not yet implemented (only factor=2 supported); skipping "
           "dispatch id "
        << dispatchId;
    return success();
  }

  linalg::LinalgOp rootOp = findRootLinalg(regionOp);
  if (!rootOp) {
    regionOp.emitWarning()
        << "schedule-spec split for dispatch id " << dispatchId
        << ": no linalg root found inside region; skipping";
    return success();
  }

  auto dimOr = resolveAxisDim(rootOp, split.axis);
  if (failed(dimOr)) {
    regionOp.emitWarning()
        << "schedule-spec split for dispatch id " << dispatchId
        << ": cannot resolve axis '" << split.axis << "' to an iteration "
        << "dimension; skipping";
    return success();
  }
  unsigned dim = *dimOr;

  // Compute the midpoint as half the iteration-domain size on `dim`.
  // For static iteration domains this folds to a constant; dynamic shapes
  // produce arith.constant + tensor.dim.
  Location loc = rootOp.getLoc();
  rewriter.setInsertionPoint(regionOp);
  SmallVector<Range> ranges =
      cast<TilingInterface>(rootOp.getOperation()).getIterationDomain(rewriter);
  if (dim >= ranges.size()) {
    regionOp.emitWarning()
        << "schedule-spec split for dispatch id " << dispatchId
        << ": axis dim " << dim
        << " out of range for iteration domain (size " << ranges.size() << ")";
    return success();
  }
  OpFoldResult size = ranges[dim].size;
  std::optional<int64_t> staticSize = getConstantIntValue(size);
  OpFoldResult splitPoint;
  if (staticSize) {
    splitPoint = rewriter.getIndexAttr(*staticSize / 2);
  } else {
    Value sizeValue = getValueOrCreateConstantIndexOp(rewriter, loc, size);
    Value c2 = rewriter.create<arith::ConstantIndexOp>(loc, 2);
    splitPoint =
        rewriter.create<arith::DivUIOp>(loc, sizeValue, c2).getResult();
  }

  // Structural split. We avoid linalg::splitOp entirely (it asserts deep in
  // its TilingInterface path on canonical post-FormDispatchRegions matmuls
  // even after Flow::hoistOutOfDispatch). Instead, we rebuild the root
  // linalg op `factor` times outside the original region with sliced
  // operands, wrap each rebuilt op in a fresh dispatch.region via
  // wrapOpInDispatchRegion, and recombine via tensor.insert_slice.
  (void)dim;

  // Compute peer offsets/sizes. Peer 0 gets [0, splitPoint); peer 1 gets
  // [splitPoint, fullSize).
  SmallVector<OpFoldResult> peerOffsets(2);
  SmallVector<OpFoldResult> peerSizes(2);
  peerOffsets[0] = rewriter.getIndexAttr(0);
  peerSizes[0] = splitPoint;
  peerOffsets[1] = splitPoint;
  if (staticSize) {
    int64_t splitConst = *getConstantIntValue(splitPoint);
    peerSizes[1] = rewriter.getIndexAttr(*staticSize - splitConst);
  } else {
    Value fullSizeV = getValueOrCreateConstantIndexOp(rewriter, loc, size);
    Value splitV = getValueOrCreateConstantIndexOp(rewriter, loc, splitPoint);
    peerSizes[1] =
        rewriter.create<arith::SubIOp>(loc, fullSizeV, splitV).getResult();
  }

  if (rootOp->getNumResults() != 1) {
    regionOp.emitWarning()
        << "schedule-spec split for dispatch id " << dispatchId
        << ": root linalg op has " << rootOp->getNumResults()
        << " results; only single-result roots are supported; skipping";
    return success();
  }

  // Map each linalg operand to the tensor dim that corresponds to the iter
  // dim being split. -1 means the operand is passthrough (no slicing).
  SmallVector<AffineMap> indexingMaps = rootOp.getIndexingMapsArray();
  unsigned numOperands = rootOp->getNumOperands();
  SmallVector<int> operandSliceTensorDim(numOperands, -1);
  for (unsigned i = 0; i < numOperands; ++i) {
    if (i >= indexingMaps.size())
      break;
    AffineMap m = indexingMaps[i];
    for (unsigned j = 0; j < m.getNumResults(); ++j) {
      auto d = dyn_cast<AffineDimExpr>(m.getResult(j));
      if (d && d.getPosition() == dim) {
        operandSliceTensorDim[i] = static_cast<int>(j);
        break;
      }
    }
  }

  unsigned outOpIdx = rootOp.getNumDpsInputs();
  if (outOpIdx >= numOperands || operandSliceTensorDim[outOpIdx] < 0) {
    regionOp.emitWarning()
        << "schedule-spec split for dispatch id " << dispatchId
        << ": split iter dim does not appear in output indexing map; "
           "skipping";
    return success();
  }
  int outSliceDim = operandSliceTensorDim[outOpIdx];

  // Helper: is an operand defined inside the regionOp's body?
  auto isInsideRegion = [&](Value v) {
    Operation *def = v.getDefiningOp();
    return def && def->getParentOp() == regionOp.getOperation();
  };

  // Resolve the "external" form of each operand: a value defined outside
  // regionOp that the peer linalg ops can reference. For sliced operands
  // we'll subsequently extract_slice from this external form.
  SmallVector<Value> externalOperands(numOperands);
  rewriter.setInsertionPoint(regionOp);
  for (unsigned i = 0; i < numOperands; ++i) {
    Value v = rootOp->getOperand(i);
    if (!isInsideRegion(v)) {
      externalOperands[i] = v;
      continue;
    }
    if (i == outOpIdx) {
      // Common pattern: matmul/conv outs is a linalg.fill on tensor.empty.
      // Reconstruct that chain outside the region so peers can slice from
      // a shared full-size init.
      auto fill = v.getDefiningOp<linalg::FillOp>();
      if (!fill) {
        regionOp.emitWarning()
            << "schedule-spec split for dispatch id " << dispatchId
            << ": init operand is region-internal but not a linalg.fill; "
               "skipping (matmul+fill is the supported pattern)";
        return success();
      }
      auto fillOutType = cast<RankedTensorType>(fill.getResult(0).getType());
      SmallVector<OpFoldResult> emptyShape;
      for (unsigned d = 0; d < fillOutType.getRank(); ++d) {
        if (fillOutType.isDynamicDim(d)) {
          regionOp.emitWarning()
              << "schedule-spec split for dispatch id " << dispatchId
              << ": dynamic-shape init not yet supported; skipping";
          return success();
        }
        emptyShape.push_back(rewriter.getIndexAttr(fillOutType.getDimSize(d)));
      }
      Value externalEmpty = rewriter.create<tensor::EmptyOp>(
          loc, emptyShape, fillOutType.getElementType());
      Value fillScalar = fill.getInputs()[0];
      if (isInsideRegion(fillScalar)) {
        if (auto cstOp = fillScalar.getDefiningOp<arith::ConstantOp>()) {
          Operation *clonedCst = rewriter.clone(*cstOp);
          fillScalar = clonedCst->getResult(0);
        } else {
          regionOp.emitWarning()
              << "schedule-spec split for dispatch id " << dispatchId
              << ": fill scalar is region-internal and not a constant; "
                 "skipping";
          return success();
        }
      }
      externalOperands[i] =
          rewriter
              .create<linalg::FillOp>(loc, ValueRange{fillScalar},
                                       ValueRange{externalEmpty})
              .getResult(0);
      continue;
    }
    regionOp.emitWarning()
        << "schedule-spec split for dispatch id " << dispatchId
        << ": input operand " << i << " is region-internal; only "
        << "outside-defined inputs are supported; skipping";
    return success();
  }

  // Build per-peer sliced operands + cloned linalg ops + dispatch wrappers.
  Value origResult = regionOp->getResult(0);
  auto resultType = cast<RankedTensorType>(origResult.getType());
  if (resultType.getRank() == 0) {
    regionOp.emitWarning() << "schedule-spec split: scalar result; skipping";
    return success();
  }
  SmallVector<Value> peerResults;
  for (int peer = 0; peer < 2; ++peer) {
    SmallVector<Value> slicedOperands(externalOperands);
    for (unsigned i = 0; i < numOperands; ++i) {
      int td = operandSliceTensorDim[i];
      if (td < 0)
        continue;
      Value v = externalOperands[i];
      auto vt = cast<RankedTensorType>(v.getType());
      unsigned rank = vt.getRank();
      SmallVector<OpFoldResult> off(rank, rewriter.getIndexAttr(0));
      SmallVector<OpFoldResult> sz(rank);
      SmallVector<OpFoldResult> str(rank, rewriter.getIndexAttr(1));
      for (unsigned d = 0; d < rank; ++d) {
        if (vt.isDynamicDim(d)) {
          sz[d] = rewriter.create<tensor::DimOp>(loc, v, d).getResult();
        } else {
          sz[d] = rewriter.getIndexAttr(vt.getDimSize(d));
        }
      }
      off[td] = peerOffsets[peer];
      sz[td] = peerSizes[peer];
      slicedOperands[i] =
          rewriter.create<tensor::ExtractSliceOp>(loc, v, off, sz, str);
    }

    // Clone the root linalg op with sliced operands. The clone's result
    // type matches the (sliced) init operand type.
    IRMapping mapping;
    for (unsigned i = 0; i < numOperands; ++i) {
      mapping.map(rootOp->getOperand(i), slicedOperands[i]);
    }
    // Build a fresh dispatch.region from scratch and move the cloned
    // linalg op into it. We avoid wrapOpInDispatchRegion because its
    // append-results path can leave the region with an empty result list
    // when the cloned op's MLIR type metadata was mutated post-clone.
    Type peerResultType = slicedOperands[outOpIdx].getType();
    auto peerRegion = rewriter.create<IREE::Flow::DispatchRegionOp>(
        loc, /*resultTypes=*/TypeRange{peerResultType},
        /*resultDims=*/ValueRange{},
        /*workload=*/ValueRange{});
    // Build the body block + flow.return placeholder.
    Block *peerBody = rewriter.createBlock(&peerRegion.getBody());
    rewriter.setInsertionPointToStart(peerBody);
    // Clone the linalg op inside.
    Operation *clonedInner =
        rewriter.clone(*rootOp.getOperation(), mapping);
    clonedInner->getResult(0).setType(peerResultType);
    rewriter.create<IREE::Flow::ReturnOp>(loc,
                                          ValueRange{clonedInner->getResult(0)});

    // Stamp dispatch id / subid on the new region (TagDispatchIdsPass puts
    // it on the region, not the linalg op, and the propagation through
    // ConvertDispatchRegionsToWorkgroups reads from the region).
    peerRegion->setAttr("iree.dispatch_id",
                        rewriter.getI64IntegerAttr(dispatchId));
    peerRegion->setAttr("iree.dispatch_subid",
                        rewriter.getI64IntegerAttr(peer));
    peerResults.push_back(peerRegion->getResult(0));

    // Reset insertion point to right after the new peer region for the
    // next iteration / the recombine step.
    rewriter.setInsertionPointAfter(peerRegion);
  }

  // Recombine peer results into the original output buffer via
  // tensor.insert_slice. Use externalOperands[outOpIdx] (full-size init) as
  // the accumulator base.
  Value combined = externalOperands[outOpIdx];
  unsigned outRank = resultType.getRank();
  SmallVector<OpFoldResult> insStr(outRank, rewriter.getIndexAttr(1));
  for (int peer = 0; peer < 2; ++peer) {
    SmallVector<OpFoldResult> insOff(outRank, rewriter.getIndexAttr(0));
    SmallVector<OpFoldResult> insSz(outRank);
    for (unsigned d = 0; d < outRank; ++d) {
      if (resultType.isDynamicDim(d)) {
        insSz[d] =
            rewriter.create<tensor::DimOp>(loc, combined, d).getResult();
      } else {
        insSz[d] = rewriter.getIndexAttr(resultType.getDimSize(d));
      }
    }
    insOff[outSliceDim] = peerOffsets[peer];
    insSz[outSliceDim] = peerSizes[peer];
    combined = rewriter.create<tensor::InsertSliceOp>(
        loc, peerResults[peer], combined, insOff, insSz, insStr);
  }

  rewriter.replaceOp(regionOp, combined);
  return success();
}

// Builds an affinity attribute from a directive device string ("@device_a"
// or a fully qualified `#hal.device.affinity<...>` form). Returns null on
// parse failure.
static Attribute buildShardAffinity(MLIRContext *ctx, llvm::StringRef device) {
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

// Builds a #hal.device.promise<@symbol> attribute from a "@<sym>" or
// "#hal.device.affinity<...>" device string. Used as the target attr for
// flow.tensor.transfer + the on_devices/to_device operands of
// flow.tensor.gather_from_devices.
static Attribute buildDevicePromise(MLIRContext *ctx, llvm::StringRef device) {
  device = device.trim();
  if (device.empty())
    return {};
  if (device.front() == '@') {
    return parseAttribute(("#hal.device.promise<" + device + ">").str(), ctx);
  }
  // Already a structured attr (#hal.device.affinity<@sym>): extract the
  // bare symbol and re-wrap as promise.
  if (auto parsed = parseAttribute(device, ctx)) {
    if (auto da = dyn_cast<IREE::HAL::DeviceAffinityAttr>(parsed)) {
      SymbolRefAttr ref = da.getDevice();
      if (ref) {
        return parseAttribute(("#hal.device.promise<@" +
                               ref.getLeafReference().getValue() + ">")
                                  .str(),
                              ctx);
      }
    }
  }
  return {};
}

// Shard directive: like split, but each peer gets a distinct device
// affinity (from `directive.devices[peer]`) stamped on the new dispatch
// region, and the recombination depends on the reduction kind:
//   - None: parallel-axis shard, recombine via tensor.insert_slice (each
//     peer covers a disjoint slice of the output).
//   - Add | Max | Any: reduction-axis shard, recombine via
//     flow.tensor.gather_from_devices (the lowering chains transfers +
//     elementwise reducer onto the home device).
static LogicalResult applyShardDirective(RewriterBase &rewriter,
                                         IREE::Flow::DispatchRegionOp regionOp,
                                         int64_t dispatchId,
                                         const ShardDirective &shard) {
  if (shard.devices.size() < 2) {
    regionOp.emitWarning()
        << "schedule-spec shard for dispatch id " << dispatchId
        << ": needs at least 2 devices; got " << shard.devices.size()
        << "; skipping";
    return success();
  }

  linalg::LinalgOp rootOp = findRootLinalg(regionOp);
  if (!rootOp) {
    regionOp.emitWarning() << "schedule-spec shard for dispatch id "
                           << dispatchId << ": no linalg root; skipping";
    return success();
  }
  if (rootOp->getNumResults() != 1) {
    regionOp.emitWarning()
        << "schedule-spec shard for dispatch id " << dispatchId
        << ": only single-result roots are supported; skipping";
    return success();
  }

  auto dimOr = resolveAxisDim(rootOp, shard.axis);
  if (failed(dimOr)) {
    regionOp.emitWarning()
        << "schedule-spec shard for dispatch id " << dispatchId
        << ": cannot resolve axis '" << shard.axis << "'; skipping";
    return success();
  }
  unsigned dim = *dimOr;

  // Iter-domain size on `dim` -> per-peer offset/size.
  Location loc = rootOp.getLoc();
  rewriter.setInsertionPoint(regionOp);
  SmallVector<Range> ranges =
      cast<TilingInterface>(rootOp.getOperation()).getIterationDomain(rewriter);
  if (dim >= ranges.size()) {
    regionOp.emitWarning() << "schedule-spec shard: dim out of range; skipping";
    return success();
  }
  OpFoldResult fullSize = ranges[dim].size;
  std::optional<int64_t> staticSize = getConstantIntValue(fullSize);
  if (!staticSize) {
    regionOp.emitWarning() << "schedule-spec shard: dynamic iter dim not yet "
                              "supported; skipping";
    return success();
  }
  int64_t numPeers = static_cast<int64_t>(shard.devices.size());
  int64_t baseChunk = *staticSize / numPeers;
  if (baseChunk <= 0) {
    regionOp.emitWarning() << "schedule-spec shard: iter size < num peers; "
                              "skipping";
    return success();
  }
  SmallVector<OpFoldResult> peerOffsets(numPeers);
  SmallVector<OpFoldResult> peerSizes(numPeers);
  int64_t offset = 0;
  for (int64_t p = 0; p < numPeers; ++p) {
    peerOffsets[p] = rewriter.getIndexAttr(offset);
    int64_t size =
        (p + 1 == numPeers) ? (*staticSize - offset) : baseChunk;
    peerSizes[p] = rewriter.getIndexAttr(size);
    offset += size;
  }

  // Operand-to-tensor-dim mapping (same logic as split).
  SmallVector<AffineMap> indexingMaps = rootOp.getIndexingMapsArray();
  unsigned numOperands = rootOp->getNumOperands();
  SmallVector<int> operandSliceTensorDim(numOperands, -1);
  for (unsigned i = 0; i < numOperands; ++i) {
    if (i >= indexingMaps.size())
      break;
    AffineMap m = indexingMaps[i];
    for (unsigned j = 0; j < m.getNumResults(); ++j) {
      auto d = dyn_cast<AffineDimExpr>(m.getResult(j));
      if (d && d.getPosition() == dim) {
        operandSliceTensorDim[i] = static_cast<int>(j);
        break;
      }
    }
  }

  unsigned outOpIdx = rootOp.getNumDpsInputs();
  if (outOpIdx >= numOperands) {
    regionOp.emitWarning()
        << "schedule-spec shard: no DPS init operand; skipping";
    return success();
  }
  bool reductionAxis = operandSliceTensorDim[outOpIdx] < 0;
  if (reductionAxis && shard.reduction == ShardReduction::None) {
    regionOp.emitWarning()
        << "schedule-spec shard for dispatch id " << dispatchId
        << ": axis '" << shard.axis
        << "' is reduction (not in output indexing map) but reduction='none'; "
           "expected one of add/max/any; skipping";
    return success();
  }
  if (!reductionAxis && shard.reduction != ShardReduction::None) {
    regionOp.emitWarning()
        << "schedule-spec shard for dispatch id " << dispatchId
        << ": axis '" << shard.axis
        << "' is parallel but a reduction kind was requested; skipping";
    return success();
  }
  int outSliceDim = operandSliceTensorDim[outOpIdx]; // -1 for reduction case

  auto isInsideRegion = [&](Value v) {
    Operation *def = v.getDefiningOp();
    return def && def->getParentOp() == regionOp.getOperation();
  };

  // Resolve the external form of each operand. Same logic as split: pull
  // the matmul+fill init outside, refuse other region-internal operands.
  SmallVector<Value> externalOperands(numOperands);
  rewriter.setInsertionPoint(regionOp);
  for (unsigned i = 0; i < numOperands; ++i) {
    Value v = rootOp->getOperand(i);
    if (!isInsideRegion(v)) {
      externalOperands[i] = v;
      continue;
    }
    if (i == outOpIdx) {
      auto fill = v.getDefiningOp<linalg::FillOp>();
      if (!fill) {
        regionOp.emitWarning()
            << "schedule-spec shard: init is region-internal but not a "
               "linalg.fill; skipping";
        return success();
      }
      auto fillOutType = cast<RankedTensorType>(fill.getResult(0).getType());
      SmallVector<OpFoldResult> emptyShape;
      for (unsigned d = 0; d < fillOutType.getRank(); ++d) {
        if (fillOutType.isDynamicDim(d)) {
          regionOp.emitWarning() << "schedule-spec shard: dynamic-shape init "
                                    "not supported; skipping";
          return success();
        }
        emptyShape.push_back(rewriter.getIndexAttr(fillOutType.getDimSize(d)));
      }
      Value externalEmpty = rewriter.create<tensor::EmptyOp>(
          loc, emptyShape, fillOutType.getElementType());
      Value fillScalar = fill.getInputs()[0];
      if (isInsideRegion(fillScalar)) {
        if (auto cstOp = fillScalar.getDefiningOp<arith::ConstantOp>()) {
          fillScalar = rewriter.clone(*cstOp)->getResult(0);
        } else {
          regionOp.emitWarning()
              << "schedule-spec shard: fill scalar is region-internal and "
                 "not a constant; skipping";
          return success();
        }
      }
      externalOperands[i] =
          rewriter
              .create<linalg::FillOp>(loc, ValueRange{fillScalar},
                                       ValueRange{externalEmpty})
              .getResult(0);
      continue;
    }
    regionOp.emitWarning()
        << "schedule-spec shard: input operand " << i
        << " is region-internal; skipping";
    return success();
  }

  Value origResult = regionOp->getResult(0);
  auto resultType = cast<RankedTensorType>(origResult.getType());

  MLIRContext *ctx = regionOp.getContext();

  // Pre-build per-peer affinity attrs and on-device promise attrs.
  SmallVector<Attribute> affinityAttrs(numPeers);
  SmallVector<Attribute> promiseAttrs(numPeers);
  for (int64_t p = 0; p < numPeers; ++p) {
    affinityAttrs[p] = buildShardAffinity(ctx, shard.devices[p]);
    promiseAttrs[p] = buildDevicePromise(ctx, shard.devices[p]);
    if (!affinityAttrs[p] || !promiseAttrs[p]) {
      regionOp.emitWarning()
          << "schedule-spec shard: cannot parse device '" << shard.devices[p]
          << "'; skipping";
      return success();
    }
  }

  SmallVector<Value> peerResults;
  Type peerSliceType; // sliced result type per peer (for none recombine)
  for (int64_t peer = 0; peer < numPeers; ++peer) {
    SmallVector<Value> slicedOperands(externalOperands);
    for (unsigned i = 0; i < numOperands; ++i) {
      int td = operandSliceTensorDim[i];
      if (td < 0)
        continue;
      Value v = externalOperands[i];
      auto vt = cast<RankedTensorType>(v.getType());
      unsigned rank = vt.getRank();
      SmallVector<OpFoldResult> off(rank, rewriter.getIndexAttr(0));
      SmallVector<OpFoldResult> sz(rank);
      SmallVector<OpFoldResult> str(rank, rewriter.getIndexAttr(1));
      for (unsigned d = 0; d < rank; ++d) {
        if (vt.isDynamicDim(d)) {
          sz[d] = rewriter.create<tensor::DimOp>(loc, v, d).getResult();
        } else {
          sz[d] = rewriter.getIndexAttr(vt.getDimSize(d));
        }
      }
      off[td] = peerOffsets[peer];
      sz[td] = peerSizes[peer];
      slicedOperands[i] =
          rewriter.create<tensor::ExtractSliceOp>(loc, v, off, sz, str);
    }

    // For reduction-axis sharding the output operand is NOT sliced (it
    // has the full output shape), so each peer uses the same full-size
    // init. To avoid sharing the same SSA buffer across peers (the IREE
    // Stream layer would alias it), build a fresh fill per peer.
    if (reductionAxis) {
      Value baseInit = externalOperands[outOpIdx];
      if (auto fill = baseInit.getDefiningOp<linalg::FillOp>()) {
        auto fillTy = cast<RankedTensorType>(fill.getResult(0).getType());
        SmallVector<OpFoldResult> emptyShape;
        for (unsigned d = 0; d < fillTy.getRank(); ++d) {
          emptyShape.push_back(rewriter.getIndexAttr(fillTy.getDimSize(d)));
        }
        Value freshEmpty = rewriter.create<tensor::EmptyOp>(
            loc, emptyShape, fillTy.getElementType());
        slicedOperands[outOpIdx] =
            rewriter
                .create<linalg::FillOp>(loc, ValueRange{fill.getInputs()[0]},
                                         ValueRange{freshEmpty})
                .getResult(0);
      }
    }

    Type peerResultType = slicedOperands[outOpIdx].getType();
    peerSliceType = peerResultType;

    auto peerRegion = rewriter.create<IREE::Flow::DispatchRegionOp>(
        loc, /*resultTypes=*/TypeRange{peerResultType},
        /*resultDims=*/ValueRange{},
        /*workload=*/ValueRange{});
    Block *peerBody = rewriter.createBlock(&peerRegion.getBody());
    rewriter.setInsertionPointToStart(peerBody);
    IRMapping mapping;
    for (unsigned i = 0; i < numOperands; ++i) {
      mapping.map(rootOp->getOperand(i), slicedOperands[i]);
    }
    Operation *clonedInner =
        rewriter.clone(*rootOp.getOperation(), mapping);
    clonedInner->getResult(0).setType(peerResultType);
    rewriter.create<IREE::Flow::ReturnOp>(loc,
                                          ValueRange{clonedInner->getResult(0)});

    peerRegion->setAttr("iree.dispatch_id",
                        rewriter.getI64IntegerAttr(dispatchId));
    peerRegion->setAttr("iree.dispatch_subid",
                        rewriter.getI64IntegerAttr(peer));
    peerRegion->setAttr("stream.affinity", affinityAttrs[peer]);
    peerResults.push_back(peerRegion->getResult(0));

    rewriter.setInsertionPointAfter(peerRegion);
  }

  Value combined;
  if (!reductionAxis) {
    // Parallel-axis: insert_slice chain (same as split, but each peer was
    // affinity-stamped above).
    combined = externalOperands[outOpIdx];
    unsigned outRank = resultType.getRank();
    SmallVector<OpFoldResult> insStr(outRank, rewriter.getIndexAttr(1));
    for (int64_t peer = 0; peer < numPeers; ++peer) {
      SmallVector<OpFoldResult> insOff(outRank, rewriter.getIndexAttr(0));
      SmallVector<OpFoldResult> insSz(outRank);
      for (unsigned d = 0; d < outRank; ++d) {
        if (resultType.isDynamicDim(d)) {
          insSz[d] =
              rewriter.create<tensor::DimOp>(loc, combined, d).getResult();
        } else {
          insSz[d] = rewriter.getIndexAttr(resultType.getDimSize(d));
        }
      }
      insOff[outSliceDim] = peerOffsets[peer];
      insSz[outSliceDim] = peerSizes[peer];
      combined = rewriter.create<tensor::InsertSliceOp>(
          loc, peerResults[peer], combined, insOff, insSz, insStr);
    }
  } else {
    // Reduction-axis: emit flow.tensor.gather_from_devices targeting peer 0
    // (convention: "home device" is the first device in the directive).
    StringRef redName;
    switch (shard.reduction) {
    case ShardReduction::Add:
      redName = "add";
      break;
    case ShardReduction::Max:
      redName = "max";
      break;
    case ShardReduction::Any:
      redName = "any";
      break;
    case ShardReduction::None:
      // Should have been rejected above.
      regionOp.emitWarning() << "schedule-spec shard: unexpected reduction "
                                "kind 'none' on reduction axis";
      return success();
    }
    SmallVector<Attribute> onDevices(promiseAttrs.begin(), promiseAttrs.end());
    ArrayAttr onDevicesAttr = rewriter.getArrayAttr(onDevices);
    combined = rewriter
                   .create<IREE::Flow::TensorGatherFromDevicesOp>(
                       loc, /*resultType=*/peerSliceType,
                       /*shards=*/peerResults,
                       /*shardDims=*/ValueRange{},
                       /*onDevices=*/onDevicesAttr,
                       /*toDevice=*/promiseAttrs[0],
                       /*reduction=*/redName)
                   .getResult();
  }

  rewriter.replaceOp(regionOp, combined);
  return success();
}

// Merges `producer` into `consumer` by inlining the producer's body and
// erasing the producer. Refuses if `producer` has uses outside of `consumer`.
static LogicalResult applyGrowDirective(RewriterBase &rewriter,
                                        IREE::Flow::DispatchRegionOp consumer,
                                        IREE::Flow::DispatchRegionOp producer,
                                        int64_t consumerId,
                                        int64_t producerId) {
  // External-uses guard: every user of every producer result must live
  // inside the consumer region. If not, we'd be merging a producer with
  // multiple downstream regions, which a single grow directive can't
  // express; refuse the merge so the user gets a precise diagnostic.
  llvm::SmallPtrSet<Operation *, 8> consumerOps;
  consumer.walk([&](Operation *op) { consumerOps.insert(op); });
  for (Value result : producer.getResults()) {
    for (Operation *user : result.getUsers()) {
      if (!consumerOps.contains(user)) {
        producer.emitWarning()
            << "schedule-spec grow: producer dispatch id " << producerId
            << " has uses outside consumer dispatch id " << consumerId
            << "; refusing merge.";
        return success();
      }
    }
  }

  // Move all ops from producer body (except the terminator) immediately
  // before the consumer body's first op. The producer's flow.return values
  // are remapped to feed the consumer in place of the producer's results.
  IRMapping mapping;
  auto &producerBlock = producer.getBody().front();
  auto producerTerminator =
      cast<IREE::Flow::ReturnOp>(producerBlock.getTerminator());

  rewriter.setInsertionPointToStart(&consumer.getBody().front());
  for (auto &op : producerBlock.without_terminator()) {
    Operation *cloned = rewriter.clone(op, mapping);
    for (auto [orig, newVal] :
         llvm::zip(op.getResults(), cloned->getResults())) {
      mapping.map(orig, newVal);
    }
  }

  // Replace external uses of the producer's results (which are inside
  // consumer) with the producer's flow.return values' mapped equivalents.
  for (auto [origResult, returnedVal] :
       llvm::zip(producer.getResults(), producerTerminator.getOperands())) {
    Value mapped = mapping.lookupOrDefault(returnedVal);
    rewriter.replaceAllUsesWith(origResult, mapped);
  }

  rewriter.eraseOp(producer);
  return success();
}

void ApplyScheduleDirectivesPass::runOnOperation() {
  if (clScheduleSpecPath.empty())
    return; // no-op when no spec is provided.

  FunctionOpInterface funcOp = getOperation();
  MLIRContext *ctx = funcOp.getContext();

  auto specOr = ScheduleSpec::loadFromFile(clScheduleSpecPath, ctx);
  if (failed(specOr)) {
    return signalPassFailure();
  }
  const ScheduleSpec &spec = *specOr;

  // Index regions by their iree.dispatch_id for O(1) directive lookup.
  llvm::DenseMap<int64_t, IREE::Flow::DispatchRegionOp> idToRegion;
  funcOp.walk([&](IREE::Flow::DispatchRegionOp regionOp) {
    if (auto idAttr = regionOp->getAttrOfType<IntegerAttr>("iree.dispatch_id"))
      idToRegion[idAttr.getInt()] = regionOp;
  });

  IRRewriter rewriter(ctx);

  for (const auto &kv : spec.directives) {
    int64_t id = kv.first;
    const DispatchDirective &d = kv.second;
    auto it = idToRegion.find(id);
    if (it == idToRegion.end())
      continue; // directive references a non-existent dispatch; skip.

    IREE::Flow::DispatchRegionOp regionOp = it->second;
    if (!regionOp)
      continue; // already erased by an earlier directive (e.g. grow).

    switch (d.kind) {
    case DirectiveKind::Affinity:
      // Owned by ApplyAffinityDirectivesPass on workgroups.
      break;
    case DirectiveKind::Split: {
      const auto &p = std::get<SplitDirective>(d.payload);
      (void)applySplitDirective(rewriter, regionOp, id, p);
      // Don't invalidate the index entry: applySplitDirective is a
      // warn-and-skip until structural split is wired (the original region
      // remains in place).
      break;
    }
    case DirectiveKind::Grow: {
      const auto &p = std::get<GrowDirective>(d.payload);
      auto producerIt = idToRegion.find(p.mergeWith);
      if (producerIt == idToRegion.end() || !producerIt->second) {
        regionOp.emitWarning()
            << "schedule-spec grow: producer dispatch id " << p.mergeWith
            << " not found; skipping";
        break;
      }
      if (succeeded(applyGrowDirective(rewriter, regionOp, producerIt->second,
                                       id, p.mergeWith))) {
        idToRegion[p.mergeWith] = nullptr;
      }
      break;
    }
    case DirectiveKind::Shard: {
      const auto &p = std::get<ShardDirective>(d.payload);
      (void)applyShardDirective(rewriter, regionOp, id, p);
      break;
    }
    case DirectiveKind::Replicate:
      regionOp.emitWarning()
          << "schedule-spec replicate directive not yet implemented for "
             "dispatch id "
          << id;
      break;
    }
  }
}

} // namespace mlir::iree_compiler::DispatchCreation
