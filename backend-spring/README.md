# Backend Spring Boot


## Stratégie de Gestion de Version (Git)

Pour garantir la stabilité du code et faciliter la collaboration, le projet utilise un **Gitflow simplifié**. 

### 1. Stratégie de Branches

*   **`main`** : Branche de production. Le code y est stable et fonctionnel. **Push direct interdit**. Toute modification doit provenir d'une Pull Request (PR) validée depuis `dev` ou d'un `hotfix`.
*   **`dev`** : Branche d'intégration principale. Toutes les nouvelles fonctionnalités y sont fusionnées pour être testées ensemble avant le passage en production.
*   **`feature/<scope>-<id-issue>-<short-name>`** : Branches créées depuis `dev` pour développer une nouvelle fonctionnalité.
    *   *Exemple :* `feature/auth-12-login-jwt`
*   **`bugfix/<id-issue>-<short-name>`** : Branches créées depuis `dev` pour corriger un bug non critique.
*   **`hotfix/<id-issue>-<short-name>`** : Branches créées depuis `main` pour corriger un bug critique en production. Elles doivent être mergées dans `main` ET dans `dev`.

### 2. Conventions de Commit

Nous utilisons la norme **Conventional Commits** pour maintenir un historique propre. Chaque message de commit doit suivre cette structure :
`<type>(<scope optionnel>): <description courte>`

**Types autorisés :**
*   `feat` : Ajout d'une nouvelle fonctionnalité.
*   `fix` : Correction d'un bug.
*   `docs` : Ajout ou modification de la documentation (ex: README, Doc_TFE).
*   `chore` : Tâches de maintenance, configuration (ex: mise à jour de dépendances, setup).
*   `refactor` : Modification du code qui n'ajoute pas de fonctionnalité et ne corrige pas de bug.
*   `test` : Ajout ou modification de tests.

**Exemples :**
*   `feat(auth): ajout de la génération du token JWT`
*   `docs: définition de la stratégie de branches Git (#3)`
*   `chore: initialisation du projet Spring Boot`