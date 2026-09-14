#!/usr/bin/env bash
set -euo pipefail

echo "Cleanup runtime temp state only; use explicit uninstall scripts for applications."
rm -f ../runtime/state/active-fault ../runtime/state/active-change
touch ../runtime/state/active-fault ../runtime/state/active-change
