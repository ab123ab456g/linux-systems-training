#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-../../reports/student-report-template.json}"
curl -fsS -X POST -H 'Content-Type: application/json' --data-binary "@$FILE" http://127.0.0.1:8080/reports
