## Configuration de l'environnement de développement

### 1. Base de données PostgreSQL

Le backend Spring Boot nécessite une base de données PostgreSQL (version 16 ou supérieure) nommée `bxji_dev`. Vous pouvez l'initialiser de deux manières :

#### Option A : Via Docker (Recommandé)
Si vous avez Docker installé, c'est la méthode la plus rapide. Exécutez la commande suivante (en remplaçant le mot de passe par une valeur de votre choix) :
```bash
docker run --name bxji-db -e POSTGRES_USER=bxji_user -e POSTGRES_PASSWORD=VOTRE_MOT_DE_PASSE -e POSTGRES_DB=bxji_dev -p 5432:5432 -d postgres:16
```

Cette commande lancera une instance PostgreSQL, créera l'utilisateur bxji_user avec le mot de passe que vous avez choisi, et initialisera la base bxji_dev automatiquement.
(Note : si vous utilisez cette méthode, reportez ces identifiants dans `DB_USERNAME` et `DB_PASSWORD` du fichier `backend-spring/.env`, voir `backend-spring/.env.example`).

Option B : Manuellement (via pgAdmin)
Si vous préférez utiliser votre propre installation locale de PostgreSQL :

Connectez-vous à votre serveur PostgreSQL (ex: utilisateur postgres).

Créez une nouvelle base de données nommée bxji_dev.

Assurez-vous que vos identifiants locaux (username et password) correspondent à `DB_USERNAME` et `DB_PASSWORD` dans le fichier `backend-spring/.env` (voir `backend-spring/.env.example`).
