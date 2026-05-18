// Section 2 — Carousel des actualités épinglées.
// Affiche 1 ou 2 cartes news avec dégradé rouge/orange.
// Skeleton pendant le chargement, section masquée si liste vide.
 
import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../../../shared/widgets/loaders/skeleton_loader.dart';
import '../../data/news.dart';
 
class NewsPinnedCarousel extends StatefulWidget {
  final List<News>? news;    // null = loading, [] = empty (section masquée)
  final void Function(News)? onNewsTap;
 
  const NewsPinnedCarousel({
    required this.news, super.key,
    this.onNewsTap,
  });
 
  @override
  State<NewsPinnedCarousel> createState() => _NewsPinnedCarouselState();
}
 
class _NewsPinnedCarouselState extends State<NewsPinnedCarousel> {
  int _page = 0;
  final _ctrl = PageController();
 
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    // ── Loading ───────────────────────────────────────────
    if (widget.news == null) return _buildSkeleton();
 
    // ── Empty : section masquée complètement ──────────────
    if (widget.news!.isEmpty) return const SizedBox.shrink();
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _ctrl,
            itemCount: widget.news!.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (_, i) => _NewsCard(
              news: widget.news![i],
              onTap: () => widget.onNewsTap?.call(widget.news![i]),
            ),
          ),
        ),
        if (widget.news!.length > 1) ...[
          const SizedBox(height: 10),
          _buildDots(),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
 
  Widget _buildSectionTitle() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'Actualités',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
  );
 
  Widget _buildDots() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(widget.news!.length, (i) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: _page == i ? 20 : 6,
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: _page == i ? AppColors.red : AppColors.border,
          borderRadius: BorderRadius.circular(3),
        ),
      );
    }),
  );
 
  Widget _buildSkeleton() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonBox(width: 120, height: 18, radius: 6),
        const SizedBox(height: 10),
        SkeletonBox(width: double.infinity, height: 140, radius: 16),
      ],
    ),
  );
}
 
// ── Card individuelle ─────────────────────────────────────────
 
class _NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onTap;
 
  const _NewsCard({required this.news, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.red, Color(0xFFFF6B35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3,),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.push_pin_outlined,
                          color: Colors.white, size: 12,),
                      SizedBox(width: 4),
                      Text('Épinglé',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,),),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  DateHelpers.formatShort(news.createdAt ?? DateTime.now()),
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11,),
                ),
              ],
            ),
            const Spacer(),
            Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              news.excerpt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 12,),
            ),
          ],
        ),
      ),
    );
  }
}