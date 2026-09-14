#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
for c in bash diff hostnamectl ip ss lsblk systemctl; do lt_require "$c"; done
[ -f "$(lt_runtime_dir 00-course-usage)/prepared.txt" ]
lt_log PASS
