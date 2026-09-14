#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 05-storage)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
mkdir -p "$R/mnt"
truncate -s 128M "$R/disk.img"
if [ ! -f "$R/device" ] || ! losetup "$(cat "$R/device" 2>/dev/null)" >/dev/null 2>&1; then DEV="$(lt_sudo losetup --find --show "$R/disk.img")"; echo "$DEV" > "$R/device"; fi
lt_log "device=$(cat "$R/device")"
