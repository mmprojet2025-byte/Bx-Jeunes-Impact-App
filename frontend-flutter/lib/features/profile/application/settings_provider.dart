import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/profile/data/user_preferences.dart';
import 'profile_repository.dart';

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, UserPreferences>(SettingsNotifier.new);

class SettingsNotifier extends AsyncNotifier<UserPreferences> {
  @override
  Future<UserPreferences> build() =>
      ref.read(profileRepositoryProvider).getPreferences();

  @override
  Future<void> update(UserPreferences cb) async {
    final updated = await ref.read(profileRepositoryProvider).updatePreferences(cb);
    state = AsyncData(updated);
  }
}
