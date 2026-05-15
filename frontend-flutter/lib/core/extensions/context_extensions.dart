// Extension sur BuildContext pour accéder facilement aux traductions.
//
// Usage dans un widget :
//   import 'package:bx_jeunes_impact/core/extensions/context_extensions.dart';
//
//   // Accès court (recommandé)
//   Text(context.l10n.loginTitle)
//
//   // Accès classique (identique, plus verbeux)
//   Text(AppLocalizations.of(context)!.loginTitle)
//
// ⚠️  L'extension suppose que le widget est bien sous un MaterialApp
//     qui a les LocalizationsDelegates configurés (cf. app.dart).
//     Si non, AppLocalizations.of(context) retourne null → exception.

import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

extension BuildContextL10n on BuildContext {
  /// Accès rapide aux traductions : context.l10n.xxx
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Version nullable — utile si le contexte peut être hors de MaterialApp
  AppLocalizations? get l10nOrNull => AppLocalizations.of(this);
}