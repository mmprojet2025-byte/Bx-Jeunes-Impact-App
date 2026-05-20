CREATE TABLE activities (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    date TIMESTAMP NOT NULL,
    category activity_category_enum NOT NULL,
    group_id BIGINT REFERENCES groups(id) ON DELETE SET NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE registrations (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    activity_id BIGINT NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
    status registration_status_enum DEFAULT 'REGISTERED',
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, activity_id)
);