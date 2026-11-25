# Bx-Jeunes Impact App

Application **mobile et web** de l'ASBL **Bx-Jeunes Impact**, qui centralise les activités, les groupes, les membres et les projets des jeunes. Elle vise à faciliter l'organisation interne de l'association et à encourager la participation des jeunes.

> **État : en cours de développement.** L'authentification et le tableau de bord sont avancés. Les modules Activités et Projets du frontend, ainsi que la sécurisation fine des endpoints, restent à terminer (voir les [tickets ouverts](https://github.com/mmprojet2025-byte/Bx-Jeunes-Impact-App/issues)). L'application n'est pas déployée.

## Fonctionnalités

| Domaine | État |
|---|---|
| Inscription, connexion, utilisateur courant (`/api/auth/*`), refresh token | Backend en place |
| Rôles : `YOUTH`, `GROUP_REFERENT`, `PROJECT_MANAGER`, `PARTNER`, `ADMIN`, `SUPER_ADMIN` | Définis dans le backend |
| Tableau de bord, profil, mot de passe oublié | Frontend en place |
| Activités, projets, groupes, membres, actualités | Modèle de données et API en cours ; écrans frontend à terminer |
| Partenaires et parrainages | Modèle de données prévu |

## Technologies

| Partie | Technologies |
|---|---|
| Frontend | Flutter (Dart 3), Riverpod, GoRouter, Dio, stockage sécurisé des jetons |
| Backend | Java 21, Spring Boot 4, Spring Security, JWT |
| Base de données | PostgreSQL, migrations Flyway (`V1` à `V8`) |

## Structure du dépôt

```text
backend-spring/    API REST (Spring Boot)
frontend-flutter/  application Flutter
database/          configuration de la base de données
docs/              documentation (décisions d'architecture, API, maquettes)
```

## Lancer le projet en local

**Prérequis :** JDK 21, Flutter, PostgreSQL 16 ou plus.

1. **Base de données.** Créer une base PostgreSQL nommée `bxji_dev` (voir [database/README.md](database/README.md)).
2. **Backend.** Les identifiants de la base et la clé JWT sont lus dans des variables d'environnement, jamais dans le code. Copier `backend-spring/.env.example` en `backend-spring/.env`, le remplir (la clé JWT se génère avec `openssl rand -base64 32`), puis :

   ```bash
   cd backend-spring
   set -a; source .env; set +a   # macOS / Linux
   ./mvnw spring-boot:run
   ```

   Sous Windows ou dans un IDE, définir les mêmes variables (`DB_URL`, `DB_USERNAME`, `DB_PASSWORD`, `JWT_SECRET_KEY`) dans la configuration de lancement.

   L'API écoute sur `http://localhost:8081`. Flyway crée les tables au démarrage et la migration `V8` ajoute des comptes de test **réservés au développement**.
3. **Frontend.**

   ```bash
   cd frontend-flutter
   flutter pub get
   flutter run
   ```

   Par défaut, l'application pointe vers le backend local (voir `lib/core/constants/app_config.dart`).

## Sécurité

- Authentification par jetons JWT et refresh tokens.
- La clé JWT et les identifiants de la base sont fournis par variables d'environnement (`backend-spring/.env.example`) ; le fichier `.env` est ignoré par Git.
- Les anciennes valeurs, présentes dans l'historique Git, ne doivent plus être utilisées : générer une nouvelle clé JWT et un nouveau mot de passe de base pour chaque environnement.
- Les comptes de test de la migration `V8` doivent être retirés en production.

## Documentation

- [Décision d'architecture : base de données](docs/decisions/ADR-001-database.md)
- [Documentation de l'API](docs/api_specs.md)
- [Maquettes](docs/figma_links.md) *(lien à compléter)*

## Équipe

Projet réalisé avec l'ASBL Bx-Jeunes Impact par [mmprojet2025-byte](https://github.com/mmprojet2025-byte), M-Anjum et liseben.

## Licence

Aucune licence n'est définie à ce stade : tous droits réservés.
