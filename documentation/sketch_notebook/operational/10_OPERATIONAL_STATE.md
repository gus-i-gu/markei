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

<!-- TEMPORAL_MARKER:C11-PH05-OPERATIONAL-2026-07-31 -->
> Temporal boundary — Operational checkpoint after C11-PH05 implementation and Main section 14 reconciliation. Content above preserves earlier recovery context. Content below is the sole current compact Operational state and authorizes no source, provider, live-operation, Main-root, staging or methodology change.

# Current Operational State — C11-PH05

> Branch: `grm-guarded-provisioning-20260727`
> Inspected remote head: `e6ced7fe3945925bf5f314ee11c4538029e18d44`
> Implementation evidence head: `426235d8b67ac719e494b53cfb23a6c3b06fb489`
> Rollback authority: `b59b2ecdfb69ca98c431b9f36694f011332fbef3`
> Evidence report: complete `DEV_STAGE/G_OPS_CODEX.md`
> Latest Main reconciliation: `J_MAIN_STAGE.md` section 14
> Status: Active compact Operational checkpoint

## Accepted terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
C11_PH01_PH03=IMPLEMENTED_VALIDATED_AT_RECORDED_BOUNDARIES
C11_PH05_SOURCE=IMPLEMENTED
C11_PH05_AUTOMATED_BUILD_EVIDENCE=VALIDATED
PH05_HUMAN_ACCEPTANCE=PARTIAL_DEFECT_FINDING
ANALYTICS_WRONG_VARIABLE_RESULT=DEFECTIVE
ANALYTICS_ROOT_CAUSE=NOT_ESTABLISHED
ANDROID_PUBLIC_DOWNLOADS=BLOCKED_TYPED_UNAVAILABLE
PRODUCTION_ACCEPTANCE=DEFERRED
LIVE_OPERATION_AUTHORITY=NONE
```

Cycle 10 remains closed at its two-Device, one-Account development boundary. PH05 performed no live provider or Sync operation and does not reopen production acceptance.

## Implemented and validated

- Home and Guide are local zero-I/O surfaces.
- History owns stable action selection separately from detail and reconstructs a selected export with two set-based Account-scoped reads, zero database writes and zero network calls.
- A successful explicit export produces one final collision-safe file.
- Windows Downloads is implemented at automated/build ceiling. Android public Downloads returns typed unavailable and writes zero files.
- Analytics budgets are initial request `1`, Retry `+1`, and handoff/export/local UI `+0`; Analytics writes no database state and makes no network call.
- Audit budgets are initial `2` queries, Retry `+2`, projections `+0`, writes `0`, network `0`.
- Settings performs five initial capability calls and local Refresh `+2`; duplicate actions are blocked and completed support actions refresh status without losing the action result.
- Focused tests, formatting, analysis, 278-pass/4-lab-skip full suite, Windows release build, Android debug build, diagnostic-registry check and diff check passed.
- Schema, migrations, generated source, dependencies, lockfile, native platform files and API/Auth/Sync/provider contracts were unchanged.
- Rollback is one implementation commit to `b59b2ecdfb69ca98c431b9f36694f011332fbef3`.

## Defective, blocked and host-unvalidated

- Human runtime evidence exposes an Analytics wrong-variable/result defect. Root cause is unknown; passing Analytics tests do not prove calculation-variable integrity.
- The compact composer, unified Variables control, two `dd-mm-yyyy` fields and Date-Time/Store evidence presentation are accepted correction direction, not implementation.
- Guide structure, navigation and zero-I/O behavior are implemented, but its accepted learner sequence is only partially faithful and comprehension is not established.
- Windows Downloads has no manual real-host export, permission/full-disk or visible-file acceptance.
- Android public Downloads remains intentionally unavailable; no public-storage write or real-device acceptance exists.
- Keyboard-only review, Narrator/TalkBack, locale, real-device behavior and complete human comprehension remain unvalidated.
- No live Sign in, enrollment, hosted connection, Sync, Retry, Recovery, Auth0, Neon, Render or provider operation was performed.

## Current Operational work

1. Complete the read-only Analytics draft-to-result/export state-of-union and establish root cause before corrective authority.
2. Validate manual Windows Downloads and decide whether Android public Downloads receives a separately authorized mechanism.
3. Resolve Guide learner-sequence disposition and complete keyboard, assistive-technology, locale, real-device and comprehension gates.
4. Preserve all PH05 operation budgets and unchanged schema/dependency/provider boundaries through any corrective unit.
5. Keep GCM04, conditional R07, multiple-Account hosted work, revocation, outage recovery, retention/rebootstrap and production lifecycle in C12-PHASE02.

## Recovery

Read in this order:

1. this checkpoint segment;
2. `04_TODO.md` for corrective, host-validation and deferred gates;
3. `11_OPERATIONAL_RECORD.md`, “C11-PH05 local product-surface and export materialization”;
4. `12_OPERATIONAL_MODEL.md`, “C11 Local Product-Surface and Export Operational Rules”;
5. complete `DEV_STAGE/G_OPS_CODEX.md`;
6. `J_MAIN_STAGE.md` section 14;
7. implementation commit `426235d8b67ac719e494b53cfb23a6c3b06fb489` only when execution detail is required.

Next valid route: Main verifies the Operational, Didactic and Design PH05 permanent reconciliations; separately complete the read-only Analytics correction state-of-union before any new D/E/F or Codex authority.

No source, client, database, provider, Main-root, staging or methodology mutation is authorized by this checkpoint.
