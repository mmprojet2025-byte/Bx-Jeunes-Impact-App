import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../models/user.dart';
import '../services/secure_storage_service.dart';
 
// ── AuthState ─────────────────────────────────────────────────
 
class AuthState {
  final AppUser? user;
  final bool isLoading;
  final String? error;
 
  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });
 
  bool get isAuthenticated => user != null;
 
  AuthState copyWith({
    AppUser? user,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearUser = false,
  }) =>
      AuthState(
        user:      clearUser  ? null  : user      ?? this.user,
        isLoading: isLoading  ?? this.isLoading,
        error:     clearError ? null  : error     ?? this.error,
      );
}
 
// ── AuthNotifier ──────────────────────────────────────────────
 
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());
 
  /// Appelé après un login ou register réussi
  void setUser(AppUser user) {
    state = state.copyWith(user: user, clearError: true);
  }
 
  /// Efface les tokens et réinitialise l'état
  Future<void> logout() async {
    await SecureStorageService.clearAll();
    state = const AuthState();
  }
 
  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
 
  void setError(String error) {
    state = state.copyWith(error: error, isLoading: false);
  }
 
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}
 
// ── Provider ──────────────────────────────────────────────────
 
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (_) => AuthNotifier(),
);
 