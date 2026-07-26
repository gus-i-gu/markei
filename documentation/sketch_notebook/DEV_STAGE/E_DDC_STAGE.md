# E_DDC_STAGE — Ordinary-Sync declaration meaning

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Didactic materialization authority
Unit: C10-GCM02-S12-ERR-03
Branch: `cycle10-intermid-grimoire`
Required ancestry: `3d1e82e5259cf51e8cd2d6baf694423494bab7a5`
Status: **ACTIVE — NARROW SOURCE MATERIALIZATION ONLY; GATE 12.7 HELD**

## 1. Accepted distinctions

Preserve these meanings:

- hosted readiness proves only that the readiness route answered;
- generic completion is not ordinary-Sync success;
- the client owns the complete ordinary-Sync terminal;
- the server owns only the request/transaction terminal it observed;
- `client-operation` and `server-request` declarations are correlated but not
  interchangeable;
- a client timeout before response is not a proved server timeout;
- a trusted rejection is not a transport failure;
- server request success does not prove client local persistence;
- inspection, Retry, recovery and ordinary Sync remain separate actions;
- implementation and assay preparation do not authorize Gate 12.7.

The displayed “Last successful sync” advanced after
`hosted-connection-ready`; that projection is wrong and must be corrected.

## 2. User vocabulary

Use this ordinary-Sync terminal vocabulary consistently in code, UI, tests and
diagnostic projections:

| Result code | User meaning |
| --- | --- |
| `sync-completed` | Sync completed successfully |
| `sync-no-new-events` | Sync completed; no new events were found |
| `sync-rejected` | The server rejected the Sync request; no successful Sync is claimed |
| `sync-server-timeout` | The server reported an enforced timeout; successful Sync is not claimed |
| `sync-failed` | Sync failed without another more precise trusted terminal |

The technical detail may retain the literal result code, but the main
user-facing sentence should remain plain.

When the server was not observed, say:

```text
Server declaration: not observed
```

Do not say “server timeout” when only the client deadline expired. Say:

```text
Client stopped waiting before a trusted response.
Server outcome remains unknown.
```

## 3. Closure presentation

The Closure page must make these surfaces visually and textually distinct:

```text
Hosted readiness
Ordinary Sync result
Failed/notApplied inspection
Controlled recovery
Unknown-outcome Retry
```

Correct:

```text
Last successful sync
  only the latest ordinary-sync / sync-completed or sync-no-new-events

Recent Closure attempts
  all bounded Closure operations, labelled by operation kind
```

The latest ordinary-Sync detail should show:

- client declaration;
- server declaration or `not observed`;
- declaration scope;
- last proved phase;
- elapsed/deadline values;
- operation and correlation fingerprints;
- safe next action.

Keep the normal view compact. Additional detail may use the existing
expandable technical-details surface. Do not introduce a large ERR table,
support bundle or general telemetry panel.

## 4. Timing explanation

The source default changes from five seconds to a 35-second hosted
ordinary-Sync client deadline for the focused assay. This is a diagnostic
relaxation, not proof that timing was the root cause and not a general
performance target.

If a server-owned 25-second deadline is safely enforceable, the client waits
longer so it can receive the server’s typed terminal. If safe cancellation and
rollback are not provable, the server timeout result must remain unavailable.

User-visible timing must distinguish:

```text
configured deadline
observed elapsed time
deadline owner: client or server
```

## 5. Tests and documentation

Tests must prove:

- readiness never appears as successful Sync;
- the two success codes and three non-success codes remain distinct;
- client and server declarations carry visible scopes;
- unavailable server evidence says `not observed`;
- timeout wording identifies its owner and does not invent causality;
- `Recent Closure attempts` accurately labels its contents;
- forbidden identifiers and secret-bearing data are absent;
- normal UI remains concise.

If the diagnostic vocabulary changes, update the single registry and
regenerate Dart, TypeScript and `ERR_DIAGNOSTICS.md`. Do not hand-edit generated
projections.

Do not edit permanent didactic memory.

H terminal markers:

```text
READINESS_SYNC_MEANING=SEPARATE_OR_BLOCKED
CLIENT_SERVER_SCOPE_MEANING=SEPARATE_OR_BLOCKED
FIVE_SYNC_RESULTS=VISIBLE_OR_BLOCKED
TIMEOUT_OWNERSHIP=VISIBLE_OR_BLOCKED
LAST_SUCCESSFUL_SYNC_LABEL=TRUTHFUL_OR_BLOCKED
RECENT_CLOSURE_ATTEMPTS_LABEL=ALIGNED_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```
