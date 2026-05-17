import 'activity.dart';

// ── Enum RegistrationStatus ───────────────────────────────────

enum RegistrationStatus {
  registered,
  cancelled,
  attended,
  noShow;

  String get label => switch (this) {
        RegistrationStatus.registered => 'Inscrit',
        RegistrationStatus.cancelled  => 'Annulé',
        RegistrationStatus.attended   => 'Présent',
        RegistrationStatus.noShow     => 'Absent',
      };

  String get jsonValue => switch (this) {
        RegistrationStatus.registered => 'REGISTERED',
        RegistrationStatus.cancelled  => 'CANCELLED',
        RegistrationStatus.attended   => 'ATTENDED',
        RegistrationStatus.noShow     => 'NO_SHOW',
      };

  bool get isActive => this == RegistrationStatus.registered;

  static RegistrationStatus fromString(String value) =>
      switch (value.toUpperCase()) {
        'CANCELLED' => RegistrationStatus.cancelled,
        'ATTENDED'  => RegistrationStatus.attended,
        'NO_SHOW'   => RegistrationStatus.noShow,
        _           => RegistrationStatus.registered,
      };
}

// ── Model Registration ────────────────────────────────────────

class Registration {
  final int id;
  final int userId;
  final Activity activity;
  final DateTime registrationDate;
  final RegistrationStatus status;

  const Registration({
    required this.id,
    required this.userId,
    required this.activity,
    required this.registrationDate,
    required this.status,
  });

  bool get isUpcomingActive =>
      status.isActive && activity.isUpcoming;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id:               json['id'] as int,
        userId:           json['userId'] as int,
        activity:         Activity.fromJson(
            json['activity'] as Map<String, dynamic>),
        registrationDate: DateTime.parse(
            json['registrationDate'] as String),
        status: RegistrationStatus.fromString(
            json['status'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id':               id,
        'userId':           userId,
        'activity':         activity.toJson(),
        'registrationDate': registrationDate.toIso8601String(),
        'status':           status.jsonValue,
      };
}
