import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/activity.dart';
import '../data/registration_repository.dart';
 
final myRegistrationsProvider = FutureProvider<List<Registration>>((ref) =>
    ref.read(registrationRepositoryProvider).fetchMine());
