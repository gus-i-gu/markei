# E_DDC_STAGE — C10-S01B Synchronization Semantics Contract

> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH D/F
> Scope: typed state, recovery, diagnostics and privacy
> Learner maturity: unchanged
> Cycle 11 visual/interaction work: protected

## 1. Objective

Materialize truthful semantics for one complete local `purchase.registered` convergence proof.
Contracts, code, tests and diagnostics must distinguish persistence, attempted transport, server
acceptance, download receipt, committed fact application and Device acknowledgement.

No page, banner, pairing flow, dashboard, navigation, visual polish, accessibility redesign or
Analytics work is authorized. Minimum diagnostics remain machine-readable or plain text.

## 2. Required state meanings

| State/code | Meaning earned by implementation | Must not imply |
| --- | --- | --- |
| `saved-local` | Purchase and outbound Event committed locally | queued transfer completed |
| `waiting-upload` | durable pending Event has no active attempt | server has received it |
| `uploading` | one request attempt is active | outcome is known |
| `server-accepted` | server committed or replayed equivalent Submission/Event | a peer applied it |
| `download-received` | one bounded page arrived and passed transport decoding | facts committed |
| `downloaded-applied` | complete facts, inbox and page cursor committed atomically | all Devices agree |
| `duplicate-ignored` | equivalent replay caused no second effect | conflicting content ignored |
| `acknowledged` | this Device reported its committed contiguous cursor to server | universal delivery |
| `conflict` | same identity/content rules cannot accept both versions | automatic merge allowed |
| `auth-required` | verified identity unavailable/rejected | offline failure |
| `device-revoked` | verified Device is not active | local facts should be deleted |
| `protocol-upgrade-required` | event/schema/cursor version unsupported | retry unchanged will work |
| `unknown-outcome` | request may have committed but response is absent | a replacement ID is safe |

`waiting-peer`, `cursor-expired` and account-level `converged` may remain declared for future units,
but C10-S01B must not emit them as product facts without eligible-Device/retention policies.

## 3. Typed result contract

Every transport/application/API failure exposes fields equivalent to:

```text
operation
code
outcome: applied | duplicate-equivalent | not-applied | unknown
retryable: true | false
safeAction
correlationId
optional field / eventId / submissionId
```

Raw SQL/Fastify exceptions, stack traces, credentials and payloads never cross the boundary.
Required safe semantics:

- timeout after possible upload commit → `unknown`; retry identical SubmissionId/request hash;
- same identity/same hash → `duplicate-equivalent`; reuse stored/applied result;
- same identity/different hash → `not-applied`; terminal conflict, preserve local facts;
- cursor gap/reorder → `not-applied`; retain old cursor and request valid replay;
- local apply failure → full rollback; safe replay of the same page;
- serialization/deadlock exhaustion → retryable service unavailable; preserve same Submission;
- revoked Device/protocol mismatch/entity collision → non-retryable until explicit recovery/change;
- API unavailable before acceptance → preserve pending local work and retry later.

No safe action may advise local deletion, reset, identity replacement or a new business Event merely
to escape uncertainty.

## 4. Convergence evidence

The system test may emit `CONVERGED=true` only when it proves:

1. A committed the Purchase/Event locally;
2. A used the real HTTP route and PostgreSQL committed the Submission;
3. a lost post-commit response was recovered with the identical Submission;
4. PostgreSQL contains one immutable Event and cursor;
5. B downloaded through the real route;
6. B atomically committed complete Store/Product/reference/Purchase/Item facts, inbox and cursor;
7. duplicate delivery caused no second effect or outbound echo;
8. B acknowledged the contiguous committed cursor through the real route;
9. server stored the acknowledgement;
10. reopened A/B facts and derived Lists matched the deterministic fixture.

Server acceptance alone proves only step 2. Inbox/cursor without business facts is bookkeeping, not
application. One Device acknowledgement is not all-Device convergence.

## 5. Contract and collision language

`purchase.registered` v3 represents one immutable Purchase aggregate. Its payload must carry every
immutable fact needed by a fresh peer. Non-null Person/Payment references require complete immutable
snapshots. Equivalent stable facts are reused. Any stable ID, Product code or exact-identity key
with differing immutable content is `conflict`; never call it a similar Product, overwrite, merge or
reassign its visible code automatically.

Lists remain local projections. They are compared as derived evidence and never synchronized as
authoritative facts.

## 6. Diagnostics and privacy

Allowed lab output:

- synthetic aliases, operation/code/outcome and correlation ID;
- redacted ID/hash suffixes, cursor before/after, counts and elapsed timing;
- retry-identity equality, fact/List comparison and reopen pass/fail;
- explicit `CONVERGED=false|true` based on section 4.

Forbidden output:

- credentials, tokens, connection strings, authorization headers or secret URLs;
- Purchase/Product/Store/Person/Payment payloads or ordinary user database paths;
- telemetry, developer analytics or misleading anonymous-data claims.

The lab uses synthetic data and disposable local infrastructure. Normal Markei remains local-only
unless synchronization is explicitly configured in a later authorized unit. Synchronization is not
backup, export, restore, provider recovery or indefinite history.

## 7. Test naming and protected boundary

Use evidence-specific names such as:

- `server acceptance does not claim peer application`;
- `unknown outcome reuses the same submission`;
- `download receipt does not advance cursor before fact commit`;
- `duplicate remote purchase creates no second fact or outbound event`;
- `acknowledgement follows committed contiguous apply`;
- `local registration works when API is absent`.

Cycle 11 owns final user copy placement, retry controls, status history, pairing/Device management,
accessibility and visual composition. Repository evidence does not advance KANBAN or learner status.

## 8. H report and acceptance

Replace only `DEV_STAGE/H_DDC_CODEX.md`. Report codes/meanings materialized, owning files and named
tests; privacy/log evidence; diagnostic output; misleading terms removed/avoided; unchanged learner
maturity; untouched Cycle 11 surfaces; and live provider/auth semantics skipped.

E is satisfied only when tests prevent local-save/server-accept/download/apply/ack conflation and
the complete convergence claim is mechanically tied to section 4.
