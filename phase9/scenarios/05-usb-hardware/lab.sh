#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$(cd "$SCRIPT_DIR/../.." && pwd)/lib.sh"
action="${1:-observe}"
case "$action" in
  prepare|fault|observe|verify|rollback|reset) "p9_${action}" "${BASH_SOURCE[0]}" ;;
  *) echo "usage: $0 {prepare|fault|observe|verify|rollback|reset}" >&2; exit 2 ;;
esac
