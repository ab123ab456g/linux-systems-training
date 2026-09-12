#!/usr/bin/env bash
set -euo pipefail

systemctl is-active report-app.service >/dev/null
test -d /data/report-worker/summaries
