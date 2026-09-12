#!/usr/bin/env python3
import json, os, urllib.request
from datetime import datetime, timezone
from pathlib import Path
URL=os.getenv('REPORT_APP_URL','http://127.0.0.1:8080').rstrip('/')
OUT=Path(os.getenv('SUMMARY_PATH','/data/report-worker/summaries')); OUT.mkdir(parents=True,exist_ok=True)
with urllib.request.urlopen(URL+'/reports', timeout=5) as r:
    reports=json.load(r)
summary={'generated_at':datetime.now(timezone.utc).isoformat(),'reports':len(reports),'warnings':sum(1 for x in reports if x.get('severity')=='warning'),'critical':sum(1 for x in reports if x.get('severity')=='critical')}
name=datetime.now().strftime('daily-summary-%Y-%m-%d.json')
(OUT/name).write_text(json.dumps(summary,ensure_ascii=False,indent=2))
print(json.dumps(summary,ensure_ascii=False))
