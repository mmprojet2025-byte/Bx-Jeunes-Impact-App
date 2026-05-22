-- ============================================================
-- V8 : Insertion des utilisateurs de test sécurisée
-- ============================================================

-- 1. Créer les groupes de test
INSERT INTO groups (name, description, active)
VALUES
    ('Groupe Créatif', 'Groupe dédié aux projets créatifs et artistiques', true),
    ('Groupe Innovation', 'Groupe dédié aux projets technologiques et innovants', true),
    ('Groupe Solidaire', 'Groupe dédié aux actions de solidarité', true),
    ('Groupe Communication', 'Groupe dédié à la communication et aux médias', true);

-- 2. Insérer les utilisateurs de test (en associant dynamiquement les groupes par leur nom)
INSERT INTO users (email, password, first_name, last_name, group_id, active)
VALUES
    ('jeune@test.com',      '$2a$10$CHBU4/C5FNTqkGdujdnJVOuls6aQVWsNMO1BCWXAr1lqtqo5MZvW6', 'Ajum',  'mariane', (SELECT id FROM groups WHERE name = 'Groupe Créatif'), true),
    ('referent@test.com',    '$2a$10$CHBU4/C5FNTqkGdujdnJVOuls6aQVWsNMO1BCWXAr1lqtqo5MZvW6', 'Fatima', 'Benali',  (SELECT id FROM groups WHERE name = 'Groupe Créatif'), true),
    ('admin@test.com',       '$2a$10$CHBU4/C5FNTqkGdujdnJVOuls6aQVWsNMO1BCWXAr1lqtqo5MZvW6', 'Sarah',  'Dupont',  NULL, true),
    ('partenaire@test.com',  '$2a$10$CHBU4/C5FNTqkGdujdnJVOuls6aQVWsNMO1BCWXAr1lqtqo5MZvW6', 'Marc',   'Lecomte', NULL, true),
    ('superadmin@test.com',  '$2a$10$CHBU4/C5FNTqkGdujdnJVOuls6aQVWsNMO1BCWXAr1lqtqo5MZvW6', 'Benga',  'Admin',   NULL, true),
    ('chef@test.com',        '$2a$10$CHBU4/C5FNTqkGdujdnJVOuls6aQVWsNMO1BCWXAr1lqtqo5MZvW6', 'Karim',  'Mansour', NULL, true);

-- 3. Attribuer les rôles
INSERT INTO user_roles (user_id, role)
VALUES
    ((SELECT id FROM users WHERE email = 'jeune@test.com'),       'YOUTH'),
    ((SELECT id FROM users WHERE email = 'referent@test.com'),    'GROUP_REFERENT'),
    ((SELECT id FROM users WHERE email = 'admin@test.com'),       'ADMIN'),
    ((SELECT id FROM users WHERE email = 'partenaire@test.com'),  'PARTNER'),
    ((SELECT id FROM users WHERE email = 'superadmin@test.com'),  'SUPER_ADMIN'),
    ((SELECT id FROM users WHERE email = 'chef@test.com'),        'PROJECT_MANAGER');

-- 4. Mettre à jour le référent du Groupe Créatif
UPDATE groups
SET referent_id = (SELECT id FROM users WHERE email = 'referent@test.com')
WHERE name = 'Groupe Créatif';