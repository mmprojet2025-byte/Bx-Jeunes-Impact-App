import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/bx_logo.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
import '../../application/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  final _passFocus = FocusNode();
  bool _obscure = true;

  bool get _canSubmit => _emailCtrl.text.trim().isNotEmpty && _passCtrl.text.isNotEmpty;

  late final AnimationController _ac = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 650))..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ac, curve: Curves.easeOut);
  late final Animation<Offset> _slide =
      Tween(begin: const Offset(0, .06), end: Offset.zero)
          .animate(CurvedAnimation(parent: _ac, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => setState(() {}));
    _passCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ac.dispose(); _emailCtrl.dispose(); _passCtrl.dispose(); _passFocus.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate() || !_canSubmit) return;

    final success = await ref.read(loginProvider.notifier).login(
      email: _emailCtrl.text.trim(), password: _passCtrl.text,
    );

    // FIX: read ?redirect= query param and navigate there after login
    if (success && mounted) {
      final redirect = GoRouterState.of(context).uri.queryParameters['redirect'];
      if (redirect != null && redirect.isNotEmpty) {
        context.go(Uri.decodeComponent(redirect));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // FIX: BlobDecoration is defined in bx_logo.dart — import is sufficient
            const Positioned(bottom: -10, left: -20, child: BlobDecoration()),
            SafeArea(
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: LayoutBuilder(builder: (context, constraints) {
                    final wide = constraints.maxWidth >= 500;
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: wide ? (constraints.maxWidth - 420) / 2 : 28),
                      child: _buildForm(state, wide),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(LoginState state, bool wide) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: wide ? 32 : 52),
        const BxLogo(),
        SizedBox(height: wide ? 28 : 44),

        CustomTextField(
          controller: _emailCtrl, label: 'Email', hint: 'exemple@email.com',
          prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: () => FocusScope.of(context).requestFocus(_passFocus),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Email requis';
            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
              return 'Format d\'email invalide';
            return null;
          },
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: _passCtrl, label: 'Mot de passe', hint: '••••••••',
          prefixIcon: Icons.lock_outline, obscure: _obscure,
          onToggleObscure: () => setState(() => _obscure = !_obscure),
          textInputAction: TextInputAction.done, onFieldSubmitted: _login,
          validator: (v) => (v == null || v.isEmpty) ? 'Mot de passe requis' : null,
        ),
        const SizedBox(height: 10),

        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => context.pushNamed(RouteNames.forgotPassword),
            child: const Text('Mot de passe oublié ?',
                style: TextStyle(color: AppColors.red, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ),

        if (state.error != null) ...[
          const SizedBox(height: 14),
          _ErrorBanner(message: state.error!,
              onClose: () => ref.read(loginProvider.notifier).clearError()),
        ],
        const SizedBox(height: 26),

        PrimaryButton(
          label: 'Se connecter', loading: state.isLoading,
          onTap: _canSubmit && !state.isLoading ? _login : null,
        ),
        const SizedBox(height: 22),

        Row(children: [
          Expanded(child: Divider(color: AppColors.border)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text('ou', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
          Expanded(child: Divider(color: AppColors.border)),
        ]),
        const SizedBox(height: 22),

        _GoogleButton(onTap: () { /* TODO: OAuth V2 */ }),
        const SizedBox(height: 34),

        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Nouveau ici ? ',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          GestureDetector(
            onTap: () => context.pushNamed(RouteNames.register),
            child: const Text('Créer un compte',
                style: TextStyle(color: AppColors.red, fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ]),
        const SizedBox(height: 48),
      ]),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  const _ErrorBanner({required this.message, required this.onClose});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.refuse.withOpacity(.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.refuse.withOpacity(.3)),
    ),
    child: Row(children: [
      const Icon(Icons.error_outline, color: AppColors.refuse, size: 18),
      const SizedBox(width: 8),
      Expanded(child: Text(message, style: const TextStyle(fontSize: 13, color: AppColors.refuse))),
      GestureDetector(onTap: onClose, child: const Icon(Icons.close, color: AppColors.refuse, size: 16)),
    ]),
  );
}

class _GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GoogleButton({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity, height: 52,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 22, height: 22,
          decoration: BoxDecoration(shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5)),
          child: const Center(child: Text('G',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF4285F4)))),
        ),
        const SizedBox(width: 10),
        const Text('Continuer avec Google',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      ]),
    ),
  );
}
