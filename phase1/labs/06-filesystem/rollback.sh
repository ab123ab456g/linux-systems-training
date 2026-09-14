#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 06-filesystem)"; [ -f "$R/fs/a.txt" ] && chmod 644 "$R/fs/a.txt" || true
