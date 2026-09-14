# Lab 12 — Resource

使用可控 workload 觀察 CPU/RAM，然後清除。

## 建議操作順序

1. `./prepare.sh`
2. `"$(./prepare.sh --print-runtime)/cpu_load.sh" & echo $! > "$(./prepare.sh --print-runtime)/pid"`
3. `top -b -n1 | head`
4. `vmstat 1 3`
5. `free -h`
6. `./verify.sh running`
7. `kill "$(cat "$(./prepare.sh --print-runtime)/pid")"`
8. `./verify.sh stopped`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
