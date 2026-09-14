#!/usr/bin/env bash
set -euo pipefail
[ "$#" -ge 3 ] || { echo "usage: $0 <phase> <lab> <before|after|diff>"; exit 2; }
PHASE="$1"; LAB="$2"; MODE="$3"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lab-common.sh
source "$SCRIPT_DIR/lab-common.sh"
DIR="$(lt_records_dir "$PHASE" "$LAB")"
collect(){
  {
    date
    echo '--- hostnamectl'; hostnamectl 2>&1 || true
    echo '--- uname'; uname -a 2>&1 || true
    echo '--- os-release'; cat /etc/os-release 2>&1 || true
    echo '--- identity'; whoami; id; groups
    echo '--- sessions'; who 2>&1 || true; w 2>&1 || true
    echo '--- network'; ip addr 2>&1 || true; ip route 2>&1 || true
    echo '--- storage'; lsblk -f 2>&1 || true; df -h 2>&1 || true
    echo '--- services'; systemctl --failed 2>&1 || true
    echo '--- sockets'; ss -tulpn 2>&1 || true
  }
}
case "$MODE" in
  before|after) collect > "$DIR/$MODE.txt"; echo "$DIR/$MODE.txt" ;;
  diff)
    [ -f "$DIR/before.txt" ] && [ -f "$DIR/after.txt" ] || lt_die "before.txt/after.txt missing"
    diff -u "$DIR/before.txt" "$DIR/after.txt" > "$DIR/diff.txt" || true
    echo "$DIR/diff.txt" ;;
  *) lt_die "unknown mode: $MODE" ;;
esac
