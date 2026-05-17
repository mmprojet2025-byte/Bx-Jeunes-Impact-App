import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/participation_request.dart';
import '../data/participation_request_repository.dart';
 
final participationRequestsProvider = FutureProvider.family<List<ParticipationRequest>, int>(
    (ref, projectId) => ref.read(participationRequestRepositoryProvider).fetchForProject(projectId));
 