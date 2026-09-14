#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
tmp="$(mktemp)"; grep -v "PHASE1_LAB08" /etc/hosts > "$tmp"; lt_sudo cp "$tmp" /etc/hosts; rm -f "$tmp"
