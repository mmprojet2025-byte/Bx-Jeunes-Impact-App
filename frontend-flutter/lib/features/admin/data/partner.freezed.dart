// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return _Partner.fromJson(json);
}

/// @nodoc
mixin _$Partner {
  int get id => throw _privateConstructorUsedError;

  /// Nom de l'organisation partenaire
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  PartnerLevel get level => throw _privateConstructorUsedError;

  /// URL logo (pas dans l'entité backend actuelle — anticipation V2)
  String? get logoUrl => throw _privateConstructorUsedError;

  /// Site web (anticipation V2)
  String? get websiteUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerCopyWith<Partner> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerCopyWith<$Res> {
  factory $PartnerCopyWith(Partner value, $Res Function(Partner) then) =
      _$PartnerCopyWithImpl<$Res, Partner>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      PartnerLevel level,
      String? logoUrl,
      String? websiteUrl,
      DateTime? createdAt});
}

/// @nodoc
class _$PartnerCopyWithImpl<$Res, $Val extends Partner>
    implements $PartnerCopyWith<$Res> {
  _$PartnerCopyWithImpl(this._value, this._then);

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
    Object? level = null,
    Object? logoUrl = freezed,
    Object? websiteUrl = freezed,
    Object? createdAt = freezed,
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
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as PartnerLevel,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerImplCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$$PartnerImplCopyWith(
          _$PartnerImpl value, $Res Function(_$PartnerImpl) then) =
      __$$PartnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      PartnerLevel level,
      String? logoUrl,
      String? websiteUrl,
      DateTime? createdAt});
}

/// @nodoc
class __$$PartnerImplCopyWithImpl<$Res>
    extends _$PartnerCopyWithImpl<$Res, _$PartnerImpl>
    implements _$$PartnerImplCopyWith<$Res> {
  __$$PartnerImplCopyWithImpl(
      _$PartnerImpl _value, $Res Function(_$PartnerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? level = null,
    Object? logoUrl = freezed,
    Object? websiteUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$PartnerImpl(
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
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as PartnerLevel,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerImpl extends _Partner {
  const _$PartnerImpl(
      {required this.id,
      required this.name,
      this.description,
      this.level = PartnerLevel.simple,
      this.logoUrl,
      this.websiteUrl,
      this.createdAt})
      : super._();

  factory _$PartnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerImplFromJson(json);

  @override
  final int id;

  /// Nom de l'organisation partenaire
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final PartnerLevel level;

  /// URL logo (pas dans l'entité backend actuelle — anticipation V2)
  @override
  final String? logoUrl;

  /// Site web (anticipation V2)
  @override
  final String? websiteUrl;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Partner(id: $id, name: $name, description: $description, level: $level, logoUrl: $logoUrl, websiteUrl: $websiteUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.websiteUrl, websiteUrl) ||
                other.websiteUrl == websiteUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, level,
      logoUrl, websiteUrl, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerImplCopyWith<_$PartnerImpl> get copyWith =>
      __$$PartnerImplCopyWithImpl<_$PartnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerImplToJson(
      this,
    );
  }
}

abstract class _Partner extends Partner {
  const factory _Partner(
      {required final int id,
      required final String name,
      final String? description,
      final PartnerLevel level,
      final String? logoUrl,
      final String? websiteUrl,
      final DateTime? createdAt}) = _$PartnerImpl;
  const _Partner._() : super._();

  factory _Partner.fromJson(Map<String, dynamic> json) = _$PartnerImpl.fromJson;

  @override
  int get id;
  @override

  /// Nom de l'organisation partenaire
  String get name;
  @override
  String? get description;
  @override
  PartnerLevel get level;
  @override

  /// URL logo (pas dans l'entité backend actuelle — anticipation V2)
  String? get logoUrl;
  @override

  /// Site web (anticipation V2)
  String? get websiteUrl;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PartnerImplCopyWith<_$PartnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Sponsoring _$SponsoringFromJson(Map<String, dynamic> json) {
  return _Sponsoring.fromJson(json);
}

/// @nodoc
mixin _$Sponsoring {
  int get id => throw _privateConstructorUsedError;
  int get partnerId => throw _privateConstructorUsedError;
  String? get partnerName => throw _privateConstructorUsedError;

  /// Projet sponsorisé (null si c'est une activité)
  int? get projectId => throw _privateConstructorUsedError;
  String? get projectTitle => throw _privateConstructorUsedError;

  /// Activité sponsorisée (null si c'est un projet)
  int? get activityId => throw _privateConstructorUsedError;
  String? get activityName => throw _privateConstructorUsedError;

  /// Montant financier (optionnel — peut être du soutien matériel)
  double? get amount => throw _privateConstructorUsedError;

  /// Description du soutien matériel (local, matériel, etc.)
  String? get materialSupport => throw _privateConstructorUsedError;
  SponsoringStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SponsoringCopyWith<Sponsoring> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SponsoringCopyWith<$Res> {
  factory $SponsoringCopyWith(
          Sponsoring value, $Res Function(Sponsoring) then) =
      _$SponsoringCopyWithImpl<$Res, Sponsoring>;
  @useResult
  $Res call(
      {int id,
      int partnerId,
      String? partnerName,
      int? projectId,
      String? projectTitle,
      int? activityId,
      String? activityName,
      double? amount,
      String? materialSupport,
      SponsoringStatus status,
      DateTime? createdAt});
}

/// @nodoc
class _$SponsoringCopyWithImpl<$Res, $Val extends Sponsoring>
    implements $SponsoringCopyWith<$Res> {
  _$SponsoringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partnerId = null,
    Object? partnerName = freezed,
    Object? projectId = freezed,
    Object? projectTitle = freezed,
    Object? activityId = freezed,
    Object? activityName = freezed,
    Object? amount = freezed,
    Object? materialSupport = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partnerId: null == partnerId
          ? _value.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as int,
      partnerName: freezed == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      projectTitle: freezed == projectTitle
          ? _value.projectTitle
          : projectTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      activityId: freezed == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as int?,
      activityName: freezed == activityName
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      materialSupport: freezed == materialSupport
          ? _value.materialSupport
          : materialSupport // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SponsoringStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SponsoringImplCopyWith<$Res>
    implements $SponsoringCopyWith<$Res> {
  factory _$$SponsoringImplCopyWith(
          _$SponsoringImpl value, $Res Function(_$SponsoringImpl) then) =
      __$$SponsoringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int partnerId,
      String? partnerName,
      int? projectId,
      String? projectTitle,
      int? activityId,
      String? activityName,
      double? amount,
      String? materialSupport,
      SponsoringStatus status,
      DateTime? createdAt});
}

/// @nodoc
class __$$SponsoringImplCopyWithImpl<$Res>
    extends _$SponsoringCopyWithImpl<$Res, _$SponsoringImpl>
    implements _$$SponsoringImplCopyWith<$Res> {
  __$$SponsoringImplCopyWithImpl(
      _$SponsoringImpl _value, $Res Function(_$SponsoringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partnerId = null,
    Object? partnerName = freezed,
    Object? projectId = freezed,
    Object? projectTitle = freezed,
    Object? activityId = freezed,
    Object? activityName = freezed,
    Object? amount = freezed,
    Object? materialSupport = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$SponsoringImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partnerId: null == partnerId
          ? _value.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as int,
      partnerName: freezed == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      projectTitle: freezed == projectTitle
          ? _value.projectTitle
          : projectTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      activityId: freezed == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as int?,
      activityName: freezed == activityName
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      materialSupport: freezed == materialSupport
          ? _value.materialSupport
          : materialSupport // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SponsoringStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SponsoringImpl extends _Sponsoring {
  const _$SponsoringImpl(
      {required this.id,
      required this.partnerId,
      this.partnerName,
      this.projectId,
      this.projectTitle,
      this.activityId,
      this.activityName,
      this.amount,
      this.materialSupport,
      this.status = SponsoringStatus.pending,
      this.createdAt})
      : super._();

  factory _$SponsoringImpl.fromJson(Map<String, dynamic> json) =>
      _$$SponsoringImplFromJson(json);

  @override
  final int id;
  @override
  final int partnerId;
  @override
  final String? partnerName;

  /// Projet sponsorisé (null si c'est une activité)
  @override
  final int? projectId;
  @override
  final String? projectTitle;

  /// Activité sponsorisée (null si c'est un projet)
  @override
  final int? activityId;
  @override
  final String? activityName;

  /// Montant financier (optionnel — peut être du soutien matériel)
  @override
  final double? amount;

  /// Description du soutien matériel (local, matériel, etc.)
  @override
  final String? materialSupport;
  @override
  @JsonKey()
  final SponsoringStatus status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Sponsoring(id: $id, partnerId: $partnerId, partnerName: $partnerName, projectId: $projectId, projectTitle: $projectTitle, activityId: $activityId, activityName: $activityName, amount: $amount, materialSupport: $materialSupport, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SponsoringImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.partnerName, partnerName) ||
                other.partnerName == partnerName) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectTitle, projectTitle) ||
                other.projectTitle == projectTitle) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.activityName, activityName) ||
                other.activityName == activityName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.materialSupport, materialSupport) ||
                other.materialSupport == materialSupport) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      partnerId,
      partnerName,
      projectId,
      projectTitle,
      activityId,
      activityName,
      amount,
      materialSupport,
      status,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SponsoringImplCopyWith<_$SponsoringImpl> get copyWith =>
      __$$SponsoringImplCopyWithImpl<_$SponsoringImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SponsoringImplToJson(
      this,
    );
  }
}

abstract class _Sponsoring extends Sponsoring {
  const factory _Sponsoring(
      {required final int id,
      required final int partnerId,
      final String? partnerName,
      final int? projectId,
      final String? projectTitle,
      final int? activityId,
      final String? activityName,
      final double? amount,
      final String? materialSupport,
      final SponsoringStatus status,
      final DateTime? createdAt}) = _$SponsoringImpl;
  const _Sponsoring._() : super._();

  factory _Sponsoring.fromJson(Map<String, dynamic> json) =
      _$SponsoringImpl.fromJson;

  @override
  int get id;
  @override
  int get partnerId;
  @override
  String? get partnerName;
  @override

  /// Projet sponsorisé (null si c'est une activité)
  int? get projectId;
  @override
  String? get projectTitle;
  @override

  /// Activité sponsorisée (null si c'est un projet)
  int? get activityId;
  @override
  String? get activityName;
  @override

  /// Montant financier (optionnel — peut être du soutien matériel)
  double? get amount;
  @override

  /// Description du soutien matériel (local, matériel, etc.)
  String? get materialSupport;
  @override
  SponsoringStatus get status;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$SponsoringImplCopyWith<_$SponsoringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartnerCreateRequest _$PartnerCreateRequestFromJson(Map<String, dynamic> json) {
  return _PartnerCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$PartnerCreateRequest {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  PartnerLevel get level => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get websiteUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerCreateRequestCopyWith<PartnerCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerCreateRequestCopyWith<$Res> {
  factory $PartnerCreateRequestCopyWith(PartnerCreateRequest value,
          $Res Function(PartnerCreateRequest) then) =
      _$PartnerCreateRequestCopyWithImpl<$Res, PartnerCreateRequest>;
  @useResult
  $Res call(
      {String name,
      String? description,
      PartnerLevel level,
      String? logoUrl,
      String? websiteUrl});
}

/// @nodoc
class _$PartnerCreateRequestCopyWithImpl<$Res,
        $Val extends PartnerCreateRequest>
    implements $PartnerCreateRequestCopyWith<$Res> {
  _$PartnerCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? level = null,
    Object? logoUrl = freezed,
    Object? websiteUrl = freezed,
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
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as PartnerLevel,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerCreateRequestImplCopyWith<$Res>
    implements $PartnerCreateRequestCopyWith<$Res> {
  factory _$$PartnerCreateRequestImplCopyWith(_$PartnerCreateRequestImpl value,
          $Res Function(_$PartnerCreateRequestImpl) then) =
      __$$PartnerCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      PartnerLevel level,
      String? logoUrl,
      String? websiteUrl});
}

/// @nodoc
class __$$PartnerCreateRequestImplCopyWithImpl<$Res>
    extends _$PartnerCreateRequestCopyWithImpl<$Res, _$PartnerCreateRequestImpl>
    implements _$$PartnerCreateRequestImplCopyWith<$Res> {
  __$$PartnerCreateRequestImplCopyWithImpl(_$PartnerCreateRequestImpl _value,
      $Res Function(_$PartnerCreateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? level = null,
    Object? logoUrl = freezed,
    Object? websiteUrl = freezed,
  }) {
    return _then(_$PartnerCreateRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as PartnerLevel,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerCreateRequestImpl implements _PartnerCreateRequest {
  const _$PartnerCreateRequestImpl(
      {required this.name,
      this.description,
      this.level = PartnerLevel.simple,
      this.logoUrl,
      this.websiteUrl});

  factory _$PartnerCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerCreateRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final PartnerLevel level;
  @override
  final String? logoUrl;
  @override
  final String? websiteUrl;

  @override
  String toString() {
    return 'PartnerCreateRequest(name: $name, description: $description, level: $level, logoUrl: $logoUrl, websiteUrl: $websiteUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerCreateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.websiteUrl, websiteUrl) ||
                other.websiteUrl == websiteUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, level, logoUrl, websiteUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerCreateRequestImplCopyWith<_$PartnerCreateRequestImpl>
      get copyWith =>
          __$$PartnerCreateRequestImplCopyWithImpl<_$PartnerCreateRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _PartnerCreateRequest implements PartnerCreateRequest {
  const factory _PartnerCreateRequest(
      {required final String name,
      final String? description,
      final PartnerLevel level,
      final String? logoUrl,
      final String? websiteUrl}) = _$PartnerCreateRequestImpl;

  factory _PartnerCreateRequest.fromJson(Map<String, dynamic> json) =
      _$PartnerCreateRequestImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  PartnerLevel get level;
  @override
  String? get logoUrl;
  @override
  String? get websiteUrl;
  @override
  @JsonKey(ignore: true)
  _$$PartnerCreateRequestImplCopyWith<_$PartnerCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
