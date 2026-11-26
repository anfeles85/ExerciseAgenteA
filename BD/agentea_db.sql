-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.44 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.15.0.7171
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para agentea_db
CREATE DATABASE IF NOT EXISTS `agentea_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `agentea_db`;

-- Volcando estructura para tabla agentea_db.fattening_lot
CREATE TABLE IF NOT EXISTS `fattening_lot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lot_code` varchar(50) NOT NULL COMMENT 'código del lote',
  `birthdate` date NOT NULL COMMENT 'fecha de nacimiento',
  `density` int DEFAULT NULL COMMENT 'densidad',
  `initial_number` int DEFAULT NULL COMMENT 'número inicial',
  `final_number` int DEFAULT NULL COMMENT 'número final',
  `initial_weight` decimal(10,2) DEFAULT NULL COMMENT 'peso inicial',
  `line_id` int DEFAULT NULL COMMENT 'FK linea',
  `shed_id` int DEFAULT NULL COMMENT 'FK galpon',
  PRIMARY KEY (`id`),
  KEY `FK_fattening_lot_line` (`line_id`),
  KEY `FK_fattening_lot_shed` (`shed_id`),
  CONSTRAINT `FK_fattening_lot_line` FOREIGN KEY (`line_id`) REFERENCES `line` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_fattening_lot_shed` FOREIGN KEY (`shed_id`) REFERENCES `shed` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tabla lote de engorde';

-- Volcando datos para la tabla agentea_db.fattening_lot: ~1 rows (aproximadamente)
INSERT INTO `fattening_lot` (`id`, `lot_code`, `birthdate`, `density`, `initial_number`, `final_number`, `initial_weight`, `line_id`, `shed_id`) VALUES
	(1, '1-2026', '2026-11-26', 200, 50, 50, 2.00, 1, 1);

-- Volcando estructura para tabla agentea_db.line
CREATE TABLE IF NOT EXISTS `line` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tabla linea';

-- Volcando datos para la tabla agentea_db.line: ~3 rows (aproximadamente)
INSERT INTO `line` (`id`, `name`) VALUES
	(1, 'Gallina Babcock'),
	(2, 'Gallina Jersey blanca gigante'),
	(3, 'Gallina Light Sussex');

-- Volcando estructura para tabla agentea_db.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tabla de roles';

-- Volcando datos para la tabla agentea_db.role: ~0 rows (aproximadamente)
INSERT INTO `role` (`id`, `name`) VALUES
	(1, 'ADMINISTRADOR'),
	(2, 'ADMINISTRADOR DE GRANJA'),
	(3, 'INSTRUCTOR');

-- Volcando estructura para tabla agentea_db.shed
CREATE TABLE IF NOT EXISTS `shed` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` int NOT NULL,
  `status` varchar(50) NOT NULL COMMENT 'DISPONIBLE, OCUPADO',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tabla galpon';

-- Volcando datos para la tabla agentea_db.shed: ~3 rows (aproximadamente)
INSERT INTO `shed` (`id`, `number`, `status`) VALUES
	(1, 100, 'DISPONIBLE'),
	(2, 200, 'DISPONIBLE'),
	(3, 300, 'OCUPADO');

-- Volcando estructura para tabla agentea_db.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document` bigint NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role_id` int DEFAULT NULL,
  `status` enum('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO',
  PRIMARY KEY (`id`),
  UNIQUE KEY `document` (`document`),
  KEY `FK_user_role` (`role_id`),
  CONSTRAINT `FK_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tabla usuario';

-- Volcando datos para la tabla agentea_db.user: ~0 rows (aproximadamente)
INSERT INTO `user` (`id`, `document`, `fullname`, `email`, `password`, `role_id`, `status`) VALUES
	(1, 1000000001, 'Leonardo DiCaprio', 'leonardo.dicaprio@sena.edu.co', 'agentea', 1, 'ACTIVO'),
	(2, 1000000002, 'Angelina Jolie', 'angelina.jolie@sena.edu.co', 'agentea', 2, 'ACTIVO'),
	(3, 1000000003, 'Brad Pitt', 'brad.pitt@sena.edu.co', 'agentea', 3, 'ACTIVO'),
	(4, 1000000004, 'Scarlett Johansson', 'scarlett.johansson@sena.edu.co', 'agentea', 3, 'ACTIVO'),
	(5, 1000000005, 'Tom Cruise', 'tom.cruise@sena.edu.co', 'agentea', 3, 'ACTIVO'),
	(6, 1000000006, 'Jennifer Lawrence', 'jennifer.lawrence@sena.edu.co', 'agentea', 3, 'ACTIVO'),
	(7, 1000000007, 'Robert Downey', 'robert.downey@sena.edu.co', 'agentea', 3, 'ACTIVO'),
	(8, 1000000008, 'Natalie Portman', 'natalie.portman@sena.edu.co', 'agentea', 3, 'ACTIVO'),
	(9, 1000000009, 'Will Smith', 'will.smith@sena.edu.co', 'agentea', 3, 'INACTIVO'),
	(10, 1000000010, 'Emma Watson', 'emma.watson@sena.edu.co', 'agentea', 3, 'INACTIVO');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
