import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/project.dart';
import '../data/project_repository.dart';
 
class ProjectListState {
  final List<Project> items;
  final bool isLoading, hasMore;
  final int page;
  final String? error, statusFilter;
  const ProjectListState({this.items = const [], this.isLoading = false,
    this.hasMore = true, this.page = 0, this.error, this.statusFilter});
  ProjectListState copyWith({List<Project>? items, bool? isLoading, bool? hasMore,
    int? page, String? error, String? statusFilter, bool clearError = false}) =>
    ProjectListState(items: items ?? this.items, isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore, page: page ?? this.page,
      error: clearError ? null : error ?? this.error, statusFilter: statusFilter ?? this.statusFilter);
}
 
class ProjectListNotifier extends StateNotifier<ProjectListState> {
  final ProjectRepository _repo;
  ProjectListNotifier(this._repo) : super(const ProjectListState()) { load(); }
  Future<void> load({bool refresh = false}) async {
    if (state.isLoading) return;
    final page = refresh ? 0 : state.page;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final res = await _repo.fetchAll(page: page, status: state.statusFilter);
      final items = refresh ? res.content : [...state.items, ...res.content];
      state = state.copyWith(items: items, isLoading: false, hasMore: res.hasMore, page: page + 1);
    } catch (e) { state = state.copyWith(isLoading: false, error: e.toString()); }
  }
  void setStatus(String? s) { state = state.copyWith(statusFilter: s); load(refresh: true); }
  Future<void> refresh() => load(refresh: true);
}
 
final projectListProvider = StateNotifierProvider<ProjectListNotifier, ProjectListState>((ref) =>
    ProjectListNotifier(ref.read(projectRepositoryProvider)));
  