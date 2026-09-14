#!/usr/bin/env bash
set -euo pipefail

lt_root() { cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd; }
lt_phase_from_path() { local p="$1"; grep -oE 'phase[0-9]+' <<<"$p" | tail -1; }
lt_scenario_from_path() { basename "$(dirname "$1")"; }
lt_runtime_dir() {
  local script="$1" root phase scenario
  root="$(lt_root)"; phase="$(lt_phase_from_path "$script")"; scenario="$(lt_scenario_from_path "$script")"
  printf '%s/runtime/labs/%s/%s' "$root" "$phase" "$scenario"
}
lt_log() { printf '[%s] %s\n' "$(date '+%F %T')" "$*"; }
lt_have() { command -v "$1" >/dev/null 2>&1; }
lt_run() {
  local out="$1"; shift
  { printf '$'; printf ' %q' "$@"; printf '\n'; "$@"; } >>"$out" 2>&1 || true
}
lt_snapshot_file() {
  local src="$1" dst="$2"
  [[ -e "$src" ]] || return 0
  mkdir -p "$(dirname "$dst")"
  cp -a "$src" "$dst"
}
lt_inventory() {
  local topic="$1" out="$2"
  mkdir -p "$(dirname "$out")"; : >"$out"
  printf '# topic=%s\n# time=%s\n' "$topic" "$(date -Is)" >>"$out"
  lt_run "$out" uname -a
  lt_run "$out" id
  case "$topic" in
    *user*|*account*|*login*|*sudo*|*permission*|*ssh*|*credential*|*auth*)
      lt_run "$out" who; lt_run "$out" w; lt_run "$out" last -n 10
      lt_have getent && lt_run "$out" getent passwd
      lt_have getent && lt_run "$out" getent group
      lt_have sudo && lt_run "$out" sudo -n -l
      ;;
    *disk*|*storage*|*mount*|*filesystem*|*migration*|*data*)
      lt_have lsblk && lt_run "$out" lsblk -f
      lt_run "$out" df -hT
      lt_have findmnt && lt_run "$out" findmnt
      ;;
    *network*|*dns*|*port*|*socket*|*firewall*|*interface*|*remote*|*multihost*)
      lt_have ip && lt_run "$out" ip addr
      lt_have ip && lt_run "$out" ip route
      lt_have ss && lt_run "$out" ss -tulpn
      lt_have resolvectl && lt_run "$out" resolvectl status
      lt_have nft && lt_run "$out" nft list ruleset
      lt_have ufw && lt_run "$out" ufw status verbose
      ;;
    *service*|*systemd*|*boot*|*release*|*rollout*|*specialized*)
      lt_have systemctl && lt_run "$out" systemctl --no-pager --failed
      lt_have systemctl && lt_run "$out" systemctl --no-pager list-units --type=service --state=running
      lt_have systemctl && lt_run "$out" systemctl get-default
      lt_have ss && lt_run "$out" ss -lntup
      ;;
    *cpu*|*ram*|*memory*|*resource*|*performance*|*capacity*|*stress*|*cache*)
      lt_have lscpu && lt_run "$out" lscpu
      lt_run "$out" free -h
      lt_run "$out" uptime
      lt_run "$out" df -h
      lt_run "$out" ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu
      ;;
    *kernel*|*driver*|*hardware*)
      lt_run "$out" uname -a
      lt_have lscpu && lt_run "$out" lscpu
      lt_have lspci && lt_run "$out" lspci -k
      lt_have lsusb && lt_run "$out" lsusb
      lt_have lsmod && lt_run "$out" lsmod
      lt_have dmesg && lt_run "$out" dmesg --level=err,warn
      ;;
    *container*)
      lt_have docker && lt_run "$out" docker ps -a
      lt_have docker && lt_run "$out" docker images
      lt_have podman && lt_run "$out" podman ps -a
      ;;
    *package*|*update*)
      lt_have dpkg-query && lt_run "$out" dpkg-query -W
      lt_have apt && lt_run "$out" apt list --upgradable
      ;;
    *schedule*|*automation*|*timer*)
      lt_have systemctl && lt_run "$out" systemctl --no-pager list-timers --all
      lt_have crontab && lt_run "$out" crontab -l
      ;;
    *log*)
      lt_have journalctl && lt_run "$out" journalctl -n 80 --no-pager
      ;;
    *)
      lt_run "$out" ps -ef
      lt_have ss && lt_run "$out" ss -lntup
      lt_run "$out" df -h
      ;;
  esac
  return 0
}
lt_prepare() {
  local script="$1" topic="$2" d
  d="$(lt_runtime_dir "$script")"; mkdir -p "$d/work" "$d/backup" "$d/logs"
  printf 'phase=%s\nscenario=%s\ntopic=%s\nprepared_at=%s\n' "$(lt_phase_from_path "$script")" "$(lt_scenario_from_path "$script")" "$topic" "$(date -Is)" >"$d/state.env"
  printf 'known-good\n' >"$d/work/known-good.txt"
  cp "$d/work/known-good.txt" "$d/backup/known-good.txt"
  lt_inventory "$topic" "$d/logs/inventory-before.txt"
  lt_log "prepared $d"
}
lt_fault() {
  local script="$1" topic="$2" d
  lt_prepare "$script" "$topic"; d="$(lt_runtime_dir "$script")"
  printf 'fault=%s\nfaulted_at=%s\n' "$topic" "$(date -Is)" >"$d/fault.env"
  printf 'BROKEN:%s\n' "$topic" >"$d/work/known-good.txt"
  lt_log "fault injected in sandbox: $topic"
}
lt_observe() {
  local script="$1" topic="$2" label="$3" d
  d="$(lt_runtime_dir "$script")"; mkdir -p "$d/logs"
  lt_inventory "$topic" "$d/logs/${label}.txt"
  lt_log "wrote $d/logs/${label}.txt"
}
lt_verify() {
  local script="$1" topic="$2" d rc=0
  d="$(lt_runtime_dir "$script")"; mkdir -p "$d/logs"
  lt_inventory "$topic" "$d/logs/verify.txt"
  [[ -f "$d/state.env" ]] || { lt_log "WARN: scenario has not been prepared; inventory-only verification"; return 0; }
  if [[ -f "$d/fault.env" ]]; then
    if grep -q '^BROKEN:' "$d/work/known-good.txt" 2>/dev/null; then
      lt_log "fault is still present (expected before student repair)"; rc=1
    fi
  fi
  if cmp -s "$d/work/known-good.txt" "$d/backup/known-good.txt" 2>/dev/null; then
    lt_log "sandbox state matches known-good"
  else
    lt_log "sandbox state differs from known-good"
  fi
  return "$rc"
}
lt_rollback() {
  local script="$1" d
  d="$(lt_runtime_dir "$script")"
  [[ -d "$d" ]] || { lt_log "nothing to rollback"; return 0; }
  [[ -f "$d/backup/known-good.txt" ]] && cp "$d/backup/known-good.txt" "$d/work/known-good.txt"
  rm -f "$d/fault.env"
  lt_log "rolled back sandbox state"
}
lt_reset() {
  local script="$1" d
  d="$(lt_runtime_dir "$script")"
  rm -rf "$d"
  lt_log "reset $d"
}
