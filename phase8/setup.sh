#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase8"
printf 'phase=8\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase8/phase.env"
echo "Phase 8 runtime ready: $ROOT/runtime/labs/phase8"
