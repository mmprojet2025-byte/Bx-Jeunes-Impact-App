import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class ActivityDetailScreen extends StatelessWidget {
  final int activityId;
  const ActivityDetailScreen({required this.activityId, super.key});
 
  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.background,
    appBar: CustomAppBar(title: 'Activité'),
    body: Center(
      child: Text('À implémenter',
          style: TextStyle(color: AppColors.textSecondary),),
    ),
  );
}
