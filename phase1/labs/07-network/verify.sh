#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-configured}"
case "$stage" in configured) ip addr show phase1dummy0 | grep -q "10.10.10.1/24";; deleted|restored) ! ip link show phase1dummy0 >/dev/null 2>&1;; *) lt_die "configured|deleted|restored";; esac
lt_log "PASS $stage"
