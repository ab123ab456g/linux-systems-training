# Phase 8 — 進階系統管理與基礎設施維運

## 故事背景
前七個 Phase 已經完成單台 production-like Linux Server 的：
- 操作
- 故障診斷
- 建置
- 變更管理
- 災難恢復
- 效能與容量
- 安全 hardening

Phase 8 開始從「單機管理」擴展到：
- 自動化
- 帳號生命週期治理
- 資料搬移
- Release / Rollout
- Boot / Shutdown dependency
- 遠端與多機操作
- Container
- 進階 Storage / Network
- Kernel / Driver
- 專門服務（Nginx / DB / Redis）
- IaC / 多機自動化

## 核心循環
Inventory -> Plan -> Prepare -> Change -> Verify -> Monitor -> Rollback -> Automate

## 最終目標
把既有 Linux administration 能力轉成可重複、可擴展、可跨主機的 Infrastructure Operations 能力。
