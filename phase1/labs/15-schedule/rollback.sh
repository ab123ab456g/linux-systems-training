#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
lt_sudo systemctl disable --now phase1-lab15.timer 2>/dev/null || true
lt_sudo rm -f /etc/systemd/system/phase1-lab15.service /etc/systemd/system/phase1-lab15.timer
lt_sudo systemctl daemon-reload
