import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/group.dart';
import '../data/group_repository.dart';
 
final groupDetailProvider = FutureProvider.family<Group, int>((ref, id) =>
    ref.read(groupRepositoryProvider).fetchById(id));
 