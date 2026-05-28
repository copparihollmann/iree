// Copyright 2026 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "iree/compiler/Dialect/Flow/IR/FlowOps.h"
#include "iree/compiler/DispatchCreation/Passes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"

#define DEBUG_TYPE "iree-dispatch-creation-tag-dispatch-ids"

namespace mlir::iree_compiler::DispatchCreation {

#define GEN_PASS_DEF_TAGDISPATCHIDSPASS
#include "iree/compiler/DispatchCreation/Passes.h.inc"

namespace {

// Stamps a stable, module-wide `iree.dispatch_id : i64` attribute on every
// `flow.dispatch.region`. The XPU-RT scheduler keys directives off this id, and
// the apply-schedule-directives pass uses it to locate dispatches after later
// passes rename or duplicate ops.
//
// Numbering is deterministic across runs: post-order walk of the module, which
// matches the order in which FormDispatchRegionsPass produces regions. Existing
// ids are preserved (idempotent across Phase 1 / Phase 2 round-trips).
struct TagDispatchIdsPass final
    : impl::TagDispatchIdsPassBase<TagDispatchIdsPass> {
  using Base::Base;
  void runOnOperation() override;
};

} // namespace

static constexpr llvm::StringLiteral kDispatchIdAttr = "iree.dispatch_id";

void TagDispatchIdsPass::runOnOperation() {
  ModuleOp moduleOp = getOperation();
  Builder b(moduleOp.getContext());

  int64_t maxExisting = -1;
  SmallVector<IREE::Flow::DispatchRegionOp> untagged;
  moduleOp.walk([&](IREE::Flow::DispatchRegionOp regionOp) {
    if (auto existing =
            regionOp->getAttrOfType<IntegerAttr>(kDispatchIdAttr)) {
      maxExisting = std::max(maxExisting, existing.getInt());
      return;
    }
    untagged.push_back(regionOp);
  });

  int64_t nextId = maxExisting + 1;
  for (auto regionOp : untagged) {
    regionOp->setAttr(kDispatchIdAttr, b.getI64IntegerAttr(nextId++));
  }
}

} // namespace mlir::iree_compiler::DispatchCreation
