#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 17-security)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
lt_require nft
if lt_sudo nft list table inet phase1_lab17 >/dev/null 2>&1; then lt_sudo nft delete table inet phase1_lab17; fi
lt_log "sandbox table has no hook; it will not filter traffic"
