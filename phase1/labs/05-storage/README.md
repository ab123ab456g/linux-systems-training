# Lab 06 — Filesystem

練習 Linux filesystem 的磁碟空間、inode、檔案 metadata、目錄使用量與 `find` 搜尋。

## 練習流程

```bash
./prepare.sh
```

取得 runtime：

```bash
RUNTIME="$(./prepare.sh --print-runtime)"
```

---

## 1. Filesystem 空間

查看磁碟容量：

```bash
df -h
```

查看 inode：

```bash
df -i
```

重點：

- `df -h`：filesystem 還有多少容量
- `df -i`：filesystem 還有多少 inode

---

## 2. Directory 使用量

查看目前目錄下一層的空間使用量：

```bash
du -xhd1 .
```

查看 Lab filesystem：

```bash
du -xhd1 "$RUNTIME/fs"
```

參數：

```text
-x    不跨 filesystem
-h    human-readable
-d1   只顯示下一層
```

---

## 3. File Listing

詳細列出檔案：

```bash
ls -l
```

包含隱藏檔：

```bash
ls -la
```

可查看：

```text
permission
owner
group
size
mtime
filename
```

---

## 4. File Metadata

查看檔案完整 metadata：

```bash
stat "$RUNTIME/fs/a.txt"
```

一般形式：

```bash
stat <file>
```

主要資訊：

```text
Size
Blocks
inode
permissions
owner
group
atime
mtime
ctime
```

---

## 5. Find Files

找所有普通檔案：

```bash
find . -type f
```

找所有目錄：

```bash
find . -type d
```

---

## 6. Find by Name

依名稱搜尋：

```bash
find . -name "a.txt"
```

使用 wildcard：

```bash
find . -name "*.txt"
```

---

## 7. Find by Permission

修改測試檔權限：

```bash
chmod 640 "$RUNTIME/fs/a.txt"
```

找權限為 `640` 的檔案：

```bash
find "$RUNTIME/fs" -type f -perm 640
```

找 Other 有 write 權限的檔案：

```bash
find . -type f -perm -002
```

`002`：

```text
other write permission
```

---

## 8. Find by Modification Time

最近一天內修改：

```bash
find . -type f -mtime -1
```

超過 7 天沒有修改：

```bash
find . -type f -mtime +7
```

---

## 9. Find by Size

找大於 1 MB 的檔案：

```bash
find . -type f -size +1M
```

例如大於 100 MB：

```bash
find . -type f -size +100M
```

---

# Complete Practice

```bash
./prepare.sh

RUNTIME="$(./prepare.sh --print-runtime)"

df -h
df -i

du -xhd1 "$RUNTIME/fs"

ls -l "$RUNTIME/fs"
ls -la "$RUNTIME/fs"

stat "$RUNTIME/fs/a.txt"

find "$RUNTIME/fs" -type f
find "$RUNTIME/fs" -type d

find "$RUNTIME/fs" -name "*.txt"

chmod 640 "$RUNTIME/fs/a.txt"

find "$RUNTIME/fs" -type f -perm 640
find "$RUNTIME/fs" -type f -perm -002

find "$RUNTIME/fs" -type f -mtime -1

find "$RUNTIME/fs" -type f -size +1M

./verify.sh changed

./reset.sh
```

# Command Family

```text
Filesystem
│
├── filesystem usage
│   ├── df -h
│   └── df -i
│
├── directory usage
│   └── du -xhd1
│
├── file listing
│   ├── ls -l
│   └── ls -la
│
├── metadata
│   └── stat
│
└── search
    └── find
        ├── -type f
        ├── -type d
        ├── -name
        ├── -perm
        ├── -mtime
        └── -size
```

# Troubleshooting Flow

```text
磁碟空間問題
    ↓
df -h

inode 問題
    ↓
df -i

哪個目錄太大
    ↓
du -xhd1 .

哪個檔案有問題
    ↓
find / ls -la

查看檔案詳細狀態
    ↓
stat
```

也就是：

```text
filesystem
    ↓
directory
    ↓
file
    ↓
metadata
```

## Completion Standard

完成後應能獨立操作：

```bash
df -h
df -i
du -xhd1 .
ls -l
ls -la
stat <file>

find . -type f
find . -type d
find . -name "*.txt"
find . -perm ...
find . -mtime ...
find . -size ...
```

並能回答：

1. 磁碟空間是否不足？
2. inode 是否不足？
3. 哪個目錄占用最多空間？
4. 如何取得檔案的 inode、權限、大小與時間？
5. 如何搜尋檔案或目錄？
6. 如何依名稱搜尋？
7. 如何依權限搜尋？
8. 如何依修改時間搜尋？
9. 如何搜尋大型檔案？
10. 如何找出 Other 可寫入的檔案？
