import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../application/project_form_provider.dart';
import '../../../groups/application/group_list_provider.dart';

class ProjectFormScreen extends ConsumerStatefulWidget {
  /// Si non null → mode édition
  final int? projectId;

  const ProjectFormScreen({super.key, this.projectId});

  @override
  ConsumerState<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends ConsumerState<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _needsCtrl = TextEditingController();
  int? _selectedGroupId;
  String? _selectedGroupName;

  bool get _isEdit => widget.projectId != null;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _needsCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final body = <String, dynamic>{
      'title': _titleCtrl.text.trim(),
      'description': _descCtrl.text.trim(),
      if (_needsCtrl.text.trim().isNotEmpty) 'needs': _needsCtrl.text.trim(),
      if (_selectedGroupId != null) 'groupId': _selectedGroupId,
    };

    final ok = await ref
        .read(projectFormProvider.notifier)
        .save(body, id: widget.projectId);

    if (ok && mounted) {
      _showSuccessSnack();
      context.goNamed(RouteNames.projects);
    }
  }

  void _showSuccessSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEdit
              ? 'Projet mis à jour ✓'
              : 'Projet soumis ! Ton référent va l\'examiner.',
          style: const TextStyle(fontFamily: 'Inter'),
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(projectFormProvider);
    final groupsAsync = ref.watch(groupListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: _isEdit ? 'Modifier le projet' : 'Proposer un projet',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Bandeau d'intro ───────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.orange],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline,
                        color: Colors.white, size: 32),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ton idée peut tout changer !',
                            style: AppTypography.onDark(AppTypography.h5),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Décris ton projet et soumets-le à ton référent.',
                            style: AppTypography.onDark(
                                AppTypography.bodySmall),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Titre ─────────────────────────────────────────
              _FieldLabel(text: 'Titre du projet *'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleCtrl,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Ex : Initiation au codage pour les jeunes',
                  prefixIcon: Icon(Icons.title_outlined,
                      color: AppColors.textHint, size: 20),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Le titre est obligatoire'
                    : v.trim().length < 5
                        ? 'Minimum 5 caractères'
                        : null,
              ),

              const SizedBox(height: 18),

              // ── Description ───────────────────────────────────
              _FieldLabel(text: 'Description *'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descCtrl,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Décris ton projet en détail : objectif, public cible, déroulement...',
                  alignLabelWithHint: true,
                ),
                validator: (v) => (v == null || v.trim().length < 20)
                    ? 'Minimum 20 caractères'
                    : null,
              ),

              const SizedBox(height: 18),

              // ── Besoins ───────────────────────────────────────
              _FieldLabel(text: 'Besoins du projet'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _needsCtrl,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText:
                      'Matériel, bénévoles, budget, compétences nécessaires...',
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 18),

              // ── Groupe ────────────────────────────────────────
              _FieldLabel(text: 'Groupe concerné *'),
              const SizedBox(height: 6),
              groupsAsync.when(
                loading: () => Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: AppColors.primary, strokeWidth: 2),
                    ),
                  ),
                ),
                error: (_, __) => const Text(
                    'Impossible de charger les groupes',
                    style: TextStyle(color: AppColors.error)),
                data: (groups) => DropdownButtonFormField<int>(
                  value: _selectedGroupId,
                  decoration: const InputDecoration(
                    hintText: 'Sélectionner un groupe',
                    prefixIcon: Icon(Icons.group_outlined,
                        color: AppColors.textHint, size: 20),
                  ),
                  items: groups
                      .map((g) => DropdownMenuItem(
                            value: g.id,
                            child: Text(g.name),
                          ))
                      .toList(),
                  onChanged: (id) {
                    setState(() {
                      _selectedGroupId = id;
                      _selectedGroupName =
                          groups.firstWhere((g) => g.id == id).name;
                    });
                  },
                  validator: (_) => _selectedGroupId == null
                      ? 'Sélectionne un groupe'
                      : null,
                ),
              ),

              const SizedBox(height: 28),

              // ── Info circuit de validation ────────────────────
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline,
                            color: AppColors.primary, size: 16),
                        const SizedBox(width: 8),
                        Text('Circuit de validation',
                            style: AppTypography.colored(
                                AppTypography.h5, AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _ValidationStep(
                        step: '1', text: 'Tu soumets le projet'),
                    _ValidationStep(
                        step: '2', text: 'Ton référent examine et valide'),
                    _ValidationStep(
                        step: '3', text: 'L\'administrateur valide définitivement'),
                    _ValidationStep(
                        step: '4',
                        text: 'Le projet peut devenir visible aux partenaires',
                        isLast: true),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── Erreur API ────────────────────────────────────
              if (formState.error != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: AppColors.error, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          formState.error!,
                          style: AppTypography.colored(
                              AppTypography.bodySmall, AppColors.error),
                        ),
                      ),
                    ],
                  ),
                ),

              // ── Bouton soumettre ──────────────────────────────
              PrimaryButton(
                label: _isEdit ? 'Enregistrer les modifications' : 'Soumettre le projet',
                loading: formState.isLoading,
                onTap: _submit,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widgets helpers ──────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) => Text(text, style: AppTypography.label);
}

class _ValidationStep extends StatelessWidget {
  final String step;
  final String text;
  final bool isLast;

  const _ValidationStep({
    required this.step,
    required this.text,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: AppTypography.colored(
                    AppTypography.bodySmall, AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
