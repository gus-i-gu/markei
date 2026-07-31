// ignore_for_file: prefer_initializing_formals

import '../domain/shared/ids.dart';

final class AuditAttemptId {
  const AuditAttemptId(this.value);

  final int value;
}

final class AuditEventId {
  const AuditEventId(this.value);

  final int value;
}

final class AuditCursor {
  const AuditCursor({required this.startedAtUtc, required this.attemptId});

  final DateTime startedAtUtc;
  final AuditAttemptId attemptId;
}

final class AuditPageRequest {
  AuditPageRequest({
    required this.accountId,
    required this.environmentAlias,
    this.cursor,
    int limit = defaultLimit,
  }) : limit = limit.clamp(1, maxLimit);

  static const defaultLimit = 20;
  static const maxLimit = 50;

  final AccountId accountId;
  final String environmentAlias;
  final AuditCursor? cursor;
  final int limit;
}

enum AuditUnavailableReason { notRecorded, unknownCode, readFailed }

final class AuditUnavailable {
  const AuditUnavailable(this.reason, this.message);

  final AuditUnavailableReason reason;
  final String message;
}

final class AuditEventProjection {
  const AuditEventProjection({
    required this.id,
    required this.recordedAtUtc,
    required this.code,
    required this.title,
    required this.meaning,
    required this.guidance,
    required this.severity,
    required this.outcome,
    required this.phase,
  });

  final AuditEventId id;
  final DateTime recordedAtUtc;
  final String code;
  final String title;
  final String meaning;
  final String guidance;
  final String severity;
  final String outcome;
  final String phase;
}

final class AuditAttemptProjection {
  const AuditAttemptProjection({
    required this.id,
    required this.startedAtUtc,
    required this.completedAtUtc,
    required this.operationKind,
    required this.resultCode,
    required this.outcomeClass,
    required this.latestStage,
    required this.correlationReference,
    required this.deviceReference,
    required this.events,
  });

  final AuditAttemptId id;
  final DateTime startedAtUtc;
  final DateTime? completedAtUtc;
  final String operationKind;
  final String resultCode;
  final String outcomeClass;
  final String latestStage;
  final String? correlationReference;
  final String? deviceReference;
  final List<AuditEventProjection> events;
}

final class AuditPageResult {
  const AuditPageResult({
    required this.records,
    required this.nextCursor,
    required this.loadedAtUtc,
    required this.isPartialWindow,
    required this.queryCount,
    required this.networkCallCount,
    required this.writeCallCount,
  });

  final List<AuditAttemptProjection> records;
  final AuditCursor? nextCursor;
  final DateTime loadedAtUtc;
  final bool isPartialWindow;
  final int queryCount;
  final int networkCallCount;
  final int writeCallCount;
}

abstract interface class AuditReadPort {
  Future<AuditPageResult> loadPage(AuditPageRequest request);
}

enum AuditWorkspaceKind { idle, loading, ready, empty, stale, unavailable }

final class AuditWorkspaceState {
  const AuditWorkspaceState._({
    required this.kind,
    this.page,
    this.message,
    this.request,
    this.generation = 0,
  });

  const AuditWorkspaceState.idle()
    : this._(kind: AuditWorkspaceKind.idle, generation: 0);

  const AuditWorkspaceState.loading({
    AuditPageResult? previous,
    AuditPageRequest? request,
    required int generation,
  }) : this._(
         kind: AuditWorkspaceKind.loading,
         page: previous,
         request: request,
         generation: generation,
       );

  const AuditWorkspaceState.ready(
    AuditPageResult page, {
    required AuditPageRequest request,
    required int generation,
  }) : this._(
         kind: AuditWorkspaceKind.ready,
         page: page,
         request: request,
         generation: generation,
       );

  const AuditWorkspaceState.empty(
    AuditPageResult page, {
    required AuditPageRequest request,
    required int generation,
  }) : this._(
         kind: AuditWorkspaceKind.empty,
         page: page,
         request: request,
         generation: generation,
       );

  const AuditWorkspaceState.stale({
    required AuditPageResult previous,
    required AuditPageRequest request,
    required String message,
    required int generation,
  }) : this._(
         kind: AuditWorkspaceKind.stale,
         page: previous,
         request: request,
         message: message,
         generation: generation,
       );

  const AuditWorkspaceState.unavailable({
    required String message,
    AuditPageResult? previous,
    AuditPageRequest? request,
    required int generation,
  }) : this._(
         kind: AuditWorkspaceKind.unavailable,
         page: previous,
         request: request,
         message: message,
         generation: generation,
       );

  final AuditWorkspaceKind kind;
  final AuditPageResult? page;
  final String? message;
  final AuditPageRequest? request;
  final int generation;
}

final class AuditController {
  AuditController({
    required AccountId accountId,
    required String environmentAlias,
    required AuditReadPort repository,
  }) : _accountId = accountId,
       _environmentAlias = environmentAlias,
       _repository = repository;

  final AccountId _accountId;
  final String _environmentAlias;
  final AuditReadPort _repository;
  var _generation = 0;
  bool _disposed = false;
  AuditPageRequest? _lastRequest;
  AuditWorkspaceState _state = const AuditWorkspaceState.idle();

  AuditWorkspaceState get state => _state;

  Future<AuditWorkspaceState> loadFirstPage() {
    return _load(
      AuditPageRequest(
        accountId: _accountId,
        environmentAlias: _environmentAlias,
      ),
    );
  }

  Future<AuditWorkspaceState> retry() {
    return _load(
      _lastRequest ??
          AuditPageRequest(
            accountId: _accountId,
            environmentAlias: _environmentAlias,
          ),
    );
  }

  Future<AuditWorkspaceState> loadNextPage() {
    final cursor = _state.page?.nextCursor;
    if (cursor == null) return Future.value(_state);
    return _load(
      AuditPageRequest(
        accountId: _accountId,
        environmentAlias: _environmentAlias,
        cursor: cursor,
      ),
    );
  }

  Future<AuditWorkspaceState> _load(AuditPageRequest request) async {
    if (_disposed) return _state;
    final generation = ++_generation;
    final previous = _state.page;
    _lastRequest = request;
    _state = AuditWorkspaceState.loading(
      previous: previous,
      request: request,
      generation: generation,
    );
    try {
      final page = await _repository.loadPage(request);
      if (_disposed || generation != _generation) return _state;
      _state = page.records.isEmpty
          ? AuditWorkspaceState.empty(
              page,
              request: request,
              generation: generation,
            )
          : AuditWorkspaceState.ready(
              page,
              request: request,
              generation: generation,
            );
      return _state;
    } on Object {
      if (_disposed || generation != _generation) return _state;
      _state = previous == null
          ? AuditWorkspaceState.unavailable(
              message: 'Local activity could not be loaded.',
              request: request,
              generation: generation,
            )
          : AuditWorkspaceState.stale(
              previous: previous,
              request: request,
              message:
                  'Last loaded locally at ${previous.loadedAtUtc.toUtc().toIso8601String()}. Refresh to read local records again.',
              generation: generation,
            );
      return _state;
    }
  }

  void dispose() {
    _disposed = true;
    _generation++;
  }
}
