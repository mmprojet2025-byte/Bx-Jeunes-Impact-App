import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Indicateur de chargement centré — utilisé dans les écrans qui
/// n'ont pas encore de skeleton loader.
class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingIndicator({super.key, this.size = 36, this.color});

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: size, height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: color ?? AppColors.primary,
      ),
    ),
  );
}
