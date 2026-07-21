# E_DDC_STAGE — Unknown Recovery Semantics

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Status: **ACTIVE CODEX SEMANTIC AUTHORITY**

## Vocabulary

- `unknown` — the client cannot prove whether the hosted transaction applied; it is neither pending
  nor failed.
- `exact retry` — retransmission of the same persisted submission ID, request hash, ordered members
  and event facts.
- `duplicate-equivalent` — the server proves the exact earlier submission/effect already exists; it
  is a successful convergence result, not a second application.
- `next local sequence 3` — sequences 1 and 2 were allocated locally; it does not claim that either
  was accepted remotely.
- `server next expected sequence 1` — bounded provider evidence observed before this unit; it must
  be re-established during the later human verification and not hard-coded into the client.
- `recovery action` — an explicit guarded retry of eligible unknown work, not manual reclassification.

## User meaning

Closure must explain that unknown work needs review because its remote outcome was not established.
The recovery action must say what it will preserve, require confirmation, and report only stable
outcomes and safe next guidance. It must not invite the user to create replacement purchases,
reenroll, clear data, or repeatedly press Sync.

`Retry unresolved submission` is distinct from ordinary `Sync`: it targets the persisted unknown
submission under stricter preflight rules. Cancellation, ineligibility and unavailable evidence are
distinct from failure.

## Evidence and privacy

The displayed sequence numbers and bounded state codes are diagnostic facts. Complete IDs, hashes,
payloads, tokens, provider addresses, callback URLs, raw errors and registry command contents do not
belong in the UI or G/H/I evidence.

Repository tests establish implementation behavior. Only a later controlled run against the real
Windows database and disposable hosted environment can validate recovery and convergence.
