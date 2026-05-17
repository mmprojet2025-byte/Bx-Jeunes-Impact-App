import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';

// ── ParticipationRequest model ────────────────────────────────

enum ParticipationRequestStatus { pending, accepted, rejected }

extension ParticipationRequestStatusExt on ParticipationRequestStatus {
  String get jsonValue => switch (this) {
        ParticipationRequestStatus.pending  => 'PENDING',
        ParticipationRequestStatus.accepted => 'ACCEPTED',
        ParticipationRequestStatus.rejected => 'REJECTED',
      };

  String get label => switch (this) {
        ParticipationRequestStatus.pending  => 'En attente',
        ParticipationRequestStatus.accepted => 'Accepté',
        ParticipationRequestStatus.rejected => 'Refusé',
      };

  static ParticipationRequestStatus fromString(String v) =>
      switch (v.toUpperCase()) {
        'ACCEPTED' => ParticipationRequestStatus.accepted,
        'REJECTED' => ParticipationRequestStatus.rejected,
        _          => ParticipationRequestStatus.pending,
      };
}

class ParticipationRequest {
  final int id;
  final int projectId;
  final int userId;
  final String? message;
  final ParticipationRequestStatus status;
  final DateTime createdAt;

  const ParticipationRequest({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.status,
    required this.createdAt,
    this.message,
  });

  factory ParticipationRequest.fromJson(Map<String, dynamic> j) =>
      ParticipationRequest(
        id:        j['id']        as int,
        projectId: j['projectId'] as int,
        userId:    j['userId']    as int,
        message:   j['message']   as String?,
        status:    ParticipationRequestStatusExt.fromString(
                       j['status'] as String? ?? 'PENDING'),
        createdAt: DateTime.parse(j['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id':        id,
        'projectId': projectId,
        'userId':    userId,
        'message':   message,
        'status':    status.jsonValue,
        'createdAt': createdAt.toIso8601String(),
      };
}

// ── Repository ────────────────────────────────────────────────


class ParticipationRequestRepository {
  final ApiService _api;
  ParticipationRequestRepository(this._api);

  Future<List<ParticipationRequest>> fetchForProject(int projectId) async {
  final raw = await _api.get<List<dynamic>>(
    '${AppConfig.projectsEndpoint}/$projectId/participation-requests',
    fromJson: (json) => json as List<dynamic>,
  );

  final items = raw;
  return items
      .map((e) => ParticipationRequest.fromJson(e as Map<String, dynamic>))
      .toList();
}

  Future<ParticipationRequest> request(int projectId, {String? message}) =>
      _api.post<ParticipationRequest>(
        '${AppConfig.projectsEndpoint}/$projectId/participation-requests',
        body: {if (message != null) 'message': message},
        fromJson: (j) =>
            ParticipationRequest.fromJson(j as Map<String, dynamic>),
      );

  Future<ParticipationRequest> respond(int requestId, String status) =>
      _api.put<ParticipationRequest>(
        '/participation-requests/$requestId',
        body: {'status': status},
        fromJson: (j) =>
            ParticipationRequest.fromJson(j as Map<String, dynamic>),
      );
}

final participationRequestRepositoryProvider =
    Provider<ParticipationRequestRepository>((ref) =>
        ParticipationRequestRepository(ref.read(apiServiceProvider)));
