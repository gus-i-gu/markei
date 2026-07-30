# F_DSN_STAGE — Architecture for C10-GCM03-S09-R06-CR01

## Envelope

Sequence: FLX-ORD-01

Role: Main architecture constraint

Round or unit: C10-GCM03-S09-R06-CR01

Branch: grm-guarded-provisioning-20260727

Baseline / inspected HEAD: e5168f6d2063b359ba773c107b73420bb29d43e8

Authority: D controls execution; E controls evidence; F controls ownership.

## 1. Architectural objective

Add one bounded fail-closed preparation gate to the existing Windows build procedure:

~~~text
operator-owned process state
→ relevant-owner preflight
→ Flutter cleanup request
→ independent generated-state postcondition
→ bounded exact-path cleanup when safe
→ second absence proof
→ dependency/plugin regeneration
→ regeneration coherence proof
→ existing R06 validation/build/identity chain
~~~

This is procedure architecture. It does not change application architecture or Sync architecture.

## 2. Root responsibility

The defect belongs to GS-FLUTTER-WIN orchestration because the procedure advanced from cleanup into pub get without proving the filesystem state required by pub get.

Flutter remains responsible for ordinary cleanup and package/plugin generation. CR01 does not replace Flutter's generator. It wraps the transition with explicit preconditions and postconditions.

The auth0_flutter symlink is an observed collision location, not an architectural root cause assigned to Auth0 or the plugin dependency.

## 3. Responsibility map

| Responsibility | Owner | Constraint |
|---|---|---|
| Operator closes active app/build/debug activity | human operator | procedure gives bounded guidance |
| Relevant owner/process inspection | GS-FLUTTER-WIN | observe and stop; never terminate |
| Ordinary generated-state cleanup | flutter clean | exit code is necessary, not sufficient |
| Cleanup postcondition verification | GS-FLUTTER-WIN | exact enumerated generated targets |
| Safe residual generated-target removal | GS-FLUTTER-WIN | literal paths, contained client root, no active owner |
| Package/plugin regeneration | flutter pub get | only after cleanup gate passes |
| Regeneration coherence verification | GS-FLUTTER-WIN | package config plus Windows plugin state |
| R06 source identity resolution | existing shared helper | unchanged |
| Analysis/tests/build | existing Flutter commands | unchanged after gate |
| Artifact identity | existing GS-FLUTTER-WIN tail | unchanged |
| Callback registration and launch | existing GS-FLUTTER-WIN tail | exact built executable |
| Preserved data and live actions | installed application/human authority | untouched by Codex |
| Sync and diagnostics | existing R02–R05 owners | frozen |
| R07 Settings/Audit design | later Main-approved unit | held |

## 4. State machine

Required preparation states:

~~~text
preflight-pending
→ blocked-active-owner
or
→ cleanup-requested
→ blocked-clean-command
or
→ cleanup-postcondition-check
→ bounded-residual-removal
→ blocked-residual-or-reappeared
or
→ clean-state-proved
→ pub-get-running
→ blocked-pub-get
or
→ regeneration-check
→ blocked-regeneration-incoherent
or
→ windows-build-preparation-ready
~~~

No transition may skip from cleanup-requested directly to pub-get-running. The clean-state-proved transition requires filesystem evidence independent of flutter clean's exit code.

## 5. Containment invariant

Every removable path must satisfy all of:

~~~text
TARGET_IS_EXPLICITLY_ENUMERATED
TARGET_IS_FLUTTER_GENERATED
TARGET_RESOLVES_UNDER_CLIENT_ROOT
TARGET_IS_NOT_CLIENT_ROOT
TARGET_IS_NOT_REPOSITORY_ROOT
NO_RELEVANT_OWNER_IS_ACTIVE
REMOVAL_RESULT_IS_VERIFIED
~~~

A failed invariant stops the procedure. It must never be converted into a wildcard, broad recursive deletion, cache-wide purge, or process kill.

The Flutter client root, repository root, source directories, pubspec files, lockfile, application data, databases, coordinates, and user files are immutable boundaries.

## 6. Process-boundary law

The procedure may inspect a bounded process set and report names/IDs sufficient for operator action. It must not:

- call Stop-Process, taskkill, kill, or equivalent;
- infer permission to close VS Code or terminals;
- terminate Markei automatically;
- expose full command lines, environment variables, tokens, local coordinates, or unrelated processes;
- treat every Dart analysis process as automatically safe to terminate.

If it cannot distinguish a relevant owner safely, it stops and delegates closure to the operator.

## 7. Regeneration invariant

After flutter pub get:

~~~text
package configuration exists and is readable
AND
Windows ephemeral/plugin generation exists in the expected shape
AND
auth0_flutter has one coherent generated plugin target
AND
no stale-collision condition is observed
~~~

This proof establishes only dependency-generation readiness. It does not validate Auth0 login, callback behavior, hosted service availability, or Sync.

## 8. R06 identity preservation

The existing architecture remains:

~~~text
clean committed Git HEAD/tree
→ shared deterministic source-identity helper
→ MARKEI_SOURCE_REVISION / MARKEI_SOURCE_TREE_SHA256
→ immutable BuildProvenance
→ boot transport
→ Closure presentation
~~~

CR01 must not create another identity helper, rename definitions, alter BuildProvenance, or change platform semantics.

Because documentation/G_SCRIPTS.md participates in the source-tree digest, the CR01 implementation commit becomes the next candidate identity. A human rerun must rebuild from that exact pushed HEAD; old e5168f6 artifacts remain historical evidence only.

## 9. Existing execution tail is frozen

Once windows-build-preparation-ready is reached, preserve the R06 tail:

~~~text
flutter analyze
→ flutter test
→ flutter build windows --release with existing definitions
→ exact markei.exe existence
→ byte size and SHA-256
→ callback registration for exact executable
→ exact executable launch
→ visible identity instruction
~~~

CR01 may add bounded readiness output but must not reorder or weaken these ownership relationships.

## 10. Frozen boundaries

CR01 does not modify:

- application source, navigation, Closure UI, Settings, Audit, MKS/ERR, or diagnostic projection;
- Product, purchase, catalogue, Sync, cursor, acknowledgement, or operation semantics;
- SQLite schema/state, hosted API, protocol, Render, Neon, Auth0 configuration, enrollment, or provider data;
- dependencies, pubspec.lock, native plugin source, CMake, vcpkg, or cpprestsdk;
- Android or Windows Debug procedures;
- methodology, permanent domain memory, J, A/B/C, or R07 design.

## 11. Completion boundary

CR01 completes when:

- GS-FLUTTER-WIN has an observable non-terminating process preflight;
- cleanup success is proved by exact postconditions;
- residual generated state can be removed only within the containment invariant;
- pub get is gated by clean-state proof;
- package/plugin regeneration is checked coherently;
- extraction and PowerShell parsing pass;
- the R06 identity/build tail is preserved;
- G/H/I report the bounded result;
- one fast-forward implementation commit is published.

CR01 does not complete the preserved-machine build. That result belongs to the user's corrected GS-FLUTTER-WIN rerun.

## 12. Release architecture

~~~text
CR01 implementation and focused validation
→ Main reconciliation
→ corrected GS-FLUTTER-WIN human rerun
→ Windows artifact and visible identity
→ Android artifact and visible identity if still pending
→ freeze exact candidate
→ separately authorized serialized Sync assay
→ activate R07 only if the assay yields a real attribution ambiguity
~~~

No live Sync authority exists inside CR01.
