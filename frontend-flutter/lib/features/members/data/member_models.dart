import '../../../shared/models/user.dart';
import '../../../shared/models/role.dart';
 
/// MemberSummary — version allégée d'AppUser pour les listes de membres.
class MemberSummary {
  final int    id;
  final String firstName, lastName, email;
  final Role   primaryRole;
  final int?   groupId;
  final String? groupName;
  final bool   active;
 
  const MemberSummary({required this.id, required this.firstName, required this.lastName,
    required this.email, required this.primaryRole, this.groupId, this.groupName, this.active = true});
 
  String get fullName => '$firstName $lastName';
  String get initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty  ? lastName[0].toUpperCase()  : '';
    return '$f$l';
  }
 
  factory MemberSummary.fromJson(Map<String, dynamic> j) => MemberSummary(
    id: j['id'] as int, firstName: j['firstName'] as String, lastName: j['lastName'] as String,
    email: j['email'] as String,
    primaryRole: Role.fromString(((j['roles'] as List?)?.first as String?) ?? 'YOUTH'),
    groupId: j['groupId'] as int?, groupName: j['groupName'] as String?,
    active: j['active'] as bool? ?? true);
 
  AppUser toAppUser() => AppUser(id: id, email: email, firstName: firstName,
    lastName: lastName, roles: {primaryRole}, groupId: groupId, groupName: groupName, active: active);
}
