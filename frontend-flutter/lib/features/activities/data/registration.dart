// Modèle Dart aligné sur :
//   - Entity  : Registration.java
//   - Enum    : RegistrationStatus.java
//
// Représente l'inscription d'un utilisateur à une activité.
// Utilisé par GET /api/registrations/me pour récupérer
// les activités auxquelles l'utilisateur connecté est inscrit.
 
import 'activity.dart';
import 'activity.dart';
 
// ── Enum RegistrationStatus ───────────────────────────────────
 
enum RegistrationStatus {
  registered, // REGISTERED → Inscrit (actif)
  cancelled,  // CANCELLED  → Annulé par l'utilisateur
  attended,   // ATTENDED   → Présent (marqué par le référent)
  noShow;     // NO_SHOW    → Absent sans annulation
 
  String get label {
    switch (this) {
      case RegistrationStatus.registered: return 'Inscrit';
      case RegistrationStatus.cancelled:  return 'Annulé';
      case RegistrationStatus.attended:   return 'Présent';
      case RegistrationStatus.noShow:     return 'Absent';
    }
  }
 
  bool get isActive => this == RegistrationStatus.registered;
 
  static RegistrationStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'REGISTERED': return RegistrationStatus.registered;
      case 'CANCELLED':  return RegistrationStatus.cancelled;
      case 'ATTENDED':   return RegistrationStatus.attended;
      case 'NO_SHOW':    return RegistrationStatus.noShow;
      default:           return RegistrationStatus.registered;
    }
  }
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
 
  /// Seules les inscriptions REGISTERED dont l'activité est à venir
  /// sont affichées dans "Mes activités à venir".
  bool get isUpcomingActive =>
      status.isActive && activity.isUpcoming;
 
  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    id:               json['id'] as int,
    userId:           json['userId'] as int,
    activity:         Activity.fromJson(json['activity'] as Map<String, dynamic>),
    registrationDate: DateTime.parse(json['registrationDate'] as String),
    status:           RegistrationStatus.fromString(json['status'] as String),
  );
 
  Map<String, dynamic> toJson() => {
    'id':               id,
    'userId':           userId,
    'activity':         activity.toJson(),
    'registrationDate': registrationDate.toIso8601String(),
    'status':           status.name.toUpperCase(),
  };
}