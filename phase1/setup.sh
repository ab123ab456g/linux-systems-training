#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase1"
printf 'phase=1\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase1/phase.env"
echo "Phase 1 runtime ready: $ROOT/runtime/labs/phase1"
