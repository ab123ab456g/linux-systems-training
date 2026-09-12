# Linux Systems Training

Hands-on, scenario-based Linux systems administration and infrastructure training from first machine inspection to troubleshooting, deployment, recovery, performance, security, automation, multi-host operations, containers, and Infrastructure as Code.

This repository keeps the same Linux server / Report System story across the course so that later phases reuse earlier skills instead of becoming isolated command exercises.

## Training Method

The main learning flow is:

```text
Environment
→ Machine Record
→ Baseline / Inventory
→ Understand one operational question
→ Run the relevant command
→ Read and interpret the output
→ Enter the lab / scenario
→ Change or fault
→ Verify
→ Diagnose if needed
→ Rollback / Recovery
→ Reset
→ Final Machine Record
```

The goal is not only to memorize commands. Each command should answer a concrete operational question and fit into a repeatable workflow.

## Platform Support

This project is **Linux-first**. The repository can be used from Linux, WSL2, and macOS, but the full system-administration course is designed around a real Linux environment.

| Platform | Support | Recommended use |
|---|---:|---|
| Linux VM / Linux host | Full | Complete Phase 1–8 course |
| WSL2 | High for user-space labs | Shell, packages, processes, services, networking, logs, scripting, and many Phase 1–7 exercises |
| macOS | Partial | Generic shell practice and repository use; run a Linux VM for the full course |

### Linux

Linux is the reference platform. A disposable VM with snapshots is recommended for labs involving systemd, storage, firewall rules, LVM, kernel modules, low-level networking, reboot behavior, or destructive changes.

### WSL2

WSL2 supports a large portion of the course, especially:

- Bash and shell scripting
- `grep`, `sed`, `awk`, `find`
- `apt`
- process inspection
- `systemctl` / `journalctl` when systemd is enabled
- `ip`, `ss`, `ssh`, `curl`
- package, service, environment, log, and troubleshooting labs

Some areas are environment-dependent or limited, including boot/reboot exercises, kernel modules, drivers, raw block devices, LVM, firewall semantics, bridges/VLAN/bonding, and hardware-oriented labs.

### macOS

macOS is Unix-like but is not GNU/Linux. Generic shell tools work well, but Linux-specific administration tools and service/storage/network models differ.

For the complete course, use macOS as the host and run an Ubuntu or other Linux VM.

### Command Equivalents

Some Linux tasks have functional equivalents on macOS, but they are **not exact one-to-one replacements**.

Examples:

| Linux | macOS equivalent | Notes |
|---|---|---|
| `systemctl` | `launchctl` | Different service models |
| `journalctl` | `log show`, `log stream` | Different logging systems |
| `apt` | `brew` | Different package ecosystems |
| `ip addr` | `ifconfig` | Different output/configuration model |
| `ip route` | `route -n get default`, `netstat -rn` | Routing syntax differs |
| `ss -tulpn` | `lsof -i`, `netstat` | Socket/process display differs |
| `lsblk` | `diskutil list` | Device model differs |
| `blkid` | `diskutil info` | Filesystem metadata differs |
| `findmnt` | `mount` | Not a direct equivalent |
| `nft`, `ufw` | `pfctl` | Firewall models differ |
| `systemd timer` | `launchd` | Scheduler model differs |

GNU and BSD/macOS versions of commands such as `sed`, `stat`, `date`, `ps`, `find`, and `xargs` may also use different flags.

See [`docs/platform-compatibility.md`](docs/platform-compatibility.md) for the detailed compatibility guide, command substitutions, GNU/BSD differences, and recommended platform strategy.

## Command Families

The slide decks teach common command families and option variants instead of showing only the base command.

Examples:

```bash
id
id -u
id -g
id -G
id -nG
```

```bash
grep pattern file
grep -i pattern file
grep -n pattern file
grep -v pattern file
grep -E 'error|fail' file
grep -A 3 -B 3 pattern file
```

Other command families include:

- `systemctl` / `journalctl`
- `ip` / `ss`
- `df` / `du` / `lsblk` / `findmnt` / `blkid`
- `ps` / `pgrep` / `lsof`
- `grep` / `sed` / `awk`
- `tar` / `rsync` / `diff` / `sha256sum`

The course introduces these variants in context and then combines them into larger inspection and troubleshooting workflows.

## Phase Overview

| Phase | Topic | Core question |
|---|---|---|
| Phase 1 | System takeover and inspection | What is the current state of this Linux system? |
| Phase 2 | Troubleshooting and repair | What is broken, where is it broken, and how do I fix it? |
| Phase 3 | Deployment and expansion | How do I safely add a new service? |
| Phase 4 | Production change management | How do I change a running system safely? |
| Phase 5 | Backup, restore, and disaster recovery | How do I recover trustworthy system state? |
| Phase 6 | Performance and capacity planning | Why is the system slow, and how much load can it handle? |
| Phase 7 | Security hardening and exposure management | What is unnecessarily exposed or over-privileged? |
| Phase 8 | Advanced infrastructure operations | How do I scale single-host administration into automation, multi-host, containers, and IaC? |

## Phase 1 — System Takeover

Establish a trustworthy normal-state baseline before changing anything.

Coverage includes identity and sudo, sessions, OS/kernel/hardware, disks/filesystems/mounts, networking/DNS, processes/services/ports, resources, logs, packages, schedules, environment, firewall, and Report App verification.

Primary output: a reproducible Machine Record and baseline.

## Phase 2 — Troubleshooting and Repair

Controlled faults are injected into the same environment.

```text
Detect
→ Inspect
→ Isolate
→ Fix
→ Verify
→ Rollback
```

## Phase 3 — Deployment and Expansion

Deploy an additional Report Worker while the original Report App remains available. Coverage includes users/groups, packages, directories, storage, networking, DNS, systemd, ports, environment variables, schedules, logs, firewall rules, startup, verification, and recovery.

## Phase 4 — Production Change Management

```text
Observe
→ Plan
→ Backup
→ Change
→ Verify
→ Monitor
→ Rollback if needed
```

Practice controlled changes such as package updates, application upgrades, configuration, permissions, services, ports, firewall, DNS/network, schedules, environment variables, limits, backup/restore, credential rotation, and reload/restart operations.

## Phase 5 — Backup, Restore, and Disaster Recovery

```text
Assess
→ Select recovery point
→ Protect current state
→ Restore
→ Verify
→ Failback
```

Recover files, configuration, application, service, data, and infrastructure state from trustworthy recovery points.

## Phase 6 — Performance and Capacity Planning

Build baselines, measure workload behavior, isolate bottlenecks, tune safely, compare before/after results, and estimate capacity.

Coverage includes CPU, RAM, disk usage/I/O, network throughput/latency, service response time, processes/threads, file descriptors, sockets, resource limits, stress testing, capacity forecasting, and scale-up/scale-out decisions.

## Phase 7 — Security Hardening

Audit the current attack surface and reduce unnecessary exposure without breaking required services.

Coverage includes login sessions, sudo, users/groups, permissions, SUID/SGID, SSH, ports/services, firewall, interface exposure, authentication failures, service accounts, secrets, credentials, keys, security updates, and continuous baseline monitoring.

## Phase 8 — Advanced Infrastructure Operations

Extend the previous skills from one host into infrastructure operations.

Coverage includes automation/scheduling, account lifecycle governance, data migration, release/rollout workflows, boot/shutdown dependencies, remote and multi-host operations, containers, advanced storage/networking, kernel/driver management, specialized services such as Nginx/PostgreSQL/Redis, and Infrastructure as Code.

## Slide Decks

`ppt/` contains the overview and Phase 1–8 teaching decks.

Each phase contains 60+ slides and follows the same practical structure:

```text
Phase context
→ Environment setup
→ Machine Record
→ Baseline
→ Command explanation
→ Command-family variants
→ Lab steps
→ Output interpretation
→ Verify
→ Fault/change
→ Diagnose
→ Rollback
→ Reset
→ Final record
```

Page count may exceed 60 when command families or practical scenarios need more space.

## Repository Structure

```text
linux-systems-training/
├── common/          # shared Report App / Worker / helper scripts
├── docs/            # phase notes, platform guide, matrix coverage
├── packages/        # controlled training package assets
├── phase1/ ... phase8/
├── ppt/             # overview + Phase 1–8 slide decks
├── runtime/         # generated lab state; ignored by Git
├── tests/           # automated shell test suite
└── tools/           # helper utilities
```

## Lab Script Convention

Scenario directories may contain:

```text
prepare.sh
inventory.sh
measure.sh
fault.sh
verify.sh
rollback.sh
failback.sh
reset.sh
```

- `prepare.sh` — create the controlled training state
- `inventory.sh` / `measure.sh` — inspect or record current state
- `fault.sh` — inject a controlled training fault
- `verify.sh` — check expected state
- `rollback.sh` — return to the state before the current change
- `failback.sh` — restore the previous production/recovery state
- `reset.sh` — return the lab to its initial training state

`verify`, `rollback`, and `reset` are intentionally separate concepts. Students should first understand and manually inspect the state before using helper scripts as automated acceptance/recovery tools.

## Automated Tests

Run the shell test suite with:

```bash
bash tests/test-all.sh
```

Useful individual checks include:

```bash
bash tests/test-structure.sh
bash tests/test-syntax.sh
bash tests/test-phase1.sh
bash tests/test-phase8.sh
bash tests/test-scenarios.sh
bash tests/test-rollback.sh
bash tests/test-idempotency.sh
```

The automated test harness uses the repository's safe training/runtime model. Real destructive administration exercises should be performed only in a disposable VM or intentionally prepared lab environment.

## Public Repository Safety

Do not commit real credentials or private machine information, including real `.env` secrets, private SSH keys, API tokens/passwords, generated runtime state, local Machine Records containing sensitive host/IP information, or transient logs/test outputs.

Use fake or training-only credentials in public examples.

## License

This repository uses dual licensing:

- **Source code, shell scripts, and software-oriented files:** MIT License — see [`LICENSE`](LICENSE).
- **Educational content, Markdown documentation, slide decks, DOCX materials, diagrams, exercises, and course content:** Creative Commons Attribution 4.0 International (CC BY 4.0) — see [`LICENSE-CONTENT.md`](LICENSE-CONTENT.md).

The software is permissively reusable under MIT, while the teaching material may be shared, adapted, and used commercially with appropriate attribution.
