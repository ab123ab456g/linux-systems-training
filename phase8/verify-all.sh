#!/usr/bin/env bash
set -euo pipefail
BASE="$(cd "$(dirname "$0")" && pwd)"
rc=0
while IFS= read -r -d '' f; do echo "==> $f"; bash "$f" || rc=1; done < <(find "$BASE" -mindepth 2 -type f -name verify.sh -print0 | sort -z)
exit "$rc"
