// Modèles pour la feature Activités.
//
// Entités backend mirrorées :
//   Activity.java         → Activity
//   Registration.java     → Registration
//   ActivityCategory.java → ActivityCategory (enum)
//   RegistrationStatus.java → RegistrationStatus (enum)
//
// Champs alignés sur ActivityResponse.java (ce que l'API renvoie réellement).
 
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
 
import '../../../core/theme/app_colors.dart';
 
part 'activity.freezed.dart';
part 'activity.g.dart';
 
// ── Enum ActivityCategory ─────────────────────────────────────
// Miroir exact de ActivityCategory.java
 
@JsonEnum(valueField: 'jsonValue')
enum ActivityCategory {
  @JsonValue('WORKSHOP')
  workshop('WORKSHOP'),
 
  @JsonValue('TRAINING')
  training('TRAINING'),
 
  @JsonValue('MEETING')
  meeting('MEETING'),
 
  @JsonValue('OUTING')
  outing('OUTING'),
 
  @JsonValue('EVENT')
  event('EVENT'),
 
  @JsonValue('OTHER')
  other('OTHER');
 
  const ActivityCategory(this.jsonValue);
  final String jsonValue;
 
  String get label => switch (this) {
        ActivityCategory.workshop => 'Atelier',
        ActivityCategory.training => 'Formation',
        ActivityCategory.meeting  => 'Réunion',
        ActivityCategory.outing   => 'Sortie',
        ActivityCategory.event    => 'Événement',
        ActivityCategory.other    => 'Autre',
      };
 
  Color get color => switch (this) {
        ActivityCategory.workshop => AppColors.orange,
        ActivityCategory.training => AppColors.culture,
        ActivityCategory.meeting  => AppColors.solidarite,
        ActivityCategory.outing   => AppColors.sport,
        ActivityCategory.event    => AppColors.red,
        ActivityCategory.other    => AppColors.autre,
      };
 
  IconData get icon => switch (this) {
        ActivityCategory.workshop => Icons.palette_outlined,
        ActivityCategory.training => Icons.school_outlined,
        ActivityCategory.meeting  => Icons.groups_outlined,
        ActivityCategory.outing   => Icons.directions_walk_outlined,
        ActivityCategory.event    => Icons.celebration_outlined,
        ActivityCategory.other    => Icons.event_outlined,
      };
}
 
// ── Enum RegistrationStatus ───────────────────────────────────
// Miroir exact de RegistrationStatus.java
 
@JsonEnum(valueField: 'jsonValue')
enum RegistrationStatus {
  @JsonValue('REGISTERED')
  registered('REGISTERED'),
 
  @JsonValue('CANCELLED')
  cancelled('CANCELLED'),
 
  @JsonValue('ATTENDED')
  attended('ATTENDED'),
 
  @JsonValue('NO_SHOW')
  noShow('NO_SHOW');
 
  const RegistrationStatus(this.jsonValue);
  final String jsonValue;
 
  String get label => switch (this) {
        RegistrationStatus.registered => 'Inscrit',
        RegistrationStatus.cancelled  => 'Annulé',
        RegistrationStatus.attended   => 'Présent',
        RegistrationStatus.noShow     => 'Absent',
      };
 
  bool get isActive => this == RegistrationStatus.registered;
}
 
// ── Activity ──────────────────────────────────────────────────
// Aligné sur ActivityResponse.java
 
@freezed
class Activity with _$Activity {
  const Activity._();
 
  const factory Activity({
    required int id,
 
    /// Nom de l'activité (max 150 chars côté backend)
    required String name,
 
    /// Date/heure de l'activité — LocalDateTime sérialisé en ISO-8601
    required DateTime date, required ActivityCategory category, String? description,
 
    /// Groupe organisateur (null = activité ASBL générale)
    int? groupId,
    String? groupName,
 
    DateTime? createdAt,
 
    @Default(true) bool active,
  }) = _Activity;
 
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
 
  // ── Computed ─────────────────────────────────────────────
  bool get isUpcoming => date.isAfter(DateTime.now());
  bool get isPast     => date.isBefore(DateTime.now());
}
 
// ── Registration ──────────────────────────────────────────────
// Miroir de Registration.java — association User ↔ Activity
 
@freezed
class Registration with _$Registration {
  const Registration._();
 
  const factory Registration({
    required int id,
 
    /// ID de l'utilisateur inscrit
    required int userId,
 
    /// Activité concernée (embedded dans la réponse API)
    required Activity activity,
 
    DateTime? registrationDate,
 
    @Default(RegistrationStatus.registered) RegistrationStatus status,
  }) = _Registration;
 
  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
 
  bool get isUpcomingActive =>
      status.isActive && activity.isUpcoming;
}