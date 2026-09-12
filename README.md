# Linux Systems Training

A hands-on, scenario-based Linux systems administration and infrastructure training project.

This repository uses the same Linux server and Report System story across all phases so that each phase builds on the previous one instead of becoming an isolated command exercise.

The training path starts from taking over a normal Linux machine and gradually extends into troubleshooting, deployment, change management, recovery, performance, security, automation, containers, multi-host operations, and infrastructure as code.

## Training Philosophy

The core workflow is:

```text
Environment
→ Machine Record
→ Baseline
→ Inventory
→ Lab / Scenario
→ Change or Fault
→ Verify
→ Diagnose if needed
→ Rollback / Recovery
→ Reset
→ Final Record
```

The goal is not just to memorize Linux commands. Each command should answer a concrete operational question and fit into a repeatable system workflow.

## Phase Overview

| Phase | Topic | Core Question |
|---|---|---|
| Phase 1 | System takeover and inspection | What is the current state of this Linux system? |
| Phase 2 | Troubleshooting and recovery | What is broken, where is it broken, and how do I fix it? |
| Phase 3 | Deployment and expansion | How do I safely build and add a new service? |
| Phase 4 | Production change management | How do I change a running system safely? |
| Phase 5 | Backup, restore, and disaster recovery | How do I recover from data or system failure? |
| Phase 6 | Performance and capacity planning | Why is the system slow, and how much load can it handle? |
| Phase 7 | Security hardening and exposure management | What is unnecessarily exposed or over-privileged? |
| Phase 8 | Advanced infrastructure operations | How do I scale single-host administration into automation, multi-host, containers, and IaC? |

## Phase 1 — System Takeover

Inspect and record a normal Linux machine before making changes.

Topics include:

- identity, groups, sudo, sessions
- OS, kernel, hostname, hardware
- disks, filesystems, mounts, capacity
- network interfaces, routes, DNS
- processes, services, ports, sockets
- CPU, RAM, disk resources
- logs, packages, schedules, environment
- firewall and basic security state
- Report App verification

The key output is a reproducible machine record and baseline.

## Phase 2 — Troubleshooting

Inject controlled failures into the same environment and practice:

```text
Detect
→ Inspect
→ Isolate
→ Fix
→ Verify
→ Rollback
```

Scenarios cover permissions, storage, filesystems, networking, DNS, processes, services, ports, resources, logs, packages, schedules, environment, and firewall issues.

## Phase 3 — Deployment and Expansion

Deploy and operate an additional Report Worker service while the original Report App remains available.

Topics include users and groups, packages, directories, storage, networking, systemd, ports, environment variables, schedules, logs, firewall rules, startup, verification, and recovery.

## Phase 4 — Change Management

Practice controlled production changes:

```text
Observe
→ Plan
→ Backup
→ Change
→ Verify
→ Monitor
→ Rollback if needed
```

Examples include package updates, application upgrades, configuration changes, permissions, service settings, ports, firewall rules, DNS/network changes, schedules, environment variables, resource limits, cleanup, backup/restore, credential rotation, and reload/restart operations.

## Phase 5 — Backup, Restore, and Disaster Recovery

Recover data, configuration, application, service, and infrastructure state from trustworthy recovery points.

The recovery workflow focuses on:

```text
Assess
→ Select Recovery Point
→ Protect Current State
→ Restore
→ Verify
→ Failback
```

## Phase 6 — Performance and Capacity Planning

Build a baseline, measure the system, isolate bottlenecks, tune safely, and compare before/after results.

Coverage includes:

- CPU and memory
- disk usage and I/O
- network throughput and latency
- service response time
- process/thread counts
- file descriptors and sockets
- resource limits
- stress testing
- capacity forecasting
- scale-up / scale-out decisions

## Phase 7 — Security Hardening

Audit the current attack surface and reduce unnecessary exposure without breaking required services.

Coverage includes:

- login sessions and sudo privileges
- unused users and groups
- file ownership and permissions
- SUID / SGID
- SSH configuration and hardening
- listening ports and services
- firewall and interface exposure
- authentication failures
- service accounts
- secrets, credentials, and SSH keys
- security package updates
- continuous baseline monitoring

## Phase 8 — Advanced Infrastructure Operations

Extend the previous skills from one host into infrastructure operations.

Topics include:

- automation and scheduling
- account lifecycle governance
- data migration
- release / rollout workflows
- boot and shutdown dependencies
- remote and multi-host operations
- containers
- advanced storage and networking
- kernel and driver management
- specialized services such as Nginx, PostgreSQL, and Redis
- Infrastructure as Code / multi-host automation

## Repository Structure

```text
linux-systems-training/
├── common/          # shared Report App / Worker / helper scripts
├── docs/            # phase notes and matrix coverage documents
├── packages/        # controlled package training assets
├── phase1/ ... phase8/
├── ppt/             # training slide decks
├── runtime/         # generated training state (ignored by Git)
├── tests/           # automated shell test suite
└── tools/           # helper utilities
```

## Lab Script Convention

Depending on the phase, scenario directories may include scripts such as:

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

- `prepare.sh` — build the controlled lab state
- `inventory.sh` / `measure.sh` — inspect or record current state
- `fault.sh` — inject a training fault where applicable
- `verify.sh` — check whether the expected state is satisfied
- `rollback.sh` — return to the state before the current change
- `failback.sh` — restore the previous production/recovery state
- `reset.sh` — return the lab to its initial training state

## Automated Tests

Run the full safe shell test suite:

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

The repository test harness is designed around the safe training/runtime model. Destructive production actions should be performed only in disposable VMs or intentionally prepared lab environments.

## Recommended Environment

A Linux VM is recommended for the full course.

Some labs require features that may be limited or behave differently under WSL, including:

- systemd behavior
- loop devices
- mounts and filesystems
- firewall / nftables
- LVM
- kernel modules and drivers
- low-level networking
- reboot / boot dependency exercises

For destructive labs, use a disposable VM or snapshot-capable environment.

## Safety Notes

Before publishing machine records or lab outputs, make sure they do not contain real credentials or sensitive host information.

Do not commit:

- `.env` files containing real secrets
- private SSH keys
- API tokens or passwords
- real credential files
- generated runtime state
- machine-specific logs or records containing sensitive information

Use only fake or training credentials in public examples.

## License

No license has been selected yet. Add a license before reusing this repository outside its intended training context.
