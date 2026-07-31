final class ExportDestinationRequest {
  ExportDestinationRequest({
    required this.baseNameCue,
    required this.extension,
    required this.mediaType,
    required List<int> bytes,
  }) : bytes = List.unmodifiable(bytes);

  final String baseNameCue;
  final String extension;
  final String mediaType;
  final List<int> bytes;
}

enum ExportDestinationFailureKind {
  unsupportedPlatform,
  destinationUnavailable,
  permissionDenied,
  safeNameExhausted,
  writeFailed,
  alreadyInProgress,
}

sealed class ExportDestinationResult {
  const ExportDestinationResult();
}

final class ExportDestinationSuccess extends ExportDestinationResult {
  const ExportDestinationSuccess({
    required this.destinationLabel,
    required this.path,
    required this.bytesWritten,
  });

  final String destinationLabel;
  final String path;
  final int bytesWritten;
}

final class ExportDestinationFailure extends ExportDestinationResult {
  const ExportDestinationFailure({required this.kind, required this.message});

  final ExportDestinationFailureKind kind;
  final String message;
}

abstract interface class ExportDestinationPort {
  Future<ExportDestinationResult> write(ExportDestinationRequest request);
}

String exportDestinationMessage(String format, ExportDestinationResult result) {
  return switch (result) {
    ExportDestinationSuccess(:final destinationLabel, :final path) =>
      'Exported $format to $destinationLabel: $path.',
    ExportDestinationFailure(:final message) => message,
  };
}
