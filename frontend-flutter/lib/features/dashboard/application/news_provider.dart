import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_config.dart';
import '../../../features/dashboard/data/news.dart';
import '../../../shared/providers/api_service_provider.dart';

final newsListProvider =
    AsyncNotifierProvider<NewsListNotifier, List<News>>(NewsListNotifier.new);

class NewsListNotifier extends AsyncNotifier<List<News>> {
  @override
  Future<List<News>> build() async {
    final api = ref.read(apiServiceProvider);
    final data = await api.get<List<dynamic>>(AppConfig.newsEndpoint);
    return (data as List)
        .map((e) => News.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}