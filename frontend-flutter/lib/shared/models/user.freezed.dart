part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  /// Ensemble des rôles — miroir de Set<Role> côté backend
  Set<Role> get roles => throw _privateConstructorUsedError;

  /// Groupe de rattachement (null si pas encore assigné)
  int? get groupId => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;

  /// Soft delete : false = compte désactivé
  bool get active =>
      throw _privateConstructorUsedError; // ── Champs RGPD (UML révisé) ──────────────────────────
  /// Date de naissance — requis pour vérifier la minorité
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;

  /// Consentement parental (obligatoire pour les mineurs)
  bool get parentalConsent => throw _privateConstructorUsedError;

  /// Email du parent/tuteur (si mineur)
  String? get parentEmail =>
      throw _privateConstructorUsedError; // ── Timestamps ────────────────────────────────────────
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {int id,
      String email,
      String firstName,
      String lastName,
      Set<Role> roles,
      int? groupId,
      String? groupName,
      bool active,
      DateTime? dateOfBirth,
      bool parentalConsent,
      String? parentEmail,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? roles = null,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? active = null,
    Object? dateOfBirth = freezed,
    Object? parentalConsent = null,
    Object? parentEmail = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as Set<Role>,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      parentalConsent: null == parentalConsent
          ? _value.parentalConsent
          : parentalConsent // ignore: cast_nullable_to_non_nullable
              as bool,
      parentEmail: freezed == parentEmail
          ? _value.parentEmail
          : parentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String firstName,
      String lastName,
      Set<Role> roles,
      int? groupId,
      String? groupName,
      bool active,
      DateTime? dateOfBirth,
      bool parentalConsent,
      String? parentEmail,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? roles = null,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? active = null,
    Object? dateOfBirth = freezed,
    Object? parentalConsent = null,
    Object? parentEmail = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AppUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as Set<Role>,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      parentalConsent: null == parentalConsent
          ? _value.parentalConsent
          : parentalConsent // ignore: cast_nullable_to_non_nullable
              as bool,
      parentEmail: freezed == parentEmail
          ? _value.parentEmail
          : parentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      final Set<Role> roles = const <Role>{},
      this.groupId,
      this.groupName,
      this.active = true,
      this.dateOfBirth,
      this.parentalConsent = false,
      this.parentEmail,
      this.createdAt,
      this.updatedAt})
      : _roles = roles,
        super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;

  /// Ensemble des rôles — miroir de Set<Role> côté backend
  final Set<Role> _roles;

  /// Ensemble des rôles — miroir de Set<Role> côté backend
  @override
  @JsonKey()
  Set<Role> get roles {
    if (_roles is EqualUnmodifiableSetView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_roles);
  }

  /// Groupe de rattachement (null si pas encore assigné)
  @override
  final int? groupId;
  @override
  final String? groupName;

  /// Soft delete : false = compte désactivé
  @override
  @JsonKey()
  final bool active;
// ── Champs RGPD (UML révisé) ──────────────────────────
  /// Date de naissance — requis pour vérifier la minorité
  @override
  final DateTime? dateOfBirth;

  /// Consentement parental (obligatoire pour les mineurs)
  @override
  @JsonKey()
  final bool parentalConsent;

  /// Email du parent/tuteur (si mineur)
  @override
  final String? parentEmail;
// ── Timestamps ────────────────────────────────────────
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, firstName: $firstName, lastName: $lastName, roles: $roles, groupId: $groupId, groupName: $groupName, active: $active, dateOfBirth: $dateOfBirth, parentalConsent: $parentalConsent, parentEmail: $parentEmail, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.parentalConsent, parentalConsent) ||
                other.parentalConsent == parentalConsent) &&
            (identical(other.parentEmail, parentEmail) ||
                other.parentEmail == parentEmail) &&
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
      email,
      firstName,
      lastName,
      const DeepCollectionEquality().hash(_roles),
      groupId,
      groupName,
      active,
      dateOfBirth,
      parentalConsent,
      parentEmail,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser(
      {required final int id,
      required final String email,
      required final String firstName,
      required final String lastName,
      final Set<Role> roles,
      final int? groupId,
      final String? groupName,
      final bool active,
      final DateTime? dateOfBirth,
      final bool parentalConsent,
      final String? parentEmail,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override

  /// Ensemble des rôles — miroir de Set<Role> côté backend
  Set<Role> get roles;
  @override

  /// Groupe de rattachement (null si pas encore assigné)
  int? get groupId;
  @override
  String? get groupName;
  @override

  /// Soft delete : false = compte désactivé
  bool get active;
  @override // ── Champs RGPD (UML révisé) ──────────────────────────
  /// Date de naissance — requis pour vérifier la minorité
  DateTime? get dateOfBirth;
  @override

  /// Consentement parental (obligatoire pour les mineurs)
  bool get parentalConsent;
  @override

  /// Email du parent/tuteur (si mineur)
  String? get parentEmail;
  @override // ── Timestamps ────────────────────────────────────────
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
