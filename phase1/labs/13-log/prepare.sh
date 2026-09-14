#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 13-log)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
: > "$R/app.log"
lt_log prepared
