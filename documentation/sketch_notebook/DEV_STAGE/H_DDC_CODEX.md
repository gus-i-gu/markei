# H_DDC_CODEX - Windows Authentication State Evidence

- Authority marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
- Baseline SHA after fast-forward: fc4af17c766f39715fe909b9fbda587e1bb7b881
- Final commit SHA: reported by Codex terminal response after commit publication.
- Result classification: local callback/credential semantics corrected; provider retest required.

## States Materialized

- `callback-not-received`
- `callback-state-rejected`
- `authorization-code-exchange-rejected`
- `access-token-missing`
- `id-token-missing`
- `token-expired`
- `token-confusion-rejected`
- `provider-unavailable`
- `authentication-rejected-unknown`
- `authenticated`

Cancellation remains `sign-in-cancelled`. Provider outage remains distinct from rejected
authorization. Successful Auth0 tenant login is not represented as `authenticated` unless usable SDK
credentials exist.

## Semantic Tests

- Provider exception text maps through a closed diagnostic allowlist.
- Unsafe exception text, callback-like text and secret-like text map only to
  `authentication-rejected-unknown`.
- Valid SDK credentials become `authenticated`.
- Missing access token, missing ID token, expired credentials and access/ID token confusion fail
  closed.
- Closure runner reports exact neutral authentication diagnostics.
- Closure UI surface still reports bounded state strings.
- Enrollment success alone still cannot produce sync success.

## Privacy and Logging Evidence

The correction does not expose tokens, authorization codes, PKCE material, state, nonce, email,
subject, Account IDs, Device IDs, full callback URLs or provider credentials. The Windows runner
contract test asserts no callback data logging through standard output or debug output calls.

## Unsupported Claims Absent

Reports and UI wording do not claim Device enrollment, hosted synchronization, MCG-02 closure,
Cycle 10 closure, provider mutation or MCG-03 readiness. The only terminal claim is local Windows
auth callback correction with provider retest required.
