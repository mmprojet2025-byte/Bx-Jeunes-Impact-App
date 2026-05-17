import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_repository.dart';

class GdprState {
  final bool isLoading; final bool deleted; final String? error;
  const GdprState({this.isLoading = false, this.deleted = false, this.error});
}

class GdprNotifier extends StateNotifier<GdprState> {
  final ProfileRepository _repo;
  GdprNotifier(this._repo) : super(const GdprState());

  Future<void> deleteAccount() async {
    state = const GdprState(isLoading: true);
    try {
      await _repo.deleteAccount();
      state = const GdprState(deleted: true);
    } catch (e) {
      state = GdprState(error: 'Erreur : $e');
    }
  }
}

final gdprProvider = StateNotifierProvider<GdprNotifier, GdprState>(
    (ref) => GdprNotifier(ref.read(profileRepositoryProvider)));