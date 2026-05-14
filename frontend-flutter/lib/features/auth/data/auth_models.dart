// Miroirs des DTOs auth du backend :
//   AuthenticationRequest.java  → LoginRequest
//   UserCreateRequest.java      → RegisterRequest
//   AuthenticationResponse.java → AuthResponse
//
// Règles de validation password (miroir de UserCreateRequest) :
//   - min 8 caractères
//   - au moins une majuscule
//   - au moins un chiffre
 
import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'auth_models.freezed.dart';
part 'auth_models.g.dart';
 
// ── LoginRequest ──────────────────────────────────────────────
// Miroir de AuthenticationRequest.java
 
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;
 
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
 
// ── RegisterRequest ───────────────────────────────────────────
// Miroir de UserCreateRequest.java
// groupId optionnel : l'utilisateur peut être assigné à un groupe plus tard.
 
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
 
    /// Groupe de rattachement (optionnel à l'inscription)
    int? groupId,
 
    // ── Champs RGPD ───────────────────────────────────────
    DateTime? dateOfBirth,
 
    /// Consentement parental (requis si mineur)
    @Default(false) bool parentalConsent,
 
    /// Email du parent/tuteur (si mineur)
    String? parentEmail,
  }) = _RegisterRequest;
 
  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
 
// ── AuthResponse ──────────────────────────────────────────────
// Miroir de AuthenticationResponse.java
 
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required String email,
    required int userId,
  }) = _AuthResponse;
 
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
 
// ── RefreshRequest ────────────────────────────────────────────
// Corps envoyé à POST /api/auth/refresh
 
@freezed
class RefreshRequest with _$RefreshRequest {
  const factory RefreshRequest({
    required String refreshToken,
  }) = _RefreshRequest;
 
  factory RefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestFromJson(json);
}
 
// ── ForgotPasswordRequest ─────────────────────────────────────
 
@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({
    required String email,
  }) = _ForgotPasswordRequest;
 
  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}
 