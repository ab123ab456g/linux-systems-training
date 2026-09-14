# Lab 04 — Hardware

讀取 CPU/RAM/PCI/USB，並以 loop device 作為虛擬硬體 sandbox。

## 建議操作順序

1. `lscpu`
2. `lsmem`
3. `lspci`
4. `lsusb`
5. `./prepare.sh`
6. `losetup -a`
7. `lsblk`
8. `./verify.sh attached`
9. `./reset.sh`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
