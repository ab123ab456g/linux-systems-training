#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
sudo getent group reportworker >/dev/null || sudo groupadd --system reportworker
id reportworker >/dev/null 2>&1 || sudo useradd --system --gid reportworker --home /nonexistent --shell /usr/sbin/nologin reportworker
sudo install -d /opt/report-worker /etc/report-worker /data/report-worker/summaries /var/lib/report-worker /var/log/report-worker
sudo cp -a "$ROOT/common/report-worker/app" /opt/report-worker/
sudo cp "$ROOT/common/report-worker/config/worker.env" /etc/report-worker/
sudo cp "$ROOT/common/report-worker/config/worker.conf" /etc/report-worker/
sudo cp "$ROOT/common/report-worker/systemd/"* /etc/systemd/system/
sudo chown -R reportworker:reportworker /opt/report-worker /data/report-worker /var/lib/report-worker /var/log/report-worker
sudo systemctl daemon-reload
sudo systemctl enable --now report-worker.timer
