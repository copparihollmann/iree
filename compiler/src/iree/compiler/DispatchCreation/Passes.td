// Copyright 2023 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef IREE_COMPILER_DISPATCHCREATION_PASSES
#define IREE_COMPILER_DISPATCHCREATION_PASSES


include "mlir/Pass/PassBase.td"

// File organization:
// Groups passes that are related under one banner //===....===//. For example
// the dispatch region creation preprocessing passes and dispatch region
// formation passes are a couple of such groups. For any new pass add it to the
// relevant group and keep them alphabetical within a group.

//===---------------------------------------------------------------------===//
// Dispatch region creation preprocessing passes :
// Passes that transform the program before forming dispatches, like
// - Elementwise operation fusion
// - Reshape propagation passes
//===---------------------------------------------------------------------===//

def BitcastUnsupportedElementTypesPass :
    Pass<"iree-dispatch-creation-bitcast-unsupported-element-types"> {
  let summary = "Bitcasts tensor element types unsupported by the HAL";
  let dependentDialects = [
    "IREE::Flow::FlowDialect",
    "IREE::TensorExt::IREETensorExtDialect",
  ];
}

def BubbleUpExpandShapesPass :
    Pass<"iree-dispatch-creation-bubble-up-expand-shapes"> {
  let summary = "Propagate expand_shapes up the program (and collapse_shapes down).";
  let options = [
    Option<"enableReshapeMovementAcrossReductions", "enable-reshape-movement-across-reductions", "bool",
           /*default=*/"false", "Enables propagation of 'expand_shape's and 'collapse_shape's through 'linalg.generic's with reductions">
  ];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::linalg::LinalgDialect",
    "IREE::LinalgExt::IREELinalgExtDialect",
  ];
}

def InsertTensorBarriersPass :
    InterfacePass<"iree-dispatch-creation-insert-tensor-barriers",
                  "mlir::FunctionOpInterface"> {
  let summary = "Insert tensor barrier markers around computation regions.";
  let description = [{
    Walks from function boundaries and inserts iree_tensor_ext.compute_barrier.start
    and iree_tensor_ext.compute_barrier.end operations at the boundaries of
    computation regions (tensor/linalg/linalgext ops). These barriers allow
    controlling where certain transformations like reshape propagation can occur.

    The pass identifies compute operations and wraps tensor values flowing
    into and out of the compute region with the barrier operations.
  }];
  let dependentDialects = [
    "IREE::TensorExt::IREETensorExtDialect",
  ];
}

def RemoveTensorBarriersPass :
    InterfacePass<"iree-dispatch-creation-remove-tensor-barriers",
                  "mlir::FunctionOpInterface"> {
  let summary = "Remove tensor barrier markers from the program.";
  let description = [{
    Removes iree_tensor_ext.compute_barrier.start and iree_tensor_ext.compute_barrier.end
    operations from the program. These are identity operations that simply
    pass through their operands, so they can be safely removed by replacing
    all uses of their results with their operands.
  }];
  let dependentDialects = [
    "IREE::TensorExt::IREETensorExtDialect",
  ];
}

def ElementwiseOpFusionPass :
    Pass<"iree-dispatch-creation-elementwise-op-fusion", ""> {
  let summary = "Fuse elementwise operations.";
  let options = [
    Option<"intraDispatch", "intra-dispatch", "bool",
           /*default=*/"false",
           "Fuse operations within a dispatch only (default is to fuse only operations outside of a dispatch)">,
    Option<"fuseMultiReduction", "fuse-multi-reduction", "bool",
           /*default=*/"true", "Fuse ops that have multiple reduction iterators">,
    Option<"fuseTruncateOps", "fuse-truncate-ops", "bool",
           /*default=*/"false",
           "Fuse producer truncate-like operations with consumers">,
    Option<"fuseBroadcastOps", "fuse-broadcast-ops", "bool",
           /*default=*/"false", "Fuse broadcast-like ops with producers">,
  ];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
  ];
}

def FoldReshapesIntoTensorBarriersPass :
    InterfacePass<"iree-dispatch-creation-fold-reshapes-into-tensor-barriers",
                  "mlir::FunctionOpInterface"> {
  let summary = "Fold reshape operations into tensor barriers.";
  let description = [{
    Moves tensor.expand_shape and tensor.collapse_shape operations through
    iree_tensor_ext.compute_barrier.start and iree_tensor_ext.compute_barrier.end operations.
    This blocks reshapes on the edge of the program from being propagated.
  }];
  let dependentDialects = [
    "IREE::TensorExt::IREETensorExtDialect",
    "mlir::tensor::TensorDialect",
  ];
}

def FoldUnitExtentDimsPass :
    Pass<"iree-dispatch-creation-fold-unit-extent-dims", "mlir::ModuleOp"> {
  let summary = "Fold unit extent dimension of operations.";
  let description = [{
    Imports upstream patterns to fold unit extent dims but with IREE control.
  }];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::arith::ArithDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::tensor::TensorDialect",
  ];
}

def FoldUnitExtentDimsForFuncPass :
    Pass<"iree-dispatch-creation-fold-unit-extent-dims-for-func", ""> {
  let summary = "Fold unit extent dimension of operations on a function.";
  let description = [{
    Imports upstream patterns to fold unit extent dims but with IREE control.
  }];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::arith::ArithDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::tensor::TensorDialect",
  ];
}

def FuseHorizontalContractionsPass:
    InterfacePass<"iree-dispatch-creation-fuse-horizontal-contractions", "mlir::FunctionOpInterface"> {
  let summary = "Fuses horizontal contraction ops";
  let description = [{
    For cases where multiple contractions
    - that dont have a direct dependence
    - that have the same LHS operand
    - all the N dimensions of the RHS operands used are the same
    Such contractions can be executed as a single contraction, i.e.

    A = matmul(lhs, rhs0);
    B = matmul(lhs, rhs1);
    C = matmul(lhs, rhs2);

    can be combined into
    result = matmul(lhs, concat_along_N(rhs0, rhs1, rhs2));
    A = slice0(result)
    B = slice1(result)
    C = slice2(result)

    Instead of doing an actual concat of the RHS operands,
    and extracting slices of the result, the pass generates a single
    operation with
    - the lhs operands
    - all the rhs operands
    - multiple results representing the individual matmuls
  }];
  let dependentDialects = [
    "mlir::arith::ArithDialect",
    "mlir::tensor::TensorDialect",
  ];
  let options = [
    Option<"fusionLimit", "fusion-limit", "int",
            /*default=*/"3", "Maximum number of contractions fused into one">
  ];
  let statistics = [
    Statistic<"numFusionGroups", "num-fusion-groups", "Number of fusion groups found">,
    Statistic<"numSize2FusionGroups", "num-size-2-groups", "Number of fusion groups of size 2">,
    Statistic<"numSize3FusionGroups", "num-size-3-groups", "Number of fusion groups of size 3">
  ];
}

def FuseMultiUseElementwiseProducerPass :
    InterfacePass<"iree-dispatch-creation-fuse-multi-use-elementwise-producer",
                   "mlir::FunctionOpInterface"> {
  let summary = "Fuse elementwise linalg operations on tensors when producers have multiple uses.";
  let options = [
    Option<"intraDispatch", "intra-dispatch", "bool",
           /*default=*/"false", "Fuse operations within a dispatch only (default is to fuse only operations outside of a dispatch)">,
    Option<"numIterations", "num-iterations", "unsigned",
           /*default=*/"2", "Number of iterations to fuse multiuse ops">
  ];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::arith::ArithDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::math::MathDialect",
  ];
}

def FusionPreprocessingPass :
    Pass<"iree-dispatch-creation-fusion-preprocessing", ""> {
  let summary = "Run useful preprocessing patterns that help with fusion.";
  let dependentDialects = [
    "mlir::affine::AffineDialect",
  ];
}

def SinkReshapesPass :
    Pass<"iree-dispatch-creation-sink-reshapes", ""> {
  let summary = "Sink reshapes to allow for compute op -> consumer fusion.";
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::arith::ArithDialect",
    "IREE::LinalgExt::IREELinalgExtDialect",
  ];
}

def SplitReductionPass :
    Pass<"iree-dispatch-creation-split-reduction-ops", ""> {
  let summary = "Split reduction dimension to increase parallelism.";
  let dependentDialects = [
    "mlir::linalg::LinalgDialect",
    "IREE::LinalgExt::IREELinalgExtDialect",
  ];
}

def TensorPadToTensorInsertSlicePass :
    Pass<"iree-dispatch-creation-tensor-pad-to-tensor-insert-slice"> {
  let summary = "Convert tensor.pad into linalg.fill + tensor.insert_slice.";
  let options = [
    Option<"skipSingleLinalgOpUses", "skip-one-linalg-use-case", "bool",
           /*default=*/"false",
           "Skip the op that has only one use which is used"
           "by a Linalg op">,
  ];
  let dependentDialects = [
    "mlir::arith::ArithDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::math::MathDialect",
    "mlir::memref::MemRefDialect",
  ];
}

def TransposeGenericOpsPass :
    Pass<"iree-dispatch-creation-transpose-generic-ops", ""> {
  let summary = "Transpose generic op loops.";
  let dependentDialects = [
    "mlir::linalg::LinalgDialect",
  ];
}

//===---------------------------------------------------------------------===//
// Dispatch region creation passes.
//===---------------------------------------------------------------------===//

def CloneProducersIntoDispatchRegionsPass :
    InterfacePass<"iree-dispatch-creation-clone-producers-into-dispatch-regions", "mlir::FunctionOpInterface"> {
  let summary = "Clone producers into dispatch regions to be isolated above.";
  let description = [{
    Pass to clone into dispatch regions producers of values used in the dispatch
    regions but defined in the above. This prepares the dispatch regions for
    converting to dispatch workgroups with explicit captures.
  }];
  let options = [
    Option<"aggressive", "aggressive", "bool",
    /*default=*/"false",
    "Include operations that are cloned only under aggressive fusion mode">,
  ];
}

def CollapseDimensionsPass :
    InterfacePass<"iree-dispatch-creation-collapse-dimensions", "mlir::FunctionOpInterface"> {
  let summary = "Collapse dimensions of Linalg Ops on tensor ops.";
  let options = [
    Option<"maxIterations", "max-iterations", "int",
    /*default=*/"10",
    "Maximum number of iterations to wait for collapse dimensions to converge"
    >,
  ];
  let description = [{
    Collapse dimensions of Linalg Ops on tensor ops inside dispatch.region ops
    and hoist the reshaping operations out of the dispatch.
  }];
  let dependentDialects = [
    "IREE::LinalgExt::IREELinalgExtDialect",
  ];
}

def FormDispatchRegionsPass :
    InterfacePass<"iree-dispatch-creation-form-dispatch-regions", "mlir::FunctionOpInterface"> {
  let summary = "Form Dispatch Region Ops from Linalg operations on tensors to form dispatch.regions.";
  let options = [
    Option<"aggressiveFusion", "aggressive-fusion", "bool",
           /*default=*/"false", "Aggressive mode enabling fusions not ready for all backends">,
    Option<"fusePadWithConsumers", "fuse-pad-with-consumers", "bool",
           /*default=*/"false", "Enable fusing pad with consumer">,
    Option<"fusePadWithProducers", "fuse-pad-with-producers", "bool",
           /*default=*/"false", "Enable fusion of pad with producers">
  ];
  let description = [{
    Pass to form dispatch.region ops from Linalg on tensor ops. A dispatch region
    is created for each tiled loop nest. This pass only moves the root compute op
    into the dispatch region, allowing producers to be outside.
  }];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::scf::SCFDialect",
    "mlir::tensor::TensorDialect",
    "IREE::Flow::FlowDialect",
    "IREE::LinalgExt::IREELinalgExtDialect",
    "IREE::TensorExt::IREETensorExtDialect",
  ];
}

def FormScalarDispatchesPass :
    InterfacePass<"iree-dispatch-creation-form-scalar-dispatches", "mlir::FunctionOpInterface"> {
  let summary = "Form Dispatch Regions for scalar computations.";
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::tensor::TensorDialect",
    "IREE::Flow::FlowDialect",
  ];
}

def SetSplitReductionSizesPass :
    Pass<"iree-dispatch-creation-set-split-reduction-sizes"> {
  let summary = "Set 'iree_linalg_ext.split_reduction' attribute on ops";
  let options = [
    Option<"splitReductionTargetSize", "split-reduction-target-size", "int64_t", "1024",
           "Target tile size for split reduction. Inner reduction "
           "dimensions are tiled first, with the tile size rounded "
           "up until it evenly divides the iteration domain.">
  ];
  let dependentDialects = [];
}

def FormSplitReductionDispatchesPass :
    InterfacePass<"iree-dispatch-creation-form-split-reduction-dispatches", "mlir::FunctionOpInterface"> {
  let summary = "Partially tile reduction operations and place into dispatches";
  let options = [
    ListOption<"splitSize", "split-size", "int",
        "Tile sizes for split reduction (innermost first)">,
    Option<"enableFusePad", "enable-fuse-pad", "bool",
        /*default=*/"false", "Fuse pad into scf.forall">
  ];
  let dependentDialects = [
    "IREE::Flow::FlowDialect",
    "IREE::LinalgExt::IREELinalgExtDialect",
    "IREE::TensorExt::IREETensorExtDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::scf::SCFDialect",
  ];
}

def FuseEncodingOpsIntoDispatchRegionsPass :
    InterfacePass<"iree-dispatch-creation-fuse-encoding-ops-into-dispatch-regions-pass", "mlir::FunctionOpInterface"> {
  let summary = "Fuses set_encoding ops into producer dispatch regions, or forms new dispatches around them.";
  let dependentDialects = [
    "mlir::linalg::LinalgDialect",
    "IREE::Flow::FlowDialect",
    "IREE::Encoding::IREEEncodingDialect",
  ];
  let options = [
    Option<"enableAggressiveFusion", "enable-aggressive-fusion", "bool",
    /*default=*/"false",
    "Enable encoding op fusion if the producer has more than one use">,
  ];
}

def HoistEncodingOpsPass : Pass<"iree-dispatch-creation-hoist-encoding-ops", "mlir::ModuleOp"> {
  let summary = "Hoists tensor encoding ops out of flow dispatch regions.";
  let dependentDialects = [
    "mlir::linalg::LinalgDialect",
    "IREE::Flow::FlowDialect",
    "IREE::Encoding::IREEEncodingDialect",
  ];
}

def HoistUniformScalarComputePass :
    InterfacePass<"iree-dispatch-creation-hoist-uniform-scalar-compute", "mlir::FunctionOpInterface"> {
  let summary = "Hoists scalar (computation) out of dispatch regions.";
}

def PropagateEncodingsPass :
    InterfacePass<"iree-dispatch-creation-propagate-encodings", "mlir::FunctionOpInterface"> {
  let summary = "Propagate encodings across other operations.";
  let dependentDialects = [
    "mlir::tensor::TensorDialect",
    "IREE::Encoding::IREEEncodingDialect",
  ];
}

def AnnotateDataTilingHintsPass :
    InterfacePass<"iree-dispatch-creation-annotate-data-tiling-hints", "mlir::FunctionOpInterface"> {
  let summary = "Adds data-tiling hint attribute to linalg operations.";
  let description = [{
    The pass does nothing, if any operation already has the data-tiling hint
    attribute. Otherwise, it aggressively filters linalg ops and adds the
    data-tiling hint attribute to the operations.
  }];
}

def ApplyScheduleDirectivesPass :
    InterfacePass<"iree-dispatch-creation-apply-schedule-directives",
                  "mlir::FunctionOpInterface"> {
  let summary = "Apply split/grow schedule directives to dispatch regions.";
  let description = [{
    Reads the path supplied via `--iree-merlin-schedule-spec` and rewrites
    `flow.dispatch.region` ops keyed by `iree.dispatch_id`:

    - `split: factor=N, axis=A`: hoist the root linalg op out of its region,
      apply `linalg::splitOp` along the named axis at the midpoint, and wrap
      each half in a fresh dispatch region carrying the original
      `iree.dispatch_id` plus a 0/1 `iree.dispatch_subid`.
    - `grow: merge_with=ID`: inline the producer region's body into the
      consumer and erase the producer. Refuses if the producer has
      uses outside the consumer.

    `affinity` directives are handled later by
    `apply-affinity-directives` (which runs on workgroups). `shard` and
    `replicate` are not yet implemented; the pass emits a warning and
    leaves those dispatches alone.
  }];
  let dependentDialects = [
    "mlir::arith::ArithDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::tensor::TensorDialect",
    "IREE::Flow::FlowDialect",
    "IREE::HAL::HALDialect",
  ];
}

def ApplyAffinityDirectivesPass :
    Pass<"iree-dispatch-creation-apply-affinity-directives", "mlir::ModuleOp"> {
  let summary = "Apply schedule.json affinity directives to dispatch workgroups.";
  let description = [{
    Reads the path supplied via `--iree-merlin-schedule-spec` and stamps
    `stream.affinity = #hal.device.affinity<@<device>>` onto every
    `flow.dispatch.workgroups` op according to the directives keyed by
    `iree.dispatch_id`. Dispatches not named in the schedule receive the
    `global.default_affinity` (if set). This is the compiler-side replacement
    for the regex-based `samples/research/promise_schedule_multi_model/`
    `hw_annotation.py`.
  }];
  let dependentDialects = [
    "IREE::Flow::FlowDialect",
    "IREE::HAL::HALDialect",
  ];
}

def LowerGatherFromDevicesPass :
    InterfacePass<"iree-dispatch-creation-lower-gather-from-devices",
                  "mlir::FunctionOpInterface"> {
  let summary = "Lower flow.tensor.gather_from_devices to existing Flow ops.";
  let description = [{
    Rewrites every `flow.tensor.gather_from_devices` op (emitted by
    `apply-schedule-directives` for the `shard` directive) into existing
    Flow + tensor + linalg ops so the standard FlowToStream conversion
    pipeline can handle it without a bespoke pattern:

      reduction = "none": one `flow.tensor.transfer` per shard onto the
        home device, then a chain of `tensor.insert_slice` (the apply-shard
        pass already emits per-shard slices, so each shard contributes a
        disjoint region of the output).

      reduction = "add" | "max" | "any": one `flow.tensor.transfer` per
        shard onto the home device, then a chain of `linalg.generic`
        elementwise reducers (one per non-base shard).

    This is forward-compatible with a future Stream-level peephole that
    matches `gather_from_devices` directly and lowers to a HAL collective
    op (`hal.fence`-coordinated all_reduce); the peephole would simply
    run before this pass.
  }];
  let dependentDialects = [
    "mlir::arith::ArithDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::tensor::TensorDialect",
    "IREE::Flow::FlowDialect",
    "IREE::HAL::HALDialect",
  ];
}

def TagDispatchIdsPass :
    Pass<"iree-dispatch-creation-tag-dispatch-ids", "mlir::ModuleOp"> {
  let summary = "Stamp a stable iree.dispatch_id on every flow.dispatch.region.";
  let description = [{
    Walks the module in post-order and assigns a unique i64
    `iree.dispatch_id` attribute to each `flow.dispatch.region` that does not
    already carry one. The id is the anchor used by the XPU-RT scheduler and
    the apply-schedule-directives pass to refer to a specific dispatch across
    serialization boundaries and through later passes that may rename or clone
    operations.

    The pass is idempotent: existing ids are preserved, and new ids are
    assigned starting from one past the current maximum.
  }];
  let dependentDialects = [
    "IREE::Flow::FlowDialect",
  ];
}

def SetEncodingPass : InterfacePass<"iree-dispatch-creation-set-encoding",
                                    "mlir::FunctionOpInterface"> {
  let summary = "Introduces tensor encoding for flow dispatch regions.";
  let description = [{
    Sets the encoding for compute operations to allow execution of the
    operations in tiled/padded layouts.
  }];
  let dependentDialects = [
    "mlir::linalg::LinalgDialect",
    "IREE::Flow::FlowDialect",
    "IREE::Encoding::IREEEncodingDialect",
  ];
  let options = [
    Option<
        "encodingOption", "encoding-option",
        "mlir::iree_compiler::DispatchCreation::EncodingOptions",
        /*default=*/
        "mlir::iree_compiler::DispatchCreation::EncodingOptions::Generic",
        "Select the type of encoding options to add.",
        [{::llvm::cl::values(
            clEnumValN(
                mlir::iree_compiler::DispatchCreation::EncodingOptions::Padding,
                "padding", "Encode tensors that need to be padded."),
            clEnumValN(
                mlir::iree_compiler::DispatchCreation::EncodingOptions::Generic,
                "default", "Uses EncodingAttr which encodes as much information as possible."))}]>,
  ];
}

def ConvertEncodingToFlowPass :
    InterfacePass<"iree-dispatch-creation-convert-encoding-to-flow", "mlir::FunctionOpInterface"> {
  let summary = "Convert top-level Encoding ops to Flow ops.";
  let description = [{
    Pass to convert top-level Encoding ops to Flow ops, which only converts the
    Encoding ops outside flow.dispatch.region to Flow.
  }];
  let dependentDialects = [
    "IREE::Encoding::IREEEncodingDialect",
    "IREE::Flow::FlowDialect",
  ];
}

//===---------------------------------------------------------------------===//
// Dispatch region to workgroups passes
//===---------------------------------------------------------------------===//

def ConvertDispatchRegionsToWorkgroupsPass :
    InterfacePass<"iree-dispatch-creation-convert-dispatch-regions-to-workgroups", "mlir::FunctionOpInterface"> {
  let summary = "Convert dispatch regions to dispatch workgroups.";
  let description = [{
    Pass to convert dispatch regions to dispatch workgroups. This pass is
    intended to be used after dispatch regions have been formed.
  }];
  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::linalg::LinalgDialect",
    "mlir::scf::SCFDialect",
    "mlir::tensor::TensorDialect",
    "IREE::Flow::FlowDialect",
    "IREE::TensorExt::IREETensorExtDialect",
  ];
  let statistics = [
    Statistic<"numDispatches", "num-dispatches", "Number of dispatches created">
  ];
}

def ConvertTensorToFlowPass :
    InterfacePass<"iree-dispatch-creation-convert-tensor-to-flow", "mlir::FunctionOpInterface"> {
    let summary = "Convert tensor operations to flow";
    let description = [{
      Pass to convert tensor operations to flow.tensor.* operations.
    }];
    let dependentDialects = [
      "mlir::affine::AffineDialect",
      "mlir::arith::ArithDialect",
      "mlir::linalg::LinalgDialect",
      "mlir::tensor::TensorDialect",
      "IREE::Flow::FlowDialect",
    ];
    let statistics = [
      Statistic<"numSlowCopyDispatches", "num-slow-copy-dispatches",
                "Number of slow copy dispatches (for handling slices) created">
    ];
}

def MaterializeDefaultWorkgroupCountRegionPass:
    InterfacePass<"iree-dispatch-creation-materialize-default-workgroup-count-region",
                  "mlir::FunctionOpInterface"> {
      let summary = "Canonicalize dispatch workgroups ops.";
      let description = [{
        Apply dispatch workgroups canonicalization patterns.
      }];
      let dependentDialects = [
        "IREE::TensorExt::IREETensorExtDialect",
        "mlir::affine::AffineDialect",
        "mlir::arith::ArithDialect",
        "mlir::linalg::LinalgDialect",
        "mlir::scf::SCFDialect",
        "IREE::Flow::FlowDialect",

      ];
}


#endif // IREE_COMPILER_DISPATCHCREATION_PASSES
