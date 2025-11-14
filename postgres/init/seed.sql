CREATE TABLE IF NOT EXISTS HIP_TABLE (
    Id SERIAL PRIMARY KEY,
    healthcare_id TEXT NOT NULL UNIQUE,
    healthcare_license TEXT NOT NULL UNIQUE,
    healthcare_name TEXT NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    availability VARCHAR(15) NOT NULL,
    total_facilities INTEGER NOT NULL, 
    total_mbbs_doc INTEGER NOT NULL,
    total_worker INTEGER NOT NULL, 
    no_of_beds INTEGER NOT NULL,
    date_of_registration TIMESTAMP DEFAULT NOW(),
    password TEXT NOT NULL,
    about VARCHAR(300) NOT NULL,
    country VARCHAR(30) NOT NULL,
    state VARCHAR(20) NOT NULL,
    city VARCHAR(30) NOT NULL,
    landmark VARCHAR(45) NOT NULL
);

INSERT INTO HIP_TABLE (
    healthcare_id,
    healthcare_license,
    healthcare_name,
    email,
    availability,
    total_facilities,
    total_mbbs_doc,
    total_worker,
    no_of_beds,
    password,
    about,
    country,
    state,
    city,
    landmark
) VALUES (
    'HC-001',
    '001',
    'Test User Hospital',
    'testuser@example.com',
    'Yes',
    200,
    58,
    400,
    200,
    '$2a$10$N3q2dzQ11frAPlxpD8WLI.fwVrTY/DWhYMami0E01WIifOhJgjn/u',
    'Leading healthcare facility with modern infrastructure.',
    'India',
    'Karnataka',
    'Bangalore',
    'MG Road'
);


CREATE TABLE IF NOT EXISTS HealthCare_pref (
    Id SERIAL PRIMARY KEY,
    healthcare_id TEXT NOT NULL,
    scheduled_deletion VARCHAR(20),
    profile_viewed INTEGER,
    profile_updated INTEGER NOT NULL,
    account_locked VARCHAR(15) NOT NULL,
    records_created INTEGER NOT NULL,
    records_viewed INTEGER NOT NULL,
    totalrequest_count INTEGER NOT NULL,
    appointmentFee INTEGER NOT NULL,
    isAvailable VARCHAR(20) NOT NULL,
    FOREIGN KEY (healthcare_id) REFERENCES HIP_TABLE(healthcare_id) ON DELETE CASCADE
);

-- Insert matching pref record
INSERT INTO HealthCare_pref (
    healthcare_id,
    scheduled_deletion,
    profile_viewed,
    profile_updated,
    account_locked,
    records_created,
    records_viewed,
    totalrequest_count,
    appointmentFee,
    isAvailable
) VALUES (
    'HC-001',
    false,
    0,
    0,
    false,
    0,
    0,
    50000,
    300,
    true
)
ON CONFLICT DO NOTHING;