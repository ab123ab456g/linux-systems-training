#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase3"
printf 'phase=3\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase3/phase.env"
echo "Phase 3 runtime ready: $ROOT/runtime/labs/phase3"
