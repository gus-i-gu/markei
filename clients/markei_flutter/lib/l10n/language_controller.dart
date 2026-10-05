import 'package:flutter/widgets.dart';

import '../application/language_preference.dart';

class LanguageController extends ChangeNotifier {
  LanguageController(this.repository);
  final LanguagePreferenceRepository repository;
  String? selection;
  String? error;
  bool busy = true;
  bool _disposed = false;
  Locale? get locale => switch (selection) {
    'pt_BR' => const Locale('pt', 'BR'),
    'es' => const Locale('es'),
    'en' => const Locale('en'),
    _ => null,
  };

  Future<void> load() async {
    try {
      final saved = await repository.readLanguage();
      if (_disposed) return;
      selection = const ['en', 'pt_BR', 'es'].contains(saved) ? saved : null;
    } catch (_) {
      error =
          'The saved language could not be read. Device language is being used.';
    }
    if (_disposed) return;
    busy = false;
    notifyListeners();
  }

  Future<void> select(String? language) async {
    if (busy || _disposed) return;
    if (language != null && !const ['en', 'pt_BR', 'es'].contains(language)) {
      return;
    }
    busy = true;
    error = null;
    notifyListeners();
    try {
      await repository.writeLanguage(language);
      if (_disposed) return;
      selection = language;
    } catch (_) {
      error =
          'Language could not be saved. Your previous preference is still active.';
    }
    if (_disposed) return;
    busy = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
