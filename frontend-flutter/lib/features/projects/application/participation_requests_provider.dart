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