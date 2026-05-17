import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'registration.dart';
 
class RegistrationRepository {
  final ApiService _api;
  RegistrationRepository(this._api);
 
  Future<List<dynamic>> fetchMine() =>
    _api.get<List<dynamic>>('\${AppConfig.activitiesEndpoint}/my-registrations',
      fromJson: (j) => (j as List).map((e) => Registration.fromJson(e as Map<String,dynamic>)).toList());
 
  Future<Registration> register(int activityId) =>
    _api.post<Registration>('\${AppConfig.activitiesEndpoint}/\$activityId/register',
      fromJson: (j) => Registration.fromJson(j as Map<String,dynamic>));
 
  Future<void> cancel(int registrationId) =>
    _api.delete('/registrations/\$registrationId');
 
  Future<List<dynamic>> fetchAttendance(int activityId) =>
    _api.get<List<dynamic>>('\${AppConfig.activitiesEndpoint}/\$activityId/attendance',
      fromJson: (j) => (j as List).map((e) => Registration.fromJson(e as Map<String,dynamic>)).toList());
 
  Future<Registration> markAttendance(int registrationId, RegistrationStatus status) =>
    _api.put<Registration>('/registrations/\$registrationId/attendance',
      body: {'status': status.jsonValue},
      fromJson: (j) => Registration.fromJson(j as Map<String,dynamic>));

  Future<Object?> fetchForActivity(int activityId) async {}
}
 
final registrationRepositoryProvider = Provider<RegistrationRepository>((ref) =>
    RegistrationRepository(ref.read(apiServiceProvider)));
    