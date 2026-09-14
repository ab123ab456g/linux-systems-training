#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 07-network)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
if ip link show phase1dummy0 >/dev/null 2>&1; then lt_sudo ip link del phase1dummy0; fi
ip addr > "$R/ip.before"; ip route > "$R/route.before"
lt_log prepared
