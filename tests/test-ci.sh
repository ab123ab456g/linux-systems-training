#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"

bash "$ROOT/tests/test-structure.sh"
bash "$ROOT/tests/test-syntax.sh"

for n in {1..8}; do
  phase="$ROOT/phase$n"
  for s in setup.sh baseline.sh inventory.sh verify-all.sh reset-all.sh; do
    if [[ -f "$phase/$s" ]]; then
      bash "$phase/$s" >/dev/null
    fi
  done
  # Smoke one verify-capable scenario/lab per phase.
  d="$(find "$phase" -type f -name verify.sh -printf '%h\n' | head -n1 || true)"
  if [[ -n "$d" ]]; then
    [[ -f "$d/prepare.sh" ]] && bash "$d/prepare.sh" >/dev/null
    bash "$d/verify.sh" >/dev/null
    [[ -f "$d/reset.sh" ]] && bash "$d/reset.sh" >/dev/null || true
  fi
  pass "phase$n smoke"
done

# Explicit fault contract: a known Phase 2 fault must be detected.
fault_dir="$(find "$ROOT/phase2" -type f -name fault.sh -printf '%h\n' | head -n1 || true)"
if [[ -n "$fault_dir" ]]; then
  [[ -f "$fault_dir/prepare.sh" ]] && bash "$fault_dir/prepare.sh" >/dev/null
  bash "$fault_dir/fault.sh" >/dev/null
  if bash "$fault_dir/verify.sh" >/dev/null 2>&1; then
    fail "fault verify unexpectedly passed: $fault_dir"
  fi
  if [[ -f "$fault_dir/rollback.sh" ]]; then bash "$fault_dir/rollback.sh" >/dev/null; fi
  if [[ -f "$fault_dir/reset.sh" ]]; then bash "$fault_dir/reset.sh" >/dev/null; fi
  pass "phase2 fault contract"
fi

pass "CI smoke suite passed"
