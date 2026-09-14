#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-updated}"
case "$stage" in
 created) getent passwd phase1user >/dev/null; getent group phase1lab >/dev/null;;
 updated) id phase1user | grep -q phase1lab;;
 deleted|restored) ! getent passwd phase1user >/dev/null; ! getent group phase1lab >/dev/null;;
 *) lt_die "stage: created|updated|deleted|restored";; esac
lt_log "PASS $stage"
