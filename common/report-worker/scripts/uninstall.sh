#!/usr/bin/env bash
set -euo pipefail

sudo systemctl disable --now report-worker.timer 2>/dev/null || true
sudo rm -f /etc/systemd/system/report-worker.service /etc/systemd/system/report-worker.timer
sudo systemctl daemon-reload
sudo rm -rf /opt/report-worker /etc/report-worker
