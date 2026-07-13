# A_OPERATIONAL — Cycle 08 Round C08-R01

> Role: Operational Chat [O]
> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01
> Status: FUNCTIONAL STAGING — FOR MAIN RECONCILIATION
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> HEAD: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Scope: investigation and evidence only; no implementation authority

## 1. Methodology loaded and authority check

The complete Cycle 08 boot route was consulted in the required order: root `AGENTS.md`, `INDEX.md`, `PROMPT_COLLECTION.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, `CHAT_BEHAVIOUR.md`, and `METHOD_GLOSSARY.md`.

PRI-O establishes Operational ownership of execution, environments, reproducibility, runtime, persistence, validation, operational cost, failure states, and implementation evidence. PMC-01 confirms that this chat may write only the explicitly authorized functional stage. PMC-02 confirms the route `A/B/C ↔ J ↔ provisional D/E/F ↔ renewed A/B/C`, with D/E/F non-executable until final human/Main activation. MSU-02 authorizes this read-only investigation and replacement of A only.

Prohibited here: application source, dependencies, schemas, tools, infrastructure, permanent memory, methodology, J, D/E/F, G/H/I, architecture selection, Didactic promotion, commit, or push.

Knowledge-state discipline: repository and G evidence may establish implemented or tested facts; generated host structure is not runtime validation; build/startup is not complete interaction acceptance; proposed Cycle 08 work remains staged, not accepted implementation.

## 2. Branch and repository-state verification

GitHub branch lookup confirmed `cycle-08-shared-client-product-beta`. Comparing the expected commit with the branch returned `identical`, `ahead_by: 0`, and `behind_by: 0`; therefore the remote branch HEAD is exactly `60105fab8eac4ac858d8a36674e358737e1c9f98`.

The supplied local workspace was not a usable checkout, so local `git status`, `git branch`, and `git pull` could not be executed. All investigation reads were therefore made through GitHub with the branch ref explicitly pinned. This is an environment limitation, not repository drift. No default-branch content or uploaded ZIP was used.

Notebook contradiction: older headers in `00_PROJECT_STATE.md` and `06_SESSION_SCHEME.md` still name the Cycle 07 branch/baseline, while their latest temporal sections correctly activate Cycle 08 on the present branch. Latest temporal sections control recovery, but Main should eventually refresh those headers.

## 3. Repository topology and Operational component inventory

The branch exposes five relevant boundaries:

1. protected Python/PySide6 desktop application (`main.py`, `app/`, `tests/`, `requirements.txt`);
2. Flutter shared client (`clients/markei_flutter/`), including handwritten Dart, generated Drift/plugin code, tests, and Windows/Android hosts;
3. language-neutral contracts/fixtures used for normalization and shared-beta semantics;
4. Sketch Notebook methodology, continuity, domain memory, and staging;
5. local runtime/build outputs, which must remain untracked and data-isolated.

| Exact path/component | Responsibility and ownership | Present state/evidence | Failure modes, debt, Cycle 08 relevance |
| --- | --- | --- | --- |
| `main.py`, `app/main.py` | Handwritten protected Python/PySide6 entrypoints | Still present; five Python regressions previously passed | Must remain runnable and must not open Flutter data. Regression gate throughout Cycle 08. |
| `requirements.txt` | Handwritten Python dependency boundary | Minimal PySide6 requirement | Unpinned dependency resolution reduces long-term reproducibility; packaging baseline remains protected. |
| `clients/markei_flutter/pubspec.yaml` | Handwritten Flutter dependency and SDK contract | Dart `^3.12.2`; Drift, path provider, SQLite, UUID, normalization and test tooling declared | Caret ranges plus a committed lockfile are usable for application builds; upgrades must be deliberate. No new Cycle 08 package is yet justified. |
| `clients/markei_flutter/pubspec.lock` | Generated dependency resolution, repository-owned | Locks the resolved graph, including Drift 2.34.x in the inspected branch | Regeneration can alter build behavior; require clean diff and full regression gates. |
| `clients/markei_flutter/lib/main.dart` and `lib/app/` | Handwritten Flutter bootstrap/composition | App-private composition is created before `runApp` | Initialization failure needs visible, privacy-safe failure handling; lifecycle close/reopen remains incomplete evidence. |
| Flutter domain/application/persistence sources under `clients/markei_flutter/lib/` | Handwritten business workflow and Drift adapter; `.g.dart` files are generated | Account-private catalogue, Store, Purchase/Items, local event queue, History and Device UUID foundation are implemented | Catalogue reuse, Store workflow, staged edit/remove/review, detailed History, price comparison, large-data behavior and recovery remain Cycle 08 work/evidence. |
| Drift schema/migration and generated companions under the Flutter client | Handwritten schema/migration declarations plus generated companions | Schema v2 migration, atomic Purchase transaction, rollback, close/reopen, monotonic sequence and Device persistence were previously tested | Migration chain has only bounded evidence; never silently recreate/reset on migration failure. Backup/export decision is still open. |
| `clients/markei_flutter/test/` | Handwritten unit/widget/integration-style local tests | Latest accepted checkpoint records 27 Flutter tests passing | Automated tests do not cover complete keyboard, Back, focus, rotation, resume, restart, larger text, device diversity or production packaging. |
| `clients/markei_flutter/windows/` | Mostly Flutter-generated host with repository-owned configuration | Release build and startup smoke passed; Windows local workflow human-validated | No production installer/update channel for Flutter, signing, crash recovery, or broad accessibility evidence. Cycle 10 distribution boundary. |
| `clients/markei_flutter/android/app/build.gradle.kts` | Generated host adapted by hand | Stable `com.gusigu.markei`, SDK 36, Java 17; debug APK/install/launch previously validated | Release still uses debug signing and explicitly lacks production signing. Physical-device breadth and full lifecycle remain unvalidated. |
| `clients/markei_flutter/android/app/src/main/AndroidManifest.xml` | Generated host configuration, repository-owned | Markei label, `singleTop`, `adjustResize`, rotation/keyboard config changes, no broad storage permission observed | Manifest flags do not prove keyboard, Back, focus, rotation, process recreation or resume behavior. Manual Cycle 08 matrix required. |
| shared-beta contracts/fixtures | Handwritten language-neutral semantic boundary | v2 normalization/identity and structural examples previously tested | They are not yet a cloud wire protocol or synchronization proof. Preserve through Cycle 08; Cycle 09 activates protocol use. |
| `documentation/sketch_notebook/` | Mixed protected methodology, Main continuity, domain memory and staging | Latest 00/06 sections activate Cycle 08 investigation; A was cleared for replacement | Header/path drift must be reported, not repaired here. `LEGACY_RECONCILIATION.md` was not loaded. |

The GitHub connector exposed pinned file inspection but not a branch-recursive tree endpoint. Consequently the topology above is the verified operational boundary inventory, not a claim that every tracked generated host file was enumerated line-by-line. A later Codex/local checkout should attach `git ls-files` evidence before implementation.

## 4. Verified implementation and evidence state

Accepted carried evidence:

- Flutter 3.44.6 / Dart 3.12.2 environment recorded in Cycle 07 evidence;
- 27 Flutter tests passed;
- Windows Flutter build passed and the local workflow was human-validated;
- Android debug build, install, launch, Purchase registration, and app-private persistence were runtime-evidenced;
- five Python regressions passed;
- persistent installation Device UUID, monotonic sequence, Drift v2 migration, atomic Purchase/Items/event commit, rollback, and bounded close/reopen behavior were implemented/tested;
- protected Python/PySide6 source and ordinary database remain the rollback/reference boundary.

Not established:

- complete Catalogue browse/search/reuse or duplicate-warning journey;
- Store browse/search/select/create and duplicate behavior;
- staged Item edit/remove/cancel/review and duplicate-submit prevention;
- detailed History and first versioned personal price comparison;
- large Catalogue/History responsiveness or measured performance;
- full keyboard, Back, focus, rotation, background/resume, larger-text and cold-relaunch matrix;
- corrupted/missing/unreadable database recovery;
- export, import or backup restoration;
- physical-device breadth, production signing, packaged distribution, upgrade channel, diagnostics/support or privacy operations.

## 5. Cycle 08 operational capacity

The repository can support an additive local-first product-beta implementation without cloud infrastructure. Existing composition, Drift persistence, atomic Purchase transaction, local History foundation, tests, Windows host and Android debug host are sufficient starting capacity.

The economical implementation sequence is:

```text
responsive shell and state/error harness
→ Catalogue and Store selection/create
→ staged Purchase edit/remove/review
→ detailed History
→ versioned price comparison
→ migration/reopen/recovery and volume checks
→ Windows/Android manual acceptance
```

Each unit should retain the Python regressions and avoid dependency/schema expansion unless the unit proves it necessary.

## 6. Carried lifecycle and Device debt

Mandatory carried lifecycle evidence:

- narrow portrait and landscape without overflow;
- keyboard does not hide the active field/action; focus order and validation recovery are coherent;
- Android Back dismisses transient UI first and does not silently discard staged Purchase data;
- rotation and window resize preserve or intentionally reset staged state with explicit behavior;
- background/resume preserves durable facts and defines staged-state behavior;
- process termination and cold relaunch preserve registered Purchases/History;
- larger text, safe areas, scrolling, and tap targets remain usable;
- database close/open and migration failures never silently reset local data.

Device UUID is accepted only for the bounded local prototype. Before Cycle 09 multi-device synchronization, define one current installation relation, uniqueness/concurrency rules, recreation/uninstall behavior, and sequence allocation under concurrent access. Cycle 08 must avoid presenting local Device identity as account authentication.

## 7. Proposed validation gates and costs

| Gate | Evidence | Relative cost |
| --- | --- | --- |
| Repository safety | exact branch/HEAD; `git status`; `git ls-files`; generated diff review; protected Python/database unchanged | Low once a checkout exists |
| Static/generated consistency | `dart format --output=none --set-exit-if-changed .`; `flutter analyze`; Drift generation check | Low–medium |
| Automated regression | complete Flutter tests plus `python -m unittest discover -s tests` | Low–medium |
| Transaction/retry | invalid Item rollback; double-submit/retry; no partial facts/event; sequence continuity | Medium |
| Migration/reopen | fresh DB, previous schema fixture, close/reopen, process restart, failed migration without reset | Medium |
| Product workflow | Catalogue/Store reuse/create, two-item stage/edit/remove/review/register, History detail, comparison | Medium; widget plus manual |
| Responsive/lifecycle | Windows narrow/wide; Android portrait/landscape, keyboard, focus, Back, background/resume, restart, larger text | High; repeated manual matrix |
| Volume/performance | seeded tiers such as 100/1,000/10,000 Products and Purchases; record launch, search, History and detail latency/memory | Medium–high; define budgets before acceptance |
| Platform build | debug Android APK/run and Windows release build/startup | Medium |
| Production packaging | release signing, installer/update, distribution and upgrade rehearsal | High; deferred to Cycle 10 |

Recommended pre-implementation command baseline from `clients/markei_flutter`:

```text
flutter doctor -v
flutter devices
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter build apk --debug
python -m unittest discover -s tests
```

Run host builds only on hosts that support them and record versions, duration, warnings, device class, and whether evidence was automated or human-observed.

## 8. Migration, recovery, backup/export boundaries

- Flutter continues using app-private local storage; no broad Android storage permission should be added.
- Cycle 06 Python SQLite and Flutter Drift databases remain separate. No direct legacy conversion is authorized.
- Every schema change needs an explicit old-version fixture, forward migration, rollback/failure test, and no-silent-reset invariant.
- Registered raw facts remain authoritative; projections and price analytics must be rebuildable and versioned.
- Android uninstall/data-clear destroys app-private local-only data unless export/backup exists; this must be plainly documented before beta acceptance.
- Cycle 08 must make a human decision between: (A) supported export plus restore rehearsal; (B) documented device-local beta with explicit destructive-loss warning. A UI button without restoration evidence is not an accepted backup.
- Export should be user-initiated, bounded, integrity-checkable, privacy-conscious and independent of privileged cloud credentials. Import/restore may be deferred only if the beta promise says so explicitly.
- Recovery must distinguish missing database, migration failure, SQLite corruption, insufficient storage, permission/path failure, and user-requested reset. Diagnostics must not expose real Purchase contents.

## 9. Blockers, contradictions, and failure states

1. No usable local checkout was supplied, so current commands/tests and a recursive tracked-file inventory could not be executed in this investigation.
2. Main continuity headers retain Cycle 07 metadata although their latest sections correctly activate Cycle 08.
3. Operational checkpoint drift noted at Cycle 07 materialization may remain; latest Main continuity and repository evidence supersede it for this stage.
4. Product-beta performance budgets and seed volumes are undefined.
5. Backup/export and restore promise is undecided.
6. Staged Purchase survival across navigation, rotation, backgrounding and process death is undefined.
7. Error/retry semantics must prevent duplicate or partial Purchases while keeping user input recoverable.
8. Android release uses debug signing; public distribution is forbidden at this state.
9. No evidence supports production diagnostics, support workflow, privacy deletion, or upgrade recovery.

## 10. Cycle 09/10 deferrals

Cycle 09: verified account, immutable Account UUID, TypeScript API, Neon/Postgres, authentication/authorization, idempotent upload, cursor download, bootstrap/convergence, multi-device current-installation invariant and network retry.

Cycle 10: production secrets, privacy/deletion operations, finalized export/import and disaster recovery, observability/support, release signing, Android distribution, Flutter Windows installer/update path, upgrade testing, controlled public beta, and broader device coverage.

Cycle 08 must preserve these boundaries but must not activate them.

## 11. Human questions

1. Must Cycle 08 beta include a supported export-and-restore workflow, or is an explicit local-only data-loss warning acceptable until Cycle 10?
2. Should staged, unregistered Purchase data survive only in-app navigation/rotation, or also process death?
3. Which physical Android device classes and Windows display/scaling combinations are mandatory for Cycle 08 acceptance?
4. What response-time budgets and maximum Catalogue/History volumes define an acceptable local beta?
5. Is manual Windows/Android acceptance expected after every feature sprint or only at bounded integration gates plus final Cycle acceptance?

## 12. Recommendations to Main

- Keep Sprint 01 read-only and reconcile A/B/C before any D/E/F.
- Split later D/E/F by bounded product units and require the provisional banner until final activation.
- Require a clean local checkout and `git ls-files` inventory as the first Codex preflight.
- Make lifecycle/staged-state behavior, backup promise, test volumes and performance budgets explicit before implementation.
- Preserve the protected Python beta and both database boundaries as rollback evidence.
- Require automated transaction/migration tests before manual UI acceptance and distinguish debug-host evidence from production readiness.
- Do not introduce cloud, auth, signing/distribution, or broad analytics into Cycle 08.

## 13. Exact next staging route

```text
C08-R01 A_OPERATIONAL
↔ C08-R01 B_DIDACTIC and C_DESIGN
→ Main reads A/B/C and writes/enriches J_MAIN_STAGE
→ Main prepares provisional D/E/F carrying:
   Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
→ O/A/D renew A/B/C against J and provisional D/E/F
→ Main enriches J and D/E/F
→ explicit final human/Main activation
→ Codex materialization
→ G/H/I evidence
→ permanent-domain reconciliation and Main continuity
```

Until explicit activation, no D/E/F content is executable.

<!-- ROUND_MARKER:C08-C08-R02-O-2026-07-13 -->
# Cycle 08 Round C08-R02 — Operational Investigation

## 1. Role, authority, branch, and HEAD

Operational Chat [O] executed this append-only exploratory round against `gus-i-gu/markei`, branch `cycle-08-shared-client-product-beta`, inspected HEAD `44b50788952947cfb3d23290192ebb3521d3a816`. GitHub comparison showed the branch identical to, and therefore descending from, the expected starting HEAD.

Authority is limited to repository investigation and this cumulative A append. Current J and `D_OPS_STAGE.md` remain provisional. No source, test, dependency, schema, generated code, host, tool, permanent memory, J, D/E/F, G/H/I, or Main-continuity change is authorized.

## 2. Prompts executed and recovery result

Executed complete indexed definitions: PRI-O, PMC-01, PMC-02, ERI-01, and FCA-02.

- PRI-O: confirmed execution/evidence responsibility and A-only staging ownership.
- PMC-01: confirmed current exploration state, prohibited surfaces, and checkpoint/J/A/D recovery route.
- PMC-02: confirmed `A/B/C → J → provisional D/E/F → renewed A/B/C`; promotion and materialization remain inactive.
- ERI-01: inspected repository truth retrospectively and classified exact symbols and operational effects.
- FCA-02: preserved all C08-R01 content and appended this marked round.

No full canonical-methodology reopen was required: PROMPT_COLLECTION resolved current routing and authority. Retained contradiction: `INDEX.md` references `J_MAIN_STAGE.md`, while the active repository path is `[M]_STAGE/J_[M]_STAGE.md`. This round reports but does not repair methodology/navigation drift.

## 3. Repository surfaces inspected

Pinned branch reads covered:

- `clients/markei_flutter/lib/main.dart`;
- `clients/markei_flutter/lib/app/markei_composition.dart`;
- `clients/markei_flutter/lib/app/markei_app.dart`;
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`;
- `clients/markei_flutter/lib/app/pages/history_page.dart`;
- `clients/markei_flutter/lib/application/catalogue_queries.dart`;
- `clients/markei_flutter/lib/application/register_purchase.dart`;
- `clients/markei_flutter/lib/application/purchase_history.dart`;
- `clients/markei_flutter/lib/domain/catalogue/product.dart`;
- `clients/markei_flutter/lib/domain/purchase/purchase.dart`;
- `clients/markei_flutter/lib/domain/shared/ids.dart`;
- `clients/markei_flutter/lib/domain/shared/money.dart`;
- `clients/markei_flutter/lib/domain/shared/quantity.dart`;
- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`;
- `clients/markei_flutter/lib/infrastructure/local/local_device_identity_repository.dart`;
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`;
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`;
- `clients/markei_flutter/test/local_purchase_repository_test.dart`;
- Flutter manifest/lockfile and Windows/Android hosts previously indexed in C08-R01;
- protected `main.py`, `app/main.py`, `requirements.txt`, and prior Python regression boundary;
- latest 00/05/06 Cycle 08 state, J, D_OPS, A, and Operational checkpoint.

Generated Drift output was treated through its handwritten `@DriftDatabase` generator source and build-runner boundary, not read line-by-line.

## 4. New component, function, and object evidence

| Classification | Exact symbol/path | Operational evidence and consequence |
| --- | --- | --- |
| newly evidenced | `MarkeiComposition.appPrivate()` in `app/markei_composition.dart` | Opens `LocalDatabase.appPrivate()`, builds one `LocalQueryRepository`, hard-codes `AccountId('local-account')`, and resolves a persistent Device before `runApp`. Startup database/identity failure occurs before product UI and has no inspected user-facing recovery surface. |
| newly evidenced | `_selectedIndex`, `_refreshSignal`, `IndexedStack` in `app/markei_app.dart` | Navigation and refresh state live for the mounted app state only. Two fixed destinations exist: Purchase and History. IndexedStack preserves mounted page/controller state across tab changes, but no restoration evidence exists for process death. |
| newly evidenced | `_items: List<PurchaseItemDraft>` and controllers in `purchase_page.dart` | Purchase draft is mutable widget state. It survives IndexedStack tab switching, but no edit/remove/cancel operation exists and lifecycle/process restoration is absent. |
| newly evidenced | `_addItem()` | Always creates `NewProductReference(draft)`; it queries similarity, then stages the Item regardless of warnings. Existing Product selection/reuse is not exposed. Warning is advisory text after staging, not a pre-stage explicit choice. |
| newly evidenced | `_productDraft()` and `_addItem()` | Both Product and purchased quantity are hard-coded to `MeasurementKind.mass`; volume/count domain support exists but is unreachable in this UI. |
| newly evidenced | `_registerPurchase()` | Generates no submission identity and has no busy/in-flight flag. Multiple calls can reach `registerPurchase`; each repository call creates fresh Purchase/Event UUIDs. Current local atomicity does not prevent duplicate logical submission. |
| newly evidenced | `_message = error.toString()` | Validation, persistence, migration, and unexpected failures are not classified; implementation exception text becomes user-visible and is not a privacy-safe diagnostic contract. |
| newly evidenced | `_parseMinorUnits(String)` | Accepts only unsigned amounts with at most two decimals and assumes BRL/two-decimal display in this UI. Domain `Money` only asserts three-character currency, so runtime validation remains uneven. |
| newly evidenced | `RegisterPurchaseCommand` | Contains account/device/store/time/currency/items but no attempt/submission UUID. Adding durable retry identity changes application contract and likely persistence schema. |
| newly evidenced | `LocalPurchaseRepository.registerPurchase()` | One Drift transaction resolves/creates Store and Products, validates aggregate, inserts Purchase/Items/Event/PendingEvent, allocates sequence, and returns IDs/sequence. Rollback is real; idempotent retry is absent. |
| newly evidenced | `_resolveStore()` | Matches exact trimmed `displayName` within account. Stores has no account/name unique key, normalization, or branch identity; concurrent or case/spacing variants can create distinct Stores. |
| newly evidenced | `_resolveProduct()` | Existing references enforce account ownership. New drafts reuse exact `exactIdentityKey`; duplicate normalized user code throws. This supports J’s exact-reuse/advisory-similarity distinction, but the current UI never sends `ExistingProductReference`. |
| newly evidenced | `_allocateDeviceSequence()` | Reads and increments inside the surrounding registration transaction. Unique `accountId/deviceId/deviceSequence` protects sequence reuse, but selection of the active Device remains separate prototype debt. |
| newly evidenced | `LocalDeviceIdentityRepository.loadOrCreateDeviceId()` | Transaction inserts local account, scans only the earliest 20 Devices, and returns the first UUID-v4 match; otherwise creates one. No explicit current-installation relation exists. |
| newly evidenced | `LocalDatabase.appPrivate()` | Uses `getApplicationSupportDirectory()/markei_shared_beta.sqlite` and background SQLite. This supports app-private storage; it provides no export/restore, corruption handling, or user-selectable recovery path. |
| newly evidenced | `LocalDatabase.migration` | Schema v2 supports only v1→v2; other upgrade paths throw `UnsupportedError`. It creates synthetic legacy Product codes and ledger evidence. No failure recovery or backup boundary is implemented. |
| newly evidenced | Drift tables/keys in `local_database.dart` | Products uniquely constrain account+normalized code and account+exact identity; SyncEvents constrain account+device+sequence. Stores lack reuse uniqueness; Purchases lack submission/attempt uniqueness. |
| newly evidenced | `LocalQueryRepository.listRecentPurchases()` | Limits to 50 summaries and performs a separate count query per Purchase (N+1). No Purchase detail, Product observation query, pagination/cursor, or analytics query exists. |
| newly evidenced | `HistoryPage.build()` | `FutureBuilder` maps loading, error, and genuine empty data to “No purchases registered.” It shows Store/item count/total only; occurrence time is returned by the port but not displayed. |
| retained/validated prior | `local_purchase_repository_test.dart` | Tests atomic facts/event persistence, invalid-item rollback, file close/reopen, and fixture envelope. It does not test duplicate submissions, existing Product selection UI, Store concurrency, migration failure, History detail, volume, or lifecycle. |

## 5. Retained C08-R01 conclusions

Retained:

- protected Python/PySide6 and Flutter databases remain separate rollback boundaries;
- Flutter composition, Drift transaction, domain values, query ports, Windows/Android hosts, and existing tests provide enough capacity for additive Cycle 08 work;
- atomic Purchase registration is implemented, while safe duplicate-submit identity is not;
- lifecycle, keyboard, Back, focus, rotation, resume, restart, larger text, performance, recovery, and backup remain evidence debt;
- Device selection is prototype-only;
- cloud synchronization, production signing/distribution, iOS, and PySide6 retirement remain Cycle 09/10 or later boundaries.

## 6. Corrections and superseded claims

- corrected: C08-R01 described Catalogue/Store reuse as capacity at a broad boundary. Repository truth shows query ports and repository methods exist, but the current UI exposes neither existing Product selection nor Store browsing; functional product capacity is therefore lower than the domain/application capacity.
- corrected: “similarity warning” exists, but it does not currently ask before staging. J’s explicit “create anyway” choice is prospective, not implemented.
- corrected: current draft survives tab switching because `IndexedStack` keeps `PurchasePage` mounted; it is not wholly transient across navigation. It remains unproven across rotation/background/process recreation.
- corrected: History has a summary query and widget, but loading/error are indistinguishable from empty and the N+1 item-count pattern makes large-history performance risk concrete.
- superseded: candidate 10,000-row tiers should not be treated as the first acceptance matrix. Reproducible seed tooling and budgets do not exist; begin with measured 100/1,000 tiers, then expand only if cost remains bounded.
- contradicted if asserted: no repository evidence supports an existing review phase, edit/remove, retry idempotency, detailed History, Product observation history, price analytics, export, restore, or failure classification.

## 7. Confrontation with current J

Supported:

- J’s product spine, atomicity/idempotency distinction, draft-versus-registered distinction, raw-fact authority, Device debt, Store identity asymmetry, and lifecycle/backup boundaries match repository truth.
- J correctly states no new navigation/state dependency is presently justified.
- J’s statement that widgets must not traverse Drift rows is respected by the current ports/adapters.

Needs correction/enrichment:

- J should state that `PurchasePage` never calls `listProducts` or `listStores`; current Catalogue/Store ports are latent rather than product-visible.
- Similarity warnings are computed before the setState append but do not gate staging or capture a human decision.
- History’s failure-state defect is stronger than a missing polished state: snapshot errors presently render as empty.
- Current query cost includes N+1 counts and a hard 50-row limit; performance/pagination design must precede large-volume acceptance.
- Draft lifetime already covers tab switching within one mounted `IndexedStack`; decisions should focus on route replacement, rotation/restoration, backgrounding, and process death.
- BRL and MASS are hard-coded in the present Purchase UI despite wider domain types; Cycle 08 must decide whether the first beta deliberately narrows them or exposes the existing dimensions/currency model.

## 8. Confrontation with provisional D_OPS_STAGE

Feasible without new dependencies or schema:

- widget tests for add/stage validation, edit/remove/review once implemented, warning choice, loading/error/empty states, busy-state behavior, and narrow/wide layouts;
- repository tests for Store/Product resolution, rollback, close/reopen, query ordering, and bounded history;
- formatting, analysis, Flutter tests, Python regressions, Windows build, and Android debug build/run;
- manual keyboard, Back, rotation, background/resume, larger-text, and restart matrix.

Requires source but likely no new package:

- explicit presentation-state classification;
- existing Product/Store picker using current query ports;
- draft coordinator using current Dart/Flutter primitives;
- History detail/query ports and deterministic price-calculation domain code;
- privacy-safe error mapping.

Requires schema/migration decision:

- durable submission/attempt UUID and identical/conflicting retry semantics;
- Store normalized identity/branch uniqueness if enforced durably;
- explicit current-installation Device relation;
- persisted process-death Purchase draft, if selected;
- database-level export/import metadata only if the chosen format requires it.

D correction: Gate O2 must not require “Store selection/create tests” as if a Store query/picker already exists; it should name current `listStores`, `_resolveStore`, and the prospective picker separately. Gate O4’s insufficient-storage/corruption cases may need controlled fault injection or adapter seams; they cannot be honestly claimed through ordinary widget tests.

## 9. Prospective structures and alternatives

### 9.1 Application-owned Purchase draft coordinator

- problem: draft is locked inside `_PurchasePageState`, preventing clear lifetime, review, and restoration policy;
- responsibility: own staged Items, Store selection, totals, validation phase, in-flight state, and result;
- likely owner/layer: application-facing coordinator consumed by presentation;
- affected: `PurchasePage`, `RegisterPurchaseCommand`, `MarkeiComposition`;
- surfaces: existing `lib/application/` and `lib/app/pages/`; exact filename remains for Main/Design;
- lifetime: app/session by default; process persistence only if human selects it;
- dependency: presentation → coordinator → existing ports/domain;
- persistence/schema: none for session-only; new draft storage/schema if process-death survival is required;
- tests: pure coordinator plus widget lifecycle tests;
- cost: medium; alternative is expanded widget state (cheaper, less testable);
- reversibility: high before persistence;
- status: prospective.

### 9.2 Submission identity

- problem: repeated logical registration creates fresh Purchase/Event identities;
- responsibility: identify one logical submit across retry and restart;
- owner/layer: application command plus local persistence uniqueness;
- affected: `RegisterPurchaseCommand`, `PurchaseRegistrationRepository.registerPurchase`, `LocalPurchaseRepository`, Purchases or a dedicated attempts relation, contracts;
- lifetime: durable at least through outcome/retry;
- dependency: generated in application/presentation, enforced by infrastructure;
- schema/migration: yes;
- tests: identical retry, conflicting payload, transaction failure, restart-after-commit;
- cost: medium–high;
- alternatives: Purchase UUID as submission key; dedicated attempt table; UI busy flag only (rejected as guarantee);
- reversibility: medium after schema release;
- status: prospective, human/Main acceptance required.

### 9.3 History detail and observation queries

- problem: summary-only port, N+1 counts, no comparison inputs;
- responsibility: fetch Purchase detail and comparable Product observations without exposing Drift rows;
- owner/layer: application query ports with local adapter; pure versioned analytics over returned facts;
- affected: `purchase_history.dart`, `LocalQueryRepository`, `HistoryPage`, domain money/quantity;
- lifetime: query result/view lifetime; analytics rebuildable;
- dependency: widgets → ports; analytics → domain facts;
- persistence/schema: no immediate change if current facts suffice; indexes may be justified by measured query plans;
- tests: detail correctness, account isolation, ordering/paging, comparability, N+1 elimination, volume timing;
- cost: medium;
- alternatives: one joined aggregate query versus bounded batched queries;
- reversibility: high;
- status: prospective.

### 9.4 Store identity hardening

- problem: exact case-sensitive display-name lookup and no durable account/name uniqueness;
- responsibility: deterministic reuse while keeping similarity advisory;
- owner/layer: domain normalization + repository constraint;
- affected: `Store`, `_resolveStore`, `Stores`, `listStores`;
- lifetime: durable identity;
- dependency: domain rule enforced by adapter/schema;
- schema/migration: likely yes if normalized key/branch field becomes unique;
- tests: case/whitespace equivalence, concurrency, branch distinction, migration collisions;
- cost: medium–high because existing collisions need policy;
- alternatives: Cycle 08 advisory-only warning without durable merge; defer branch identity;
- reversibility: medium;
- status: prospective and blocked on minimum Store facts.

### 9.5 Failure-state mapper

- problem: raw exceptions reach UI and History errors appear empty;
- responsibility: classify validation, conflict, retryable storage, unknown outcome, migration/startup, and empty state without exposing private facts;
- owner/layer: application/presentation boundary;
- affected: Purchase/History pages, registration/query ports, startup composition;
- lifetime: per operation plus retained draft on recoverable failure;
- dependency: infrastructure errors translated inward/outward through application result types;
- persistence/schema: none;
- tests: injected failures and user-visible state assertions;
- cost: low–medium;
- alternatives: local try/catch strings (current, insufficient);
- reversibility: high;
- status: prospective; strong first-unit candidate.

## 10. Dependency, schema, migration, and host consequences

- no new dependency is evidenced as necessary for the first responsive/error-state unit;
- navigation/state packages remain unjustified until existing Flutter primitives are tested against chosen draft lifetime;
- submission identity, Store uniqueness, current-installation Device relation, or durable drafts require explicit schema versions and representative migration fixtures;
- History detail/analytics should first use existing facts and measured queries; add indexes only from query/volume evidence;
- export/restore requires filesystem sharing/picker behavior on Windows/Android and therefore host/manual validation even if database schema is unchanged;
- lifecycle checks require real Windows/Android hosts; automated widget evidence cannot substitute.

## 11. Validation and evidence requirements

Next baseline must start from a usable checkout with `git ls-files`, exact generated ownership, clean/reconciled status, and current tool versions.

Minimum first-unit gates:

1. current 27-test/Python baseline rerun;
2. pure/widget tests separating loading, empty, validation, registration failure, unknown outcome, and success;
3. busy-state double-tap test, explicitly classified as UX mitigation rather than idempotency;
4. draft retention across Purchase↔History tab switch and selected rebuild/rotation scenario;
5. narrow/wide overflow, keyboard/focus, and larger-text widget checks;
6. Windows and Android manual smoke after automated pass;
7. protected Python and database boundaries unchanged.

Later schema-bearing gate: migration fixture, identical/conflicting retry, rollback, close/reopen, and no-silent-reset before UI acceptance.

Performance: build deterministic seed helpers first; measure 100 and 1,000 Products/Purchases, query counts, History latency, search latency, and comparison latency. Escalate to 10,000 only after budgets and test cost are approved.

## 12. Cross-domain consequences

- Design must decide draft lifetime, submission identity ownership, Store identity, query shapes, and whether BRL/MASS are intentional reduced-beta constraints.
- Didactic must distinguish existing exact reuse from absent UI selection, advisory warning from confirmed duplicate, empty from failed loading, busy-state from idempotency, and personal price change from general inflation.
- Main must not phrase Catalogue/Store/History as complete product journeys; only underlying ports/domain/persistence foundations exist.

## 13. Human decisions

1. Catalogue destination versus Purchase-integrated picker, or both.
2. Store picker-only versus destination and minimum branch/location identity.
3. Product code mandatory/optional/advanced.
4. Whether Cycle 08 UI remains BRL+MASS-first or exposes volume/count and currency choices.
5. Draft survival: tab switch only, app session/background, or process death.
6. Review as page/dialog or phase in staged list.
7. Durable submission UUID and identical/conflicting retry behavior.
8. First comparison basis and “price change” wording.
9. Export+restore, export-only, or explicit local-only loss boundary.
10. 100/1,000 seed budgets, required devices/scaling, and manual acceptance cadence.
11. Store normalization/branch policy timing.
12. Device invariant in Cycle 08 hardening versus mandatory Cycle 09 entry.

## 14. Recommendations for J restaging

- retain J’s product spine but label current UI exposure separately from underlying capacity;
- add the exact PurchasePage, HistoryPage, LocalQueryRepository, LocalPurchaseRepository, LocalDatabase, and Device findings above;
- correct similarity choice, History error/empty behavior, MASS/BRL reachability, draft tab lifetime, and N+1/limit facts;
- group schema-bearing decisions (submission, Store identity, Device relation, durable draft) separately from dependency-free UI/error/query work;
- reduce initial performance tiers to reproducible measured tiers pending budgets.

## 15. Recommendations for next D/E/F enrichment

First bounded candidate: responsive shell plus explicit presentation-state/failure boundary and application-owned session draft, using existing dependencies and schema. Include Catalogue/Store picker confrontation only if the human settles destinations and minimum identity.

Keep durable idempotency as a separate schema-bearing unit. Keep History detail/analytics separate from responsive restructuring. Keep export/restore, Device relation, and broad lifecycle acceptance in hardening units.

Operational D should name exact current symbols and distinguish tests that extend existing coverage from prospective test surfaces. Every D/E/F append remains:

`Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX`.

## 16. Exact next route

```text
C08-R02 A/B/C publication
→ Main runs MJR-03
→ Main appends the next J reconciliation
→ Main runs MDE-04
→ Main appends the next provisional D/E/F enrichment
→ renewed domain confrontation as required
→ final human/Main activation
→ Codex
```

Implementation authority remains inactive.
