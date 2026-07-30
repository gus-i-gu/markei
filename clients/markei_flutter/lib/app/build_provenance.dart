final class BuildProvenance {
  factory BuildProvenance.fromRaw({
    required String sourceRevision,
    required String sourceTreeSha256,
  }) {
    final revision = sourceRevision.trim();
    final treeSha256 = sourceTreeSha256.trim();
    if (_fullRevisionPattern.hasMatch(revision) &&
        _sourceTreeSha256Pattern.hasMatch(treeSha256)) {
      return BuildProvenance._(
        fullSourceRevision: revision,
        sourceTreeSha256: treeSha256,
      );
    }
    return unavailable;
  }

  const BuildProvenance._({
    required this.fullSourceRevision,
    required this.sourceTreeSha256,
  });

  static final current = BuildProvenance.fromRaw(
    sourceRevision: const String.fromEnvironment('MARKEI_SOURCE_REVISION'),
    sourceTreeSha256: const String.fromEnvironment('MARKEI_SOURCE_TREE_SHA256'),
  );

  static const unavailable = BuildProvenance._(
    fullSourceRevision: '',
    sourceTreeSha256: '',
  );

  static final _fullRevisionPattern = RegExp(r'^[a-f0-9]{40}$');
  static final _sourceTreeSha256Pattern = RegExp(r'^[a-f0-9]{64}$');

  final String fullSourceRevision;
  final String sourceTreeSha256;

  bool get isAvailable =>
      fullSourceRevision.isNotEmpty && sourceTreeSha256.isNotEmpty;

  String get displayRevision =>
      isAvailable ? fullSourceRevision.substring(0, 12) : '';

  String get sourceRevisionLabel => isAvailable
      ? 'Source revision #$displayRevision'
      : 'Source identity unavailable';

  String get sourceTreeSha256Label => isAvailable
      ? 'Source tree SHA-256 $sourceTreeSha256'
      : 'Source identity unavailable';
}
