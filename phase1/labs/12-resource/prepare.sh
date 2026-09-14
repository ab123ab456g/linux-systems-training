#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 12-resource)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
cat > "$R/cpu_load.sh" <<"EOF"
#!/usr/bin/env bash
while :; do :; done
EOF
chmod +x "$R/cpu_load.sh"
lt_log prepared
