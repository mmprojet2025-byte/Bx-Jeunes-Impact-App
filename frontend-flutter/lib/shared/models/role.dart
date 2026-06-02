import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
 
import '../../core/theme/app_colors.dart';
 
@JsonEnum(valueField: 'jsonValue')
enum Role {
  @JsonValue('YOUTH')
  youth('YOUTH'),
 
  @JsonValue('GROUP_REFERENT')
  groupReferent('GROUP_REFERENT'),
 
  @JsonValue('ADMIN')
  admin('ADMIN'),
 
  @JsonValue('PARTNER')
  partner('PARTNER'),
 
  @JsonValue('SUPER_ADMIN')
  superAdmin('SUPER_ADMIN'),
 
  @JsonValue('PROJECT_MANAGER')
  projectManager('PROJECT_MANAGER');
 
  const Role(this.jsonValue);
 
  /// Valeur JSON envoyée/reçue du backend
  final String jsonValue;
 
  /// Label français pour l'UI
  String get label => switch (this) {
        Role.youth          => 'Jeune',
        Role.groupReferent  => 'Référent',
        Role.admin          => 'Admin',
        Role.partner        => 'Partenaire',
        Role.superAdmin     => 'Super Admin',
        Role.projectManager => 'Chef de projet',
      };
 
  /// Couleur associée pour les badges UI
  Color get color => switch (this) {
        Role.youth          => AppColors.roleYouth,
        Role.groupReferent  => AppColors.roleReferent,
        Role.admin          => AppColors.roleAdmin,
        Role.partner        => AppColors.rolePartner,
        Role.superAdmin     => AppColors.roleSuperAdmin,
        Role.projectManager => AppColors.roleProjectManager,
      };
 
  bool get isStaff =>
      this == Role.admin ||
      this == Role.superAdmin ||
      this == Role.groupReferent ||
      this == Role.projectManager;

  static Role fromString(String r) => Role.values.firstWhere(
    (e) => e.jsonValue == r.toUpperCase(),
    orElse: () => Role.youth,
  );
}

 