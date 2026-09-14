#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 08-dns)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
grep -v "PHASE1_LAB08" /etc/hosts > "$R/hosts.clean"
lt_log prepared
