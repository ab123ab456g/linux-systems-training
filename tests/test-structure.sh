#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
for n in {1..8}; do
  [[ -d "$ROOT/phase$n" ]] || fail "missing phase$n"
  [[ -f "$ROOT/phase$n/README.md" ]] || fail "missing phase$n/README.md"
done
for f in test-syntax.sh test-scenarios.sh test-rollback.sh test-idempotency.sh test-all.sh; do
  [[ -f "$ROOT/tests/$f" ]] || fail "missing tests/$f"
done
pass "repository structure OK"
