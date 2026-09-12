#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase5"
printf 'phase=5\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase5/phase.env"
echo "Phase 5 runtime ready: $ROOT/runtime/labs/phase5"
