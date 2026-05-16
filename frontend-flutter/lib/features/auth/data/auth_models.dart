import '../../../shared/models/user.dart';
 
// ── LoginRequest ──────────────────────────────────────────────
 
class LoginRequest {
  final String email;
  final String password;
 
  const LoginRequest({required this.email, required this.password});
 
  Map<String, dynamic> toJson() => {
    'email':    email,
    'password': password,
  };
}
 
// ── AuthResponse ──────────────────────────────────────────────
// Miroir exact de la réponse 200 du backend.
// Le champ "user" est parsé en AppUser pour mise à jour de authProvider.
 
class AuthResponse {
  final AppUser user;
  final String  accessToken;
  final String  refreshToken;
  final int?    expiresIn;    // secondes — optionnel selon le backend
 
  const AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    this.expiresIn,
  });
 
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // Le backend peut envoyer "user" directement ou les champs à la racine
    final userJson = json['user'] as Map<String, dynamic>? ?? json;
 
    return AuthResponse(
      user:         AppUser.fromJson(userJson),
      accessToken:  json['accessToken']  as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn:    json['expiresIn']    as int?,
    );
  }
}
 
// ── RegisterRequest ───────────────────────────────────────────
 
class RegisterRequest {
  final String    email;
  final String    password;
  final String    firstName;
  final String    lastName;
  final int?      groupId;
  final DateTime? dateOfBirth;
  final bool      parentalConsent;
  final String?   parentEmail;
 
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.groupId,
    this.dateOfBirth,
    this.parentalConsent = false,
    this.parentEmail,
  });
 
  Map<String, dynamic> toJson() => {
    'email':            email,
    'password':         password,
    'firstName':        firstName,
    'lastName':         lastName,
    if (groupId       != null) 'groupId':       groupId,
    if (dateOfBirth   != null) 'dateOfBirth':   dateOfBirth!.toIso8601String(),
    'parentalConsent':  parentalConsent,
    if (parentEmail   != null) 'parentEmail':   parentEmail,
  };
}
 
// ── RefreshRequest ────────────────────────────────────────────
 
class RefreshRequest {
  final String refreshToken;
  const RefreshRequest({required this.refreshToken});
  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
