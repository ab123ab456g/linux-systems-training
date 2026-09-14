#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
for s in "$SCRIPT_DIR"/scenarios/*; do
  [[ -x "$s/lab.sh" ]] && "$s/lab.sh" reset
done
