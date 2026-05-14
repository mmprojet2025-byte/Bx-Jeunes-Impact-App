// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      category: $enumDecode(_$ActivityCategoryEnumMap, json['category']),
      groupId: (json['groupId'] as num?)?.toInt(),
      groupName: json['groupName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'category': _$ActivityCategoryEnumMap[instance.category]!,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'active': instance.active,
    };

const _$ActivityCategoryEnumMap = {
  ActivityCategory.workshop: 'WORKSHOP',
  ActivityCategory.training: 'TRAINING',
  ActivityCategory.meeting: 'MEETING',
  ActivityCategory.outing: 'OUTING',
  ActivityCategory.event: 'EVENT',
  ActivityCategory.other: 'OTHER',
};

_$RegistrationImpl _$$RegistrationImplFromJson(Map<String, dynamic> json) =>
    _$RegistrationImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      activity: Activity.fromJson(json['activity'] as Map<String, dynamic>),
      registrationDate: json['registrationDate'] == null
          ? null
          : DateTime.parse(json['registrationDate'] as String),
      status:
          $enumDecodeNullable(_$RegistrationStatusEnumMap, json['status']) ??
              RegistrationStatus.registered,
    );

Map<String, dynamic> _$$RegistrationImplToJson(_$RegistrationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'activity': instance.activity,
      'registrationDate': instance.registrationDate?.toIso8601String(),
      'status': _$RegistrationStatusEnumMap[instance.status]!,
    };

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.registered: 'REGISTERED',
  RegistrationStatus.cancelled: 'CANCELLED',
  RegistrationStatus.attended: 'ATTENDED',
  RegistrationStatus.noShow: 'NO_SHOW',
};
