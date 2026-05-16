import 'role.dart';
 
class AppUser {
  final int         id;
  final String      email;
  final String      firstName;
  final String      lastName;
  final Set<Role>   roles;
  final int?        groupId;
  final String?     groupName;
  final bool        active;
  final DateTime?   dateOfBirth;
  final bool        parentalConsent;
  final String?     parentEmail;
  final DateTime?   createdAt;
 
  const AppUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.roles           = const {},
    this.groupId,
    this.groupName,
    this.active          = true,
    this.dateOfBirth,
    this.parentalConsent = false,
    this.parentEmail,
    this.createdAt,
  });
 
  // ── Computed ──────────────────────────────────────────────
 
  String get fullName    => '$firstName $lastName';
  String get displayName => '$firstName ${lastName.isNotEmpty ? lastName[0].toUpperCase() : ""}.';
  String get initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty  ? lastName[0].toUpperCase()  : '';
    return '$f$l';
  }
 
  bool get isAdmin    => roles.contains(Role.admin) || roles.contains(Role.superAdmin);
  bool get isReferent => roles.contains(Role.groupReferent);
  bool get isYouth    => roles.contains(Role.youth);
  bool get isPartner  => roles.contains(Role.partner);
 
  Role get primaryRole {
    if (roles.contains(Role.superAdmin))     return Role.superAdmin;
    if (roles.contains(Role.admin))          return Role.admin;
    if (roles.contains(Role.groupReferent))  return Role.groupReferent;
    if (roles.contains(Role.projectManager)) return Role.projectManager;
    if (roles.contains(Role.partner))        return Role.partner;
    return Role.youth;
  }
 
  bool get isMinor {
    if (dateOfBirth == null) return false;
    final now = DateTime.now();
    final age = now.year - dateOfBirth!.year;
    final hadBirthday = now.month > dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day >= dateOfBirth!.day);
    return (hadBirthday ? age : age - 1) < 18;
  }
 
  // ── Serialization ─────────────────────────────────────────
 
  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id:              json['id'] as int,
    email:           json['email'] as String,
    firstName:       json['firstName'] as String,
    lastName:        json['lastName'] as String,
    roles:           ((json['roles'] as List?) ?? [])
        .map((r) => Role.fromString(r as String))
        .toSet(),
    groupId:         json['groupId']       as int?,
    groupName:       json['groupName']     as String?,
    active:          json['active']        as bool? ?? true,
    dateOfBirth:     json['dateOfBirth']   != null
        ? DateTime.tryParse(json['dateOfBirth'] as String) : null,
    parentalConsent: json['parentalConsent'] as bool? ?? false,
    parentEmail:     json['parentEmail']   as String?,
    createdAt:       json['createdAt']     != null
        ? DateTime.tryParse(json['createdAt'] as String) : null,
  );
 
  Map<String, dynamic> toJson() => {
    'id':             id,
    'email':          email,
    'firstName':      firstName,
    'lastName':       lastName,
    'roles':          roles.map((r) => r.jsonValue).toList(),
    'groupId':        groupId,
    'groupName':      groupName,
    'active':         active,
    'dateOfBirth':    dateOfBirth?.toIso8601String(),
    'parentalConsent': parentalConsent,
    'parentEmail':    parentEmail,
  };
 
  AppUser copyWith({
    String? firstName, String? lastName, String? email,
    Set<Role>? roles, int? groupId, String? groupName,
  }) => AppUser(
    id: id, active: active, createdAt: createdAt,
    dateOfBirth: dateOfBirth, parentalConsent: parentalConsent,
    parentEmail: parentEmail,
    firstName:  firstName  ?? this.firstName,
    lastName:   lastName   ?? this.lastName,
    email:      email      ?? this.email,
    roles:      roles      ?? this.roles,
    groupId:    groupId    ?? this.groupId,
    groupName:  groupName  ?? this.groupName,
  );
}
