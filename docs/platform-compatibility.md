# Platform Compatibility

This project is Linux-first. The repository, documentation, shell exercises, and many command-line labs can be used from Linux, WSL2, or macOS, but the full system-administration course is designed around a real Linux environment.

## Support Summary

| Platform | Support level | Recommended use |
|---|---|---|
| Linux VM / Linux host | Full | Complete course, including systemd, storage, networking, security, recovery, kernel, and infrastructure labs |
| WSL2 | High for user-space labs | Shell, package, process, service, networking, logs, scripting, and many Phase 1–7 exercises |
| macOS | Partial | Generic shell practice and repository usage; use a Linux VM for the full course |

A disposable Linux VM is the recommended reference environment because some labs intentionally modify system state, services, storage, networking, firewall rules, or boot behavior.

## Linux

Linux is the primary target platform and is the only environment expected to support the complete course without conceptual substitution.

Examples of Linux-native tools used throughout the course include:

- `systemctl`, `journalctl`
- `apt`
- `ip`, `ss`
- `lsblk`, `blkid`, `findmnt`, `losetup`
- `mount`, `umount`, LVM tools
- `nft`, `ufw`
- `modprobe`, `lsmod`, `sysctl`
- systemd timers and service units

For destructive or low-level labs, prefer a VM with snapshots.

## WSL2

WSL2 runs a real Linux userspace and supports a large portion of the training material.

Usually suitable for:

- Bash and shell scripting
- `grep`, `sed`, `awk`, `find`
- `apt`
- process inspection
- `systemctl` / `journalctl` when systemd is enabled
- `ip`, `ss`, `ssh`, `curl`
- package, service, environment, log, and many troubleshooting labs

Environment-dependent or limited areas include:

- boot and reboot sequence exercises
- kernel modules and drivers
- raw block-device work
- LVM
- some loop-device and mount behavior
- nftables / firewall behavior
- bridges, VLANs, bonding, and low-level network topology
- hardware-oriented exercises

WSL2 is excellent for daily command-line practice, but a Linux VM is recommended for the complete Phase 5–8 path and any lab that depends on real boot, kernel, block-device, or network-isolation behavior.

## macOS

macOS is Unix-like, but it is not GNU/Linux. Many generic shell tools are available, while Linux-specific administration tools are absent or use different system models.

Useful directly on macOS:

- `bash` / `zsh`
- `grep`
- `awk`
- `find`
- `tar`
- `ssh`
- `curl`
- `git`

Some commands exist but use BSD/macOS behavior rather than GNU behavior, so options may differ:

- `sed`
- `stat`
- `date`
- `ps`
- `find`
- `xargs`

For the full course, use macOS as the host and run an Ubuntu or other Linux VM using UTM, VMware Fusion, Parallels, or another virtualization platform.

## Functional Command Equivalents

The following table provides navigation equivalents for learners moving between Linux and macOS.

> These are functional equivalents for learning and orientation, not exact one-to-one replacements. The service manager, logging system, firewall model, networking stack, and storage tools differ between Linux and macOS.

| Linux command / role | macOS equivalent | WSL2 | Notes |
|---|---|---|---|
| `systemctl` | `launchctl` | Usually supported with systemd enabled | Different service models |
| `journalctl` | `log show`, `log stream` | Usually supported with systemd enabled | Different logging models |
| `apt` | `brew` | Supported | Package ecosystems differ |
| `ip addr` | `ifconfig` | Supported | Output and configuration model differ |
| `ip route` | `route -n get default`, `netstat -rn` | Supported | Routing syntax differs |
| `ss -tulpn` | `lsof -i`, `netstat` | Supported | PID/process visibility differs |
| `lsblk` | `diskutil list` | Environment-dependent | Device model differs |
| `blkid` | `diskutil info` | Environment-dependent | Filesystem metadata differs |
| `findmnt` | `mount` | Usually supported | Less direct on macOS |
| `mount` / `umount` | `mount` / `umount`, `diskutil` | Usually supported | Device handling differs |
| `nft`, `ufw` | `pfctl` | Environment-dependent | Firewall models are not equivalent |
| `systemd timer` | `launchd` calendar/interval jobs | Supported with systemd | Scheduler model differs |
| `modprobe`, `lsmod` | no direct equivalent | Limited | Kernel-extension model differs |
| `lspci` | `system_profiler` / `ioreg` | Limited | Hardware inspection model differs |
| `lsusb` | `system_profiler SPUSBDataType` | Limited | Hardware visibility differs |
| `hostnamectl` | `scutil --get ComputerName`, `hostname` | Supported | Hostname management differs |

## Common GNU/BSD Differences

Do not assume the same flags work on both Linux and macOS.

Examples:

### `sed`

Linux/GNU examples may use:

```bash
sed -i 's/old/new/' file.txt
```

macOS/BSD `sed` typically requires a backup-suffix argument:

```bash
sed -i '' 's/old/new/' file.txt
```

### `stat`

Linux:

```bash
stat -c '%U %G %a %n' file.txt
```

macOS:

```bash
stat -f '%Su %Sg %Lp %N' file.txt
```

### `date`

GNU `date` and BSD `date` use different flags for parsing and date arithmetic. For course labs that depend on exact GNU behavior, run the command inside Linux rather than translating it blindly.

## Recommended Platform Strategy

```text
Linux host
└─ Linux VM or disposable lab machine
   └─ Full course

Windows
└─ WSL2
   ├─ Most command-line and user-space labs
   └─ Linux VM for low-level / destructive labs

macOS
└─ Linux VM
   └─ Full course
```

The course remains Linux-first. Platform equivalents are provided to help learners navigate familiar tasks on macOS or WSL2 without changing the Linux administration concepts taught by the main curriculum.
