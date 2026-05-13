// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      referentId: (json['referentId'] as num?)?.toInt(),
      referentName: json['referentName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      active: json['active'] as bool? ?? true,
      memberCount: (json['memberCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'referentId': instance.referentId,
      'referentName': instance.referentName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'active': instance.active,
      'memberCount': instance.memberCount,
    };

_$GroupCreateRequestImpl _$$GroupCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupCreateRequestImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      referentId: (json['referentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GroupCreateRequestImplToJson(
        _$GroupCreateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'referentId': instance.referentId,
    };
