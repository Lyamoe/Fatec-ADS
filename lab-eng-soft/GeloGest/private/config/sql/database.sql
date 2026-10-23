CREATE DATABASE IF NOT EXISTS gelateria_stock;
USE gelateria_stock;

-- 1. Tabela de Tipos/Tamanhos de Recipientes (Cubas/Potes)
CREATE TABLE IF NOT EXISTS containers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    container_name VARCHAR(128) NOT NULL,
    container_weight_grams INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabela de Sabores de Gelato
CREATE TABLE IF NOT EXISTS flavors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    flavor_name VARCHAR(128) NOT NULL,
    description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabela de Lotes/Estoque de Cubas
CREATE TABLE IF NOT EXISTS stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    flavor_id INT NOT NULL,
    container_id INT NOT NULL,
    container_status ENUM('in_stock', 'display', 'empty') NOT NULL DEFAULT 'in_stock',
    quantity_grams INT NOT NULL,
    arrival_date DATE NOT NULL,
    best_before_date DATE NOT NULL,
    FOREIGN KEY (flavor_id) REFERENCES flavors(id) ON DELETE CASCADE,
    FOREIGN KEY (container_id) REFERENCES containers(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabela de Usuários
CREATE TABLE IF NOT EXISTS user_login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_type ENUM('admin', 'user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabela de Histórico de Movimentações (Recomendado)
CREATE TABLE IF NOT EXISTS stock_movements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT NOT NULL,
    user_id INT NOT NULL,
    movement_type ENUM('entry', 'display_transfer', 'waste', 'exit') NOT NULL,
    grams_changed INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (stock_id) REFERENCES stock(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user_login(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==================== DADOS INICIAIS ==================== 

-- Inserir Usuário Administrador Inicial
INSERT INTO user_login (user_name, user_password, user_type)
VALUES ('Lyamoe', '$2y$10$z69sbLvtw7LqV35O8kLv8OqR3Te0Gw4Jvpa38I4BTvlHUIbeeYCri', 'admin');

-- Inserir alguns Tipos de Cubas Padrão
INSERT INTO containers (container_name, container_weight_grams) VALUES
('Cuba Inox Padrão (5L)', 1200),
('Cuba Inox Funda (7L)', 1500),
('Pote Plástico Reserva (10L)', 450);