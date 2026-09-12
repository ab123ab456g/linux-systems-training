# Linux Training

同一台 Linux Server、同一套 Report System，依序練習：

1. Phase 1：接手正常系統、巡檢與建立 baseline。
2. Phase 2：故障注入、診斷、修復與恢復。
3. Phase 3：在既有系統上部署 Report Worker。
4. Phase 4：正式上線後的日常維運與變更管理。

`ppt/` 保留既有簡報；其餘目錄是可執行教材、情境、驗證、回復與測試素材。

## 主要應用

- `report-app.service`：HTTP Report App，預設 `127.0.0.1:8080`
- `report-worker.service`：背景分析 worker
- `report-worker.timer`：定期觸發 worker

## 快速查看

```bash
./tools/status.sh
```

> 注意：部分 Lab 需要 root 權限、systemd、loop device 或真實 Linux VM。WSL 某些項目會受限。


## Phase 5 — Backup / Restore / Disaster Recovery
Recover data, configuration, application, service and infrastructure state from trustworthy recovery points, verify consistency, and fail back safely.


## Phase 6
效能分析 / 容量規劃：Baseline → Measure → Isolate → Tune → Verify → Monitor → Capacity Planning。


## Phase 7
安全性檢查 / 權限與暴露面管理：Inventory → Assess → Isolate → Harden → Verify → Monitor。


## Phase 8
進階系統管理與基礎設施維運：Automation / Multi-host / Container / Advanced Infra / IaC。


## Automated shell tests
Run `bash tests/test-all.sh`.
