#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-running}"
case "$stage" in running) curl -fsS http://127.0.0.1:18088/health | grep -q '"status": "ok"'; ss -ltn | grep -q ":18088";; stopped) ! ss -ltn | grep -q ":18088";; *) lt_die "running|stopped";; esac
lt_log "PASS $stage"
