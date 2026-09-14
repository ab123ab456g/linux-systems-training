#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR" && while [[ ! -f common/scripts/lab-runtime.sh && "$PWD" != / ]]; do cd ..; done; pwd)"
source "$ROOT/common/scripts/lab-runtime.sh"
lt_observe "${BASH_SOURCE[0]}" 'service-systemd-release-14-restore-schedule' 'capture-before'
