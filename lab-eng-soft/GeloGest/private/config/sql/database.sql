CREATE DATABASE IF NOT EXISTS gelateria_stock;
USE gelateria_stock;

-- Tipos de Cubas / Recipientes (Tara)
CREATE TABLE IF NOT EXISTS containers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    container_name VARCHAR(128) NOT NULL, -- Ex: 'Grande Rasa', 'Pequena Funda'
    container_code VARCHAR(10) UNIQUE,     -- Ex: 'g-r', 'p-f', 'g-f'
    tare_weight_grams INT NOT NULL         -- Peso do recipiente vazio
);

-- Sabores
CREATE TABLE IF NOT EXISTS flavors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    flavor_name VARCHAR(128) NOT NULL
);

-- Usuários
CREATE TABLE IF NOT EXISTS user_login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_type ENUM('admin', 'user') NOT NULL DEFAULT 'user'
);

-- Cubas Individuais em Estoque (Lotes Físicos)
-- Cada linha representa UMA cuba física de gelato que entrou na loja
CREATE TABLE IF NOT EXISTS stock_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    flavor_id INT NOT NULL,
    container_id INT NOT NULL,
    arrival_date DATE NOT NULL,                              -- Data em que foi produzida
    best_before_date DATE NOT NULL,                          -- Validade
    status ENUM('in_stock', 'display', 'finished', 'discarded') NOT NULL DEFAULT 'in_stock',
    current_gross_weight_grams INT NOT NULL,                 -- Último peso bruto registrado
    current_net_weight_grams INT NOT NULL,                   -- Último peso líquido (Gross - Tare)
    
    FOREIGN KEY (flavor_id) REFERENCES flavors(id) ON DELETE CASCADE,
    FOREIGN KEY (container_id) REFERENCES containers(id) ON DELETE RESTRICT
);

-- Histórico de Pesaens e Auditoria Diária
-- Registra cada atualização feita pela funcionária ao abrir a tela diária
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

-- ==================== DADOS INICIAIS ==================== 

-- Inserir Usuário Administrador Inicial
INSERT INTO user_login (user_name, user_password, user_type)
VALUES ('Lyamoe', '$2y$10$z69sbLvtw7LqV35O8kLv8OqR3Te0Gw4Jvpa38I4BTvlHUIbeeYCri', 'admin');

-- Inserir alguns Tipos de Cubas Padrão
INSERT INTO containers (container_name, container_code, tare_weight_grams) VALUES
('Grande Rasa',  'g-r', 277),
('Grande Funda', 'g-f', 341),
('Pequena Rasa', 'p-r', 379),
('Pequena Funda', 'p-f', 372),
('Mini Quadrada', 'm-q', 204);

-- Inserção dos Sabores
INSERT INTO flavors (flavor_name) VALUES
('3 Leites'),
('Abacaxi c/ cocada'),
('Amarena'),
('Belga'),
('Cheesecake'),
('Chiclete'),
('Chocobianco'),
('Chocoblack'),
('Chocomiatto'),
('Doce de Leite'),
('Flor de leite'),
('Iogurte c/ maracujá'),
('Kinder'),
('Manga maracujá'),
('Menta'),
('Morango'),
('Mousse Maracuja'),
('Ninho com brigadeiro'),
('Palha italiana'),
('Pé de moleque'),
('Pistache'),
('Rafaello'),
('Reeses'),
('Torta de limão');

-- 4. Inserção de Cubas Ativas em Estoque / Vitrine (Simulação de Lotes para o PEPS)
-- Nota: O peso líquido é calculado subtraindo a tara da cuba selecionada.

-- Sabor: 3 Leites (ID: 1)
-- Cuba 1 na Vitrine (Cuba 'g-r')
INSERT INTO stock_items (flavor_id, container_id, arrival_date, best_before_date, status, current_gross_weight_grams, current_net_weight_grams) VALUES
(1, 1, '2023-10-01', '2023-10-15', 'display', 3217, 2417);

-- Cuba 2 no Estoque - Lote mais antigo (Cuba 'g-r')
INSERT INTO stock_items (flavor_id, container_id, arrival_date, best_before_date, status, current_gross_weight_grams, current_net_weight_grams) VALUES
(1, 1, '2023-09-29', '2023-10-13', 'in_stock', 5398, 4598);

-- Sabor: Morango (ID: 16)
-- Cuba 1 na Vitrine (Cuba 'p-f')
INSERT INTO stock_items (flavor_id, container_id, arrival_date, best_before_date, status, current_gross_weight_grams, current_net_weight_grams) VALUES
(16, 4, '2023-10-01', '2023-10-10', 'display', 2398, 1798);

-- Cuba 2 no Estoque (Cuba 'p-f')
INSERT INTO stock_items (flavor_id, container_id, arrival_date, best_before_date, status, current_gross_weight_grams, current_net_weight_grams) VALUES
(16, 4, '2023-10-01', '2023-10-10', 'in_stock', 1780, 1180);

-- Sabor: Rafaello (ID: 22)
-- Cuba que acabou/foi finalizada
INSERT INTO stock_items (flavor_id, container_id, arrival_date, best_before_date, status, current_gross_weight_grams, current_net_weight_grams) VALUES
(22, 4, '2023-09-25', '2023-10-02', 'finished', 600, 0);

-- 5. Histórico Inicial de Leitura Diária (Logs)
INSERT INTO daily_stock_logs (stock_item_id, user_id, log_date, previous_status, new_status, gross_weight_grams, net_weight_grams) VALUES
(1, 1, '2023-10-01', 'in_stock', 'display', 3217, 2417),
(2, 1, '2023-10-01', 'in_stock', 'in_stock', 5398, 4598),
(3, 1, '2023-10-01', 'display', 'display', 2398, 1798),
(4, 1, '2023-10-01', 'in_stock', 'in_stock', 1780, 1180);