# Lab 15 — Schedule

用 systemd timer sandbox 練習定時工作。

## 建議操作順序

1. `./prepare.sh`
2. `sudo cp "$(./prepare.sh --print-runtime)/phase1-lab15."{service,timer} /etc/systemd/system/`
3. `sudo systemctl daemon-reload`
4. `sudo systemctl start phase1-lab15.timer`
5. `systemctl list-timers --all | grep phase1-lab15`
6. `./verify.sh installed`
7. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
