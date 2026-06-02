import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_config.dart';
import '../../../features/dashboard/data/statistics_models.dart';
import '../../../shared/providers/api_service_provider.dart';

final statsProvider = AsyncNotifierProvider<StatsNotifier, AppStats>(StatsNotifier.new);

class StatsNotifier extends AsyncNotifier<AppStats> {
  @override
  Future<AppStats> build() async {
    final api = ref.read(apiServiceProvider);
    final data = await api.get<Map<String, dynamic>>(AppConfig.statsEndpoint,
        fromJson: (j) => j as Map<String, dynamic>);
    return AppStats.fromJson(data);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
