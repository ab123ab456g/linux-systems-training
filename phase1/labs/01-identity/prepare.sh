#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 01-identity)"
getent passwd phase1user > "$R/pre-user.txt" || true
getent group phase1lab > "$R/pre-group.txt" || true
lt_log "prepared; phase1user/phase1lab should be sandbox objects"
