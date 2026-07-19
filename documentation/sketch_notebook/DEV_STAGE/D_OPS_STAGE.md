# D_OPS_STAGE — Windows Runtime Packaging Closure Step 1

> Authority marker: C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z
> Required ancestor: 1922ffc38b9a7b24cf49143e9fae726f9f8349db
> Status: **ACTIVE BOUNDED CODEX AUTHORITY**

## Accepted evidence

The Windows release build, Auth0 signup/login, callback consumption, credential acceptance,
authenticated status, logout and re-sign-in passed. The callback-launched process failed only when
`cpprest_2_10.dll` was absent from the runner directory. Manually copying vcpkg release DLLs beside
`markei.exe` made the complete authentication sequence pass.

## Objective

Make Debug and Release runner outputs self-contained for the runtime libraries actually required by
the pinned `auth0_flutter` Windows dependency. A clean build must launch directly and through the
`auth0flutter` protocol without PATH modification or manual DLL copying.

## Required implementation

1. Inspect the existing Flutter runner and plugin CMake targets and implement configuration-aware
   post-build/runtime deployment using CMake target metadata where possible.
2. Package only resolved runtime dependencies needed by the executable/plugin closure. Do not
   hard-code one developer username, drive, vcpkg root, build configuration or DLL filename.
3. Select Debug DLLs for Debug and Release DLLs for Release; never mix CRT configurations.
4. Preserve the callback, credential, token-lifecycle and single-instance corrections at `1922ffc`.
5. Fail the build clearly when a required runtime dependency cannot be resolved; do not defer the
   failure to application or callback launch.
6. Keep binaries and generated build output untracked. Do not vendor vcpkg, DLLs or provider data.

## Decisive validation

- start from `flutter clean` and a PowerShell process whose PATH contains no vcpkg `bin` directory;
- run `flutter pub get` and build Windows Debug and Release with the required non-secret defines;
- prove each output contains its required runtime closure and contains no debug DLL in Release;
- launch each executable directly and verify it remains alive with a responsive window;
- invoke a sanitized `auth0flutter://callback` negative fixture and prove the secondary process
  launches without a missing-DLL dialog while malformed/state-invalid input fails closed;
- run focused callback/packaging tests, full Flutter tests, analysis and formatting;
- run `git diff --check`, changed-path inventory and tracked/staged secret and binary scans.

Real provider login remains a human retest. Codex must record the accepted sanitized human result
and must not request, read or store Auth0 credentials, tokens, callback URLs or user identity.

## Boundaries

No dependency upgrade, provider mutation, enrollment, synchronization, migration, Drift/PostgreSQL
schema change, server authorization change, product UI redesign, permanent documentation, MCG-03
or MCG-04 work is authorized. Replace only G/H/I after implementation and publish one bounded unit.

Success terminal:

~~~text
MCG-02_WINDOWS_RUNTIME_PACKAGING_CORRECTED
MCG-02_CLEAN_PROVIDER_RETEST_REQUIRED
~~~

Otherwise report `MCG-02_WINDOWS_RUNTIME_PACKAGING_PARTIAL` with the exact blocker.
