// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/compiler/GlobalOptimization/Passes.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#define DEBUG_TYPE "iree-global-opt-fuse-transpose-into-matmul"

namespace mlir::iree_compiler::GlobalOptimization {

#define GEN_PASS_DEF_FUSETRANSPOSEINTOMATMULPASS
#include "iree/compiler/GlobalOptimization/Passes.h.inc"

namespace {

/// Pattern that detects linalg.matmul -> linalg.transpose([1,0]) chains
/// and annotates the matmul with `iree.opu_transposed_output`.
/// Limited to square outputs (M == N) where the transpose is type-preserving.
struct FuseTransposeIntoMatmulPattern
    : public OpRewritePattern<linalg::TransposeOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(linalg::TransposeOp transposeOp,
                                PatternRewriter &rewriter) const override {
    // Check this is a 2D [1,0] transpose.
    ArrayRef<int64_t> perm = transposeOp.getPermutation();
    if (perm.size() != 2 || perm[0] != 1 || perm[1] != 0)
      return failure();

    // The input to the transpose must be a matmul with a single use.
    Value transposeInput = transposeOp.getInput();
    auto matmulOp = transposeInput.getDefiningOp<linalg::MatmulOp>();
    if (!matmulOp || !matmulOp->hasOneUse())
      return failure();

    // Only handle square outputs (M == N) for now.
    auto resultType =
        dyn_cast<RankedTensorType>(matmulOp.getResult(0).getType());
    if (!resultType || resultType.getRank() != 2)
      return failure();
    int64_t M = resultType.getDimSize(0);
    int64_t N = resultType.getDimSize(1);
    if (M != N || ShapedType::isDynamic(M))
      return failure();

    // Don't re-annotate.
    if (matmulOp->hasAttr("iree.opu_transposed_output"))
      return failure();

    // Annotate the matmul. Since M == N, the result type is unchanged.
    rewriter.modifyOpInPlace(matmulOp, [&]() {
      matmulOp->setAttr("iree.opu_transposed_output",
                        rewriter.getUnitAttr());
    });

    // Replace the transpose with the matmul result (types match: MxM == MxM).
    rewriter.replaceOp(transposeOp, matmulOp.getResult(0));

    LLVM_DEBUG(llvm::dbgs() << "Fused transpose into matmul: " << matmulOp
                            << "\n");
    return success();
  }
};

struct FuseTransposeIntoMatmulPass
    : impl::FuseTransposeIntoMatmulPassBase<FuseTransposeIntoMatmulPass> {
  void runOnOperation() override {
    MLIRContext *context = &getContext();
    RewritePatternSet patterns(context);
    patterns.add<FuseTransposeIntoMatmulPattern>(context);
    if (failed(applyPatternsGreedily(getOperation(), std::move(patterns)))) {
      return signalPassFailure();
    }
  }
};

} // namespace
} // namespace mlir::iree_compiler::GlobalOptimization
