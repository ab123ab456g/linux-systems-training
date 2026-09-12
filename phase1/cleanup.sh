#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
rm -rf "$ROOT/runtime/labs/phase1"
echo 'Phase 1 runtime cleaned.'
