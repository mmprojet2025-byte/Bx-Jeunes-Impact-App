# Lance l'application Flutter contre le backend local.
#
# Backend attendu sur :
#   Android emulator → http://10.0.2.2:8080  (alias de localhost depuis l'émulateur)
#   iOS simulator    → http://localhost:8080
#
# Usage :
#   chmod +x run-local.sh   (une seule fois)
#   ./run-local.sh
#   ./run-local.sh -d chrome          (web)
#   ./run-local.sh -d "iPhone 15"     (simulateur iOS spécifique)
 
set -e
 
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  Bx-Jeunes Impact — ENV: LOCAL           ║"
echo "║  Backend: http://localhost:8080           ║"
echo "╚══════════════════════════════════════════╝"
echo ""
 
flutter run \
  --dart-define=ENV=local \
  --dart-define=API_BASE_URL=http://10.0.2.2:8080 \
  "$@"
 