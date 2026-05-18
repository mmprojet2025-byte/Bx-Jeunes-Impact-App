import 'package:bx_jeunes_impact/features/profile/data/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_provider.dart';
import 'profile_repository.dart';

class EditProfileState {
  final bool isLoading; final bool success; final String? error;
  const EditProfileState({this.isLoading = false, this.success = false, this.error});
  EditProfileState copyWith({bool? isLoading, bool? success, String? error, bool clear = false}) =>
      EditProfileState(isLoading: isLoading ?? this.isLoading, success: success ?? this.success,
          error: clear ? null : error ?? this.error);
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  final Ref _ref;
  EditProfileNotifier(this._ref) : super(const EditProfileState());

  Future<void> save(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, clear: true);
    try {
      await _ref.read(profileRepositoryProvider).updateProfile(data);
      _ref.invalidate(profileProvider);
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Erreur : $e');
    }
  }
}

final editProfileProvider = StateNotifierProvider<EditProfileNotifier, EditProfileState>(
    (ref) => EditProfileNotifier(ref));
    