# Lab 14 — Package

建立兩個本地 .deb 版本，練習 install/upgrade/remove，不依賴網路。

## 建議操作順序

1. `./prepare.sh`
2. `sudo dpkg -i "$(./prepare.sh --print-runtime)/phase1-helper_1.0_all.deb"`
3. `phase1-helper`
4. `./verify.sh v1`
5. `sudo dpkg -i "$(./prepare.sh --print-runtime)/phase1-helper_1.1_all.deb"`
6. `./verify.sh v11`
7. `sudo dpkg -r phase1-helper`
8. `./verify.sh removed`

## Command family

請配合 PPT 該 Lab 後面的 command family 頁面，先做最小操作，再展開參數族。
