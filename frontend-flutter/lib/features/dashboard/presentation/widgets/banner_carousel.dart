import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});
 
  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}
 
class _BannerCarouselState extends State<BannerCarousel> {
  int _page = 0;
  final _ctrl = PageController();
 
  static const _banners = [
    (
      text: 'Ensemble,\nfaisons la différence\naujourd\'hui pour\ndemain !',
      c1: AppColors.red,
      c2: Color(0xFFFF6B35),
      icon: Icons.favorite_rounded,
    ),
    (
      text: 'Rejoins des groupes\net collabore avec\nd\'autres jeunes !',
      c1: AppColors.orange,
      c2: AppColors.orangeLight,
      icon: Icons.groups_rounded,
    ),
  ];
 
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
 
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
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.35)),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(b.icon, color: Colors.white, size: 34),
                ),
              ]),
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
            width: _page == i ? 20 : 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: _page == i ? AppColors.red : AppColors.border,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    ]);
  }
}
 