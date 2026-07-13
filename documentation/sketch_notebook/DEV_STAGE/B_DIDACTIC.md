# B_DIDACTIC — Cycle 08 Round C08-R01

> Role: Didactic Chat [A]
> Cycle: 08
> Round: C08-R01
> Branch: `cycle-08-shared-client-product-beta`
> Inspected HEAD: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Date: 2026-07-12
> Status: Functional investigation for Main reconciliation; not canonical promotion or Codex authority

## 1. Methodology-loaded report

The complete required sequence was loaded: root `AGENTS.md`; `INDEX.md`; `PROMPT_COLLECTION.md`; `METHOD_FOUNDATIONS.md`; `FLUX.md`; `PROMOTION_RULES.md`; `CHAT_PROTOCOL.md`; `CHAT_BEHAVIOUR.md`; and `METHOD_GLOSSARY.md`. PROMPT_COLLECTION was consolidated through PRI-A, PMC-01, PMC-02, and MSU-02 with Didactic scope.

Confirmed authority: [A] observes learner-facing concepts, vocabulary, dependencies, misconceptions, and evidence-based maturity; [A] may replace only this temporary stage in this round. Main owns synthesis. Design owns architecture. Operational owns execution acceptance. Codex materializes only later authorized D/E/F. Implementation evidence is not learner evidence, and staging is not promotion.

PMC-01 result: retained role and Cycle 08 direction agree with the canonical recovery surfaces. PMC-02 result: routing and promotion boundaries are explicit; no KANBAN maturity change is justified. MSU-02 result: application inspection is required because Cycle 08 product language is the direct subject and the Didactic checkpoint predates Cycle 08.

Contradictions/drift:

- `didactics/08_CONCEPT_MAP.md` is still labelled as a Cycle 07 checkpoint; Main continuity opens Cycle 08 Sprint 01. This is checkpoint staleness, not authority to refresh it now.
- `INDEX.md` names `J_MAIN_STAGE.md`, while the repository uses `[M]_STAGE/J_[M]_STAGE.md`. The latter is the actual current route named by PROMPT_COLLECTION and the mission.
- MSU-02 normally directs a commit/push for a shared branch, but the human instruction expressly says not to commit or push unless separately authorized. No commit or push is authorized.
- Current J is intentionally cleared and contains no active synthesis. `LEGACY_RECONCILIATION.md` remains archived provisional material and was not treated as authority.

## 2. Branch and HEAD

Local verification completed in the required order. Working tree began clean; branch was `cycle-08-shared-client-product-beta`; `git pull --ff-only origin cycle-08-shared-client-product-beta` reported already up to date; HEAD exactly matched `60105fab8eac4ac858d8a36674e358737e1c9f98`. The GitHub connector independently confirmed that commit and branch file access.

## 3. Recovery and repository topology

Recovered from `00_PROJECT_STATE.md`, the Cycle 08 entry in `06_SESSION_SCHEME.md`, the latest Cycle 08 segment in `05_SESSION_LOG.md`, cleared J, the stale Didactic checkpoint, the KANBAN and Glossary where concept ownership/vocabulary required them, and Operational/Design checkpoints for cross-domain limits. `13_LECTURE_REGISTER.md` was not required because no maturity transition or learner chronology was claimed.

The complete repository topology was scanned. Relevant classes of material are: preserved Python/PySide6 beta (`main.py`, `app/`, Python tests and packaging); handwritten Flutter client (`clients/markei_flutter/lib/`); Flutter tests; platform hosts (`android/`, `windows/`, `ios/`); Drift persistence and generated database source; shared v1/v2 contract fixtures and JSON Schemas; manifests and lockfiles; generated/build/distribution output; and notebook/documentation. Generated and binary output was classified but not read line by line.

### Didactic component inventory

| Exact path | Responsibility and concepts | User vocabulary / evidence | Likely misconception | KANBAN ownership | Cycle relevance |
| --- | --- | --- | --- | --- | --- |
| `clients/markei_flutter/lib/domain/catalogue/product.dart` | Product draft, packaged/bulk mode, normalized identity, visible display fields | Product code, name, brand, packaged, bulk; implemented | visible fields or fuzzy likeness equal internal identity | `&%%07`, `&%%08`, `&&&06` | C08 core; correction/merge deferred |
| `clients/markei_flutter/lib/application/catalogue_queries.dart` | Catalogue lookup and advisory similarity | “Similar” warning; implemented query boundary | warning means duplicate or automatic merge | `&%%07`, `&%%08` | C08 core |
| `clients/markei_flutter/lib/domain/store/store.dart` | account-private Store record | Store/name; implemented minimal model | chain name uniquely identifies a branch | `&&&06` and project identity family; exact Store concept coverage incomplete | C08 gap; richer branch rules deferred |
| `clients/markei_flutter/lib/domain/purchase/purchase.dart` | Purchase aggregate and draft Item lines | Purchase, Item, package count, quantity, line total; implemented | staged Item already is historical Purchase Item | `&%%09`, `&%%10`, `&&&07` | C08 core |
| `clients/markei_flutter/lib/domain/shared/quantity.dart` | dimensional normalization | amount, unit, normalized quantity; implemented | package amount, package count, and purchased amount are interchangeable | `&%%12` | C08 core |
| `clients/markei_flutter/lib/domain/shared/money.dart` | currency plus integer minor units | currency, total; implemented | every currency has two decimal places or formatted value is raw fact | `&%%13` | C08 presentation boundary |
| `clients/markei_flutter/lib/application/register_purchase.dart` | registration command and repository contract | register Purchase; implemented | “save”, “upsert”, and immutable registration mean the same action | `&%%09`, `&%%11`, `&&&07` | atomic review/register core |
| `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart` | local atomic write of Product/Store/Purchase/Items/event | no necessary user-facing technical vocabulary; implemented/tested | local event queue means cloud synchronization exists | `&%%11`, `&&&07`, sync concepts | preserve; C09 activation deferred |
| `clients/markei_flutter/lib/infrastructure/local/local_database.dart` | Drift tables, keys, constraints, migrations | none should expose UUID/event/cursor language | account row means authenticated account; pending event means upload | persistence/sync entries | protected technical behavior; C09 sync deferred |
| `clients/markei_flutter/lib/app/pages/purchase_page.dart` | current multi-item staging scaffold | Store, Product code/name/brand, package amount/unit, Quantity, Packages, Line total, Add item, Register; implemented/widget-tested | “Quantity” is sufficiently precise; warning resolves duplicates; staging includes edit/remove/review | existing Product/Purchase/quantity concepts | baseline to enrich in C08 |
| `clients/markei_flutter/lib/app/pages/history_page.dart` | summary projection and empty state | History, no purchases registered, store, item count, total; implemented/widget-tested | summary is detailed History or analytics | raw/derived and Purchase concepts | detail/comparison gap for C08 |
| `clients/markei_flutter/lib/app/markei_app.dart` | navigation/composition presentation | Purchase, History; implemented | same widget tree proves responsive/platform acceptance | Flutter/composition and evidence-state concepts | responsive foundation C08 |
| `clients/markei_flutter/test/` | executable examples for identity, migration, transaction, UI and lifecycle-adjacent behavior | test evidence, not learner evidence | passing tests establish understanding or full product acceptance | `&&&05` | evidence source only |
| `contracts/shared_beta/v2/` | language-neutral identity, Purchase, and event examples/schemas | technical contract vocabulary | fixture is final wire protocol or active synchronization | data contract, catalogue, sync concepts | protect during C08; C09 transport deferred |
| `app/`, `main.py`, `tests/test_release_configuration.py` | accepted Python/PySide6 behavior and regression baseline | legacy Register/Storage/History vocabulary | Python projections define new Flutter product language | existing Python/project concepts | protected behavior, not C08 primary UI |
| `clients/markei_flutter/android/`, `windows/`, `ios/` | platform hosts | Android/Windows interaction | host files prove full lifecycle or iOS scope | Flutter/evidence boundary | Windows/Android C08; iOS deferred |

## 4. Accepted concepts and vocabulary

Accepted conceptual ground, without new maturity claims:

- Catalogue: the household’s private reusable collection of Product references, distinct from one Purchase entry.
- Product: a reusable identity-bearing catalogue fact; visible code/name/brand/package facts help recognition but are not the internal UUID.
- Exact duplicate: exact normalized identity equivalence eligible for reuse under the current rules.
- Similar Product: advisory likeness requiring human choice; it never authorizes automatic merge.
- Packaged amount: the amount contained by one package (for example 500 g).
- Package count: how many packages were bought.
- Purchased amount: the observed total quantity on the Purchase line; it must retain a dimension and unit.
- Normalized quantity: a comparable representation derived from entered amount/unit; it is not a replacement for understandable display evidence.
- Staged Item: editable, removable pre-registration input.
- Purchase Item: the registered historical line within an atomic Purchase.
- Review: inspection/correction before registration. Registration: one atomic historical commit, not an upsert.
- History: raw Purchase observations and their details. Price comparison: a derived interpretation rebuilt from those observations.
- Personal price change: change between the user’s own comparable observations. It must not be called general, official, or population inflation.
- Responsive composition: interface adaptation to available space and interaction conditions; not proof of identical layout or complete platform behavior.

## 5. Cycle 08 conceptual gaps

1. A learner-facing visible Product identity sentence is not yet settled: which fields users recognize, and which internal distinctions remain hidden.
2. Store versus Store branch/location lacks a stable ordinary-language rule.
3. The UI label `Quantity` collapses purchased amount and normalized/comparable quantity.
4. The relationship among package amount, package count, purchased amount, unit price, and line total needs one coherent example and validation vocabulary.
5. Current staging has add/register but no implemented edit/remove/cancel/review model.
6. Failure/retry language does not yet distinguish validation failure, transaction failure, unknown outcome, safe retry, and duplicate prevention.
7. History is only a summary list; detail, Product observation history, comparison inputs, and selected interval are unimplemented.
8. The first personal price-change formula and comparability rule remain provisional; shrinkflation and mixed package sizes must not be silently collapsed.
9. Empty, loading, validation, success, failure, recovery, and retry states are incomplete or undifferentiated.
10. Responsive behavior has phone-width widget evidence but no accepted conceptual model for keyboard, Back, focus, larger text, rotation, and wide composition.

## 6. Existing KANBAN ownership

Cycle 08 should extend or exemplify existing entries before inventing duplicates: `&&&01` responsibility boundaries; `&&&02` raw versus derived data; `&&&03` naming as contract; `&&&05` evidence state; `&&&06` stable identity; `&&&07` atomicity; `&&&08` historical integrity; `&&&09` authentication versus authorization; `&&&10` eventual consistency; `&%%07` reusable Catalogue; `&%%08` Product identification and normalization; `&%%09` Purchase aggregate; `&%%10` Purchase Item; `&%%11` append-only event; `&%%12` dimensional quantity; `&%%13` minor-unit money; `&%%14` analytics registry/versioning; and Flutter/Drift framework entries.

Possible uncovered teaching objects—visible identity, exact-versus-advisory match, draft-versus-registered state, review-versus-commit, and responsive composition—must first be tested as examples/extensions of these owners. No new IDs or status changes are proposed in this round.

## 7. Provisional vocabulary candidates

- `Catalogue Product` for the reusable reference, with plain `Product` preferred in UI where context is clear.
- `Package size` instead of `Package amount` when speaking to users.
- `Packages bought` for package count.
- `Total amount bought` for purchased amount when ambiguity exists.
- `Comparable amount` only when normalization is actually displayed/explained.
- `Purchase draft` or `Items to register` for pre-registration state.
- `Review purchase` for the explicit pre-commit step.
- `Price change in your purchases` as the safest first analytics title.
- `Compared purchases` and explicit date interval for the two observations.

These are candidates for usability/learner evaluation, not canonical Glossary entries.

## 8. Misleading language and confusion risks

- Avoid `inflation rate` without the qualifier personal/observed; two private prices do not measure general inflation.
- Avoid `upsert Purchase`; registration creates a new immutable historical Purchase.
- Avoid `duplicate` for fuzzy similarity; say `similar Product` until exact equivalence is established.
- Avoid `syncing`, `uploaded`, `account`, `signed in`, or `cloud backup` in user-facing status. Current behavior is local; the account identifier and event queue are preparatory technical structures.
- Avoid exposing UUID, device sequence, event, cursor, hash, Drift, or normalization version as ordinary product vocabulary.
- Avoid `saved` after an uncertain failure; distinguish validation rejection, registration success, and unknown/retry states.
- Avoid implying that Android/Windows share identical interactions merely because they share Flutter source.
- Avoid treating normalized quantity or derived unit price as raw receipt evidence.

## 9. Learner-evidence boundaries

Repository files and passing tests demonstrate implemented examples. Human runtime reports demonstrate bounded workflow evidence. Neither demonstrates that the learner can define, distinguish, predict, explain, or apply a concept independently. Therefore every existing KANBAN maturity remains unchanged.

Future promotion would require explicit learner evidence such as: explaining Product visible/internal identity; classifying exact versus advisory matches; calculating package count versus purchased amount; predicting atomic rollback; distinguishing draft Item from Purchase Item; identifying raw and derived price facts; or explaining why personal price change is not general inflation. Usability observation may improve interface language but is not automatically conceptual mastery.

## 10. Cycle 09/10 deferrals

Cycle 09: authentication/authorization activation, remote API/Neon, actual upload/download synchronization, server cursors, conflict handling, multi-device convergence, central/shared catalogue, household sharing, and production identity semantics.

Cycle 10 or later: broad analytics, forecasting, official-index comparison, shrinkflation suite, cross-store recommendations, global catalogue/product-family relations, mature Product/Store correction/merge/delete workflows, legacy import, and broader distribution. iOS is outside the current Cycle 08 scope.

## 11. Human questions

1. Should the UI use `Catalogue`, `Products`, or a paired title such as `My products` while documentation retains Catalogue?
2. Is user Product code mandatory in Cycle 08, optional, or an advanced/internal-facing field?
3. For packaged goods, should the user enter package count plus package size and let total purchased amount derive, or retain all three with consistency validation?
4. What minimum facts distinguish Store branches in Cycle 08: name only, optional location label, or another visible identifier?
5. Must Review be a separate screen/dialog, or may an editable staged list plus explicit Register action satisfy the concept?
6. Should the first analytics view say percentage `price change`, reserving `personal inflation/deflation` for an explanatory secondary label?
7. Which failures may be retried automatically, and which must ask the user to confirm whether registration occurred?

## 12. Recommendations to Main

- Make the first product-language spine: choose/reuse Product → stage Items → review → atomically register → inspect History → compare like observations.
- Require every D/E/F UI instruction to name validation, empty, success, failure, retry, and recovery language, not only happy-path widgets.
- Keep internal identity/sync vocabulary behind the interface while preserving contract invariants.
- Define comparability before naming analytics; begin with explicit Product, amount basis, two Purchase observations, dates, stores, currency, and percentage change.
- Treat Store branch identity and package/purchased quantity entry as human decisions before implementation staging.
- Carry current KANBAN maturity unchanged and schedule small learner checks after the product vocabulary is selected.

## 13. Exact next staging route

```text
C08-R01 B_DIDACTIC
↔ Main J reconciliation with A_OPERATIONAL and C_DESIGN
↔ provisional D/E/F, each labelled exactly:
  Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
↔ renewed A/B/C review of the proposed product language and gates
↔ enriched J and D/E/F
→ explicit human/Main authorization
→ Codex materialization
→ G/H/I evidence
→ functional reconciliation; only then consider permanent Didactic updates or maturity review
```

This report recommends no source change, permanent Didactic promotion, architecture choice, or Operational acceptance.
