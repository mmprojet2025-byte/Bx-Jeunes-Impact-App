import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  const SocialLoginButtons({super.key, this.onGoogleTap});
  @override Widget build(BuildContext context) => Column(children: [
    Row(children: [Expanded(child: Divider(color: AppColors.border)),
      const Padding(padding: EdgeInsets.symmetric(horizontal: 14),
        child: Text('ou', style: TextStyle(color: AppColors.textSecondary, fontSize: 13))),
      Expanded(child: Divider(color: AppColors.border))]),
    const SizedBox(height: 20),
    GestureDetector(onTap: onGoogleTap, child: Container(width: double.infinity, height: 52,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 22, height: 22, decoration: BoxDecoration(shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1.5)),
          child: const Center(child: Text('G', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF4285F4))))),
        const SizedBox(width: 10),
        const Text('Continuer avec Google', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      ]))),
  ]);
}
