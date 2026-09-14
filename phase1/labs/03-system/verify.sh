#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 03-system)"; s="${1:-changed}"; cur="$(hostname)"; orig="$(cat "$R/original-hostname")"
case "$s" in changed) [ "$cur" = phase1-lab-host ];; restored) [ "$cur" = "$orig" ];; *) lt_die "stage changed|restored";; esac
lt_log "PASS $s"
