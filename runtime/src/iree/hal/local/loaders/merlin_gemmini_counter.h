// merlin_gemmini_counter.h — inline RoCC helpers for Gemmini's per-stage
// performance counters (k_COUNTER = 126).
//
// These mirror counter_read / counter_configure in chipyard's
// gemmini-rocc-tests/include/gemmini.h:343-359 but are inlined in the
// iree runtime so embedded_elf_loader.c can wrap each dispatch with a
// counter read.
//
// Counter event codes come from
// chipyard/generators/gemmini/src/main/scala/gemmini/CounterFile.scala.
// We pick 8 events (one per counter slot) targeting the "no overlap"
// diagnosis for the matmul perf cliff. Edit the 8-slot panel by changing
// the MERLIN_GEMMINI_COUNTER_PANEL_INIT macro at the bottom.

#ifndef MERLIN_GEMMINI_COUNTER_H_
#define MERLIN_GEMMINI_COUNTER_H_

#include <stdint.h>

// Event codes from CounterFile.scala (verified 2026-05-27).
// Always defined (independent of MERLIN_PROFILE_COUNTERS) so callers can
// reference the names from non-RISC-V translation units (e.g., the host
// build, the no-op shim path) without ifdef gymnastics.
#define MAIN_LD_CYCLES               1
#define MAIN_ST_CYCLES               2
#define MAIN_EX_CYCLES               3
#define MAIN_LD_ST_CYCLES            4
#define MAIN_LD_EX_CYCLES            5
#define MAIN_ST_EX_CYCLES            6
#define MAIN_LD_ST_EX_CYCLES         7
#define LOAD_DMA_WAIT_CYCLE          8
#define LOAD_ACTIVE_CYCLE            9
#define LOAD_SCRATCHPAD_WAIT_CYCLE   10
#define STORE_DMA_WAIT_CYCLE         11
#define STORE_ACTIVE_CYCLE           12
#define WDMA_TL_WAIT_CYCLES          23
#define EXE_ACTIVE_CYCLE             24
#define EXE_FLUSH_CYCLE              25
#define EXE_CONTROL_Q_BLOCK_CYCLE    26
#define EXE_PRELOAD_HAZ_CYCLE        27
#define EXE_OVERLAP_HAZ_CYCLE        28
#define SCRATCHPAD_A_WAIT_CYCLE      29
#define SCRATCHPAD_B_WAIT_CYCLE      30
#define SCRATCHPAD_D_WAIT_CYCLE      31
#define ACC_A_WAIT_CYCLE             32
#define ACC_B_WAIT_CYCLE             33
#define ACC_D_WAIT_CYCLE             34
#define RESERVATION_STATION_FULL_CYCLES 41
#define RESERVATION_STATION_ACTIVE_CYCLES 42
#define LOOP_MATMUL_ACTIVE_CYCLES    43

// 8-counter panel — 2026-05-27 PANEL B. Phase 0 panel A showed
// RS_FULL ≈ 100% but MAIN_EX = 0.0002% (controller idle FSM-wise).
// Panel B targets the gap: where ARE the 114M cycles going?
//  - LOOP_MATMUL_ACTIVE: how much time is the LOOP_WS macro state machine
//    running end-to-end? (Should be most of the dispatch.)
//  - EXE_ACTIVE: actual systolic-array activity (different lens than
//    MAIN_EX_CYCLES which counts the main controller's EX-state cycles).
//  - LOAD_ACTIVE / STORE_ACTIVE: real controller occupancy (vs MAIN_LD/ST
//    which is main-FSM gated).
//  - SCRATCHPAD_A/B_WAIT: HW waiting for spad fill before COMPUTE can fire.
//  - ACC_A_WAIT: HW waiting for accumulator-bank fill (D loads).
//  - EXE_OVERLAP_HAZ: execute stalls because A and B SPAD banks are still
//    being written by previous load (vs PRELOAD_HAZ for preload itself).
#define MERLIN_GEMMINI_COUNTER_PANEL \
    MERLIN_X(0, LOOP_MATMUL_ACTIVE_CYCLES)        \
    MERLIN_X(1, EXE_ACTIVE_CYCLE)                 \
    MERLIN_X(2, LOAD_ACTIVE_CYCLE)                \
    MERLIN_X(3, STORE_ACTIVE_CYCLE)               \
    MERLIN_X(4, SCRATCHPAD_A_WAIT_CYCLE)          \
    MERLIN_X(5, SCRATCHPAD_B_WAIT_CYCLE)          \
    MERLIN_X(6, ACC_A_WAIT_CYCLE)                 \
    MERLIN_X(7, EXE_OVERLAP_HAZ_CYCLE)

#if defined(__riscv) && defined(MERLIN_PROFILE_COUNTERS) && MERLIN_PROFILE_COUNTERS

// k_COUNTER opcode = 126. Custom-3 (CUSTOM_ACC). func7=126.
//   rd      = output counter value (for read mode)
//   rs1     = config_reg = (idx<<4) | (code<<12) | configure_bit
//   rs2     = unused (canonical lib passes _placeholder)
//
// Read mode:    config_reg = (idx & 7) << 4
// Configure:    config_reg = (idx & 7) << 4 | 0x8 | (code & 0x3f) << 12

static inline uint32_t merlin_gemmini_counter_read(unsigned idx) {
    uint32_t cfg = (idx & 0x7) << 4;
    uint32_t res;
    asm volatile(".insn r 0x7b, 0x7, 126, %0, %1, x0"
                 : "=r"(res)
                 : "r"((uint64_t)cfg));
    return res;
}

static inline void merlin_gemmini_counter_configure(unsigned idx, unsigned code) {
    uint32_t non_incremental = 0;
    // Mirror gemmini-rocc-tests:351-358 — codes > INCREMENTAL_COUNTERS get
    // the non_incremental bit set. Our 8-slot panel currently uses only
    // incremental codes (LD/ST/EX/etc.) so this branch is dormant; kept
    // for safety if we later swap in event/sample-counter codes.
    uint32_t cfg = ((idx & 0x7) << 4) | 0x8 | ((code & 0x3f) << 12)
                 | (non_incremental << 31);
    uint32_t placeholder;
    asm volatile(".insn r 0x7b, 0x7, 126, %0, %1, x0"
                 : "=r"(placeholder)
                 : "r"((uint64_t)cfg));
    (void)placeholder;
}

// Program the 8-slot panel. Call once at worker startup. Idempotent
// across multiple invocations (re-configuring the same slot with the
// same code is a no-op on the hardware side).
static inline void merlin_gemmini_counter_panel_init(void) {
#define MERLIN_X(slot, code) merlin_gemmini_counter_configure(slot, code);
    MERLIN_GEMMINI_COUNTER_PANEL
#undef MERLIN_X
}

#else  // !MERLIN_PROFILE_COUNTERS or !__riscv

static inline uint32_t merlin_gemmini_counter_read(unsigned idx) {
    (void)idx;
    return 0;
}
static inline void merlin_gemmini_counter_configure(unsigned idx, unsigned code) {
    (void)idx; (void)code;
}
static inline void merlin_gemmini_counter_panel_init(void) {}

#endif  // MERLIN_PROFILE_COUNTERS

#endif  // MERLIN_GEMMINI_COUNTER_H_
