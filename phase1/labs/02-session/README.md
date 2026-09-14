# Lab 02 — Session / Login

## 目的

確認目前有哪些使用者登入系統、自己位於哪個 terminal，
以及如何辨識目前與歷史 session。

## Read

```bash
users
who
w
tty
last -n 10
lastlog
loginctl list-sessions
```

## 操作

開啟另一個 shell 或 SSH session。

例如：

```bash
ssh <user>@<host>
```

也可以直接開啟另一個 terminal，建立第二個登入環境。

## Verify

重新執行：

```bash
users
who
w
tty
loginctl list-sessions
```

確認：

- 新的使用者 / session 是否出現
- 新的 TTY 是否出現
- `w` 是否能看到新的登入狀態
- `loginctl list-sessions` 是否列出新的 session

## Delete / Logout

在新增的 shell / SSH session 中執行：

```bash
logout
```

或：

```bash
exit
```

## Verify again

回到原本的 shell，重新執行：

```bash
who
w
loginctl list-sessions
```

確認剛才新增的 session 已經消失。

## 操作故事

登入 Linux 主機後：

1. 用 `users` 看目前有哪些使用者在線。
2. 用 `who` 看誰從哪個 terminal、什麼時間登入。
3. 用 `w` 看目前登入者正在做什麼。
4. 用 `tty` 確認自己目前所在的 terminal。
5. 用 `last -n 10` 查看最近的登入與登出歷史。
6. 用 `lastlog` 查看各帳號最後一次登入時間。
7. 用 `loginctl list-sessions` 查看 systemd 目前管理中的 session。
8. 再開啟一個新的 shell / SSH session。
9. 重新執行查詢指令，確認新 session 出現。
10. 使用 `logout` 或 `exit` 結束 session。
11. 再次查詢，確認 session 已經消失。

## Command family

### Current login / session

```bash
users
who
w
tty
loginctl list-sessions
```

### Login history

```bash
last -n 10
lastlog
```

### Session lifecycle

```bash
ssh <user>@<host>
logout
exit
```

## 完成標準

完成此 Lab 後，應能回答：

- 現在有哪些使用者登入？
- 每個使用者在哪個 terminal？
- 他們什麼時候登入？
- 他們目前正在做什麼？
- 自己目前在哪個 TTY？
- 最近有哪些登入 / 登出紀錄？
- 某個帳號最後一次何時登入？
- systemd 目前管理哪些 session？
- 新增一個 session 後，要如何驗證它出現？
- logout / exit 後，要如何驗證它消失？
