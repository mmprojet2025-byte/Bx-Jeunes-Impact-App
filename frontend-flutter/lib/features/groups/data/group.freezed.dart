// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  int get id => throw _privateConstructorUsedError;

  /// Nom du groupe (max 150 chars)
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// ID du référent responsable (null si pas encore assigné)
  int? get referentId => throw _privateConstructorUsedError;
  String? get referentName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Nombre de membres (calculé côté backend, optionnel dans la réponse)
  int? get memberCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      int? referentId,
      String? referentName,
      DateTime? createdAt,
      bool active,
      int? memberCount});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? referentId = freezed,
    Object? referentName = freezed,
    Object? createdAt = freezed,
    Object? active = null,
    Object? memberCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      referentId: freezed == referentId
          ? _value.referentId
          : referentId // ignore: cast_nullable_to_non_nullable
              as int?,
      referentName: freezed == referentName
          ? _value.referentName
          : referentName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      memberCount: freezed == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      int? referentId,
      String? referentName,
      DateTime? createdAt,
      bool active,
      int? memberCount});
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? referentId = freezed,
    Object? referentName = freezed,
    Object? createdAt = freezed,
    Object? active = null,
    Object? memberCount = freezed,
  }) {
    return _then(_$GroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      referentId: freezed == referentId
          ? _value.referentId
          : referentId // ignore: cast_nullable_to_non_nullable
              as int?,
      referentName: freezed == referentName
          ? _value.referentName
          : referentName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      memberCount: freezed == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupImpl extends _Group {
  const _$GroupImpl(
      {required this.id,
      required this.name,
      this.description,
      this.referentId,
      this.referentName,
      this.createdAt,
      this.active = true,
      this.memberCount})
      : super._();

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  @override
  final int id;

  /// Nom du groupe (max 150 chars)
  @override
  final String name;
  @override
  final String? description;

  /// ID du référent responsable (null si pas encore assigné)
  @override
  final int? referentId;
  @override
  final String? referentName;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey()
  final bool active;

  /// Nombre de membres (calculé côté backend, optionnel dans la réponse)
  @override
  final int? memberCount;

  @override
  String toString() {
    return 'Group(id: $id, name: $name, description: $description, referentId: $referentId, referentName: $referentName, createdAt: $createdAt, active: $active, memberCount: $memberCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.referentId, referentId) ||
                other.referentId == referentId) &&
            (identical(other.referentName, referentName) ||
                other.referentName == referentName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      referentId, referentName, createdAt, active, memberCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class _Group extends Group {
  const factory _Group(
      {required final int id,
      required final String name,
      final String? description,
      final int? referentId,
      final String? referentName,
      final DateTime? createdAt,
      final bool active,
      final int? memberCount}) = _$GroupImpl;
  const _Group._() : super._();

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  int get id;
  @override

  /// Nom du groupe (max 150 chars)
  String get name;
  @override
  String? get description;
  @override

  /// ID du référent responsable (null si pas encore assigné)
  int? get referentId;
  @override
  String? get referentName;
  @override
  DateTime? get createdAt;
  @override
  bool get active;
  @override

  /// Nombre de membres (calculé côté backend, optionnel dans la réponse)
  int? get memberCount;
  @override
  @JsonKey(ignore: true)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupCreateRequest _$GroupCreateRequestFromJson(Map<String, dynamic> json) {
  return _GroupCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$GroupCreateRequest {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get referentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCreateRequestCopyWith<GroupCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCreateRequestCopyWith<$Res> {
  factory $GroupCreateRequestCopyWith(
          GroupCreateRequest value, $Res Function(GroupCreateRequest) then) =
      _$GroupCreateRequestCopyWithImpl<$Res, GroupCreateRequest>;
  @useResult
  $Res call({String name, String? description, int? referentId});
}

/// @nodoc
class _$GroupCreateRequestCopyWithImpl<$Res, $Val extends GroupCreateRequest>
    implements $GroupCreateRequestCopyWith<$Res> {
  _$GroupCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? referentId = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      referentId: freezed == referentId
          ? _value.referentId
          : referentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupCreateRequestImplCopyWith<$Res>
    implements $GroupCreateRequestCopyWith<$Res> {
  factory _$$GroupCreateRequestImplCopyWith(_$GroupCreateRequestImpl value,
          $Res Function(_$GroupCreateRequestImpl) then) =
      __$$GroupCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description, int? referentId});
}

/// @nodoc
class __$$GroupCreateRequestImplCopyWithImpl<$Res>
    extends _$GroupCreateRequestCopyWithImpl<$Res, _$GroupCreateRequestImpl>
    implements _$$GroupCreateRequestImplCopyWith<$Res> {
  __$$GroupCreateRequestImplCopyWithImpl(_$GroupCreateRequestImpl _value,
      $Res Function(_$GroupCreateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? referentId = freezed,
  }) {
    return _then(_$GroupCreateRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      referentId: freezed == referentId
          ? _value.referentId
          : referentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupCreateRequestImpl implements _GroupCreateRequest {
  const _$GroupCreateRequestImpl(
      {required this.name, this.description, this.referentId});

  factory _$GroupCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupCreateRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final int? referentId;

  @override
  String toString() {
    return 'GroupCreateRequest(name: $name, description: $description, referentId: $referentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupCreateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.referentId, referentId) ||
                other.referentId == referentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, referentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupCreateRequestImplCopyWith<_$GroupCreateRequestImpl> get copyWith =>
      __$$GroupCreateRequestImplCopyWithImpl<_$GroupCreateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _GroupCreateRequest implements GroupCreateRequest {
  const factory _GroupCreateRequest(
      {required final String name,
      final String? description,
      final int? referentId}) = _$GroupCreateRequestImpl;

  factory _GroupCreateRequest.fromJson(Map<String, dynamic> json) =
      _$GroupCreateRequestImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  int? get referentId;
  @override
  @JsonKey(ignore: true)
  _$$GroupCreateRequestImplCopyWith<_$GroupCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
