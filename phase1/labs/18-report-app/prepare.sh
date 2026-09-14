#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../common/scripts/lab-common.sh"
R="$(lt_runtime_dir 18-report-app)"
if [ "${1:-}" = "--print-runtime" ]; then echo "$R"; exit 0; fi
cat > "$R/report_app.py" <<"PYAPP"
from http.server import BaseHTTPRequestHandler, HTTPServer
import json, os, socket
class H(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            body=json.dumps({"status":"ok","host":socket.gethostname(),"pid":os.getpid()}).encode()
            self.send_response(200); self.send_header("Content-Type","application/json"); self.end_headers(); self.wfile.write(body)
        else:
            self.send_response(404); self.end_headers()
    def log_message(self, fmt, *args): pass
HTTPServer(("127.0.0.1",18088),H).serve_forever()
PYAPP
lt_log prepared
