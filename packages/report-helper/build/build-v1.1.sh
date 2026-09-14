#!/usr/bin/env bash
set -euo pipefail

VER="1.1"
ARCH="all"
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
TMP="$(mktemp -d)"
PKG="$TMP/report-helper"
mkdir -p "$PKG/DEBIAN" "$PKG/usr/local/bin"
cp "$ROOT/packages/report-helper/src/v$VER/report-helper" "$PKG/usr/local/bin/report-helper"
chmod 755 "$PKG/usr/local/bin/report-helper"
cat > "$PKG/DEBIAN/control" <<EOF
Package: report-helper
Version: $VER
Section: utils
Priority: optional
Architecture: $ARCH
Maintainer: Linux Training <training@example.invalid>
Description: Controlled training package for package lifecycle labs
EOF
mkdir -p "$ROOT/packages/report-helper/deb"
dpkg-deb --build "$PKG" "$ROOT/packages/report-helper/deb/report-helper_${VER}_${ARCH}.deb"
rm -rf "$TMP"
