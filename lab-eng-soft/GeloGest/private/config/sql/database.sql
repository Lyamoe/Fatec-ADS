SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "-03:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `gelogest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gelogest`;

-- --------------------------------------------------------
-- 1. Table structure `companies`
-- --------------------------------------------------------
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_name` (`company_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 2. Table structure `containers`
-- --------------------------------------------------------
CREATE TABLE `containers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `container_name` varchar(128) NOT NULL,
  `container_code` varchar(10) DEFAULT NULL,
  `tare_weight_grams` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_id` (`company_id`,`container_code`),
  CONSTRAINT `containers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 3. Table structure `flavors`
-- --------------------------------------------------------
CREATE TABLE `flavors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `flavor_name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `flavors_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 4. Table structure `users_login`
-- --------------------------------------------------------
CREATE TABLE `users_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_type` enum('admin','owner','user') NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `user_email` (`user_email`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `users_login_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 5. Table structure `stock_items`
-- --------------------------------------------------------
CREATE TABLE `stock_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `flavor_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `arrival_date` date NOT NULL,
  `best_before_date` date NOT NULL,
  `status` enum('in_stock','display','finished','discarded') NOT NULL DEFAULT 'in_stock',
  `current_gross_weight_grams` int(11) NOT NULL,
  `current_net_weight_grams` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `flavor_id` (`flavor_id`),
  KEY `container_id` (`container_id`),
  CONSTRAINT `stock_items_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_items_ibfk_2` FOREIGN KEY (`flavor_id`) REFERENCES `flavors` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_items_ibfk_3` FOREIGN KEY (`container_id`) REFERENCES `containers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 6. Table structure `daily_stock_logs`
-- --------------------------------------------------------
CREATE TABLE `daily_stock_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_item_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `log_date` date NOT NULL,
  `previous_status` enum('in_stock','display','finished','discarded') DEFAULT NULL,
  `new_status` enum('in_stock','display','finished','discarded') NOT NULL,
  `gross_weight_grams` int(11) NOT NULL,
  `net_weight_grams` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `stock_item_id` (`stock_item_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `daily_stock_logs_ibfk_1` FOREIGN KEY (`stock_item_id`) REFERENCES `stock_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `daily_stock_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users_login` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- DATA SEEDS
-- --------------------------------------------------------

INSERT INTO `companies` (`company_name`) VALUES
('Test_Company'),
('Miatto Gelateria');

INSERT INTO `containers` (`company_id`, `container_name`, `container_code`, `tare_weight_grams`) VALUES
(2, 'Grande Rasa', 'g-r', 277),
(2, 'Grande Funda', 'g-f', 341),
(2, 'Pequena Rasa', 'p-r', 379),
(2, 'Pequena Funda', 'p-f', 372),
(2, 'Mini Quadrada', 'm-q', 204);

INSERT INTO `flavors` (`company_id`, `flavor_name`) VALUES
(2, '3 Leites'),
(2, 'Abacaxi c/ cocada'),
(2, 'Amarena'),
(2, 'Belga'),
(2, 'Cheesecake'),
(2, 'Chiclete'),
(2, 'Chocobianco'),
(2, 'Chocoblack'),
(2, 'Chocomiatto'),
(2, 'Doce de Leite'),
(2, 'Flor de leite'),
(2, 'Iogurte c/ maracujá'),
(2, 'Kinder'),
(2, 'Manga maracujá'),
(2, 'Menta'),
(2, 'Morango'),
(2, 'Mousse Maracuja'),
(2, 'Ninho com brigadeiro'),
(2, 'Palha italiana'),
(2, 'Pé de moleque'),
(2, 'Pistache'),
(2, 'Rafaello'),
(2, 'Reeses'),
(2, 'Torta de limão');

INSERT INTO `users_login` (`company_id`, `user_name`, `user_password`, `user_email`, `user_type`) VALUES
(1, 'TestAdmin', '$2a$12$UL4ab1cjIikcgPSv5qwiTOwDold/Mb1Mn0iqTWe3xJFMPN5OfdeEe', 'a@a.a', 'admin'),
(1, 'TestUser', '$2a$12$UL4ab1cjIikcgPSv5qwiTOwDold/Mb1Mn0iqTWe3xJFMPN5OfdeEe', 'b@b.b', 'user'),
(2, 'LyamPeres', '$2a$12$lJYhxO..xCUxSSjfwbbJne6cwqyPpUckY8AO.pR7I7rOFE1rrCYM2', 'lyamoesp@gmail.com', 'admin');

INSERT INTO `stock_items` (`company_id`, `flavor_id`, `container_id`, `arrival_date`, `best_before_date`, `status`, `current_gross_weight_grams`, `current_net_weight_grams`) VALUES
(2, 1, 1, '2023-10-01', '2023-10-15', 'display', 3217, 2417),
(2, 1, 1, '2023-09-29', '2023-10-13', 'in_stock', 5398, 4598),
(2, 16, 4, '2023-10-01', '2023-10-10', 'display', 2398, 1798),
(2, 16, 4, '2023-10-01', '2023-10-10', 'in_stock', 1780, 1180),
(2, 22, 4, '2023-09-25', '2023-10-02', 'finished', 600, 0);

INSERT INTO `daily_stock_logs` (`stock_item_id`, `user_id`, `log_date`, `previous_status`, `new_status`, `gross_weight_grams`, `net_weight_grams`, `created_at`) VALUES
(1, 2, '2023-10-01', 'in_stock', 'display', 3217, 2417, '2026-11-03 17:17:23'),
(2, 2, '2023-10-01', 'in_stock', 'in_stock', 5398, 4598, '2026-11-03 17:17:23'),
(3, 2, '2023-10-01', 'display', 'display', 2398, 1798, '2026-11-03 17:17:23'),
(4, 2, '2023-10-01', 'in_stock', 'in_stock', 1780, 1180, '2026-11-03 17:17:23');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;