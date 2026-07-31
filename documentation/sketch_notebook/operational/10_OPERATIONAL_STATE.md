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

<!-- TEMPORAL_MARKER:C11-PH02-OPERATIONAL-2026-07-31 -->
> Temporal boundary — Operational checkpoint after C11-PH01-R01 and C11-PH02 materialization. Content above preserves the earlier C11-PH01-S01 recovery checkpoint. Content below is the current compact Operational recovery state and authorizes no source, provider, live-operation or production change.


# Current Operational State — C11-PH02

> Branch: `grm-guarded-provisioning-20260727`
> Inspected repository head: `0bfc02e8363d8119469a5e8627d8350fa97790b4`
> Implementation evidence head: `20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6`
> Latest Main reconciliation: `J_MAIN_STAGE.md` section 9
> Status: Active compact Operational checkpoint

## Accepted terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
C11_PH01_R01=IMPLEMENTED_VALIDATED_AUTOMATED_BUILD_CEILING
C11_PH02=IMPLEMENTED_VALIDATED_AUTOMATED_BUILD_CEILING
PRODUCTION_ACCEPTANCE=ABSENT
LIVE_OPERATION_AUTHORITY=NONE
```

Cycle 10 acceptance remains limited to two Devices, one Account and the development environment. GCM04, multiple-Account isolation, revocation, outage recovery, retention/rebootstrap and production lifecycle remain deferred to C12-PHASE02.

## Implemented and validated

- Purchase and Catalogue constrained-height reachability and field geometry corrections.
- One History checkbox selection affordance with separate detail activation.
- R02 tester-owned bounded scrolling and visibility-gated hidden Analytics loading.
- Deterministic read-only local Analytics scoped by the active Account.
- One complete joined evidence load; no History 50-row reuse and no N+1 detail path.
- Initial request count 1; each local Retry +1; filtering, selection, execution, focus, reset and reorder +0.
- Typed History Purchase-ID handoff; History does not calculate Analytics.
- Sum, Mean, B-minus-A Difference and part-of-whole Percentage with checked fixed-point/rational behavior.
- Typed unavailable outcomes for zero denominator and overflow.
- One workspace state across wide and compact layouts; 100-row rendered page and 500-ID selected-scope bound.
- Focused tests, 26 app-shell tests, full 258-pass/4-skip suite, analysis, Windows release build and Android debug build.

## Measured evidence boundary

On one Windows validation host:

- ordinary 1,000-Purchase/5,000-Item Sum fixture: complete load 2 ms, calculation 22 ms;
- stress 10,000-Purchase/50,000-Item Mean fixture with selected scope 500: complete load 6 ms, calculation 302 ms.

These are committed fixture measurements, not universal Windows or Android performance guarantees.

No schema, migration, dependency, lockfile, generated-source, platform, API, Auth, Sync, provider or diagnostic surface changed. No live Sync/provider operation occurred, and no Cycle 10 or production acceptance boundary reopened.

## Remaining gates

- screenshot-based compact/medium/wide review;
- Narrator, TalkBack and other assistive-technology review;
- keyboard-only human acceptance;
- real Windows/Android device and density/orientation review;
- locale review;
- human comprehension and visual acceptance;
- representative slower-device performance confirmation when Main authorizes a target.

These are unperformed acceptance gates, not implementation failures.

## Recovery

Read in this order:

1. this checkpoint segment;
2. `04_TODO.md` for executable and deferred gates;
3. `11_OPERATIONAL_RECORD.md`, “C11-PH01-R01 and C11-PH02 combined materialization”;
4. `12_OPERATIONAL_MODEL.md`, “C11 Deterministic Local Analytics Operational Rules”;
5. complete `DEV_STAGE/G_OPS_CODEX.md`;
6. `J_MAIN_STAGE.md` section 9;
7. implementation commit `20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6` only when execution detail is required.

Next valid route: after Operational, Didactic and Design permanent reconciliations are published, Main reconciles the results and selects the bounded C11-PH03 entry.

No source, client, database, provider, Main-root, staging or methodology mutation is authorized by this checkpoint.
