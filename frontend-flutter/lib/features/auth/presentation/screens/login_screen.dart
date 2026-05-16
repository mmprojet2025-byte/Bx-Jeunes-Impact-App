import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/bx_logo.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
import '../../application/login_provider.dart';
 
class LoginScreen extends ConsumerStatefulWidget {
  /// URL vers laquelle rediriger après un login réussi (depuis query param ?redirect=)
  final String? redirectTo;
 
  const LoginScreen({super.key, this.redirectTo});
 
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _obscure = true;
 
  late final AnimationController _ac =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 650))
        ..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ac, curve: Curves.easeOut);
  late final Animation<Offset> _slide =
      Tween(begin: const Offset(0, .07), end: Offset.zero)
          .animate(CurvedAnimation(parent: _ac, curve: Curves.easeOut));
 
  @override
  void dispose() {
    _ac.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }
 
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
 
    final success = await ref.read(loginProvider.notifier).login(
      email:    _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );
 
    if (success && mounted) {
      // Redirige vers la destination initiale ou l'accueil
      if (widget.redirectTo != null && widget.redirectTo!.isNotEmpty) {
        context.go(Uri.decodeComponent(widget.redirectTo!));
      } else {
        context.goNamed(RouteNames.home);
      }
    }
  }
 
  void _goForgotPassword() => context.pushNamed(RouteNames.forgotPassword);
  void _goRegister()        => context.pushNamed(RouteNames.register);
 
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
 
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(children: [
          const Positioned(bottom: -10, left: -20, child: BlobDecoration()),
          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 52),
                        const BxLogo(),
                        const SizedBox(height: 44),
 
                        CustomTextField(
                          controller: _emailCtrl,
                          label: 'Email',
                          hint: 'exemple@email.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Email requis';
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())) {
                              return 'Format d\'email invalide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
 
                        CustomTextField(
                          controller: _passCtrl,
                          label: 'Mot de passe',
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline,
                          obscure: _obscure,
                          onToggleObscure: () => setState(() => _obscure = !_obscure),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: _login,
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Mot de passe requis' : null,
                        ),
                        const SizedBox(height: 10),
 
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _goForgotPassword,
                            child: const Text('Mot de passe oublié ?',
                                style: TextStyle(color: AppColors.red,
                                    fontSize: 13, fontWeight: FontWeight.w500,),),
                          ),
                        ),
 
                        if (loginState.error != null) ...[
                          const SizedBox(height: 14),
                          _ErrorBanner(
                            message: loginState.error!,
                            onClose: () =>
                                ref.read(loginProvider.notifier).clearError(),
                          ),
                        ],
                        const SizedBox(height: 26),
 
                        PrimaryButton(
                          label: 'Se connecter',
                          loading: loginState.isLoading,
                          onTap: _login,
                        ),
                        const SizedBox(height: 22),
 
                        const Row(children: [
                          Expanded(child: Divider(color: AppColors.border)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text('ou', style: TextStyle(
                                color: AppColors.textSecondary, fontSize: 13,),),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],),
                        const SizedBox(height: 22),
 
                        _GoogleButton(onTap: () {}), // TODO: OAuth
                        const SizedBox(height: 34),
 
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Text('Pas encore de compte ? ',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),),
                          GestureDetector(
                            onTap: _goRegister,
                            child: const Text('Créer un compte',
                                style: TextStyle(color: AppColors.red,
                                    fontSize: 14, fontWeight: FontWeight.bold,),),
                          ),
                        ],),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
 
class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  const _ErrorBanner({required this.message, required this.onClose});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.refuse.withOpacity(.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.refuse.withOpacity(.3)),
      ),
      child: Row(children: [
        const Icon(Icons.error_outline, color: AppColors.refuse, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(message,
            style: const TextStyle(fontSize: 13, color: AppColors.refuse),),),
        GestureDetector(onTap: onClose,
            child: const Icon(Icons.close, color: AppColors.refuse, size: 16),),
      ],),
    );
  }
}
 
class _GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GoogleButton({required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, height: 52,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1.5),),
            child: const Center(child: Text('G',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                    color: Color(0xFF4285F4),),),),
          ),
          const SizedBox(width: 10),
          const Text('Continuer avec Google',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,),),
        ],),
      ),
    );
  }
}
