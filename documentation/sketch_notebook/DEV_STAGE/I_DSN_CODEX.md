# I_DSN_CODEX - Windows Callback and Credential Design Evidence

- Authority marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
- Baseline SHA after fast-forward: fc4af17c766f39715fe909b9fbda587e1bb7b881
- Final commit SHA: reported by Codex terminal response after commit publication.
- Dependency decision: `auth0_flutter` remains pinned at 2.4.0; no dependency update was needed.

## Callback and Credential Flow

The corrected boundary is:

`Auth0 browser -> auth0flutter protocol activation -> secondary runner -> current-user named pipe -> primary runner -> PLUGIN_STARTUP_URL under SDK lock -> Auth0 SDK polling transaction -> code exchange -> defensive credential checks -> ExternalAuthenticationSession`.

The runner still owns OS activation and bounded forwarding. The Auth0 SDK still owns OAuth state,
PKCE, code exchange and token construction. The Markei adapter owns closed diagnostic mapping and
defensive credential acceptance.

## Runner / Plugin Boundary

The pinned Auth0 Flutter 2.4.0 reference runner includes `plugin_startup_url_lock.h` and writes
`PLUGIN_STARTUP_URL` under `auth0_flutter::WriteLockGuard`. Markei now does the same for first
startup callbacks and forwarded secondary-instance callbacks.

Retained security invariants:

- exact `auth0flutter://callback` prefix;
- single-instance mutex;
- named pipe forwarding;
- current-user SID pipe security;
- bounded string framing and null termination;
- no callback data logs;
- wrong-prefix inputs ignored before SDK handoff.

## Safe Diagnostic Mapping

Provider and SDK failures are normalized to a closed set before reaching application state.
Credential validation is defensive only: access and ID tokens must be present, distinct and beyond
the safety margin. No JWT body parsing is used as a substitute for hosted issuer, audience,
signature or authorization verification.

## Deviations and Deferred Work

The test proof for Windows protocol activation is source-level and build-level; a real provider
runtime retest remains required. Duplicate/stale/cross-transaction callback rejection is delegated
to the SDK transaction state and covered locally by the runner's single write path and closed state
mapping, not by a live OS protocol test.

Deferred work remains unchanged: hosted Account/Device binding and scoped synchronization resume
only after provider retest reaches `authenticated`; production installer protocol registration,
intermediary HTTPS callback flow, dependency upgrades, persistent secure sessions, MCG-03 and Cycle
10 closure are outside this correction.
