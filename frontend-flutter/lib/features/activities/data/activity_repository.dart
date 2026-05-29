import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/models/paginated_response.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'activity.dart';
 
class ActivityRepository {
  final ApiService _api;
  ActivityRepository(this._api);
 
  Future<PaginatedResponse<Activity>> fetchAll({int page = 0, String? category}) =>
    _api.get<PaginatedResponse<Activity>>(AppConfig.activitiesEndpoint,
      queryParams: {if (category != null) 'category': category, 'page': page, 'size': 20},
      fromJson: (j) => PaginatedResponse.fromJson(j as Map<String, dynamic>,
          (e) => Activity.fromJson(e as Map<String, dynamic>),),);
 
  Future<Activity> fetchById(int id) =>
    _api.get<Activity>(r'${AppConfig.activitiesEndpoint}/$id',
      fromJson: (j) => Activity.fromJson(j as Map<String, dynamic>),);
 
  Future<Activity> create(Map<String, dynamic> body) =>
    _api.post<Activity>(AppConfig.activitiesEndpoint, body: body,
      fromJson: (j) => Activity.fromJson(j as Map<String, dynamic>),);
 
  Future<Activity> update(int id, Map<String, dynamic> body) =>
    _api.put<Activity>(r'${AppConfig.activitiesEndpoint}/$id', body: body,
      fromJson: (j) => Activity.fromJson(j as Map<String, dynamic>),);
 
  Future<void> delete(int id) => _api.delete(r'${AppConfig.activitiesEndpoint}/$id');
}
 
final activityRepositoryProvider = Provider<ActivityRepository>((ref) =>
    ActivityRepository(ref.read(apiServiceProvider)),);
