// Miroir de Group.java.
// Un groupe est animé par un référent et regroupe plusieurs jeunes.
 
import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'group.freezed.dart';
part 'group.g.dart';
 
@freezed
class Group with _$Group {
  const Group._();
 
  const factory Group({
    required int id,
 
    /// Nom du groupe (max 150 chars)
    required String name,
 
    String? description,
 
    /// ID du référent responsable (null si pas encore assigné)
    int? referentId,
    String? referentName,
 
    DateTime? createdAt,
 
    @Default(true) bool active,
 
    /// Nombre de membres (calculé côté backend, optionnel dans la réponse)
    int? memberCount,
  }) = _Group;
 
  factory Group.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);
 
  bool get hasReferent => referentId != null;
}
 
// ── GroupCreateRequest ────────────────────────────────────────
 
@freezed
class GroupCreateRequest with _$GroupCreateRequest {
  const factory GroupCreateRequest({
    required String name,
    String? description,
    int? referentId,
  }) = _GroupCreateRequest;
 
  factory GroupCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$GroupCreateRequestFromJson(json);
}
 