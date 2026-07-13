# C_DESIGN — Cycle 08 Round C08-R01

> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Role: Design Chat [D]
> Repository: `gus-i-gu/markei`
> Required branch: `cycle-08-shared-client-product-beta`
> Remote baseline inspected: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Scope: architecture investigation and recommendations to Main; no implementation authority

---

## 1. Methodology-loaded report

The complete required sequence was read from the named remote branch: root `AGENTS.md`; `INDEX.md`; `PROMPT_COLLECTION.md`; `METHOD_FOUNDATIONS.md`; `FLUX.md`; `PROMOTION_RULES.md`; `CHAT_PROTOCOL.md`; `CHAT_BEHAVIOUR.md`; and `METHOD_GLOSSARY.md`.

`PROMPT_COLLECTION` was consolidated through PRI-D, PMC-01, PMC-02, and MSU-02 with Design scope. The resulting authority boundary is:

- Design observes responsibilities, dependency direction, invariants, ownership, alternatives, reversibility, and cost;
- this file is a functional C-stage report for Main reconciliation;
- it does not validate execution, change Didactic maturity, promote permanent Design canon, authorize schema/source/dependency work, or activate D/E/F;
- promotion is semantic; materialization is physical; neither follows automatically from repository evidence;
- `LEGACY_RECONCILIATION.md` is archived provisional evidence, not current authority;
- only this paired `C_DESIGN.md` is writable in this round.

No methodology contradiction was found in those authority rules. Path/state contradictions are recorded in section 11.

## 2. Branch and HEAD evidence

The prescribed local commands could not complete because the supplied workspace root is not a usable Git checkout (`fatal: not a git repository`). No substitute branch, reset, stash, clean, overwrite, commit, or push was attempted.

GitHub connector evidence independently established:

- repository `gus-i-gu/markei` exists;
- branch `cycle-08-shared-client-product-beta` exists;
- commit `60105fab8eac4ac858d8a36674e358737e1c9f98` exists on the inspected repository and is titled `Reset Main staging after archival`;
- all repository reads explicitly used the required branch.

Therefore the remote investigation baseline is confirmed, while local branch cleanliness and fast-forward status remain unverified.

## 3. Repository topology and Design component inventory

The complete architectural surface was scanned through GitHub branch reads, dependency/import traversal, permanent checkpoints, and current staging. Generated Drift output and platform boilerplate are implementation products; handwritten ownership remains with the adjacent Dart/host sources.

| Exact path | Responsibility and dependency direction | Identity/state ownership | Ownership/status | Debt and Cycle relevance |
| --- | --- | --- | --- | --- |
| `clients/markei_flutter/lib/main.dart` | Flutter entrypoint; initializes binding, requests composition, runs app | process bootstrap only | handwritten; accepted/materialized | correct thin entrypoint; C08 keeps it thin |
| `clients/markei_flutter/lib/app/markei_composition.dart` | composition root; infrastructure adapters satisfy application ports | database lifetime, local account context, selected installation Device | handwritten; accepted prototype | hard-coded `local-account`; concrete return types leak infrastructure; Device selection invariant is provisional |
| `clients/markei_flutter/lib/app/markei_app.dart` | root Material shell and two-destination composition | selected tab and integer refresh signal for app lifetime | handwritten; prototype | phone-style bottom navigation only; no breakpoint policy, routing/detail navigation, draft-lifetime contract, or recovery state |
| `clients/markei_flutter/lib/app/pages/purchase_page.dart` | Purchase presentation directly builds application command | controllers, draft item list, warnings, transient message, submission trigger | handwritten; prototype | page owns too much workflow state; create-only item staging, no edit/remove/review; fixed MASS/BRL; no busy/idempotency guard; errors expose raw exceptions |
| `clients/markei_flutter/lib/app/pages/history_page.dart` | renders recent-history query projection | async snapshot only | handwritten; prototype | summary only; no date display, detail route, fact reconstruction, explicit loading/error, paging, or analytics |
| `clients/markei_flutter/lib/application/catalogue_queries.dart` | inward-facing Product/Store/similarity query port | no durable state | handwritten; accepted interface, incomplete use-case surface | list-only; search/select/create intent and exact-match result semantics need explicit contracts |
| `clients/markei_flutter/lib/application/register_purchase.dart` | registration command and persistence port | aggregate request/result boundary | handwritten; accepted prototype contract | command accepts store name rather than explicit Store reference/draft; no stable submission key or declared retry outcome |
| `clients/markei_flutter/lib/application/purchase_history.dart` | history list projection port | read model only | handwritten; provisional projection | summary projection lacks Purchase detail, item observation, paging, and analytic query ports |
| `clients/markei_flutter/lib/domain/shared/ids.dart` | typed record identities | Account, Device, Product, Store, Purchase, Item, Event IDs | handwritten; accepted/materialized | wrappers have no value equality; IDs must remain distinct from visible Product code and Store name |
| `clients/markei_flutter/lib/domain/catalogue/product.dart` and `product_code.dart` | Product identity, normalization, exact matching, advisory similarity | immutable Product record identity and visible user code | handwritten; accepted foundation | corrections/alias/merge deferred; normalization migrations remain version-sensitive |
| `clients/markei_flutter/lib/domain/store/store.dart` | account-private Store entity | Store UUID; display name is not identity | handwritten; accepted minimum model | branch/location and duplicate policy unresolved; current persistence exact-matches case-sensitive display name |
| `clients/markei_flutter/lib/domain/purchase/purchase.dart` | Purchase aggregate and Item invariants | registered Purchase/Item facts | handwritten; accepted foundation | draft is only a list of item drafts in widget state; registered fact immutability versus correction needs later explicit policy |
| `clients/markei_flutter/lib/domain/shared/quantity.dart` and `money.dart` | dimensional quantity and minor-unit money | value semantics inside facts | handwritten; accepted foundation | UI currently collapses choice to MASS and assumes BRL/two decimal display |
| `clients/markei_flutter/lib/domain/sync/sync_event.dart` | versioned `purchase.registered` envelope | event UUID, Device sequence, immutable aggregate payload | handwritten; materialized local preparation; Cycle 09 inactive | local event is not synchronization; content/retry semantics must be preserved |
| `clients/markei_flutter/lib/infrastructure/local/local_database.dart` | Drift schema, app-private database opening, v1→v2 migration | physical local facts, queue, cursor, migration ledger | handwritten schema/migration; generated `local_database.g.dart` | accepted local prototype; monolithic schema owner is manageable now but backup/recovery and future migration policy are incomplete |
| `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart` | resolves Store/Product and atomically writes Purchase, Items, Event, pending queue, sequence | transaction ownership and generated UUIDs | handwritten; accepted atomic prototype | one large adapter combines identity resolution, mapping, transaction, event serialization; double submission creates two valid aggregates |
| `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart` | implements Catalogue and History query ports | rebuildable read projections | handwritten; accepted prototype | Product row mapping duplicated; History has N+1 item-count reads; no detail/analytics/paging |
| `clients/markei_flutter/lib/infrastructure/local/local_device_identity_repository.dart` | loads or creates persistent local Device UUID | installation Device candidate | handwritten; provisional prototype | scans up to 20 account devices and picks first UUIDv4; no explicit unique current-installation relation or concurrency rule |
| `clients/markei_flutter/test/**`, `clients/markei_flutter/integration_test/**` | domain, migration, repository, widget, platform-boundary evidence | fixture/test state only | handwritten; materialized evidence, Operational acceptance not claimed here | C08 must extend contract tests for draft/retry/detail/analytics; this report does not claim test execution |
| `clients/markei_flutter/android/**`, `windows/**`, `ios/**` | generated/platform host projects and native lifecycle/package integration | OS process, package identity, app-private paths | mixed generated/handwritten host ownership | Windows/Android are active C08 hosts; iOS remains unvalidated/deferred; host code must not own domain workflow |
| `app/**`, `main.py`, `tests/**`, `database/**` | protected Python/PySide6 beta and legacy data boundary | established desktop runtime/database | handwritten; accepted/protected | behavioral/migration reference only; no Flutter direct opening, IPC dependency, or retirement in C08 |
| `contracts/shared_beta/v2/**` | language-neutral schemas/examples/fixtures | protocol meaning and fixture identities | handwritten canonical contract artifacts; accepted foundation | C08 local changes must not silently redefine Cycle 09 wire meaning |

## 4. Accepted architecture and materialized structures

The accepted inward direction remains:

```text
Flutter presentation
→ application commands/query ports
→ domain entities, values, invariants, analytics contracts
← infrastructure adapters implement application/domain ports
```

Materialized strengths to preserve:

- an isolated Flutter shared client beside the protected Python beta;
- a thin process entrypoint and explicit composition root;
- domain types independent of Flutter and Drift;
- account-private Product and Store records with UUID identity;
- visible Product code separated from internal Product identity;
- exact normalized Product reuse and advisory-only similarity;
- multi-item Purchase aggregate validation;
- one Drift transaction for Product/Store resolution, Purchase, Items, event, pending queue, and Device-sequence advancement;
- raw local facts separated from rebuildable query projections;
- app-private local storage, schema versioning, and migration ledger;
- local event preparation that preserves the future API boundary without claiming synchronization;
- persistent platform-neutral Device UUID as a bounded prototype;
- generated Windows/Android/iOS hosts kept outside domain ownership.

## 5. Provisional choices and prototype debt

Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX

Recommended provisional architecture for confrontation:

1. Introduce a presentation-facing Purchase draft coordinator/view model owned below the page but above domain facts. It owns Store selection/draft, staged Items, editing/removal, validation, review phase, busy/result state, and retry identity. Widgets own controllers/focus only.
2. Keep state management package-neutral in Sprint 02. A small explicit `ChangeNotifier`/`Listenable` or equivalent injected controller is cheaper and reversible; adopt a package only when navigation, restoration, or testing evidence justifies it.
3. Make the responsive shell choose navigation presentation by available width: bottom navigation for narrow space; rail or equivalent for wide space. Screen identity and selection remain shared; platform branding must not fork the product model.
4. Treat Catalogue and History as first-class screens/read models, not side effects of Purchase. Store selection may initially be a reusable picker flow without requiring a permanent Store screen.
5. Separate draft identity from registered fact identity. Draft Items may use ephemeral UI keys; Product/Store/Purchase/Item UUIDs become durable only at accepted resolution/registration boundaries.
6. Preserve exact Product equivalence as deterministic reuse. Similarity produces ranked advisory candidates and requires explicit human selection or `create anyway`; it never changes identity automatically.
7. Add an explicit client-generated `submissionId`/attempt UUID to registration. The repository must return the prior result for an identical retry and reject conflicting content, rather than relying only on disabling a button.
8. Extend History through dedicated list, detail, Product-observation, and comparison projection ports. Do not make widgets traverse Drift rows or event JSON.
9. Define personal price comparison as versioned derived analytics over immutable Item facts. The first useful observation should normalize line total by recorded purchased quantity/package basis only where dimensions and currency are comparable; absence/incomparability is a result, not zero.
10. Keep Drift as the local transaction owner in C08. Split query mappers/use cases only where responsibilities or tests benefit; do not introduce a generic repository abstraction or distributed topology prematurely.

Prototype debt presently includes raw exception display, N+1 History counts, hard-coded BRL and MASS, case-sensitive Store reuse, duplicated Product row mapping, no submit guard/idempotency key, no detail projection, no explicit loading/error model, and form draft loss/lifetime ambiguity.

## 6. Cycle 08 responsibility and state boundaries

| Concern | Proposed owner | Lifetime/invariant |
| --- | --- | --- |
| navigation selection | responsive shell coordinator | app session; same semantic destinations across widths |
| text/focus/keyboard | page/widgets | mounted view lifetime; never durable fact authority |
| Purchase draft and review | application-facing draft coordinator | survives view recomposition/navigation according to explicit policy; disposable after confirmed success/cancel |
| Product/Store search results | query use cases | refreshable read state; account-scoped |
| exact matching | Product domain normalization + repository uniqueness | versioned, deterministic, account-scoped |
| similarity warning | domain advisory rule + query adapter | non-authoritative; requires human choice |
| registered Purchase aggregate | domain invariants + registration transaction | immutable raw fact boundary in C08 |
| duplicate-submit protection | application submission identity + local unique persistence rule | identical retry returns same result; conflict fails atomically |
| History list/detail | application projection ports | rebuildable views over facts; no fact mutation |
| price comparison | versioned domain/application analytic + projection adapter | derived and reproducible from named fact boundary/version |
| database/migrations | Drift infrastructure | one local schema owner; no silent reset; migrations explicit |
| backup/export | application port with local adapter, if approved | consistent read boundary; format/version and recovery intent explicit |
| Device | installation identity repository + composition | exactly one selected current-installation Device before C09 sync |
| platform lifecycle | Flutter shell/host adapters | no domain-rule duplication in Windows/Android hosts |

Atomic registration must remain one local transaction. Network work must never enter that transaction. UI disablement is useful feedback but is not the identity guarantee. Registered aggregate correction/deletion remains deferred unless Main explicitly expands the fact model.

## 7. Alternatives, reversibility, and development cost

| Decision | Lower-cost/recommended route | Alternative | Reversibility and cost |
| --- | --- | --- | --- |
| state | injected draft coordinator using SDK primitives | Riverpod/Bloc/provider package now | low-cost route is highly reversible; package adoption adds dependency, conventions, and migration work |
| navigation | shared destinations with width-driven NavigationBar/Rail | router package and nested routes immediately | shell swap is cheap; deep-link/router adoption becomes justified with detail routes/restoration |
| Catalogue | dedicated query screen + picker reuse | embed all Product management in Purchase | dedicated boundary costs more UI now but avoids Purchase-page growth and is reversible at presentation level |
| Store | picker/create flow with UUID reference | free-text Store on registration | picker costs query/state work; preserves identity and later branch evolution |
| draft | explicit application draft model | keep `List<PurchaseItemDraft>` in widget | moderate refactor now; strongly reduces future edit/review/restoration cost |
| idempotency | client submission UUID persisted uniquely | busy flag only | schema/contract cost is moderate; postponement raises duplicate-fact migration cost |
| analytics | pure versioned calculation + query projection | cached mutable analytics as truth | compute-first is cheaper and reversible; cache later without changing meaning |
| local data | extend Drift schema by migrations | replace persistence or open Python database | Drift continuity is lowest risk; replacement/direct legacy access is high-cost and violates protection boundary |
| backup | decide contract in C08, implement only when authorized | postpone all consideration to C10 | early decision is cheap; late format/recovery retrofit is expensive |

## 8. Schema/dependency consequences — not authorization

Likely schema consequences if Main later accepts the recommendations:

- a unique durable submission/registration-attempt identity associated with Purchase and/or event;
- indexes supporting Product search/exact identity, Store search, History ordering/detail joins, and Product observation history;
- possibly normalized Store matching fields and version if Store duplicate policy is accepted;
- no table is required merely for responsive state or transient draft state unless restoration across process death becomes an explicit requirement;
- analytic results should remain computed/rebuildable initially; any cache requires analytic ID/version/input boundary;
- backup/export needs format version and consistency boundary, not necessarily a new database table;
- Device correction needs an explicit current-installation relation or singleton metadata rule plus uniqueness/concurrency migration before C09.

Likely dependency consequence: none is necessary for the first responsive/draft boundary. Navigation/state packages remain evidence-driven candidates. Drift stays accepted. These observations do not authorize `pubspec.yaml`, generated code, schema, or migration edits.

## 9. Carried installation–Device debt

The current repository finds up to twenty account Devices, selects the first UUIDv4, or creates another. This is accepted only for the one-installation prototype. It does not express `this installation owns exactly one current Device`, does not prevent multiple valid candidates, and has no explicit concurrent creation/repair policy.

Cycle 08 must keep the debt visible and must not let UI work deepen reliance on arbitrary selection. Recommended timing:

- Sprint 02–04: preserve current behavior, test lifecycle without claiming distributed safety;
- Sprint 05 acceptance: decide and, if authorized, migrate to an explicit current-installation invariant;
- hard gate before Cycle 09 upload/download: exactly one installation Device, durable across restart/upgrade, deterministic repair, unique sequence ownership, and concurrency-safe creation must be evidenced.

Uninstall/data clear may destroy the local Device with local-only data; backup/import must not accidentally clone Device identity unless the later protocol explicitly defines that behavior.

## 10. Cycle 09/10 deferrals

Cycle 09 remains the boundary for verified Account identity, authentication/authorization, TypeScript API, Neon/Postgres, idempotent upload, cursor download, bootstrap, convergence, and multi-device conflict behavior. C08 may preserve/clarify contracts but must not activate them.

Cycle 10 remains the boundary for production secrets, privacy/deletion, production-grade export/import and recovery, observability/support, signing, distribution, packaging, upgrade matrices, and controlled public beta. A bounded local backup/export decision may occur in C08, but production recovery guarantees remain deferred.

Also deferred unless separately activated: central/shared catalogue, automatic Product merge, Product alias/family/supersession, Store deletion/correction policy, registered Purchase editing/deletion, forecasting, iOS acceptance, legacy import, and PySide6 retirement.

## 11. Contradictions and human decisions

Contradictions/drift:

1. The workspace has a `.git` path but is not a usable checkout; therefore local status, current branch, pull, HEAD, and local-change safety could not be proven. Remote evidence does not cure this operational gap.
2. The supplied documentation archive is dated and contains many zero-length notebook working files; it was not treated as authority. The remote required branch supplied current truth.
3. `00_PROJECT_STATE.md` and `06_SESSION_SCHEME.md` headers still advertise Cycle 07 branch/baseline while their latest temporal sections correctly activate Cycle 08. Latest marked sections supersede the stale headers, but checkpoint refresh debt remains.
4. Historical text says D/E/F become implementation authority after Main approval; the active C08 loop explicitly requires every intermediate D/E/F to remain provisional until final human/Main activation. The stricter active-cycle rule governs.
5. The accepted Product identity model is stronger than current Store identity behavior; Store duplicate/branch semantics remain unresolved.
6. Atomic registration exists, but safe duplicate submission does not. Atomicity and idempotency must not be conflated.

Human/Main decisions required:

- Is Catalogue a top-level beta destination, or a reusable selection surface reached primarily from Purchase?
- Is Store a top-level destination or picker-only boundary in C08?
- Must Purchase drafts survive tab switches only, app backgrounding, or full process death?
- Is a persisted submission UUID accepted for C08, and what identical/conflicting retry result should the application expose?
- What is the minimum Store identity: normalized name only, or name plus optional branch/location?
- Which price basis is the first beta comparison: purchased-unit price, package-unit price, or a deliberately bounded subset by Product mode?
- Does C08 implement local export/backup, or only settle its contract and defer production implementation?
- Must installation–Device correction occur in Sprint 05, or may it remain a named hard gate at Cycle 09 entry?

## 12. Recommendations to Main

Main should preserve the materialized inward dependency direction and stage C08 as bounded increments:

1. responsive shell and explicit presentation-state ownership;
2. Catalogue/Store query and selection contracts;
3. Purchase draft coordinator with edit/remove/review;
4. idempotent atomic registration boundary;
5. History list/detail projections;
6. versioned personal price comparison;
7. migration, recovery, backup/export decision, Device invariant, and host acceptance.

Main should require each future provisional D/E/F to name exact files, state lifetimes, transaction owner, migration consequences, generated-code handling, tests/evidence, rollback/stop gates, and non-goals. No sprint should combine responsive restructuring, schema idempotency, analytics, and Device migration without separate acceptance gates.

## 13. Exact next staging route

```text
C08-R01 A/B/C complete
→ Main reads A_OPERATIONAL + B_DIDACTIC + this C_DESIGN
→ J_MAIN_STAGE reconciliation
→ provisional D/E/F
   Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
→ renewed O/A/D confrontation of J and provisional D/E/F
→ enriched J and replacement provisional D/E/F as required
→ repeat until contradictions and human decisions are resolved
→ explicit final human/Main activation
→ only then Codex materialization
→ G/H/I evidence
→ domain reconciliation and checkpoint refresh
```

Immediate next writer: Main Chat [M] in `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`, after all three current A/B/C reports are available. This C-stage does not write or activate D/E/F.

---

Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
