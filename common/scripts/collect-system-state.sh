#!/usr/bin/env bash
set -euo pipefail

echo '## identity'; id
echo '## system'; uname -a
echo '## disk'; lsblk; df -h
echo '## network'; ip addr; ip route
echo '## service'; systemctl --no-pager status report-app.service 2>/dev/null || true
echo '## port'; ss -tulpn 2>/dev/null || true
