#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 04-hardware)"; stage="${1:-attached}"
case "$stage" in attached) DEV="$(cat "$R/device")"; losetup "$DEV" >/dev/null;; detached) DEV="$(cat "$R/device" 2>/dev/null || true)"; [ -z "$DEV" ] || ! losetup "$DEV" >/dev/null 2>&1;; *) lt_die "attached|detached";; esac
lt_log "PASS $stage"
