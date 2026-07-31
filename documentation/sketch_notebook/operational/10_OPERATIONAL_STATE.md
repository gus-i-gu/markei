# 10_OPERATIONAL_STATE.md

> Version: C11-PH01 Operational checkpoint
> Branch: `grm-guarded-provisioning-20260727`
> Inspected repository head: `1422731e512ce073e7fda09451415803d12f3a4e`
> Materialization evidence head: `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`
> Status: Active compact Operational checkpoint

# Current State

## Accepted terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCTION_ACCEPTANCE=ABSENT
LIVE_OPERATION_AUTHORITY=NONE
```

Cycle 10 acceptance is limited to two Devices, one Account and the development environment. Client/Render convergence is accepted within the recorded assay; no final provider-table recount followed the golden no-op repeats. GCM04, multiple-Account isolation, revocation, outage recovery, retention/rebootstrap and production lifecycle remain deferred to C12-PHASE02.

## C11-PH01-S01 state

Implemented and automated/build validated:

- stable destination identity;
- compact `<600`, medium `600–1023` and wide `>=1024` shell policies;
- retained page state through responsive layout changes;
- shared visual foundation;
- Home and Lists recomposition;
- read-only Lists Retry limited to the local projection read;
- focused tests, full Flutter tests, analysis, Windows release build and Android debug build.

Unchanged by S01:

- business and persistence behavior;
- Sync, diagnostics, recovery and provider behavior;
- Settings and Closure behavior.

Host-unvalidated or unperformed:

- Windows and Android human visual acceptance;
- Narrator, TalkBack and keyboard-only acceptance;
- Android real-device/density acceptance;
- approved golden or pixel-parity acceptance;
- preserved-client launch and live provider operation.

## Current Operational work

1. Perform bounded Windows/Android human-platform acceptance for the S01 shell, Home and Lists.
2. Complete Catalogue, Purchase and History convergence through separately authorized PH01 units with the same automated/build/human evidence separation.
3. Retain C11-PH02 Analytics and C11-PH03 Settings/Audit/Closure disposition as later work.
4. Keep all backend resilience, multiple-Account, GCM04 and production lifecycle work in C12-PHASE02.

## Recovery

Read in this order:

1. this checkpoint;
2. `04_TODO.md` for current and deferred gates;
3. `11_OPERATIONAL_RECORD.md`, “Cycle 10 — Permanent Operational Registration” and “C11-PH01-S01 visual foundation materialization”;
4. `12_OPERATIONAL_MODEL.md`, “Cycle 10 Guarded Synchronization Operational Rules”;
5. `DEV_STAGE/G_OPS_CODEX.md` for exact S01 commands, artifacts, changed paths and skipped acceptance;
6. the current mutable `J_MAIN_STAGE.md` prefix for global scope and authority.

No source, client, database or provider mutation is authorized by this checkpoint.
