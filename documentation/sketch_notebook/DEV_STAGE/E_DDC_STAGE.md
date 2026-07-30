# E_DDC_STAGE — Evidence contract for C10-GCM03-S09-R06-CR01

## Envelope

Sequence: FLX-ORD-01

Role: Main evidence constraint

Round or unit: C10-GCM03-S09-R06-CR01

Branch: grm-guarded-provisioning-20260727

Baseline / inspected HEAD: e5168f6d2063b359ba773c107b73420bb29d43e8

Authority: D is executable; E limits conclusions; F owns architecture.

Writable surfaces: only those named by D.

Evidence boundary: Windows generated-state preparation and procedure readiness only.

## 1. Question being answered

CR01 answers:

> Does GS-FLUTTER-WIN refuse to continue into dependency regeneration and build until bounded Flutter-generated state is demonstrably clean and coherently regenerated?

CR01 does not answer:

> Does Windows now build and run on the user's preserved client?

It also does not answer whether inter-device Sync converges.

## 2. Accepted incident interpretation

The observed sequence is:

~~~text
incomplete cleanup of .dart_tool
→ stale or recreated generated state remained
→ flutter pub get collided with auth0_flutter generated plugin state
→ PathExistsException / errno 183
→ compilation did not begin
~~~

Maximum supported classification:

~~~text
WINDOWS_BUILD_FAILURE_CLASS=GENERATED_STATE_OR_LOCK_PRECONDITION
R06_SOURCE_IDENTITY_FAILURE=NOT_ESTABLISHED
DEPENDENCY_INCOMPATIBILITY=NOT_ESTABLISHED
CMAKE_FAILURE=NOT_ESTABLISHED
AUTH0_CONFIGURATION_FAILURE=NOT_ESTABLISHED
SYNC_RUNTIME_FAILURE=NOT_ESTABLISHED
~~~

Chrome availability has no evidentiary relation to this Windows desktop failure.

## 3. Evidence required from implementation

Source inspection must establish:

- no automatic process termination;
- only exact Flutter-generated targets under the Flutter client root are eligible for removal;
- flutter clean success is followed by independent filesystem postcondition checks;
- flutter pub get cannot run while a required generated target remains;
- regeneration is checked for package configuration and coherent Windows plugin state;
- a failure stops before analyze/build;
- the existing R06 source revision and source-tree digest transport remains unchanged;
- executable hashing, callback registration, and exact-executable launch remain unchanged;
- no Sync, database, provider, dependency, authentication, or preserved-state path changed.

PowerShell extraction/parse evidence may establish that the canonical Markdown block remains executable through the existing dispatcher.

A disposable clean-checkout exercise may establish only that the corrected path can pass on that host. It cannot establish resolution of the user's original lock owner unless the preserved machine later reruns the procedure.

## 4. Process and cleanup evidence ceilings

| Evidence | Maximum conclusion |
|---|---|
| Process preflight source inspection | relevant owners are checked and never terminated automatically |
| Exact-path containment guard | cleanup scope is bounded to generated client state |
| Post-clean absence assertions | pub get is gated by verified cleanup |
| Regeneration assertions | expected package/plugin generated state exists coherently after pub get |
| PowerShell parse/extraction | documented block is syntactically consumable |
| Disposable clean-checkout run | procedure works on that disposable host |
| User rerun with no collision | original Windows preparation blocker is cleared for that run |
| Windows artifact path/size/hash | exact new executable bytes were built |
| Visible Closure identity | running Windows client reports the embedded R06 identity |
| No live Sync | no convergence conclusion |

Do not claim a lock was fixed merely because static validation passed. Do not claim the plugin or dependency was defective merely because its stale symlink was the collision point.

## 5. Safety interpretation

Automatic termination of Markei, Flutter, Dart, VS Code, or another user process is prohibited. The procedure may identify a bounded blocker and stop with operator guidance.

Generated-state deletion is acceptable only when all of the following are true:

- the target is explicitly enumerated;
- it resolves beneath clients/markei_flutter;
- it is known Flutter-generated state;
- no relevant owner is active;
- the procedure verifies deletion before continuing.

Broad cache purges, dependency upgrades, source deletion, user-data deletion, and cleanup outside the Flutter client are not acceptable evidence-generating actions.

## 6. R06 preservation rule

CR01 must not alter the R06 identity meaning:

~~~text
full Git revision = canonical committed source revision
12-character revision = display abbreviation
source-tree SHA-256 = common cross-platform source identity
APK/EXE SHA-256 = platform-specific artifact identity
~~~

Because CR01 changes documentation/G_SCRIPTS.md, the CR01 implementation commit will have a new source revision/tree digest. The later human rebuild must use the identity resolved from that exact pushed CR01 implementation HEAD. Values from e5168f6 and its pre-commit artifacts must not be presented as the new frozen candidate identity.

## 7. Validation economy

Sufficient CR01 evidence is:

~~~text
exact changed-path inspection
+ canonical procedure extraction
+ PowerShell parse validation
+ bounded fail-closed source assertions
+ optional disposable-host clean-path exercise
+ G/H/I report replacement
~~~

Insufficient substitutions include:

- rerunning every Flutter, GRIMOIRE, SQLite, Neon, Render, Auth0, or provider check;
- deleting broad caches until the command happens to pass;
- terminating processes automatically;
- changing dependency versions;
- running Android again;
- presenting the old e5168f6 artifact hashes as CR01 artifacts;
- treating a successful disposable build as preserved-client launch evidence.

## 8. Human release terminal

After CR01 implementation is reconciled, the user may rerun only GS-FLUTTER-WIN.

Release to the next provenance step requires:

~~~text
GS_FLUTTER_WIN_CLEANUP_PREFLIGHT=PASS
GS_FLUTTER_WIN_PUB_GET=PASS
GS_FLUTTER_WIN_BUILD=PASS
WINDOWS_ARTIFACT_IDENTITY=RECORDED
WINDOWS_VISIBLE_SOURCE_IDENTITY=PASS
PRESERVED_WINDOWS_DATA=VISIBLE
AUTOMATIC_SYNC_OBSERVED=NO
~~~

Any remaining cleanup collision, missing preserved data, unexpected automatic operation, or identity mismatch stops progression.

## 9. PRC-01 non-promotion boundary

CR01 cannot promote:

- practical Sync success;
- Product reconciliation;
- cursor advancement;
- acknowledgement;
- two-device convergence;
- no-op replay;
- GCM03 closure;
- MVP Sync acceptance;
- R07 implementation necessity.

R07 remains held. It becomes an implementation route only after a separately authorized controlled Sync produces a real causal-attribution failure or another Main-approved activation condition.
