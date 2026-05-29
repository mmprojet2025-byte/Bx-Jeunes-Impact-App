import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/providers/api_service_provider.dart';

// ── Model ─────────────────────────────────────────────────────
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
  static ParticipationRequestStatus fromString(String v) => switch (v.toUpperCase()) {
    'ACCEPTED' => ParticipationRequestStatus.accepted,
    'REJECTED' => ParticipationRequestStatus.rejected,
    _          => ParticipationRequestStatus.pending,
  };
}

class ParticipationRequest {
  final int id, projectId, userId;
  final String? message;
  final ParticipationRequestStatus status;
  final DateTime createdAt;

  const ParticipationRequest({
    required this.id, required this.projectId, required this.userId,
    required this.status, required this.createdAt, this.message,
  });

  factory ParticipationRequest.fromJson(Map<String, dynamic> j) => ParticipationRequest(
    id:        j['id']        as int,
    projectId: j['projectId'] as int,
    userId:    j['userId']    as int,
    message:   j['message']   as String?,
    status:    ParticipationRequestStatusExt.fromString(j['status'] as String? ?? 'PENDING'),
    createdAt: DateTime.parse(j['createdAt'] as String),
  );
}

// ── Notifier ──────────────────────────────────────────────────
class ParticipationRequestsNotifier
    extends FamilyAsyncNotifier<List<ParticipationRequest>, int> {
  @override
  Future<List<ParticipationRequest>> build(int arg) async {
    final api  = ref.read(apiServiceProvider);
    final list = await api.get<List<dynamic>>(
      '${AppConfig.projectsEndpoint}/$arg/participation-requests',
      fromJson: (j) => j as List<dynamic>,
    );
    return list
        .map((e) => ParticipationRequest.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // FIX: sendRequest used by ProjectDetailScreen
  Future<void> sendRequest({String? message}) async {
    final api = ref.read(apiServiceProvider);
    await api.post<void>(
      '${AppConfig.projectsEndpoint}/$arg/participation-requests',
      body: {'projectId': arg, if (message != null && message.isNotEmpty) 'message': message},
    );
    state = await AsyncValue.guard(() => build(arg));
  }

  Future<void> accept(int requestId) async {
    final api = ref.read(apiServiceProvider);
    await api.put<void>(
        '${AppConfig.projectsEndpoint}/$arg/participation-requests/$requestId/accept');
    state = await AsyncValue.guard(() => build(arg));
  }

  Future<void> reject(int requestId) async {
    final api = ref.read(apiServiceProvider);
    await api.put<void>(
        '${AppConfig.projectsEndpoint}/$arg/participation-requests/$requestId/reject');
    state = await AsyncValue.guard(() => build(arg));
  }
}

final participationRequestsProvider = AsyncNotifierProvider.family
    ParticipationRequestsNotifier, List<ParticipationRequest>, int>(
  ParticipationRequestsNotifier.new,
);
