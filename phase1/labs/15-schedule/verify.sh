#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-installed}"
case "$stage" in installed) systemctl list-timers --all | grep -q phase1-lab15.timer;; removed) [ ! -e /etc/systemd/system/phase1-lab15.timer ];; *) lt_die "installed|removed";; esac
lt_log "PASS $stage"
