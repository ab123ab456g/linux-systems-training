# Phase 7 — 安全性檢查 / 權限與暴露面管理

## 故事背景
Report App 與 Report Worker 已穩定營運，公司開始第一次正式 Security Review。

Phase 7 的目標不是做攻防，而是：
- 盤點目前 user / group / sudo / session
- 盤點 service / port / interface / firewall
- 檢查 SSH / credentials / secrets
- 移除不必要帳號、服務、Port 與權限
- 降低 service privilege
- 套用 security updates
- 驗證必要服務仍正常
- 建立持續 security baseline monitoring

## 核心循環
Inventory -> Assess -> Isolate -> Harden -> Verify -> Monitor -> Rollback if needed -> Repeat

## 最終交付
- security baseline
- exposure inventory
- hardening report
- before/after comparison
- rollback notes
- monitoring baseline
