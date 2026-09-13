#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rc=0
for s in "$SCRIPT_DIR"/scenarios/*; do
  if [[ -x "$s/lab.sh" ]]; then
    echo "==> $(basename "$s")"
    "$s/lab.sh" verify || rc=1
  fi
done
exit "$rc"
