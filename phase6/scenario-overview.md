# Phase 6 Story

系統已上線並穩定營運，但資料量與使用者數持續增加。

起始狀態：
- Report App 正常
- Report Worker 正常
- Health check = 200
- 沒有明顯故障

營運三個月後：
- reports/day 增加
- concurrent users 增加
- Worker 分析量增加
- 使用者開始反映「偶爾變慢」

Phase 6 依序進行：
1. 建 CPU baseline
2. 建 RAM baseline
3. 建 Disk usage baseline
4. 建 Disk I/O baseline
5. 建 Network baseline
6. 找高 CPU process
7. 找高 RAM process
8. 分析 swap / memory pressure
9. 分析 disk I/O bottleneck
10. 分析 disk growth
11. 分析 network throughput / latency
12. 分析 service response time
13. 分析 process / thread growth
14. 分析 open files / FD
15. 分析 connection / socket
16. 調整 process priority
17. 調整 systemd resource limits
18. 調整 cache / buffer
19. 清除非必要 workload
20. 壓力測試
21. 比較 tuning 前後
22. 容量預估
23. Scale up / Scale out 決策

原則：
- 先量測，再 tuning
- 一次只改一個主要變數
- 相同 workload 重測
- 保留 before/after 數據
- 若更差立即 rollback
