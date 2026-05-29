import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/api_error.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/services/secure_storage_service.dart';
import '../data/auth_models.dart';
import '../data/auth_repository.dart';
 
// ── State ─────────────────────────────────────────────────────
 
class RegisterState {
  final bool    isLoading;
  final String? error;
 
  const RegisterState({this.isLoading = false, this.error});
 
  RegisterState copyWith({
    bool?   isLoading,
    String? error,
    bool    clearError = false,
  }) =>
      RegisterState(
        isLoading: isLoading  ?? this.isLoading,
        error:     clearError ? null : error ?? this.error,
      );
}
 
// ── Notifier ──────────────────────────────────────────────────
 
class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthRepository _repo;
  final Ref            _ref;
 
  RegisterNotifier(this._repo, this._ref) : super(const RegisterState());
 
  /// Inscrit l'utilisateur et effectue l'auto-login si succès.
  /// Retourne true si succès, false sinon (state.error est peuplé).
  Future<bool> register({
    required String    firstName,
    required String    lastName,
    required String    email,
    required String    password,
    required DateTime  dateOfBirth,
    required bool      parentalConsent,
    String?            parentEmail,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
 
    try {
      final response = await _repo.register(
        RegisterRequest(
          firstName:       firstName.trim(),
          lastName:        lastName.trim(),
          email:           email.trim(),
          password:        password,
          dateOfBirth:     dateOfBirth,
          parentalConsent: parentalConsent,
          parentEmail:     parentEmail?.trim(),
          // Rôle YOUTH par défaut — assigné par le backend
        ),
      );
 
      // ── Auto-login : stocker les tokens ───────────────────
      await SecureStorageService.saveTokenPair(
        accessToken:  response.accessToken,
        refreshToken: response.refreshToken,
      );
 
      // ── Mettre à jour authProvider ────────────────────────
      _ref.read(authProvider.notifier).setUser(response.user);
 
      state = state.copyWith(isLoading: false);
      return true;
 
    } on ApiError catch (e) {
      final message = switch (e.status) {
        409 => 'Cet email est déjà utilisé.',
        400 => e.hasFieldErrors
              ? e.fieldErrors.first.message
              : 'Données invalides. Vérifiez vos informations.',
        0   => 'Connexion impossible. Vérifiez votre réseau.',
        _   => e.message,
      };
      state = state.copyWith(isLoading: false, error: message);
      return false;
 
    } catch (e) {
      final message =
          e.toString().toLowerCase().contains('socket') ||
          e.toString().toLowerCase().contains('connection') ||
          e.toString().toLowerCase().contains('timeout')
              ? 'Connexion impossible. Vérifiez votre réseau.'
              : 'Une erreur est survenue. Réessayez.';
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }
 
  void clearError() => state = state.copyWith(clearError: true);
}
 
// ── Provider ──────────────────────────────────────────────────
 
final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) =>
        RegisterNotifier(ref.read(authRepositoryProvider), ref),);