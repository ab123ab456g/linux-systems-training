#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mapfile -t D < <(find "$ROOT/phase2/scenarios" -mindepth 1 -maxdepth 1 -type d | sort)
[ ${#D[@]} -gt 0 ] || exit 1
S=${D[$RANDOM % ${#D[@]}]}
echo "Selected: $(basename "$S")"
"$S/fault.sh"
