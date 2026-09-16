# Lab 05 — Disk / Mount

使用 image + loop device 練習 block device、filesystem、mount，以及磁碟容量與掛載狀態的基本檢查。

---

## 學習目標

完成本 Lab 後，應能依照情境完成以下工作：

- 查看目前的 block device 與 partition
- 查看 filesystem、UUID 與 mount point
- 確認指定目錄是否已掛載
- 查看磁碟容量與 inode 使用量
- 查看目錄空間占用
- 建立 image file
- 將 image 映射成 loop device
- 建立 filesystem
- mount / umount filesystem
- 驗證掛載結果
- 清理 loop device 與暫存環境

---

## 建議操作順序

1. `./prepare.sh`
2. `cat "$(./prepare.sh --print-runtime)/device"`
3. `sudo mkfs.ext4 -F "$(cat "$(./prepare.sh --print-runtime)/device")"`
4. `sudo mount "$(cat "$(./prepare.sh --print-runtime)/device")" "$(./prepare.sh --print-runtime)/mnt"`
5. `findmnt "$(./prepare.sh --print-runtime)/mnt"`
6. `./verify.sh mounted`
7. `sudo umount "$(./prepare.sh --print-runtime)/mnt"`
8. `./reset.sh`

---

# Command Family

先理解每一組指令是在回答什麼問題，再練習參數。

## 1. Block Device / Filesystem 資訊

### `lsblk`

查看目前系統中的 block device、partition 與掛載關係。

```bash
lsblk
```

### `lsblk -f`

查看 block device 對應的 filesystem、UUID、label 與 mount point。

```bash
lsblk -f
```

### `blkid`

查看 block device 的 filesystem type、UUID 等資訊。

```bash
sudo blkid
```

### 這一組回答的問題

```text
現在有哪些磁碟 / partition？
它們是什麼 filesystem？
UUID 是什麼？
目前掛在哪裡？
```

---

## 2. Mount 狀態檢查

### `findmnt`

查看目前 filesystem 的掛載關係。

```bash
findmnt
```

### 查指定掛載點

```bash
findmnt /data/report-app
```

用來確認 `/data/report-app` 是否真的有 filesystem 掛載在上面。

### `mount`

列出目前 mount 狀態。

```bash
mount
```

### 搭配 `grep` 查特定路徑

```bash
mount | grep /data
```

### 這一組回答的問題

```text
這個 filesystem 有沒有 mount？
它 mount 到哪裡？
/data 底下有哪些掛載？
```

---

## 3. 磁碟容量與 inode

### `df -h`

查看 filesystem 的容量與剩餘空間，使用人類易讀格式。

```bash
df -h
```

### `df -i`

查看 inode 使用量。

```bash
df -i
```

### `du -xhd1`

查看目前目錄下一層各目錄的空間占用，限制在同一 filesystem。

```bash
du -xhd1
```

也可以指定路徑：

```bash
sudo du -xhd1 /data
```

### 這一組回答的問題

```text
磁碟空間是不是滿了？      -> df -h
inode 是不是用完了？       -> df -i
是哪個目錄吃掉空間？       -> du -xhd1
```

---

## 4. 建立 Image File

### `dd`

建立固定大小的 image file。

例如建立 100 MiB：

```bash
dd if=/dev/zero of=disk.img bs=1M count=100
```

確認：

```bash
ls -lh disk.img
```

### 注意

不要只寫：

```bash
dd if=/dev/zero of=disk.img
```

因為沒有指定 `count`，會持續寫入直到被中止或儲存空間耗盡。

---

## 5. Image -> Loop Device

### 建立 loop device

```bash
sudo losetup --find --show disk.img
```

輸出可能類似：

```text
/dev/loop13
```

### 查看目前 loop device

```bash
losetup -a
```

### 移除 loop device

```bash
sudo losetup -d /dev/loop13
```

### 這一層的概念

```text
disk.img
   ↓ losetup
/dev/loop13
```

普通檔案經過 loop device 映射後，可以當成 block device 操作。

---

## 6. 建立 Filesystem

### `mkfs`

在 block device 上建立 filesystem。

本 Lab 使用 ext4：

```bash
sudo mkfs.ext4 -F /dev/loop13
```

完成後可以確認：

```bash
lsblk -f
sudo blkid /dev/loop13
```

流程：

```text
image file
   ↓
loop device
   ↓
filesystem
```

---

## 7. Mount Filesystem

先建立 mount point：

```bash
sudo mkdir -p /mnt/lab
```

掛載：

```bash
sudo mount /dev/loop13 /mnt/lab
```

驗證：

```bash
findmnt /mnt/lab
lsblk -f
mount | grep /mnt/lab
```

必要時也可以檢查容量：

```bash
df -h /mnt/lab
```

---

## 8. Umount 與清理

先卸載 filesystem：

```bash
sudo umount /mnt/lab
```

驗證已卸載：

```bash
findmnt /mnt/lab
```

再移除 loop device：

```bash
sudo losetup -d /dev/loop13
```

確認：

```bash
losetup -a
lsblk
```

---

# 完整手動流程

以下是不依賴 Lab script 時，可以自己完整跑一次的版本。

```bash
# 1. 建立 100 MiB image

dd if=/dev/zero of=disk.img bs=1M count=100

# 2. image -> loop device

sudo losetup --find --show disk.img

# 假設輸出 /dev/loop13

# 3. 建立 ext4 filesystem

sudo mkfs.ext4 -F /dev/loop13

# 4. 建立 mount point

sudo mkdir -p /mnt/lab

# 5. mount

sudo mount /dev/loop13 /mnt/lab

# 6. verify

lsblk -f
sudo blkid /dev/loop13
findmnt /mnt/lab
df -h /mnt/lab

# 7. umount

sudo umount /mnt/lab

# 8. detach loop device

sudo losetup -d /dev/loop13

# 9. final verify

findmnt /mnt/lab
losetup -a
lsblk
```

---

# 核心流程圖

```text
查看系統
lsblk / lsblk -f / blkid
        ↓
建立 image
dd
        ↓
建立 block device
losetup
        ↓
建立 filesystem
mkfs.ext4
        ↓
掛載
mount
        ↓
驗證
findmnt / lsblk -f / blkid / df
        ↓
卸載
umount
        ↓
移除 loop device
losetup -d
```

---

# Troubleshooting 基本判斷

## 情境 1：不知道裝置名稱

```bash
lsblk
losetup -a
```

## 情境 2：不知道 filesystem 類型

```bash
lsblk -f
sudo blkid
```

## 情境 3：不知道有沒有 mount

```bash
findmnt
findmnt /data/report-app
mount | grep /data
```

## 情境 4：磁碟空間不足

```bash
df -h
sudo du -xhd1 /data
```

## 情境 5：容量看起來還有，但不能建立新檔

```bash
df -i
```

## 情境 6：要安全移除 loop device

```bash
sudo umount /mnt/lab
sudo losetup -d /dev/loop13
```

順序為：

```text
umount
   ↓
losetup -d
```

---

# 第一輪複習最小集合

先確定下面這些指令可以依照情境主動叫出來：

```bash
lsblk
lsblk -f
blkid
findmnt
df -h
df -i
du -xhd1
dd
losetup
mkfs.ext4
mount
umount
```

不需要第一輪就背完所有參數；先掌握「什麼情境用哪一組 command family」，再逐步增加參數與故障情境。
