import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/project_repository.dart';
 
class ProjectFormState {
  final bool isLoading, success;
  final String? error;
  const ProjectFormState({this.isLoading = false, this.success = false, this.error});
  ProjectFormState copyWith({bool? isLoading, bool? success, String? error, bool clearError = false}) =>
    ProjectFormState(isLoading: isLoading ?? this.isLoading, success: success ?? this.success,
      error: clearError ? null : error ?? this.error);
}
 
class ProjectFormNotifier extends StateNotifier<ProjectFormState> {
  final ProjectRepository _repo;
  ProjectFormNotifier(this._repo) : super(const ProjectFormState());
  Future<bool> save(Map<String, dynamic> body, {int? id}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      id != null ? await _repo.update(id, body) : await _repo.create(body);
      state = state.copyWith(isLoading: false, success: true); return true;
    } catch (e) { state = state.copyWith(isLoading: false, error: e.toString()); return false; }
  }
}
 
final projectFormProvider = StateNotifierProvider.autoDispose<ProjectFormNotifier, ProjectFormState>((ref) =>
    ProjectFormNotifier(ref.read(projectRepositoryProvider)));
    