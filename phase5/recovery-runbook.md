# Recovery Runbook

1. Assess the incident and define scope.
2. Stop unsafe writes if necessary.
3. Identify candidate recovery points and RPO impact.
4. Validate backup integrity before restoration.
5. Preserve the current incident state before overwriting anything.
6. Restore the smallest required scope first.
7. Verify integrity, ownership, permissions, schema and business rules.
8. Verify Report App / Report Worker / timers / network access.
9. Return production traffic only after verification.
10. If recovery is wrong, fail back to the protected pre-restore state.
11. Create a new known-good recovery point and record the incident timeline.
