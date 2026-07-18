# D_OPS_STAGE — MCG-02 Executable Closure Correction

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
> Required ancestor: 214df17
> Status: **ACTIVE BOUNDED CODEX AUTHORITY**

## Objective

Make the accepted Auth0 composition human-executable and truthful: expose a development-only native
closure surface, replace the false enrollment-only sync probe with the existing real hosted
synchronization path, and prove a Windows binary when the host supports it.

## Preflight

Read methodology, J and D/E/F; confirm clean tracked state, branch
`intermid-cycle-recovery` and ancestry `214df17`. Preserve all unrelated and private local files.
Do not read or use provider values, credentials, tokens, `.env*`, `.vscode` or `NEON_*`.

## CP1 — Truthful closure port

- Introduce a narrow application port for the real hosted synchronization action/result.
- Wire it to existing HTTP upload/download, local applier, cursor and acknowledgement services.
- `hostedSyncProbe` must execute that port; Device-enrollment replay is not synchronization.
- Return semantic results such as `sync-completed`, `sync-no-new-events`, `sync-interrupted`,
  `authentication-required`, `device-enrollment-required` and `sync-unavailable`.
- Never infer synchronization availability merely from a stored server Device ID.
- Preserve absolute deadlines, query-after-unknown, local facts/outbox and acknowledgement-after-
  commit invariants already proved by R05.

## CP2 — Development-only native surface

- Add the smallest neutral surface needed to invoke status, sign-in, enrollment/query, real hosted
  sync and logout on Android and Windows.
- Gate it behind an explicit compile-time development flag that defaults false.
- When false or provider configuration is absent, existing product navigation and local behavior
  remain unchanged.
- Display semantic state names only. Never display/copy tokens, claims, subjects, provider IDs,
  Account/Device IDs, connection data or fact payloads.
- Do not redesign product UI or begin Cycle 11 work.

## CP3 — Stable Device execution

- Use the existing durable local installation/Device identity; do not generate a new installation
  identity per button press.
- Enrollment request identity must be durable/replayable until resolved.
- Same request/hash replays; a changed hash conflicts; unknown outcomes remain queryable.
- Do not auto-provision external identities, membership or Devices outside existing routes.

## CP4 — Proof

Add deterministic tests proving:

- surface absent/inert by default and available only with the development flag plus valid config;
- sign-in → enrollment → real sync → logout state sequence;
- enrollment-only success cannot produce a sync-success state;
- real upload/download/apply/ack is invoked and local facts converge in the loopback harness;
- interruption/401/unknown/revoked Device preserves facts and outbox;
- no token or private identifier enters diagnostics or durable storage;
- stable installation/request identity survives retry and restart;
- Android callback behavior remains valid;
- Windows callback routing and composition remain valid.

Fakes may prove local state behavior but cannot stand in for the existing real HTTP/file-backed sync
harness or for provider acceptance.

## CP5 — Validation and reports

Run dependency-lock, format, analysis, focused and full Flutter tests, Android debug build, and
Windows release build when host-supported. If Windows remains excluded, report the exact host gate;
do not claim Windows binary readiness. Run affected server checks if shared contracts change, plus
`git diff --check` and tracked/staged secret scan.

Replace G/H/I with actual baseline/final SHA, exact paths, commands, counts, exclusions, semantic
states, dependency direction and privacy evidence. Remove stale `final commit pending` wording.

Do not change migrations 001–006, server authorization semantics, Drift schema, provider resources,
permanent memory or methodology. Commit and push one bounded unit without force.

Success terminal:

~~~text
MCG-02_NATIVE_CLOSURE_SURFACE=true
MCG-02_REAL_HOSTED_SYNC_PATH=true
MCG-02_STABLE_DEVICE_EXECUTION=true
MCG-02_TOKEN_EPHEMERAL=true
MCG-02_NATIVE_PROVIDER_PROOF_READY
MCG-02_DECISIVE_PROVIDER_PROOF_PENDING
~~~

Otherwise report `MCG-02_NATIVE_CLOSURE_CORRECTION_PARTIAL` with the exact blocker. Do not proceed
to provider mutation, permanent promotion, Cycle 10 closure, MCG-03 or MCG-04.
