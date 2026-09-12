# Linux Systems Training

Hands-on, scenario-based Linux systems administration and infrastructure training from first machine inspection to troubleshooting, deployment, recovery, performance, security, automation, multi-host operations, containers, and Infrastructure as Code.

This repository intentionally keeps the same Linux server / Report System story across the course so that later phases reuse earlier skills instead of becoming isolated command exercises.

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

## Command Families

The slide decks also teach common command families and option variants instead of showing only the base command.

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

Start from a normal Linux machine and establish a trustworthy baseline before changing anything.

Coverage includes:

- identity, UID/GID, groups, sudo
- sessions and login history
- OS, kernel, hostname, architecture
- CPU, memory, PCI, USB, storage hardware
- disks, filesystems, mounts, UUID and labels
- interfaces, addresses, routes, DNS
- processes, services, ports, sockets
- CPU / RAM / disk resource state
- logs, packages, schedules and environment
- firewall and basic security state
- Report App verification

Primary output: a reproducible Machine Record and normal-state baseline.

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

Scenarios cover permissions, hardware, storage, filesystem, network, DNS, processes, services, ports, resources, logs, packages, schedules, environment, and firewall failures.

## Phase 3 — Deployment and Expansion

Deploy an additional Report Worker while the original Report App remains available.

Coverage includes users/groups, packages, directories, storage, networking, DNS, systemd, ports, environment variables, schedules, logs, firewall rules, startup, verification, and recovery.

## Phase 4 — Production Change Management

Practice controlled changes on a running system.

```text
Observe
→ Plan
→ Backup
→ Change
→ Verify
→ Monitor
→ Rollback if needed
```

Examples include package updates, application upgrades, configuration changes, permissions, service settings, ports, firewall, DNS/network, schedules, environment variables, limits, cleanup, backup/restore, credential rotation, and reload/restart operations.

## Phase 5 — Backup, Restore, and Disaster Recovery

Recover files, configuration, application, service, data, and infrastructure state from trustworthy recovery points.

```text
Assess
→ Select recovery point
→ Protect current state
→ Restore
→ Verify
→ Failback
```

## Phase 6 — Performance and Capacity Planning

Build baselines, measure workload behavior, isolate bottlenecks, tune safely, compare before/after results, and estimate capacity.

Coverage includes CPU, RAM, disk usage, disk I/O, network throughput/latency, service response time, processes/threads, file descriptors, sockets, resource limits, stress testing, capacity forecasting, and scale-up / scale-out decisions.

## Phase 7 — Security Hardening

Audit the current attack surface and reduce unnecessary exposure without breaking required services.

Coverage includes login sessions, sudo, users/groups, permissions, SUID/SGID, SSH, ports/services, firewall, interface exposure, authentication failures, service accounts, secrets, credentials, keys, security updates, and continuous baseline monitoring.

## Phase 8 — Advanced Infrastructure Operations

Extend the previous skills from one host into infrastructure operations.

Coverage includes:

- automation and scheduling
- account lifecycle governance
- data migration
- release / rollout workflows
- boot and shutdown dependencies
- remote and multi-host operations
- containers
- advanced storage and networking
- kernel and driver management
- Nginx / PostgreSQL / Redis style specialized services
- Infrastructure as Code / multi-host automation

## Slide Decks

`ppt/` contains the course slide decks for the overview and Phase 1–8.

The current decks are designed as practical teaching material rather than short summaries. Each phase contains 60+ slides and follows the same general learning structure:

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

Page count is allowed to exceed 60 when command families or practical scenarios need more space.

## Repository Structure

```text
linux-systems-training/
├── common/          # shared Report App / Worker / helper scripts
├── docs/            # phase notes and matrix coverage documents
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

Typical meaning:

- `prepare.sh` — create the controlled training state
- `inventory.sh` / `measure.sh` — inspect or record current state
- `fault.sh` — inject a controlled training fault
- `verify.sh` — check expected state
- `rollback.sh` — return to the state before the current change
- `failback.sh` — restore the previous production/recovery state
- `reset.sh` — return the lab to its initial training state

`verify`, `rollback`, and `reset` are intentionally separate concepts; students should first understand and manually inspect the state before using the helper scripts as automated acceptance/recovery tools.

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

The automated test harness uses the repository's safe training/runtime model. Real destructive administration exercises should be performed only in a disposable VM or an intentionally prepared lab environment.

## Recommended Environment

A Linux VM is recommended for the complete course.

Some labs require or behave differently depending on access to:

- systemd
- loop devices
- mounts and filesystems
- firewall / nftables
- LVM
- kernel modules and drivers
- low-level networking
- reboot / boot dependency behavior
- containers and multi-host networking

WSL is useful for many command-line exercises, but a disposable VM provides the most complete environment for the full training path.

## Public Repository Safety

Do not commit real credentials or private machine information.

Examples that should remain local:

- `.env` files containing real secrets
- private SSH keys
- API tokens and passwords
- real credential exports
- generated runtime state
- local Machine Records containing sensitive host/IP information
- transient logs and test outputs

Use fake or training-only credentials in public examples.

## License

This repository uses dual licensing:

- **Source code, shell scripts, and software-oriented files:** MIT License — see [`LICENSE`](LICENSE).
- **Educational content, Markdown documentation, slide decks, DOCX materials, diagrams, exercises, and course content:** Creative Commons Attribution 4.0 International (CC BY 4.0) — see [`LICENSE-CONTENT.md`](LICENSE-CONTENT.md).

In short: the software is permissively reusable under MIT, while the teaching material may also be shared, adapted, and used commercially as long as appropriate attribution is provided.
