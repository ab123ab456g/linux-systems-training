# Phase 7 Story

系統正常營運，但不假設現況就是安全的。

依序進行：
1. 建立 user / session baseline
2. 檢查 sudo / root 權限
3. 清理不必要 user
4. 清理不必要 group membership
5. 掃描 owner / permission
6. 掃描 SUID / SGID
7. 檢查 SSH 設定
8. 盤點開放 Port
9. 盤點 listening Service
10. 檢查 Firewall 規則
11. 檢查對外暴露 interface
12. 評估安全套件更新
13. 分析異常登入
14. 分析 authentication failure
15. 檢查 systemd service 執行帳號
16. 檢查 secret 暴露
17. 檢查 credential / key 權限
18. 移除不必要帳號 / Service
19. 關閉不必要 Port
20. SSH Hardening
21. 安全性套件更新
22. 驗證必要服務仍可用
23. 持續監控登入 / 權限 / Port

原則：
- 先 inventory，再 harden
- 不確定用途前不要直接刪除
- 所有 hardening 都要可 rollback
- SSH 變更必須保留舊 session 測新 session
- hardening 完成後要完整驗證 Report App / Worker / Timer / SSH
