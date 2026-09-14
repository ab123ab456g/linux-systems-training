# Lab 10 — Service

建立專用 systemd service，修改、啟停、驗證後移除。

## 建議操作順序

1. `./prepare.sh`
2. `sudo cp "$(./prepare.sh --print-runtime)/phase1-lab10.service" /etc/systemd/system/`
3. `sudo systemctl daemon-reload`
4. `sudo systemctl start phase1-lab10`
5. `systemctl status phase1-lab10 --no-pager`
6. `./verify.sh running`
7. `sudo systemctl stop phase1-lab10`
8. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
