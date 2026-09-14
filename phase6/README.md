# Phase 6 — 效能分析 / 容量規劃

## 故事背景
Report App 與 Report Worker 已正式營運一段時間。系統沒有明顯故障，health check 正常，
但使用量上升後開始出現延遲、資源競爭與容量成長問題。

Phase 6 的目標不是「把壞掉的系統修好」，而是：

1. 建立正常 baseline
2. 量測 CPU / RAM / Disk / Network / Application
3. 隔離 bottleneck
4. 做單一變更 tuning
5. 用相同 workload 重測
6. 持續監控
7. 若效能變差則 rollback
8. 根據歷史資料做 capacity forecast
9. 判斷 scale up / scale out

## 核心循環
Baseline -> Measure -> Isolate -> Tune -> Verify -> Monitor -> Rollback if worse -> Measure again

## 系統
- report-app.service
- report-worker.service
- report-worker.timer
- Report App API
- Report / Summary data

## 最終交付
- performance baseline
- bottleneck analysis
- before/after benchmark
- capacity forecast
- scale decision report
