// Shared trace-region addresses for merlin's opt-in dispatch debug.
//
// These constants are referenced from BOTH the runtime (debug probes in
// embedded_elf_loader.c) and the compiler (emitTrace / emitMatmulTrace in
// the merlin Gemmini codegen). Keeping them in one place prevents the two
// sides drifting out of sync.
//
// Gated builds: usages live behind MERLIN_DISPATCH_DEBUG (runtime) and the
// `dispatch-debug` pass option (compiler). The header itself just defines
// numeric macros and is always safe to include.

#ifndef MERLIN_DEBUG_ADDRESSES_H_
#define MERLIN_DEBUG_ADDRESSES_H_

// Binding trace — 5×u64 region populated by the compiler with the
// resolved IREE binding pointers (sentinel, A, B, C, D) just before the
// dispatch fires. Lives 2 MB into main DRAM, well beyond IREE's
// allocator high-water mark on the Zephyr image.
#define MERLIN_DEBUG_BINDING_TRACE_ADDR     0x80200000ULL
#define MERLIN_DEBUG_BINDING_TRACE_SENTINEL 0xDEADC0DEFACEBEEFULL

// Bug A matmul trace — 5×u64 region populated by the compiler with the
// A/B/C/D pointers the dispatch will actually consume. Distinct from
// the binding trace so both can be active simultaneously when debugging.
#define MERLIN_DEBUG_MATMUL_TRACE_ADDR      0x80300000ULL
#define MERLIN_DEBUG_MATMUL_TRACE_SENTINEL  0xCAFEBABEBA1100A0ULL

// Pre-dispatch trace-clear sentinel: written by the runtime over the
// matmul trace region before the dispatch fires, so that after the
// dispatch returns we can tell whether the compiler-emitted trace
// stores actually executed (intact sentinel = stores never ran).
#define MERLIN_DEBUG_TRACE_CLEAR_SENTINEL   0xDEADBEEFCAFEBABEULL

#endif  // MERLIN_DEBUG_ADDRESSES_H_
