import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;
 
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });
 
  static const _items = [
    (icon: Icons.home_rounded,            label: 'Accueil'),
    (icon: Icons.calendar_today_rounded,  label: 'Activités'),
    (icon: Icons.work_outline_rounded,    label: 'Projets'),
    (icon: Icons.person_outline_rounded,  label: 'Profil'),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          final item   = _items[i];
          final active = selectedIndex == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 24,
                    color: active ? AppColors.red : AppColors.textSecondary,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          active ? FontWeight.w600 : FontWeight.normal,
                      color:
                          active ? AppColors.red : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
 