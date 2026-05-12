# Frontend Flutter

Application mobile/web en Flutter.


Arborescence frontend-flutter

              lib/
├── main.dart
├── app.dart                          # Configuration globale de l'app
│
├── core/                             # Éléments transversaux
│   ├── router/                       # go_router + guards d'authentification
│   ├── theme/                        # Couleurs ASBL (rouge/orange/jaune), styles
│   ├── constants/                    # URLs, durées, tailles
│   └── utils/                        # Validators, formatters, helpers
│
├── shared/                           # Code partagé entre features
│   ├── models/                       # Entités communes (User, ApiError)
│   ├── services/                     # api_service, secure_storage, logger
│   ├── providers/                    # Providers globaux (auth state, current user)
│   └── widgets/                      # Composants réutilisables (AppBar, Cards, Loaders)
│
└── features/                         # Une feature = un domaine métier
    ├── auth/
    │   ├── data/                     # Models spécifiques + Repository
    │   ├── application/              # Providers Riverpod
    │   └── presentation/
    │       ├── screens/              # login_screen, register_screen, forgot_password_screen
    │       └── widgets/              # Composants spécifiques à auth
    ├── dashboard/                    # home_screen, stats_screen
    ├── activities/                   # activity_list, detail, form, attendance
    ├── projects/                     # project_list, detail, form, members
    ├── groups/                       # group_list, detail, form, members
    ├── members/                      # member_list, detail
    ├── profile/                      # profile, edit_profile, settings
    └── admin/                        # partner_list, partner_form, notifications