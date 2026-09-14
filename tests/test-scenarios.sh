#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"

checked=0
fault_checked=0

while IFS= read -r -d '' d; do
  [[ -f "$d/verify.sh" ]] || continue
  has_recovery=0
  [[ -f "$d/reset.sh" || -f "$d/rollback.sh" || -f "$d/failback.sh" ]] && has_recovery=1
  [[ "$has_recovery" -eq 1 ]] || fail "verify without recovery path: $d"

  checked=$((checked+1))

  if [[ -f "$d/prepare.sh" ]]; then run_script "$d/prepare.sh"; fi

  if [[ -f "$d/fault.sh" ]]; then
    fault_checked=$((fault_checked+1))
    run_script "$d/fault.sh"
    if bash "$d/verify.sh" >/dev/null 2>&1; then
      fail "verify unexpectedly passed while fault is present: $d"
    else
      pass "fault correctly detected: ${d#$ROOT/}"
    fi
  else
    run_script "$d/verify.sh"
  fi

  if [[ -f "$d/rollback.sh" ]]; then
    run_script "$d/rollback.sh"
  elif [[ -f "$d/failback.sh" ]]; then
    run_script "$d/failback.sh"
  else
    run_script "$d/reset.sh"
  fi

  # A recovery script itself must be safe to run again.
  if [[ -f "$d/reset.sh" ]]; then
    run_script "$d/reset.sh"
  elif [[ -f "$d/rollback.sh" ]]; then
    run_script "$d/rollback.sh"
  fi
done < <(find "$ROOT"/phase{1..8} -type d -print0 2>/dev/null)

pass "scenario contract passed: $checked verified directories, $fault_checked explicit fault scenarios"
