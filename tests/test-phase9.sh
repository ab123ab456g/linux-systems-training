#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"

PHASE="$ROOT/phase9"
[[ -d "$PHASE" ]] || fail "phase9 missing"
[[ -f "$PHASE/lib.sh" ]] || fail "phase9/lib.sh missing"
[[ -f "$PHASE/baseline.sh" ]] || fail "phase9/baseline.sh missing"
[[ -f "$PHASE/setup.sh" ]] || fail "phase9/setup.sh missing"
[[ -f "$PHASE/verify-all.sh" ]] || fail "phase9/verify-all.sh missing"
[[ -f "$PHASE/reset-all.sh" ]] || fail "phase9/reset-all.sh missing"

info "testing phase9 structure and smoke lifecycle"

expected=(
  01-takeover-baseline
  02-slow-system-high-cpu
  03-disk-pressure
  04-network-dns
  05-usb-hardware
  06-gpu-display
  07-service-failure
  08-path-runtime
  09-permission-denied
  10-boot-login-slow
  11-filesystem-image
  12-preserve-rebuild
)

for name in "${expected[@]}"; do
  d="$PHASE/scenarios/$name"
  [[ -d "$d" ]] || fail "missing scenario: $name"
  [[ -f "$d/lab.sh" ]] || fail "missing lab.sh: $name"
  bash -n "$d/lab.sh" || fail "syntax error: $name/lab.sh"
done

bash -n "$PHASE/lib.sh" || fail "syntax error: phase9/lib.sh"

# Smoke-test non-destructive paths. We intentionally do not inject faults here.
count=0
for name in "${expected[@]}"; do
  lab="$PHASE/scenarios/$name/lab.sh"
  bash "$lab" reset >/dev/null 2>&1 || true
  bash "$lab" prepare
  bash "$lab" observe

  # Inspection-only scenarios become verifiable after observe.
  case "$name" in
    01-takeover-baseline|05-usb-hardware|06-gpu-display)
      bash "$lab" verify
      ;;
  esac

  bash "$lab" reset
  count=$((count+1))
done

pass "phase9: smoke-tested $count scenarios"
