import '../domain/shared/ids.dart';

/// Explicit access to this Account's locally stored data, without contacting a
/// provider. The export is an access report, not a database backup/import file.
abstract interface class UserDataAccessRepository {
  Future<UserDataInventory> inventory(AccountId accountId);
  Future<UserDataExport> exportAccountData(AccountId accountId);
  Future<LocalDiagnosticsClearResult> clearLocalDiagnostics(
    AccountId accountId,
  );
}

final class UserDataInventory {
  UserDataInventory({required this.accountId, required Map<String, int> counts})
    : counts = Map.unmodifiable(counts);

  final AccountId accountId;
  final Map<String, int> counts;
  int get totalRecords =>
      counts.values.fold(0, (total, count) => total + count);
  int count(String dataset) => counts[dataset] ?? 0;
}

final class UserDataExport {
  UserDataExport({required List<int> jsonBytes, required this.inventory})
    : jsonBytes = List.unmodifiable(jsonBytes);

  final List<int> jsonBytes;
  final UserDataInventory inventory;
}

final class LocalDiagnosticsClearResult {
  const LocalDiagnosticsClearResult({
    required this.attemptsRemoved,
    required this.diagnosticEventsRemoved,
  });

  final int attemptsRemoved;
  final int diagnosticEventsRemoved;
}
