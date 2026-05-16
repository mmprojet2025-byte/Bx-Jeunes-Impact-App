part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FieldErrorImpl _$$FieldErrorImplFromJson(Map<String, dynamic> json) =>
    _$FieldErrorImpl(
      field: json['field'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$FieldErrorImplToJson(_$FieldErrorImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      status: (json['status'] as num).toInt(),
      error: json['error'] as String?,
      code: json['code'] as String?,
      message: json['message'] as String? ?? 'Une erreur est survenue',
      path: json['path'] as String?,
      fieldErrors: (json['fieldErrors'] as List<dynamic>?)
              ?.map((e) => FieldError.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FieldError>[],
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'status': instance.status,
      'error': instance.error,
      'code': instance.code,
      'message': instance.message,
      'path': instance.path,
      'fieldErrors': instance.fieldErrors,
    };
