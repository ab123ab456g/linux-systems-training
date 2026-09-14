#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 05-storage)"; if findmnt "$R/mnt" >/dev/null 2>&1; then lt_sudo umount "$R/mnt"; fi; if [ -f "$R/device" ]; then lt_sudo losetup -d "$(cat "$R/device")" 2>/dev/null || true; fi
