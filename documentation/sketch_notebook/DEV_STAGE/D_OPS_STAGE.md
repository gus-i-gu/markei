# D_OPS_STAGE — C10-GCM03-S10-R03 corrective implementation

## Active authority

Authority state: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED

Primary unit: C10-GCM03-S10-R03  
Human-assay continuity alias: C10-GCM03-S09-R03  
Previous unit: C10-GCM03-S10-R02  
Repository: gus-i-gu/markei  
Existing branch: grm-guarded-provisioning-20260727  
Required pre-stage ancestry: 1975bf0d216ff03a3ead6c47e0892df00d55d62e  
Required Codex starting head: the published R03 staging commit containing this file, as pinned by Main.

This is a bounded FLX-ORD-01 correction entered from failed human acceptance. D controls operations; E/F constrain semantics and architecture. J and REC_DIAGNOSTICS.md remain append-only.

## 1. Diagnostic conclusion

R02 passed the Purchase selector regression but not inter-device convergence.

Windows operation e6e918285640 proves authenticated upload/download requests, HTTP 200 provider responses, trusted upload-result persistence, and download-response-received. No acknowledgement began. An exception then escaped before a durable download-local-apply result. NativeAuthClosureRunner emitted closure-runner-exception and incorrectly replaced the proved trusted response with not-received.

Android separately proved that a new incoming Product UUID with the same exact semantic identity but a different user Product code is rejected as remote-product-natural-identity-conflict. Repeating Sync replays the unacknowledged page.

Windows facts/inbox/cursor commit versus rollback is unproved. The unknown interval includes applyPage and durable local-apply diagnostics. R03 must separate transaction truth from diagnostic truth.

## 2. Writable scope

Codex may minimally modify source/tests under clients/markei_flutter/lib/application, app, domain, infrastructure/local, and clients/markei_flutter/test.

Codex shall replace only G_OPS_CODEX.md, H_DDC_CODEX.md, and I_DSN_CODEX.md. No other GRIMOIRE file is writable.

## 3. Product reconciliation

For an established incoming UUID, require full immutable snapshot coherence, including user code. Contradiction is a typed conflict.

For a new incoming UUID:

| Code match | Exact-identity match | Action |
|---|---|---|
| none | none | Insert |
| same row | same row | Reuse and map |
| one row | none | Typed same-code/different-identity conflict |
| none | one row | Reuse exact row despite different code; preserve local code/display |
| different rows | different rows | Typed split-key conflict |
| ambiguous | any | Typed bounded conflict |
| any | ambiguous | Typed bounded conflict |

Exact semantic identity is Product.identityKey and normalized Account/name/brand/mode/measurement/package facts. It deliberately excludes user code and raw display formatting. A new UUID with same exact identity but another code is a convergence candidate.

Maintain incoming Product UUID → selected local Product UUID mapping for every Purchase Item. Preserve existing Store mapping/rules unless source-proved evidence requires a minimal correction.

Do not rewrite hosted events/existing Products or add an alias table, migration, dependency, provider mutation, constraint exception, or global equality override.

## 4. Total local-apply boundary

Keep one Drift transaction covering Product/Store reconciliation, Purchases/Items, inbox, and Account cursor.

Any exception inside must escape first so Drift rolls back completely. Translate only after rollback into a bounded category: identity conflict, SQLite/Drift database failure, payload/snapshot shape failure, local invariant failure, or unexpected local-apply failure.

Use typed/library-aware checks where available, not only runtime-name substring tests. No applyPage exception may escape into the UI runner.

Allow only sanitized exception class/category. Never retain messages, SQL, values, payloads, catalogue facts, UUIDs, stacks, tokens, secrets, or full hashes.

## 5. Core truth and diagnostics

Observability must not alter synchronization truth.

Update an in-memory causal snapshot before durable diagnostics. Retain entered/proved phase, provider/trusted-response state, apply state, local mutation/result persistence, acknowledgement, bounded result, and sanitized class.

If apply rolls back: report not-applied/rolled-back and do not acknowledge.

If apply commits but diagnostics persistence fails: keep committed facts/cursor, do not relabel as rolled back, do not abort the core result, and report bounded diagnostics-persistence-degraded.

NativeAuthClosureRunner may keep a safety catch, but must use the strongest causal snapshot. It must never rewrite download-response-received/trusted-received as terminal/trusted-not-received.

## 6. Exception visibility

The diagnostics table already stores sanitizedExceptionClass. Propagate it through repository projection, application summary, current-action mapping, and Closure UI technical details. Show only the bounded class/category. No migration.

## 7. Acknowledgement/replay

Acknowledgement begins only after complete local commit and cursor advancement. Failed, rejected, rolled-back, or unproved apply means no acknowledgement/cursor advance. Committed apply with diagnostic degradation remains committed. Replay stays idempotent.

## 8. Required tests

Product identity:

- new UUID + exact identity + different code reuses one local Product;
- same code + different identity conflicts;
- split keys, ambiguity, and established UUID mutation conflict;
- local code/display is preserved;
- Purchase Items use the remote-to-local mapping;
- mixed Android/Windows cursor page converges without duplicates;
- prior rejected hosted event no longer poisons later pages.

Transaction/protocol:

- generic non-SQL exception rolls back all facts/inbox/cursor;
- no acknowledgement after failed/unproved apply;
- cursor advances atomically;
- replay remains idempotent;
- typed conflict/database categories remain bounded.

Diagnostics:

- trusted response survives every apply failure;
- latest causal phase remains precise;
- runner cannot overwrite stronger evidence;
- sanitized class reaches summary/UI;
- diagnostic persistence failures before apply, during reporting, and after committed apply are contained;
- diagnostics cannot flip committed versus rolled-back truth;
- forbidden diagnostic content is absent.

Regression:

- stable Product-ID selection/Find Item;
- Store convergence, upload-result persistence, queue behavior, v3 Person/Payment restrictions;
- unchanged hosted API/payload version.

## 9. Validation

Record exact outcomes for format, flutter analyze, focused identity/apply/diagnostics/sync tests, full flutter test, debug APK and Windows builds, manifest inspection where applicable, git diff --check, sensitive scan, and changed-file inventory. Skipped labs are not live evidence.

## 10. Prohibited

No live client Sync/Retry/Recovery/Enroll/Query, diagnostic clearing, new Purchase, data reset, database surgery, provider/API/auth/enrollment/schema/migration/dependency change, branch creation/rename, force push, or GRIMOIRE authority/history edit. Do not modify DB_MGMT.sql, G_SCRIPTS.md, or I_SCRIPTS.ps1.

If scope expansion is required, stop with a precise G/H/I blocker.

## 11. Terminals

~~~
C10_GCM03_S10_R03=IMPLEMENTED_VALIDATED | BLOCKED
PRODUCT_EXACT_ID_DIFFERENT_CODE=PASS | FAIL
PRODUCT_CODE_DIFFERENT_IDENTITY_CONFLICT=PASS | FAIL
REMOTE_ITEM_ID_REMAP=PASS | FAIL
REMOTE_PAGE_ATOMICITY=PASS | FAIL
UNEXPECTED_LOCAL_APPLY_TRANSLATION=PASS | FAIL
DIAGNOSTIC_PERSISTENCE_CONTAINMENT=PASS | FAIL
CAUSAL_EVIDENCE_PRESERVATION=PASS | FAIL
SANITIZED_EXCEPTION_CLASS_UI=PASS | FAIL
ACKNOWLEDGEMENT_AFTER_UNPROVED_APPLY=NOT_STARTED | VIOLATED
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
~~~

Publish one non-forced fast-forward commit containing only authorized source/test/G/H/I files.
