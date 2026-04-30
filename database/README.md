## Configuration de l'environnement de développement

### 1. Base de données PostgreSQL

Le backend Spring Boot nécessite une base de données PostgreSQL (version 16 ou supérieure) nommée `bxji_dev`. Vous pouvez l'initialiser de deux manières :

#### Option A : Via Docker (Recommandé)
Si vous avez Docker installé, c'est la méthode la plus rapide. À la racine du projet, exécutez simplement :
```bash
docker-compose up -d

Cette commande lancera une instance PostgreSQL, créera l'utilisateur bxji_user avec le mot de passe bxji_password, et initialisera la base bxji_dev automatiquement.
(Note : si vous utilisez cette méthode, n'oubliez pas de mettre à jour le application.properties pour utiliser ces identifiants).

Option B : Manuellement (via pgAdmin)
Si vous préférez utiliser votre propre installation locale de PostgreSQL :

Connectez-vous à votre serveur PostgreSQL (ex: utilisateur postgres).

Créez une nouvelle base de données nommée bxji_dev.

Assurez-vous que vos identifiants locaux (username et password) correspondent à ceux configurés dans le fichier backend-spring/src/main/resources/application.properties.