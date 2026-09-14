#!/usr/bin/env bash
set -euo pipefail

curl -fsS http://127.0.0.1:${REPORT_PORT:-8080}/health
