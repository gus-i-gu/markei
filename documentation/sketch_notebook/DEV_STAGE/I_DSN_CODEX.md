# I_DSN_CODEX - Native Closure R1 Design Evidence

- Authority marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
- Baseline SHA: e59d919ecb776597b13615137cd23413dae42c36
- Final commit SHA: reported after commit by Codex terminal response, not self-embedded.
- Evidence environment: Flutter 3.44.6, Dart 3.12.2, Auth0 Flutter 2.4.0 retained, loopback HTTP/file-backed Drift proof, Android debug build, Windows symlink host exclusion.
- Result classification: native closure correction locally executable; provider proof pending.

## Dependency Direction

The corrected path is:

`NativeClosurePage -> NativeAuthClosureRunner -> ExternalAuthenticationSession / HostedEnrollmentCoordinator / HostedSyncCoordinator`.

`HostedSyncCoordinator` composes existing synchronization use cases:

`UploadPendingEvents -> SyncTransport`, `DownloadAndApplyEvents -> SyncTransport + RemoteEventApplier`, and `AcknowledgeAppliedCursor -> SyncTransport + RemoteEventApplier`.

Infrastructure remains below application ports: `HttpSyncTransport`, `HttpDeviceEnrollmentTransport`, Drift repositories and `NativeAuth0Authentication`. Auth0 SDK types remain infrastructure-only. Lab authentication remains test/loopback-only and is not selected by production composition.

## Closure Surface

The development surface is a single neutral page added to navigation only when `MARKEI_NATIVE_CLOSURE_SURFACE` is true and `NativeAuthConfiguration` is ready. The flag defaults false. With the flag off, the existing product navigation and local registration behavior remain unchanged.

The page can invoke status, sign in, enroll/query Device, real hosted sync and logout. It displays state strings only and no credentials, provider identifiers, Account/Device identifiers, connection details or synchronization payloads.

## Stable Identity

`StableDeviceEnrollmentCommandFactory` reads `HostedIdentityRepository` before constructing enrollment commands. Existing installation id and unresolved enrollment request id are reused across retries and Drift reopen. Fresh ids are generated only when no durable hosted state exists. There is no automatic external identity, Account membership or Device provisioning.

## Sync Correction

`hostedSyncProbe()` no longer calls enrollment replay. It delegates to `HostedSyncCoordinator`, which checks authentication, evaluates enrolled Device guard state, uploads pending outbox entries, downloads after the committed cursor, applies remote events atomically through Drift, then acknowledges only after local cursor application.

Production deviation for R1: none beyond the accepted native-composition baseline. Migrations 001-006, server authorization, Drift schema/reset behavior, Auth0/Neon/Render resources, dependency versions, lockfiles and permanent methodology/domain memory were unchanged.

Residual boundary: Windows release binary remains host-excluded until Developer Mode or symlink support is available. No provider login, provider mutation, deployment, permanent promotion, Cycle 10 closure, MCG-03 or MCG-04 was performed.
