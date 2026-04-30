CREATE TABLE partners (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    level partner_level_enum NOT NULL DEFAULT 'SIMPLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sponsorings (
    id BIGSERIAL PRIMARY KEY,
    partner_id BIGINT NOT NULL REFERENCES partners(id) ON DELETE CASCADE,
    project_id BIGINT REFERENCES projects(id) ON DELETE CASCADE,
    activity_id BIGINT REFERENCES activities(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2),
    material_support TEXT,
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (project_id IS NOT NULL OR activity_id IS NOT NULL)
);