import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/partner_repository.dart';

final partnerListProvider =
    AsyncNotifierProvider<PartnerListNotifier, List<Partner>>(
        PartnerListNotifier.new,);

class PartnerListNotifier extends AsyncNotifier<List<Partner>> {
  @override
  Future<List<Partner>> build() =>
      ref.read(partnerRepositoryProvider).fetchAll();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(partnerRepositoryProvider).fetchAll(),);
  }

  Future<void> delete(int id) async {
    await ref.read(partnerRepositoryProvider).delete(id);
    state = AsyncData(
        state.value!.where((p) => p.id != id).toList(),);
  }
}