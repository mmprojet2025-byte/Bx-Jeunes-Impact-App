// Miroir de UserResponse.java + champs RGPD (dateOfBirth, parentalConsent)
// anticipant l'UML révisé à venir.
//
// Génération :
//   flutter pub run build_runner build --delete-conflicting-outputs
 
import 'package:freezed_annotation/freezed_annotation.dart';
 
import 'role.dart';
 
part 'user.freezed.dart';
part 'user.g.dart';
 
@freezed
class AppUser with _$AppUser {
  const AppUser._(); // ← permet d'ajouter des méthodes dans l'extension
 
  const factory AppUser({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
 
    /// Ensemble des rôles — miroir de Set<Role> côté backend
    @Default(<Role>{}) Set<Role> roles,
 
    /// Groupe de rattachement (null si pas encore assigné)
    int? groupId,
    String? groupName,
 
    /// Soft delete : false = compte désactivé
    @Default(true) bool active,
 
    // ── Champs RGPD (UML révisé) ──────────────────────────
    /// Date de naissance — requis pour vérifier la minorité
    DateTime? dateOfBirth,
 
    /// Consentement parental (obligatoire pour les mineurs)
    @Default(false) bool parentalConsent,
 
    /// Email du parent/tuteur (si mineur)
    String? parentEmail,
 
    // ── Timestamps ────────────────────────────────────────
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AppUser;
 
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
 
  // ── Computed properties ───────────────────────────────────
 
  /// "Jean D."
  String get displayName => '$firstName ${lastName[0].toUpperCase()}.';
 
  /// "JD" pour l'avatar initiales
  String get initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty  ? lastName[0].toUpperCase()  : '';
    return '$f$l';
  }
 
  String get fullName => '$firstName $lastName';
 
  bool hasRole(Role r) => roles.contains(r);
  bool get isAdmin        => roles.contains(Role.admin) || roles.contains(Role.superAdmin);
  bool get isReferent     => roles.contains(Role.groupReferent);
  bool get isYouth        => roles.contains(Role.youth);
  bool get isPartner      => roles.contains(Role.partner);
 
  /// Rôle principal affiché dans l'UI (priorité : superAdmin > admin > referent > pm > partner > youth)
  Role get primaryRole {
    if (roles.contains(Role.superAdmin))     return Role.superAdmin;
    if (roles.contains(Role.admin))          return Role.admin;
    if (roles.contains(Role.groupReferent))  return Role.groupReferent;
    if (roles.contains(Role.projectManager)) return Role.projectManager;
    if (roles.contains(Role.partner))        return Role.partner;
    return Role.youth;
  }
 
  /// Vrai si l'utilisateur a moins de 18 ans
  bool get isMinor {
    if (dateOfBirth == null) return false;
    final now  = DateTime.now();
    final age  = now.year - dateOfBirth!.year;
    final hadBirthday = now.month > dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day >= dateOfBirth!.day);
    return (hadBirthday ? age : age - 1) < 18;
  }
}
