#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 06-filesystem)"; stage="${1:-changed}"
case "$stage" in changed) [ "$(stat -c %a "$R/fs/a.txt")" = 640 ];; reset) [ "$(stat -c %a "$R/fs/a.txt")" = 644 ];; *) lt_die "changed|reset";; esac
lt_log "PASS $stage"
