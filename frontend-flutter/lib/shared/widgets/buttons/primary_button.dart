import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class PrimaryButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;
  final double height;
 
  const PrimaryButton({
    required this.label, super.key,
    this.loading = false,
    this.onTap,
    this.height = 52,
  });
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          disabledBackgroundColor: AppColors.red.withOpacity(.6),
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: loading
            ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5,),
              )
            : Text(label,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,),),
      ),
    );
  }
}