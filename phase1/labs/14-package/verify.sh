#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
stage="${1:-v1}"
case "$stage" in v1) dpkg-query -W -f='${Version}' phase1-helper 2>/dev/null | grep -qx 1.0;; v11) dpkg-query -W -f='${Version}' phase1-helper 2>/dev/null | grep -qx 1.1;; removed) ! dpkg-query -W phase1-helper >/dev/null 2>&1;; *) lt_die "v1|v11|removed";; esac
lt_log "PASS $stage"
