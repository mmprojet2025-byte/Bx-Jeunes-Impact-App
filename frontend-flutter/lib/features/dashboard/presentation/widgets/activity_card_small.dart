import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
 
class ActivityCardSmall extends StatelessWidget {
  final String title;
  final String day;
  final String month;
  final String location;
  final String imgKey;
 
  const ActivityCardSmall({
    super.key,
    required this.title,
    required this.day,
    required this.month,
    required this.location,
    required this.imgKey,
  });
 
  // FIX : utilise les couleurs sémantiques d'AppColors au lieu de Color(0x...)
  static const _bgColors = {
    'basket':  AppColors.categoryOuting,    // bleu sport
    'art':     AppColors.categoryTraining,  // violet culture
    'garden':  AppColors.categoryMeeting,   // vert solidarité
    'music':   AppColors.categoryTraining,  // violet
    'speech':  AppColors.info,              // bleu info
  };
 
  static const _icons = {
    'basket': Icons.sports_basketball_outlined,
    'art':    Icons.palette_outlined,
    'garden': Icons.eco_outlined,
    'music':  Icons.music_note_outlined,
    'speech': Icons.record_voice_over_outlined,
  };
 
  @override
  Widget build(BuildContext context) {
    final bgColor = _bgColors[imgKey] ?? AppColors.categoryOther;
    final icon    = _icons[imgKey]    ?? Icons.event_outlined;
 
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 162,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color:      AppColors.shadowLight, // FIX : AppColors au lieu de Color(0x0C000000)
              blurRadius: 10,
              offset:     Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: 112,
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(.85),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16)),
                ),
                child: Center(
                  child: Icon(icon,
                      color: AppColors.textOnPrimary.withOpacity(.55),
                      size: 48),
                ),
              ),
              Positioned(
                top: 8, left: 8,
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(day,
                          style: AppTypography.h4.copyWith(
                              color: AppColors.textOnPrimary,
                              fontSize: 16,
                              height: 1.1)),
                      Text(month,
                          style: AppTypography.caption.copyWith(
                              color: AppColors.textOnPrimary.withOpacity(.7),
                              letterSpacing: .5)),
                    ],
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.h5.copyWith(fontSize: 13)),
                  const SizedBox(height: 5),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 11, color: AppColors.textSecondary),
                    const SizedBox(width: 3),
                    Text(location, style: AppTypography.caption),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
