import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'participation_request.dart';
 
class ParticipationRequestRepository {
  final ApiService _api;
  ParticipationRequestRepository(this._api);
 
  Future<List<ParticipationRequest>> fetchForProject(int projectId) =>
    _api.get<List<dynamic>>('\${AppConfig.projectsEndpoint}/\$projectId/participation-requests',
      fromJson: (j) => (j as List).map((e) => ParticipationRequest.fromJson(e as Map<String,dynamic>)).toList());
 
  Future<ParticipationRequest> request(int projectId, {String? message}) =>
    _api.post<ParticipationRequest>('\${AppConfig.projectsEndpoint}/\$projectId/participation-requests',
      body: {if (message != null) 'message': message},
      fromJson: (j) => ParticipationRequest.fromJson(j as Map<String,dynamic>));
 
  Future<ParticipationRequest> respond(int requestId, String status) =>
    _api.put<ParticipationRequest>('/participation-requests/\$requestId',
      body: {'status': status},
      fromJson: (j) => ParticipationRequest.fromJson(j as Map<String,dynamic>));
}
 
final participationRequestRepositoryProvider = Provider<ParticipationRequestRepository>((ref) =>
    ParticipationRequestRepository(ref.read(apiServiceProvider)));
