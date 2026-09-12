#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
sudo getent group reportapp >/dev/null || sudo groupadd --system reportapp
id reportapp >/dev/null 2>&1 || sudo useradd --system --gid reportapp --home /nonexistent --shell /usr/sbin/nologin reportapp
sudo install -d /opt/report-app /etc/report-app /data/report-app/reports /var/log/report-app
sudo cp -a "$ROOT/common/report-app/app" /opt/report-app/
sudo cp "$ROOT/common/report-app/config/report-app.env" /etc/report-app/
sudo cp "$ROOT/common/report-app/config/report-app.conf" /etc/report-app/
sudo cp "$ROOT/common/report-app/systemd/report-app.service" /etc/systemd/system/
sudo chown -R reportapp:reportapp /opt/report-app /data/report-app /var/log/report-app
sudo systemctl daemon-reload
sudo systemctl enable --now report-app.service
