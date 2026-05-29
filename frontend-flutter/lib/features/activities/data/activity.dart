import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

// ── Enum ActivityCategory ─────────────────────────────────────
// Miroir exact de ActivityCategory.java

enum ActivityCategory {
  workshop('WORKSHOP'),
  training('TRAINING'),
  meeting('MEETING'),
  outing('OUTING'),
  event('EVENT'),
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

// ── Model Activity ────────────────────────────────────────────

class Activity {
  final int              id;
  final String           name;
  final String?          description;
  final DateTime         date;
  final ActivityCategory category;
  final String?          groupName;   // lieu / groupe
  final int?             maxParticipants;
  final int?             currentParticipants;

  const Activity({
    required this.id,
    required this.name,
    required this.date, required this.category, this.description,
    this.groupName,
    this.maxParticipants,
    this.currentParticipants,
  });

  // ── Computed helpers used by widgets ─────────────────────────

  bool get isUpcoming => date.isAfter(DateTime.now());

  /// "14"
  String get dayNumber => date.day.toString().padLeft(2, '0');

  /// "JAN", "FÉV", etc.
  String get monthAbbr {
    const months = [
      'JAN', 'FÉV', 'MAR', 'AVR', 'MAI', 'JUN',
      'JUL', 'AOÛ', 'SEP', 'OCT', 'NOV', 'DÉC',
    ];
    return months[date.month - 1];
  }

  // ── Serialization ─────────────────────────────────────────────

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id:                  json['id'] as int,
    name:                json['name'] as String,
    description:         json['description'] as String?,
    date:                DateTime.parse(json['date'] as String),
    category:            ActivityCategory.values.firstWhere(
                           (c) => c.jsonValue == json['category'],
                           orElse: () => ActivityCategory.other,
                         ),
    groupName:           json['groupName'] as String?,
    maxParticipants:     json['maxParticipants'] as int?,
    currentParticipants: json['currentParticipants'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id':                  id,
    'name':                name,
    'description':         description,
    'date':                date.toIso8601String(),
    'category':            category.jsonValue,
    'groupName':           groupName,
    'maxParticipants':     maxParticipants,
    'currentParticipants': currentParticipants,
  };
}