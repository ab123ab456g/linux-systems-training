#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
count=0
while IFS= read -r -d '' f; do
  bash -n "$f" || fail "syntax error: $f"
  count=$((count+1))
done < <(find "$ROOT" -type f -name '*.sh' -print0)
pass "bash -n passed for $count shell scripts"
