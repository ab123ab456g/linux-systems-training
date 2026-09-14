#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-configured}"
case "$stage" in configured) getent hosts phase1-lab.local | grep -q 127.0.0.1;; restored) ! grep -q PHASE1_LAB08 /etc/hosts;; *) lt_die "configured|restored";; esac
lt_log "PASS $stage"
