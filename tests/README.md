# Shell Test Suite

Run all safe repository tests:

```bash
bash tests/test-all.sh
```

Tests:
- `test-structure.sh`: required repository structure
- `test-syntax.sh`: `bash -n` for every shell script
- `test-phase1.sh` ... `test-phase8.sh`: per-phase smoke tests
- `test-scenarios.sh`: scenario contract; explicit fault scenarios must make `verify.sh` fail before recovery
- `test-rollback.sh`: rollback/reset repeatability
- `test-idempotency.sh`: repeated setup/reset/recovery smoke tests

The suite uses the repository's safe training/runtime model and does not intentionally alter real production users, firewall, LVM, SSH, systemd, or kernel state.

Quick validation:

```bash
bash tests/test-ci.sh
```

`test-ci.sh` is the fast gate. `test-all.sh` is the exhaustive suite and can take substantially longer because it traverses every Phase 1–8 scenario and repeatability path.
