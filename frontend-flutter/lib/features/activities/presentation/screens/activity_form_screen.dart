import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class ActivityFormScreen extends StatelessWidget {
  final int? activityId;
  const ActivityFormScreen({super.key, this.activityId});
 
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
