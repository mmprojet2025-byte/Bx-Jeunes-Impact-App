import 'package:bx_jeunes_impact/features/profile/data/user_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/models/user.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';

class ProfileRepository {
  final ApiService _api;
  ProfileRepository(this._api);

  Future<AppUser> getProfile() => _api.get<AppUser>(
      '${AppConfig.usersEndpoint}/me',
      fromJson: (j) => AppUser.fromJson(j as Map<String, dynamic>));

  Future<AppUser> updateProfile(Map<String, dynamic> data) =>
      _api.put<AppUser>('${AppConfig.usersEndpoint}/me',
          body: data,
          fromJson: (j) => AppUser.fromJson(j as Map<String, dynamic>));

  Future<void> changePassword(String current, String newPass) =>
      _api.post<void>('${AppConfig.usersEndpoint}/me/change-password',
          body: {'currentPassword': current, 'newPassword': newPass});

  Future<void> deleteAccount() =>
      _api.delete('${AppConfig.usersEndpoint}/me');

  Future<UserPreferences> getPreferences() =>
      _api.get<UserPreferences>('${AppConfig.usersEndpoint}/me/preferences',
          fromJson: (j) => UserPreferences.fromJson(j as Map<String, dynamic>));

  Future<UserPreferences> updatePreferences(UserPreferences prefs) =>
      _api.put<UserPreferences>('${AppConfig.usersEndpoint}/me/preferences',
          body: prefs.toJson(),
          fromJson: (j) => UserPreferences.fromJson(j as Map<String, dynamic>));
}

final profileRepositoryProvider = Provider<ProfileRepository>(
    (ref) => ProfileRepository(ref.read(apiServiceProvider)));