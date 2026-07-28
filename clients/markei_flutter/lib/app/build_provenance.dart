final class BuildProvenance {
  factory BuildProvenance.fromRaw(String value) {
    final normalized = value.trim();
    if (RegExp(r'^[a-f0-9]{7,12}$').hasMatch(normalized)) {
      return BuildProvenance._(normalized);
    }
    return unavailable;
  }

  const BuildProvenance._(this.sourceFingerprint);

  static final current = BuildProvenance.fromRaw(
    const String.fromEnvironment('MARKEI_BUILD_PROVENANCE'),
  );

  static const unavailable = BuildProvenance._('unavailable');

  final String sourceFingerprint;

  bool get isAvailable => sourceFingerprint != 'unavailable';

  String get displayLabel => isAvailable
      ? 'Build provenance #$sourceFingerprint'
      : 'Build provenance unavailable';
}
