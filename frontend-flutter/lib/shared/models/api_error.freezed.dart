// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FieldError _$FieldErrorFromJson(Map<String, dynamic> json) {
  return _FieldError.fromJson(json);
}

/// @nodoc
mixin _$FieldError {
  String get field => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldErrorCopyWith<FieldError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldErrorCopyWith<$Res> {
  factory $FieldErrorCopyWith(
          FieldError value, $Res Function(FieldError) then) =
      _$FieldErrorCopyWithImpl<$Res, FieldError>;
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class _$FieldErrorCopyWithImpl<$Res, $Val extends FieldError>
    implements $FieldErrorCopyWith<$Res> {
  _$FieldErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldErrorImplCopyWith<$Res>
    implements $FieldErrorCopyWith<$Res> {
  factory _$$FieldErrorImplCopyWith(
          _$FieldErrorImpl value, $Res Function(_$FieldErrorImpl) then) =
      __$$FieldErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class __$$FieldErrorImplCopyWithImpl<$Res>
    extends _$FieldErrorCopyWithImpl<$Res, _$FieldErrorImpl>
    implements _$$FieldErrorImplCopyWith<$Res> {
  __$$FieldErrorImplCopyWithImpl(
      _$FieldErrorImpl _value, $Res Function(_$FieldErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_$FieldErrorImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldErrorImpl implements _FieldError {
  const _$FieldErrorImpl({required this.field, required this.message});

  factory _$FieldErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldErrorImplFromJson(json);

  @override
  final String field;
  @override
  final String message;

  @override
  String toString() {
    return 'FieldError(field: $field, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldErrorImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, field, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldErrorImplCopyWith<_$FieldErrorImpl> get copyWith =>
      __$$FieldErrorImplCopyWithImpl<_$FieldErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldErrorImplToJson(
      this,
    );
  }
}

abstract class _FieldError implements FieldError {
  const factory _FieldError(
      {required final String field,
      required final String message}) = _$FieldErrorImpl;

  factory _FieldError.fromJson(Map<String, dynamic> json) =
      _$FieldErrorImpl.fromJson;

  @override
  String get field;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$FieldErrorImplCopyWith<_$FieldErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return _ApiError.fromJson(json);
}

/// @nodoc
mixin _$ApiError {
  /// Timestamp ISO-8601 de l'erreur
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Code HTTP (400, 401, 403, 404, 409, 422, 500…)
  int get status => throw _privateConstructorUsedError;

  /// Libellé HTTP ("Not Found", "Unauthorized"…)
  String? get error => throw _privateConstructorUsedError;

  /// Code métier applicatif ("RESOURCE_NOT_FOUND", "VALIDATION_ERROR"…)
  String? get code => throw _privateConstructorUsedError;

  /// Message lisible par l'utilisateur
  String get message => throw _privateConstructorUsedError;

  /// Path de la requête ayant échoué
  String? get path => throw _privateConstructorUsedError;

  /// Erreurs de validation par champ (présentes uniquement sur 400/422)
  List<FieldError> get fieldErrors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiErrorCopyWith<ApiError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) then) =
      _$ApiErrorCopyWithImpl<$Res, ApiError>;
  @useResult
  $Res call(
      {DateTime? timestamp,
      int status,
      String? error,
      String? code,
      String message,
      String? path,
      List<FieldError> fieldErrors});
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res, $Val extends ApiError>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? status = null,
    Object? error = freezed,
    Object? code = freezed,
    Object? message = null,
    Object? path = freezed,
    Object? fieldErrors = null,
  }) {
    return _then(_value.copyWith(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldErrors: null == fieldErrors
          ? _value.fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as List<FieldError>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiErrorImplCopyWith<$Res>
    implements $ApiErrorCopyWith<$Res> {
  factory _$$ApiErrorImplCopyWith(
          _$ApiErrorImpl value, $Res Function(_$ApiErrorImpl) then) =
      __$$ApiErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? timestamp,
      int status,
      String? error,
      String? code,
      String message,
      String? path,
      List<FieldError> fieldErrors});
}

/// @nodoc
class __$$ApiErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ApiErrorImpl>
    implements _$$ApiErrorImplCopyWith<$Res> {
  __$$ApiErrorImplCopyWithImpl(
      _$ApiErrorImpl _value, $Res Function(_$ApiErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? status = null,
    Object? error = freezed,
    Object? code = freezed,
    Object? message = null,
    Object? path = freezed,
    Object? fieldErrors = null,
  }) {
    return _then(_$ApiErrorImpl(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldErrors: null == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as List<FieldError>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorImpl extends _ApiError {
  const _$ApiErrorImpl(
      {this.timestamp,
      required this.status,
      this.error,
      this.code,
      this.message = 'Une erreur est survenue',
      this.path,
      final List<FieldError> fieldErrors = const <FieldError>[]})
      : _fieldErrors = fieldErrors,
        super._();

  factory _$ApiErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorImplFromJson(json);

  /// Timestamp ISO-8601 de l'erreur
  @override
  final DateTime? timestamp;

  /// Code HTTP (400, 401, 403, 404, 409, 422, 500…)
  @override
  final int status;

  /// Libellé HTTP ("Not Found", "Unauthorized"…)
  @override
  final String? error;

  /// Code métier applicatif ("RESOURCE_NOT_FOUND", "VALIDATION_ERROR"…)
  @override
  final String? code;

  /// Message lisible par l'utilisateur
  @override
  @JsonKey()
  final String message;

  /// Path de la requête ayant échoué
  @override
  final String? path;

  /// Erreurs de validation par champ (présentes uniquement sur 400/422)
  final List<FieldError> _fieldErrors;

  /// Erreurs de validation par champ (présentes uniquement sur 400/422)
  @override
  @JsonKey()
  List<FieldError> get fieldErrors {
    if (_fieldErrors is EqualUnmodifiableListView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldErrors);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, status, error, code,
      message, path, const DeepCollectionEquality().hash(_fieldErrors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      __$$ApiErrorImplCopyWithImpl<_$ApiErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorImplToJson(
      this,
    );
  }
}

abstract class _ApiError extends ApiError {
  const factory _ApiError(
      {final DateTime? timestamp,
      required final int status,
      final String? error,
      final String? code,
      final String message,
      final String? path,
      final List<FieldError> fieldErrors}) = _$ApiErrorImpl;
  const _ApiError._() : super._();

  factory _ApiError.fromJson(Map<String, dynamic> json) =
      _$ApiErrorImpl.fromJson;

  @override

  /// Timestamp ISO-8601 de l'erreur
  DateTime? get timestamp;
  @override

  /// Code HTTP (400, 401, 403, 404, 409, 422, 500…)
  int get status;
  @override

  /// Libellé HTTP ("Not Found", "Unauthorized"…)
  String? get error;
  @override

  /// Code métier applicatif ("RESOURCE_NOT_FOUND", "VALIDATION_ERROR"…)
  String? get code;
  @override

  /// Message lisible par l'utilisateur
  String get message;
  @override

  /// Path de la requête ayant échoué
  String? get path;
  @override

  /// Erreurs de validation par champ (présentes uniquement sur 400/422)
  List<FieldError> get fieldErrors;
  @override
  @JsonKey(ignore: true)
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
