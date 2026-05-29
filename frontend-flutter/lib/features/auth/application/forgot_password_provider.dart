import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/api_error.dart';
import '../data/auth_repository.dart';
 
// ── State ─────────────────────────────────────────────────────
 
class ForgotPasswordState {
  /// true = l'appel API est en cours (spinner sur le bouton)
  final bool isLoading;
 
  /// true = l'email a été envoyé avec succès → afficher l'écran de confirmation
  final bool sent;
 
  /// Message d'erreur à afficher (erreur réseau uniquement — pas de 404)
  final String? error;
 
  /// Email qui a été soumis (utilisé dans l'écran de confirmation)
  final String? submittedEmail;
 
  const ForgotPasswordState({
    this.isLoading      = false,
    this.sent           = false,
    this.error,
    this.submittedEmail,
  });
 
  ForgotPasswordState copyWith({
    bool?   isLoading,
    bool?   sent,
    String? error,
    String? submittedEmail,
    bool    clearError = false,
  }) =>
      ForgotPasswordState(
        isLoading:      isLoading      ?? this.isLoading,
        sent:           sent           ?? this.sent,
        submittedEmail: submittedEmail ?? this.submittedEmail,
        error:          clearError ? null : error ?? this.error,
      );
}
 
// ── Notifier ──────────────────────────────────────────────────
 
class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthRepository _repo;
 
  ForgotPasswordNotifier(this._repo) : super(const ForgotPasswordState());
 
  /// Envoie la demande de réinitialisation.
  ///
  /// Le backend retourne toujours 200 (même si l'email n'existe pas)
  /// pour éviter l'énumération des comptes.
  /// Seules les erreurs réseau/serveur remontent dans state.error.
  Future<void> sendResetLink(String email) async {
    state = state.copyWith(
      isLoading:      true,
      clearError:     true,
      submittedEmail: email.trim(),
    );
 
    try {
      await _repo.forgotPassword(email.trim());
 
      // Succès → passer à l'écran de confirmation
      state = state.copyWith(isLoading: false, sent: true);
 
    } on ApiError catch (e) {
      // Le backend devrait toujours retourner 200, mais on gère par sécurité.
      // On affiche quand même "sent" pour ne pas révéler si l'email existe.
      if (e.isNetworkError) {
        state = state.copyWith(
          isLoading: false,
          error: 'Connexion impossible. Vérifiez votre réseau.',
        );
      } else {
        // 4xx/5xx inattendus → on traite comme un succès (sécurité)
        state = state.copyWith(isLoading: false, sent: true);
      }
 
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Connexion impossible. Vérifiez votre réseau.',
      );
    }
  }
 
  /// Réinitialise le state (pour le bouton "Renvoyer un lien")
  void reset() => state = const ForgotPasswordState();
 
  void clearError() => state = state.copyWith(clearError: true);
}
 
// ── Provider ──────────────────────────────────────────────────
 
final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) =>
        ForgotPasswordNotifier(ref.read(authRepositoryProvider)),);