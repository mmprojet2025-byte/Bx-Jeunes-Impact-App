import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/activity.dart';
import '../data/activity_repository.dart';

class ActivityFormState {
  final bool isLoading;
  final bool success;
  final String? error;
  const ActivityFormState(
      {this.isLoading = false, this.success = false, this.error,});

  ActivityFormState copyWith(
          {bool? isLoading, bool? success, String? error, bool clear = false,}) =>
      ActivityFormState(
        isLoading: isLoading ?? this.isLoading,
        success: success ?? this.success,
        error: clear ? null : error ?? this.error,
      );
}

class ActivityFormNotifier extends StateNotifier<ActivityFormState> {
  final ActivityRepository _repo;
  final int? activityId;
  ActivityFormNotifier(this._repo, {this.activityId})
      : super(const ActivityFormState());

  Future<void> submit({
    required String name,
    required String? description,
    required DateTime date,
    required ActivityCategory category,
    String? groupName,
    int? maxParticipants,
  }) async {
    state = state.copyWith(isLoading: true, clear: true);
    try {
      if (activityId != null) {
        await _repo.update(activityId!, {
          'name': name,
          'description': description,
          'date': date.toIso8601String(),
          'category': category.jsonValue,
          'groupName': groupName,
          'maxParticipants': maxParticipants,
        });
      } else {
        await _repo.create({
          'name': name,
          'description': description,
          'date': date.toIso8601String(),
          'category': category.jsonValue,
          'groupName': groupName,
          'maxParticipants': maxParticipants,
        });
      }
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Erreur lors de la sauvegarde : $e',);
    }
  }

  void clearError() => state = state.copyWith(clear: true);
}

final activityFormProvider = StateNotifierProvider.family<ActivityFormNotifier,
    ActivityFormState, int?>(
  (ref, id) =>
      ActivityFormNotifier(ref.read(activityRepositoryProvider), activityId: id),
);