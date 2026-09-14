#!/usr/bin/env bash
set -euo pipefail

[ $# -ge 2 ] || { echo "usage: $0 <phase1|phase3> <lab-dir>"; exit 2; }
PHASE=$1; LAB=$2
cd "$(dirname "$0")/../$PHASE/labs/$LAB"
cat README.md
