import '../domain/analytics/analytics_models.dart';
import 'marc_messages.dart';

String localizedAnalyticsInterpretation(
  AnalyticsRecord record,
  MarcMessages messages,
) {
  if (messages.language == 'en') return record.interpretation;
  // Translate known developer labels; preserve the frozen interpretation's
  // counts and grouping rather than recalculating or inferring new claims.
  String labels(String text) =>
      text.split(', ').map(messages.display).join(', ');
  final grouped = RegExp(
    r'^(.+?) (.+?) grouped by (.+?)\. Calculated from (\d+) contained items across (\d+) group\(s\)\.(?: (\d+) incompatible or unavailable values are listed in Table\.)?$',
  ).firstMatch(record.interpretation);
  if (grouped != null) {
    final base = messages.message(
      '{p0} {p1} grouped by {p2}. Calculated from {p3} contained items across {p4} group(s).',
      [
        messages.display(grouped[1]!),
        labels(grouped[2]!),
        messages.display(grouped[3]!),
        grouped[4],
        grouped[5],
      ],
    );
    return grouped[6] == null
        ? base
        : messages.message(
            '{p0} {p1} incompatible or unavailable values are listed in Table.',
            [base, grouped[6]],
          );
  }
  final aggregate = RegExp(
    r'^(.+?) of (.+?)\. Based on (\d+) of (\d+) evidence rows\.$',
  ).firstMatch(record.interpretation);
  if (aggregate != null) {
    return messages
        .message('{p0} of {p1}. Based on {p2} of {p3} evidence rows.', [
          messages.display(aggregate[1]!),
          labels(aggregate[2]!),
          aggregate[3],
          aggregate[4],
        ]);
  }
  return messages.display(record.interpretation);
}
