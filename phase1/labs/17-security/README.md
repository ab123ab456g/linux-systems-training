# Lab 17 — Security / Firewall

使用獨立 nft table sandbox，不掛 hook，不影響真實流量。

## 建議操作順序

1. `./prepare.sh`
2. `sudo nft add table inet phase1_lab17`
3. `sudo nft add chain inet phase1_lab17 sandbox`
4. `sudo nft add rule inet phase1_lab17 sandbox tcp dport 18080 accept`
5. `sudo nft list table inet phase1_lab17`
6. `./verify.sh configured`
7. `sudo nft delete table inet phase1_lab17`
8. `./verify.sh deleted`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
