import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user.dart';
import '../../../shared/providers/api_service_provider.dart';
 
final groupMembersProvider = FutureProvider.family<List<AppUser>, int>((ref, groupId) async {
  final api = ref.read(apiServiceProvider);
  final list = await api.get<List<dynamic>>('/groups/$groupId/members',
    fromJson: (j) => j as List<dynamic>);
  return list.map((e) => AppUser.fromJson(e as Map<String,dynamic>)).toList();
});
