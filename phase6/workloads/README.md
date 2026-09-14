# Workloads

可使用的測試工具：
- CPU/RAM: stress-ng
- Disk I/O: fio
- Network: iperf3
- HTTP: curl / 自製 concurrent request script

所有 workload 必須：
1. 先記 baseline
2. 設定 duration
3. 記錄參數
4. 使用相同 workload 做 before/after 比較
5. 完成後 reset
