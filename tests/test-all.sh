#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
tests=(
  test-structure.sh
  test-syntax.sh
  test-phase1.sh
  test-phase2.sh
  test-phase3.sh
  test-phase4.sh
  test-phase5.sh
  test-phase6.sh
  test-phase7.sh
  test-phase8.sh
  test-scenarios.sh
  test-rollback.sh
  test-idempotency.sh
)
for t in "${tests[@]}"; do
  printf '\n===== %s =====\n' "$t"
  bash "$ROOT/tests/$t"
done
pass "ALL TESTS PASSED"
