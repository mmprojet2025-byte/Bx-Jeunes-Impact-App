// Modèles pour la feature Projets.
//
// Entités backend mirrorées :
//   Project.java       → Project
//   ProjectStatus.java → ProjectStatus (enum 8 valeurs)
//
// Extra :
//   ProjectCreateRequest → ProjectCreateRequest (miroir de ProjectCreateRequest.java)
//   ProjectParticipationRequest → nouveau (UML révisé)
 
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
 
import '../../../core/theme/app_colors.dart';
 
part 'project.freezed.dart';
part 'project.g.dart';
 
// ── Enum ProjectStatus ────────────────────────────────────────
// Miroir EXACT de ProjectStatus.java (8 valeurs)
 
@JsonEnum(valueField: 'jsonValue')
enum ProjectStatus {
  @JsonValue('PENDING')
  pending('PENDING'),
 
  @JsonValue('VALIDATED_BY_REFERENT')
  validatedByReferent('VALIDATED_BY_REFERENT'),
 
  @JsonValue('REFUSED_BY_REFERENT')
  refusedByReferent('REFUSED_BY_REFERENT'),
 
  @JsonValue('TRANSMITTED_TO_ADMIN')
  transmittedToAdmin('TRANSMITTED_TO_ADMIN'),
 
  @JsonValue('VALIDATED_BY_ADMIN')
  validatedByAdmin('VALIDATED_BY_ADMIN'),
 
  @JsonValue('REFUSED_BY_ADMIN')
  refusedByAdmin('REFUSED_BY_ADMIN'),
 
  @JsonValue('VISIBLE_TO_PARTNERS')
  visibleToPartners('VISIBLE_TO_PARTNERS'),
 
  @JsonValue('COMPLETED')
  completed('COMPLETED');
 
  const ProjectStatus(this.jsonValue);
  final String jsonValue;
 
  String get label => switch (this) {
        ProjectStatus.pending               => 'En attente',
        ProjectStatus.validatedByReferent   => 'Validé référent',
        ProjectStatus.refusedByReferent     => 'Refusé',
        ProjectStatus.transmittedToAdmin    => 'Transmis',
        ProjectStatus.validatedByAdmin      => 'Validé',
        ProjectStatus.refusedByAdmin        => 'Refusé',
        ProjectStatus.visibleToPartners     => 'Public',
        ProjectStatus.completed             => 'Terminé',
      };
 
  Color get color => switch (this) {
        ProjectStatus.pending               => AppColors.enAttente,
        ProjectStatus.validatedByReferent   => AppColors.enCours,
        ProjectStatus.refusedByReferent     => AppColors.refuse,
        ProjectStatus.transmittedToAdmin    => AppColors.sport,
        ProjectStatus.validatedByAdmin      => AppColors.valide,
        ProjectStatus.refusedByAdmin        => AppColors.refuse,
        ProjectStatus.visibleToPartners     => AppColors.culture,
        ProjectStatus.completed             => AppColors.brouillon,
      };
 
  /// Statuts considérés "actifs" pour la section "Mes projets"
  bool get isActive => switch (this) {
        ProjectStatus.pending             => true,
        ProjectStatus.validatedByReferent => true,
        ProjectStatus.transmittedToAdmin  => true,
        ProjectStatus.validatedByAdmin    => true,
        ProjectStatus.visibleToPartners   => true,
        _ => false,
      };
 
  bool get isRefused =>
      this == ProjectStatus.refusedByReferent ||
      this == ProjectStatus.refusedByAdmin;
}
 
// ── Project ───────────────────────────────────────────────────
// Aligné sur ProjectResponse.java + champs de validation (Project.java)
 
@freezed
class Project with _$Project {
  const Project._();
 
  const factory Project({
    required int id,
    required String title,
    required String description,
 
    @Default(ProjectStatus.pending) ProjectStatus status,
 
    /// Créateur du projet
    required int creatorId,
    String? creatorName,
 
    /// Groupe porteur (optionnel)
    int? groupId,
    String? groupName,
 
    // ── Validation référent ───────────────────────────────
    int? validatedByReferentId,
    String? referentValidationComment,
    DateTime? referentValidationDate,
 
    // ── Validation admin ──────────────────────────────────
    int? validatedByAdminId,
    String? adminValidationComment,
    DateTime? adminValidationDate,
 
    // ── Timestamps ────────────────────────────────────────
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Project;
 
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
 
// ── ProjectCreateRequest ──────────────────────────────────────
// Miroir de ProjectCreateRequest.java
 
@freezed
class ProjectCreateRequest with _$ProjectCreateRequest {
  const factory ProjectCreateRequest({
    required String title,
    required String description,
    int? groupId,
  }) = _ProjectCreateRequest;
 
  factory ProjectCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectCreateRequestFromJson(json);
}
 
// ── ProjectParticipationRequest ───────────────────────────────
// Nouveau — UML révisé : demande de participation à un projet existant
 
@freezed
class ProjectParticipationRequest with _$ProjectParticipationRequest {
  const factory ProjectParticipationRequest({
    required int projectId,
 
    /// Message de motivation (optionnel)
    String? message,
  }) = _ProjectParticipationRequest;
 
  factory ProjectParticipationRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectParticipationRequestFromJson(json);
}
 
// ── ProjectValidationRequest ──────────────────────────────────
// Corps envoyé par référent/admin pour valider ou refuser
 
@freezed
class ProjectValidationRequest with _$ProjectValidationRequest {
  const factory ProjectValidationRequest({
    required ProjectStatus newStatus,
    String? comment,
  }) = _ProjectValidationRequest;
 
  factory ProjectValidationRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectValidationRequestFromJson(json);
}
 