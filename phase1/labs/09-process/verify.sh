#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 09-process)"; stage="${1:-running}"; pid="$(cat "$R/pid" 2>/dev/null || true)"
case "$stage" in running) [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null;; stopped) [ -z "$pid" ] || ! kill -0 "$pid" 2>/dev/null;; *) lt_die "running|stopped";; esac
lt_log "PASS $stage"
