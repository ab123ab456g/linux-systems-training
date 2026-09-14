# 確認 SUID / SGID 檔案

## 目的
找不必要 privileged bit

## 流程
Inventory -> Assess -> Isolate -> Harden -> Verify -> Monitor -> Rollback if needed

## 注意
- 不要在未確認 dependency 前直接刪除帳號 / service / rule。
- 所有修改前先保留目前設定。
- SSH 修改必須保留舊 session 再測新 session。
- Secret 類 scenario 不應將真實 secret 寫入 log 或 report。
