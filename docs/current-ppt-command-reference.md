# Current PPT Command Reference

Scope: **Overview + Phase 1–8 command-family PPT set**

This document lists the command families, option variants, and common combinations that are already present in the current slide decks. It is intentionally limited to the current PPT content and does **not** include future Phase 9–11 material that has only been planned.

## Training flow

The current course uses commands inside a repeatable operational workflow:

```text
Machine Record
→ Baseline / Inventory
→ Operation / Change / Fault
→ Verify
→ Compare before vs after
→ Diagnose if needed
→ Rollback / Recovery
→ Reset
```

The goal is not to memorize isolated commands. Each command should answer an operational question and fit into a reproducible workflow.

## Lab control scripts

These are repository training scripts rather than Linux built-in commands.

| Script | Role | Training concept |
|---|---|---|
| `./prepare.sh` | Build controlled lab/scenario state | Prepare a reproducible environment |
| `./verify.sh` | Check expected state | Verify the target state |
| `./rollback.sh` | Return to pre-change state | Reversible change |
| `./reset.sh` | Return to initial lab state | Reproducible practice |
| `./baseline.sh` | Record before-state where used | Baseline / Machine Record |
| `./setup.sh` | Build phase-level environment where used | Environment setup |

---

# 1. Identity, login, host, and environment

| Command | Purpose | Current PPT examples | Scope |
|---|---|---|---|
| `whoami` | Show current effective user | `whoami` | Overview, P1–P8 |
| `id` | UID/GID and group identity | `id`, `id -u`, `id -g`, `id -G`, `id -nG`, `id reportapp` | Overview, P1–P8 |
| `groups` | Show group memberships | `groups` | Overview, P1–P8 |
| `who` | Show logged-in sessions | `who` | Overview, P7 |
| `w` | Show users and current activity | `w` | Overview, P7 |
| `last` | Login history | `last -n 20` | P7 |
| `pwd` | Show current working directory | `pwd` | P1–P8 |
| `date` | Record current time | `date` | P1–P8 |
| `hostnamectl` | Host identity / OS information | `hostnamectl` | Overview, P1–P8 |
| `uname` | Kernel / architecture information | `uname -a` | Overview, P1–P8 |
| `lscpu` | CPU information | `lscpu` | Overview |
| `getent` | Query NSS databases | `getent passwd reportapp`, `getent group report`, `getent group sudo` | Overview, P1–P8 |

# 2. Files, text processing, and state comparison

| Command | Purpose | Current PPT examples | Scope |
|---|---|---|---|
| `ls` | List files and permissions | `ls -la /data/report-app` | Overview, P1–P8 |
| `stat` | File metadata | `stat /etc/report-app/report-app.env` | Overview, P1–P8 |
| `cat` | Read text files | `cat /etc/os-release` | Overview, P1–P8 |
| `find` | Search files by type/name/permission/size | `find /data/report-app -type f -name '*.json'`, `find /data/report-app -perm -002`, `find /var/log -type f -size +100M` | Overview, P1–P8 |
| `grep` | Filter output and logs | `grep -nE 'error|fail|denied' app.log`, `grep -C 3 'Permission denied' app.log` | Overview, P1–P8 |
| `sed` | Show ranges / perform replacements | `sed -n '1,80p' file`, `sed -i.bak 's/PORT=8080/PORT=8081/' app.env` | Overview, P1–P8 |
| `awk` | Field processing / simple filtering | `awk '{print $1,$2,$3}' access.log`, `awk '$9 >= 500 {print}' access.log` | Overview, P1–P8 |
| `tail` | Follow logs / show trailing output | `tail -f /var/log/report-app/report-app.log` | Overview, P1–P8 |
| `mkdir` | Create record/lab directories | `mkdir -p ~/linux-training-records/phaseX/labXX` | Overview, P1–P8 |
| `cd` | Enter lab/scenario directories | `cd ~/linux-training/phaseX/...` | P1–P8 |
| `cp` | Copy configuration / files | `cp -a ...`, `sudo cp report-worker.service /etc/systemd/system/` | Overview, P3–P4 |
| `ln` | Create or switch symbolic links | `ln -sfn` | Overview |
| `diff` | Compare before/after or directory state | `diff -u before.txt after.txt || true`, `diff -r src/ dst/` | Overview, P1–P8 |
| `sha256sum` | Create / verify integrity hashes | `sha256sum report-001.json`, `sha256sum -c manifest.sha256` | Overview, P1–P8 |

## `grep` family currently represented

```bash
grep pattern file
grep -i pattern file
grep -n pattern file
grep -v pattern file
grep -E 'error|fail' file
grep -A 3 pattern file
grep -B 3 pattern file
grep -C 3 pattern file
```

Common combinations in the decks include filtering `journalctl`, `systemctl`, `ss`, and file/log output.

# 3. Disk, filesystem, mount, backup, and synchronization

| Command | Purpose | Current PPT examples | Scope |
|---|---|---|---|
| `lsblk` | Block devices and filesystems | `lsblk -f` | Overview, P1–P8 |
| `blkid` | UUID / label / filesystem metadata | `blkid` | Overview, P1–P8 |
| `findmnt` | Inspect mount points | `findmnt /data/report-app` | Overview, P1–P8 |
| `mount` | Inspect mount state | `mount | grep /data` | Overview, P1–P8 |
| `umount` | Unmount lab filesystems | `sudo umount /mnt/lab-disk` | Overview, P1–P8 |
| `df` | Capacity and inode usage | `df -h`, `df -i`, `df -h /data/report-app` | Overview, P1–P8 |
| `du` | Directory usage analysis | `du -xhd1 /data/report-app` | Overview, P1–P8 |
| `tar` | Inspect / extract archives | `tar -tf backup.tar.gz | head`, `tar -xf backup.tar.gz -C restore/` | Overview, P1–P8 |
| `rsync` | Sync, dry-run, restore, remote sync | `rsync -a --dry-run src/ dst/`, `rsync -a src/ dst/`, `rsync -a config/ app-01:/etc/report-app/` | Overview, P1–P8 |

# 4. Network, ports, HTTP, and remote access

| Command | Purpose | Current PPT examples | Scope |
|---|---|---|---|
| `ip` | Interfaces, addresses, routes, route lookup | `ip addr`, `ip link show`, `ip route`, `ip route get 8.8.8.8` | Overview, P1–P8 |
| `ss` | Listening sockets / socket summary | `ss -tulpn`, `ss -s`, `ss -tulpn | grep ':8080'` | Overview, P1–P8 |
| `curl` | HTTP health check and timing | `curl -v http://127.0.0.1:8080/health`, `curl -w ...` | Overview, P1–P8 |
| `ssh` | Remote execution in advanced/multi-host scenarios | `ssh "$h" 'hostname; df -h /; systemctl is-active report-app'` | Overview, P8 |

# 5. Process, service, logging, and performance

| Command | Purpose | Current PPT examples | Scope |
|---|---|---|---|
| `ps` | Process list / CPU sorting | `ps aux | grep report`, `ps aux --sort=-%cpu | head` | Overview, P1–P8 |
| `pgrep` | Find processes by name | `pgrep -a report-worker` | Overview, P1–P8 |
| `pstree` | Inspect process tree | `pstree -ap | grep report` | Overview, P1–P8 |
| `lsof` | Open files / process-port ownership | `lsof -p 1234`, `lsof -i :8080` | Overview, P1–P8 |
| `systemctl` | systemd service status/config/dependencies/restart | `systemctl status report-app`, `systemctl is-active report-app`, `systemctl is-enabled report-app`, `systemctl cat report-app`, `systemctl show -p ...`, `systemctl list-dependencies`, `systemctl daemon-reload`, `systemctl restart report-app` | Overview, P1–P8 |
| `journalctl` | systemd journal query / follow / priority / time filtering | `journalctl -u report-app`, `journalctl -xe`, `journalctl -f`, `journalctl --since '10 min ago'`, `journalctl -p warning..alert`, `journalctl -o short-iso` | Overview, P1–P8 |
| `dmesg` | Kernel messages | `dmesg | tail -n 50` | Overview, P1–P8 |
| `top` | Interactive process/resource view | `top` | Overview, P1–P8 |
| `uptime` | Uptime and load | `uptime` | Overview |
| `free` | RAM / swap summary | `free -h` | Overview, P6 |
| `vmstat` | CPU/memory/process sampling | `vmstat 1 5` | Overview, P6 |
| `iostat` | Disk I/O sampling | `iostat -xz 1 5` | P6 |

# 6. Packages, accounts, security, and advanced infrastructure

| Command | Purpose | Current PPT examples | Scope |
|---|---|---|---|
| `apt` | Debian/Ubuntu package information | `apt policy` | Overview |
| `dpkg` | Installed package queries | `dpkg -l | grep -E 'python|nginx|redis'` | Overview, P1 |
| `python3` | Runtime version check | `python3 --version` | Overview |
| `useradd` | Create service account | `sudo useradd -r -s /usr/sbin/nologin reportworker` | Overview, P3 |
| `groupadd` | Create groups | `groupadd` | Overview |
| `visudo` | Validate sudoers syntax | `visudo -c` | Overview |
| `sshd` | Inspect effective SSH daemon configuration | `sshd -T | grep -E 'permitrootlogin|passwordauthentication'` | Overview, P7 |
| `ufw` | Firewall status | `ufw status verbose` | P7 |
| `crontab` | User schedule inspection | `crontab -l` | Overview |
| `docker` | Container inspection | `docker ps`, `docker logs report-worker` | P8 |
| `ansible` | Multi-host / automation basics | `ansible all -m ping` | P8 |

# 7. Phase summary

| Phase | Main topic | Current command focus |
|---|---|---|
| Phase 1 | System takeover / normal inspection | identity, OS, disk, network, process, service, port, logs, baseline |
| Phase 2 | Troubleshooting and repair | reuse Phase 1 commands inside fault → diagnose → fix → verify |
| Phase 3 | Deployment and expansion | `useradd`, file deployment, systemd service setup and verification |
| Phase 4 | Production change management | package/config/release changes, before/after comparison, rollback |
| Phase 5 | Backup / restore / DR | `find`, `tar`, `rsync`, `sha256sum`, `diff`, restore verification |
| Phase 6 | Performance / capacity | `free`, `top`, `vmstat`, `iostat`, `ps`, `df`, `du`, `curl` timing |
| Phase 7 | Security / exposure management | `who`, `w`, `last`, `visudo`, `sshd -T`, permission search, `ufw`, service identity |
| Phase 8 | Advanced systems / infrastructure | `ssh`, remote `rsync`, `docker`, `ansible`, multi-host and automation |

# 8. Command-family design already present in the decks

## Identity

```bash
id
id -u
id -g
id -G
id -nG
```

The purpose is to separate effective identity, primary group, and supplementary groups instead of treating `id` as one opaque command.

## Service / log

The current decks treat `systemctl` and `journalctl` as command families rather than single commands.

Examples include:

```bash
systemctl status report-app
systemctl is-active report-app
systemctl is-enabled report-app
systemctl cat report-app
systemctl show -p ...
systemctl list-dependencies ...
systemctl daemon-reload
systemctl restart report-app
```

```bash
journalctl -u report-app
journalctl -xe
journalctl -f
journalctl --since '10 min ago'
journalctl -p warning..alert
journalctl -o short-iso
```

## Network

```bash
ip addr
ip link show
ip route
ip route get 8.8.8.8

ss -tulpn
ss -s
```

## Storage

The current storage family separates several different questions:

```text
lsblk    → what block devices/filesystems exist?
blkid    → what UUID/labels/filesystem metadata exist?
findmnt  → where/how is something mounted?
df       → how much filesystem capacity/inodes remain?
du       → where is space being consumed?
```

## Recovery and comparison

```text
tar       → archive contents / extraction
rsync     → synchronization / dry-run / restore
diff      → before-vs-after comparison
sha256sum → integrity verification
```

# 9. Not yet part of this current PPT command reference

This is a **current-coverage** document, not the final Linux command catalog.

The following topics have been discussed/planned but are not considered part of this Phase 1–8 PPT command reference until they are formally added to the corresponding decks:

- full SSH key workflow: `ssh-keygen`, `ssh-copy-id`, `ssh-agent`, `ssh-add`
- SFTP-focused workflow
- compression families such as `gzip`, `xz`, `zip`, `unzip`
- file encryption such as `gpg`, `openssl`, `age`
- full TLS / certificate / HTTPS command workflow
- Phase 9 Linux workstation commands
- Phase 10 multi-host administration commands
- Phase 11 production platform commands

# 10. Maintenance rule

Whenever a slide deck adds a new command family, update this document with:

1. the command family;
2. the options/combinations that are actually taught;
3. the first phase or phases where it appears.

This file can then serve as the course command coverage index and as a basis for Linux distribution, WSL, macOS, and Windows adaptation work.
