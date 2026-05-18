import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user.dart';
import '../../../shared/providers/auth_provider.dart';
import 'profile_repository.dart';

final profileProvider = AsyncNotifierProvider<ProfileNotifier, AppUser>(ProfileNotifier.new);

class ProfileNotifier extends AsyncNotifier<AppUser> {
  @override
  Future<AppUser> build() => ref.read(profileRepositoryProvider).getProfile();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(profileRepositoryProvider).getProfile());
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final updated = await ref.read(profileRepositoryProvider).updateProfile(data);
      state = AsyncData(updated);
      ref.read(authProvider.notifier).setUser(updated);
      return true;
    } catch (e) { return false; }
  }
}
