#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
checked=0
while IFS= read -r -d '' d; do
  [[ -f "$d/prepare.sh" ]] || continue
  rec=""
  if [[ -f "$d/rollback.sh" ]]; then rec="$d/rollback.sh"
  elif [[ -f "$d/failback.sh" ]]; then rec="$d/failback.sh"
  elif [[ -f "$d/reset.sh" ]]; then rec="$d/reset.sh"
  else continue
  fi
  run_script "$d/prepare.sh"
  [[ -f "$d/fault.sh" ]] && run_script "$d/fault.sh" || true
  run_script "$rec"
  run_script "$rec"
  checked=$((checked+1))
done < <(find "$ROOT"/phase{1..8} -type d -print0 2>/dev/null)
pass "rollback/reset repeatability passed for $checked directories"
