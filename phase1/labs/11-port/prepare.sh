#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 11-port)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
mkdir -p "$R/www"; echo phase1-port > "$R/www/index.html"
if [ -f "$R/pid" ]; then kill "$(cat "$R/pid")" 2>/dev/null || true; fi
rm -f "$R/pid"
lt_log prepared
