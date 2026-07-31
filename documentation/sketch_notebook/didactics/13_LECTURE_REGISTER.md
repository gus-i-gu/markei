# 13_LECTURE_REGISTER.md

> Domain: Didactic
> Status: Observational history
> Authority: Didactic Chat [A]
> Current truth sources: `02_KANBAN.md`, `07_GLOSSARY.md`, and `08_CONCEPT_MAP.md`
> Rule: This file records how learning memory evolved; it does not override canon or checkpoint state.

---

# Observation 001 — Didactic Domain Recovery

```text
Date: 2026-07-10
Branch: sketch-notebook-recovery
Class: domain recovery and repopulation
```

The Didactic domain was reconstructed from current repository evidence, exact Main reconciliation, and bounded historical review. Canon, glossary, checkpoint, and observational roles were restored without treating implementation facts as learner mastery.

Durable lessons:

- exact authority path and branch matter;
- physical package placement does not fully define semantic responsibility;
- staged interpretation is not canon;
- derivative terminology does not create independent truth;
- unresolved architecture remains outside Didactic authority;
- useful implementation output does not prove cycle completion.

# Observation 002 — Cycle 06 Sprint 01 Concept Classification

```text
Date: 2026-07-12
Branch: sketch-notebook-recovery
Class: release-learning classification
Main source: [M]_STAGE/J_[M]_STAGE.md
```

Four concepts were classified as canonical Red:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

Sprint 01 evidenced a one-folder frozen build and launch, schema-only production initialization, startup diagnostics, and an evidence-triggered shutdown correction. Installer compilation remained blocked by missing `ISCC.exe`; installed execution and uninstall retention remained unvalidated. No concept became Green.

# Observation 003 — Cycle 06 Sprint 02 Installed-Lifecycle Evidence

```text
Date: 2026-07-12
Branch: sketch-notebook-recovery
Class: post-materialization Didactic reconciliation
Sources:
  DEV_STAGE/E_DDC_STAGE.md
  DEV_STAGE/H_DDC_CODEX.md
  DEV_STAGE/G_OPS_CODEX.md
  [M]_STAGE/J_[M]_STAGE.md
```

Sprint 02 crossed the installer and automated installed-lifecycle boundary.

Observed progression:

```text
installer configured
→ Inno Setup 6.7.3 installed per-user
→ ISCC.exe discovered
→ installer compiled
→ installer artifact inspected and hashed
→ per-user installation
→ Start Menu launch
→ installed technical workflow evidence
→ close and immediate reopen
→ same-version reinstall
→ uninstall with retained user data
→ reinstall recovery
```

Learning evidence reinforced:

- `&&&05`: each state required matching evidence; acceptance remained separate.
- `&&%04`: installed shortcut execution was distinguished from source and frozen-directory execution.
- `&%%06`: compiled installer, installed files, uninstall, retention, and recovery became observed lifecycle stages.
- `%%%06`: Inno Setup was installer-time tooling, not an installed runtime dependency.
- `%%%05`: replaceable installed files and retained `%LOCALAPPDATA%\Markei` state were directly distinguished.
- `%%%01`: category `F` / `General` and store `1` / `Default Store` were classified as required structural defaults, not sample seed data.

A fresh-production Register-equivalent workflow initially failed because required foreign-key defaults were absent. The bounded correction created structural defaults idempotently while preserving zero sample products and purchases. This demonstrated that initialization, migration/defaulting, and seeding are distinct operations.

Automated technical workflow evidence used the same ProductService/database path and validated persisted Register-equivalent data plus Lists, History, and Settings projections. It did not constitute a complete human-visible UI walkthrough.

Security/reputation evidence remained bounded:

```text
Defender enabled: observed
Authenticode: NotSigned
human-visible SmartScreen behavior: unknown
```

Maturity decision:

```text
no new concept
no Green promotion
no Red-to-Yellow promotion
```

The reason is explicit: software validation and release readiness do not demonstrate learner mastery. Future maturity movement requires learner evidence under the Didactic protocol.

Remaining learner checks:

1. explain the difference between installer configuration, compiled artifact, installation, validation, and acceptance;
2. distinguish frozen launch from Start Menu installed launch;
3. explain why retention must be observed across uninstall and reinstall;
4. distinguish structural defaults from sample data;
5. classify SmartScreen/reputation evidence separately from application correctness;
6. explain why `ISCC.exe` is installer-time only;
7. explain why automated service-backed validation is not a full human UI walkthrough.

# Current Observation Boundary

Cycle 06 is technically release-candidate ready under automated installed-lifecycle evidence, but Didactic memory does not claim learner mastery, human-visible UI acceptance, SmartScreen behavior, or final beta acceptance.

# Observation 004 — Cycle 07 Sprint 01 Portability Learning Reconciliation

```text
Date: 2026-07-12
Branch: cycle-07-mobile-preparation
Class: portability investigation and pathway-cost observation
Sources:
  [M]_STAGE/J_[M]_STAGE.md
  DEV_STAGE/A_OPERATIONAL.md
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/C_DESIGN.md
```

Cycle 07 Sprint 01 investigated portability without implementing a mobile prototype. It established a learning boundary: shared source language does not guarantee a shared runtime, and platform-neutral components do not by themselves make an application portable. Markei's models and parts of its business behavior are reuse candidates, while presentation, storage paths, construction, packaging, and lifecycle remain platform-sensitive.

The investigation preserved two serious pathways.

## Python-native pathway

The Python-native pathway tries to lower initial implementation cost by executing more of the existing Python core directly. Its attraction is immediate: fewer rules may need to be rewritten, existing Python tests may remain useful, and the learner can initially work in a familiar language.

That saving is conditional. Cost may move into mobile Python packaging, device lifecycle handling, native integration, accessibility, platform support, distribution, and debugging across less conventional boundaries. Reusing source can reduce rewriting while increasing uncertainty about whether the runtime, dependencies, and UI toolchain behave reliably on Android and iOS.

## Contract-first cross-platform pathway

The contract-first pathway accepts a larger initial cost because some behavior must be implemented again in a conventional native or cross-platform client. It tries to make that cost visible and controlled through behavioral contracts, golden fixtures, semantic-parity checks, explicit lifecycle ownership, a mobile-owned local store, and platform-appropriate presentation.

Its cost includes duplicate implementation, contract and fixture design, parity testing, and learning a mobile toolchain. Its intended benefit is lower long-term uncertainty: each platform can use established tooling while shared examples protect the meaning of receipt registration, calculation, validation, and status behavior.

Human/Main direction currently favors this contract-first Design pathway. This is a reasoned project preference, not evidence that the pathway is understood by the learner, validated by a prototype, or permanently accepted as architecture. The Python-native route remains a bounded challenger whose direct-reuse claim requires device evidence.

## Development cost in learner-facing terms

Development cost is everything the project must spend to create, understand, prove, distribute, and keep a change working. It is not only money or lines of code. It includes:

- learning effort and setup time;
- the number of ideas that must be held together;
- repeated or duplicate implementation;
- designing tests and shared examples;
- finding and explaining failures;
- fragile or unusual toolchains;
- maintenance across Android, iOS, and desktop;
- preventing two implementations from silently changing meaning;
- packaging and distribution requirements;
- the effort required by future changes.

A pathway can look cheaper because it writes less code today while becoming expensive to package and debug later. Another can look expensive because it rewrites behavior today while making later maintenance and platform support more predictable. Sprint 01 compared where cost may occur; it did not measure either pathway through implementation.

## Candidate concepts observed

```text
Platform Boundary
Composition Root
Dependency Injection
Behavioral Contract
Golden Fixture
Semantic Parity
Local Persistence
Offline-First
Transaction Boundary
Application Lifecycle Ownership
Synchronization
```

These remain KANBAN candidates. Existing canon already partially supports them through Responsibility Boundary, Application Service, Repository Pattern, Resource Ownership and Lifetime, Statement Atomicity versus Workflow Atomicity, and SQLite Connection Ownership. Canonical creation should wait until prototype preparation identifies which candidates are necessary as independent concepts and provides concrete project examples.

Unresolved learner questions include:

1. Which parts of Markei can share source, and which can share only behavior?
2. What does a composition root create and connect?
3. Why does dependency injection make a storage implementation selectable?
4. How can a fixture prove equivalent behavior across Python and another runtime?
5. Who owns the mobile database and its transaction lifetime?
6. What must remain available for the application to be offline-first?
7. When does synchronization become a requirement rather than speculative infrastructure?
8. Which costs are paid once, and which recur with every platform or feature change?
9. What evidence would fairly compare the two pathways?
10. Why does a project preference not change learner maturity?

Maturity decision:

```text
new canonical concepts: none
candidate concepts: eleven
maturity changes: none
project preference: contract-first, provisional
prototype validation: not performed
learner mastery: not demonstrated
```

# Current Observation Boundary

Cycle 06 remains accepted and closed. Cycle 07 Sprint 01 provides classified portability knowledge and a preferred investigation direction, but not mobile runtime evidence, prototype validation, permanent architecture acceptance, or learner mastery. D/E/F remain postponed.

# Observation 005 — Cycle 07 Sprint 02 Flutter Canonical Promotion

```text
Date: 2026-07-12
Branch: cycle-07-mobile-preparation
Class: model-design canonical promotion
Sources:
  [M]_STAGE/J_[M]_STAGE.md sections 17–18
  DEV_STAGE/A_OPERATIONAL.md
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/C_DESIGN.md
```

Human/Main established Flutter/Dart as the planning basis for the shared Windows, Android, and iOS client. TypeScript remained favored for the custom synchronization API, Neon for managed shared persistence, and the accepted Python/PySide6 beta as reference and rollback. No application, API, schema, provider, infrastructure, or D/E/F implementation was authorized or evidenced.

The model-design discussion genuinely approached stable identity, authentication and authorization, the account-private reusable catalogue, deterministic Product normalization, Purchase aggregation, dimensional quantity and minor-unit money, append-only offline synchronization, eventual consistency, historical integrity, versioned analytics, immutable Dart models, and responsive Flutter composition.

Human clarification established that implementation is not required for canonical concept introduction when a model-design concept has reusable meaning and concrete project manifestation. The Didactic domain therefore promoted:

```text
&&&06–&&&10
&&%05
&%%07–&%%17
%%%07
```

All eighteen concepts entered as Red.

Reconciliation prevented duplicate semantic ownership:

- Authoritative Fact / Derived Projection remained an extension of `&&&02`.
- Purchase atomicity remained an extension of `&%%05`.
- Row Ownership remained an Authorization example.
- Composition root and application lifecycle remained related to existing responsibility, ownership, and cleanup concepts.
- Protocol versioning became part of Sync Protocol.
- Storage-schema versioning remained related to `%%%01`.
- Append-only event semantics remained distinct from Dart immutability.

Learning-state decision:

```text
new canonical concepts: 18
new concept status: Red
existing maturity changes: none
implementation evidence: none
learner mastery evidence: none
```

Concept introduction records that the project can now name and teach the model. It does not show that the learner can independently explain, apply, compare, or debug it. Later maturity movement requires explicit learner evidence.

# Current Observation Boundary

The permanent Didactic domain now contains canonical Flutter shared-beta model vocabulary, derived retrieval terminology, and a refreshed checkpoint. Architecture and implementation acceptance remain outside Didactic ownership; D/E/F remain postponed.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Observation 006 — Cycle 07 Sprint 03 Local Flutter Evidence

```text
Date: 2026-07-12
Branch: cycle-07-mobile-preparation
Class: post-materialization Didactic reconciliation
Sources:
  [M]_STAGE/J_[M]_STAGE.md §19
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/H_DDC_CODEX.md
Materialization commit:
  5ef64a1d5b6af6d397d4f3a7aea6d635911be12d
```

Sprint 03 Unit 01 changed the evidence state from planning-only to a locally implemented and unit-tested Flutter/Dart foundation.

Observed implementation:

```text
Flutter project under clients/markei_flutter
→ immutable Dart domain/value models
→ account-private reusable catalogue
→ PACKAGED/BULK identity rules
→ dimensional quantities and minor-unit money
→ Purchase aggregate with one or more Items
→ Drift fresh local schema
→ atomic Purchase/Items/local event/pending queue transaction
→ rollback on invalid Item
→ close/reopen persistence
→ minimal versioned analytics registry
→ shared_beta/v1 JSON semantic fixtures
```

Reported validation:

```text
flutter analyze: passed
flutter test: 9 passed
Dart formatting/generation: passed
Python regressions: 5 passed
Windows runtime/build: host-blocked
Android runtime/build: host-blocked
iOS runtime/build: host-unavailable
```

The local tests provide executable examples for Stable Identity, Immutable Dart Model, Reusable Catalogue, Purchase Aggregate, Purchase Item, local Append-Only Event, Dimensional Quantity, Monetary Minor Unit, Historical Integrity, and Versioned Analytic. They also provide bounded evidence for deterministic normalization, offline queue preparation, and Flutter framework setup.

The evidence does not prove:

- responsive Flutter composition;
- Windows, Android, or iOS lifecycle behavior;
- authentication or authorization;
- TypeScript API behavior;
- server idempotency;
- cursor download/application;
- eventual cross-device consistency;
- schema upgrade/recovery;
- complete wire-contract compatibility;
- learner mastery.

The JSON files were classified as versioned semantic fixtures or contract examples. `catalogue_identity.json` contains the strongest input/expected-output evidence. The Purchase and sync fixtures remain incomplete: they do not yet fix every type, range, nullability rule, enum, unknown-field policy, timestamp form, or version transition. Fixture existence is not a complete Sync Protocol.

Two important correctness questions were preserved:

1. Device sequence allocation may reset to 1 on repeated registration, so monotonic device ordering is not accepted.
2. Text normalization may mishandle accented Portuguese names and has no explicit Unicode/locale/canonical-byte policy, so normalization v1 remains provisional.

Generated Drift and platform source was distinguished from handwritten design. Generated code is reviewed through its source schema/configuration and regeneration evidence; it is not independent proof of business architecture or platform execution.

Maturity decision:

```text
new concepts: none
existing maturity changes: none
local executable evidence: recorded
learner evidence: absent
```

The next learner boundary is to explain evidence classifications, local queue versus synchronization, fixture versus protocol, generated versus handwritten ownership, Unicode normalization, monotonic sequencing, and the proof required for a maturity transition.

# Current Observation Boundary

Sprint 03 Unit 01 is a successful local foundation. It does not complete the user-visible Flutter vertical slice, platform validation, synchronization protocol, or Cycle 07. Main orientation favors correcting identity/sequence defects, strengthening fixtures, and completing the local shared-client workflow before the protocol harness. Sprint 04 remains unauthorized.

---

# Observation 007 — Cycle 07 Sprint 04 Local Flutter Workflow Evidence

> Evidence sources: `DEV_STAGE/H_DDC_CODEX.md`, Main J §21, `DEV_STAGE/B_DIDACTIC.md`, current Flutter source/tests, and `contracts/shared_beta/v2/`  
> Evidence class: implemented, tested, and selectively host-validated; learner mastery not evidenced

Sprint 04 materialized the bounded local Flutter workflow anticipated by the prior checkpoint. The protected Python beta remained regression-tested while the Flutter client gained an explicit composition boundary, a multi-item Purchase form, atomic local registration, and a readable local history projection.

The strongest concept evidence is:

- a user-designable, account-private Product code is stored as display value plus normalized key;
- the Product record keeps a separately generated immutable local UUID;
- normalized Name, Brand, mode, and package facts form versioned semantic identification evidence without becoming the record identity;
- Unicode NFKC and whitespace collapse preserve readable display facts while producing deterministic comparison keys;
- PACKAGED and BULK retain different package-quantity rules;
- Purchase, Items, local append-only event, pending queue entry, and device-sequence allocation remain within one local transaction;
- repeated successful registrations produce device sequences 1, 2, 3, while a rolled-back registration consumes no sequence;
- schema v1-to-v2 migration preserves the existing Product row, assigns an explicit temporary legacy code, records the migration, and survives reopen;
- JSON Schema validates the readable v2 catalogue, Purchase, and sync-event examples structurally;
- the Flutter widget test exercises multi-item registration and the resulting history view;
- Windows analysis, tests, build, and launch smoke supplied host evidence.

The evidence boundaries are equally important. JSON Schema does not establish every cross-field business invariant or Dart/TypeScript parity. A local event and pending queue are not an API, server acknowledgement, cursor application, or cross-device convergence. The future central Product UUID remains a design possibility rather than an implemented identity. Authentication, authorization, eventual consistency, and real Sync Protocol behavior remain unimplemented. Android was blocked by absent tooling under the authorized installation boundary; iOS remains host-unvalidated. Manual UI acceptance remains open.

Maturity decision:

```text
new concepts: none
existing maturity changes: none
implementation/test evidence: recorded
learner evidence: absent
```

# Current Observation Boundary

Sprint 04 closes several local correctness and platform-evidence gaps from Sprint 03, but it does not prove distributed synchronization or learner mastery. The next learner work is to explain the three Product identities, structural schema versus semantic invariants, local atomic delivery preparation versus synchronization, and why Windows validation does not generalize automatically to Android or iOS.

---

# Observation 008 — Cycle 07 Sprint 05 Android Execution Evidence

> Date: 2026-07-12  
> Branch: `cycle-07-mobile-preparation`  
> Inspected implementation head: `ca53097b346ae42b216188dabc56a6eef45b051c`  
> Sources: `DEV_STAGE/H_DDC_CODEX.md`, Main J §24, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/E_DDC_STAGE.md`, current source/tests/Android configuration, and human-observed emulator evidence  
> Class: post-materialization Didactic reconciliation

Sprint 05 moved Android from generated target scaffolding to executed debug-development evidence. The Flutter SDK and Android SDK were separately identified; Android Studio supplied the Android tooling environment; an API 36 emulator booted; a debug APK was built, installed, and launched. The APK identifies the application as `com.gusigu.markei` with display label `Markei`.

The implementation replaced the production `windows-device` placeholder with a Drift-owned local UUID v4. Automated tests demonstrate creation in a fresh database, reuse after close/reopen, distinct UUIDs for distinct databases, sequence continuation after reopen, and preservation of historical non-UUID rows. Runtime database inspection observed one UUID Device row, one Purchase, and the sequence advanced to 2.

The human confirmed Purchase registration on the emulator. This is interaction evidence for creating a new immutable Purchase and its related local facts. It is not evidence that an existing Purchase can be replaced or “upserted”; current repository source creates a fresh Purchase UUID and inserts the Purchase. The local append-only event and pending queue remain synchronization preparation, not upload, server acknowledgement, cursor application, or convergence.

Evidence ladder reached:

```text
Flutter SDK selected
→ Android SDK/toolchain recognized
→ licences accepted
→ emulator online
→ debug APK built
→ APK installed
→ Flutter app launched
→ Purchase registration human-observed
→ app-private database inspected
→ persistence/sequence partly observed
```

The evidence does not complete the full lifecycle matrix. Phone-width widget tests exercise layout constraints and the Purchase/History path, but they are not real Android evidence for keyboard behavior, Back, rotation, background/resume, text scaling, process recreation, or visual quality. Force-stop/relaunch and database inspection provide partial persistence evidence. One emulator does not establish physical-device compatibility.

The UI remains a functional scaffold. SafeArea, scrolling, staged total, and navigation are bounded usability work, not accepted visual design or accessibility certification. Authentication, authorization, server synchronization, physical-device validation, production signing/release, and iOS remain deferred or unvalidated.

Maturity decision:

```text
new concepts: none
existing maturity changes: none
source/test/host evidence: strengthened
human-observed project execution: present
explicit learner concept evidence: absent
```

# Current Observation Boundary

Sprint 05 validates an Android debug-development slice and a persistent installation-local Device identity. The next learner boundary is to explain the evidence ladder, identity taxonomy, lifecycle distinctions, registration semantics, and the difference between emulator evidence and broader device compatibility.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# Observation 009 — Intermid Recovery ProductReference Edit Evidence

```text
Date: 2026-07-14
Branch: intermid-cycle-recovery
Inspected head: 84fc6e4e49dedc7ce629a97a78dd86486dbf0cf8
Materialization commit: 409e5f1e013a282165efd5f31bed17a396ad6543
Class: post-materialization Didactic reconciliation
Sources:
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/E_DDC_STAGE.md
  DEV_STAGE/H_DDC_CODEX.md
  [M]_STAGE/J_MAIN_STAGE.md §20–25
```

The existing-Product staged-Item edit regression demonstrates a stable project distinction: the staged line retains its original `ProductReference` and Product label while package count, purchased quantity, unit, and line total remain editable Item values.

Repository evidence shows `_editingReference` and `_editingProductLabel` captured from the staged line and reused by `_saveEditedLine()`. The focused regression registers the edited Item, asserts the original Product ID, confirms the changed Item values, and confirms that the Product row count remains one.

Recorded validation at materialization time:

- focused app widget suite: 7 passed;
- full Flutter suite: 32 passed;
- Flutter analysis: no issues;
- no final blocker.

Evidence limits:

- the regression directly exercises `ExistingProductReference`;
- preservation of `NewProductReference` follows from the shared source path but lacks its own focused regression;
- widget/in-memory evidence is not platform, restart, migration, or release acceptance;
- project implementation and test evidence are not learner-maturity evidence.

Maturity decision:

```text
new canonical concept: none
existing maturity changes: none
project distinction evidence: strengthened
explicit learner explanation or transfer evidence: absent
```

The next learner check is to explain why a Product reference identifies the reusable catalogue subject while quantity and price belong to the transaction Item, and to predict the failure caused by rebuilding identity from current form selection.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.

# Observation 010 — Cycle 10 Diagnostic Learning Registration

```text
Date: 2026-07-30
Branch: grm-guarded-provisioning-20260727
Registration anchor: f3bfd3e6829d0f42951e306c449564fb05d7cc9c
Class: bounded permanent Didactic observation
Primary evidence:
  documentation/REC_LEGACY.md — Records 001–021 and Appendix I
  documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md — mutable prefix
Historical provenance:
  J_MAIN_STAGE.md — protected Legacy_Progress, selectively recovered
Canonical reconciliation:
  documentation/sketch_notebook/didactics/02_KANBAN.md — reviewed, unchanged
Derived and checkpoint memory:
  07_GLOSSARY.md and 08_CONCEPT_MAP.md — read-only orientation, unchanged
```

This registration records the learning progression exposed by Cycle 10 without
turning the diagnostic registry into Didactic canon. It distinguishes concepts
implemented in the product, concepts represented in the interface, concepts
explained by the evidence, concepts practically demonstrated by the assays,
and actual learner comprehension. The first four are strongly evidenced within
the boundaries below. Direct learner explanation, prediction, debugging or
transfer evidence sufficient for a KANBAN maturity transition was not
recorded.

## Ordered learning progression

1. **Local-first product truth versus hosted coordination.** The early records
   showed that a durable local queue and local Product/Purchase state can exist
   while hosted readiness, provider contact or synchronization remains absent.
   Later same-Device and reciprocal two-Device assays demonstrated that the
   hosted system coordinates exchange and convergence; it does not become the
   ordinary source of local product truth. Provenance: REC 001–006, 009–013,
   018–021; J sections 2–4 and protected GCM02/GCM03 progression.

2. **Readiness versus ordinary Sync.** Hosted-connection checks established
   transport/readiness only. They did not upload, download, apply, acknowledge
   or advance Last successful Sync. REC 003–006 corrected the earlier tendency
   to read one successful readiness result as synchronization evidence.
   Provenance: REC 001–006 and Appendix I progression rows 001–006.

3. **Current action result versus preserved operation history.** Early Closure
   surfaces displayed a current failed/notApplied inspection beside a newer
   readiness result, exposing that one flat result field could not safely
   identify the operation being discussed. Operation and correlation
   fingerprints, grouped lifecycle rows and preserved attempt history restored
   the distinction between the newest action terminal and older evidence.
   Provenance: REC 001–008; Appendix I rows 001–008; J historical System
   Diagnosis and diagnostic-tightening entries.

4. **Product natural identity versus three other identities.** Cycle 10
   separated the user-visible Product code, the immutable local Product UUID,
   the natural identity used to reconcile semantically identical Products, and
   the hosted event identity used for append-only delivery. REC 018–021
   practically demonstrated that matching natural identity with different
   local representations can converge as one Product without rewriting those
   distinct responsibilities. Provenance: REC 018–021; J section 3 and
   protected R03–R05 corrective lineage.

5. **Transaction outcome versus diagnostic-persistence outcome.** A trusted
   provider response or committed local apply is a causal result. A later
   failure to persist or render diagnostics must not erase that result. REC
   019–020 exposed this through trusted upload/download evidence followed by a
   local apply conflict or unclassified runner terminal. The correction kept
   transaction truth and diagnostic-history truth separately reportable.
   Provenance: REC 019–020; Appendix I rows 018–020; J Cycle 10 capsule and
   protected corrective history.

6. **Outcome vocabulary became ordered rather than interchangeable.**
   `blocked` means a prerequisite prevented an attempted phase;
   `not-applied` means the business effect was not committed;
   `applied` means the intended local effect committed;
   `duplicate-equivalent` means replay required no second business effect
   because the equivalent fact already existed; and `unknown` means the
   available evidence cannot determine the outcome. These terms describe
   evidence-bounded outcomes, not generic error severity. Provenance: REC
   001–012 and Appendix I; J historical System Diagnosis catalogue and
   diagnostic-tightening reconciliation.

7. **Acknowledgement depends on committed local progress.** REC 019–020 showed
   acknowledgement correctly absent when local application/cursor progress was
   not durably established. REC 021 later showed authenticated acknowledgement
   only after successful convergence and on golden no-op repeats. The learner
   model is causal: provider download precedes local apply; committed apply and
   cursor truth precede acknowledgement. Provenance: REC 019–021; J section 3.

8. **Same-Device proof differs from reciprocal two-Device convergence.** GCM02
   closed only after client, Render and provider evidence agreed for one hosted
   Device. It did not prove a second Device. GCM03 then required two preserved
   clients, both directions of convergence, natural-identity reconciliation,
   stable projections, drained queues and one idempotent no-op repeat per
   Device. Provenance: REC 009–017 for the boundary and REC 021 for reciprocal
   closure; Appendix I; J sections 2–3.

9. **Automated validation differs from practical human acceptance.** Tests,
   builds and generated diagnostic contracts stabilized implementation and
   vocabulary. The controlled human/client/Render assay established practical
   convergence within its exact development scope. Neither kind of evidence
   automatically proves learner mastery, and automated evidence alone cannot
   substitute for the practical assay. Provenance: REC 018–021; J sections 3,
   7 and 8; the standing KANBAN Evidence State and Validation Boundary rule.

10. **Development acceptance differs from production acceptance.** The accepted
    terminal is two Devices, one Account, development provider. Cross-Account
    isolation, membership disable/revocation, outage and acknowledgement
    uncertainty recovery, retention, snapshot/rebootstrap and production
    deployment/lifecycle acceptance were not proved. Provenance: REC 021 and
    Appendix I material evidence ceiling; J sections 2–3 and 8.

## Important misconceptions and diagnostic corrections

| Earlier or tempting interpretation | Evidence-backed correction |
| --- | --- |
| A ready hosted connection proves Sync | Readiness proves only its bounded control path; ordinary Sync has separate upload/download/apply/acknowledgement phases. |
| One page-level result describes every visible card and attempt | Current action, last Sync result and historical attempts are separate projections and must be associated by operation evidence. |
| A local pending row means synchronization occurred | It proves durable local delivery preparation only. |
| A successful provider response means local application succeeded | Provider acceptance and local durable apply are separate causal phases. |
| A later diagnostic failure may replace a prior trusted response | Diagnostic persistence may fail, but preserved causal evidence must retain the trusted response and committed outcome. |
| Product code, Product UUID, natural identity and Event UUID are aliases | They identify different subjects or responsibilities and must not substitute for one another. |
| `duplicate-equivalent` is another failure | It is an idempotent no-second-effect result when the equivalent fact already exists. |
| `unknown` means rejected or failed | It means the supplied evidence cannot classify the outcome; safe action remains bounded until reconciled. |
| Old failures override a newer successful terminal | History remains visible, but current state follows the newest correctly associated operation terminal. |
| One Device success proves convergence | Same-Device closure and reciprocal two-Device convergence require different evidence. |
| Passing tests/builds proves human or learner acceptance | It proves only the named automated/build boundary. |
| GCM03 proves production lifecycle readiness | It proves the stated two-Device/one-Account development boundary only. |

## Terminology whose meaning stabilized during Cycle 10

- **Local-first truth:** durable local Product, Purchase, queue and projection
  state owned by the client; not a synonym for isolated or never synchronized.
- **Hosted coordination:** authenticated Account/Device exchange, ordering,
  download and acknowledgement used to converge local truths.
- **Product code:** immutable user-visible catalogue identifier; not the local
  Product UUID, natural identity tuple or hosted event UUID.
- **Natural Product identity:** deterministic semantic identity used to select
  or merge the corresponding Product subject without fuzzy auto-merge.
- **Current action result:** the terminal associated with the action currently
  being inspected; it does not erase prior operation evidence.
- **Historical operation evidence:** append-oriented diagnostic chronology that
  remains available after newer terminals.
- **Readiness:** ability to satisfy the bounded hosted-connection prerequisite;
  explicitly not proof of ordinary Sync.
- **Acknowledgement:** a post-apply declaration of committed local cursor
  progress, not proof of all-Device convergence or backup.
- **Golden no-op repeat:** an empty-queue ordinary Sync that downloads and
  acknowledges without submitting or creating duplicate business effects.

## Practical assay lessons

- Freeze pre-action client, queue, sequence and evidence ceilings before
  pressing a control.
- Associate client and server evidence through sanitized operation/correlation
  fingerprints rather than timestamps or page position alone.
- Keep readiness, Diagnostics, ordinary Sync, Retry and Recovery as different
  actions with different mutation and proof boundaries.
- Preserve older failures for causal learning while using the newest correctly
  associated operation to state current outcome.
- Stop when an outcome is unknown, a cursor/apply result is not durable, or
  expected counts/identity relationships disagree.
- Demonstrate reciprocal convergence by checking both clients, stable
  Catalogue/History projections, drained queues and idempotent repeats.
- Treat client declarations as one evidence source; server logs and provider
  inspection supply different evidence and cannot be inferred from the client.
- Read-only or rolled-back provider inventory establishes only the captured
  point in time. REC 021 intentionally does not claim a fresh final
  provider-table recount.

## Comprehension evidence and boundary

The human assay sequence demonstrates practical adherence to bounded action
packets: preserved clients were retained, prohibited recovery/provider repair
was avoided, reciprocal actions were sequenced, and final projections were
compared. This is evidence of disciplined practical participation and of
confusions being corrected through successive records.

It is not, by itself, direct evidence that the learner can independently
explain, predict, debug or transfer every concept above. The repository records
no explicit learner explanation evaluated against the KANBAN rubric.
Therefore:

```text
CONCEPTS_IMPLEMENTED_OR_REPRESENTED=YES
CONCEPTS_EXPLAINED_BY_EVIDENCE=YES
CONCEPTS_PRACTICALLY_DEMONSTRATED=YES_WITHIN_DEVELOPMENT_SCOPE
DIRECT_LEARNER_MASTERY_EVIDENCE=ABSENT
KANBAN_TRANSITION=NONE
```

## Accepted evidence ceilings

```text
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
FINAL_POST_NO_OP_PROVIDER_TABLE_RECOUNT=NOT_COLLECTED
PRODUCTION_ACCEPTANCE=ABSENT
```

The accepted GCM03 terminal does not prove:

- two-Account isolation;
- membership disable or Device revocation;
- outage and acknowledgement-uncertainty recovery;
- retention, snapshot or rebootstrap behavior;
- production deployment, lifecycle, availability or acceptance.

Those questions remain outside this Cycle 10 Didactic registration and are
deferred to C12-PHASE02.

## Unresolved learning questions

1. Can the learner explain, without consulting the UI, why Product code, local
   UUID, natural identity and Event UUID must remain separate?
2. Can the learner predict when each of blocked, not-applied, applied,
   duplicate-equivalent and unknown is correct from a short lifecycle trace?
3. Can the learner distinguish a trusted provider response, committed local
   apply, diagnostic persistence and displayed terminal when they disagree?
4. Can the learner derive why acknowledgement must wait for committed cursor
   progress?
5. Can the learner design the minimum additional evidence for two-Account
   isolation, revocation, outage recovery and rebootstrap without overclaiming
   production acceptance?
6. Can the learner explain why an older preserved failure remains valuable
   without overriding the newest successful operation terminal?

## PRC-01 classification summary

| Candidate claim | Current state | Evidence and boundary | Semantic owner / destination | Result |
| --- | --- | --- | --- | --- |
| Cycle 10 produced an ordered learning and misconception-correction history | implemented and validated within Records 001–021 | REC chronology plus J historical provenance | Didactic observational / this Lecture Register | appended |
| Identity, outcome, readiness, acknowledgement and evidence-ceiling distinctions are stable teaching material | accepted project meaning | REC 001–021, J Cycle 10 capsule, existing KANBAN identities | existing Didactic canon; observational interpretation here | no new concept identity |
| Existing concept maturity should change | candidate | no direct learner explanation, prediction, debugging or transfer record | `02_KANBAN.md` | rejected; unchanged |
| GCM03 supports production or lifecycle maturity | contradicted | REC 021 and Appendix I explicitly exclude those families | no canonical destination | rejected |
| Runtime diagnostic rows should become Didactic canon | contradicted | runtime registry owns codes; REC owns chronology | no Didactic canonical destination | rejected |

# Current Observation Boundary

Cycle 10 is registered in permanent Didactic history at the exact same-Device
and reciprocal two-Device development boundaries. This append does not claim
production readiness, operational acceptance, architecture selection, learner
mastery or a KANBAN maturity transition. Derived and checkpoint memory were
intentionally left unchanged by the human-narrowed registration scope.


---

# Observation 011 — C11-PH01-S01 Meaning and Learning Event

```text
Date: 2026-07-30
Branch: grm-guarded-provisioning-20260727
Implementation head: 1c7df53c095f4e7c1d85f278ba16c21fd95b25e6
Class: bounded C11 presentation-meaning observation
Primary evidence:
  documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
  documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md — mutable prefix §§2, 5.2, 7–8
Cycle 10 relationship:
  Observation 010 remains the sole Cycle 10 learning-history registration
Maturity effect: none
```

This event records the meaning made visible by C11-PH01-S01 without treating
implementation, widget tests, builds or Main direction as learner mastery.
It is distinct from Observation 010: Cycle 10 established synchronization and
evidence-boundary vocabulary; this event records the first bounded presentation
convergence for Home, Lists and the responsive shell.

## Meaning represented by the implementation

- Navigation uses ordinary destination names rather than internal maturity or
  planning labels.
- Home presents Markei as a local-first tool: register a Purchase first, then
  inspect reusable Products, estimated Lists and Purchase history.
- `Register purchase` is the primary Home action. `View lists`, `Browse
  catalogue` and `Open purchase history` remain secondary.
- Lists is an estimated projection from registered Purchase history. It is not
  recorded inventory and does not claim measured remaining stock.
- `Estimate` names a derived projection; `Approximate` qualifies uncertain
  values; `Unavailable` means no usable estimate is present; `Not enough
  history` means one compatible observation cannot form an interval; and
  `Expected ended` is a projection state, not a recorded depletion fact.
- Analytics is reserved for C11-PH02 and does not imply active calculations or
  telemetry.
- Audit is reserved for C11-PH03 and does not imply that the existing
  diagnostic system has migrated into a user-facing audit feature.

## Readable state distinctions

Lists represents six different conditions rather than one generic empty/error
surface:

1. loading — the local projection request is in progress;
2. read error — the local read failed and existing local data was not changed;
3. first-use empty — no projection data exists yet;
4. filtered empty — data may exist, but the current search has no match;
5. insufficient history — a Product exists but lacks enough intervals;
6. populated data — summary and responsive table/card projections are available.

The Retry action belongs only to the read-error state. Its wording states that
it repeats a read-only local projection request and that local data was not
changed. It is not Sync, recovery, replay or provider mutation.

## Responsive and accessibility meaning

Wide tables and compact cards are two presentations of the same local
projection, search and sort state. Responsive adaptation may change density,
navigation container and grouping, but it must preserve information meaning,
status semantics and reachable actions.

Automated evidence covers exact 599/600/1023/1024 breakpoints, selected
destination preservation, compact More reachability, medium tooltips, shared
table/card state and a 200-percent text-scale Home render without a Flutter
overflow/exception.

The following remain unperformed and therefore unaccepted:

- Windows Narrator;
- Android TalkBack;
- keyboard-only manual traversal;
- real-device visual review;
- human Windows or Android page-comprehension acceptance;
- approved pixel/golden parity.

## Learning and acceptance boundary

```text
ORDINARY_NAVIGATION_LABELS=IMPLEMENTED_AND_TEST_EVIDENCED
HOME_LOCAL_FIRST_HIERARCHY=IMPLEMENTED_AND_TEST_EVIDENCED
LISTS_PROJECTION_VOCABULARY=IMPLEMENTED_AND_TEST_EVIDENCED
LISTS_STATE_DISTINCTIONS=IMPLEMENTED_AND_TEST_EVIDENCED
RESPONSIVE_INFORMATION_EQUIVALENCE=AUTOMATED_EVIDENCE_ONLY
HUMAN_PLATFORM_ACCEPTANCE=ABSENT
DIRECT_LEARNER_COMPREHENSION_EVIDENCE=ABSENT
KANBAN_TRANSITION=NONE
```

Passing builds demonstrate that the bounded presentation compiles for Windows
and Android. Widget tests demonstrate named rendering and state contracts.
Neither evidence class proves that a learner can independently explain the
terms, that assistive technologies announce them correctly, or that people
successfully comprehend the pages on real devices.

## Remaining PH01 and inherited boundaries

Catalogue, Purchase and History recomposition remain later C11-PH01 work.
Functional Analytics remains C11-PH02. Settings/Audit redesign and Closure
capability disposition remain C11-PH03. Business rules, Sync, diagnostics,
recovery and provider behavior were unchanged by S01.

## Misconceptions prevented

| Tempting interpretation | Evidence-qualified correction |
| --- | --- |
| Lists records what is physically in storage | Lists estimates from Purchase history; it is not measured inventory. |
| `Expected ended` records depletion | It is a projection state. |
| Retry may change or recover data | This Retry repeats a read-only local request; the error copy states local data was not changed. |
| Compact cards are a reduced feature set | Cards and wide tables preserve the same information and actions within the tested contract. |
| A reserved Analytics destination means Analytics exists | Calculations remain PH02 and telemetry is not implied. |
| Audit already owns diagnostics | Audit is reserved for PH03; diagnostic ownership is unchanged. |
| Breakpoint and text-scale tests prove accessibility acceptance | Narrator, TalkBack, keyboard-only and real-device evidence remain absent. |

# Current Observation Boundary

C11-PH01-S01 supplies a stable presentation vocabulary and automated evidence
for the shell, Home and Lists. It does not complete PH01, establish learner
mastery, prove human platform acceptance, activate Analytics/Audit, or broaden
Cycle 10 synchronization acceptance.

# Observation 012 — C11-PH01-R01 and C11-PH02 Meaning Registration

```text
Date: 2026-07-31
Branch: grm-guarded-provisioning-20260727
Class: implementation/evidence learning event
Implementation: 20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6
Main reconciliation: 0bfc02e8363d8119469a5e8627d8350fa97790b4 section 9
KANBAN transition: NONE
```

## Ordered learning event

1. The five learner destinations became reachable with unambiguous History
   selection and detail meaning.
2. History learned only to transfer typed Purchase-ID context; calculation
   remained owned by Analytics.
3. Analytics became deterministic, local and Account-scoped, with session-local
   cards above a complete supporting evidence matrix.
4. Each card named one determinant—Product, Purchase, Store or UTC Time—one or
   more relational variables, one operation and optional Time conditions.
5. The learner-visible evidence vocabulary stabilized at twelve fields:
   Purchase, date/time, Product, Brand, Store, purchased by, purchased for,
   payment method, quantity, unit price, line total and promotion.
6. Unsupported or invalid facts stayed visibly unavailable. The implementation
   did not repair missing raw facts or import remote/external facts.
7. Evidence traceability stabilized: matrix selection initializes a card, card
   evidence focuses the matrix, and reset restores all current evidence.
8. Wide and compact arrangements preserved semantic parity while changing
   density and reading order.

## Operation meanings and corrected misconceptions

| Tempting interpretation | Evidence-qualified correction |
| --- | --- |
| Sum means a Purchase total | Sum is the total contribution of the named variable in the named scope. Purchase total and line total remain distinct. |
| Mean is an estimate | Mean is the arithmetic average of valid named contributions; unavailable inputs do not become estimates. |
| Difference means change | Difference is comparison B minus baseline A. It is not change unless A and B explicitly define such a comparison. |
| Percentage means percentage change | Percentage is a named part of a named containing whole. Percentage change is outside this contract. |
| A zero denominator is zero percent | It is a typed unavailable outcome. |
| Overflow can be clipped or approximated | It is a typed unavailable outcome; the factual input is not repaired. |
| Product and Purchase are interchangeable determinants | Product groups Item contribution; Purchase retains transaction context. |
| Store grouping already compares Stores | Grouping forms Store evidence sets; comparison requires an explicit operation and A/B meaning. |
| An interpretation explains why something happened | It states the factual result, scope, evidence count and period. It does not infer cause or recommend action. |
| History calculates before opening Analytics | History transfers typed Purchase IDs only. |

## Scope and traceability learned

- evidence pages contain 100 rows;
- selected scope is bounded to 500 Purchase IDs;
- cards are session-local and leave recorded Purchase facts unchanged;
- selected and filtered evidence are distinct scopes;
- Time can be the determinant or an optional UTC condition;
- every available result names its evidence count and applicable period;
- partial, missing and unavailable evidence remains visible rather than silently
  disappearing.

## Evidence classification

The implementation commit, focused tests and Windows/Android builds establish
representation and execution of the named contract. They separately establish:

- automated operation/state behavior;
- automated wide/compact semantic parity and keyboard/focus behavior;
- build completion for the recorded targets.

They do not establish screenshots, Narrator, TalkBack, locale variation,
keyboard-only human use, real-device acceptance or learner comprehension.
Those evidence classes are `NOT_PERFORMED`.

## Stable exclusions

No charts, forecasting, prediction, rankings, recommendations, causal claims,
telemetry, remote/Sync-derived Analytics, external facts or raw-fact repair were
introduced. Analytics does not broaden Cycle 10 provider or production
acceptance.

## Remaining learning questions

- Can a learner explain determinant versus condition without relying on the UI?
- Can a learner predict the result of Difference B minus A and identify the
  baseline correctly?
- Can a learner identify the containing whole for Percentage and reject
  percentage-change language?
- Can a learner trace a card result back to the correct Purchase/item evidence
  across both wide and compact layouts?
- Do screen-reader, locale, real-device and human comprehension assays preserve
  these distinctions?

This event records concept representation and project execution, not learner
mastery. No KANBAN maturity transition is authorized.
