#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-configured}"
case "$stage" in configured) lt_sudo nft list table inet phase1_lab17 | grep -q "dport 18080 accept";; deleted) ! lt_sudo nft list table inet phase1_lab17 >/dev/null 2>&1;; *) lt_die "configured|deleted";; esac
lt_log "PASS $stage"
