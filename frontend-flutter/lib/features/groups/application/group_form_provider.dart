import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/group_repository.dart';
 
class GroupFormState {
  final bool isLoading, success; final String? error;
  const GroupFormState({this.isLoading = false, this.success = false, this.error});
  GroupFormState copyWith({bool? isLoading, bool? success, String? error, bool clearError = false}) =>
    GroupFormState(isLoading: isLoading ?? this.isLoading, success: success ?? this.success,
      error: clearError ? null : error ?? this.error);
}
class GroupFormNotifier extends StateNotifier<GroupFormState> {
  final GroupRepository _repo;
  GroupFormNotifier(this._repo) : super(const GroupFormState());
  Future<bool> save(Map<String,dynamic> body, {int? id}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      id != null ? await _repo.update(id, body) : await _repo.create(body);
      state = state.copyWith(isLoading: false, success: true); return true;
    } catch (e) { state = state.copyWith(isLoading: false, error: e.toString()); return false; }
  }
}
final groupFormProvider = StateNotifierProvider.autoDispose<GroupFormNotifier, GroupFormState>((ref) =>
    GroupFormNotifier(ref.read(groupRepositoryProvider)));
    