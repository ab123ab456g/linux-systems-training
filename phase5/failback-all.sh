#!/usr/bin/env bash
set -euo pipefail
BASE="$(cd "$(dirname "$0")" && pwd)"
while IFS= read -r -d '' f; do bash "$f"; done < <(find "$BASE" -mindepth 2 -type f -name failback.sh -print0 | sort -z)
