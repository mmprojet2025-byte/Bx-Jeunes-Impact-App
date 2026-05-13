# Frontend Flutter

Application mobile/web en Flutter.

# Bx-Jeunes Impact — Frontend Flutter

Application mobile & web Flutter pour les jeunes de Bruxelles.

> **Connecter · Inspirer · Impacter**

---

## Prérequis

| Outil | Version minimale |
|---|---|
| Flutter SDK | 3.0.0 (stable channel) |
| Dart SDK | 3.0.0 |
| Android Studio / VS Code | dernière version stable |
| Xcode | 14+ (build iOS uniquement) |

```bash
# Vérifier l'installation
flutter doctor
```

---

## Installation

```bash
cd frontend-flutter
flutter pub get
```

---

## Lancer l'application — 3 modes d'environnement

L'application cible différents backends selon le contexte.
Les URLs sont injectées au **build** via `--dart-define` — aucun fichier `.env` à gérer.

### Rendre les scripts exécutables (une seule fois)

```bash
chmod +x run-local.sh run-dev.sh run-prod.sh
```

---

### Mode LOCAL — backend sur ta machine

```bash
./run-local.sh
```

| Propriété | Valeur |
|---|---|
| `ENV` | `local` |
| `API_BASE_URL` | `http://10.0.2.2:8080` (émulateur Android) |
| Badge AppBar | 🟠 **LOCAL** |
| Backend requis | Spring Boot lancé localement (`./mvnw spring-boot:run`) |

> **Note Android emulator** : `10.0.2.2` est l'alias réseau de `localhost` de ta machine hôte
> vu depuis l'émulateur Android. Pour iOS Simulator, remplace par `http://localhost:8080`.

Options supplémentaires :

```bash
./run-local.sh -d chrome           # Lancer en web
./run-local.sh -d "iPhone 15"      # Simulateur iOS spécifique
```

---

### Mode DEV — backend distant sur Render

```bash
./run-dev.sh
```

| Propriété | Valeur |
|---|---|
| `ENV` | `dev` |
| `API_BASE_URL` | `https://bxji-back-dev.onrender.com` |
| Badge AppBar | 🔵 **DEV** |
| Backend requis | Aucun (le backend Render tourne en continu) |

> ⚠️ **Render spin-up** : sur le plan gratuit, le backend se met en veille après 15 min d'inactivité.
> La première requête peut prendre ~30 secondes le temps du réveil — c'est normal.

Options supplémentaires :

```bash
./run-dev.sh -d chrome             # Web contre le backend Render
./run-dev.sh --release             # Build release contre dev
```

---

### Mode PROD — production (à configurer)

```bash
./run-prod.sh
```

| Propriété | Valeur |
|---|---|
| `ENV` | `prod` |
| `API_BASE_URL` | À définir dans `run-prod.sh` |
| Badge AppBar | *(aucun badge)* |
| Confirmation | Le script demande une confirmation avant de lancer |

> ⚠️ Remplacer `PROD_API_URL` dans `run-prod.sh` avant d'utiliser ce mode.

---

## Badge d'environnement

Un badge coloré s'affiche dans l'AppBar dès que `ENV != prod` :

| Environnement | Badge | Couleur |
|---|---|---|
| `local` | **LOCAL** | 🟠 Orange |
| `dev` | **DEV** | 🔵 Bleu |
| `prod` | *(aucun)* | — |

Le badge est rendu par `EnvBadge` (`lib/shared/widgets/app_bar/env_badge.dart`).
Il retourne `SizedBox.shrink()` en production — **zéro overhead**.

```dart
// Intégré automatiquement dans CustomAppBar
// Pour le désactiver sur un écran spécifique :
CustomAppBar(
  title: 'Mon écran',
  showEnvBadge: false,
)
```

---

## Architecture

```
lib/
├── core/
│   ├── constants/
│   │   └── app_config.dart        ← URLs, ENV, endpoints, clés storage
│   ├── router/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   └── app_typography.dart
│   └── utils/
│       ├── date_helpers.dart
│       ├── formatters.dart
│       ├── logger.dart
│       └── validators.dart
├── shared/
│   ├── models/                    ← user, role, api_error, paginated_response
│   ├── providers/                 ← auth, api_service, current_user, connectivity
│   ├── services/                  ← ApiService (Dio), AuthInterceptor, RefreshInterceptor,
│   │                                  SecureStorageService, ImageUploadService
│   └── widgets/                   ← boutons, champs, badges, loaders, empty states...
└── features/
    ├── auth/                      ← login, register, forgot password
    ├── dashboard/                 ← home screen, news, stats
    ├── activities/                ← liste, détail, formulaire, présences
    ├── projects/                  ← liste, détail, validation, membres
    ├── profile/                   ← profil, settings, RGPD
    ├── groups/                    ← liste, détail, membres
    ├── members/                   ← liste, détail
    └── admin/                     ← notifications, partenaires
```

---

## Configuration AppConfig

Toutes les constantes partagées sont dans `lib/core/constants/app_config.dart` :

```dart
AppConfig.apiBaseUrl      // URL complète avec /api — injectée par --dart-define
AppConfig.environment     // 'local' | 'dev' | 'prod'
AppConfig.isLocal         // true si ENV == 'local'
AppConfig.isDev           // true si ENV == 'dev'
AppConfig.isProduction    // true si ENV == 'prod'
AppConfig.showDevBadge    // true si ENV != 'prod'
AppConfig.envLabel        // 'LOCAL' | 'DEV' | 'PROD'
```

---

## Dépendances principales

| Package | Version | Usage |
|---|---|---|
| `flutter_riverpod` | ^2.5.1 | State management |
| `dio` | ^5.4.3 | Client HTTP |
| `flutter_secure_storage` | ^9.2.2 | Stockage JWT (AES-256) |
| `go_router` | ^13.2.0 | Navigation |
| `connectivity_plus` | ^6.0.3 | Détection réseau |
| `cached_network_image` | ^3.3.1 | Cache images |
| `fl_chart` | ^0.68.0 | Graphiques stats |

```bash
# Installer / mettre à jour
flutter pub get
```

---

## Tests

```bash
# Tous les tests
flutter test

# Un fichier spécifique
flutter test test/features/auth/login_test.dart

# Avec couverture
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Build de distribution

```bash
# Android APK
flutter build apk --release \
  --dart-define=ENV=prod \
  --dart-define=API_BASE_URL=https://api.bxjeunesimpact.be

# Android App Bundle (Play Store)
flutter build appbundle --release \
  --dart-define=ENV=prod \
  --dart-define=API_BASE_URL=https://api.bxjeunesimpact.be

# iOS
flutter build ipa \
  --dart-define=ENV=prod \
  --dart-define=API_BASE_URL=https://api.bxjeunesimpact.be

# Web
flutter build web \
  --dart-define=ENV=prod \
  --dart-define=API_BASE_URL=https://api.bxjeunesimpact.be
```

---

## Variables d'environnement disponibles

| Variable | Défaut | Description |
|---|---|---|
| `ENV` | `local` | Nom de l'environnement |
| `API_BASE_URL` | `http://10.0.2.2:8080` | URL racine du backend (sans `/api`) |

> Ces variables sont passées via `--dart-define=CLE=VALEUR` et **jamais** stockées dans un fichier commité.

---

*Bx-Jeunes Impact — v1.0.0*
