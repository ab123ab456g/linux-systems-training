# Script implementation status

Phase 1–8 lab/scenario action scripts have been converted from instructional placeholders to executable training scripts.

- Rewritten nested action scripts: 603
- Shared runtime library: `common/scripts/lab-runtime.sh`
- Default mode is safe sandbox mode under `runtime/labs/`.
- Inventory/measurement commands read the actual Linux host when the command exists.
- Prepare/fault/change state is isolated in the training runtime rather than destructively changing the host.
- Verify, rollback, reset and phase-level verify/reset runners are executable.

This design intentionally separates **learning the workflow** from destructive host administration. Commands that query systemd, network, disks, users, packages and logs are real read-only commands; state-changing labs use the sandbox unless a later lab explicitly opts into a real disposable VM/container.
