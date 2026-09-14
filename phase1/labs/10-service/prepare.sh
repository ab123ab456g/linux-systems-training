#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 10-service)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
cat > "$R/phase1-lab10.service" <<EOF
[Unit]
Description=Phase1 Lab10 Service
[Service]
Type=simple
ExecStart=/usr/bin/python3 -m http.server 18081 --directory $R
Restart=on-failure
EOF
printf "lab10
" > "$R/index.html"
lt_log prepared
