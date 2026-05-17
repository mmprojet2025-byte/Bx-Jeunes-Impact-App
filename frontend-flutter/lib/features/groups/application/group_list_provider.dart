import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/group.dart';
import '../data/group_repository.dart';
 
final groupListProvider = FutureProvider<List<Group>>((ref) async {
  final res = await ref.read(groupRepositoryProvider).fetchAll();
  return res.content;
});
