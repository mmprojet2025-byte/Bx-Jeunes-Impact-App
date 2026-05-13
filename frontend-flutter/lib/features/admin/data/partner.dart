// Modèles pour la feature Admin — Partenaires & Sponsoring (préparation V2).
//
// Entités backend mirrorées :
//   Partner.java     → Partner
//   PartnerLevel.java → PartnerLevel (enum)
//   Sponsoring.java  → Sponsoring
 
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'partner.freezed.dart';
part 'partner.g.dart';
 
// ── Enum PartnerLevel ─────────────────────────────────────────
// Miroir exact de PartnerLevel.java
 
@JsonEnum(valueField: 'jsonValue')
enum PartnerLevel {
  @JsonValue('SIMPLE')
  simple('SIMPLE'),
 
  @JsonValue('SPONSOR')
  sponsor('SPONSOR'),
 
  @JsonValue('STRATEGIC')
  strategic('STRATEGIC');
 
  const PartnerLevel(this.jsonValue);
  final String jsonValue;
 
  String get label => switch (this) {
        PartnerLevel.simple    => 'Partenaire',
        PartnerLevel.sponsor   => 'Sponsor',
        PartnerLevel.strategic => 'Partenaire stratégique',
      };
}
 
// ── Enum SponsoringStatus ─────────────────────────────────────
// Miroir du champ status String de Sponsoring.java
// Le backend utilise une String libre — on la type ici côté Flutter
 
@JsonEnum(valueField: 'jsonValue')
enum SponsoringStatus {
  @JsonValue('PENDING')
  pending('PENDING'),
 
  @JsonValue('CONFIRMED')
  confirmed('CONFIRMED'),
 
  @JsonValue('CANCELLED')
  cancelled('CANCELLED');
 
  const SponsoringStatus(this.jsonValue);
  final String jsonValue;
 
  String get label => switch (this) {
        SponsoringStatus.pending   => 'En attente',
        SponsoringStatus.confirmed => 'Confirmé',
        SponsoringStatus.cancelled => 'Annulé',
      };
}
 
// ── Partner ───────────────────────────────────────────────────
// Miroir de Partner.java
 
@freezed
class Partner with _$Partner {
  const Partner._();
 
  const factory Partner({
    required int id,
 
    /// Nom de l'organisation partenaire
    required String name,
 
    String? description,
 
    @Default(PartnerLevel.simple) PartnerLevel level,
 
    /// URL logo (pas dans l'entité backend actuelle — anticipation V2)
    String? logoUrl,
 
    /// Site web (anticipation V2)
    String? websiteUrl,
 
    DateTime? createdAt,
  }) = _Partner;
 
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
}
 
// ── Sponsoring ────────────────────────────────────────────────
// Miroir de Sponsoring.java
// Un sponsoring lie un Partner à un Project OU une Activity (pas les deux à la fois).
 
@freezed
class Sponsoring with _$Sponsoring {
  const Sponsoring._();
 
  const factory Sponsoring({
    required int id,
 
    required int partnerId,
    String? partnerName,
 
    /// Projet sponsorisé (null si c'est une activité)
    int? projectId,
    String? projectTitle,
 
    /// Activité sponsorisée (null si c'est un projet)
    int? activityId,
    String? activityName,
 
    /// Montant financier (optionnel — peut être du soutien matériel)
    double? amount,
 
    /// Description du soutien matériel (local, matériel, etc.)
    String? materialSupport,
 
    @Default(SponsoringStatus.pending) SponsoringStatus status,
 
    DateTime? createdAt,
  }) = _Sponsoring;
 
  factory Sponsoring.fromJson(Map<String, dynamic> json) =>
      _$SponsoringFromJson(json);
 
  /// Vrai si ce sponsoring concerne un projet
  bool get isForProject  => projectId != null;
 
  /// Vrai si ce sponsoring concerne une activité
  bool get isForActivity => activityId != null;
}
 
// ── PartnerCreateRequest ──────────────────────────────────────
 
@freezed
class PartnerCreateRequest with _$PartnerCreateRequest {
  const factory PartnerCreateRequest({
    required String name,
    String? description,
    @Default(PartnerLevel.simple) PartnerLevel level,
    String? logoUrl,
    String? websiteUrl,
  }) = _PartnerCreateRequest;
 
  factory PartnerCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PartnerCreateRequestFromJson(json);
}