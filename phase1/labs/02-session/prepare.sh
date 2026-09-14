#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 02-session)"
who > "$R/who.before" || true
w > "$R/w.before" || true
last -n 10 > "$R/last.before" || true
lt_log "open a second terminal/SSH session manually"
