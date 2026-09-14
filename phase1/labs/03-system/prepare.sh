#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 03-system)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
hostnamectl --static 2>/dev/null | head -n1 > "$R/original-hostname" || hostname > "$R/original-hostname"
uname -a > "$R/uname.txt"
cat /etc/os-release > "$R/os-release.txt"
lt_log "saved original hostname"
