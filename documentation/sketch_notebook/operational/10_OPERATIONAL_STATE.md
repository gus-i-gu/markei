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

<!-- TEMPORAL_MARKER:C11-ANALYTICS-CORRECTION-OPERATIONAL-2026-07-31 -->
> Temporal boundary — Operational checkpoint after C11 Analytics correction implementation and Main section 16 reconciliation. Content above preserves earlier recovery context. Content below is the sole current compact Operational state and authorizes no source, provider, live-operation, Main-root, staging or methodology change.

# Current Operational State — C11 Analytics Correction

> Branch: `grm-guarded-provisioning-20260727`
> Inspected remote head: `34eb4b60fd4f9c6455c1774c055c1615581623af`
> Implementation evidence head: `17fd65296e960112787b870363b40339f535f5b6`
> Implementation parent: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
> Correction authority: `0e647e76aa8275bda48cea1e9d08427e3d949134` — consumed
> Evidence report: complete `DEV_STAGE/G_OPS_CODEX.md`
> Latest Main reconciliation: `J_MAIN_STAGE.md` section 16
> Status: Active compact Operational checkpoint

## Accepted terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
C11_PH01_PH03_PH05=IMPLEMENTED_VALIDATED_AT_RECORDED_BOUNDARIES
ANALYTICS_CORRECTION=IMPLEMENTED
CALCULATION_SELECTION_INTEGRITY=VALIDATED_AUTOMATED
DEFAULT_QUANTITY_INSERTION=NOT_EVIDENCED
RAW_FIXED_POINT_PRESENTATION=REMOVED
VISIBLE_ORDINARY_ANALYTICS_UUIDS=NO
ANALYTICS_EFFECTS=initial_read:1;retry:+1;other:+0;writes:0;network:0
PRODUCTION_ACCEPTANCE=DEFERRED
LIVE_OPERATION_AUTHORITY=NONE
```

Cycle 10 remains closed at its two-Device, one-Account development boundary. The correction performed no live provider or Sync operation and does not reopen production acceptance.

## Implemented and validated

- One typed Variables owner derives categorical breakdowns and numeric measures. Categorical-only and unsupported combinations block without inserting an implicit measure.
- One immutable session record controls Chart, Table, interpretation, CSV and PDF; later draft and record selection do not mutate it.
- Strict inclusive `dd-mm-yyyy` dates map from local-calendar boundaries to the existing UTC half-open interval.
- Quantity, money, unit-price, percent, signed Difference and Evidence count use readable shared presentation/export conversion.
- Raw compatibility keys and ordinary Purchase, Product, Store and Item UUID presentation are removed while internal identities remain.
- The ten-case regression matrix and focused serial Analytics suite passed with 24 tests.
- The full serial suite passed with 286 tests and 4 lab-gated skips.
- Formatting, analysis, diagnostic-registry check, Windows release build and Android debug build passed.
- Analytics retains initial local read `1`, Retry `+1`, other actions `+0`, database writes `0` and network calls `0`.
- Schema, migrations, generated source, dependencies, lockfile, native platform files, GRM/GS and unrelated systems remained unchanged.
- The serial `G_SCRIPTS.md` gate correction was satisfied before implementation. Codex correction authority is consumed.

## Warnings and evidence ceiling

Existing Drift multiple-database warnings were observed and not suppressed. The existing Windows Boost/CMake warning and Android Auth0 Kotlin Gradle compatibility warning remained. None is a correction failure.

Still unperformed: wide/compact screenshot review; keyboard-only human review; Narrator and TalkBack; locale and long-string review; Windows application launch; Android real-device behavior; learner comprehension; and manual Windows Downloads export.

No live Auth0, Neon, Render, provider or Sync operation was performed. PH05 Guide sequence deviation remains out of scope. Android public Downloads remains typed unavailable. GCM04, conditional former R07, multiple-Account hosted work, revocation, outage recovery, retention/rebootstrap and production lifecycle remain C12-PHASE02 work.

## Current Operational work

1. Complete wide/compact screenshot, keyboard, assistive-technology, locale/long-string and learner-comprehension review.
2. Launch the Windows release application and manually validate CSV/PDF Downloads behavior.
3. Validate corrected Analytics behavior on an Android real Device while retaining typed-unavailable public Downloads.
4. Preserve the correction's local-only effect budget and unchanged schema/dependency/provider boundary.
5. Resolve the PH05 Guide sequence deviation separately; keep C12-PHASE02 backend work deferred.

## Recovery

Read in this order:

1. this checkpoint segment;
2. `04_TODO.md` for remaining executable and deferred gates;
3. `11_OPERATIONAL_RECORD.md`, “C11 Analytics correction materialization”;
4. `12_OPERATIONAL_MODEL.md`, “C11 Deterministic Local Analytics Operational Rules” and “Analytics composition and presentation integrity”;
5. complete `DEV_STAGE/G_OPS_CODEX.md`;
6. `J_MAIN_STAGE.md` section 16;
7. implementation commit `17fd65296e960112787b870363b40339f535f5b6` only when execution detail is required.

Next valid route: complete parallel Didactic and Design correction reconciliation, then Main verifies the twelve-file domain delta and performs final C11 permanent absorption before opening C12.

No source, client, database, provider, Main-root, staging or methodology mutation is authorized by this checkpoint.
