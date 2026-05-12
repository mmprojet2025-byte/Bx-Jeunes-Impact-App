import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/bx_logo.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
 
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ── State ────────────────────────────────────────────────
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool    _obscure = true;
  bool    _loading = false;
  String? _error;
 
  // ── Animations ──────────────────────────────────────────
  late final AnimationController _ac =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 650))
        ..forward();
 
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ac, curve: Curves.easeOut);
 
  late final Animation<Offset> _slide =
      Tween(begin: const Offset(0, .07), end: Offset.zero).animate(
          CurvedAnimation(parent: _ac, curve: Curves.easeOut));
 
  @override
  void dispose() {
    _ac.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }
 
  // ── Actions ──────────────────────────────────────────────
 
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
 
    try {
      // TODO: remplacer par ref.read(loginProvider.notifier).login(...)
      await Future.delayed(const Duration(milliseconds: 1400));
 
      if (!mounted) return;
      // TODO: context.go(RouteNames.home);
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Email ou mot de passe incorrect.');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
 
  void _goForgotPassword() {
    // TODO: context.push(RouteNames.forgotPassword);
    showDialog(
      context: context,
      builder: (_) => _ForgotPasswordDialog(
        onSubmit: (email) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Lien envoyé à $email'),
            backgroundColor: AppColors.enCours,
            behavior: SnackBarBehavior.floating,
          ));
        },
      ),
    );
  }
 
  void _goRegister() {
    // TODO: context.push(RouteNames.register);
  }
 
  void _loginGoogle() {
    // TODO: implémenter OAuth Google
  }
 
  // ── Build ────────────────────────────────────────────────
 
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(children: [
          // Blob décoratif
          const Positioned(
              bottom: -10, left: -20, child: BlobDecoration()),
 
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 52),
                        const BxLogo(),
                        const SizedBox(height: 44),
 
                        // Email
                        CustomTextField(
                          controller: _emailCtrl,
                          label: 'Email',
                          hint: 'exemple@email.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty)
                              return 'Email requis';
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(v.trim()))
                              return 'Format d\'email invalide';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
 
                        // Mot de passe
                        CustomTextField(
                          controller: _passCtrl,
                          label: 'Mot de passe',
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline,
                          obscure: _obscure,
                          onToggleObscure: () =>
                              setState(() => _obscure = !_obscure),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: _login,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Mot de passe requis';
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
 
                        // Mot de passe oublié
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _goForgotPassword,
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
 
                        // Erreur
                        if (_error != null) ...[
                          const SizedBox(height: 14),
                          _ErrorBanner(
                            message: _error!,
                            onClose: () =>
                                setState(() => _error = null),
                          ),
                        ],
                        const SizedBox(height: 26),
 
                        // Bouton connexion
                        PrimaryButton(
                          label: 'Se connecter',
                          loading: _loading,
                          onTap: _login,
                        ),
                        const SizedBox(height: 22),
 
                        // Séparateur
                        Row(children: [
                          Expanded(
                              child: Divider(color: AppColors.border)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text('ou',
                                style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13)),
                          ),
                          Expanded(
                              child: Divider(color: AppColors.border)),
                        ]),
                        const SizedBox(height: 22),
 
                        // Google
                        _GoogleButton(onTap: _loginGoogle),
                        const SizedBox(height: 34),
 
                        // Créer un compte
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Pas encore de compte ? ',
                                style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14)),
                            GestureDetector(
                              onTap: _goRegister,
                              child: const Text('Créer un compte',
                                  style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
 
// ── Widgets locaux ────────────────────────────────────────────
 
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
        Expanded(
            child: Text(message,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.refuse))),
        GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.close,
                color: AppColors.refuse, size: 16)),
      ]),
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
        width: double.infinity,
        height: 52,
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
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: const Center(
              child: Text('G',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4285F4))),
            ),
          ),
          const SizedBox(width: 10),
          const Text('Continuer avec Google',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary)),
        ]),
      ),
    );
  }
}
 
// ── Dialog mot de passe oublié ────────────────────────────────
 
class _ForgotPasswordDialog extends StatefulWidget {
  final void Function(String email) onSubmit;
  const _ForgotPasswordDialog({required this.onSubmit});
 
  @override
  State<_ForgotPasswordDialog> createState() =>
      _ForgotPasswordDialogState();
}
 
class _ForgotPasswordDialogState extends State<_ForgotPasswordDialog> {
  final _ctrl = TextEditingController();
  bool _loading = false;
 
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Réinitialiser',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
            'Entrez votre email pour recevoir un lien de réinitialisation.',
            style: TextStyle(
                color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 16),
        TextField(
          controller: _ctrl,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'exemple@email.com',
            hintStyle:
                const TextStyle(color: AppColors.textHint),
            filled: true,
            fillColor: AppColors.inputBg,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(color: AppColors.textSecondary))),
        ElevatedButton(
          onPressed: _loading
              ? null
              : () async {
                  setState(() => _loading = true);
                  await Future.delayed(const Duration(milliseconds: 800));
                  widget.onSubmit(_ctrl.text.trim());
                },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: _loading
              ? const SizedBox(
                  width: 16, height: 16,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2))
              : const Text('Envoyer'),
        ),
      ],
    );
  }
}
 