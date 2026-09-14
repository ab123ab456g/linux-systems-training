#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
PHASE="$ROOT/phase6"
[[ -d "$PHASE" ]] || fail "phase6 missing"
info "testing phase6"
for s in setup.sh baseline.sh inventory.sh monitor.sh verify-all.sh reset-all.sh failback-all.sh; do
  [[ -f "$PHASE/$s" ]] && run_script "$PHASE/$s"
done
count=0
while IFS= read -r -d '' d; do
  [[ -f "$d/verify.sh" ]] || continue
  [[ -f "$d/prepare.sh" ]] && run_script "$d/prepare.sh"
  # Do not inject faults in per-phase smoke test.
  run_script "$d/verify.sh"
  [[ -f "$d/reset.sh" ]] && run_script "$d/reset.sh" || true
  count=$((count+1))
done < <(find "$PHASE" -type d -print0 2>/dev/null)
pass "phase6: smoke-tested $count verify directories"
