import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_config.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../data/project.dart';

final projectDetailProvider =
    AsyncNotifierProvider.family<ProjectDetailNotifier, Project, int>(
  ProjectDetailNotifier.new,
);

class ProjectDetailNotifier extends FamilyAsyncNotifier<Project, int> {
  @override
  Future<Project> build(int arg) async {
    final api = ref.read(apiServiceProvider);
    final data = await api.get<Map<String, dynamic>>(
      '${AppConfig.projectsEndpoint}/$arg',
      fromJson: (j) => j as Map<String, dynamic>,
    );
    return Project.fromJson(data);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(arg));
  }
}
