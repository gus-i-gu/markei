import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';

void main() {
  test('minimal analytics registry is versioned', () {
    final registry = minimalAnalyticsRegistry();
    final definition = registry.requireDefinition(
      'purchase.total_minor_units',
      1,
    );

    expect(definition.identifier, 'purchase.total_minor_units');
    expect(definition.version, 1);
  });
}
