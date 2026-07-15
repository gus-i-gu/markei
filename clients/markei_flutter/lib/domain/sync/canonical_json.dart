import 'dart:convert';

import 'package:crypto/crypto.dart';

String canonicalJson(Object? value) => jsonEncode(_canonicalize(value));

String canonicalUtf8Sha256(Object? value) =>
    sha256.convert(utf8.encode(canonicalJson(value))).toString();

Object? _canonicalize(Object? value) {
  if (value is Map) {
    final entries = value.entries.toList()
      ..sort((a, b) => a.key.toString().compareTo(b.key.toString()));
    return {
      for (final entry in entries)
        entry.key.toString(): _canonicalize(entry.value),
    };
  }
  if (value is Iterable) {
    return value.map(_canonicalize).toList(growable: false);
  }
  return value;
}
