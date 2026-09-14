#!/usr/bin/env bash
set -euo pipefail

echo '== training state =='
for f in ../runtime/state/*; do printf '%s: ' "$(basename "$f")"; cat "$f"; done
echo '== report app =='
systemctl --no-pager --full status report-app.service 2>/dev/null || true
curl -fsS http://127.0.0.1:8080/health 2>/dev/null || true; echo
