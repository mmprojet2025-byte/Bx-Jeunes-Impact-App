# Lance l'application Flutter contre le backend distant (Render — env dev).
#
# Backend : https://bxji-back-dev.onrender.com
#
# ⚠️  Première requête lente (~30s) si le backend Render est en veille
#     (plan gratuit spin-up). C'est normal, pas un bug.
#
# Usage :
#   chmod +x run-dev.sh   (une seule fois)
#   ./run-dev.sh
#   ./run-dev.sh -d chrome          (web)
#   ./run-dev.sh --release          (build release sur dev)
 
set -e
 
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║  Bx-Jeunes Impact — ENV: DEV                         ║"
echo "║  Backend: https://bxji-back-dev.onrender.com         ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
 
flutter run \
  --dart-define=ENV=dev \
  --dart-define=API_BASE_URL=https://bxji-back-dev.onrender.com \
  "$@"
 