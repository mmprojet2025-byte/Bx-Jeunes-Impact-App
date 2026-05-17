import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PhotoUploadWidget extends StatelessWidget {
  final String? currentUrl;
  final VoidCallback onTap;
  const PhotoUploadWidget({required this.onTap, super.key, this.currentUrl});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.upload_outlined, color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text('Changer la photo de profil',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary)),
          ]),
        ),
      );
}