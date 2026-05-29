import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notification_models.dart';
import '../data/notification_repository.dart';

final notificationHistoryProvider =
    AsyncNotifierProvider<NotificationHistoryNotifier, List<AppNotification>>(
        NotificationHistoryNotifier.new,);

class NotificationHistoryNotifier
    extends AsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() =>
      ref.read(notificationRepositoryProvider).fetchHistory();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(notificationRepositoryProvider).fetchHistory(),);
  }
}

class NotificationSendState {
  final bool isLoading;
  final bool success;
  final String? error;
  const NotificationSendState(
      {this.isLoading = false, this.success = false, this.error,});
  NotificationSendState copyWith(
          {bool? isLoading, bool? success, String? error, bool clear = false,}) =>
      NotificationSendState(
          isLoading: isLoading ?? this.isLoading,
          success: success ?? this.success,
          error: clear ? null : error ?? this.error,);
}

class NotificationSendNotifier extends StateNotifier<NotificationSendState> {
  final NotificationRepository _repo;
  NotificationSendNotifier(this._repo) : super(const NotificationSendState());

  Future<void> send(NotificationSendRequest req) async {
    state = state.copyWith(isLoading: true, clear: true);
    try {
      await _repo.send(req);
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Erreur : $e');
    }
  }

  void reset() => state = const NotificationSendState();
}

final notificationSendProvider = StateNotifierProvider<
    NotificationSendNotifier, NotificationSendState>(
  (ref) => NotificationSendNotifier(ref.read(notificationRepositoryProvider)),
);