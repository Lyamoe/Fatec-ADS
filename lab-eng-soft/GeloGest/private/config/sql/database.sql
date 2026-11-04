-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04/11/2026 às 20:34
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gelateria_stock`
--

-- --------------------------------------------------------

--
-- Table structure `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `company_name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Seeds for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`) VALUES
(2, 'Miatto Gelateria'),
(1, 'Test_Company');

-- --------------------------------------------------------

--
-- Table structure `containers`
--

CREATE TABLE `containers` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `container_name` varchar(128) NOT NULL,
  `container_code` varchar(10) DEFAULT NULL,
  `tare_weight_grams` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Seeds for table `containers`
--

INSERT INTO `containers` (`id`, `company_id`, `container_name`, `container_code`, `tare_weight_grams`) VALUES
(1, 2, 'Grande Rasa', 'g-r', 277),
(2, 2, 'Grande Funda', 'g-f', 341),
(3, 2, 'Pequena Rasa', 'p-r', 379),
(4, 2, 'Pequena Funda', 'p-f', 372),
(5, 2, 'Mini Quadrada', 'm-q', 204);

-- --------------------------------------------------------

--
-- Table structure `daily_stock_logs`
--

CREATE TABLE `daily_stock_logs` (
  `id` int(11) NOT NULL,
  `stock_item_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `log_date` date NOT NULL,
  `previous_status` enum('in_stock','display','finished','discarded') DEFAULT NULL,
  `new_status` enum('in_stock','display','finished','discarded') NOT NULL,
  `gross_weight_grams` int(11) NOT NULL,
  `net_weight_grams` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Seeds for table `daily_stock_logs`
--

INSERT INTO `daily_stock_logs` (`id`, `stock_item_id`, `user_id`, `log_date`, `previous_status`, `new_status`, `gross_weight_grams`, `net_weight_grams`, `created_at`) VALUES
(1, 1, 2, '2023-10-01', 'in_stock', 'display', 3217, 2417, '2026-11-03 17:17:23'),
(2, 2, 2, '2023-10-01', 'in_stock', 'in_stock', 5398, 4598, '2026-11-03 17:17:23'),
(3, 3, 2, '2023-10-01', 'display', 'display', 2398, 1798, '2026-11-03 17:17:23'),
(4, 4, 2, '2023-10-01', 'in_stock', 'in_stock', 1780, 1180, '2026-11-03 17:17:23');

-- --------------------------------------------------------

--
-- Table structure `flavors`
--

CREATE TABLE `flavors` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `flavor_name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Seeds for table `flavors`
--

INSERT INTO `flavors` (`id`, `company_id`, `flavor_name`) VALUES
(1, 2, '3 Leites'),
(2, 2, 'Abacaxi c/ cocada'),
(3, 2, 'Amarena'),
(4, 2, 'Belga'),
(5, 2, 'Cheesecake'),
(6, 2, 'Chiclete'),
(7, 2, 'Chocobianco'),
(8, 2, 'Chocoblack'),
(9, 2, 'Chocomiatto'),
(10, 2, 'Doce de Leite'),
(11, 2, 'Flor de leite'),
(12, 2, 'Iogurte c/ maracujá'),
(13, 2, 'Kinder'),
(14, 2, 'Manga maracujá'),
(15, 2, 'Menta'),
(16, 2, 'Morango'),
(17, 2, 'Mousse Maracuja'),
(18, 2, 'Ninho com brigadeiro'),
(19, 2, 'Palha italiana'),
(20, 2, 'Pé de moleque'),
(21, 2, 'Pistache'),
(22, 2, 'Rafaello'),
(23, 2, 'Reeses'),
(24, 2, 'Torta de limão');

-- --------------------------------------------------------

--
-- Table structure `stock_items`
--

CREATE TABLE `stock_items` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `flavor_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `arrival_date` date NOT NULL,
  `best_before_date` date NOT NULL,
  `status` enum('in_stock','display','finished','discarded') NOT NULL DEFAULT 'in_stock',
  `current_gross_weight_grams` int(11) NOT NULL,
  `current_net_weight_grams` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Seeds for table `stock_items`
--

INSERT INTO `stock_items` (`id`, `company_id`, `flavor_id`, `container_id`, `arrival_date`, `best_before_date`, `status`, `current_gross_weight_grams`, `current_net_weight_grams`) VALUES
(1, 2, 1, 1, '2023-10-01', '2023-10-15', 'display', 3217, 2417),
(2, 2, 1, 1, '2023-09-29', '2023-10-13', 'in_stock', 5398, 4598),
(3, 2, 16, 4, '2023-10-01', '2023-10-10', 'display', 2398, 1798),
(4, 2, 16, 4, '2023-10-01', '2023-10-10', 'in_stock', 1780, 1180),
(5, 2, 22, 4, '2023-09-25', '2023-10-02', 'finished', 600, 0);

-- --------------------------------------------------------

--
-- Table structure `user_login`
--

CREATE TABLE `user_login` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_type` enum('admin','owner','user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Seeds for table `user_login`
--

INSERT INTO `user_login` (`id`, `company_id`, `user_name`, `user_password`, `user_type`) VALUES
(1, 1, 'TestAdmin', '$2y$10$z69sbLvtw7LqV35O8kLv8OqR3Te0Gw4Jvpa38I4BTvlHUIbeeYCri', 'admin'),
(2, 2, 'LyamPeres', '$2y$10$z69sbLvtw7LqV35O8kLv8OqR3Te0Gw4Jvpa38I4BTvlHUIbeeYCri', 'admin');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `company_name` (`company_name`);

--
-- Índices de tabela `containers`
--
ALTER TABLE `containers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `company_id` (`company_id`,`container_code`);

--
-- Índices de tabela `daily_stock_logs`
--
ALTER TABLE `daily_stock_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_item_id` (`stock_item_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `flavors`
--
ALTER TABLE `flavors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Índices de tabela `stock_items`
--
ALTER TABLE `stock_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `flavor_id` (`flavor_id`),
  ADD KEY `container_id` (`container_id`);

--
-- Índices de tabela `user_login`
--
ALTER TABLE `user_login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD KEY `company_id` (`company_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `containers`
--
ALTER TABLE `containers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `daily_stock_logs`
--
ALTER TABLE `daily_stock_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `flavors`
--
ALTER TABLE `flavors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `stock_items`
--
ALTER TABLE `stock_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `user_login`
--
ALTER TABLE `user_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `containers`
--
ALTER TABLE `containers`
  ADD CONSTRAINT `containers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `daily_stock_logs`
--
ALTER TABLE `daily_stock_logs`
  ADD CONSTRAINT `daily_stock_logs_ibfk_1` FOREIGN KEY (`stock_item_id`) REFERENCES `stock_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `daily_stock_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_login` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `flavors`
--
ALTER TABLE `flavors`
  ADD CONSTRAINT `flavors_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `stock_items`
--
ALTER TABLE `stock_items`
  ADD CONSTRAINT `stock_items_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_items_ibfk_2` FOREIGN KEY (`flavor_id`) REFERENCES `flavors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_items_ibfk_3` FOREIGN KEY (`container_id`) REFERENCES `containers` (`id`);

--
-- Restrições para tabelas `user_login`
--
ALTER TABLE `user_login`
  ADD CONSTRAINT `user_login_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
