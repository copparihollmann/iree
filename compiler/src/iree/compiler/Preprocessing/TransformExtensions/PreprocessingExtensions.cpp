// Copyright 2024 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/compiler/Preprocessing/TransformExtensions/PreprocessingExtensions.h"

#include "iree/compiler/Dialect/LinalgExt/IR/LinalgExtOps.h"
#include "iree/compiler/Dialect/LinalgExt/Utils/IndexingUtils.h"
#include "iree/compiler/Utils/EquivalenceUtils.h"
#include "iree/compiler/Utils/ShapeUtils.h"
#include "mlir/Dialect/Linalg/IR/LinalgInterfaces.h"
#include "mlir/Dialect/Transform/Interfaces/TransformInterfaces.h"
#include "mlir/IR/AffineMap.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/IRMapping.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/Value.h"
#include "mlir/Interfaces/ValueBoundsOpInterface.h"

namespace mlir::iree_compiler {

IREE::transform_dialect::PreprocessingExtensions::PreprocessingExtensions() {
  registerTransformOps<
#define GET_OP_LIST
#include "iree/compiler/Preprocessing/TransformExtensions/PreprocessingExtensionsOps.cpp.inc"
      >();
}

void registerTransformDialectPreprocessingExtension(DialectRegistry &registry) {
  registry.addExtensions<IREE::transform_dialect::PreprocessingExtensions>();
}

//===----------------------------------------------------------------------===//
// MatchCastCompatibleDagFromRootOp
//===----------------------------------------------------------------------===//

// Compares the regions between two operations in lockstep for equality.
static DiagnosedSilenceableFailure
compareOperationRegions(transform::TransformOpInterface transformOp,
                        OperationEquivalenceCache &cache, IRMapping &mapping,
                        Operation *target, Operation *payload) {
  if (target->getNumRegions() != payload->getNumRegions()) {
    return transformOp.emitSilenceableError() << "region count mismatch";
  }
  for (auto [r0, r1] :
       llvm::zip_equal(target->getRegions(), payload->getRegions())) {
    if (!isStructurallyEquivalentTo(cache, r0, r1, mapping)) {
      return transformOp.emitSilenceableError()
             << "target op does not match specified body";
    }
  }
  return DiagnosedSilenceableFailure::success();
}

// Helper to check whether two operations are equivalent up to cast
// compatibility of their arguments (i.e. the arguments of the payload
// can be casted to the arguments of the target).
static DiagnosedSilenceableFailure
compareCastCompatibleOperations(transform::TransformOpInterface transformOp,
                                Operation *target, Operation *payload) {
  if (target->getName() != payload->getName()) {
    return transformOp.emitSilenceableError()
           << "target operation name " << target->getName()
           << " does not match payload " << payload->getName();
  }

  if (target->getAttrDictionary() != payload->getAttrDictionary()) {
    return transformOp.emitSilenceableError()
           << "target attribute dictionary " << target->getAttrDictionary()
           << " does not match payload attribute dictionary "
           << payload->getAttrDictionary();
  }

  if (target->getNumResults() != payload->getNumResults()) {
    return transformOp.emitSilenceableError() << "result count mismatch";
  }

  if (target->getNumOperands() != payload->getNumOperands()) {
    return transformOp.emitSilenceableError() << "operand count mismatch";
  }
  for (auto [targetType, payloadType] :
       llvm::zip_equal(target->getOperandTypes(), payload->getOperandTypes())) {
    if (auto targetTensorType = dyn_cast<RankedTensorType>(targetType)) {
      if (!isCastableToTensorType(payloadType, targetTensorType)) {
        return transformOp.emitSilenceableError()
               << "operand tensor type mismatch";
      }
    } else if (targetType != payloadType) {
      return transformOp.emitSilenceableError() << "operand type mismatch";
    }
  }
  return DiagnosedSilenceableFailure::success();
}

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchCastCompatibleDagFromRootOp::matchOperation(
    Operation *current, transform::TransformResults &results,
    transform::TransformState &state) {
  Operation *targetDagRoot = getRegion().front().back().getPrevNode();

  // Reserve the list of inputs based on the number of block arguments in
  // the operation region.
  int64_t numInputs = getRegion().getNumArguments();
  SmallVector<Value> inputs(numInputs, nullptr);

  // Maps from target/payload op to the order in which they were first
  // processed. This is used to verify that two uses actually point to the
  // same node in the dag.
  llvm::MapVector<Operation *, Operation *> targetToPayloadMapping;

  // Step 1. First just walk from root op "upwards" to match basic
  // producer-consumer match (without checking regions).

  // Populate the paired worklist with the current target and payload root ops.
  SmallVector<Operation *> targetWorklist = {targetDagRoot};
  SmallVector<Operation *> payloadWorklist = {current};
  while (!targetWorklist.empty()) {
    Operation *targetOp = targetWorklist.pop_back_val();
    Operation *payloadOp = payloadWorklist.pop_back_val();

    if (targetOp->hasAttr("match.operation_name_only")) {
      if (targetOp->getName() != payloadOp->getName()) {
        return emitSilenceableError() << "only operation name op mismatch";
      }
      // Do not recurse and do not require any specific structure beyond the
      // operation name.
      continue;
    }

    // Verify that if already processed, both operations are at the same
    // position.
    if (targetToPayloadMapping.contains(targetOp)) {
      if (targetToPayloadMapping.lookup(targetOp) != payloadOp) {
        return emitSilenceableError() << "dag mismatch";
      }
      continue;
    }

    // Verify general operation equality (name, attributes).
    DiagnosedSilenceableFailure diag =
        compareCastCompatibleOperations(*this, targetOp, payloadOp);
    if (!diag.succeeded()) {
      diag.attachNote(payloadOp->getLoc()) << "While processing operation";
      return diag;
    }

    // Pair up a single (target, payload) value reference. Treats target
    // block-args as match inputs; otherwise queues the producer pair onto
    // the worklist (or verifies the existing mapping for already-seen
    // producers). Returns true on success; on failure, populates *outErr
    // and returns false.
    auto enqueueValuePair = [&](Value targetVal, Value payloadVal,
                                DiagnosedSilenceableFailure *outErr) -> bool {
      if (auto targetBlockArg = dyn_cast<BlockArgument>(targetVal)) {
        if (targetBlockArg.getOwner() != &getRegion().front()) {
          *outErr =
              emitDefiniteFailure() << "Invalid block argument in target";
          return false;
        }
        int64_t argIdx = targetBlockArg.getArgNumber();
        if (inputs[argIdx] && inputs[argIdx] != payloadVal) {
          *outErr = emitSilenceableError()
                    << "input operand with conflicting uses";
          return false;
        }
        inputs[argIdx] = payloadVal;
        return true;
      }
      Operation *payloadDefiningOp = payloadVal.getDefiningOp();
      if (!payloadDefiningOp) {
        *outErr = emitSilenceableError()
                  << "early termination of the operation dag";
        return false;
      }
      Operation *targetDefiningOp = targetVal.getDefiningOp();
      if (targetToPayloadMapping.contains(targetDefiningOp)) {
        if (targetToPayloadMapping.lookup(targetDefiningOp) !=
            payloadDefiningOp) {
          *outErr = emitSilenceableError() << "dag mismatch";
          return false;
        }
        return true;
      }
      targetWorklist.push_back(targetDefiningOp);
      payloadWorklist.push_back(payloadDefiningOp);
      return true;
    };

    for (auto [payloadOperand, targetOperand] :
         llvm::zip_equal(payloadOp->getOperands(), targetOp->getOperands())) {
      DiagnosedSilenceableFailure err =
          DiagnosedSilenceableFailure::success();
      if (!enqueueValuePair(targetOperand, payloadOperand, &err)) {
        return err;
      }
    }

    // Also walk references *captured into this op's regions* from outer
    // scope. Without this, a linalg.generic body that references a
    // hoisted constant defined in the match's outer scope would never
    // visit that constant — step 2's region-equivalence walk would then
    // hit `parentMapping.lookup(captured)` on an unmapped value and
    // assert in IRMapping. Concretely: the post-canonicalize relu form
    // `linalg.generic { ^bb0(%a, %o): arith.maximumf %a, %cst_outer }`
    // captures `%cst_outer` from the surrounding region.
    //
    // Capture detection: an SSA Value is "captured" if its defining op
    // (or block) lives outside this op's regions. We walk the regions
    // and, for each operand of every contained op, check whether the
    // operand's owner is inside the same op or further out. We pair the
    // captured payload value with the corresponding capture in the
    // target op via a synchronized walk — both target and payload must
    // walk in lockstep so capture order matches deterministically.
    if (targetOp->getNumRegions() == payloadOp->getNumRegions()) {
      for (auto [targetRegion, payloadRegion] :
           llvm::zip_equal(targetOp->getRegions(), payloadOp->getRegions())) {
        SmallVector<Value> targetCaptures;
        SmallVector<Value> payloadCaptures;
        // Collect captures in deterministic order: walk every operation
        // inside the region and inspect each operand. If the operand's
        // defining op (or block) is OUTSIDE the region, it's a capture.
        // We collect deduped captures preserving first-use order.
        llvm::SmallSetVector<Value, 8> targetSeen;
        llvm::SmallSetVector<Value, 8> payloadSeen;
        targetRegion.walk([&](Operation *innerOp) {
          for (Value v : innerOp->getOperands()) {
            // Skip values defined inside this region.
            Block *ownerBlock = nullptr;
            if (auto ba = dyn_cast<BlockArgument>(v)) {
              ownerBlock = ba.getOwner();
            } else if (auto *op = v.getDefiningOp()) {
              ownerBlock = op->getBlock();
            }
            if (!ownerBlock) continue;
            // If owner block is contained in this region, it's not
            // captured.
            bool inside = false;
            for (Block &b : targetRegion) {
              if (&b == ownerBlock) { inside = true; break; }
            }
            if (inside) continue;
            targetSeen.insert(v);
          }
        });
        payloadRegion.walk([&](Operation *innerOp) {
          for (Value v : innerOp->getOperands()) {
            Block *ownerBlock = nullptr;
            if (auto ba = dyn_cast<BlockArgument>(v)) {
              ownerBlock = ba.getOwner();
            } else if (auto *op = v.getDefiningOp()) {
              ownerBlock = op->getBlock();
            }
            if (!ownerBlock) continue;
            bool inside = false;
            for (Block &b : payloadRegion) {
              if (&b == ownerBlock) { inside = true; break; }
            }
            if (inside) continue;
            payloadSeen.insert(v);
          }
        });
        if (targetSeen.size() != payloadSeen.size()) {
          return emitSilenceableError()
                 << "captured-value count mismatch (target="
                 << targetSeen.size() << ", payload=" << payloadSeen.size()
                 << ")";
        }
        for (auto [t, p] :
             llvm::zip_equal(targetSeen.getArrayRef(),
                             payloadSeen.getArrayRef())) {
          DiagnosedSilenceableFailure err =
              DiagnosedSilenceableFailure::success();
          if (!enqueueValuePair(t, p, &err)) {
            return err;
          }
        }
      }
    }

    // Mark the current target + payload as processed.
    targetToPayloadMapping[targetOp] = payloadOp;
  }

  // Step 2. Now check regions of all the ops match.
  OperationEquivalenceCache cache(getContext());
  auto mapping = cache.acquireMapping();
  for (auto [targetOp, payloadOp] : llvm::reverse(targetToPayloadMapping)) {
    DiagnosedSilenceableFailure diag =
        compareOperationRegions(*this, cache, *mapping, targetOp, payloadOp);
    if (!diag.succeeded()) {
      diag.attachNote(payloadOp->getLoc()) << "While processing region";
      return diag;
    }
    for (auto [targetOpResult, payloadOpResult] :
         llvm::zip_equal(targetOp->getResults(), payloadOp->getResults())) {
      mapping->map(targetOpResult, payloadOpResult);
    }
  }

  // Verify that all input arguments were successfully matched.
  if (llvm::any_of(inputs, [](Value in) { return !in; })) {
    return emitSilenceableError() << "failed to match all input nodes";
  }

  results.setValues(cast<OpResult>(getInputs()), inputs);
  results.setValues(cast<OpResult>(getOutputs()), current->getResults());
  return DiagnosedSilenceableFailure::success();
}

LogicalResult
IREE::transform_dialect::MatchCastCompatibleDagFromRootOp::verify() {
  auto &body = getRegion().front();
  if (llvm::range_size(body.getOperations()) < 2) {
    return emitOpError() << "match region must contain at least one operation";
  }
  // TODO: Region verification that it includes a single DAG.
  return success();
}

//===----------------------------------------------------------------------===//
// MatchContractionOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchContractionOp::matchOperation(
    Operation *current, transform::TransformResults &results,
    transform::TransformState &state) {
  Location loc = current->getLoc();
  auto linalgOp = dyn_cast<linalg::LinalgOp>(current);
  if (!linalgOp) {
    return emitSilenceableFailure(loc) << "Operation is not a LinalgOp.";
  }

  if (!linalg::isaContractionOpInterface(linalgOp)) {
    return emitSilenceableFailure(loc)
           << "Operation is not a contraction operation.";
  }

  Type targetLhsType = getLhsType();
  Type currentLhsType = getElementTypeOrSelf(linalgOp.getDpsInputs()[0]);
  if (currentLhsType != targetLhsType) {
    return emitSilenceableFailure(loc)
           << "LHS type doesn't match: expected " << targetLhsType << ", got "
           << currentLhsType;
  }

  Type targetRhsType = getRhsType();
  Type currentRhsType = getElementTypeOrSelf(linalgOp.getDpsInputs()[1]);
  if (currentRhsType != targetRhsType) {
    return emitSilenceableFailure(loc)
           << "RHS type doesn't match: expected " << targetRhsType << ", got "
           << currentRhsType;
  }

  Type targetOutputType = getOutputType();
  // Since linalg::isaContractionOpInterface already verified single output in
  // above code, we can directly access it.
  Type currentOutputType =
      getElementTypeOrSelf(linalgOp.getDpsInits()[0].getType());
  if (currentOutputType != targetOutputType) {
    return emitSilenceableFailure(loc)
           << "output type doesn't match: expected " << targetOutputType
           << ", got " << currentOutputType;
  }

  ArrayAttr currentIndexingMaps = linalgOp.getIndexingMaps();
  if (std::optional<ArrayAttr> targetIndexingMaps = getIndexingMaps()) {
    if (currentIndexingMaps != *targetIndexingMaps) {
      return emitSilenceableFailure(loc) << "indexing maps don't match";
    }
  }

  // Get the actual size values for batch/m/n/k dimensions after verifying it's
  // a contraction operation.
  linalg::ContractionDimensions contractionDims =
      linalg::inferContractionDims(linalgOp).value();
  SmallVector<int64_t> iterationDomain = linalgOp.getStaticLoopRanges();
  Builder builder(getContext());

  auto iterationSizes = [&](ArrayRef<unsigned> dimIndices) {
    return llvm::map_to_vector(dimIndices, [&](unsigned dimIdx) -> Attribute {
      return builder.getI64IntegerAttr(iterationDomain[dimIdx]);
    });
  };

  results.setParams(cast<OpResult>(getBatchDims()),
                    iterationSizes(contractionDims.batch));
  results.setParams(cast<OpResult>(getMDims()),
                    iterationSizes(contractionDims.m));
  results.setParams(cast<OpResult>(getNDims()),
                    iterationSizes(contractionDims.n));
  results.setParams(cast<OpResult>(getKDims()),
                    iterationSizes(contractionDims.k));

  return DiagnosedSilenceableFailure::success();
}

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchAttentionOp::matchOperation(
    Operation *current, transform::TransformResults &results,
    transform::TransformState &state) {
  Location loc = current->getLoc();
  auto attentionOp = dyn_cast<IREE::LinalgExt::AttentionOp>(current);
  if (!attentionOp) {
    return emitSilenceableFailure(loc)
           << "Operation is not an attention operation.";
  }

  Type targetQueryType = getQueryType();
  Type currentQueryType =
      getElementTypeOrSelf(attentionOp.getQuery().getType());
  if (currentQueryType != targetQueryType) {
    return emitSilenceableFailure(loc)
           << "Query type doesn't match: expected " << targetQueryType
           << ", got " << currentQueryType;
  }

  Type targetKeyType = getKeyType();
  Type currentKeyType = getElementTypeOrSelf(attentionOp.getKey().getType());
  if (currentKeyType != targetKeyType) {
    return emitSilenceableFailure(loc)
           << "Key type doesn't match: expected " << targetKeyType << ", got "
           << currentKeyType;
  }

  Type targetValueType = getValueType();
  Type currentValueType =
      getElementTypeOrSelf(attentionOp.getValue().getType());
  if (currentValueType != targetValueType) {
    return emitSilenceableFailure(loc)
           << "Value type doesn't match: expected " << targetValueType
           << ", got " << currentValueType;
  }

  Type targetOutputType = getOutputType();
  Type currentOutputType =
      getElementTypeOrSelf(attentionOp.getOutput().getType());
  if (currentOutputType != targetOutputType) {
    return emitSilenceableFailure(loc)
           << "Output type doesn't match: expected " << targetOutputType
           << ", got " << currentOutputType;
  }

  ArrayAttr currentIndexingMaps = attentionOp.getIndexingMaps();
  ArrayAttr targetIndexingMaps = getIndexingMaps();
  if (currentIndexingMaps != targetIndexingMaps) {
    return emitSilenceableFailure(loc) << "indexing maps don't match";
  }

  FailureOr<IREE::LinalgExt::AttentionOpDetail> maybeOpInfo =
      IREE::LinalgExt::AttentionOpDetail::get(
          attentionOp.getQueryMap(), attentionOp.getKeyMap(),
          attentionOp.getValueMap(), attentionOp.getOutputMap());
  if (failed(maybeOpInfo)) {
    return emitSilenceableFailure(loc)
           << "Failed to infer attention dimensions";
  }
  IREE::LinalgExt::AttentionOpDetail opInfo = *maybeOpInfo;
  SmallVector<int64_t> iterationDomain = attentionOp.getStaticLoopRanges();

  Builder builder(getContext());
  auto iterationSizes = [&](ArrayRef<int64_t> dimIndices) {
    return llvm::map_to_vector(dimIndices, [&](int64_t dimIdx) -> Attribute {
      return builder.getI64IntegerAttr(iterationDomain[dimIdx]);
    });
  };

  results.setParams(cast<OpResult>(getBatchDims()),
                    iterationSizes(opInfo.getBatchDims()));
  results.setParams(cast<OpResult>(getMDims()),
                    iterationSizes(opInfo.getMDims()));
  results.setParams(cast<OpResult>(getNDims()),
                    iterationSizes(opInfo.getNDims()));
  results.setParams(cast<OpResult>(getK1Dims()),
                    iterationSizes(opInfo.getK1Dims()));
  results.setParams(cast<OpResult>(getK2Dims()),
                    iterationSizes(opInfo.getK2Dims()));

  return DiagnosedSilenceableFailure::success();
}

//===----------------------------------------------------------------------===//
// MatchConvolutionOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchConvolutionOp::matchOperation(
    Operation *current, transform::TransformResults &results,
    transform::TransformState &state) {
  Location loc = current->getLoc();
  auto linalgOp = dyn_cast<linalg::LinalgOp>(current);
  if (!linalgOp) {
    return emitSilenceableFailure(loc) << "Operation is not a LinalgOp.";
  }

  if (!linalg::isaConvolutionOpInterface(linalgOp)) {
    return emitSilenceableFailure(loc)
           << "Operation is not a convolution operation.";
  }

  Type targetLhsType = getLhsType();
  Type currentLhsType = getElementTypeOrSelf(linalgOp.getDpsInputs()[0]);
  if (currentLhsType != targetLhsType) {
    return emitSilenceableFailure(loc)
           << "LHS type doesn't match: expected " << targetLhsType << ", got "
           << currentLhsType;
  }

  Type targetRhsType = getRhsType();
  Type currentRhsType = getElementTypeOrSelf(linalgOp.getDpsInputs()[1]);
  if (currentRhsType != targetRhsType) {
    return emitSilenceableFailure(loc)
           << "RHS type doesn't match: expected " << targetRhsType << ", got "
           << currentRhsType;
  }

  Type targetOutputType = getOutputType();
  Type currentOutputType =
      getElementTypeOrSelf(linalgOp.getDpsInits()[0].getType());
  if (currentOutputType != targetOutputType) {
    return emitSilenceableFailure(loc)
           << "output type doesn't match: expected " << targetOutputType
           << ", got " << currentOutputType;
  }

  ArrayAttr currentIndexingMaps = linalgOp.getIndexingMaps();
  if (std::optional<ArrayAttr> targetIndexingMaps = getIndexingMaps()) {
    if (currentIndexingMaps != *targetIndexingMaps) {
      return emitSilenceableFailure(loc) << "indexing maps don't match";
    }
  }

  FailureOr<linalg::ConvolutionDimensions> maybeConvDims =
      linalg::inferConvolutionDims(linalgOp);
  if (failed(maybeConvDims)) {
    return emitSilenceableFailure(loc)
           << "Failed to infer convolution dimensions.";
  }
  linalg::ConvolutionDimensions convDims = *maybeConvDims;
  SmallVector<int64_t> iterationDomain = linalgOp.getStaticLoopRanges();

  Builder builder(getContext());
  auto buildI64Attrs = [&builder](const auto &values, const auto &transform) {
    return llvm::map_to_vector(values, [&](auto val) -> Attribute {
      return builder.getI64IntegerAttr(transform(val));
    });
  };
  auto getIterationSize = [&](unsigned idx) { return iterationDomain[idx]; };

  results.setParams(cast<OpResult>(getBatchDims()),
                    buildI64Attrs(convDims.batch, getIterationSize));
  results.setParams(cast<OpResult>(getOutputImageDims()),
                    buildI64Attrs(convDims.outputImage, getIterationSize));
  results.setParams(cast<OpResult>(getOutputChannelDims()),
                    buildI64Attrs(convDims.outputChannel, getIterationSize));
  results.setParams(cast<OpResult>(getFilterDims()),
                    buildI64Attrs(convDims.filterLoop, getIterationSize));
  results.setParams(cast<OpResult>(getInputChannelDims()),
                    buildI64Attrs(convDims.inputChannel, getIterationSize));
  results.setParams(cast<OpResult>(getDepthDims()),
                    buildI64Attrs(convDims.depth, getIterationSize));
  results.setParams(
      cast<OpResult>(getStrides()),
      buildI64Attrs(convDims.strides, [](int64_t val) { return val; }));
  results.setParams(
      cast<OpResult>(getDilations()),
      buildI64Attrs(convDims.dilations, [](int64_t val) { return val; }));
  return DiagnosedSilenceableFailure::success();
}

//===----------------------------------------------------------------------===//
// MatchDimsEqualOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure IREE::transform_dialect::MatchDimsEqualOp::apply(
    transform::TransformRewriter &rewriter,
    transform::TransformResults &results, transform::TransformState &state) {
  ArrayRef<transform::Param> actualDimAttrs =
      state.getParams(getDimensionSizes());
  ArrayRef<int64_t> expectedDims = getExpectedValues();

  SmallVector<std::optional<int64_t>> actualDims = llvm::map_to_vector(
      actualDimAttrs, [](Attribute attr) -> std::optional<int64_t> {
        if (auto intAttr = dyn_cast<IntegerAttr>(attr)) {
          return intAttr.getInt();
        }
        return std::nullopt;
      });

  if (!llvm::equal(actualDims, expectedDims,
                   [](const std::optional<int64_t> &lhs, int64_t rhs) {
                     return rhs == -1 || lhs == rhs;
                   })) {
    return emitSilenceableError() << "Dimension sizes do not match";
  }

  return DiagnosedSilenceableFailure::success();
}

void IREE::transform_dialect::MatchDimsEqualOp::getEffects(
    SmallVectorImpl<MemoryEffects::EffectInstance> &effects) {
  transform::onlyReadsHandle(getDimensionSizesMutable(), effects);
}

//===----------------------------------------------------------------------===//
// MatchCastCompatibleTypesOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchCastCompatibleTypesOp::matchValue(
    Value current, transform::TransformResults &results,
    transform::TransformState &state) {
  Type targetType = getTargetType();
  if (auto targetTensorType = dyn_cast<RankedTensorType>(targetType)) {
    if (!isCastableToTensorType(current.getType(), targetTensorType)) {
      return emitSilenceableError()
             << "type " << current.getType() << " is not castable to "
             << targetTensorType;
    }
    return DiagnosedSilenceableFailure::success();
  }
  if (current.getType() != targetType) {
    return emitSilenceableError()
           << "type " << current.getType() << " does not match " << targetType;
  }
  return DiagnosedSilenceableFailure::success();
}

//===----------------------------------------------------------------------===//
// MatchDimBoundsOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchDimBoundsOp::matchValue(
    Value current, transform::TransformResults &results,
    transform::TransformState &state) {
  auto shapedType = dyn_cast<ShapedType>(current.getType());
  if (!shapedType) {
    return emitSilenceableError()
           << "type " << current.getType() << " is not a shaped type";
  }
  int64_t dim = getDim();
  if (dim >= shapedType.getRank()) {
    return emitSilenceableError()
           << "dim " << dim << " out of range for shaped type " << shapedType;
  }
  if (std::optional<int64_t> lb = getLowerBound()) {
    auto constantLb = ValueBoundsConstraintSet::computeConstantBound(
        presburger::BoundType::LB, {current, /*dim=*/dim},
        /*stopCondition=*/nullptr, /*closedLB=*/true);
    if (failed(constantLb)) {
      return emitSilenceableError()
             << "failed to compute constant lower bound for dim " << dim;
    }
    if (lb.value() > constantLb.value()) {
      return emitSilenceableError()
             << "dim " << dim << " is not >= " << lb.value();
    }
  }
  if (std::optional<int64_t> ub = getUpperBound()) {
    auto constantUb = ValueBoundsConstraintSet::computeConstantBound(
        presburger::BoundType::UB, {current, /*dim=*/dim},
        /*stopCondition=*/nullptr, /*closedUB=*/true);
    if (failed(constantUb)) {
      return emitSilenceableError()
             << "failed to compute constant upper bound for dim " << dim;
    }
    if (ub.value() < constantUb.value()) {
      return emitSilenceableError()
             << "dim " << dim << " is not <= " << ub.value();
    }
  }
  return DiagnosedSilenceableFailure::success();
}

//===----------------------------------------------------------------------===//
// MatchDimIsMultipleOfOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchDimIsMultipleOfOp::matchValue(
    Value current, transform::TransformResults &results,
    transform::TransformState &state) {
  MLIRContext *ctx = current.getContext();
  auto shapedType = dyn_cast<ShapedType>(current.getType());
  if (!shapedType) {
    return emitSilenceableError()
           << "type " << current.getType() << " is not a shaped type";
  }
  int64_t dim = getDim();
  if (dim >= shapedType.getRank()) {
    return emitSilenceableError()
           << "dim " << dim << " out of range for shaped type " << shapedType;
  }
  int64_t size = getSize();
  ValueBoundsConstraintSet::Variable dimVar(current, dim);

  // Check if current[dim] % size == 0. There are a couple of options for how
  // to do this (e.g. mul(floordiv)). Affine map canonicalizations are good
  // at dropping terms that statically divide the mod RHS so we go with this
  // one.
  AffineMap modMap = AffineMap::get(/*dimCount=*/0, /*symbolCount=*/1,
                                    getAffineSymbolExpr(0, ctx) %
                                        getAffineConstantExpr(size, ctx));
  ValueBoundsConstraintSet::Variable modVar(modMap, {dimVar});
  Builder b(ctx);
  FailureOr<bool> maybeFailed = ValueBoundsConstraintSet::areEqual(
      modVar, OpFoldResult{b.getIndexAttr(0)});
  if (failed(maybeFailed) || !maybeFailed.value()) {
    return emitSilenceableError()
           << "dim " << dim << " of shaped type " << shapedType
           << " is not a multiple of " << size;
  }
  return DiagnosedSilenceableFailure::success();
}

//===----------------------------------------------------------------------===//
// MatchRegionsOp
//===----------------------------------------------------------------------===//

DiagnosedSilenceableFailure
IREE::transform_dialect::MatchRegionsOp::matchOperation(
    Operation *current, transform::TransformResults &results,
    transform::TransformState &state) {
  Operation *comparisonTarget = &getRegion().front().front();
  OperationEquivalenceCache cache(current->getContext());
  auto mapping = cache.acquireMapping();
  return compareOperationRegions(*this, cache, *mapping, comparisonTarget,
                                 current);
}

LogicalResult IREE::transform_dialect::MatchRegionsOp::verify() {
  auto &body = getRegion().front();
  if (llvm::range_size(body.getOperations()) != 2) {
    return emitOpError() << "match region must contain exactly one operation";
  }
  Operation *target = &body.front();
  if (target->getNumRegions() == 0) {
    return emitOpError() << "contained operation for comparison must have at "
                            "least one region";
  }
  return success();
}

} // namespace mlir::iree_compiler

#define GET_OP_CLASSES
#include "iree/compiler/Preprocessing/TransformExtensions/PreprocessingExtensionsOps.cpp.inc"
