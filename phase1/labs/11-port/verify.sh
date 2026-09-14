#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-listening}"
case "$stage" in listening) ss -ltn | grep -q ":18080"; curl -fsS http://127.0.0.1:18080/ | grep -q phase1-port;; stopped) ! ss -ltn | grep -q ":18080";; *) lt_die "listening|stopped";; esac
lt_log "PASS $stage"
