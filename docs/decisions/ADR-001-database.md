ADR = Architecture Decision Records

# ADR 001 : Choix du Système de Gestion de Base de Données (SGBD)

**Date :** 2026-04-30
**Statut :** Accepté

## Contexte
Le cahier des charges de l'application Bx-Jeunes Impact impose l'utilisation d'une base de données relationnelle, en laissant le choix entre MySQL et PostgreSQL. Le projet nécessite une gestion stricte des rôles et des statuts de validation (machine à états), ainsi qu'une évolutivité vers des données plus complexes (partenaires, sponsorings, et intégration future d'API externes liées aux transports et à la météo).

## Décision
Nous avons décidé d'utiliser **PostgreSQL 16**.

## Justification
* **Types ENUM natifs :** PostgreSQL gère nativement les énumérations, ce qui garantit l'intégrité des données au niveau de la base pour nos `ProjectStatus` (EN_ATTENTE, VALIDE_REFERENT, etc.) et nos `Role`.
* **Support JSON/JSONB :** Excellent support pour le stockage de données non structurées, indispensable pour anticiper le stockage en cache des réponses des API de mobilité et de qualité de l'air (iRail, STIB, OpenAQ).
* **Déploiement Cloud :** PostgreSQL est le standard de facto et est largement supporté dans les offres gratuites (Render, Railway, Supabase), facilitant le déploiement final.
* **Compatibilité Spring Boot :** Excellente intégration avec Spring Data JPA et Hibernate.

## Conséquences
* Tous les développeurs de l'équipe devront installer PostgreSQL localement ou utiliser le `docker-compose.yml` fourni pour harmoniser les environnements de développement.




# Gestion de la Base de Données (Flyway)

Ce projet utilise **Flyway** pour le versioning et la migration du schéma de base de données. 
**Aucune modification de la base de données ne doit être faite manuellement ou via Hibernate (`ddl-auto=update`).**

## Convention de nommage

Tous les scripts de migration doivent être placés dans le dossier :
`backend-spring/src/main/resources/db/migration`

Le nommage des fichiers est strict et doit respecter la syntaxe suivante :
`V<Numéro_de_version>__<Description_en_snake_case>.sql`
*(Attention : il y a deux underscores `__` entre la version et la description).*

### Exemples valides :
* `V1__init_schema.sql`
* `V2__create_users_table.sql`
* `V3__add_status_to_projects.sql`

Au démarrage de l'application, Flyway lira ces fichiers dans l'ordre numérique et appliquera les changements manquants dans la base de données. L'historique des migrations exécutées est stocké dans la table `flyway_schema_history`.