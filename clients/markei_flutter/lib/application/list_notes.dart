import '../domain/shared/ids.dart';

const listNoteEventType = 'product.list-note.recorded';

/// Revisions replace only edits observed by their author. Concurrent edits stay
/// visible until the user combines them, independently of device clocks.
final class ListNoteRevision {
  ListNoteRevision({
    required this.id,
    required this.productId,
    required this.note,
    required Iterable<String> tags,
    required Iterable<String> replaces,
  }) : tags = List.unmodifiable(tags),
       replaces = Set.unmodifiable(replaces);
  final String id;
  final String productId;
  final String note;
  final List<String> tags;
  final Set<String> replaces;
}

List<ListNoteRevision> activeListNotes(Iterable<ListNoteRevision> revisions) {
  final all = revisions.toList();
  final replaced = all.expand((revision) => revision.replaces).toSet();
  return List.unmodifiable(
    all.where((revision) => !replaced.contains(revision.id)).toList()
      ..sort((a, b) => a.id.compareTo(b.id)),
  );
}

List<String> normalizeListTags(Iterable<String> values) {
  final tags = values
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toSet()
      .toList();
  if (tags.length > 20 || tags.any((tag) => tag.length > 64)) {
    throw const FormatException(
      'Use up to 20 tags, each no longer than 64 characters.',
    );
  }
  return List.unmodifiable(tags);
}

abstract interface class ListNotesRepository {
  Future<Map<String, List<ListNoteRevision>>> read(AccountId accountId);
  Future<void> save({
    required AccountId accountId,
    required DeviceId deviceId,
    required ProductId productId,
    required String note,
    required List<String> tags,
    required Set<String> observedRevisionIds,
  });
}
