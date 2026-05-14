import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../../../core/constants/app_config.dart';
import '../../../shared/models/user.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'auth_models.dart';
 
class AuthRepository {
  final ApiService _api;
 
  AuthRepository(this._api);
 
  /// POST /api/auth/login
  Future<AuthResponse> login(LoginRequest request) =>
      _api.post<AuthResponse>(
        AppConfig.loginEndpoint,
        body: {'email': request.email, 'password': request.password},
        fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
 
  /// POST /api/auth/register
  Future<AuthResponse> register(RegisterRequest request) =>
      _api.post<AuthResponse>(
        AppConfig.registerEndpoint,
        body: {
          'email':            request.email,
          'password':         request.password,
          'firstName':        request.firstName,
          'lastName':         request.lastName,
          if (request.groupId != null) 'groupId': request.groupId,
          if (request.dateOfBirth != null)
            'dateOfBirth': request.dateOfBirth!.toIso8601String(),
          'parentalConsent': request.parentalConsent,
          if (request.parentEmail != null) 'parentEmail': request.parentEmail,
        },
        fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
 
  /// POST /api/auth/forgot-password
  Future<void> forgotPassword(String email) =>
      _api.post<void>(
        AppConfig.forgotPasswordEndpoint,
        body: {'email': email},
      );
 
  /// GET /api/users/me — récupère le profil de l'utilisateur connecté
  Future<AppUser> getMe() =>
      _api.get<AppUser>(
        '${AppConfig.usersEndpoint}/me',
        fromJson: (json) => AppUser.fromJson(json as Map<String, dynamic>),
      );
}
 
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(apiServiceProvider));
});
