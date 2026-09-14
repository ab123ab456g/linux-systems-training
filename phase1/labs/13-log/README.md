# Lab 13 — Log

產生 sandbox log，使用 journalctl/tail/grep 篩選。

## 建議操作順序

1. `./prepare.sh`
2. `logger -t phase1-lab13 "PHASE1_LAB13 test event"`
3. `echo "ERROR phase1 sample" >> "$(./prepare.sh --print-runtime)/app.log"`
4. `journalctl -t phase1-lab13 -n 20 --no-pager`
5. `grep -nE "ERROR|FAIL" "$(./prepare.sh --print-runtime)/app.log"`
6. `./verify.sh generated`
7. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
