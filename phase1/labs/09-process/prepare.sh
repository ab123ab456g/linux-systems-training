#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 09-process)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
[ ! -f "$R/pid" ] || kill "$(cat "$R/pid")" 2>/dev/null || true
rm -f "$R/pid"
lt_log prepared
