<!-- TEMPORAL_MARKER:C10-RETENTION-RECOVERY-DIDACTIC-INVESTIGATION-2026-07-15 -->

# B_DIDACTIC — Cycle 10 Retention and Recovery Semantics

> Sequence: FLX-INV-02
> Role: Didactic/UX Chat [A]
> Branch: `intermid-cycle-recovery`
> Baseline / inspected HEAD: `36b7b22b20e3b308b7b800514f6828a91ea49fcd`
> Authority: Didactic/UX investigation only
> Writable surface: this file only
> Knowledge state: candidate / proposed / provisional
> Materialization authority: none
> Learner maturity: unchanged

## 1. Methodology retained

The complete route `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL` remains controlling after both Agent Contracts.

Retained constraints:

- Didactic authority owns learning meaning, terminology and misconception prevention;
- this functional stage may propose language but cannot select architecture or policy;
- repository, test and provider evidence prove only their named project boundary;
- implementation success cannot manufacture learner explanation, prediction, transfer or mastery;
- candidate, proposed, provisional, accepted, implemented, validated, blocked and deferred remain distinct;
- no KANBAN transition or lecture-history entry is authorized;
- only `DEV_STAGE/B_DIDACTIC.md` may be replaced;
- source, permanent Didactic memory, Main stages and every other stage remain untouched;
- Cycle 11 owns polished visual and interaction composition.

This report is explicitly speculative. It defines semantic obligations for later Main reconciliation and materialization; it does not describe implemented retention UI or an accepted recovery policy.

## 2. Controlling evidence boundary

Main accepts one decisive local convergence story:

```text
Drift A → Flutter HTTP → Fastify/PostgreSQL → Flutter HTTP → Drift B
```

The proved story includes complete Purchase aggregate application, duplicate-equivalent replay, acknowledgement by Device B and deterministic reopen evidence.

It does not establish:

- live Neon behavior;
- production authentication or Device enrollment;
- a supported offline duration;
- event deletion or acknowledgement expiry;
- application snapshots;
- full rebootstrap;
- account deletion semantics;
- provider-backup restoration;
- future recovery after a long disconnection.

Therefore `synchronized` may describe the named completed convergence fixture, but `recoverable`, `backed up`, `restorable` and `safe forever` remain unearned claims.

## 3. Vocabulary map

| Term | Provisional truthful meaning | Must not imply |
| --- | --- | --- |
| Local fact | Product/Purchase fact committed in one installation’s Drift database | a server or peer copy exists |
| Coordination copy | Event, cursor, acknowledgement or snapshot data held for synchronization | authoritative local history or analytics |
| Event history | Ordered immutable changes available after a cursor | a complete current account image |
| Application snapshot | Markei-defined complete-enough fact image for rebuilding a Device | Neon backup, raw database dump or universal restore |
| Provider backup | Provider-controlled PostgreSQL recovery mechanism | restore of one user, Device or local Drift file |
| Acknowledgement | One Device reported a contiguous locally applied cursor | backup, permanence or all-Device agreement |
| Synchronized | Named eligible Devices reached the stated fact/cursor condition | independently recoverable after server cleanup |
| Recoverable | A tested route can rebuild required application facts under stated conditions | merely synchronized once |
| Incremental catch-up | Apply retained events after a known cursor | full replacement of local state |
| Full rebootstrap | Rebuild from a trusted application snapshot, then catch up incrementally | automatic conflict-free merge |
| Cursor expired | Required events after this cursor are no longer available incrementally | local Purchase history was deleted |
| No new events | Server has no events after a valid current cursor | cursor is valid without proof |
| Supported offline window | Period during which the selected policy promises incremental or snapshot recovery | indefinite offline safety |
| Device inactive | Device has not connected within a policy interval | revoked or unauthorized |
| Device revoked | Server authorization for the Device has been withdrawn | remote erasure of its local files |
| Device replacement | Enroll a new installation/Device identity | restoration of the same Device identity |
| Recovery started | A recovery plan or transfer began | facts are usable or complete |
| Recovery completed | Snapshot applied, required catch-up applied and terminal checks passed | every future recovery is guaranteed |
| Server cleanup | Coordination records removed under policy | deletion of local Purchase history |
| Unknown outcome | Request may have committed but response is absent | retry with a new identity is safe |

## 4. User-state matrix

Cycle classification: `diagnostic` means Cycle 10 may require typed/plain-text evidence; `visual` means Cycle 11 owns presentation.

| State | Technical trigger | Known / unknown | Safe action | Avoid | Owner |
| --- | --- | --- | --- | --- | --- |
| Up to date on this Device | valid cursor reached current server high-water mark after committed apply | known for this Device and scope; other Devices unknown | none; retain timestamp/scope | `Everything is safe everywhere` | diagnostic now; visual C11 |
| Changes waiting to upload | durable pending Event exists | safe locally; server acceptance unknown | keep app data; retry normally | `Synced` | diagnostic now; visual C11 |
| Accepted by server | Submission/Event atomically committed or replayed equivalent | server copy known; peer application unknown | allow peer catch-up | `Backed up` | diagnostic now; visual C11 |
| Waiting for another Device | server accepted and named eligible peer acknowledgement is behind | origin/server state known; peer availability unknown | connect peer within policy window | `Almost finished everywhere` | policy-dependent; visual C11 |
| Device outside supported window | last valid contact exceeds accepted policy interval | long absence known; incremental recoverability may be unknown | prepare eligibility/recovery check | `Your data expired` | diagnostic after policy; visual C11 |
| Incremental history available | cursor is valid and all required later events remain retained | catch-up path known; final success unknown | download/apply pages | `Recovery complete` | diagnostic C10 |
| Full refresh required | typed cursor expiry or missing-history result | incremental route unavailable; snapshot viability may be unknown | stop incremental apply and request rebootstrap | `Local data is gone` | diagnostic C10; visual C11 |
| Refresh being prepared | server accepted snapshot/rebootstrap request or generation lease | work started; artifact completeness unknown | wait/retry same recovery identity | `Restoring` | diagnostic C10 |
| Snapshot downloading | bounded snapshot bytes are transferring | transfer progress known; validity/application unknown | continue or resume safely | `Data restored` | diagnostic C10; visual C11 |
| Snapshot downloaded, not applied | complete artifact received and validated but local transaction not committed | artifact available; local facts unchanged | apply through protected transaction | `Device recovered` | diagnostic C10 |
| Snapshot applied, catch-up pending | snapshot facts/cursor committed; newer events remain | base state known; current state not reached | incremental catch-up | `Up to date` | diagnostic C10 |
| Recovery completed | snapshot/apply/catch-up/reopen checks all pass | named Device recovered to named high-water mark | resume normal sync | `Permanent backup complete` | diagnostic C10; visual C11 |
| Recovery interrupted safely | interruption occurred before terminal completion with resumable identity/checkpoint | committed phase known; completion unknown | retry/resume same recovery identity | `Failed and rolled back` unless proven | diagnostic C10 |
| Local unsent changes block replacement | pending/uploading/unknown local Events exist before destructive rebootstrap | unsent local work exists; server equivalence unknown | upload/reconcile/export before replacement | `Reset now` | diagnostic C10; visual C11 |
| Credentials expired | verifier rejects expired/missing credential | local facts remain; server access unavailable | renew authentication | `Offline` or `data lost` | diagnostic C10; visual C11 |
| Device revoked | verified Device is inactive by authorization policy | network mutation denied; local erasure not implied | preserve local facts; follow re-enrollment/replacement policy | `Device deleted` | diagnostic C10; visual C11 |
| Cursor expired | server can prove requested incremental position is outside retained coverage | incremental gap known; snapshot recovery unknown until checked | require explicit full-rebootstrap route | `No updates` | diagnostic C10 |
| Server retention elapsed | named events/snapshots crossed deletion eligibility and were removed | coordination copies gone; local copies may survive | use remaining accepted recovery route | `Purchases deleted everywhere` | policy text C10; visual C11 |
| Account deletion pending | deletion accepted but defined cleanup phases incomplete | request recorded; each storage boundary may differ | show scopes and expected terminal evidence | `Deleted` | diagnostic contract C10; visual C11 |
| Account deletion completed | accepted deletion checks passed for defined application/server scopes | defined server copies removed; offline local copies may remain | explain residual local-device responsibility | `Erased from every Device` | diagnostic contract C10; visual C11 |
| Unknown outcome | response absent after possibly committed operation | commit status unknown | replay same idempotency identity and payload | `Try again as new` | diagnostic C10 |

## 5. Privacy and expectation language

Provisional explanation:

`Markei keeps Product and Purchase facts in each installation’s local database. When synchronization is enabled, the service may temporarily retain coordination events, acknowledgements and application snapshots so an authorized Device can catch up after being offline. The exact retention period and recovery coverage must be stated by the accepted policy. Server cleanup does not by itself delete Purchase history already stored on a Device.`

Required distinctions:

- coordination data survives while an eligible Device is offline because delivery cannot occur while that Device is absent;
- bounded retention is protocol operation, not developer analytics;
- absence of analytics does not mean absence of synchronization data;
- a snapshot should contain only the immutable Markei facts and protocol metadata required to rebuild the supported application state;
- snapshot content must exclude credentials, authorization headers, provider secrets and unrelated telemetry;
- server copies may remain only for the accepted duration, eligibility and deletion rules;
- after the supported window, incremental history may be unavailable and full rebootstrap may be required;
- local history survives server cleanup unless the local Device separately deletes it;
- synchronization does not replace export because export is a user-readable artifact;
- synchronization does not replace backup because it may propagate mistakes and obey bounded retention;
- account deletion may require staged deletion across application rows, snapshots, events and provider backup cycles;
- provider backup schedules and expiry are infrastructure facts, not immediate application-level deletion guarantees;
- logs may contain operation code, outcome, retryability, correlation ID, redacted aliases, cursor ranges, counts, timings and hashes;
- logs must not contain Purchase/Product/Store/Person/Payment facts, tokens, passwords, connection strings or raw snapshot bodies.

## 6. Misconception register

| Misconception | Required correction |
| --- | --- |
| `Acknowledged means backed up forever` | acknowledgement proves one Device reported a committed cursor under one policy |
| `No downloaded events means current` | current requires a valid cursor/high-water comparison, not an empty response alone |
| `Cursor expired means local data deleted` | expiry concerns missing server history for incremental catch-up |
| `Rebootstrap merges everything automatically` | replacement/merge behavior needs explicit conflict and unsent-change rules |
| `Server cleanup deletes every Device purchase` | cleanup removes server coordination copies, not autonomous local databases |
| `Neon backup restores one user’s local state` | provider backup restores provider storage; Markei needs its own scoped snapshot/rebuild contract |
| `One successful sync proves future recovery` | one convergence fixture does not validate retention expiry or rebootstrap |
| `Revoking a Device erases its copies` | revocation stops authorization; remote local erasure is a separate, generally unprovable operation |
| `Snapshot downloaded means recovery complete` | validation, atomic apply, incremental catch-up and reopen evidence remain |
| `Inactive means revoked` | inactivity is time-based observation; revocation is an authorization decision |
| `Replacement restores the same Device` | a new installation normally needs a new Device identity and explicit history policy |

## 7. Policy alternatives

### A. Fixed retention window

User expectation: events remain available for a stated number of days.

Likely misunderstanding: any Device reconnecting before the date is guaranteed to recover, even if snapshots, failures or account state differ.

Recovery promise: incremental catch-up only while the required cursor range remains retained; afterward recovery is unavailable unless another mechanism exists.

Language risk: `kept for 30 days` may sound like backup or deletion from local Devices after day 30.

### B. Active-Device lease

User expectation: Devices that periodically renew eligibility remain covered.

Likely misunderstanding: `active` means currently online, trusted forever or user-visible usage activity.

Recovery promise: coordination copies are retained according to eligible Device acknowledgements/leases; expired Devices require re-enrollment or rebootstrap.

Language risk: hidden lease expiry can feel like unexplained data loss unless the supported window and consequences are explicit.

### C. Hybrid retention plus snapshot coverage

User expectation: recent events support incremental catch-up; a current application snapshot supports full refresh after the event window.

Likely misunderstanding: snapshot means provider backup, automatic merge or complete historical archive.

Recovery promise: valid cursor → incremental catch-up; expired cursor → protected snapshot replacement followed by incremental catch-up, subject to unsent-change checks.

Language risk: `full refresh` may be heard as destructive reset, and `snapshot available` may be heard as recovery completed.

## 8. Preferred semantic hypothesis

Provisional recommendation: **hybrid bounded event retention plus application snapshots and explicit active-Device eligibility**.

Confidence: medium.

Reasons:

- fixed events alone eventually strand long-offline Devices;
- leases alone do not provide a reconstruction artifact;
- the hybrid model can state two honest routes: incremental catch-up or full rebootstrap;
- it allows server cleanup without promising permanent event history;
- it can protect local unsent work before replacement;
- it separates Markei application recovery from Neon provider backup.

This is not canonical. Main must still select durations, snapshot ownership, eligibility, deletion and conflict rules.

## 9. Second implementation semantic contract

Codex tests should minimally materialize:

1. a typed `cursor-expired` or semantically equivalent response distinct from an empty valid page;
2. an explicit `full-rebootstrap-required` result with `not-applied` outcome and safe action;
3. a snapshot/recovery identity reusable after interruption;
4. phase-specific progress: `preparing`, `downloading`, `downloaded`, `applying`, `catching-up`, `completed`;
5. no phase before terminal verification may emit `recovered` or `up-to-date`;
6. interruption-safe retry that resumes or replays the same recovery identity;
7. atomic snapshot apply with cursor and fact integrity evidence;
8. incremental catch-up after snapshot cursor before completion;
9. reopen comparison before `recovery-completed`;
10. protection that blocks destructive replacement when pending, uploading or unknown local submissions exist;
11. typed revoked, expired-credential, account-deleting and unknown-outcome diagnostics;
12. privacy-safe codes, counts, cursors, correlation IDs and redacted hashes only;
13. no polished synchronization page, progress component, Device manager or Cycle 11 composition.

Suggested evidence-specific tests:

- `empty valid page is not cursor expired`;
- `expired cursor requires full rebootstrap`;
- `snapshot download does not claim recovery complete`;
- `snapshot apply is followed by incremental catch-up`;
- `interrupted recovery reuses recovery identity`;
- `pending local events block destructive replacement`;
- `server cleanup leaves existing local purchases unchanged`;
- `provider backup is not used as an application snapshot`.

## 10. MCG-01 learning boundary

During MCG-01 the developer must distinguish:

- Neon branch: provider environment lineage/compute-storage branch;
- database: named PostgreSQL database inside the selected provider branch;
- provider backup: infrastructure recovery mechanism for provider storage;
- application snapshot: Markei-defined fact package for one synchronization recovery contract;
- migration role: privileged schema-change identity;
- runtime role: least-privilege API data-access identity;
- branch expiry: provider lifecycle behavior;
- event retention: Markei application policy;
- secret evidence: the actual credential or credential-bearing URL, which must never be requested;
- sanitized evidence: aliases, region/version, role names, migration hash, timestamps and pass/fail results.

Successful provider setup is project evidence only. It does not prove learner mastery, retention correctness, application recovery or production readiness.

## 11. Cycle 10 / Cycle 11 boundary

Cycle 10 owns:

- typed states and failure distinctions;
- recovery phase truth conditions;
- safe-action contracts;
- privacy-safe diagnostics;
- tests preventing premature completion claims;
- plain-text policy wording required to interpret functional behavior.

Cycle 11 owns:

- page placement and navigation;
- cards, banners, dialogs, icons, progress bars and history views;
- retry controls and Device-management presentation;
- wording hierarchy, severity and timing;
- visual/accessibility composition and broader synchronization polish.

Cycle 10 must not postpone semantic truth to Cycle 11. Cycle 11 must not visually imply guarantees absent from Cycle 10 contracts.

## 12. Unresolved Main decisions

1. Fixed event-retention duration and its start/refresh trigger.
2. Whether Device eligibility uses acknowledgement, lease, explicit enrollment state or a combination.
3. Snapshot creation trigger, frequency, version, scope and encryption boundary.
4. Which immutable facts and tombstones a snapshot contains.
5. Whether snapshots are per Account, per protocol version or per Device eligibility class.
6. Snapshot expiry and the terminal state when both event and snapshot coverage are gone.
7. Exact protection/merge behavior for local unsent changes before rebootstrap.
8. Whether replacement creates a new Device identity and how historical acknowledgements are treated.
9. Revocation, inactive-Device and lost-Device semantics.
10. Account-deletion phases, provider-backup lag and residual offline local copies.
11. Which Devices count toward `waiting-peer`, `synchronized` or account-level recovery statements.
12. MCG-01 evidence required before provider-backed retention tests.
13. Whether local adversarial expiry/rebootstrap tests precede MCG-02.
14. Final user-facing supported offline window and recovery promise.

## 13. Disposition

```text
accepted project evidence:
  bounded local HTTP/PostgreSQL convergence for one complete Purchase fixture

implemented retention/recovery policy:
  none accepted by this investigation

proposed:
  truthful vocabulary, state matrix, hybrid retention/snapshot hypothesis,
  privacy language and second-implementation semantic test contract

blocked / unresolved:
  duration, Device eligibility, snapshots, rebootstrap, account deletion,
  provider-backup relationship and unsent-change reconciliation

Cycle 11 deferred:
  polished pages, visual progress, Device management and broader UX composition

learner maturity:
  unchanged; no KANBAN transition and no lecture-history event

speculative status:
  explicit; all policy and wording recommendations await Main reconciliation
```
