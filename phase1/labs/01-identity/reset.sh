#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
if getent passwd phase1user >/dev/null; then lt_sudo userdel -r phase1user || true; fi
if getent group phase1lab >/dev/null; then lt_sudo groupdel phase1lab || true; fi
lt_log rolled-back
