import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../data/auth_models.dart';
import '../data/auth_repository.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/services/secure_storage_service.dart';
 
class RegisterState {
  final bool isLoading;
  final String? error;
 
  const RegisterState({this.isLoading = false, this.error});
 
  RegisterState copyWith({bool? isLoading, String? error, bool clearError = false}) =>
      RegisterState(
        isLoading: isLoading ?? this.isLoading,
        error:     clearError ? null : error ?? this.error,
      );
}
 
class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthRepository _repo;
  final Ref _ref;
 
  RegisterNotifier(this._repo, this._ref) : super(const RegisterState());
 
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    int? groupId,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
 
    try {
      final response = await _repo.register(
        RegisterRequest(
          firstName: firstName,
          lastName:  lastName,
          email:     email,
          password:  password,
          groupId:   groupId,
        ),
      );
 
      await SecureStorageService.saveTokenPair(
        accessToken:  response.accessToken,
        refreshToken: response.refreshToken,
      );
 
      final user = await _repo.getMe();
      _ref.read(authProvider.notifier).setUser(user);
 
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Inscription échouée. Vérifiez vos informations.',
      );
      return false;
    }
  }
 
  void clearError() => state = state.copyWith(clearError: true);
}
 
final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(ref.read(authRepositoryProvider), ref);
});
 