#!/usr/bin/env bash
set -euo pipefail

DEST="$(dirname "$0")/../runtime/backups/manual-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$DEST"
sudo cp -a /etc/report-app /etc/report-worker /etc/systemd/system/report-app.service /etc/systemd/system/report-worker.service /etc/systemd/system/report-worker.timer "$DEST" 2>/dev/null || true
echo "$DEST"
