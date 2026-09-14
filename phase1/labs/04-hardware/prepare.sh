#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 04-hardware)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
lt_require losetup
truncate -s 64M "$R/hardware.img"
if [ -f "$R/device" ] && losetup "$(cat "$R/device")" >/dev/null 2>&1; then
  DEV="$(cat "$R/device")"
else
  DEV="$(lt_sudo losetup --find --show "$R/hardware.img")"
  echo "$DEV" > "$R/device"
fi
lt_log "attached $DEV"
