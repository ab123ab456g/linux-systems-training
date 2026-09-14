#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 14-package)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
lt_require dpkg-deb
build(){ v="$1"; B="$R/build-$v"; rm -rf "$B"; mkdir -p "$B/DEBIAN" "$B/usr/local/bin"; cat > "$B/DEBIAN/control" <<EOF
Package: phase1-helper
Version: $v
Section: misc
Priority: optional
Architecture: all
Maintainer: Phase1 Lab
Description: Local package for Phase1 training
EOF
cat > "$B/usr/local/bin/phase1-helper" <<EOF
#!/usr/bin/env bash
echo phase1-helper $v
EOF
chmod +x "$B/usr/local/bin/phase1-helper"
dpkg-deb --build "$B" "$R/phase1-helper_${v}_all.deb" >/dev/null
}
build 1.0; build 1.1
lt_log prepared
