// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsImpl _$$NewsImplFromJson(Map<String, dynamic> json) => _$NewsImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      authorId: (json['authorId'] as num?)?.toInt(),
      authorName: json['authorName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      pinned: json['pinned'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$$NewsImplToJson(_$NewsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'imageUrl': instance.imageUrl,
      'pinned': instance.pinned,
      'createdAt': instance.createdAt?.toIso8601String(),
      'active': instance.active,
    };

_$NewsCreateRequestImpl _$$NewsCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NewsCreateRequestImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      pinned: json['pinned'] as bool? ?? false,
    );

Map<String, dynamic> _$$NewsCreateRequestImplToJson(
        _$NewsCreateRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'pinned': instance.pinned,
    };
