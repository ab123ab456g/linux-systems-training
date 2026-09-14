# Lab 03 — System Identification

## 目的

接手一台陌生 Linux 主機時，先辨識這台機器的基本資訊，
包含 hostname、Linux kernel、CPU 架構、發行版與部分 kernel runtime 參數。

接著實際修改 hostname，驗證修改成功，最後 rollback 回原本狀態。

---

## 操作故事

你剛登入一台陌生 Linux Server。

第一件事不是直接改設定，而是先確認：

- 這台機器叫什麼？
- 跑什麼 Linux？
- 使用哪個 kernel？
- CPU 架構是什麼？
- kernel 目前有哪些 runtime 設定？

確認完系統資訊後，再進行 hostname 修改。

修改前先保存原本 hostname，
修改完成後驗證，
最後 rollback，確認系統恢復到原本狀態。

整個流程：

```text
接手陌生主機
    ↓
確認 hostname / OS
    ↓
確認 kernel / architecture
    ↓
確認 Linux distribution
    ↓
查看 kernel runtime parameter
    ↓
保存原本 hostname
    ↓
修改 hostname
    ↓
驗證修改成功
    ↓
rollback
    ↓
驗證恢復成功
```

一句話記憶：

> 先認識機器，再改名字，確認改成功，最後恢復原狀。

---

## Read

### 1. 查看 hostname 與系統基本資訊

```bash
hostnamectl
```

主要查看：

- Static hostname
- Operating System
- Kernel
- Architecture

回答：

> 這台機器叫什麼？跑什麼系統？

---

### 2. 查看完整 kernel 資訊

```bash
uname -a
```

顯示：

- kernel name
- hostname
- kernel release
- kernel version
- architecture

---

### 3. 查看 CPU / system architecture

```bash
uname -m
```

常見結果：

```text
x86_64
aarch64
```

---

### 4. 查看 kernel release

```bash
uname -r
```

例如：

```text
6.8.0-xx-generic
```

---

### 5. 查看 Linux distribution

```bash
cat /etc/os-release
```

例如：

```text
NAME="Ubuntu"
VERSION="24.04 LTS"
ID=ubuntu
```

注意：

```text
uname
```

主要看 kernel。

```text
/etc/os-release
```

主要看 Linux distribution。

---

### 6. 查看 kernel runtime parameter

```bash
sysctl vm.swappiness
```

例如：

```text
vm.swappiness = 60
```

泛化形式：

```bash
sysctl <key>
```

例如：

```bash
sysctl kernel.hostname
sysctl vm.overcommit_memory
sysctl net.ipv4.ip_forward
```

---

## Prepare

查看 Lab 保存的原始 hostname：

```bash
cat "$(./prepare.sh --print-runtime)/original-hostname"
```

目的：

> 在修改 hostname 前，先知道原本值，方便 rollback。

---

## Update

修改 hostname：

```bash
sudo hostnamectl set-hostname phase1-lab-host
```

修改後可以再次查看：

```bash
hostnamectl
```

確認 hostname 是否已變更。

---

## Verify changed

執行：

```bash
./verify.sh changed
```

確認 hostname 已成功改成 Lab 指定值。

---

## Rollback

執行：

```bash
./rollback.sh
```

將 hostname 還原成實驗前的原始值。

---

## Verify restored

執行：

```bash
./verify.sh restored
```

確認 hostname 已恢復。

---

## 完整操作流程

```bash
hostnamectl
uname -a
uname -m
uname -r
cat /etc/os-release
sysctl vm.swappiness

cat "$(./prepare.sh --print-runtime)/original-hostname"

sudo hostnamectl set-hostname phase1-lab-host

./verify.sh changed

./rollback.sh

./verify.sh restored
```

---

## Command Family

### System identity

```bash
hostnamectl
uname -a
uname -m
uname -r
cat /etc/os-release
```

### Kernel runtime parameters

```bash
sysctl <key>
```

### Hostname update

```bash
hostnamectl set-hostname <name>
```

### Lab verification / rollback

```bash
./verify.sh changed
./rollback.sh
./verify.sh restored
```

---

## 流程對應

```text
Read
    hostnamectl
    uname
    cat /etc/os-release
    sysctl

Prepare
    original-hostname

Update
    hostnamectl set-hostname

Verify
    verify.sh changed

Rollback
    rollback.sh

Verify
    verify.sh restored
```

---

## 完成標準

完成此 Lab 後，應能回答：

- 這台主機目前叫什麼名字？
- 使用哪個 Linux distribution？
- 目前 kernel release 是什麼？
- CPU / system architecture 是什麼？
- `uname` 與 `/etc/os-release` 的差別是什麼？
- 如何讀取一個 kernel runtime parameter？
- 如何修改 hostname？
- 修改前如何保存原始狀態？
- 如何驗證 hostname 已修改成功？
- 如何 rollback？
- 如何確認 rollback 後已恢復原狀？
