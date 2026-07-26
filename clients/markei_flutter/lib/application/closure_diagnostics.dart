import '../domain/shared/ids.dart';

abstract interface class ClosureDiagnosticsQuery {
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  });
  Future<UnknownSubmissionRetryPreflight> unknownSubmissionRetryPreflight({
    required String authenticationState,
  });
  Future<FailedNotAppliedRecoveryInspection> inspectFailedNotAppliedRecovery({
    required String authenticationState,
    required String operationFingerprint,
  });
  Future<void> clearAttemptHistory();
}

abstract interface class SyncAttemptRecorder {
  Future<int> beginSyncAttempt();
  Future<int> beginDiagnosticAttempt({
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String correlationFingerprint,
  });
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  });
  Future<void> completeDiagnosticAttempt(
    int attemptId, {
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String recoveryCode,
    required String correlationFingerprint,
    required String elapsedBand,
    int? httpStatus,
    required bool responseHeadersReceived,
  });
  Future<int> recordDiagnosticEvent(SyncDiagnosticEnvelope diagnostic);
}

final class SyncDiagnosticEnvelope {
  const SyncDiagnosticEnvelope({
    required this.attemptId,
    required this.ordinal,
    required this.code,
    required this.nativeCode,
    required this.severity,
    required this.outcome,
    required this.operationKind,
    required this.phase,
    required this.operationFingerprint,
    required this.correlationFingerprint,
    required this.localMutationState,
    required this.providerContactState,
    required this.providerTransactionState,
    required this.trustedResponseState,
    required this.queueScope,
    required this.pendingCount,
    required this.uploadingCount,
    required this.failedCount,
    required this.unknownCount,
    required this.memberCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextDeviceSequence,
    required this.httpStatus,
    required this.responseHeadersReceived,
    required this.safeAction,
    required this.retryable,
    required this.sanitizedExceptionClass,
    required this.serverSqlstateClass,
  });

  final int attemptId;
  final int ordinal;
  final String code;
  final String? nativeCode;
  final String severity;
  final String outcome;
  final String operationKind;
  final String phase;
  final String? operationFingerprint;
  final String? correlationFingerprint;
  final String localMutationState;
  final String providerContactState;
  final String providerTransactionState;
  final String trustedResponseState;
  final String? queueScope;
  final int? pendingCount;
  final int? uploadingCount;
  final int? failedCount;
  final int? unknownCount;
  final int? memberCount;
  final int? firstDeviceSequence;
  final int? lastDeviceSequence;
  final int? nextDeviceSequence;
  final int? httpStatus;
  final bool responseHeadersReceived;
  final String safeAction;
  final bool retryable;
  final String? sanitizedExceptionClass;
  final String? serverSqlstateClass;
}

final class ClosureDiagnosticsSnapshot {
  const ClosureDiagnosticsSnapshot({
    required this.authenticationState,
    required this.enrollmentState,
    required this.syncReadiness,
    required this.lastResult,
    required this.queueCounts,
    required this.nextDeviceSequence,
    required this.lastSuccessfulSyncAt,
    required this.recoveryGuidance,
    required this.recentAttempts,
    required this.devices,
    required this.actionableEvents,
    required this.refreshedAt,
  });

  final String authenticationState;
  final String enrollmentState;
  final String syncReadiness;
  final String lastResult;
  final ClosureQueueCounts queueCounts;
  final int? nextDeviceSequence;
  final DateTime? lastSuccessfulSyncAt;
  final String recoveryGuidance;
  final List<ClosureSyncAttemptSummary> recentAttempts;
  final List<ClosureDeviceSummary> devices;
  final List<ClosureActionableEventSummary> actionableEvents;
  final DateTime refreshedAt;
}

final class ClosureQueueCounts {
  const ClosureQueueCounts({
    required this.pending,
    required this.uploading,
    required this.failed,
    required this.unknown,
  });

  final int pending;
  final int uploading;
  final int failed;
  final int unknown;

  int get blocked => failed + unknown;
}

final class ClosureSyncAttemptSummary {
  const ClosureSyncAttemptSummary({
    required this.fingerprint,
    required this.startedAt,
    required this.completedAt,
    required this.duration,
    required this.operationKind,
    required this.phase,
    required this.latestStage,
    required this.resultCode,
    required this.outcomeClass,
    required this.recoveryCode,
    required this.correlationFingerprint,
    required this.elapsedBand,
    required this.httpStatus,
    required this.responseHeadersReceived,
  });

  final String fingerprint;
  final DateTime startedAt;
  final DateTime? completedAt;
  final Duration? duration;
  final String operationKind;
  final String phase;
  final String latestStage;
  final String resultCode;
  final String outcomeClass;
  final String? recoveryCode;
  final String? correlationFingerprint;
  final String? elapsedBand;
  final int? httpStatus;
  final bool responseHeadersReceived;
}

final class ClosureDeviceSummary {
  const ClosureDeviceSummary({
    required this.fingerprint,
    required this.isCurrent,
    required this.enrollmentState,
    required this.nextSequence,
  });

  final String fingerprint;
  final bool isCurrent;
  final String enrollmentState;
  final int nextSequence;
}

final class ClosureActionableEventSummary {
  const ClosureActionableEventSummary({
    required this.fingerprint,
    required this.eventType,
    required this.deviceSequence,
    required this.state,
    required this.enqueuedAt,
    required this.occurredAt,
  });

  final String fingerprint;
  final String eventType;
  final int deviceSequence;
  final String state;
  final DateTime enqueuedAt;
  final DateTime occurredAt;
}

final class UnknownSubmissionRetryPreflight {
  const UnknownSubmissionRetryPreflight.eligible({
    required this.submissionFingerprint,
    required this.eventCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextLocalDeviceSequence,
  }) : state = 'unknown-retry-eligible',
       guidance = 'confirm-exact-unknown-retry',
       eligible = true;

  const UnknownSubmissionRetryPreflight.blocked({
    required this.state,
    required this.guidance,
  }) : eligible = false,
       submissionFingerprint = null,
       eventCount = null,
       firstDeviceSequence = null,
       lastDeviceSequence = null,
       nextLocalDeviceSequence = null;

  final bool eligible;
  final String state;
  final String guidance;
  final String? submissionFingerprint;
  final int? eventCount;
  final int? firstDeviceSequence;
  final int? lastDeviceSequence;
  final int? nextLocalDeviceSequence;
}

final class FailedNotAppliedRecoveryInspection {
  const FailedNotAppliedRecoveryInspection.eligible({
    required this.diagnosticCode,
    required this.candidateFingerprint,
    required this.memberCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextDeviceSequence,
    required this.queueCounts,
    required this.requestHashMatches,
    required this.membershipContiguous,
    required this.deviceScopeMatches,
    required this.eventStatesCompatible,
    required this.noAcceptedMembers,
    required this.noActiveOverlap,
  }) : eligible = true,
       state = 'failed-not-applied-inspection-eligible';

  const FailedNotAppliedRecoveryInspection.blocked({
    required this.diagnosticCode,
    required this.state,
    required this.queueCounts,
    this.candidateFingerprint,
    this.memberCount,
    this.firstDeviceSequence,
    this.lastDeviceSequence,
    this.nextDeviceSequence,
    this.requestHashMatches = false,
    this.membershipContiguous = false,
    this.deviceScopeMatches = false,
    this.eventStatesCompatible = false,
    this.noAcceptedMembers = false,
    this.noActiveOverlap = false,
  }) : eligible = false;

  final bool eligible;
  final String diagnosticCode;
  final String state;
  final String? candidateFingerprint;
  final int? memberCount;
  final int? firstDeviceSequence;
  final int? lastDeviceSequence;
  final int? nextDeviceSequence;
  final ClosureQueueCounts queueCounts;
  final bool requestHashMatches;
  final bool membershipContiguous;
  final bool deviceScopeMatches;
  final bool eventStatesCompatible;
  final bool noAcceptedMembers;
  final bool noActiveOverlap;
}

final class ClosureDiagnosticsScope {
  const ClosureDiagnosticsScope({
    required this.accountId,
    required this.deviceId,
    required this.environmentAlias,
  });

  final AccountId accountId;
  final DeviceId deviceId;
  final String environmentAlias;
}
