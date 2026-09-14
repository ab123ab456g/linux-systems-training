#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase7"
printf 'phase=7\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase7/phase.env"
echo "Phase 7 runtime ready: $ROOT/runtime/labs/phase7"
