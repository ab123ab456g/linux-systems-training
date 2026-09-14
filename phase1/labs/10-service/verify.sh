#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-running}"
case "$stage" in running) systemctl is-active --quiet phase1-lab10.service; curl -fsS http://127.0.0.1:18081/ >/dev/null;; stopped|deleted) ! systemctl is-active --quiet phase1-lab10.service;; *) lt_die "running|stopped|deleted";; esac
lt_log "PASS $stage"
