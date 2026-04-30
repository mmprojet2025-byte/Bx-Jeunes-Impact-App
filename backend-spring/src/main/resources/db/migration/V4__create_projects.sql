CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    status project_status_enum DEFAULT 'PENDING',
    creator_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    group_id BIGINT REFERENCES groups(id) ON DELETE SET NULL,
    
    validated_by_referent_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    referent_validation_date TIMESTAMP,
    referent_validation_comment TEXT,
    
    validated_by_admin_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    admin_validation_date TIMESTAMP,
    admin_validation_comment TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);