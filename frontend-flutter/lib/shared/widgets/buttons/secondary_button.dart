import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double height;
  final IconData? icon;
 
  const SecondaryButton({
    super.key,
    required this.label,
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
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.red,
          side: const BorderSide(color: AppColors.red),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: icon != null
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(icon, size: 18),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ])
            : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
