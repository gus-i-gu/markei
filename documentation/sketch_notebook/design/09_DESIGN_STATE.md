# 09_DESIGN_STATE.md

> Version: 0.7-cycle09-sprint02-promotion
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Current Design checkpoint after Cycle 09 Sprint 02 promotion
> Sources: C/F/I, post-Codex J, target references and handwritten repository evidence

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves prior checkpoints. This is the single current Design checkpoint.

# Cycle 07 Sprint 05 Design Checkpoint

> Branch: `cycle-07-mobile-preparation`
> Evidence: `DEV_STAGE/I_DSN_CODEX.md`
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`, §24
> Intent/directive: `DEV_STAGE/C_DESIGN.md`, `DEV_STAGE/F_DSN_STAGE.md`
> Repository truth: Android host, async composition, Device repository, Drift v2, tests, and functional scaffold

## Current architecture

Sprint 05 established an Android-local debug slice without changing the accepted shared-client direction:

```text
Windows / Android Flutter hosts
→ shared entrypoint and asynchronous composition
→ presentation
→ application commands/query ports
→ independent Dart domain
→ local repository adapters
→ Drift schema v2 / application-private SQLite
```

Android/Kotlin remains a host. It owns no Product, Purchase, Event, sequence, analytics, or repository behavior. Cycle 06 Python/PySide6 and its database remain protected and recoverable.

## Implemented and validated

- Android namespace/application ID: `com.gusigu.markei`; label: `Markei`;
- Flutter embedding v2 and minimal `FlutterActivity` host;
- asynchronous composition loads Device identity before event-producing commands;
- database-owned UUID v4 replaces production `windows-device` injection;
- UUID persists across reopen; fresh databases differ;
- sequence continues 1→2 for the persisted Device;
- historical non-UUID Device rows are preserved and not reused;
- no schema migration was needed because Drift v2 already owns Device and sequence fields;
- `SafeArea` and staged BRL total extend the functional scaffold;
- 27 Flutter tests and analysis passed;
- debug APK built; identity badging passed;
- API 36 emulator boot/install/launch passed;
- Android app-private database and Device/Purchase facts were observed;
- human Android Purchase registration was confirmed;
- Windows build and five Python regressions passed.

## Accepted Design boundaries

- stable application ID owns Android installation/update and sandbox continuity;
- application label is presentation metadata, not identity;
- Account remains the provisional `local-account` placeholder;
- Device is an app-private UUID v4 with sequence attached to its database row;
- Device is not hardware-, platform-, Account-, email-, or application-ID-derived;
- Product, Purchase, Item, Event, and catalogue identity rules remain unchanged;
- compile/target SDK 36 and host tool versions are Operational configuration, not domain architecture;
- SafeArea and staged total are bounded scaffold choices, not final UI acceptance;
- local queue/event preparation is not synchronization.

## Prototype-only debt

`LocalDeviceIdentityRepository` scans only the first 20 Account Devices by creation time and selects the earliest UUID v4. This is acceptable for the bounded single-installation prototype only.

Before real synchronization or multiple-Device history, Design requires an explicit current-installation relation with exactly one referenced Device, idempotent concurrent bootstrap, uniqueness protection, and preserved historical Devices. Exact physical schema and migration remain open.

## Evidence limits

```text
validated
    debug Android build and one emulator execution
    sandbox persistence observation
    Device bootstrap/reopen/sequence tests
    human Purchase registration
    Windows/Python regression

partial or host-unvalidated
    keyboard and Back behavior
    rotation and background/resume
    larger text and accessibility
    complete force-stop/cold-relaunch matrix
    physical device compatibility

not accepted/deferred
    final UI/UX
    production signing/release/store
    backup policy
    authentication/API/Neon/synchronization
    central catalogue/import/iOS/PySide6 retirement
```

Automated ADB form entry was blocked by emulator input overlays, while manual registration passed. Phone-width widget tests do not establish final visual quality or complete Android lifecycle behavior.

## Next valid route

Main may close Sprint 05 if current debug-development evidence is sufficient, or authorize one bounded supplemental Android checklist for keyboard, Back, rotation, background/resume, larger text, and cold relaunch. Broad UI/UX formalization must remain a later sprint. The explicit installation-Device invariant must be resolved before real synchronization.

Additional implementation remains inactive until Main/human authority is expressed through fresh D/E/F.

## Recovery pointers

- Canonical: `design/01_ARCHITECTURE.md`, §§16–19.
- Derived: `design/14_MODEL_OVERVIEW.md`, current post-marker segment.
- Observational: `design/03_DECISION_LOG.md`, Event 17.
- Evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main: `[M]_STAGE/J_[M]_STAGE.md`, §24.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here. Content above is historical. This is the current Design checkpoint.

# Cycle 09 Sprint 02 Design Checkpoint

> Sequence: FLX-PRM-04 / PRC-01
> Branch: `intermid-cycle-recovery`
> Required ancestry: `4bf2e52d9d3e23437c4da1d8bb05e2402e189dd5`
> Source range: `5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3..1d817972aea0229c9f109f236f4d224671927aab`
> Generated Drift: derived evidence only

## Current architecture

```text
adaptive Flutter presentation
→ application ports/read models/results/calculations
→ independent Dart domain
← local adapters
→ handwritten Drift schema v4 / app-private SQLite
```

Offline-first dependency direction and the protected Python/PySide6 boundary remain stable.

## Promoted as implemented

- tested schema-v4 migration/reopen boundary;
- opaque Person/Payment UUID identity plus immutable Account-scoped `@/#` visible codes and counters;
- mandatory immutable Account-scoped Product codes with normalized uniqueness and deterministic legacy backfill;
- optional archive-resolvable Purchase references;
- exact local Purchase date/time parsing and conversion to one persisted UTC occurrence;
- same-selected-unit BULK fixed-point calculation with read-only half-up minor-unit total;
- exact Product-code resolution/autofill without implicit Item addition;
- Product-first rebuildable Lists query; no persisted List/cache;
- compact Home/Lists/Purchase/History/More navigation;
- Catalogue selection/detail and History select-all/detail increments.

## Partial, contradicted or deferred

| Claim | State |
| --- | --- |
| complete design system | partial: small theme foundation only |
| shared Markei components | exist, but pages do not consume them |
| Home visual rebuild | not materialized |
| Lists relational table/card/filter target | not materialized |
| Catalogue/History composition | partial; standard list structure retained |
| Purchase composition | functional increment; former ~1,020-line form retained |
| adaptive Product details | partial/open |
| History double-click | contradicted: focuses detail instead of toggling selection |
| native OS PDF sharing | deferred; temporary-file/manual fallback |
| target-image parity | not achieved |
| Android/manual accessibility | unvalidated |
| Windows workflow/visual acceptance | unvalidated |
| release readiness | not accepted |

Catalogue (~377 lines), History (~330) and Purchase (~1,020) exceed ordinary ~250-line modularity guidance. This debt is architectural because it increases responsive and visual-change coupling.

## Stable invariants

- registered Purchase facts remain authoritative; projections and exports are rebuildable;
- Product UUID, visible code, exact identity, similarity and idempotency remain distinct;
- no competing BULK price-per-unit fact is persisted;
- exact lookup, selection, details and Item addition remain separate operations;
- archived references remain historically readable;
- exports do not mutate Purchases or upload data;
- generated code cannot override handwritten schema truth.

## Evidence limits

Automated source/tests establish the promoted schema and focused application contracts. They do not establish screenshot parity, manual accessibility, native sharing, Android runtime, Windows workflow acceptance, DST-zone provenance or production release.

## Remaining Design conflicts

1. freeze History double-click semantics against the selection contract;
2. define the actual token/state/component set and require page adoption;
3. define relational Lists desktop-table/mobile-card content and filters;
4. choose adaptive Product-detail pane/route/sheet behavior;
5. split Purchase/Catalogue/History into bounded components;
6. define native share/save lifecycle if activated;
7. define screenshot, compact/expanded, Windows and accessibility acceptance gates.

## Next Main handoff

Authorize, reject or narrow one schema-free visual-convergence unit:

```text
expand tokens and reusable primitives
→ make pages consume the shared system
→ recompose Home
→ recompose Lists relational presentation
→ recompose Catalogue
→ split and recompose Purchase
→ recompose History and resolve double-click
→ expanded/compact screenshot comparison
→ Windows workflow and accessibility validation
```

No source implementation is active from this checkpoint. Fresh D/E/F authority is required.

Recovery: Architecture §21; Decision Log Event 21; Model Overview current Cycle 09 segment; C/F/I and post-Codex J.

---

<!-- TEMPORAL_MARKER:C10-RECOVERED-PROMOTION-2026-07-15 -->
> Temporal boundary retained; this is the single current Design checkpoint.

# C11-PH03 Design Checkpoint

> Sequence: FLX-PRM-04 / PDR2-D
> Branch: \`grm-guarded-provisioning-20260727\`
> Inspected implementation head: \`0924e743931ea7aba2c9cc5d2e28063e737b2ff5\`
> J reconciliation head: \`33dc1002b4a7b00fa67e863dfe98a43c97d66cee\`
> Evidence: complete \`DEV_STAGE/I_DSN_CODEX.md\`
> Main reconciliation: \`[M]_STAGE/J_MAIN_STAGE.md\` section 11

## Current accepted architecture

PH01-R01 and PH02 remain permanently absorbed. PH03 implements mandatory
Settings, mandatory Audit and complete retirement of Closure from ordinary
product navigation.

~~~text
Audit presentation
→ one page-session AuditController
→ capability-narrow AuditReadPort
→ local diagnostic projection repository
→ existing persisted attempts/events + read-only safe registry meaning

Settings presentation
→ existing Account-scoped reference/preference repositories
→ capability-narrow Account and Sync/Device support ports
~~~

## PH03 ownership and invariants

- persisted attempt/event IDs own Audit projection identity;
- paging uses an exclusive UTC-start-time-plus-attempt-ID cursor;
- each page uses one attempt query plus one child-event query;
- reads are Account/environment-predicated and sanitized;
- Audit performs zero network calls and zero writes;
- visibility gates first load; generation suppresses stale completions;
- Retry is manual and local-only;
- one controller supplies every responsive layout and is composition-owned;
- Settings preserves existing local repository authority;
- Account and Sync/Device behavior reaches presentation only through narrow
  support ports;
- Closure is absent from ordinary destination identity and navigation;
- broad probes, recovery, delete-history and provider maintenance remain outside
  ordinary UI and development-only where retained;
- composition close is idempotent and disposes the controller/database once.

## Evidence state

| Claim | State |
| --- | --- |
| PH03 Settings/Audit/Closure topology | implemented and validated |
| focused/full tests, analysis and path audits | validated |
| Windows release / Android debug builds | validated |
| registry drift and resource disposal | validated |
| bounded human UI verification for continuation | accepted |
| screenshot-set / assistive technology / locale | host-unvalidated |
| real-device / keyboard-only / comprehension | host-unvalidated |
| human architecture acceptance | host-unvalidated |
| minor UI polish | deferred to C12-PH01 |
| schema/generated/dependency/API/Auth/Sync/provider change | deferred and not implemented |
| former R07 causal/backend engine | deferred and not implemented |

## Preserved boundaries and rollback

The rollback boundary is
\`256ee4dbbcb790419b816862ee42933a115ddd87\`. Reverting the one PH03
implementation commit restores the prior product surface without schema, data,
generated-source or dependency rollback.

PH03 changes no schema, migration, generated source, dependency, API/Auth/Sync
or provider contract, diagnostic registry or Analytics behavior. Existing
Closure implementation may remain unreachable development/support
infrastructure; it defines no ordinary product authority.

## Next valid route

Main should verify the completed Operational, Didactic and Design PH03
reconciliations, then refresh \`00_PROJECT_STATE.md\`, \`05_SESSION_LOG.md\` and
\`06_SESSION_SCHEME.md\` before opening C12-PH01 bounded UI polish. Do not
reopen PH03 architecture or restage C11 D/E/F for minor visual refinements.

GCM04, conditional R07, production, resilience, multiple-Account, Device
revocation, retention and rebootstrap remain deferred.

## Recovery pointers

- Canonical: \`design/01_ARCHITECTURE.md\`, §§23–26.
- Derived: \`design/14_MODEL_OVERVIEW.md\`, current C11-PH03 model.
- Observational: \`design/03_DECISION_LOG.md\`, Events 23–26.
- Evidence: complete \`DEV_STAGE/I_DSN_CODEX.md\`.
- Main: \`[M]_STAGE/J_MAIN_STAGE.md\`, section 11.
