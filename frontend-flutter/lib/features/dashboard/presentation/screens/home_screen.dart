import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bar/bottom_nav_bar.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/section_header.dart';
import '../widgets/activity_card_small.dart';
import '../widgets/project_card_small.dart';
import '../widgets/groups_cta_banner.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
 
  // Mock data — remplacer par des providers Riverpod
  static const _activities = [
    (title: 'Tournoi de Basket',     day: '25', month: 'MAI',
        location: 'Bruxelles',  imgKey: 'basket'),
    (title: 'Atelier Art & Création', day: '28', month: 'MAI',
        location: 'Bruxelles',  imgKey: 'art'),
  ];
 
  static const _projects = [
    (title: 'Clean City Challenge', status: 'En cours',
        statusColor: AppColors.enCours, imgKey: 'city'),
    (title: 'Jeunes & Tech',        status: 'En cours',
        statusColor: AppColors.enCours, imgKey: 'tech'),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(slivers: [
 
          // ── App Bar ──────────────────────────────────────
          SliverToBoxAdapter(child: _buildAppBar()),
 
          // ── Bannière carousel ────────────────────────────
          const SliverToBoxAdapter(child: BannerCarousel()),
 
          // ── Activités à venir ────────────────────────────
          SliverToBoxAdapter(
              child: SectionHeader(
                  title: 'Activités à venir',
                  onSeeAll: () { /* TODO: navigate */ })),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _activities.length,
                itemBuilder: (_, i) {
                  final a = _activities[i];
                  return ActivityCardSmall(
                    title: a.title, day: a.day, month: a.month,
                    location: a.location, imgKey: a.imgKey,
                  );
                },
              ),
            ),
          ),
 
          // ── Projets populaires ───────────────────────────
          SliverToBoxAdapter(
              child: SectionHeader(
                  title: 'Projets populaires',
                  onSeeAll: () { /* TODO: navigate */ })),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 155,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _projects.length,
                itemBuilder: (_, i) {
                  final p = _projects[i];
                  return ProjectCardSmall(
                    title: p.title, status: p.status,
                    statusColor: p.statusColor, imgKey: p.imgKey,
                  );
                },
              ),
            ),
          ),
 
          // ── CTA Groupes ──────────────────────────────────
          const SliverToBoxAdapter(child: GroupsCtaBanner()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ]),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
 
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: const [
              Text('Bonjour ',
                  style: TextStyle(
                      fontSize: 20, color: AppColors.textPrimary)),
              Text('👋', style: TextStyle(fontSize: 20)),
            ]),
            const SizedBox(height: 2),
            const Text('Bienvenue !',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text('Découvre, participe et\nfais la différence !',
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4)),
          ]),
          _NotificationBell(count: 3, onTap: () {}),
        ],
      ),
    );
  }
}
 
// ── Cloche notification locale ────────────────────────────────
 
class _NotificationBell extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _NotificationBell({required this.count, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.notifications_outlined,
              color: AppColors.textPrimary, size: 22),
        ),
        if (count > 0)
          Positioned(
            top: -4, right: -4,
            child: Container(
              width: 18, height: 18,
              decoration: const BoxDecoration(
                  color: AppColors.red, shape: BoxShape.circle),
              child: Center(
                child: Text(count.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
      ]),
    );
  }
}
 