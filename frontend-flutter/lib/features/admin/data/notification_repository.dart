import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import 'notification_models.dart';

class NotificationRepository {
  final ApiService _api;
  NotificationRepository(this._api);

  Future<List<AppNotification>> fetchHistory() =>
      _api.get<List<dynamic>>('${AppConfig.statsEndpoint}/notifications',
          fromJson: (j) => (j as List)
              .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
              .toList());

  Future<void> send(NotificationSendRequest req) =>
      _api.post<void>('/notifications', body: req.toJson());
}

final notificationRepositoryProvider =
    Provider<NotificationRepository>((ref) =>
        NotificationRepository(ref.read(apiServiceProvider)));