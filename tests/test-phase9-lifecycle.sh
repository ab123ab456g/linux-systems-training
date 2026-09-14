#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"

PHASE="$ROOT/phase9"
[[ -d "$PHASE" ]] || fail "phase9 missing"

info "testing phase9 fault/rollback lifecycle"

# These scenarios are intentionally sandboxed and safe for automated lifecycle tests.
scenarios=(
  02-slow-system-high-cpu
  03-disk-pressure
  04-network-dns
  07-service-failure
  08-path-runtime
  09-permission-denied
  10-boot-login-slow
)

for name in "${scenarios[@]}"; do
  lab="$PHASE/scenarios/$name/lab.sh"
  [[ -f "$lab" ]] || fail "missing lab.sh: $name"

  info "phase9 lifecycle: $name"
  bash "$lab" reset >/dev/null 2>&1 || true
  bash "$lab" prepare
  bash "$lab" fault
  bash "$lab" observe

  # A faulted scenario should normally fail verification before repair/rollback.
  if bash "$lab" verify >/dev/null 2>&1; then
    fail "$name unexpectedly verified while fault was active"
  fi

  bash "$lab" rollback
  bash "$lab" verify
  bash "$lab" reset

done

pass "phase9: fault/rollback lifecycle passed for ${#scenarios[@]} scenarios"
