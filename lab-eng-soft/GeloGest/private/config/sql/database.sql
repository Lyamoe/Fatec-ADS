CREATE DATABASE IF NOT EXISTS gelateria_stock;
USE gelateria_stock;

-- ==================== SCHEMA DEFINITION ==================== 

-- 1. Companies (Multi-tenant root table)
CREATE TABLE IF NOT EXISTS companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(128) NOT NULL UNIQUE
);

-- 2. User Accounts (Linked to a specific company)
CREATE TABLE IF NOT EXISTS user_login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_type ENUM('admin', 'owner', 'user') NOT NULL DEFAULT 'user',
    
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);

-- 3. Container Types / Tubs (Company-specific tare weights)
CREATE TABLE IF NOT EXISTS containers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    container_name VARCHAR(128) NOT NULL, -- e.g., 'Large Shallow', 'Small Deep'
    container_code VARCHAR(10),           -- e.g., 'l-s', 's-d'
    tare_weight_grams INT NOT NULL,        -- Empty weight of the container
    
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE,
    UNIQUE(company_id, container_code)     -- Container code only needs to be unique within the same company
);

-- 4. Gelato Flavors (Company-specific flavor menu)
CREATE TABLE IF NOT EXISTS flavors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    flavor_name VARCHAR(128) NOT NULL,
    
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);

-- 5. Individual Stock Items / Tubs (Physical batches in store)
CREATE TABLE IF NOT EXISTS stock_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    flavor_id INT NOT NULL,
    container_id INT NOT NULL,
    arrival_date DATE NOT NULL,                                 -- Production or arrival date
    best_before_date DATE NOT NULL,                             -- Expiration date
    status ENUM('in_stock', 'display', 'finished', 'discarded') NOT NULL DEFAULT 'in_stock',
    current_gross_weight_grams INT NOT NULL,                    -- Latest registered gross weight
    current_net_weight_grams INT NOT NULL,                      -- Latest net weight (Gross - Tare)
    
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE,
    FOREIGN KEY (flavor_id) REFERENCES flavors(id) ON DELETE CASCADE,
    FOREIGN KEY (container_id) REFERENCES containers(id) ON DELETE RESTRICT
);

-- 6. Weighing History & Daily Audit Logs
CREATE TABLE IF NOT EXISTS daily_stock_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stock_item_id INT NOT NULL,
    user_id INT,
    log_date DATE NOT NULL,
    previous_status ENUM('in_stock', 'display', 'finished', 'discarded'),
    new_status ENUM('in_stock', 'display', 'finished', 'discarded') NOT NULL,
    gross_weight_grams INT NOT NULL,
    net_weight_grams INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (stock_item_id) REFERENCES stock_items(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user_login(id) ON DELETE SET NULL
);

-- ==================== INITIAL SEED DATA ==================== 

-- 1. Insert Companies (Test_Company gets ID 1, Miatto gets ID 2)
INSERT INTO companies (company_name) VALUES 
('Test_Company'),
('Miatto');

-- 2. Insert Admin Users
-- Test_Company Admin (ID 1)
INSERT INTO user_login (company_id, user_name, user_password, user_type)
VALUES (1, 'TestAdmin', '$2y$10$z69sbLvtw7LqV35O8kLv8OqR3Te0Gw4Jvpa38I4BTvlHUIbeeYCri', 'admin');

-- Miatto Admin (ID 2)
INSERT INTO user_login (company_id, user_name, user_password, user_type)
VALUES (2, 'LyamPeres', '$2y$10$z69sbLvtw7LqV35O8kLv8OqR3Te0Gw4Jvpa38I4BTvlHUIbeeYCri', 'admin');

-- 3. Insert Standard Container Types (Assigned to Miatto - ID 2)
INSERT INTO containers (company_id, container_name, container_code, tare_weight_grams) VALUES
(2, 'Grande Rasa',  'g-r', 277),
(2, 'Grande Funda', 'g-f', 341),
(2, 'Pequena Rasa', 'p-r', 379),
(2, 'Pequena Funda', 'p-f', 372),
(2, 'Mini Quadrada', 'm-q', 204);

-- 4. Insert Flavors (Assigned to Miatto - ID 2)
INSERT INTO flavors (company_id, flavor_name) VALUES
(2, '3 Leites'), (2, 'Abacaxi c/ cocada'), (2, 'Amarena'), (2, 'Belga'),
(2, 'Cheesecake'), (2, 'Chiclete'), (2, 'Chocobianco'), (2, 'Chocoblack'),
(2, 'Chocomiatto'), (2, 'Doce de Leite'), (2, 'Flor de leite'), (2, 'Iogurte c/ maracujá'),
(2, 'Kinder'), (2, 'Manga maracujá'), (2, 'Menta'), (2, 'Morango'),
(2, 'Mousse Maracuja'), (2, 'Ninho com brigadeiro'), (2, 'Palha italiana'),
(2, 'Pé de moleque'), (2, 'Pistache'), (2, 'Rafaello'), (2, 'Reeses'), (2, 'Torta de limão');

-- 5. Insert Active Tubs in Stock / Display (Assigned to Miatto - ID 2)
INSERT INTO stock_items (company_id, flavor_id, container_id, arrival_date, best_before_date, status, current_gross_weight_grams, current_net_weight_grams) VALUES
(2, 1, 1, '2023-10-01', '2023-10-15', 'display', 3217, 2417),
(2, 1, 1, '2023-09-29', '2023-10-13', 'in_stock', 5398, 4598),
(2, 16, 4, '2023-10-01', '2023-10-10', 'display', 2398, 1798),
(2, 16, 4, '2023-10-01', '2023-10-10', 'in_stock', 1780, 1180),
(2, 22, 4, '2023-09-25', '2023-10-02', 'finished', 600, 0);

-- 6. Initial Daily Audit Logs (Assigned to Miatto User ID 2)
INSERT INTO daily_stock_logs (stock_item_id, user_id, log_date, previous_status, new_status, gross_weight_grams, net_weight_grams) VALUES
(1, 2, '2023-10-01', 'in_stock', 'display', 3217, 2417),
(2, 2, '2023-10-01', 'in_stock', 'in_stock', 5398, 4598),
(3, 2, '2023-10-01', 'display', 'display', 2398, 1798),
(4, 2, '2023-10-01', 'in_stock', 'in_stock', 1780, 1180);