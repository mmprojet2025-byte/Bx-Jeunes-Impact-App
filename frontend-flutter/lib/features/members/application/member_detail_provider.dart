import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/groups/data/group.dart';
import '../../../features/groups/data/group_repository.dart';
 
final groupDetailProvider = FutureProvider.family<Group, int>((ref, id) =>
    ref.read(groupRepositoryProvider).fetchById(id));
