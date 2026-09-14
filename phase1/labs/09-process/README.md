# Lab 09 — Process

建立、停止/繼續與終止 sandbox process。

## 建議操作順序

1. `./prepare.sh`
2. `sleep 600 & echo $! > "$(./prepare.sh --print-runtime)/pid"`
3. `pgrep -a sleep`
4. `kill -STOP "$(cat "$(./prepare.sh --print-runtime)/pid")"`
5. `kill -CONT "$(cat "$(./prepare.sh --print-runtime)/pid")"`
6. `./verify.sh running`
7. `kill "$(cat "$(./prepare.sh --print-runtime)/pid")"`
8. `./verify.sh stopped`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
