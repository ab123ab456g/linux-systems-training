# Phase 5 Recovery Overview

Phase 5 trains recovery after major loss or corruption rather than ordinary troubleshooting.

Core sequence:
assess → select backup → protect current state → restore → verify consistency → verify services → return traffic → establish new recovery point.

The same Report App and Report Worker environment from earlier phases is reused so recovery decisions have application consequences.
