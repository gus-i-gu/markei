import 'dart:convert';
import 'dart:io';

Map<String, Object?> loadFixture(String name) {
  final file = File('../../contracts/shared_beta/v1/$name');
  return jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
}
