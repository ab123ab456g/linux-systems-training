#!/usr/bin/env bash
set -euo pipefail

[ $# -ge 1 ] || { echo "usage: $0 <CR-file>"; exit 2; }
cat "$(dirname "$0")/../phase4/change-requests/$1"
