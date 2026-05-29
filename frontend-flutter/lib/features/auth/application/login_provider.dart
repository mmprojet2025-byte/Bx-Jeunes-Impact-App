import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../data/auth_models.dart';
import '../data/auth_repository.dart';
import '../../../shared/models/api_error.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/services/secure_storage_service.dart';
 
// ── State ─────────────────────────────────────────────────────
 
class LoginState {
  final bool    isLoading;
  final String? error;
 
  const LoginState({this.isLoading = false, this.error});
 
  LoginState copyWith({
    bool?   isLoading,
    String? error,
    bool    clearError = false,
  }) =>
      LoginState(
        isLoading: isLoading  ?? this.isLoading,
        error:     clearError ? null : error ?? this.error,
      );
}
 
// ── Notifier ──────────────────────────────────────────────────
 
class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _repo;
  final Ref            _ref;
 
  LoginNotifier(this._repo, this._ref) : super(const LoginState());
 
  /// Tente la connexion avec [email] et [password].
  /// Retourne true si succès, false sinon (state.error est peuplé).
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
 
    try {
      final response = await _repo.login(
        LoginRequest(email: email.trim(), password: password),
      );
 
      // ── Stocker les tokens dans flutter_secure_storage ────
      // Jamais dans SharedPreferences — données sensibles.
      await SecureStorageService.saveTokenPair(
        accessToken:  response.accessToken,
        refreshToken: response.refreshToken,
      );
 
      // ── Mettre à jour l'état global d'authentification ────
      // authProvider déclenche la redirection via routerProvider.refresh.
      _ref.read(authProvider.notifier).setUser(response.user);
 
      state = state.copyWith(isLoading: false);
      return true;
 
    } on ApiError catch (e) {
      // Erreur structurée retournée par le backend
      final message = e.isUnauthorized
          ? 'Identifiants invalides. Vérifiez votre email et mot de passe.'
          : e.isNetworkError
              ? 'Connexion impossible. Vérifiez votre réseau.'
              : e.message;
 
      state = state.copyWith(isLoading: false, error: message);
      return false;
 
    } catch (e) {
      // Erreur réseau non structurée (timeout, socket, DNS…)
      final message = e.toString().toLowerCase().contains('socket') ||
              e.toString().toLowerCase().contains('connection') ||
              e.toString().toLowerCase().contains('timeout')
          ? 'Connexion impossible. Vérifiez votre réseau.'
          : 'Une erreur est survenue. Réessayez.';
 
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }
 
  /// Efface l'erreur (appelé quand l'utilisateur ferme le bandeau).
  void clearError() => state = state.copyWith(clearError: true);
}
 
// ── Provider ──────────────────────────────────────────────────
 
final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) =>
        LoginNotifier(ref.read(authRepositoryProvider), ref),);