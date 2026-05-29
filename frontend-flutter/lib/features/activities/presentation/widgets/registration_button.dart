import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/registration.dart';

class RegistrationButton extends StatelessWidget {
  final Registration? registration;
  final bool isLoading;
  final VoidCallback? onRegister;
  final VoidCallback? onCancel;

  const RegistrationButton({
    super.key,
    this.registration,
    this.isLoading = false,
    this.onRegister,
    this.onCancel,
  });

  bool get _isRegistered =>
      registration != null && registration!.status.isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : _isRegistered
                ? onCancel
                : onRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isRegistered ? AppColors.enAttente : AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5,),)
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(_isRegistered ? Icons.cancel_outlined : Icons.add_circle_outline,
                    size: 20,),
                const SizedBox(width: 8),
                Text(
                    _isRegistered
                        ? 'Annuler mon inscription'
                        : 'S\'inscrire à cette activité',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold,),),
              ],),
      ),
    );
  }
}