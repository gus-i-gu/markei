/// A device preference, independent of Account membership and synchronization.
abstract interface class LanguagePreferenceRepository {
  Future<String?> readLanguage();
  Future<void> writeLanguage(String? language);
}

final class MemoryLanguagePreferenceRepository
    implements LanguagePreferenceRepository {
  MemoryLanguagePreferenceRepository([this.language]);
  String? language;
  @override
  Future<String?> readLanguage() async => language;
  @override
  Future<void> writeLanguage(String? language) async =>
      this.language = language;
}
