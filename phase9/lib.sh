#!/usr/bin/env bash
set -euo pipefail

P9_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$P9_DIR/.." && pwd)"
source "$ROOT/common/scripts/lab-runtime.sh"

p9_scenario() { basename "$(dirname "$1")"; }
p9_runtime() { printf '%s/runtime/labs/phase9/%s' "$ROOT" "$(p9_scenario "$1")"; }
p9_log() { lt_log "phase9: $*"; }
p9_have() { command -v "$1" >/dev/null 2>&1; }

p9_record() {
  local script="$1" label="${2:-machine-record}" d out
  d="$(p9_runtime "$script")"; mkdir -p "$d/logs"
  out="$d/logs/${label}.txt"; : >"$out"
  {
    printf '# Phase 9 machine record\n# time=%s\n\n' "$(date -Is)"
    printf '## identity\n'; whoami; id; groups || true
    printf '\n## os/kernel\n'; hostnamectl 2>/dev/null || true; uname -a; cat /etc/os-release 2>/dev/null || true
    printf '\n## cpu/memory\n'; lscpu 2>/dev/null || true; free -h 2>/dev/null || true; uptime || true
    printf '\n## storage\n'; lsblk -f 2>/dev/null || true; blkid 2>/dev/null || true; findmnt 2>/dev/null || true; df -hT; df -i
    printf '\n## pci/usb\n'; lspci -k 2>/dev/null || true; lsusb 2>/dev/null || true
    printf '\n## network\n'; ip link 2>/dev/null || true; ip addr 2>/dev/null || true; ip route 2>/dev/null || true
    printf '\n## sockets\n'; ss -tulpn 2>/dev/null || true
    printf '\n## services\n'; systemctl --no-pager --failed 2>/dev/null || true
    printf '\n## logs\n'; journalctl -p warning..alert -n 80 --no-pager 2>/dev/null || true
    printf '\n## processes\n'; ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu | head -n 30
    printf '\n## runtimes\n'
    for c in git ssh python3 pip3 node npm java javac gcc make; do
      command -v "$c" 2>/dev/null || true
      "$c" --version 2>/dev/null | head -n 2 || true
    done
  } >>"$out" 2>&1
  p9_log "wrote $out"
}

p9_prepare() {
  local script="$1" scenario d
  scenario="$(p9_scenario "$script")"; d="$(p9_runtime "$script")"
  mkdir -p "$d"/{work,backup,logs}
  printf 'scenario=%s\nprepared_at=%s\n' "$scenario" "$(date -Is)" >"$d/state.env"
  case "$scenario" in
    01-takeover-baseline)
      p9_record "$script" "machine-record-before"
      ;;
    02-slow-system-high-cpu)
      printf 'normal\n' >"$d/work/status.txt"; cp "$d/work/status.txt" "$d/backup/status.txt"
      ;;
    03-disk-pressure)
      mkdir -p "$d/work/data"; printf 'normal\n' >"$d/work/data/README"
      ;;
    04-network-dns)
      cat >"$d/work/resolv.conf" <<'EOF'
nameserver 1.1.1.1
options timeout:2 attempts:2
EOF
      cp "$d/work/resolv.conf" "$d/backup/resolv.conf"
      ;;
    05-usb-hardware|06-gpu-display)
      p9_record "$script" "hardware-before"
      ;;
    07-service-failure)
      cat >"$d/work/service.env" <<'EOF'
SERVICE_NAME=report-app
PORT=8080
STATE=active
EOF
      cp "$d/work/service.env" "$d/backup/service.env"
      ;;
    08-path-runtime)
      mkdir -p "$d/work/bin-good" "$d/work/bin-bad"
      printf '#!/usr/bin/env bash\necho GOOD-RUNTIME\n' >"$d/work/bin-good/python3"
      printf '#!/usr/bin/env bash\necho BAD-RUNTIME\n' >"$d/work/bin-bad/python3"
      chmod +x "$d/work/bin-good/python3" "$d/work/bin-bad/python3"
      printf 'export PATH="%s/work/bin-good:$PATH"\n' "$d" >"$d/backup/env.sh"
      cp "$d/backup/env.sh" "$d/work/env.sh"
      ;;
    09-permission-denied)
      printf 'important data\n' >"$d/work/secret.txt"
      chmod 600 "$d/work/secret.txt"
      cp -a "$d/work/secret.txt" "$d/backup/secret.txt"
      ;;
    10-boot-login-slow)
      mkdir -p "$d/work/startup.d"
      printf '#!/usr/bin/env bash\nsleep 0\n' >"$d/work/startup.d/20-report-sync"
      chmod +x "$d/work/startup.d/20-report-sync"
      cp -a "$d/work/startup.d" "$d/backup/"
      ;;
    11-filesystem-image)
      truncate -s 32M "$d/work/fs.img"
      if p9_have mkfs.ext4; then mkfs.ext4 -q -F "$d/work/fs.img"; fi
      cp "$d/work/fs.img" "$d/backup/fs.img"
      ;;
    12-preserve-rebuild)
      mkdir -p "$d/work/home/Projects/demo" "$d/work/home/.ssh" "$d/work/home/Documents"
      printf 'demo project\n' >"$d/work/home/Projects/demo/README.md"
      printf 'Host github.com\n  User git\n' >"$d/work/home/.ssh/config"
      printf '[user]\n\tname = Training User\n' >"$d/work/home/.gitconfig"
      printf 'important document\n' >"$d/work/home/Documents/important.txt"
      printf 'git\npython3\ncurl\n' >"$d/work/package-list.txt"
      ;;
  esac
  p9_log "prepared $scenario"
}

p9_fault() {
  local script="$1" scenario d
  scenario="$(p9_scenario "$script")"; d="$(p9_runtime "$script")"
  [[ -f "$d/state.env" ]] || p9_prepare "$script"
  case "$scenario" in
    01-takeover-baseline|05-usb-hardware|06-gpu-display)
      printf 'inspection-only=true\n' >"$d/fault.env"
      ;;
    02-slow-system-high-cpu)
      if [[ -f "$d/hog.pid" ]] && kill -0 "$(cat "$d/hog.pid")" 2>/dev/null; then
        p9_log "CPU hog already running"
      else
        (yes >/dev/null) & echo $! >"$d/hog.pid"
      fi
      printf 'cause=high-cpu-process\n' >"$d/fault.env"
      ;;
    03-disk-pressure)
      dd if=/dev/zero of="$d/work/data/disk-pressure.bin" bs=1M count=32 status=none
      mkdir -p "$d/work/data/inodes"
      for i in $(seq 1 2000); do : >"$d/work/data/inodes/file-$i"; done
      printf 'cause=space-and-inode-pressure\n' >"$d/fault.env"
      ;;
    04-network-dns)
      printf 'nameserver 203.0.113.254\noptions timeout:1 attempts:1\n' >"$d/work/resolv.conf"
      printf 'cause=bad-dns-config\n' >"$d/fault.env"
      ;;
    07-service-failure)
      sed -i 's/^PORT=.*/PORT=99999/; s/^STATE=.*/STATE=failed/' "$d/work/service.env"
      printf 'cause=bad-service-config\n' >"$d/fault.env"
      ;;
    08-path-runtime)
      printf 'export PATH="%s/work/bin-bad:%s/work/bin-good:$PATH"\n' "$d" "$d" >"$d/work/env.sh"
      printf 'cause=path-shadowing\n' >"$d/fault.env"
      ;;
    09-permission-denied)
      chmod 000 "$d/work/secret.txt"
      printf 'cause=file-mode-000\n' >"$d/fault.env"
      ;;
    10-boot-login-slow)
      printf '#!/usr/bin/env bash\nsleep 8\n' >"$d/work/startup.d/20-report-sync"
      chmod +x "$d/work/startup.d/20-report-sync"
      printf 'cause=slow-startup-job\n' >"$d/fault.env"
      ;;
    11-filesystem-image)
      if p9_have mkfs.ext4; then
        dd if=/dev/zero of="$d/work/fs.img" bs=1024 count=4 seek=1 conv=notrunc status=none
      else
        printf 'SIMULATED-CORRUPTION\n' >>"$d/work/fs.img"
      fi
      printf 'cause=filesystem-image-corruption\n' >"$d/fault.env"
      ;;
    12-preserve-rebuild)
      printf 'decision=rebuild\nreason=unknown-history-and-multiple-faults\n' >"$d/fault.env"
      ;;
  esac
  p9_log "fault/scenario state ready: $scenario"
}

p9_observe() {
  local script="$1" scenario d out
  scenario="$(p9_scenario "$script")"; d="$(p9_runtime "$script")"
  mkdir -p "$d/logs"; out="$d/logs/observe-$(date +%Y%m%d-%H%M%S).txt"
  {
    printf '# scenario=%s\n# time=%s\n' "$scenario" "$(date -Is)"
    case "$scenario" in
      01-takeover-baseline) p9_record "$script" "takeover-observation";;
      02-slow-system-high-cpu)
        uptime; free -h; ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu | head -n 25
        p9_have vmstat && vmstat 1 3
        ;;
      03-disk-pressure)
        df -h; df -i; du -xhd1 "$d/work" 2>/dev/null || true
        find "$d/work" -type f -size +10M -ls 2>/dev/null || true
        ;;
      04-network-dns)
        ip link 2>/dev/null || true; ip addr 2>/dev/null || true; ip route 2>/dev/null || true
        p9_have resolvectl && resolvectl status || true
        printf '\n## lab resolver\n'; cat "$d/work/resolv.conf"
        ;;
      05-usb-hardware)
        p9_have lsusb && lsusb || true
        journalctl -k -n 80 --no-pager 2>/dev/null || dmesg | tail -n 80 || true
        ;;
      06-gpu-display)
        p9_have lspci && lspci -k | grep -A3 -Ei 'vga|3d|display' || true
        p9_have nvidia-smi && nvidia-smi || true
        journalctl -k -n 80 --no-pager 2>/dev/null || true
        ;;
      07-service-failure)
        cat "$d/work/service.env"
        systemctl --no-pager --failed 2>/dev/null || true
        ss -lntup 2>/dev/null || true
        journalctl -p warning..alert -n 50 --no-pager 2>/dev/null || true
        ;;
      08-path-runtime)
        cat "$d/work/env.sh"
        bash -c "source '$d/work/env.sh'; command -v python3; python3"
        ;;
      09-permission-denied)
        id; ls -l "$d/work/secret.txt"; stat "$d/work/secret.txt"
        p9_have getfacl && getfacl "$d/work/secret.txt" || true
        ;;
      10-boot-login-slow)
        p9_have systemd-analyze && systemd-analyze || true
        p9_have systemd-analyze && systemd-analyze blame | head -n 20 || true
        grep -Rns 'sleep ' "$d/work/startup.d" || true
        ;;
      11-filesystem-image)
        ls -lh "$d/work/fs.img"
        p9_have file && file "$d/work/fs.img" || true
        p9_have fsck.ext4 && fsck.ext4 -fn "$d/work/fs.img" || true
        ;;
      12-preserve-rebuild)
        find "$d/work/home" -maxdepth 3 -type f -printf '%P\n' | sort
        cat "$d/work/package-list.txt"
        ;;
    esac
  } >>"$out" 2>&1 || true
  p9_log "wrote $out"
}

p9_verify() {
  local script="$1" scenario d
  scenario="$(p9_scenario "$script")"; d="$(p9_runtime "$script")"
  case "$scenario" in
    01-takeover-baseline)
      test -s "$d/logs/machine-record-before.txt"
      ;;
    02-slow-system-high-cpu)
      if [[ -f "$d/hog.pid" ]] && kill -0 "$(cat "$d/hog.pid")" 2>/dev/null; then
        echo "FAIL: CPU hog still running: PID $(cat "$d/hog.pid")"; return 1
      fi
      ;;
    03-disk-pressure)
      test ! -e "$d/work/data/disk-pressure.bin"
      [[ ! -d "$d/work/data/inodes" || $(find "$d/work/data/inodes" -type f | wc -l) -lt 100 ]]
      ;;
    04-network-dns)
      cmp -s "$d/work/resolv.conf" "$d/backup/resolv.conf"
      ;;
    05-usb-hardware|06-gpu-display)
      ls "$d/logs"/observe-*.txt >/dev/null 2>&1
      ;;
    07-service-failure)
      grep -q '^PORT=8080$' "$d/work/service.env" && grep -q '^STATE=active$' "$d/work/service.env"
      ;;
    08-path-runtime)
      [[ "$(bash -c "source '$d/work/env.sh'; python3")" == "GOOD-RUNTIME" ]]
      ;;
    09-permission-denied)
      [[ "$(stat -c '%a' "$d/work/secret.txt")" == "600" ]]
      ;;
    10-boot-login-slow)
      ! grep -Eq 'sleep +[1-9][0-9]*' "$d/work/startup.d/20-report-sync"
      ;;
    11-filesystem-image)
      if p9_have fsck.ext4; then fsck.ext4 -fn "$d/work/fs.img" >/dev/null 2>&1; else cmp -s "$d/work/fs.img" "$d/backup/fs.img"; fi
      ;;
    12-preserve-rebuild)
      test -d "$d/work/backup"
      test -f "$d/work/backup/SHA256SUMS"
      test -f "$d/work/backup/Projects/demo/README.md"
      ;;
  esac
  p9_log "verify passed: $scenario"
}

p9_rollback() {
  local script="$1" scenario d
  scenario="$(p9_scenario "$script")"; d="$(p9_runtime "$script")"
  case "$scenario" in
    02-slow-system-high-cpu)
      if [[ -f "$d/hog.pid" ]]; then kill "$(cat "$d/hog.pid")" 2>/dev/null || true; rm -f "$d/hog.pid"; fi
      ;;
    03-disk-pressure)
      rm -f "$d/work/data/disk-pressure.bin"; rm -rf "$d/work/data/inodes"
      ;;
    04-network-dns) cp "$d/backup/resolv.conf" "$d/work/resolv.conf";;
    07-service-failure) cp "$d/backup/service.env" "$d/work/service.env";;
    08-path-runtime) cp "$d/backup/env.sh" "$d/work/env.sh";;
    09-permission-denied) chmod 600 "$d/work/secret.txt";;
    10-boot-login-slow) rm -rf "$d/work/startup.d"; cp -a "$d/backup/startup.d" "$d/work/";;
    11-filesystem-image) cp "$d/backup/fs.img" "$d/work/fs.img";;
  esac
  rm -f "$d/fault.env"
  p9_log "rolled back: $scenario"
}

p9_reset() {
  local script="$1" d
  d="$(p9_runtime "$script")"
  if [[ -f "$d/hog.pid" ]]; then kill "$(cat "$d/hog.pid")" 2>/dev/null || true; fi
  rm -rf "$d"
  p9_log "reset $(p9_scenario "$script")"
}
