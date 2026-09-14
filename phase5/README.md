# Phase 5 — Backup / Restore / Disaster Recovery

## Story
The Report system has been in production for a period of time. A data-loss or system-damage incident occurs. The operator must assess the damage, select a trustworthy recovery point, preserve the current incident state, restore only what is necessary, verify data consistency and service health, and fail back if recovery is wrong.

## Core flow

assess → select backup → protect current state → restore → verify → failback → handoff

## Systems in scope
- Report App
- Report Worker
- application data / database
- systemd units
- users / groups / permissions / ACL
- filesystem / mounts
- network / DNS / firewall
- cron / systemd timers
- backup manifests / checksums / recovery points

## Safety
All destructive training scenarios must be run only in the training environment. Each scenario includes prepare/verify/failback/reset helpers. The student performs the actual recovery steps.
