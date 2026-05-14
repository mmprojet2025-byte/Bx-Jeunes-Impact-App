# Génère tous les fichiers .g.dart et .freezed.dart pour les modèles freezed.
#
# À lancer depuis frontend-flutter/ après chaque modification d'un modèle.
#
# Usage :
#   chmod +x build_runner.sh   (une seule fois)
#   ./build_runner.sh          # build complet
#   ./build_runner.sh --watch  # mode watch (régénère à chaque sauvegarde)
 
set -e
 
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  Bx-Jeunes Impact — Code generation          ║"
echo "║  freezed + json_serializable → .g.dart       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
 
if [[ "$1" == "--watch" ]]; then
  echo "Mode WATCH activé — Ctrl+C pour arrêter"
  echo ""
  dart run build_runner watch --delete-conflicting-outputs
else
  echo "Build unique..."
  echo ""
  dart run build_runner build --delete-conflicting-outputs
  echo ""
  echo "✅ Génération terminée."
  echo ""
  echo "Fichiers générés :"
  find lib -name "*.g.dart" -o -name "*.freezed.dart" | sort
fi
 