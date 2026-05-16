import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../../../core/constants/app_config.dart';
import '../../../shared/models/user.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'auth_models.dart';
 
class AuthRepository {
  final ApiService _api;
 
  AuthRepository(this._api);
 
  // ── Login ─────────────────────────────────────────────────
  // POST /api/auth/login
  // Lève ApiError(401) si identifiants invalides → intercepté par LoginNotifier.
 
  Future<AuthResponse> login(LoginRequest request) =>
      _api.post<AuthResponse>(
        AppConfig.loginEndpoint,
        body: request.toJson(),
        fromJson: (json) =>
            AuthResponse.fromJson(json as Map<String, dynamic>),
      );
 
  // ── Register ──────────────────────────────────────────────
 
  Future<AuthResponse> register(RegisterRequest request) =>
      _api.post<AuthResponse>(
        AppConfig.registerEndpoint,
        body: request.toJson(),
        fromJson: (json) =>
            AuthResponse.fromJson(json as Map<String, dynamic>),
      );
 
  // ── Forgot password ───────────────────────────────────────
  // Retourne void — le backend envoie l'email de réinitialisation.
 
  Future<void> forgotPassword(String email) =>
      _api.post<void>(
        AppConfig.forgotPasswordEndpoint,
        body: {'email': email},
      );
 
  // ── Get current user ──────────────────────────────────────
  // Appelé après login pour hydrater authProvider avec le profil complet.
 
  Future<AppUser> getMe() =>
      _api.get<AppUser>(
        '${AppConfig.usersEndpoint}/me',
        fromJson: (json) =>
            AppUser.fromJson(json as Map<String, dynamic>),
      );
}
 
// ── Provider ──────────────────────────────────────────────────
 
final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepository(ref.read(apiServiceProvider)));
    