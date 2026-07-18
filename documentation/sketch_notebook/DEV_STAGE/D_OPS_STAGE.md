# D_OPS_STAGE — Hosted Account/Device Binding Correction

> Authority marker: C10-MCG02-HOSTED-IDENTITY-BINDING_20260718T155856Z
> Required ancestor: 0b219602fe6eb4dc7976cea3a7d2d00fce930500
> Status: **ACTIVE BOUNDED CODEX AUTHORITY**

## Objective

Bind post-enrollment Flutter composition to the stored hosted AccountId and server DeviceId, and
scope every hosted synchronization repository to that binding. Preserve all existing local-only
facts/outbox entries without rewriting, discarding or uploading them.

## Required behavior

1. Before enrollment, retain the existing local-only Account/Device composition.
2. Enrollment stores hosted AccountId, server DeviceId and installation state as today.
3. The enrolling process returns `hosted-restart-required` before any hosted sync.
4. On restart, validate the stored binding and select its AccountId/server DeviceId for new purchase
   registration and hosted sync.
5. Reject malformed/incomplete/revoked bindings and fall back to safe local-only behavior.
6. Scope hosted outbox leasing and unknown-submission replay by hosted AccountId and DeviceId.
7. Scope download cursor, inbox validation, fact application and acknowledgement to the hosted
   AccountId; reject any downloaded cross-Account event.
8. Leave pending local-only events untouched and visible to their original local Account.

## Invariants

- Never mutate IDs or hashes inside an existing immutable event.
- Never relabel existing local facts as hosted facts.
- Never upload a local-only event through a hosted binding.
- Never select the first arbitrary cursor from a multi-Account Drift database.
- New hosted events embed exactly the stored hosted AccountId/server DeviceId.
- Device sequence begins and advances under the hosted local Device row consistently with server
  enrollment state.
- Logout does not delete local facts or silently erase the hosted binding.
- Revocation blocks hosted sync without corrupting local state.

## Tests

Add decisive tests for:

- pre-enrollment local registration remains local-only;
- enrollment requires restart before hosted sync;
- restart selects stored hosted AccountId/server DeviceId;
- a new post-binding event exactly matches the hosted IDs;
- older local-only pending events are not leased or changed;
- hosted pending events upload successfully through the real loopback server authorization shape;
- scoped cursor/ack uses only the hosted Account;
- cross-Account download is rejected without mutation;
- incomplete, malformed and revoked binding fail closed;
- two isolated databases bind the same hosted Account with distinct server Device IDs and converge;
- close/reopen preserves each binding and authoritative facts.

Use file-backed Drift and real existing HTTP/upload/download/apply/ack services. Do not weaken the
server, rewrite hashes or make fixtures bypass identity validation.

## Boundaries and validation

No migration, server authorization, Auth0/Neon/Render resource, Drift schema/reset, automatic
membership, product UX, permanent memory or MCG-03 change is authorized. Prefer additive scoped
constructors/ports over global behavior changes; retain existing local lab tests.

Run formatting, analysis, focused/full Flutter tests, Android debug and Windows release when
host-supported, affected server tests, `git diff --check` and secret scan. Replace G/H/I with actual
paths, commands, counts, identity-scope evidence and exclusions. Commit/push one bounded unit.

Success terminal:

~~~text
MCG-02_HOSTED_IDENTITY_BINDING=true
MCG-02_HOSTED_OUTBOX_SCOPED=true
MCG-02_HOSTED_CURSOR_APPLIER_SCOPED=true
MCG-02_LOCAL_ONLY_EVENTS_PRESERVED=true
MCG-02_TWO_DEVICE_BINDING_CONVERGED=true
MCG-02_DECISIVE_PROVIDER_PROOF_READY
~~~

Otherwise report `MCG-02_HOSTED_IDENTITY_BINDING_PARTIAL`. Do not execute provider proof or MCG-03.
