import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../application/language_preference.dart';

final class FileLanguagePreferenceRepository
    implements LanguagePreferenceRepository {
  FileLanguagePreferenceRepository({Future<Directory> Function()? directory})
    : _directory = directory ?? getApplicationSupportDirectory;

  final Future<Directory> Function() _directory;

  Future<File> _file() async =>
      File(path.join((await _directory()).path, 'marc-language.json'));

  @override
  Future<String?> readLanguage() async {
    final file = await _file();
    if (!await file.exists()) return null;
    final value = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    final language = value['language'];
    if (language != null && !const ['en', 'pt_BR', 'es'].contains(language)) {
      throw const FormatException('Unsupported saved language');
    }
    return language as String?;
  }

  @override
  Future<void> writeLanguage(String? language) async {
    if (language != null && !const ['en', 'pt_BR', 'es'].contains(language)) {
      throw ArgumentError.value(language, 'language');
    }
    final file = await _file();
    await file.parent.create(recursive: true);
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(
      jsonEncode({'language': language}),
      flush: true,
    );
    await temporary.rename(file.path);
  }
}
