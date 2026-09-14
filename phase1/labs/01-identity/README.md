# Lab 01 — Identity / Permission

使用 test user/group sandbox 練習身分、群組與 sudo 權限。

## 建議操作順序

1. `sudo groupadd phase1lab`
2. `sudo useradd -m -s /bin/bash phase1user`
3. `id phase1user`
4. `sudo usermod -aG phase1lab phase1user`
5. `groups phase1user`
6. `./verify.sh updated`
7. `sudo userdel -r phase1user`
8. `sudo groupdel phase1lab`
9. `./verify.sh deleted`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
