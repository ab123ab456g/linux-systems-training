#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 06-filesystem)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
mkdir -p "$R/fs/sub"
printf "alpha
" > "$R/fs/a.txt"
printf "beta
" > "$R/fs/sub/b.txt"
chmod 644 "$R/fs/a.txt"
lt_log prepared
