#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 00-course-usage)"
echo "prepared $(date)" > "$R/prepared.txt"
lt_log "runtime=$R"
