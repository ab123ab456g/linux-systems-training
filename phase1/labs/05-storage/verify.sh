#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 05-storage)"; stage="${1:-mounted}"; DEV="$(cat "$R/device")"
case "$stage" in mounted) findmnt "$R/mnt" >/dev/null; blkid "$DEV" >/dev/null;; unmounted) ! findmnt "$R/mnt" >/dev/null;; *) lt_die "mounted|unmounted";; esac
lt_log "PASS $stage"
