#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/runtime/labs/phase4"
printf 'phase=4\nsetup_at=%s\n' "$(date -Is)" > "$ROOT/runtime/labs/phase4/phase.env"
echo "Phase 4 runtime ready: $ROOT/runtime/labs/phase4"
