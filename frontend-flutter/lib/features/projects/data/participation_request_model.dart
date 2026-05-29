// lib/features/projects/data/participation_request_model.dart

enum ParticipationRequestStatus {
  pending,
  accepted,
  refused,
}

extension ParticipationRequestStatusExt on ParticipationRequestStatus {
  static ParticipationRequestStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ACCEPTED':
        return ParticipationRequestStatus.accepted;
      case 'REFUSED':
        return ParticipationRequestStatus.refused;
      case 'PENDING':
      default:
        return ParticipationRequestStatus.pending;
    }
  }

  String toJson() {
    switch (this) {
      case ParticipationRequestStatus.accepted:
        return 'ACCEPTED';
      case ParticipationRequestStatus.refused:
        return 'REFUSED';
      case ParticipationRequestStatus.pending:
        return 'PENDING';
    }
  }

  String get label {
    switch (this) {
      case ParticipationRequestStatus.accepted:
        return 'Accepté';
      case ParticipationRequestStatus.refused:
        return 'Refusé';
      case ParticipationRequestStatus.pending:
        return 'En attente';
    }
  }
}

class ParticipationRequest {
  final int id;
  final int projectId;
  final int userId;
  final String? message;
  final ParticipationRequestStatus status;
  final DateTime createdAt;

  ParticipationRequest({
    required this.id,
    required this.projectId,
    required this.userId,
    this.message,
    required this.status,
    required this.createdAt,
  });

  factory ParticipationRequest.fromJson(Map<String, dynamic> j) {
    return ParticipationRequest(
      id: (j['id'] as num).toInt(),
      projectId: (j['projectId'] as num).toInt(),
      userId: (j['userId'] as num).toInt(),
      message: j['message'] as String?,
      status: ParticipationRequestStatusExt.fromString(
        j['status'] as String? ?? 'PENDING',
      ),
      createdAt: DateTime.parse(j['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'userId': userId,
      'message': message,
      'status': status.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ParticipationRequest copyWith({
    int? id,
    int? projectId,
    int? userId,
    String? message,
    ParticipationRequestStatus? status,
    DateTime? createdAt,
  }) {
    return ParticipationRequest(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
