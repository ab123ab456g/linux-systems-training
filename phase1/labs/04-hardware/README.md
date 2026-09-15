# Lab 04 — Hardware Inspection + Manual Device Attach

## 目的

接手一台 Linux 主機後，先辨識目前可見的硬體與裝置：

- CPU
- Memory
- PCI
- USB
- Block Device
- Kernel hardware message
- Loop Device

接著不只「看」，還要**手動建立一個測試 image file 並掛成 loop device**，
觀察 Linux 如何出現新的 block device，
最後再手動 detach 並清理。

---

## 操作故事

你登入一台陌生 Linux 主機。

先盤點：

```text
CPU 是什麼？
Memory 有多少？
PCI / USB 有哪些裝置？
Linux 現在有哪些 block device？
Kernel 最近看到了什麼？
```

接著自己製造一個裝置變化：

```text
用 dd 建立 image file
    ↓
把它 attach 成 loop device
    ↓
確認 /dev/loopX 出現
    ↓
用 lsblk / losetup 驗證
    ↓
detach
    ↓
確認裝置消失
    ↓
刪除測試 image
```

一句話記憶：

> 先看硬體，再用 dd 做一顆假的磁碟，掛上去、驗證、最後拆掉。

---

# Part 1 — Read / Inspect

## CPU

```bash
lscpu
```

查看：

- Architecture
- CPU 數量
- Core / Thread
- Model name
- Virtualization
- Cache

---

## Memory

```bash
lsmem
```

查看 Linux kernel 目前辨識到的 memory block。

---

## PCI Device

```bash
lspci
```

查看 PCI bus 上有哪些裝置。

進一步查看 driver：

```bash
lspci -k
```

查看：

- Kernel driver in use
- Kernel modules

---

## USB Device

```bash
lsusb
```

查看目前 USB bus 上的裝置。

---

## Block Device

```bash
lsblk
```

查看：

- disk
- partition
- loop device
- CD-ROM
- mount point

---

## Kernel Hardware Message

```bash
dmesg | tail -n 50
```

需要完整資訊時：

```bash
dmesg
```

用來查看：

- device detection
- driver loading
- attach / detach
- hardware error

---

## Existing Loop Devices

```bash
losetup -a
```

確認目前有哪些 loop device。

---

# Part 2 — Manual Create / Attach

## 1. 用 dd 建立測試 image file

建立一個 64 MiB 的 image file：

```bash
dd if=/dev/zero of=/tmp/lab04-loop.img bs=1M count=64 status=progress
```

參數：

```text
if=/dev/zero
→ input file，輸入來源，不斷提供 0

of=/tmp/lab04-loop.img
→ output file，輸出檔案

bs=1M
→ 每個 block 寫 1 MiB

count=64
→ 寫入 64 個 block

status=progress
→ 顯示寫入進度
```

結果：

```text
1 MiB × 64 = 64 MiB
```

確認檔案：

```bash
ls -lh /tmp/lab04-loop.img
```

這時它仍然只是普通檔案，還不是 block device。

---

## 2. 手動 attach 成 loop device

執行：

```bash
sudo losetup --find --show /tmp/lab04-loop.img
```

例如輸出：

```text
/dev/loop8
```

這表示 Linux 把：

```text
/tmp/lab04-loop.img
```

映射成：

```text
/dev/loop8
```

---

## 3. Verify — 確認裝置出現

查看 loop device：

```bash
losetup -a
```

查看 block device：

```bash
lsblk
```

也可以只查看剛建立的裝置：

```bash
lsblk /dev/loop8
```

實際裝置編號以：

```bash
sudo losetup --find --show /tmp/lab04-loop.img
```

輸出為準。

---

## 4. 查看 device node

例如：

```bash
ls -l /dev/loop8
```

確認 `/dev/loop8` 是 block device node。

---

## 5. 查看 kernel message

```bash
dmesg | tail -n 50
```

觀察 attach 前後 kernel 是否有相關裝置訊息。

---

# Part 3 — Manual Detach / Delete

## 1. Detach loop device

假設剛才建立的是：

```text
/dev/loop8
```

執行：

```bash
sudo losetup -d /dev/loop8
```

---

## 2. Verify detached

```bash
losetup -a
lsblk
```

確認剛才的 loop device 已不再對應測試 image。

---

## 3. Delete test image

```bash
rm /tmp/lab04-loop.img
```

確認：

```bash
ls -l /tmp/lab04-loop.img
```

應該顯示檔案不存在。

---

# Part 4 — Lab Script Version

除了手動操作，也可以跑教材提供的自動流程。

## Prepare

```bash
./prepare.sh
```

Lab 自動建立並 attach 測試 loop device。

---

## Verify

```bash
losetup -a
lsblk
dmesg | tail -n 50
./verify.sh attached
```

---

## Reset

```bash
./reset.sh
```

再驗證：

```bash
losetup -a
lsblk
```

---

# 完整手動操作流程

```bash
lscpu
lsmem
lspci
lspci -k
lsusb
lsblk
dmesg | tail -n 50
losetup -a

dd if=/dev/zero of=/tmp/lab04-loop.img bs=1M count=64 status=progress
ls -lh /tmp/lab04-loop.img

sudo losetup --find --show /tmp/lab04-loop.img

losetup -a
lsblk
ls -l /dev/loopX
dmesg | tail -n 50

sudo losetup -d /dev/loopX

losetup -a
lsblk

rm /tmp/lab04-loop.img
```

> `/dev/loopX` 要換成 `losetup --find --show` 實際輸出的裝置名稱。

---

# Command Family

## Hardware Inspection

```bash
lscpu
lsmem
lspci
lspci -k
lsusb
```

## Block Device

```bash
lsblk
```

## Kernel Hardware Message

```bash
dmesg
dmesg | tail -n 50
```

## Loop Device

```bash
losetup
losetup -a
losetup --find --show <file>
losetup -d <loop-device>
```

## Image File

```bash
dd if=/dev/zero of=<file> bs=<size> count=<count>
ls -lh <file>
rm <file>
```

---

# 流程對應

```text
Read
    lscpu
    lsmem
    lspci
    lspci -k
    lsusb
    lsblk
    dmesg
    losetup -a

Create
    dd

Attach
    losetup --find --show

Verify
    losetup -a
    lsblk
    ls -l /dev/loopX
    dmesg

Detach
    losetup -d

Delete
    rm

Verify restored
    losetup -a
    lsblk
```

---

# 完成標準

完成後應能回答：

- CPU 怎麼查？
- Memory 怎麼查？
- PCI / USB 裝置怎麼查？
- PCI 裝置使用哪個 driver？
- block device 怎麼查？
- kernel hardware message 怎麼查？
- loop device 是什麼？
- `dd` 如何建立固定大小的 image file？
- 普通 image file 如何變成 `/dev/loopX`？
- 如何驗證 loop device 已 attach？
- 如何 detach loop device？
- 如何確認 detach 成功？
- `prepare.sh` 與手動 `dd + losetup` 的差別是什麼？

---

# 本 Lab 核心

```text
看硬體
→ lscpu / lsmem / lspci / lsusb

看 Linux 裝置
→ lsblk

看 kernel
→ dmesg

建立測試 image
→ dd

手動掛成 block device
→ losetup --find --show

驗證
→ losetup -a / lsblk

拆掉
→ losetup -d

清理
→ rm
```
