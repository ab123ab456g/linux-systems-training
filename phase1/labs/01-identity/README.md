# Lab 01 — Identity / Permission

使用 test user/group sandbox 練習身分、群組與 sudo 權限。

## Lab 共通操作流程

### 1. 進入 Lab

```bash
cd phase1/labs/01-identity
pwd
ls -l
```

### 2. 確認腳本可以執行

先查看權限：

```bash
ls -l *.sh
```

如果腳本沒有執行權限：

```bash
chmod +x prepare.sh
chmod +x verify.sh
chmod +x rollback.sh
chmod +x reset.sh
chmod +x ../00-course-usage/record.sh
```

也可以一次設定：

```bash
chmod +x *.sh
chmod +x ../00-course-usage/record.sh
```

再次確認：

```bash
ls -l *.sh
ls -l ../00-course-usage/record.sh
```

有 `x` 才能直接：

```bash
./prepare.sh
```

如果沒有設定 executable，也可以：

```bash
bash prepare.sh
```

### 3. Prepare

```bash
./prepare.sh
```

### 4. 記錄 Before

```bash
../00-course-usage/record.sh before
```

### 5. 依下方學習與操作順序手動操作

執行本 Lab 的 Linux 指令。

### 6. Verify

```bash
./verify.sh
```

特定狀態依本 Lab 規劃使用：

```bash
./verify.sh updated
./verify.sh deleted
```

### 7. 記錄 After

```bash
../00-course-usage/record.sh after
```

### 8. 比較差異

```bash
../00-course-usage/record.sh diff
```

### 9. 需要回到本次變更前

```bash
./rollback.sh
```

### 10. 要重新練習

```bash
./reset.sh
```

## 學習與操作順序

### 1. 確認目前身份

```bash
whoami
id
```

### 2. 拆解 UID / GID / Group

```bash
id -u
id -g
id -G
id -nG
groups
```

### 3. 確認 sudo 權限

```bash
sudo -l
```

### 4. 查看系統帳號與群組

```bash
getent passwd
getent group
```

### 5. 建立測試 Group

```bash
sudo groupadd phase1lab
getent group phase1lab
```

### 6. 建立測試 User

```bash
sudo useradd -m -s /bin/bash phase1user
id phase1user
getent passwd phase1user
```

### 7. 修改 Group Membership

```bash
sudo usermod -aG phase1lab phase1user
groups phase1user
id phase1user
getent group phase1lab
```

### 8. 驗證 Updated 狀態

```bash
./verify.sh updated
```

### 9. 刪除測試 User

```bash
sudo userdel -r phase1user
```

### 10. 刪除測試 Group

```bash
sudo groupdel phase1lab
```

### 11. 驗證 Deleted 狀態

```bash
./verify.sh deleted
```

## Command family

### Identity

```bash
whoami
id
id -u
id -g
id -G
id -nG
groups
sudo -l
```

### Account / Group Database

```bash
getent passwd
getent passwd USER
getent group
getent group GROUP
```

### User / Group

```bash
sudo groupadd GROUP
sudo useradd -m -s /bin/bash USER
sudo usermod -aG GROUP USER
sudo userdel -r USER
sudo groupdel GROUP
```

### Verify

```bash
id USER
groups USER
getent passwd USER
getent group GROUP
```

## Script / File Execution

查看權限：

```bash
ls -l FILE
```

增加執行權限：

```bash
chmod +x FILE
```

移除執行權限：

```bash
chmod -x FILE
```

直接執行 executable script：

```bash
./FILE.sh
```

指定 Bash 執行：

```bash
bash FILE.sh
```

確認腳本類型：

```bash
file FILE.sh
```

查看 shebang：

```bash
head -n 1 FILE.sh
```
