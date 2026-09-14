#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 03-system)"; [ -f "$R/original-hostname" ] || lt_die "prepare first"
lt_sudo hostnamectl set-hostname "$(cat "$R/original-hostname")"
lt_log restored
