import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/activity.dart';
import '../data/registration_repository.dart';
 
class AttendanceNotifier extends StateNotifier<AsyncValue<List<Registration>>> {
  final RegistrationRepository _repo;
  final int activityId;
  AttendanceNotifier(this._repo, this.activityId) : super(const AsyncLoading()) { _load(); }
  Future<void> _load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.fetchAttendance(activityId));
  }
  Future<void> mark(int registrationId, RegistrationStatus status) async {
    final updated = await _repo.markAttendance(registrationId, status);
    state = state.whenData((list) => list.map((r) => r.id == registrationId ? updated : r).toList());
  }
  Future<void> refresh() => _load();
}
 
final attendanceProvider = StateNotifierProvider.family<AttendanceNotifier, AsyncValue<List<Registration>>, int>(
    (ref, activityId) => AttendanceNotifier(ref.read(registrationRepositoryProvider), activityId));
