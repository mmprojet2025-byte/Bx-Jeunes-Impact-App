// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ProjectStatus get status => throw _privateConstructorUsedError;

  /// Créateur du projet
  int get creatorId => throw _privateConstructorUsedError;
  String? get creatorName => throw _privateConstructorUsedError;

  /// Groupe porteur (optionnel)
  int? get groupId => throw _privateConstructorUsedError;
  String? get groupName =>
      throw _privateConstructorUsedError; // ── Validation référent ───────────────────────────────
  int? get validatedByReferentId => throw _privateConstructorUsedError;
  String? get referentValidationComment => throw _privateConstructorUsedError;
  DateTime? get referentValidationDate =>
      throw _privateConstructorUsedError; // ── Validation admin ──────────────────────────────────
  int? get validatedByAdminId => throw _privateConstructorUsedError;
  String? get adminValidationComment => throw _privateConstructorUsedError;
  DateTime? get adminValidationDate =>
      throw _privateConstructorUsedError; // ── Timestamps ────────────────────────────────────────
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      ProjectStatus status,
      int creatorId,
      String? creatorName,
      int? groupId,
      String? groupName,
      int? validatedByReferentId,
      String? referentValidationComment,
      DateTime? referentValidationDate,
      int? validatedByAdminId,
      String? adminValidationComment,
      DateTime? adminValidationDate,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? creatorId = null,
    Object? creatorName = freezed,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? validatedByReferentId = freezed,
    Object? referentValidationComment = freezed,
    Object? referentValidationDate = freezed,
    Object? validatedByAdminId = freezed,
    Object? adminValidationComment = freezed,
    Object? adminValidationDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as int,
      creatorName: freezed == creatorName
          ? _value.creatorName
          : creatorName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      validatedByReferentId: freezed == validatedByReferentId
          ? _value.validatedByReferentId
          : validatedByReferentId // ignore: cast_nullable_to_non_nullable
              as int?,
      referentValidationComment: freezed == referentValidationComment
          ? _value.referentValidationComment
          : referentValidationComment // ignore: cast_nullable_to_non_nullable
              as String?,
      referentValidationDate: freezed == referentValidationDate
          ? _value.referentValidationDate
          : referentValidationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validatedByAdminId: freezed == validatedByAdminId
          ? _value.validatedByAdminId
          : validatedByAdminId // ignore: cast_nullable_to_non_nullable
              as int?,
      adminValidationComment: freezed == adminValidationComment
          ? _value.adminValidationComment
          : adminValidationComment // ignore: cast_nullable_to_non_nullable
              as String?,
      adminValidationDate: freezed == adminValidationDate
          ? _value.adminValidationDate
          : adminValidationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
          _$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      ProjectStatus status,
      int creatorId,
      String? creatorName,
      int? groupId,
      String? groupName,
      int? validatedByReferentId,
      String? referentValidationComment,
      DateTime? referentValidationDate,
      int? validatedByAdminId,
      String? adminValidationComment,
      DateTime? adminValidationDate,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
      _$ProjectImpl _value, $Res Function(_$ProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? creatorId = null,
    Object? creatorName = freezed,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? validatedByReferentId = freezed,
    Object? referentValidationComment = freezed,
    Object? referentValidationDate = freezed,
    Object? validatedByAdminId = freezed,
    Object? adminValidationComment = freezed,
    Object? adminValidationDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ProjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as int,
      creatorName: freezed == creatorName
          ? _value.creatorName
          : creatorName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      validatedByReferentId: freezed == validatedByReferentId
          ? _value.validatedByReferentId
          : validatedByReferentId // ignore: cast_nullable_to_non_nullable
              as int?,
      referentValidationComment: freezed == referentValidationComment
          ? _value.referentValidationComment
          : referentValidationComment // ignore: cast_nullable_to_non_nullable
              as String?,
      referentValidationDate: freezed == referentValidationDate
          ? _value.referentValidationDate
          : referentValidationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validatedByAdminId: freezed == validatedByAdminId
          ? _value.validatedByAdminId
          : validatedByAdminId // ignore: cast_nullable_to_non_nullable
              as int?,
      adminValidationComment: freezed == adminValidationComment
          ? _value.adminValidationComment
          : adminValidationComment // ignore: cast_nullable_to_non_nullable
              as String?,
      adminValidationDate: freezed == adminValidationDate
          ? _value.adminValidationDate
          : adminValidationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl extends _Project {
  const _$ProjectImpl(
      {required this.id,
      required this.title,
      required this.description,
      this.status = ProjectStatus.pending,
      required this.creatorId,
      this.creatorName,
      this.groupId,
      this.groupName,
      this.validatedByReferentId,
      this.referentValidationComment,
      this.referentValidationDate,
      this.validatedByAdminId,
      this.adminValidationComment,
      this.adminValidationDate,
      this.createdAt,
      this.updatedAt})
      : super._();

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final ProjectStatus status;

  /// Créateur du projet
  @override
  final int creatorId;
  @override
  final String? creatorName;

  /// Groupe porteur (optionnel)
  @override
  final int? groupId;
  @override
  final String? groupName;
// ── Validation référent ───────────────────────────────
  @override
  final int? validatedByReferentId;
  @override
  final String? referentValidationComment;
  @override
  final DateTime? referentValidationDate;
// ── Validation admin ──────────────────────────────────
  @override
  final int? validatedByAdminId;
  @override
  final String? adminValidationComment;
  @override
  final DateTime? adminValidationDate;
// ── Timestamps ────────────────────────────────────────
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Project(id: $id, title: $title, description: $description, status: $status, creatorId: $creatorId, creatorName: $creatorName, groupId: $groupId, groupName: $groupName, validatedByReferentId: $validatedByReferentId, referentValidationComment: $referentValidationComment, referentValidationDate: $referentValidationDate, validatedByAdminId: $validatedByAdminId, adminValidationComment: $adminValidationComment, adminValidationDate: $adminValidationDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.creatorName, creatorName) ||
                other.creatorName == creatorName) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.validatedByReferentId, validatedByReferentId) ||
                other.validatedByReferentId == validatedByReferentId) &&
            (identical(other.referentValidationComment,
                    referentValidationComment) ||
                other.referentValidationComment == referentValidationComment) &&
            (identical(other.referentValidationDate, referentValidationDate) ||
                other.referentValidationDate == referentValidationDate) &&
            (identical(other.validatedByAdminId, validatedByAdminId) ||
                other.validatedByAdminId == validatedByAdminId) &&
            (identical(other.adminValidationComment, adminValidationComment) ||
                other.adminValidationComment == adminValidationComment) &&
            (identical(other.adminValidationDate, adminValidationDate) ||
                other.adminValidationDate == adminValidationDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      status,
      creatorId,
      creatorName,
      groupId,
      groupName,
      validatedByReferentId,
      referentValidationComment,
      referentValidationDate,
      validatedByAdminId,
      adminValidationComment,
      adminValidationDate,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(
      this,
    );
  }
}

abstract class _Project extends Project {
  const factory _Project(
      {required final int id,
      required final String title,
      required final String description,
      final ProjectStatus status,
      required final int creatorId,
      final String? creatorName,
      final int? groupId,
      final String? groupName,
      final int? validatedByReferentId,
      final String? referentValidationComment,
      final DateTime? referentValidationDate,
      final int? validatedByAdminId,
      final String? adminValidationComment,
      final DateTime? adminValidationDate,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ProjectImpl;
  const _Project._() : super._();

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  ProjectStatus get status;
  @override

  /// Créateur du projet
  int get creatorId;
  @override
  String? get creatorName;
  @override

  /// Groupe porteur (optionnel)
  int? get groupId;
  @override
  String? get groupName;
  @override // ── Validation référent ───────────────────────────────
  int? get validatedByReferentId;
  @override
  String? get referentValidationComment;
  @override
  DateTime? get referentValidationDate;
  @override // ── Validation admin ──────────────────────────────────
  int? get validatedByAdminId;
  @override
  String? get adminValidationComment;
  @override
  DateTime? get adminValidationDate;
  @override // ── Timestamps ────────────────────────────────────────
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectCreateRequest _$ProjectCreateRequestFromJson(Map<String, dynamic> json) {
  return _ProjectCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$ProjectCreateRequest {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get groupId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCreateRequestCopyWith<ProjectCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCreateRequestCopyWith<$Res> {
  factory $ProjectCreateRequestCopyWith(ProjectCreateRequest value,
          $Res Function(ProjectCreateRequest) then) =
      _$ProjectCreateRequestCopyWithImpl<$Res, ProjectCreateRequest>;
  @useResult
  $Res call({String title, String description, int? groupId});
}

/// @nodoc
class _$ProjectCreateRequestCopyWithImpl<$Res,
        $Val extends ProjectCreateRequest>
    implements $ProjectCreateRequestCopyWith<$Res> {
  _$ProjectCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? groupId = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectCreateRequestImplCopyWith<$Res>
    implements $ProjectCreateRequestCopyWith<$Res> {
  factory _$$ProjectCreateRequestImplCopyWith(_$ProjectCreateRequestImpl value,
          $Res Function(_$ProjectCreateRequestImpl) then) =
      __$$ProjectCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String description, int? groupId});
}

/// @nodoc
class __$$ProjectCreateRequestImplCopyWithImpl<$Res>
    extends _$ProjectCreateRequestCopyWithImpl<$Res, _$ProjectCreateRequestImpl>
    implements _$$ProjectCreateRequestImplCopyWith<$Res> {
  __$$ProjectCreateRequestImplCopyWithImpl(_$ProjectCreateRequestImpl _value,
      $Res Function(_$ProjectCreateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? groupId = freezed,
  }) {
    return _then(_$ProjectCreateRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectCreateRequestImpl implements _ProjectCreateRequest {
  const _$ProjectCreateRequestImpl(
      {required this.title, required this.description, this.groupId});

  factory _$ProjectCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectCreateRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final int? groupId;

  @override
  String toString() {
    return 'ProjectCreateRequest(title: $title, description: $description, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectCreateRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, groupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectCreateRequestImplCopyWith<_$ProjectCreateRequestImpl>
      get copyWith =>
          __$$ProjectCreateRequestImplCopyWithImpl<_$ProjectCreateRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _ProjectCreateRequest implements ProjectCreateRequest {
  const factory _ProjectCreateRequest(
      {required final String title,
      required final String description,
      final int? groupId}) = _$ProjectCreateRequestImpl;

  factory _ProjectCreateRequest.fromJson(Map<String, dynamic> json) =
      _$ProjectCreateRequestImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  int? get groupId;
  @override
  @JsonKey(ignore: true)
  _$$ProjectCreateRequestImplCopyWith<_$ProjectCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProjectParticipationRequest _$ProjectParticipationRequestFromJson(
    Map<String, dynamic> json) {
  return _ProjectParticipationRequest.fromJson(json);
}

/// @nodoc
mixin _$ProjectParticipationRequest {
  int get projectId => throw _privateConstructorUsedError;

  /// Message de motivation (optionnel)
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectParticipationRequestCopyWith<ProjectParticipationRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectParticipationRequestCopyWith<$Res> {
  factory $ProjectParticipationRequestCopyWith(
          ProjectParticipationRequest value,
          $Res Function(ProjectParticipationRequest) then) =
      _$ProjectParticipationRequestCopyWithImpl<$Res,
          ProjectParticipationRequest>;
  @useResult
  $Res call({int projectId, String? message});
}

/// @nodoc
class _$ProjectParticipationRequestCopyWithImpl<$Res,
        $Val extends ProjectParticipationRequest>
    implements $ProjectParticipationRequestCopyWith<$Res> {
  _$ProjectParticipationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectParticipationRequestImplCopyWith<$Res>
    implements $ProjectParticipationRequestCopyWith<$Res> {
  factory _$$ProjectParticipationRequestImplCopyWith(
          _$ProjectParticipationRequestImpl value,
          $Res Function(_$ProjectParticipationRequestImpl) then) =
      __$$ProjectParticipationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int projectId, String? message});
}

/// @nodoc
class __$$ProjectParticipationRequestImplCopyWithImpl<$Res>
    extends _$ProjectParticipationRequestCopyWithImpl<$Res,
        _$ProjectParticipationRequestImpl>
    implements _$$ProjectParticipationRequestImplCopyWith<$Res> {
  __$$ProjectParticipationRequestImplCopyWithImpl(
      _$ProjectParticipationRequestImpl _value,
      $Res Function(_$ProjectParticipationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? message = freezed,
  }) {
    return _then(_$ProjectParticipationRequestImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectParticipationRequestImpl
    implements _ProjectParticipationRequest {
  const _$ProjectParticipationRequestImpl(
      {required this.projectId, this.message});

  factory _$ProjectParticipationRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProjectParticipationRequestImplFromJson(json);

  @override
  final int projectId;

  /// Message de motivation (optionnel)
  @override
  final String? message;

  @override
  String toString() {
    return 'ProjectParticipationRequest(projectId: $projectId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectParticipationRequestImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, projectId, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectParticipationRequestImplCopyWith<_$ProjectParticipationRequestImpl>
      get copyWith => __$$ProjectParticipationRequestImplCopyWithImpl<
          _$ProjectParticipationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectParticipationRequestImplToJson(
      this,
    );
  }
}

abstract class _ProjectParticipationRequest
    implements ProjectParticipationRequest {
  const factory _ProjectParticipationRequest(
      {required final int projectId,
      final String? message}) = _$ProjectParticipationRequestImpl;

  factory _ProjectParticipationRequest.fromJson(Map<String, dynamic> json) =
      _$ProjectParticipationRequestImpl.fromJson;

  @override
  int get projectId;
  @override

  /// Message de motivation (optionnel)
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ProjectParticipationRequestImplCopyWith<_$ProjectParticipationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProjectValidationRequest _$ProjectValidationRequestFromJson(
    Map<String, dynamic> json) {
  return _ProjectValidationRequest.fromJson(json);
}

/// @nodoc
mixin _$ProjectValidationRequest {
  ProjectStatus get newStatus => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectValidationRequestCopyWith<ProjectValidationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectValidationRequestCopyWith<$Res> {
  factory $ProjectValidationRequestCopyWith(ProjectValidationRequest value,
          $Res Function(ProjectValidationRequest) then) =
      _$ProjectValidationRequestCopyWithImpl<$Res, ProjectValidationRequest>;
  @useResult
  $Res call({ProjectStatus newStatus, String? comment});
}

/// @nodoc
class _$ProjectValidationRequestCopyWithImpl<$Res,
        $Val extends ProjectValidationRequest>
    implements $ProjectValidationRequestCopyWith<$Res> {
  _$ProjectValidationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStatus = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      newStatus: null == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectValidationRequestImplCopyWith<$Res>
    implements $ProjectValidationRequestCopyWith<$Res> {
  factory _$$ProjectValidationRequestImplCopyWith(
          _$ProjectValidationRequestImpl value,
          $Res Function(_$ProjectValidationRequestImpl) then) =
      __$$ProjectValidationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProjectStatus newStatus, String? comment});
}

/// @nodoc
class __$$ProjectValidationRequestImplCopyWithImpl<$Res>
    extends _$ProjectValidationRequestCopyWithImpl<$Res,
        _$ProjectValidationRequestImpl>
    implements _$$ProjectValidationRequestImplCopyWith<$Res> {
  __$$ProjectValidationRequestImplCopyWithImpl(
      _$ProjectValidationRequestImpl _value,
      $Res Function(_$ProjectValidationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStatus = null,
    Object? comment = freezed,
  }) {
    return _then(_$ProjectValidationRequestImpl(
      newStatus: null == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectValidationRequestImpl implements _ProjectValidationRequest {
  const _$ProjectValidationRequestImpl({required this.newStatus, this.comment});

  factory _$ProjectValidationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectValidationRequestImplFromJson(json);

  @override
  final ProjectStatus newStatus;
  @override
  final String? comment;

  @override
  String toString() {
    return 'ProjectValidationRequest(newStatus: $newStatus, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectValidationRequestImpl &&
            (identical(other.newStatus, newStatus) ||
                other.newStatus == newStatus) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, newStatus, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectValidationRequestImplCopyWith<_$ProjectValidationRequestImpl>
      get copyWith => __$$ProjectValidationRequestImplCopyWithImpl<
          _$ProjectValidationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectValidationRequestImplToJson(
      this,
    );
  }
}

abstract class _ProjectValidationRequest implements ProjectValidationRequest {
  const factory _ProjectValidationRequest(
      {required final ProjectStatus newStatus,
      final String? comment}) = _$ProjectValidationRequestImpl;

  factory _ProjectValidationRequest.fromJson(Map<String, dynamic> json) =
      _$ProjectValidationRequestImpl.fromJson;

  @override
  ProjectStatus get newStatus;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$ProjectValidationRequestImplCopyWith<_$ProjectValidationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
