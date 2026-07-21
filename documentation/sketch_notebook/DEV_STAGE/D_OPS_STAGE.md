# D_OPS_STAGE — Hosted Device Header Correction

> Authority marker: C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z
> Required ancestor: cee414ffd4501e86d2d221f8fe02876716510692
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Reconciled evidence

The preserved Windows retest produced a definite `failed/notApplied` response with protocol code
`device-enrollment-required`. The local retry retained the two immutable hosted events in canonical
sequence `1,2`. Sanitized Neon evidence remained at zero submissions, zero events, zero
acknowledgements and Device expectation `1`; therefore no server application or partial commit
occurred.

Provider/schema checks established:

- migrations `002` through `006` are recorded with the expected hosted checksums;
- one Device, enrollment, external identity and membership chain is active;
- `markei_runtime` can execute the hosted readiness and membership-authorization functions;
- Render's private `DATABASE_URL` uses the `markei_runtime` role;
- Render live and ready endpoints return success.

Source inspection identifies the concrete contract defect: hosted protected routes require
`x-markei-device-id`, while `HttpSyncTransport` does not send it. Enrollment/status uses a separate
transport and can therefore pass while Sync is rejected before the submission body is applied.

## Authorized correction

1. Require one active hosted server Device ID when constructing the production
   `HttpSyncTransport`.
2. Send `x-markei-device-id` on every protected Sync and recovery request made by that transport:
   upload, download, acknowledgement, recovery start/query/chunk/completion.
3. Wire the value from `activeBinding.serverDeviceId`; fail closed if production hosted Sync is
   composed without an active binding.
4. Add focused transport tests proving the header is present and stable on all protected methods.
5. Strengthen the native-closure hosted fixture so missing or wrong Device headers are rejected
   with `device-enrollment-required`; retain a failing regression before accepting the fix.
6. Preserve the existing failed Windows submission and immutable sequences `1,2`; do not add an
   automatic data rewrite or provider workaround.

Codex may adjust constructors and test fixtures directly affected by the new required argument.
Do not broaden into enrollment redesign, token diagnostics, migrations, UI work or logging of
identifiers.

## Validation

Run at minimum:

- Dart format on changed Dart files;
- focused `HttpSyncTransport` and native-closure tests;
- recovery/orchestration and real convergence tests, with lab-only cases guarded normally;
- `flutter analyze` and full `flutter test`;
- server format, lint, typecheck, tests and build if a server fixture/source changes;
- Windows release and Android debug builds;
- `git diff --check`, secret scan and changed-path review.

G/H/I must report exact changed paths, focused assertions, full counts, build results, deviations
and the final commit/tree metadata available at reporting time.

## Stop rules

Stop on dirty overlap, contradictory Device identities, required schema change, provider access,
secret exposure, inability to retain a failing missing-header regression, or unrelated test failure.
Do not access Neon/Auth0/Render, edit a human database, reenroll a Device, deploy, or perform another
provider Sync attempt.

Success terminal:

~~~text
HOSTED_DEVICE_HEADER_ALL_PROTECTED_ROUTES=true
HOSTED_FIXTURE_REJECTS_MISSING_OR_WRONG_DEVICE=true
WINDOWS_PROVIDER_RETEST_PENDING
C10_MCG02_HOSTED_DEVICE_HEADER_CORRECTED
~~~
