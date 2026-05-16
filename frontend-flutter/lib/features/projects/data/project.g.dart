part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      status: $enumDecodeNullable(_$ProjectStatusEnumMap, json['status']) ??
          ProjectStatus.pending,
      creatorId: (json['creatorId'] as num).toInt(),
      creatorName: json['creatorName'] as String?,
      groupId: (json['groupId'] as num?)?.toInt(),
      groupName: json['groupName'] as String?,
      validatedByReferentId: (json['validatedByReferentId'] as num?)?.toInt(),
      referentValidationComment: json['referentValidationComment'] as String?,
      referentValidationDate: json['referentValidationDate'] == null
          ? null
          : DateTime.parse(json['referentValidationDate'] as String),
      validatedByAdminId: (json['validatedByAdminId'] as num?)?.toInt(),
      adminValidationComment: json['adminValidationComment'] as String?,
      adminValidationDate: json['adminValidationDate'] == null
          ? null
          : DateTime.parse(json['adminValidationDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$ProjectStatusEnumMap[instance.status]!,
      'creatorId': instance.creatorId,
      'creatorName': instance.creatorName,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'validatedByReferentId': instance.validatedByReferentId,
      'referentValidationComment': instance.referentValidationComment,
      'referentValidationDate':
          instance.referentValidationDate?.toIso8601String(),
      'validatedByAdminId': instance.validatedByAdminId,
      'adminValidationComment': instance.adminValidationComment,
      'adminValidationDate': instance.adminValidationDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ProjectStatusEnumMap = {
  ProjectStatus.pending: 'PENDING',
  ProjectStatus.validatedByReferent: 'VALIDATED_BY_REFERENT',
  ProjectStatus.refusedByReferent: 'REFUSED_BY_REFERENT',
  ProjectStatus.transmittedToAdmin: 'TRANSMITTED_TO_ADMIN',
  ProjectStatus.validatedByAdmin: 'VALIDATED_BY_ADMIN',
  ProjectStatus.refusedByAdmin: 'REFUSED_BY_ADMIN',
  ProjectStatus.visibleToPartners: 'VISIBLE_TO_PARTNERS',
  ProjectStatus.completed: 'COMPLETED',
};

_$ProjectCreateRequestImpl _$$ProjectCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectCreateRequestImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      groupId: (json['groupId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProjectCreateRequestImplToJson(
        _$ProjectCreateRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'groupId': instance.groupId,
    };

_$ProjectParticipationRequestImpl _$$ProjectParticipationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectParticipationRequestImpl(
      projectId: (json['projectId'] as num).toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ProjectParticipationRequestImplToJson(
        _$ProjectParticipationRequestImpl instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'message': instance.message,
    };

_$ProjectValidationRequestImpl _$$ProjectValidationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectValidationRequestImpl(
      newStatus: $enumDecode(_$ProjectStatusEnumMap, json['newStatus']),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$ProjectValidationRequestImplToJson(
        _$ProjectValidationRequestImpl instance) =>
    <String, dynamic>{
      'newStatus': _$ProjectStatusEnumMap[instance.newStatus]!,
      'comment': instance.comment,
    };
