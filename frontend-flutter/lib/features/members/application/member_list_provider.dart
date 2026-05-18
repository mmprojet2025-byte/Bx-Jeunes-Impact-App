import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/member_models.dart';
import '../data/member_repository.dart';
 
class MemberListState {
  final List<MemberSummary> items;
  final bool isLoading, hasMore; final int page; final String? error, search;
  const MemberListState({this.items = const [], this.isLoading = false,
    this.hasMore = true, this.page = 0, this.error, this.search});
  MemberListState copyWith({List<MemberSummary>? items, bool? isLoading, bool? hasMore,
    int? page, String? error, String? search, bool clearError = false}) =>
    MemberListState(items: items ?? this.items, isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore, page: page ?? this.page,
      error: clearError ? null : error ?? this.error, search: search ?? this.search);
}
 
class MemberListNotifier extends StateNotifier<MemberListState> {
  final MemberRepository _repo;
  MemberListNotifier(this._repo) : super(const MemberListState()) { load(); }
  Future<void> load({bool refresh = false}) async {
    if (state.isLoading) return;
    final page = refresh ? 0 : state.page;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final res = await _repo.fetchAll(page: page, search: state.search);
      final items = refresh ? res.content : [...state.items, ...res.content];
      state = state.copyWith(items: items, isLoading: false, hasMore: res.hasMore, page: page + 1);
    } catch (e) { state = state.copyWith(isLoading: false, error: e.toString()); }
  }
  void setSearch(String? q) { state = state.copyWith(search: q); load(refresh: true); }
  Future<void> refresh() => load(refresh: true);
}
 
final memberListProvider = StateNotifierProvider<MemberListNotifier, MemberListState>((ref) =>
    MemberListNotifier(ref.read(memberRepositoryProvider)));
    