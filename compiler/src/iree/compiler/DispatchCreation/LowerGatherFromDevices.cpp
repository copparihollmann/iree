// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// Rewrites flow.tensor.gather_from_devices into existing Flow + tensor +
// linalg ops so the standard FlowToStream conversion handles it without a
// bespoke pattern. See the pass description in Passes.td for full details.

#include "iree/compiler/Dialect/Flow/IR/FlowOps.h"
#include "iree/compiler/Dialect/HAL/IR/HALDialect.h"
#include "iree/compiler/Dialect/HAL/IR/HALTypes.h"
#include "iree/compiler/DispatchCreation/Passes.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/AffineMap.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Interfaces/FunctionInterfaces.h"

namespace mlir::iree_compiler::DispatchCreation {

#define GEN_PASS_DEF_LOWERGATHERFROMDEVICESPASS
#include "iree/compiler/DispatchCreation/Passes.h.inc"

namespace {

struct LowerGatherFromDevicesPass final
    : impl::LowerGatherFromDevicesPassBase<LowerGatherFromDevicesPass> {
  using Base::Base;
  void runOnOperation() override;
};

// Build an elementwise binary linalg.generic that computes
//   %out[i...] = combine(%lhs[i...], %rhs[i...])
// where `combine` is selected by `reduction` ("add" / "max" / "any"). The
// result is materialized into a fresh tensor.empty.
static Value buildElementwiseReducer(OpBuilder &b, Location loc, Value lhs,
                                     Value rhs, StringRef reduction) {
  auto t = cast<RankedTensorType>(lhs.getType());
  auto elt = t.getElementType();
  unsigned rank = t.getRank();

  SmallVector<OpFoldResult> outShape;
  for (unsigned d = 0; d < rank; ++d) {
    if (t.isDynamicDim(d)) {
      outShape.push_back(b.create<tensor::DimOp>(loc, lhs, d).getResult());
    } else {
      outShape.push_back(b.getIndexAttr(t.getDimSize(d)));
    }
  }
  Value out = b.create<tensor::EmptyOp>(loc, outShape, elt);

  // All-parallel iterators with identity indexing maps.
  SmallVector<utils::IteratorType> iters(rank, utils::IteratorType::parallel);
  AffineMap idMap = AffineMap::getMultiDimIdentityMap(rank, b.getContext());
  SmallVector<AffineMap> maps = {idMap, idMap, idMap};

  auto reducerOp = b.create<linalg::GenericOp>(
      loc, /*resultTypes=*/TypeRange{out.getType()},
      /*inputs=*/ValueRange{lhs, rhs},
      /*outputs=*/ValueRange{out}, maps, iters,
      [&](OpBuilder &nested, Location nloc, ValueRange args) {
        Value a = args[0];
        Value bv = args[1];
        Value combined;
        if (reduction == "add") {
          if (isa<FloatType>(elt)) {
            combined = nested.create<arith::AddFOp>(nloc, a, bv);
          } else {
            combined = nested.create<arith::AddIOp>(nloc, a, bv);
          }
        } else if (reduction == "max") {
          if (isa<FloatType>(elt)) {
            combined = nested.create<arith::MaximumFOp>(nloc, a, bv);
          } else {
            combined = nested.create<arith::MaxSIOp>(nloc, a, bv);
          }
        } else {
          // "any": pick lhs (deterministic; matches `gather_from_devices`
          // semantics for this kind, where the post-condition only requires
          // a representative shard).
          combined = a;
        }
        nested.create<linalg::YieldOp>(nloc, combined);
      });
  return reducerOp.getResult(0);
}

static void rewriteGather(IREE::Flow::TensorGatherFromDevicesOp op,
                          IRRewriter &rewriter) {
  Location loc = op.getLoc();
  rewriter.setInsertionPoint(op);

  ArrayAttr onDevices = op.getOnDevicesAttr();
  Attribute toDevice = op.getToDeviceAttr();
  StringRef reduction = op.getReduction();
  ValueRange shards = op.getShards();
  Value resultVal = op.getResult();
  auto resultType = cast<RankedTensorType>(resultVal.getType());

  // Step 1: Transfer each shard onto the home device. flow.tensor.transfer
  // accepts a #hal.device.promise / #hal.device.affinity attribute as the
  // `target`, so we can pass the gather op's to_device attr directly without
  // converting promise->affinity.
  SmallVector<Value> onTarget;
  onTarget.reserve(shards.size());
  for (auto [i, shard] : llvm::enumerate(shards)) {
    Attribute on = onDevices[i];
    auto shardType = cast<RankedTensorType>(shard.getType());
    SmallVector<Value> dynDims;
    for (unsigned d = 0; d < shardType.getRank(); ++d) {
      if (shardType.isDynamicDim(d)) {
        dynDims.push_back(
            rewriter.create<tensor::DimOp>(loc, shard, d).getResult());
      }
    }
    // Skip transfer if the shard is already on the home device.
    if (on == toDevice) {
      onTarget.push_back(shard);
      continue;
    }
    Value transferred = rewriter
                            .create<IREE::Flow::TensorTransferOp>(
                                loc, shardType, shard,
                                /*source_dims=*/dynDims,
                                /*target=*/toDevice)
                            .getResult();
    onTarget.push_back(transferred);
  }

  // Step 2: Combine.
  Value combined;
  if (reduction == "none") {
    // Apply-shard already emitted disjoint slices for each peer along the
    // sharded output dim. Without per-shard offset metadata at this point
    // we cannot reliably reconstruct the insert_slice chain — so for the
    // "none" reduction we expect the apply-shard pass NOT to emit a
    // gather_from_devices (it should emit insert_slice directly). If we
    // do see one, fall back to selecting the first shard with a warning.
    op.emitWarning() << "gather_from_devices with reduction='none' is "
                        "unexpected; apply-shard should emit insert_slice "
                        "directly. Using shard 0 as a fallback.";
    combined = onTarget.front();
  } else {
    // reduction = add | max | any: chain elementwise reducers.
    combined = onTarget.front();
    for (size_t i = 1; i < onTarget.size(); ++i) {
      combined = buildElementwiseReducer(rewriter, loc, combined, onTarget[i],
                                         reduction);
    }
  }

  // Match types if needed (fresh tensor.empty path may have changed
  // identity but the shape/element type are preserved).
  if (combined.getType() != resultType) {
    combined = rewriter.create<tensor::CastOp>(loc, resultType, combined);
  }

  rewriter.replaceOp(op, combined);
}

void LowerGatherFromDevicesPass::runOnOperation() {
  FunctionOpInterface funcOp = getOperation();
  IRRewriter rewriter(funcOp.getContext());

  SmallVector<IREE::Flow::TensorGatherFromDevicesOp> worklist;
  funcOp.walk([&](IREE::Flow::TensorGatherFromDevicesOp op) {
    worklist.push_back(op);
  });
  for (auto op : worklist) {
    rewriteGather(op, rewriter);
  }
}

} // namespace

} // namespace mlir::iree_compiler::DispatchCreation
