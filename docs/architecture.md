# Architecture

```text
Linux Server
├── Report App (:8080)
│   └── /data/report-app
├── Report Worker
│   └── /data/report-worker
└── systemd / timer / logs / firewall / packages
```

訓練 repository 與主機實際部署路徑分離：repository 提供教材與控制腳本；學生實際操作 `/opt`、`/etc`、`/data`、`/var/lib`、`/var/log` 與 systemd。
