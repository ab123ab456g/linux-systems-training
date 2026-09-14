#!/usr/bin/env bash
set -euo pipefail
need=(bash diff hostnamectl ip ss lsblk findmnt blkid losetup systemctl journalctl curl python3 dpkg dpkg-deb)
optional=(dig resolvectl lspci lsusb lsmem lsof nft ufw)
missing=0
for c in "${need[@]}"; do
  if command -v "$c" >/dev/null 2>&1; then printf '[OK]   %s\n' "$c"; else printf '[MISS] %s\n' "$c"; missing=1; fi
done
for c in "${optional[@]}"; do
  if command -v "$c" >/dev/null 2>&1; then printf '[OK?]  %s\n' "$c"; else printf '[OPT]  %s not installed\n' "$c"; fi
done
if [ "$missing" -ne 0 ]; then
  echo 'Required commands are missing.' >&2
  exit 1
fi
echo 'Core prerequisites look usable.'
