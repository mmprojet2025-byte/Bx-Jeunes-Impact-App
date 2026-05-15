import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/secure_storage_service.dart';
 
class AuthState {
  final AppUser? user;
  final bool isLoading;
  final String? error;
 
  const AuthState({this.user, this.isLoading = false, this.error});
 
  bool get isAuthenticated => user != null;
 
  AuthState copyWith({AppUser? user, bool? isLoading, String? error}) =>
      AuthState(
        user:      user      ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        error:     error,
      );
}
 
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());
 
  void setUser(AppUser user) => state = state.copyWith(user: user);
 
  Future<void> logout() async {
    await SecureStorageService.clearAll();
    state = const AuthState();
  }
}
 
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (_) => AuthNotifier(),
);
