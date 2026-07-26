import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/sync/sync_diagnostic_registry.g.dart';

void main() {
  test('generated sync diagnostic registry exposes v1 and 159 codes', () {
    expect(syncDiagnosticRegistryVersion, 1);
    expect(syncDiagnosticRegistry, hasLength(159));
    expect(syncDiagnosticRegistry.keys.toSet(), hasLength(159));
    expect(syncDiagnosticByCode('MKS-UI-001')?.defaultOutcome, 'blocked');
    expect(
      syncDiagnosticByCode('MKS-QUE-010')?.safeAction,
      'stop and preserve local evidence',
    );
  });
}
