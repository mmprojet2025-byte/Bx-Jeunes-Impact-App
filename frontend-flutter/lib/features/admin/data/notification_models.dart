import 'package:flutter/material.dart';

enum NotificationTarget { all, youth, referents, admins, group }
enum NotificationStatus { sent, failed, pending }

class AppNotification {
  final int id;
  final String title;
  final String body;
  final NotificationTarget target;
  final NotificationStatus status;
  final int? groupId;
  final DateTime createdAt;
  final int? sentCount;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.target,
    required this.status,
    required this.createdAt,
    this.groupId,
    this.sentCount,
  });

  factory AppNotification.fromJson(Map<String, dynamic> j) =>
      AppNotification(
        id: j['id'] as int,
        title: j['title'] as String,
        body: j['body'] as String,
        target: NotificationTarget.values.firstWhere(
            (t) => t.name.toUpperCase() == (j['target'] as String).toUpperCase(),
            orElse: () => NotificationTarget.all,),
        status: NotificationStatus.values.firstWhere(
            (s) => s.name.toUpperCase() == (j['status'] as String).toUpperCase(),
            orElse: () => NotificationStatus.sent,),
        groupId: j['groupId'] as int?,
        createdAt: DateTime.parse(j['createdAt'] as String),
        sentCount: j['sentCount'] as int?,
      );

  Color get statusColor => switch (status) {
        NotificationStatus.sent => const Color(0xFF4CAF50),
        NotificationStatus.failed => const Color(0xFFF44336),
        NotificationStatus.pending => const Color(0xFFFF9800),
      };

  String get statusLabel => switch (status) {
        NotificationStatus.sent => 'Envoyé',
        NotificationStatus.failed => 'Échec',
        NotificationStatus.pending => 'En attente',
      };

  String get targetLabel => switch (target) {
        NotificationTarget.all => 'Tous',
        NotificationTarget.youth => 'Jeunes',
        NotificationTarget.referents => 'Référents',
        NotificationTarget.admins => 'Admins',
        NotificationTarget.group => 'Groupe #$groupId',
      };
}

class NotificationSendRequest {
  final String title;
  final String body;
  final NotificationTarget target;
  final int? groupId;
  const NotificationSendRequest({
    required this.title,
    required this.body,
    required this.target,
    this.groupId,
  });
  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'target': target.name.toUpperCase(),
        if (groupId != null) 'groupId': groupId,
      };
}