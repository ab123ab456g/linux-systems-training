# System Story

## Phase 1
接手一台已正常運作的 Report Server，完成完整巡檢、基本操作、驗證與 baseline report。

## Phase 2
同一台主機被逐項注入故障；學生必須從症狀追到 root cause，修復並驗證。

## Phase 3
系統恢復正常後，新增 `report-worker`，不能破壞原 `report-app`。

## Phase 4
Report System 已進 production。營運期間收到 package update、app upgrade、設定、權限、port、firewall、DNS、排程、資源、backup/restore、credential rotation 等 change request。
