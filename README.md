# Phase 1 Linux Systems Training v2

這個 ZIP 是配合新版 Phase 1 PPT 規劃的可執行實驗包。

## 定位

- Lab 00：先學會整套 Lab 的使用方式。
- Lab 01–18：一個技術領域一個獨立 Lab。
- PPT 可以用 Chapter 把多個 Lab 組成同一個場景。
- PPT 不需要顯示 Create / Update / Delete / Verify 等 Matrix 標籤；Matrix 只用於教材 coverage 檢查。

## 重要安全假設

此套件預設在 **可重建的 Ubuntu / Debian VM** 上練習，部分 Lab 需要 `sudo` 與 systemd。
不要直接在 production server 上執行。

## 共通流程

```bash
cd phase1/labs/00-course-usage
./prepare.sh
./verify.sh
```

正式 Lab：

```bash
cd phase1/labs/XX-name
./prepare.sh
cat README.md
# 依 README 手動完成操作
./verify.sh <stage>
./rollback.sh    # 回到本次操作前 / 安全狀態
# 或
./reset.sh       # 回到 Lab 初始狀態
```

## Machine record

從任一 Lab 目錄可執行：

```bash
../../../common/scripts/record.sh phase1 01 before
../../../common/scripts/record.sh phase1 01 after
../../../common/scripts/record.sh phase1 01 diff
```

紀錄預設放在：

```text
~/linux-training-records/phase1/<lab>/
```

## Lab 列表

00 Course Usage  
01 Identity / Permission  
02 Session / Login  
03 OS / Kernel  
04 Hardware  
05 Disk / Mount  
06 Filesystem  
07 Network  
08 DNS  
09 Process  
10 Service  
11 Port / Socket  
12 Resource  
13 Log  
14 Package  
15 Schedule  
16 Environment  
17 Security / Firewall  
18 Report App / Final Handoff
