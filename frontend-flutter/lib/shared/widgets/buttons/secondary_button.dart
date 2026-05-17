import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;
  final double height;
  final IconData? icon;

  const SecondaryButton({
    required this.label, super.key,
    this.loading = false,
    this.onTap,
    this.height = 52,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: loading ? null : onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: loading
            ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(
                    color: AppColors.primary, strokeWidth: 2.5),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(label,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}
