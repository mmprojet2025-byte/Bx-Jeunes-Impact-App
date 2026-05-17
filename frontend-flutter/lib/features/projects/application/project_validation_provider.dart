import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/project_repository.dart';
 
class ValidationState {
  final bool isLoading;
  final String? error;
  const ValidationState({this.isLoading = false, this.error});
}
 
class ProjectValidationNotifier extends StateNotifier<ValidationState> {
  final ProjectRepository _repo;
  ProjectValidationNotifier(this._repo) : super(const ValidationState());
  Future<bool> validate(int projectId, String newStatus, {String? comment}) async {
    state = const ValidationState(isLoading: true);
    try {
      await _repo.validate(projectId, newStatus, comment: comment);
      state = const ValidationState(); return true;
    } catch (e) { state = ValidationState(error: e.toString()); return false; }
  }
}
 
final projectValidationProvider = StateNotifierProvider.autoDispose<ProjectValidationNotifier, ValidationState>((ref) =>
    ProjectValidationNotifier(ref.read(projectRepositoryProvider)));
    