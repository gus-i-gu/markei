import '../shared/ids.dart';

final class Store {
  const Store({
    required this.id,
    required this.accountId,
    required this.displayName,
  });

  final StoreId id;
  final AccountId accountId;
  final String displayName;

  Map<String, Object?> toJson() => {
    'id': id.value,
    'accountId': accountId.value,
    'displayName': displayName,
  };
}
