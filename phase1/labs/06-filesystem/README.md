# Lab 06 — Filesystem

在 sandbox directory 練習 inode、權限、搜尋與容量觀察。

## 建議操作順序

1. `./prepare.sh`
2. `df -h`
3. `df -i`
4. `du -sh "$(./prepare.sh --print-runtime)/fs"`
5. `stat "$(./prepare.sh --print-runtime)/fs/a.txt"`
6. `chmod 640 "$(./prepare.sh --print-runtime)/fs/a.txt"`
7. `find "$(./prepare.sh --print-runtime)/fs" -type f -perm 640`
8. `./verify.sh changed`
9. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
