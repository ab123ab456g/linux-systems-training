# Lab 18 — Report App / Final Handoff

啟動一個 mini Report App，完成 process/service/port/HTTP 與 final report。

## 建議操作順序

1. `./prepare.sh`
2. `python3 "$(./prepare.sh --print-runtime)/report_app.py" >"$(./prepare.sh --print-runtime)/app.log" 2>&1 & echo $! > "$(./prepare.sh --print-runtime)/pid"`
3. `curl http://127.0.0.1:18088/health`
4. `ss -tulpn | grep 18088`
5. `./verify.sh running`
6. `../../../common/scripts/record.sh phase1 18 after`
7. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
