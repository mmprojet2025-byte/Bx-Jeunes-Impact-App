import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class LoadingIndicator extends StatelessWidget {
  final double size;
  const LoadingIndicator({super.key, this.size = 24});
 
  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: size, height: size,
      child: const CircularProgressIndicator(
          color: AppColors.red, strokeWidth: 2.5),
    ),
  );
}
