import 'export_destination.dart';

/// Explicit, user-triggered sharing only. This grants no Marc Account access.
final class ContentShareRequest {
  const ContentShareRequest({required this.title, this.text, this.file});
  final String title;
  final String? text;
  final ExportDestinationRequest? file;
}

enum ContentShareResult { handedOff, dismissed, unconfirmed, failed, busy }

abstract interface class ContentSharingPort {
  Future<ContentShareResult> share(ContentShareRequest request);
}

String contentShareMessage(ContentShareResult result) => switch (result) {
  ContentShareResult.handedOff =>
    'Content handed to the selected app. Delivery is not confirmed by Marc.',
  ContentShareResult.dismissed => 'Sharing cancelled. Your data is unchanged.',
  ContentShareResult.unconfirmed =>
    'Sharing outcome could not be confirmed. You can try again or export the file.',
  ContentShareResult.failed =>
    'Sharing could not be opened. Your data is unchanged. Try exporting instead.',
  ContentShareResult.busy => 'Another sharing action is already open.',
};
