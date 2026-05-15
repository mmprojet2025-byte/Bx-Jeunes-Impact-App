import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'auth_provider.dart';
 
/// Convenience provider — returns the current logged-in user (nullable)
final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authProvider).user;
});
