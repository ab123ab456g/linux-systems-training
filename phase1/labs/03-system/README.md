# Lab 03 — OS / Kernel

建立 OS / kernel baseline，安全修改 hostname 後恢復。

## 建議操作順序

1. `hostnamectl`
2. `uname -a`
3. `uname -m`
4. `cat /etc/os-release`
5. `cat "$(./prepare.sh --print-runtime)/original-hostname"`
6. `sudo hostnamectl set-hostname phase1-lab-host`
7. `./verify.sh changed`
8. `./rollback.sh`
9. `./verify.sh restored`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
