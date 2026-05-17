import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../data/news.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback? onTap;
  const NewsCard({required this.news, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            if (news.pinned)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.push_pin_outlined, size: 11, color: AppColors.red),
                  SizedBox(width: 3),
                  Text('Épinglé',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.red)),
                ]),
              ),
            const Spacer(),
            Text(DateHelpers.formatShort(news.createdAt ?? DateTime.now()),
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ]),
          const SizedBox(height: 8),
          Text(news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(news.excerpt,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ]),
      ),
    );
  }
}