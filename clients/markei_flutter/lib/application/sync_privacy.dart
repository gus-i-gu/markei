/// A Device-local choice covering Marc provider actions, not explicit Auth0
/// sign-in or sign-out. Pausing does not erase records or cancel a request that
/// has already started; its Future completes after that operation settles.
abstract interface class SyncPrivacyPolicy {
  Future<bool> readPaused();

  Future<void> setPaused(bool paused);

  /// Serializes provider operations with preference changes. A pending pause
  /// rejects queued/new actions before their callbacks or local leases run.
  Future<T> runWhenAllowed<T>(
    Future<T> Function() action,
    T Function() blocked,
  );
}

/// Contains no path, underlying exception, or user data. Failure to establish a
/// trustworthy preference must never permit a provider request.
final class SyncPrivacyChoiceUnavailable implements Exception {
  const SyncPrivacyChoiceUnavailable();

  @override
  String toString() => 'sync-choice-unavailable';
}
