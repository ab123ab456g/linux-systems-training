# Lab 07 — Network

使用 dummy NIC 練習 link/IP/route，不碰實體 NIC。

## 建議操作順序

1. `./prepare.sh`
2. `sudo ip link add phase1dummy0 type dummy`
3. `sudo ip addr add 10.10.10.1/24 dev phase1dummy0`
4. `sudo ip link set phase1dummy0 up`
5. `ip addr show phase1dummy0`
6. `./verify.sh configured`
7. `sudo ip link del phase1dummy0`
8. `./verify.sh deleted`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
