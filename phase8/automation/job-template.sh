#!/usr/bin/env bash
set -euo pipefail
JOB_NAME="${JOB_NAME:-example-job}"
STATE_DIR="${STATE_DIR:-/tmp/linux-training-jobs}"
mkdir -p "$STATE_DIR"
LOCK="$STATE_DIR/$JOB_NAME.lock"
LOG="$STATE_DIR/$JOB_NAME.log"
exec 9>"$LOCK"
if command -v flock >/dev/null 2>&1; then flock -n 9 || { echo "already running" >>"$LOG"; exit 75; }; fi
printf '[%s] start %s\n' "$(date -Is)" "$JOB_NAME" >>"$LOG"
# Put idempotent work here.
printf '[%s] success %s\n' "$(date -Is)" "$JOB_NAME" >>"$LOG"
