#!/usr/bin/env bash
set -euo pipefail

[ $# -ge 2 ] || { echo "usage: $0 <phase2|phase4> <scenario-dir>"; exit 2; }
PHASE=$1; SC=$2
cd "$(dirname "$0")/../$PHASE/scenarios/$SC"
cat README.md
