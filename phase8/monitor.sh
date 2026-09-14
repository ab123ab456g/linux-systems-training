#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
source "$ROOT/common/scripts/lab-runtime.sh"
OUT="$ROOT/runtime/labs/phase8/monitor-$(date +%Y%m%d-%H%M%S).txt"
mkdir -p "$(dirname "$OUT")"
lt_inventory "phase8-monitor" "$OUT"
echo "$OUT"
