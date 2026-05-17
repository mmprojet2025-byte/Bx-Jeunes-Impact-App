import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/models/paginated_response.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'project.dart';
 
class ProjectRepository {
  final ApiService _api;
  ProjectRepository(this._api);
 
  Future<PaginatedResponse<Project>> fetchAll({int page = 0, String? status}) =>
    _api.get<PaginatedResponse<Project>>(AppConfig.projectsEndpoint,
      queryParams: {if (status != null) 'status': status, 'page': page, 'size': 20},
      fromJson: (j) => PaginatedResponse.fromJson(j as Map<String, dynamic>,
          (e) => Project.fromJson(e as Map<String, dynamic>)));
 
  Future<PaginatedResponse<Project>> fetchMine({int page = 0}) =>
    _api.get<PaginatedResponse<Project>>('\${AppConfig.projectsEndpoint}/mine',
      queryParams: {'page': page, 'size': 20},
      fromJson: (j) => PaginatedResponse.fromJson(j as Map<String, dynamic>,
          (e) => Project.fromJson(e as Map<String, dynamic>)));
 
  Future<Project> fetchById(int id) =>
    _api.get<Project>('\${AppConfig.projectsEndpoint}/\$id',
      fromJson: (j) => Project.fromJson(j as Map<String, dynamic>));
 
  Future<Project> create(Map<String, dynamic> body) =>
    _api.post<Project>(AppConfig.projectsEndpoint, body: body,
      fromJson: (j) => Project.fromJson(j as Map<String, dynamic>));
 
  Future<Project> update(int id, Map<String, dynamic> body) =>
    _api.put<Project>('\${AppConfig.projectsEndpoint}/\$id', body: body,
      fromJson: (j) => Project.fromJson(j as Map<String, dynamic>));
 
  Future<Project> validate(int id, String newStatus, {String? comment}) =>
    _api.put<Project>('\${AppConfig.projectsEndpoint}/\$id/validate',
      body: {'newStatus': newStatus, if (comment != null) 'comment': comment},
      fromJson: (j) => Project.fromJson(j as Map<String, dynamic>));
}
 
final projectRepositoryProvider = Provider<ProjectRepository>((ref) =>
    ProjectRepository(ref.read(apiServiceProvider)));

