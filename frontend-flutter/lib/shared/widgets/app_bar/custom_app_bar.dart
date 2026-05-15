import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;
 
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
  });
 
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      leading: showBack
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: AppColors.textPrimary, size: 16),
              ),
            )
          : null,
      title: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
              color: AppColors.textPrimary)),
      actions: actions,
    );
  }
}
