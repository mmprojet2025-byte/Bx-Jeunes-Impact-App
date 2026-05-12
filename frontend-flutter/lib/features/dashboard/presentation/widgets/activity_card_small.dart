import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
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
 
  static const _colors = {
    'basket': Color(0xFFE8A87C),
    'art':    Color(0xFF7EB8D4),
    'garden': Color(0xFF8BC4A0),
    'music':  Color(0xFFB39DDB),
    'speech': Color(0xFF80DEEA),
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
    final bgColor = _colors[imgKey] ?? const Color(0xFFCCCCCC);
    final icon    = _icons[imgKey]  ?? Icons.event_outlined;
 
    return GestureDetector(
      onTap: () { /* TODO: navigate to activity detail */ },
      child: Container(
        width: 162,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0C000000),
                blurRadius: 10,
                offset: Offset(0, 3)),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Image + badge date
          Stack(children: [
            Container(
              height: 112,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16)),
              ),
              child: Center(
                  child: Icon(icon,
                      color: Colors.white.withOpacity(.55), size: 48)),
            ),
            Positioned(
              top: 8, left: 8,
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(day,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.1)),
                    Text(month,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            letterSpacing: .5)),
                  ],
                ),
              ),
            ),
          ]),
 
          // Texte
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 5),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 11, color: AppColors.textSecondary),
                    const SizedBox(width: 3),
                    Text(location,
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary)),
                  ]),
                ]),
          ),
        ]),
      ),
    );
  }
}