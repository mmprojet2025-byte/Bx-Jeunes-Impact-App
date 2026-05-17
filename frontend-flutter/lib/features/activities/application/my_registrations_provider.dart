import 'package:bx_jeunes_impact/features/activities/data/registration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/registration_repository.dart';
 
final myRegistrationsProvider = FutureProvider<List<Registration>>((ref) async {
  final raw = await ref.read(registrationRepositoryProvider).fetchMine();
  return raw
      .map((e) => Registration.fromJson(e as Map<String, dynamic>))
      .toList();
});