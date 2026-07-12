typedef AnalyticCalculation<T> = T Function();

final class AnalyticDefinition<T> {
  const AnalyticDefinition({
    required this.identifier,
    required this.version,
    required this.calculate,
  });

  final String identifier;
  final int version;
  final AnalyticCalculation<T> calculate;
}

final class AnalyticsRegistry {
  AnalyticsRegistry(Iterable<AnalyticDefinition<Object?>> definitions)
    : _definitions = {
        for (final definition in definitions)
          '${definition.identifier}@${definition.version}': definition,
      };

  final Map<String, AnalyticDefinition<Object?>> _definitions;

  AnalyticDefinition<Object?> requireDefinition(
    String identifier,
    int version,
  ) {
    final definition = _definitions['$identifier@$version'];
    if (definition == null) {
      throw ArgumentError('Unknown analytic definition $identifier@$version.');
    }
    return definition;
  }
}

AnalyticsRegistry minimalAnalyticsRegistry() => AnalyticsRegistry([
  AnalyticDefinition<int>(
    identifier: 'purchase.total_minor_units',
    version: 1,
    calculate: () => 0,
  ),
]);
