#!/usr/bin/env bash
set -euo pipefail
stage="${1:-value}"; expected="${2:-two}"
case "$stage" in value) [ "${PHASE1_LAB_VAR:-}" = "$expected" ];; absent) [ -z "${PHASE1_LAB_VAR+x}" ];; *) echo "value <expected>|absent"; exit 2;; esac
echo "[LAB] PASS $stage"
