#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase2"
printf 'phase=2\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase2/phase.env"
echo "Phase 2 runtime ready: $ROOT/runtime/labs/phase2"
