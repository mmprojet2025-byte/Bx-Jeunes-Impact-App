import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
 
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});
 
  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}
 
class _BannerCarouselState extends State<BannerCarousel> {
  int _page = 0;
  final _ctrl = PageController();
 
  // FIX : Color(0xFFFF6B35) → AppColors.primaryMedium (défini dans app_colors.dart)
  static const _banners = [
    (
      text: 'Ensemble,\nfaisons la différence\naujourd\'hui pour\ndemain !',
      c1:   AppColors.primary,
      c2:   AppColors.primaryMedium,
      icon: Icons.favorite_rounded,
    ),
    (
      text: 'Rejoins des groupes\net collabore avec\nd\'autres jeunes !',
      c1:   AppColors.secondary,
      c2:   AppColors.tertiary,
      icon: Icons.groups_rounded,
    ),
  ];
 
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      SizedBox(
        height: 140,
        child: PageView.builder(
          controller: _ctrl,
          itemCount: _banners.length,
          onPageChanged: (i) => setState(() => _page = i),
          itemBuilder: (_, i) {
            final b = _banners[i];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [b.c1, b.c2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(children: [
                Expanded(
                  child: Text(b.text,
                      style: AppTypography.h4.copyWith(
                          color: AppColors.textOnPrimary,
                          fontSize: 17,
                          height: 1.35,),),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    // FIX : Colors.white24 → AppColors.textOnPrimary avec opacité
                    color: AppColors.textOnPrimary.withOpacity(.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(b.icon,
                      color: AppColors.textOnPrimary, size: 34,),
                ),
              ],),
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_banners.length, (i) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width:  _page == i ? 20 : 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: _page == i ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    ],);
  }
}
