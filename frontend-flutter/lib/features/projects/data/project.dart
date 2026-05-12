// Modèle Dart aligné sur :
//   - Entity  : Project.java
//   - DTO     : ProjectResponse.java
//   - Enum    : ProjectStatus.java
 
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
// ── Enum ProjectStatus ────────────────────────────────────────
 
enum ProjectStatus {
  pending,                // PENDING
  validatedByReferent,    // VALIDATED_BY_REFERENT
  refusedByReferent,      // REFUSED_BY_REFERENT
  transmittedToAdmin,     // TRANSMITTED_TO_ADMIN
  validatedByAdmin,       // VALIDATED_BY_ADMIN
  refusedByAdmin,         // REFUSED_BY_ADMIN
  visibleToPartners,      // VISIBLE_TO_PARTNERS
  completed;              // COMPLETED
 
  String get label {
    switch (this) {
      case ProjectStatus.pending:               return 'En attente';
      case ProjectStatus.validatedByReferent:   return 'Validé référent';
      case ProjectStatus.refusedByReferent:     return 'Refusé';
      case ProjectStatus.transmittedToAdmin:    return 'Transmis';
      case ProjectStatus.validatedByAdmin:      return 'Validé';
      case ProjectStatus.refusedByAdmin:        return 'Refusé';
      case ProjectStatus.visibleToPartners:     return 'Public';
      case ProjectStatus.completed:             return 'Terminé';
    }
  }
 
  Color get color {
    switch (this) {
      case ProjectStatus.pending:               return AppColors.enAttente;
      case ProjectStatus.validatedByReferent:   return AppColors.enCours;
      case ProjectStatus.refusedByReferent:     return AppColors.refuse;
      case ProjectStatus.transmittedToAdmin:    return AppColors.sport;
      case ProjectStatus.validatedByAdmin:      return AppColors.valide;
      case ProjectStatus.refusedByAdmin:        return AppColors.refuse;
      case ProjectStatus.visibleToPartners:     return AppColors.culture;
      case ProjectStatus.completed:             return AppColors.brouillon;
    }
  }
 
  /// Statuts considérés "en cours" pour la section "Mes projets"
  bool get isActive => switch (this) {
    ProjectStatus.pending              => true,
    ProjectStatus.validatedByReferent  => true,
    ProjectStatus.transmittedToAdmin   => true,
    ProjectStatus.validatedByAdmin     => true,
    ProjectStatus.visibleToPartners    => true,
    _ => false,
  };
 
  static ProjectStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':                 return ProjectStatus.pending;
      case 'VALIDATED_BY_REFERENT':   return ProjectStatus.validatedByReferent;
      case 'REFUSED_BY_REFERENT':     return ProjectStatus.refusedByReferent;
      case 'TRANSMITTED_TO_ADMIN':    return ProjectStatus.transmittedToAdmin;
      case 'VALIDATED_BY_ADMIN':      return ProjectStatus.validatedByAdmin;
      case 'REFUSED_BY_ADMIN':        return ProjectStatus.refusedByAdmin;
      case 'VISIBLE_TO_PARTNERS':     return ProjectStatus.visibleToPartners;
      case 'COMPLETED':               return ProjectStatus.completed;
      default:                        return ProjectStatus.pending;
    }
  }
}
 
// ── Model Project ─────────────────────────────────────────────
 
class Project {
  final int id;
  final String title;
  final String description;
  final ProjectStatus status;
  final int creatorId;
  final String? creatorName;
  final int? groupId;
  final String? groupName;
  final DateTime? createdAt;
 
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.creatorId,
    this.creatorName,
    this.groupId,
    this.groupName,
    this.createdAt,
  });
 
  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id:          json['id'] as int,
    title:       json['title'] as String,
    description: json['description'] as String,
    status:      ProjectStatus.fromString(json['status'] as String),
    creatorId:   json['creatorId'] as int,
    creatorName: json['creatorName'] as String?,
    groupId:     json['groupId'] as int?,
    groupName:   json['groupName'] as String?,
    createdAt:   json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
  );
 
  Map<String, dynamic> toJson() => {
    'id':          id,
    'title':       title,
    'description': description,
    'status':      status.name.toUpperCase(),
    'creatorId':   creatorId,
    'creatorName': creatorName,
    'groupId':     groupId,
    'groupName':   groupName,
    'createdAt':   createdAt?.toIso8601String(),
  };
}