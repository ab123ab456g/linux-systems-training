#!/usr/bin/env bash
set -euo pipefail

lt_die(){ echo "[ERROR] $*" >&2; exit 1; }
lt_log(){ echo "[LAB] $*"; }
lt_have(){ command -v "$1" >/dev/null 2>&1; }
lt_require(){ lt_have "$1" || lt_die "missing command: $1"; }
lt_sudo(){ if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi; }

lt_repo_root(){
  local here
  here="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
  printf '%s\n' "$here"
}

lt_runtime_root(){
  local r="$(lt_repo_root)/runtime/phase1"
  mkdir -p "$r"
  printf '%s\n' "$r"
}

lt_runtime_dir(){
  local lab="$1" root d
  root="$(lt_runtime_root)"
  d="$root/$lab"
  mkdir -p "$d"
  case "$d" in
    "$root"/*) ;;
    *) lt_die "unsafe runtime path: $d" ;;
  esac
  printf '%s\n' "$d"
}

lt_safe_rm_runtime(){
  local lab="$1" root d
  root="$(lt_runtime_root)"
  d="$root/$lab"
  case "$d" in
    "$root"/*) rm -rf -- "$d" ;;
    *) lt_die "refusing rm outside runtime root: $d" ;;
  esac
}

lt_records_dir(){
  local phase="$1" lab="$2" d="$HOME/linux-training-records/$phase/$lab"
  mkdir -p "$d"
  printf '%s\n' "$d"
}
