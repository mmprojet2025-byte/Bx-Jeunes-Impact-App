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