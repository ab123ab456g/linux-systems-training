#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
if ip link show phase1dummy0 >/dev/null 2>&1; then lt_sudo ip link del phase1dummy0; fi
