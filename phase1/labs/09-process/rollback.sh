#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 09-process)"; if [ -f "$R/pid" ]; then kill "$(cat "$R/pid")" 2>/dev/null || true; rm -f "$R/pid"; fi
