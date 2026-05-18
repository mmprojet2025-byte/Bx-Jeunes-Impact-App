import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/models/paginated_response.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'group.dart';
 
class GroupRepository {
  final ApiService _api;
  GroupRepository(this._api);
  Future<PaginatedResponse<Group>> fetchAll({int page = 0}) =>
    _api.get<PaginatedResponse<Group>>(AppConfig.groupsEndpoint,
      queryParams: {'page': page, 'size': 20},
      fromJson: (j) => PaginatedResponse.fromJson(j as Map<String,dynamic>,
          (e) => Group.fromJson(e as Map<String,dynamic>)));
  Future<Group> fetchById(int id) =>
    _api.get<Group>('${AppConfig.groupsEndpoint}/$id',
      fromJson: (j) => Group.fromJson(j as Map<String,dynamic>));
  Future<Group> create(Map<String,dynamic> body) =>
    _api.post<Group>(AppConfig.groupsEndpoint, body: body,
      fromJson: (j) => Group.fromJson(j as Map<String,dynamic>));
  Future<Group> update(int id, Map<String,dynamic> body) =>
    _api.put<Group>('${AppConfig.groupsEndpoint}/$id', body: body,
      fromJson: (j) => Group.fromJson(j as Map<String,dynamic>));
}
 
final groupRepositoryProvider = Provider<GroupRepository>((ref) =>
    GroupRepository(ref.read(apiServiceProvider)));
