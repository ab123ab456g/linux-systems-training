#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
checked=0
for phase in "$ROOT"/phase{1..8}; do
  [[ -d "$phase" ]] || continue
  for s in setup.sh reset-all.sh; do
    [[ -f "$phase/$s" ]] || continue
    run_script "$phase/$s"
    run_script "$phase/$s"
    checked=$((checked+1))
  done
done
while IFS= read -r -d '' f; do
  run_script "$f"
  run_script "$f"
  checked=$((checked+1))
done < <(find "$ROOT"/phase{1..8} -type f \( -name reset.sh -o -name rollback.sh -o -name failback.sh \) -print0 2>/dev/null)
pass "idempotency/repeatability smoke test passed for $checked scripts"
