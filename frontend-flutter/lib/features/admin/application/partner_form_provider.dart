import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/partner_repository.dart';

class PartnerFormState {
  final bool isLoading;
  final bool success;
  final String? error;
  const PartnerFormState(
      {this.isLoading = false, this.success = false, this.error,});
  PartnerFormState copyWith(
          {bool? isLoading, bool? success, String? error, bool clear = false,}) =>
      PartnerFormState(
          isLoading: isLoading ?? this.isLoading,
          success: success ?? this.success,
          error: clear ? null : error ?? this.error,);
}

class PartnerFormNotifier extends StateNotifier<PartnerFormState> {
  final PartnerRepository _repo;
  final int? partnerId;
  PartnerFormNotifier(this._repo, {this.partnerId})
      : super(const PartnerFormState());

  Future<void> submit(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, clear: true);
    try {
      if (partnerId != null) {
        await _repo.update(partnerId!, data);
      } else {
        await _repo.create(data);
      }
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Erreur : $e',);
    }
  }
}

final partnerFormProvider = StateNotifierProvider.family<PartnerFormNotifier,
    PartnerFormState, int?>(
  (ref, id) => PartnerFormNotifier(ref.read(partnerRepositoryProvider),
      partnerId: id,),
);