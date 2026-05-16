part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$RoleEnumMap, e))
              .toSet() ??
          const <Role>{},
      groupId: (json['groupId'] as num?)?.toInt(),
      groupName: json['groupName'] as String?,
      active: json['active'] as bool? ?? true,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      parentalConsent: json['parentalConsent'] as bool? ?? false,
      parentEmail: json['parentEmail'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'active': instance.active,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'parentalConsent': instance.parentalConsent,
      'parentEmail': instance.parentEmail,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RoleEnumMap = {
  Role.youth: 'YOUTH',
  Role.groupReferent: 'GROUP_REFERENT',
  Role.admin: 'ADMIN',
  Role.partner: 'PARTNER',
  Role.superAdmin: 'SUPER_ADMIN',
  Role.projectManager: 'PROJECT_MANAGER',
};
