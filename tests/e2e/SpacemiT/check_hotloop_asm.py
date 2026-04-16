#!/usr/bin/env python3
"""Checks hot-loop assembly properties for dumped .s files.

This script extracts one loop body (default: first `.LBB*` block) and validates:
  1) required opcode regexes are present in the loop body;
  2) there are no stack spill loads/stores in that loop body.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import sys


def _find_loop(
    lines: list[str], label_override: str | None, required_opcodes: list[str]
) -> tuple[str, list[str]]:
    label_re = re.compile(r"^\s*(\.LBB[\w\._]+):\s*$")

    def _find_loop_end(start: int, loop_label: str) -> int | None:
        branch_back = re.compile(
            rf"\b(?:bnez|bne|beq|blt|bge|j|jal)\b[^\n]*{re.escape(loop_label)}"
        )
        return next((i for i in range(start + 1, len(lines)) if branch_back.search(lines[i])), None)

    if label_override:
        loop_label = label_override
        start = next(
            (i for i, line in enumerate(lines) if re.match(rf"^\s*{re.escape(loop_label)}:\s*$", line)),
            None,
        )
        if start is None:
            raise ValueError(f"loop label not found: {loop_label}")
        end = _find_loop_end(start, loop_label)
        if end is None:
            raise ValueError(f"no backward branch to loop label found: {loop_label}")
        return loop_label, lines[start : end + 1]

    loop_labels = [(i, m.group(1)) for i, line in enumerate(lines) if (m := label_re.match(line))]
    if not loop_labels:
        raise ValueError("no .LBB loop label found")

    candidates: list[tuple[int, int, str]] = []
    for start, loop_label in loop_labels:
        end = _find_loop_end(start, loop_label)
        if end is not None:
            candidates.append((start, end, loop_label))

    if not candidates:
        raise ValueError("no backward branch found for any .LBB label")

    if required_opcodes:
        opcode_filtered: list[tuple[int, int, str]] = []
        for start, end, loop_label in candidates:
            loop_text = "\n".join(lines[start : end + 1])
            if all(re.search(opcode_re, loop_text) for opcode_re in required_opcodes):
                opcode_filtered.append((start, end, loop_label))
        if opcode_filtered:
            candidates = opcode_filtered

    # Prefer the innermost loop (shortest label-to-back-edge span).
    start, end, loop_label = min(candidates, key=lambda item: item[1] - item[0])
    return loop_label, lines[start : end + 1]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--asm", required=True, help="Path to .s file to inspect")
    parser.add_argument(
        "--require-opcode",
        action="append",
        default=[],
        help="Regex that must match at least once inside the selected loop body",
    )
    parser.add_argument(
        "--loop-label",
        default=None,
        help="Exact loop label (e.g. .LBB0_1). If omitted, uses first .LBB block.",
    )
    args = parser.parse_args()

    asm_path = pathlib.Path(args.asm)
    if not asm_path.exists():
        print(f"[FAIL] asm file does not exist: {asm_path}", file=sys.stderr)
        return 1

    lines = asm_path.read_text(encoding="utf-8", errors="ignore").splitlines()
    try:
        loop_label, loop_lines = _find_loop(lines, args.loop_label, args.require_opcode)
    except ValueError as exc:
        print(f"[FAIL] {exc}", file=sys.stderr)
        return 1

    loop_text = "\n".join(loop_lines)

    spill_re = re.compile(
        r"\b(?:sd|ld|sw|lw|sh|lh|sb|lb|fsd|fld|fsw|flw)\b[^\n]*\(\s*sp\s*\)",
        re.IGNORECASE,
    )
    if spill_re.search(loop_text):
        print(f"[FAIL] stack spill access found in hot loop {loop_label}", file=sys.stderr)
        return 1

    for opcode_re in args.require_opcode:
        if not re.search(opcode_re, loop_text):
            print(
                f"[FAIL] required opcode regex not found in hot loop {loop_label}: {opcode_re}",
                file=sys.stderr,
            )
            return 1

    print(f"[OK] hot loop {loop_label} passed checks in {asm_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
