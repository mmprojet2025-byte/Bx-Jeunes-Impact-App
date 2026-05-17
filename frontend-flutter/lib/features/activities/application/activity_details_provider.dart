import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/activity.dart';
import '../data/activity_repository.dart';
import '../data/registration.dart';
import '../data/registration_repository.dart';

// ── Activity details ──────────────────────────────────────────

final activityDetailsProvider =
    AsyncNotifierProvider.family<ActivityDetailsNotifier, Activity, int>(
  ActivityDetailsNotifier.new,
);

class ActivityDetailsNotifier extends FamilyAsyncNotifier<Activity, int> {
  @override
  Future<Activity> build(int arg) =>
      ref.read(activityRepositoryProvider).fetchById(arg);

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(activityRepositoryProvider).fetchById(arg));
  }
}

// ── Registration state for a single activity ──────────────────

class ActivityRegistrationNotifier
    extends StateNotifier<AsyncValue<Registration?>> {
  final RegistrationRepository _repo;
  final int activityId;

  ActivityRegistrationNotifier(this._repo, this.activityId)
      : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncLoading();
    try {
      final all = await _repo.fetchMine();
      final reg = all
          .where((r) =>
              r.activity.id == activityId && r.status.isActive)
          .firstOrNull;
      state = AsyncData(reg);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> register() async {
    state = const AsyncLoading();
    try {
      final reg = await _repo.register(activityId);
      state = AsyncData(reg);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> cancel(int registrationId) async {
    await _repo.cancel(registrationId);
    state = const AsyncData(null);
  }
}

final activityRegistrationProvider = StateNotifierProvider.family<
    ActivityRegistrationNotifier, AsyncValue<Registration?>, int>(
  (ref, activityId) => ActivityRegistrationNotifier(
      ref.read(registrationRepositoryProvider), activityId),
);
