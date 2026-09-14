#!/usr/bin/env bash
set -euo pipefail

sudo systemctl disable --now report-app.service 2>/dev/null || true
sudo rm -f /etc/systemd/system/report-app.service
sudo systemctl daemon-reload
sudo rm -rf /opt/report-app /etc/report-app
