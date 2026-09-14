# Lab 05 — Disk / Mount

使用 image + loop device 練習 block device 與 mount。

## 建議操作順序

1. `./prepare.sh`
2. `cat "$(./prepare.sh --print-runtime)/device"`
3. `sudo mkfs.ext4 -F "$(cat "$(./prepare.sh --print-runtime)/device")"`
4. `sudo mount "$(cat "$(./prepare.sh --print-runtime)/device")" "$(./prepare.sh --print-runtime)/mnt"`
5. `findmnt "$(./prepare.sh --print-runtime)/mnt"`
6. `./verify.sh mounted`
7. `sudo umount "$(./prepare.sh --print-runtime)/mnt"`
8. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
