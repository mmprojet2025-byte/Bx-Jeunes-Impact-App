import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/activity.dart';
import '../data/activity_repository.dart';
 
class ActivityListState {
  final List<Activity> items;
  final bool isLoading, hasMore;
  final int page;
  final String? error, categoryFilter;
  const ActivityListState({this.items = const [], this.isLoading = false,
    this.hasMore = true, this.page = 0, this.error, this.categoryFilter,});
  ActivityListState copyWith({List<Activity>? items, bool? isLoading, bool? hasMore,
    int? page, String? error, String? categoryFilter, bool clearError = false,}) =>
    ActivityListState(items: items ?? this.items, isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore, page: page ?? this.page,
      error: clearError ? null : error ?? this.error, categoryFilter: categoryFilter ?? this.categoryFilter,);
}
 
class ActivityListNotifier extends StateNotifier<ActivityListState> {
  final ActivityRepository _repo;
  ActivityListNotifier(this._repo) : super(const ActivityListState()) { load(); }
 
  Future<void> load({bool refresh = false}) async {
    if (state.isLoading) return;
    final page = refresh ? 0 : state.page;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final res = await _repo.fetchAll(page: page, category: state.categoryFilter);
      final items = refresh ? res.content : [...state.items, ...res.content];
      state = state.copyWith(items: items, isLoading: false, hasMore: res.hasMore, page: page + 1);
    } catch (e) { state = state.copyWith(isLoading: false, error: e.toString()); }
  }
 
  void setCategory(String? cat) { state = state.copyWith(categoryFilter: cat); load(refresh: true); }
  Future<void> refresh() => load(refresh: true);
}
 
final activityListProvider = StateNotifierProvider<ActivityListNotifier, ActivityListState>((ref) =>
    ActivityListNotifier(ref.read(activityRepositoryProvider)),);