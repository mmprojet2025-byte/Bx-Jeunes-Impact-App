// Repository centralisé pour l'écran d'accueil.
// Expose une seule méthode fetchHomeData() qui déclenche
// les 4 appels API en parallèle via Future.wait.
//
// Endpoints consommés :
//   GET /api/news?pinned=true
//   GET /api/registrations/me
//   GET /api/projects?proposerId=me&active=true
//   GET /api/activities?upcoming=true&limit=3
 
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_config.dart';
import '../../../core/utils/logger.dart';
import '../../../shared/providers/api_service_provider.dart';
import '../../../shared/services/api_service.dart';
import '../../activities/data/activity.dart';
import '../../activities/data/registration.dart';
import '../../projects/data/project.dart';
import 'news.dart';
 
// ── Result value object ───────────────────────────────────────
 
/// Contient toutes les données nécessaires à l'écran d'accueil.
/// Chaque liste peut être vide si l'utilisateur n'a pas de données
/// ou si l'endpoint répond avec une liste vide.
class HomeData {
  final List<News>         pinnedNews;
  final List<Registration> myRegistrations;   // activités inscrites à venir
  final List<Project>      myProjects;         // projets actifs (créateur ou membre)
  final List<Activity>     asblActivities;     // prochaines activités ASBL
 
  const HomeData({
    required this.pinnedNews,
    required this.myRegistrations,
    required this.myProjects,
    required this.asblActivities,
  });
 
  /// Retourne uniquement les inscriptions dont l'activité est à venir
  /// et dont le statut est REGISTERED (filtre côté client en cas
  /// de backend qui renverrait tous les statuts).
  List<Registration> get upcomingRegistrations => myRegistrations
      .where((r) => r.isUpcomingActive)
      .toList()
    ..sort((a, b) => a.activity.date.compareTo(b.activity.date));
 
  /// Les 3 premières activités à venir après filtre.
  List<Registration> get nextThreeRegistrations =>
      upcomingRegistrations.take(3).toList();
}
 
// ── Repository ────────────────────────────────────────────────
 
class DashboardRepository {
  final ApiService _api;
 
  DashboardRepository(this._api);
 
  /// Charge toutes les données de l'accueil en parallèle.
  /// Lance les 4 requêtes simultanément — temps total ≈ max(t1, t2, t3, t4).
  Future<HomeData> fetchHomeData() async {
    AppLogger.info('Fetching home data in parallel…', tag: 'DashboardRepository');
 
    final results = await Future.wait([
      _fetchPinnedNews(),
      _fetchMyRegistrations(),
      _fetchMyProjects(),
      _fetchAsblActivities(),
    ]);
 
    return HomeData(
      pinnedNews:      results[0] as List<News>,
      myRegistrations: results[1] as List<Registration>,
      myProjects:      results[2] as List<Project>,
      asblActivities:  results[3] as List<Activity>,
    );
  }
 
  // ── Requêtes individuelles ────────────────────────────────
 
  /// GET /api/news?pinned=true
  /// Retourne max 2 news épinglées pour le carousel.
  Future<List<News>> _fetchPinnedNews() async {
    try {
      final data = await _api.get<List<dynamic>>(
        AppConfig.newsEndpoint,
        queryParams: {'pinned': true},
      );
      final list = data
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .where((n) => n.pinned)
          .take(2)           // max 2 dans le carousel
          .toList();
      AppLogger.info('Pinned news: ${list.length}', tag: 'DashboardRepository');
      return list;
    } catch (e) {
      AppLogger.warning('Failed to fetch pinned news: $e', tag: 'DashboardRepository');
      return [];             // section vide, pas d'erreur bloquante
    }
  }
 
  /// GET /api/registrations/me
  /// Récupère toutes les inscriptions de l'utilisateur connecté.
  /// Le filtre "à venir + REGISTERED" est appliqué dans HomeData.
  Future<List<Registration>> _fetchMyRegistrations() async {
    try {
      final data = await _api.get<List<dynamic>>('/registrations/me');
      final list = data
          .map((e) => Registration.fromJson(e as Map<String, dynamic>))
          .toList();
      AppLogger.info('My registrations: ${list.length}', tag: 'DashboardRepository');
      return list;
    } catch (e) {
      AppLogger.warning('Failed to fetch registrations: $e', tag: 'DashboardRepository');
      return [];
    }
  }
 
  /// GET /api/projects?proposerId=me&active=true
  /// Projets dont l'utilisateur est créateur OU membre actif.
  Future<List<Project>> _fetchMyProjects() async {
    try {
      final data = await _api.get<List<dynamic>>(
        AppConfig.projectsEndpoint,
        queryParams: {'proposerId': 'me', 'active': true},
      );
      final list = data
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .where((p) => p.status.isActive)
          .toList();
      AppLogger.info('My projects: ${list.length}', tag: 'DashboardRepository');
      return list;
    } catch (e) {
      AppLogger.warning('Failed to fetch projects: $e', tag: 'DashboardRepository');
      return [];
    }
  }
 
  /// GET /api/activities?upcoming=true&limit=3
  /// Les 3 prochaines activités proposées par l'ASBL (toutes confondues).
  Future<List<Activity>> _fetchAsblActivities() async {
    try {
      final data = await _api.get<List<dynamic>>(
        AppConfig.activitiesEndpoint,
        queryParams: {'upcoming': true, 'limit': 3},
      );
      final list = data
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList();
      AppLogger.info('ASBL activities: ${list.length}', tag: 'DashboardRepository');
      return list;
    } catch (e) {
      AppLogger.warning('Failed to fetch ASBL activities: $e', tag: 'DashboardRepository');
      return [];
    }
  }
}
 
// ── Riverpod provider ─────────────────────────────────────────
 
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.read(apiServiceProvider));
});