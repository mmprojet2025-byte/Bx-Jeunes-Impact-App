// Modèle Dart aligné sur :
//   - Entity  : Activity.java
//   - DTO     : ActivityResponse.java
//   - Enum    : ActivityCategory.java
 
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_helpers.dart';
 
// ── Enum ActivityCategory ─────────────────────────────────────
 
enum ActivityCategory {
  workshop,   // WORKSHOP  → Atelier
  training,   // TRAINING  → Formation
  meeting,    // MEETING   → Réunion
  outing,     // OUTING    → Sortie
  event,      // EVENT     → Événement
  other;      // OTHER     → Autre
 
  /// Label français affiché dans l'UI
  String get label {
    switch (this) {
      case ActivityCategory.workshop: return 'Atelier';
      case ActivityCategory.training: return 'Formation';
      case ActivityCategory.meeting:  return 'Réunion';
      case ActivityCategory.outing:   return 'Sortie';
      case ActivityCategory.event:    return 'Événement';
      case ActivityCategory.other:    return 'Autre';
    }
  }
 
  /// Couleur associée à la catégorie
  Color get color {
    switch (this) {
      case ActivityCategory.workshop: return AppColors.orange;
      case ActivityCategory.training: return AppColors.culture;
      case ActivityCategory.meeting:  return AppColors.solidarite;
      case ActivityCategory.outing:   return AppColors.sport;
      case ActivityCategory.event:    return AppColors.red;
      case ActivityCategory.other:    return AppColors.autre;
    }
  }
 
  /// Icône associée
  IconData get icon {
    switch (this) {
      case ActivityCategory.workshop: return Icons.palette_outlined;
      case ActivityCategory.training: return Icons.school_outlined;
      case ActivityCategory.meeting:  return Icons.groups_outlined;
      case ActivityCategory.outing:   return Icons.directions_walk_outlined;
      case ActivityCategory.event:    return Icons.celebration_outlined;
      case ActivityCategory.other:    return Icons.event_outlined;
    }
  }
 
  /// Désérialisation depuis la chaîne backend
  static ActivityCategory fromString(String value) {
    switch (value.toUpperCase()) {
      case 'WORKSHOP': return ActivityCategory.workshop;
      case 'TRAINING': return ActivityCategory.training;
      case 'MEETING':  return ActivityCategory.meeting;
      case 'OUTING':   return ActivityCategory.outing;
      case 'EVENT':    return ActivityCategory.event;
      default:         return ActivityCategory.other;
    }
  }
}
 
// ── Model Activity ────────────────────────────────────────────
 
class Activity {
  final int id;
  final String name;
  final String? description;
  final DateTime date;
  final ActivityCategory category;
  final int? groupId;
  final String? groupName;
 
  const Activity({
    required this.id,
    required this.name,
    this.description,
    required this.date,
    required this.category,
    this.groupId,
    this.groupName,
  });
 
  // ── Computed ───────────────────────────────────────────────
 
  bool get isUpcoming => DateHelpers.isUpcoming(date);
 
  /// "25 MAI"
  String get shortDate => DateHelpers.formatShort(date);
 
  /// "25"
  String get dayNumber => DateHelpers.day(date);
 
  /// "MAI"
  String get monthAbbr => DateHelpers.monthAbbr(date);
 
  /// "25 Mai 2024 • 14:00"
  String get fullDateTime => DateHelpers.formatDateTime(date);
 
  // ── Serialization ──────────────────────────────────────────
 
  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id:          json['id'] as int,
    name:        json['name'] as String,
    description: json['description'] as String?,
    date:        DateTime.parse(json['date'] as String),
    category:    ActivityCategory.fromString(json['category'] as String),
    groupId:     json['groupId'] as int?,
    groupName:   json['groupName'] as String?,
  );
 
  Map<String, dynamic> toJson() => {
    'id':          id,
    'name':        name,
    'description': description,
    'date':        date.toIso8601String(),
    'category':    category.name.toUpperCase(),
    'groupId':     groupId,
    'groupName':   groupName,
  };
}
