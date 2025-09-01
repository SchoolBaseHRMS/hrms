/*

1. Database Design

Database Name: hrms_spcd

*/

-- 1. Talent Pool Identification

CREATE TABLE spcd_talent_pool (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_id VARCHAR(50) NOT NULL,
    department VARCHAR(100),
    position VARCHAR(100),
    potential_level ENUM('High','Medium','Low') NOT NULL,
    date_identified DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.Career Path Mapping

CREATE TABLE spcd_career_path (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    current_position VARCHAR(100),
    target_position VARCHAR(100),
    development_actions TEXT,
    expected_completion_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. High-Potential Employee Tracking

CREATE TABLE spcd_high_potential (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_id VARCHAR(50) NOT NULL,
    department VARCHAR(100),
    potential_score INT,
    last_review_date DATE,
    next_review_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Leadership Development Programs

CREATE TABLE spcd_leadership_program (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_name VARCHAR(100),
    employee_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status ENUM('Ongoing','Completed','Planned'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Role Transition Planning

CREATE TABLE spcd_role_transition (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    current_role VARCHAR(100),
    new_role VARCHAR(100),
    transition_date DATE,
    responsible_manager VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
