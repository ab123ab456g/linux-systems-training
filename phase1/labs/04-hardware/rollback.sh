#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 04-hardware)"; if [ -f "$R/device" ]; then DEV="$(cat "$R/device")"; lt_sudo losetup -d "$DEV" 2>/dev/null || true; fi
lt_log rolled-back
