#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
source "$ROOT/common/scripts/lab-runtime.sh"
OUT="$ROOT/runtime/labs/phase5/baseline.txt"
mkdir -p "$(dirname "$OUT")"
lt_inventory "phase5-baseline" "$OUT"
echo "$OUT"
