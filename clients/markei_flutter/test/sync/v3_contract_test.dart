import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_schema/json_schema.dart';
import 'package:markei/domain/sync/canonical_json.dart';

void main() {
  test('v3 purchase fixture validates and matches canonical hash', () {
    final event = _load('purchase_registered.valid.json');
    final schema = JsonSchema.create(
      _loadSchema('purchase_registered.schema.json'),
    );

    final result = schema.validate(event, validateFormats: false);

    expect(result.isValid, isTrue, reason: result.errors.join('\n'));
    final content = Map<String, Object?>.from(event)..remove('contentHash');
    expect(event['contentHash'], canonicalUtf8Sha256(content));
  });

  test('v3 invalid protocol version is rejected', () {
    final event = _load('purchase_registered.invalid_version.json');
    final schema = JsonSchema.create(
      _loadSchema('purchase_registered.schema.json'),
    );

    expect(schema.validate(event, validateFormats: false).isValid, isFalse);
  });
}

Map<String, Object?> _load(String name) {
  final file = File('../../contracts/shared_beta/v3/fixtures/$name');
  return jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
}

Map<String, Object?> _loadSchema(String name) {
  final file = File('../../contracts/shared_beta/v3/$name');
  return jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
}
