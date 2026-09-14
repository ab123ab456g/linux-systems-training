#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 15-schedule)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
cat > "$R/phase1-lab15.service" <<EOF
[Unit]
Description=Phase1 Lab15 scheduled job
[Service]
Type=oneshot
ExecStart=/usr/bin/bash -lc "date >> $R/timer-output.txt"
EOF
cat > "$R/phase1-lab15.timer" <<EOF
[Unit]
Description=Phase1 Lab15 timer
[Timer]
OnUnitActiveSec=30s
Unit=phase1-lab15.service
[Install]
WantedBy=timers.target
EOF
lt_log prepared
