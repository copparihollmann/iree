// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// ===== Saturn OPU (+xopu) =====
// Preprocessing pass that collapses multi-N contractions into standard 2D
// matmuls so they can flow through the encoding → mmt4d → OPU ukernel pipeline.
//
// Pattern: out[H, M, D] = Σ_k lhs[M, K] × rhs[K, H, D]
// Becomes:
//   rhs_flat = collapse_shape rhs [[0], [1, 2]]     // [K, H*D]
//   out_flat_init = fill(0) : tensor<M, H*D>
//   out_flat = matmul(lhs, rhs_flat, out_flat_init)  // [M, H*D]
//   out_3d = expand_shape out_flat [[0], [1, 2]]     // [M, H, D]
//   out = transpose out_3d [1, 0, 2]                 // [H, M, D]

#include "iree/compiler/Preprocessing/Common/Passes.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/Utils/Utils.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

namespace mlir::iree_compiler::Preprocessing {

#define GEN_PASS_DEF_COLLAPSEMULTINCONTRACTIONSPASS
#include "iree/compiler/Preprocessing/Common/Passes.h.inc"

namespace {

struct CollapseMultiNPattern : OpRewritePattern<linalg::GenericOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(linalg::GenericOp genericOp,
                                PatternRewriter &rewriter) const override {
    // Must be a contraction.
    if (!linalg::isaContractionOpInterface(genericOp))
      return failure();

    auto cDims = linalg::inferContractionDims(genericOp);
    if (failed(cDims))
      return failure();

    // Only handle exactly 2 N dims, single M and K, no batch.
    if (cDims->n.size() != 2 || cDims->m.size() != 1 ||
        cDims->k.size() != 1 || !cDims->batch.empty())
      return failure();

    // Must have projected permutation maps and 2 inputs + 1 output.
    if (genericOp.getNumDpsInputs() != 2 || genericOp.getNumDpsInits() != 1)
      return failure();
    for (auto map : genericOp.getIndexingMapsArray()) {
      if (!map.isProjectedPermutation())
        return failure();
    }

    auto lhsType = dyn_cast<RankedTensorType>(
        genericOp.getDpsInputOperand(0)->get().getType());
    auto rhsType = dyn_cast<RankedTensorType>(
        genericOp.getDpsInputOperand(1)->get().getType());
    auto outType = dyn_cast<RankedTensorType>(
        genericOp.getDpsInitOperand(0)->get().getType());
    if (!lhsType || !rhsType || !outType)
      return failure();

    // All shapes must be static.
    if (!lhsType.hasStaticShape() || !rhsType.hasStaticShape() ||
        !outType.hasStaticShape())
      return failure();

    auto maps = genericOp.getIndexingMapsArray();
    AffineMap lhsMap = maps[0]; // e.g., (d0,d1,d2,d3) -> (d1, d3)
    AffineMap rhsMap = maps[1]; // e.g., (d0,d1,d2,d3) -> (d3, d0, d2)
    AffineMap outMap = maps[2]; // e.g., (d0,d1,d2,d3) -> (d0, d1, d2)

    unsigned mDim = cDims->m[0];
    unsigned kDim = cDims->k[0];
    unsigned n0Dim = cDims->n[0];
    unsigned n1Dim = cDims->n[1];

    // Find which RHS tensor dims correspond to the two N dims.
    // RHS must have both N dims contiguous for collapse_shape to work.
    std::optional<unsigned> n0InRhs, n1InRhs, kInRhs;
    for (unsigned i = 0; i < rhsMap.getNumResults(); i++) {
      auto dimExpr = dyn_cast<AffineDimExpr>(rhsMap.getResult(i));
      if (!dimExpr)
        continue;
      if (dimExpr.getPosition() == n0Dim)
        n0InRhs = i;
      if (dimExpr.getPosition() == n1Dim)
        n1InRhs = i;
      if (dimExpr.getPosition() == kDim)
        kInRhs = i;
    }
    if (!n0InRhs || !n1InRhs || !kInRhs)
      return failure();

    // N dims must be contiguous in RHS for collapse_shape.
    unsigned nFirstInRhs = std::min(*n0InRhs, *n1InRhs);
    unsigned nLastInRhs = std::max(*n0InRhs, *n1InRhs);
    if (nLastInRhs - nFirstInRhs != 1)
      return failure();

    // Find dims in output map.
    std::optional<unsigned> n0InOut, n1InOut, mInOut;
    for (unsigned i = 0; i < outMap.getNumResults(); i++) {
      auto dimExpr = dyn_cast<AffineDimExpr>(outMap.getResult(i));
      if (!dimExpr)
        continue;
      if (dimExpr.getPosition() == n0Dim)
        n0InOut = i;
      if (dimExpr.getPosition() == n1Dim)
        n1InOut = i;
      if (dimExpr.getPosition() == mDim)
        mInOut = i;
    }
    if (!n0InOut || !n1InOut || !mInOut)
      return failure();

    // Find M and K in LHS.
    std::optional<unsigned> mInLhs, kInLhs;
    for (unsigned i = 0; i < lhsMap.getNumResults(); i++) {
      auto dimExpr = dyn_cast<AffineDimExpr>(lhsMap.getResult(i));
      if (!dimExpr)
        continue;
      if (dimExpr.getPosition() == mDim)
        mInLhs = i;
      if (dimExpr.getPosition() == kDim)
        kInLhs = i;
    }
    if (!mInLhs || !kInLhs)
      return failure();

    // Get concrete sizes.
    int64_t n0Size = rhsType.getDimSize(*n0InRhs);
    int64_t n1Size = rhsType.getDimSize(*n1InRhs);
    int64_t nFlatSize = n0Size * n1Size;
    int64_t mSize = lhsType.getDimSize(*mInLhs);
    (void)kInLhs; // Used only for map construction below.

    Location loc = genericOp.getLoc();
    Value lhs = genericOp.getDpsInputOperand(0)->get();
    Value rhs = genericOp.getDpsInputOperand(1)->get();

    // Step 1: Collapse RHS N dims → [K, N_flat] or [N_flat, K].
    // Build reassociation: group the two N dims together.
    SmallVector<ReassociationIndices> rhsReassoc;
    for (unsigned i = 0; i < rhsType.getRank(); i++) {
      if (i == nFirstInRhs) {
        rhsReassoc.push_back({(int64_t)nFirstInRhs, (int64_t)nLastInRhs});
      } else if (i == nLastInRhs) {
        continue; // Already included in previous group.
      } else {
        rhsReassoc.push_back({(int64_t)i});
      }
    }
    auto rhsFlatType = tensor::CollapseShapeOp::inferCollapsedType(
        rhsType, rhsReassoc);
    Value rhsFlat = tensor::CollapseShapeOp::create(rewriter, loc,
                                                     rhsFlatType, rhs,
                                                     rhsReassoc);

    // Step 2: Create 2D matmul: [M, K] × [K, N_flat] → [M, N_flat].
    // Determine the flat RHS layout: after collapse, K is at one position and
    // N_flat at the other.
    unsigned kInRhsFlat = (*kInRhs > nFirstInRhs) ? *kInRhs - 1 : *kInRhs;
    unsigned nInRhsFlat = (kInRhsFlat == 0) ? 1 : 0;

    // Create output tensor [M, N_flat].
    auto outElemType = outType.getElementType();
    auto outFlatType = RankedTensorType::get({mSize, nFlatSize}, outElemType);
    Value emptyOut = tensor::EmptyOp::create(
        rewriter, loc, outFlatType.getShape(), outFlatType.getElementType());

    // Fill with zero.
    Value zero;
    if (isa<IntegerType>(outElemType)) {
      zero = arith::ConstantOp::create(rewriter, loc,
                                        rewriter.getZeroAttr(outElemType));
    } else {
      zero = arith::ConstantOp::create(
          rewriter, loc, rewriter.getFloatAttr(outElemType, 0.0));
    }
    Value filledOut = linalg::FillOp::create(rewriter, loc, zero, emptyOut)
                          .getResult(0);

    // Build 2D matmul maps: (d0, d1, d2) -> ...
    // d0 = M, d1 = N_flat, d2 = K
    // LHS: (d0, d2) if M is first in LHS, else (d2, d0)
    // RHS_flat: (d2, d1) if K is first in RHS_flat, else (d1, d2)
    // Out: (d0, d1)
    MLIRContext *ctx = rewriter.getContext();
    auto d0 = getAffineDimExpr(0, ctx); // M
    auto d1 = getAffineDimExpr(1, ctx); // N_flat
    auto d2 = getAffineDimExpr(2, ctx); // K

    AffineMap newLhsMap;
    if (*mInLhs < *kInLhs)
      newLhsMap = AffineMap::get(3, 0, {d0, d2}, ctx);
    else
      newLhsMap = AffineMap::get(3, 0, {d2, d0}, ctx);

    AffineMap newRhsMap;
    if (kInRhsFlat < nInRhsFlat)
      newRhsMap = AffineMap::get(3, 0, {d2, d1}, ctx);
    else
      newRhsMap = AffineMap::get(3, 0, {d1, d2}, ctx);

    AffineMap newOutMap = AffineMap::get(3, 0, {d0, d1}, ctx);

    // Clone the body from the original generic.
    auto matmulGeneric = linalg::GenericOp::create(
        rewriter, loc, outFlatType, ValueRange{lhs, rhsFlat}, filledOut,
        ArrayRef<AffineMap>{newLhsMap, newRhsMap, newOutMap},
        ArrayRef<utils::IteratorType>{utils::IteratorType::parallel,
                                      utils::IteratorType::parallel,
                                      utils::IteratorType::reduction});

    // Copy the body from the original generic.
    IRMapping mapping;
    rewriter.cloneRegionBefore(genericOp.getRegion(),
                               matmulGeneric.getRegion(),
                               matmulGeneric.getRegion().end(), mapping);
    // Remove the empty block that GenericOp::create added.
    rewriter.eraseBlock(&matmulGeneric.getRegion().front());

    Value matmulResult = matmulGeneric.getResult(0);

    // Step 3: Expand result [M, N_flat] → [M, n0, n1] (or [M, n1, n0]).
    // The N_flat dim should expand back matching the RHS N dim order.
    int64_t nFirstSize = rhsType.getDimSize(nFirstInRhs);
    int64_t nLastSize = rhsType.getDimSize(nLastInRhs);
    SmallVector<ReassociationIndices> expandReassoc = {{0}, {1, 2}};
    auto expandedType =
        RankedTensorType::get({mSize, nFirstSize, nLastSize}, outElemType);
    Value expanded = tensor::ExpandShapeOp::create(
        rewriter, loc, expandedType, matmulResult, expandReassoc);

    // Step 4: Transpose to match original output layout [n0, M, n1] etc.
    // Original out map has dims at positions n0InOut, mInOut, n1InOut.
    // Our expanded tensor is [M, nFirst, nLast].
    // We need to map: expanded dim 0 → mInOut, expanded dim 1 → nFirstInOut,
    // expanded dim 2 → nLastInOut.
    // Where nFirstInOut is the output position of the N dim that was first in
    // RHS.
    unsigned nFirstDim = (*n0InRhs < *n1InRhs) ? n0Dim : n1Dim;
    unsigned nLastDim = (*n0InRhs < *n1InRhs) ? n1Dim : n0Dim;
    unsigned nFirstInOutPos =
        (nFirstDim == n0Dim) ? *n0InOut : *n1InOut;
    unsigned nLastInOutPos =
        (nLastDim == n0Dim) ? *n0InOut : *n1InOut;

    // Build permutation: expanded[i] goes to position perm[i] in output.
    // expanded = [M=0, nFirst=1, nLast=2]
    // output positions: M→mInOut, nFirst→nFirstInOutPos, nLast→nLastInOutPos
    SmallVector<int64_t> perm(3);
    // We need inverse: output[perm[i]] = expanded[i]
    // Actually linalg.transpose uses: output[i] = input[perm[i]]
    // So we need: for each output pos j, which expanded dim goes there?
    SmallVector<int64_t> invPerm(3);
    invPerm[*mInOut] = 0;
    invPerm[nFirstInOutPos] = 1;
    invPerm[nLastInOutPos] = 2;

    // Check if transpose is identity (no transpose needed).
    bool needsTranspose = (invPerm[0] != 0 || invPerm[1] != 1 || invPerm[2] != 2);

    Value result;
    if (needsTranspose) {
      Value emptyTransposed = tensor::EmptyOp::create(
          rewriter, loc, outType.getShape(), outType.getElementType());
      result =
          linalg::TransposeOp::create(rewriter, loc, expanded, emptyTransposed,
                                       invPerm)
              ->getResult(0);
    } else {
      result = expanded;
    }

    rewriter.replaceOp(genericOp, result);
    return success();
  }
};

struct CollapseMultiNContractionsPass final
    : impl::CollapseMultiNContractionsPassBase<
          CollapseMultiNContractionsPass> {
  void runOnOperation() override {
    MLIRContext *ctx = &getContext();
    RewritePatternSet patterns(ctx);
    patterns.insert<CollapseMultiNPattern>(ctx);
    if (failed(applyPatternsGreedily(getOperation(), std::move(patterns)))) {
      return signalPassFailure();
    }
  }
};

} // namespace
} // namespace mlir::iree_compiler::Preprocessing
