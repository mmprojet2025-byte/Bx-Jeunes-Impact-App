// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerImpl _$$PartnerImplFromJson(Map<String, dynamic> json) =>
    _$PartnerImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      level: $enumDecodeNullable(_$PartnerLevelEnumMap, json['level']) ??
          PartnerLevel.simple,
      logoUrl: json['logoUrl'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PartnerImplToJson(_$PartnerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'level': _$PartnerLevelEnumMap[instance.level]!,
      'logoUrl': instance.logoUrl,
      'websiteUrl': instance.websiteUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$PartnerLevelEnumMap = {
  PartnerLevel.simple: 'SIMPLE',
  PartnerLevel.sponsor: 'SPONSOR',
  PartnerLevel.strategic: 'STRATEGIC',
};

_$SponsoringImpl _$$SponsoringImplFromJson(Map<String, dynamic> json) =>
    _$SponsoringImpl(
      id: (json['id'] as num).toInt(),
      partnerId: (json['partnerId'] as num).toInt(),
      partnerName: json['partnerName'] as String?,
      projectId: (json['projectId'] as num?)?.toInt(),
      projectTitle: json['projectTitle'] as String?,
      activityId: (json['activityId'] as num?)?.toInt(),
      activityName: json['activityName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      materialSupport: json['materialSupport'] as String?,
      status: $enumDecodeNullable(_$SponsoringStatusEnumMap, json['status']) ??
          SponsoringStatus.pending,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SponsoringImplToJson(_$SponsoringImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partnerId': instance.partnerId,
      'partnerName': instance.partnerName,
      'projectId': instance.projectId,
      'projectTitle': instance.projectTitle,
      'activityId': instance.activityId,
      'activityName': instance.activityName,
      'amount': instance.amount,
      'materialSupport': instance.materialSupport,
      'status': _$SponsoringStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SponsoringStatusEnumMap = {
  SponsoringStatus.pending: 'PENDING',
  SponsoringStatus.confirmed: 'CONFIRMED',
  SponsoringStatus.cancelled: 'CANCELLED',
};

_$PartnerCreateRequestImpl _$$PartnerCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerCreateRequestImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      level: $enumDecodeNullable(_$PartnerLevelEnumMap, json['level']) ??
          PartnerLevel.simple,
      logoUrl: json['logoUrl'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
    );

Map<String, dynamic> _$$PartnerCreateRequestImplToJson(
        _$PartnerCreateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'level': _$PartnerLevelEnumMap[instance.level]!,
      'logoUrl': instance.logoUrl,
      'websiteUrl': instance.websiteUrl,
    };
