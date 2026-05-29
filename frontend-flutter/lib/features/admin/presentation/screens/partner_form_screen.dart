import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class PartnerFormScreen extends StatelessWidget {
  final int? partnerId;
  const PartnerFormScreen({super.key, this.partnerId});
 
  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.background,
    appBar: CustomAppBar(title: 'Partenaire'),
    body: Center(
      child: Text('À implémenter',
          style: TextStyle(color: AppColors.textSecondary),),
    ),
  );
}
