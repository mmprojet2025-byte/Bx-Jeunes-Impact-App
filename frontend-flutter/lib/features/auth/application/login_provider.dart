import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/auth_provider.dart';
import '../../../shared/services/secure_storage_service.dart';
import '../data/auth_models.dart';
import '../data/auth_repository.dart';
 
// ── State ─────────────────────────────────────────────────────
 
class LoginState {
  final bool isLoading;
  final String? error;
 
  const LoginState({this.isLoading = false, this.error});
 
  LoginState copyWith({bool? isLoading, String? error, bool clearError = false}) =>
      LoginState(
        isLoading: isLoading ?? this.isLoading,
        error:     clearError ? null : error ?? this.error,
      );
}
 
// ── Notifier ──────────────────────────────────────────────────
 
class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _repo;
  final Ref _ref;
 
  LoginNotifier(this._repo, this._ref) : super(const LoginState());
 
  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);
 
    try {
      final response = await _repo.login(
        LoginRequest(email: email, password: password),
      );
 
      // Stocke les tokens
      await SecureStorageService.saveTokenPair(
        accessToken:  response.accessToken,
        refreshToken: response.refreshToken,
      );
 
      // Charge le profil utilisateur et met à jour l'état global
      final user = await _repo.getMe();
      _ref.read(authProvider.notifier).setUser(user);
 
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().contains('401')
            ? 'Email ou mot de passe incorrect.'
            : 'Une erreur est survenue. Réessayez.',
      );
      return false;
    }
  }
 
  void clearError() => state = state.copyWith(clearError: true);
}
 
// ── Provider ──────────────────────────────────────────────────
 
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.read(authRepositoryProvider), ref);
});
