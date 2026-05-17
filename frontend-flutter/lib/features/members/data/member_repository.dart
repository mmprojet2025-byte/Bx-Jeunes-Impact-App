import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/models/paginated_response.dart';
import '../../../shared/models/user.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'member_models.dart';
 
class MemberRepository {
  final ApiService _api;
  MemberRepository(this._api);
  Future<PaginatedResponse<MemberSummary>> fetchAll({int page = 0, String? search, int? groupId}) =>
    _api.get<PaginatedResponse<MemberSummary>>(AppConfig.usersEndpoint,
      queryParams: {'page': page, 'size': 20, if (search != null) 'search': search, if (groupId != null) 'groupId': groupId},
      fromJson: (j) => PaginatedResponse.fromJson(j as Map<String,dynamic>,
          (e) => MemberSummary.fromJson(e as Map<String,dynamic>)));
  Future<AppUser> fetchById(int id) =>
    _api.get<AppUser>('${AppConfig.usersEndpoint}/$id',
      fromJson: (j) => AppUser.fromJson(j as Map<String,dynamic>));
}
 
final memberRepositoryProvider = Provider<MemberRepository>((ref) =>
    MemberRepository(ref.read(apiServiceProvider)));
