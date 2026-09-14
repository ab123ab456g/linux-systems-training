#!/usr/bin/env bash
set -euo pipefail

"$(dirname "$0")/../report-worker/scripts/uninstall.sh"
"$(dirname "$0")/../report-app/scripts/uninstall.sh"
