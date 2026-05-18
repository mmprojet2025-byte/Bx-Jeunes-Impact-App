# Lance l'application Flutter en mode PRODUCTION.
#
# ⚠️  TODO : remplacer API_BASE_URL par l'URL de production réelle
#            avant d'activer ce script.
#
# Usage :
#   chmod +x run-prod.sh   (une seule fois)
#   ./run-prod.sh                             (run sur device connecté)
#   ./run-prod.sh --release                   (build release)
#   ./run-prod.sh build apk --release         (APK Android)
#   ./run-prod.sh build ipa                   (iOS)
 
set -e
 
# ─── À CONFIGURER ─────────────────────────────────────────────
PROD_API_URL="https://api.bxjeunesimpact.be"   # ← remplacer par l'URL réelle
# ──────────────────────────────────────────────────────────────
 
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  Bx-Jeunes Impact — ENV: PRODUCTION          ║"
echo "║  Backend: $PROD_API_URL  ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "⚠️  Vous êtes en PRODUCTION — vérifiez deux fois avant de continuer."
echo ""
read -r -p "Continuer ? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Annulé."
  exit 0
fi
echo ""
 
flutter run \
  --dart-define=ENV=prod \
  --dart-define=API_BASE_URL="$PROD_API_URL" \
  --release \
  "$@"
 