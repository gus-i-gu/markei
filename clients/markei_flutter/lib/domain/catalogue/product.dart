import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../shared/ids.dart';
import '../shared/quantity.dart';

const int productNormalizationVersion = 1;
const String productUuidNamespace = 'markei.shared-beta.product.v1';

enum ProductMode { packaged, bulk }

final class Product {
  const Product({
    required this.id,
    required this.accountId,
    required this.normalizationVersion,
    required this.normalizedName,
    required this.normalizedBrand,
    required this.mode,
    required this.measurementKind,
    this.packageQuantity,
  });

  final ProductId id;
  final AccountId accountId;
  final int normalizationVersion;
  final String normalizedName;
  final String normalizedBrand;
  final ProductMode mode;
  final MeasurementKind measurementKind;
  final NormalizedQuantity? packageQuantity;

  String get identityKey {
    final base = [
      accountId.value,
      'v$normalizationVersion',
      normalizedName,
      normalizedBrand,
      mode.name.toUpperCase(),
    ];
    if (mode == ProductMode.bulk) {
      return base.join('|');
    }
    final quantity = packageQuantity;
    if (quantity == null) {
      throw StateError('Packaged products require package quantity.');
    }
    return [
      ...base,
      measurementKind.name.toUpperCase(),
      quantity.decimalText,
      quantity.unit.name.toUpperCase(),
    ].join('|');
  }

  Map<String, Object?> toJson() => {
    'id': id.value,
    'accountId': accountId.value,
    'normalizationVersion': normalizationVersion,
    'normalizedName': normalizedName,
    'normalizedBrand': normalizedBrand,
    'mode': mode.name.toUpperCase(),
    'measurementKind': measurementKind.name.toUpperCase(),
    'packageQuantity': packageQuantity?.toJson(),
    'identityKey': identityKey,
  };
}

final class ProductDraft {
  const ProductDraft({
    required this.name,
    required this.brand,
    required this.mode,
    required this.measurementKind,
    this.packageAmount,
    this.packageUnit,
  });

  final String name;
  final String brand;
  final ProductMode mode;
  final MeasurementKind measurementKind;
  final String? packageAmount;
  final String? packageUnit;
}

Product normalizeProductDraft({
  required AccountId accountId,
  required ProductDraft draft,
}) {
  final packageQuantity = switch (draft.mode) {
    ProductMode.packaged => normalizeDisplayQuantity(
      kind: draft.measurementKind,
      amount: draft.packageAmount ?? '',
      unit: draft.packageUnit ?? '',
    ),
    ProductMode.bulk => null,
  };
  final product = Product(
    id: const ProductId('pending'),
    accountId: accountId,
    normalizationVersion: productNormalizationVersion,
    normalizedName: normalizeIdentityText(draft.name),
    normalizedBrand: normalizeIdentityText(draft.brand),
    mode: draft.mode,
    measurementKind: draft.measurementKind,
    packageQuantity: packageQuantity,
  );
  return Product(
    id: deterministicProductId(product.identityKey),
    accountId: product.accountId,
    normalizationVersion: product.normalizationVersion,
    normalizedName: product.normalizedName,
    normalizedBrand: product.normalizedBrand,
    mode: product.mode,
    measurementKind: product.measurementKind,
    packageQuantity: product.packageQuantity,
  );
}

ProductId deterministicProductId(String identityKey) {
  final digest = sha256
      .convert(utf8.encode('$productUuidNamespace|$identityKey'))
      .bytes;
  final hex = digest
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join();
  return ProductId(
    '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-'
    '${hex.substring(16, 20)}-${hex.substring(20, 32)}',
  );
}

String normalizeIdentityText(String value) {
  final lower = value.trim().toLowerCase();
  return lower
      .replaceAll(RegExp(r'[^\w\s]+'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

bool isSimilarButNotExact(Product a, Product b) {
  if (a.identityKey == b.identityKey) {
    return false;
  }
  if (a.accountId.value != b.accountId.value || a.mode != b.mode) {
    return false;
  }
  return _editDistance(a.normalizedName, b.normalizedName) <= 2 ||
      a.normalizedName.contains(b.normalizedName) ||
      b.normalizedName.contains(a.normalizedName);
}

int _editDistance(String a, String b) {
  final rows = List.generate(
    a.length + 1,
    (i) =>
        List<int>.generate(b.length + 1, (j) => i == 0 ? j : (j == 0 ? i : 0)),
  );
  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      rows[i][j] = [
        rows[i - 1][j] + 1,
        rows[i][j - 1] + 1,
        rows[i - 1][j - 1] + cost,
      ].reduce((value, element) => value < element ? value : element);
    }
  }
  return rows[a.length][b.length];
}
