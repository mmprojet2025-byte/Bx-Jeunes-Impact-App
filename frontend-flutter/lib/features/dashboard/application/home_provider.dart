// Provider Riverpod qui gère l'état complet de l'écran d'accueil.
//
// Pattern : AsyncNotifier<HomeData>
//   - build()   : chargement initial (skeleton loaders côté UI)
//   - refresh() : pull-to-refresh (recharge silencieusement)
//
// L'écran observe homeProvider et réagit aux états :
//   AsyncLoading → skeleton loaders
//   AsyncData    → contenu réel
//   AsyncError   → AppErrorWidget avec bouton retry
 
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../data/dashboard_repository.dart';
import '../data/news.dart';
import '../../activities/data/activity.dart';
import '../../activities/data/registration.dart';
import '../../projects/data/project.dart';
 
// ── Re-export du value object pour simplifier les imports ─────
export '../data/dashboard_repository.dart' show HomeData;
 
// ── AsyncNotifier ─────────────────────────────────────────────
 
class HomeNotifier extends AsyncNotifier<HomeData> {
  DashboardRepository get _repo => ref.read(dashboardRepositoryProvider);
 
  /// Chargement initial — déclenché automatiquement par Riverpod.
  /// L'état passe en AsyncLoading le temps du Future.wait.
  @override
  Future<HomeData> build() => _repo.fetchHomeData();
 
  /// Pull-to-refresh : recharge toutes les données.
  /// Pendant le refresh, l'état reste AsyncData (pas de skeleton).
  /// Le RefreshIndicator détecte la fin via le Future retourné.
  Future<void> refresh() async {
    // On met l'état en loading tout en conservant la valeur précédente
    // (AsyncValue.guard conserve l'ancienne data pendant le rechargement).
    state = const AsyncLoading<HomeData>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _repo.fetchHomeData());
  }
}
 
// ── Provider ──────────────────────────────────────────────────
 
final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeData>(
  HomeNotifier.new,
);
 
// ── Providers dérivés (lecture ciblée, évite de rebuilder tout) ─
 
/// News épinglées (pour le carousel).
final pinnedNewsProvider = Provider<AsyncValue<List<News>>>((ref) {
  return ref.watch(homeProvider).whenData((d) => d.pinnedNews);
});
 
/// Inscriptions actives à venir (max 3).
final myUpcomingRegistrationsProvider =
    Provider<AsyncValue<List<Registration>>>((ref) {
  return ref.watch(homeProvider)
      .whenData((d) => d.nextThreeRegistrations);
});
 
/// Projets actifs de l'utilisateur.
final myProjectsProvider = Provider<AsyncValue<List<Project>>>((ref) {
  return ref.watch(homeProvider).whenData((d) => d.myProjects);
});
 
/// Prochaines activités ASBL (max 3).
final asblActivitiesProvider = Provider<AsyncValue<List<Activity>>>((ref) {
  return ref.watch(homeProvider).whenData((d) => d.asblActivities);
});
 