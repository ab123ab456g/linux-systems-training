# Lab 11 — Port / Socket

用 Python HTTP server 練習 listener、ss、lsof、curl。

## 建議操作順序

1. `./prepare.sh`
2. `python3 -m http.server 18080 --directory "$(./prepare.sh --print-runtime)/www" >"$(./prepare.sh --print-runtime)/server.log" 2>&1 & echo $! > "$(./prepare.sh --print-runtime)/pid"`
3. `ss -tulpn | grep 18080`
4. `curl http://127.0.0.1:18080/`
5. `./verify.sh listening`
6. `kill "$(cat "$(./prepare.sh --print-runtime)/pid")"`
7. `./verify.sh stopped`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
