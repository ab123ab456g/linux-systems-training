# Lab 08 — DNS

用 /etc/hosts 的專用 marker 做可回復的名稱解析 sandbox。

## 建議操作順序

1. `./prepare.sh`
2. `echo "127.0.0.1 phase1-lab.local # PHASE1_LAB08" | sudo tee -a /etc/hosts`
3. `getent hosts phase1-lab.local`
4. `./verify.sh configured`
5. `./rollback.sh`
6. `./verify.sh restored`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
