import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../models/user.dart';
import 'auth_provider.dart';
 
/// Convenience provider — retourne l'utilisateur connecté (nullable).
/// Les widgets qui n'ont besoin que de l'utilisateur utilisent ce provider
/// au lieu de regarder tout l'AuthState.
final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authProvider).user;
});