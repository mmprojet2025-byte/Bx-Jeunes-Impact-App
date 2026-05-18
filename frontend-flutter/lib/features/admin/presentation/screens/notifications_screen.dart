import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
 
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: CustomAppBar(title: 'Notifications'),
    body: const Center(
      child: Text('À implémenter',
          style: TextStyle(color: AppColors.textSecondary)),
    ),
  );
}
