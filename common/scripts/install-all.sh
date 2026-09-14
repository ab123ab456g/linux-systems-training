#!/usr/bin/env bash
set -euo pipefail

"$(dirname "$0")/../report-app/scripts/install.sh"
"$(dirname "$0")/../report-worker/scripts/install.sh"
