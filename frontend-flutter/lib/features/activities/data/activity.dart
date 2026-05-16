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

