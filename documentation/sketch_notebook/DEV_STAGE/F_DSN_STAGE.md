# F_DSN_STAGE — Windows Runtime Closure Design

> Authority marker: C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z
> Status: **ACTIVE DESIGN AUTHORITY**

## Selected boundary

~~~text
pinned auth0_flutter/cpprestsdk targets
-> configuration-aware CMake runtime dependency discovery
-> post-build runner deployment
-> self-contained Debug or Release directory
-> direct launch and protocol callback launch
~~~

The executable directory, not an interactive shell PATH, owns the deployable runtime closure. CMake
must derive dependencies from imported/linked targets or an equivalent reproducible target-level
mechanism. Debug and Release artifacts remain configuration-correct.

## Invariants

- no absolute developer-machine path enters tracked source or produced authority;
- no DLL or vcpkg checkout is committed;
- Release never packages debug-suffixed libraries;
- missing runtime dependencies fail during build/validation rather than after browser callback;
- callback and token handling remain unchanged and secret-free;
- generated artifacts remain outside Git and are reproducible after `flutter clean`;
- the solution remains compatible with the repository-pinned dependency versions.

The earlier hosted Account/Device binding design remains deferred until a clean provider retest
passes. Rollback removes only runtime deployment changes and retains the accepted authentication
correction and all local facts.
