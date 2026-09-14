#!/usr/bin/env python3
import json, os, platform, socket, uuid
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

HOST=os.getenv('REPORT_HOST','127.0.0.1')
PORT=int(os.getenv('REPORT_PORT','8080'))
DATA=Path(os.getenv('REPORT_DATA','/data/report-app/reports'))
DATA.mkdir(parents=True, exist_ok=True)

def dump(obj, code=200):
    return code, json.dumps(obj, ensure_ascii=False, indent=2).encode()

class H(BaseHTTPRequestHandler):
    def _send(self, code, body):
        self.send_response(code); self.send_header('Content-Type','application/json; charset=utf-8'); self.send_header('Content-Length',str(len(body))); self.end_headers(); self.wfile.write(body)
    def do_GET(self):
        if self.path=='/health':
            c,b=dump({'status':'ok','service':'report-app'}); return self._send(c,b)
        if self.path=='/system':
            c,b=dump({'hostname':socket.gethostname(),'kernel':platform.release(),'python':platform.python_version()}); return self._send(c,b)
        if self.path=='/reports':
            items=[]
            for p in sorted(DATA.glob('*.json')):
                try: items.append(json.loads(p.read_text()))
                except Exception: pass
            c,b=dump(items); return self._send(c,b)
        if self.path.startswith('/reports/'):
            rid=self.path.rsplit('/',1)[-1]
            p=DATA/f'{rid}.json'
            if not p.exists(): c,b=dump({'error':'not found'},404)
            else: c,b=dump(json.loads(p.read_text()))
            return self._send(c,b)
        c,b=dump({'error':'not found'},404); self._send(c,b)
    def do_POST(self):
        if self.path!='/reports':
            c,b=dump({'error':'not found'},404); return self._send(c,b)
        n=int(self.headers.get('Content-Length','0')); raw=self.rfile.read(n)
        try: obj=json.loads(raw or b'{}')
        except Exception:
            c,b=dump({'error':'invalid json'},400); return self._send(c,b)
        rid=str(obj.get('id') or uuid.uuid4())
        obj['id']=rid; obj.setdefault('created_at',datetime.now(timezone.utc).isoformat())
        (DATA/f'{rid}.json').write_text(json.dumps(obj,ensure_ascii=False,indent=2))
        c,b=dump(obj,201); self._send(c,b)
    def log_message(self, fmt, *args):
        print('%s - %s' % (self.address_string(), fmt%args), flush=True)

if __name__=='__main__':
    print(f'report-app listening on {HOST}:{PORT}, data={DATA}', flush=True)
    ThreadingHTTPServer((HOST,PORT),H).serve_forever()
