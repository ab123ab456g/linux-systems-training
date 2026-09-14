#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 13-log)"; stage="${1:-generated}"
case "$stage" in generated) grep -q "phase1 sample" "$R/app.log"; journalctl -t phase1-lab13 -n 20 --no-pager 2>/dev/null | grep -q PHASE1_LAB13 || true;; *) lt_die "generated";; esac
lt_log "PASS $stage"
