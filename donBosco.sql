-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.24-log - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para don_bosco
CREATE DATABASE IF NOT EXISTS `don_bosco` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `don_bosco`;

-- Volcando estructura para tabla don_bosco.anos_escolares
CREATE TABLE IF NOT EXISTS `anos_escolares` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `inicial` varchar(4) DEFAULT NULL,
  `final` varchar(4) DEFAULT NULL,
  `eliminada` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla don_bosco.anos_escolares: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `anos_escolares` DISABLE KEYS */;
INSERT INTO `anos_escolares` (`ID`, `inicial`, `final`, `eliminada`) VALUES
	(1, '2016', '2017', 0);
/*!40000 ALTER TABLE `anos_escolares` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.estudiante
CREATE TABLE IF NOT EXISTS `estudiante` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `cedula` int(8) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `ano` int(1) DEFAULT NULL,
  `seccion` varchar(50) DEFAULT NULL,
  `periodo_lectivo` varchar(50) DEFAULT NULL,
  `inasistencias` int(11) DEFAULT '0',
  `curso` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla don_bosco.estudiante: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` (`ID`, `nombres`, `apellidos`, `fecha_nacimiento`, `cedula`, `telefono`, `email`, `direccion`, `ano`, `seccion`, `periodo_lectivo`, `inasistencias`, `curso`) VALUES
	(2, 'Jose', 'Alvarez', '1995-09-25', 25458968, '04145789654', 'jalvarez@gmail.com', 'Av. Lecuna', 4, 'A', '2016-2017', 4, 'Electrónica'),
	(3, 'Jesus', 'Cibeira', '1995-09-25', 21523654, '04125658454', 'jcaciba@gmail.com', 'el paraiso', 4, 'B', '2016-2017', 1, 'Tecnología Gráfica'),
	(4, 'Pepito', 'Perez', '1995-09-25', 24568975, '04165698543', 'pepito@gmail.com', 'chuao', 5, 'A', '2016-2017', 1, 'Tecnología Gráfica'),
	(5, 'Carlos', 'Rodriguez','1995-09-25', 21265846, '04125568453', 'carlos@gmail.com', 'los ruices', 6, 'A', '2016-2017', 1, 'Tecnología Gráfica'),
	(6, 'Alejandro', 'Barone','1995-09-25', 24635987, '04145684573', 'alejandro@gmail.com', 'los ruices', 4, 'C', '2016-2017', 10, 'Tecnología Gráfica'),
	(7, 'Alex', 'Yaminne','1995-09-25', 21565485, '04125698542', 'alex@gmail.com', 'prados del este', 5, 'A', '2016-2017', 4, 'contabilidad'),
	(8, 'Pedro', 'Picapiedra','1995-09-25', 21564896, '01469856872', 'pedro@gmail.com', 'cafetal', 5, 'A', '2016-2017', 2, 'contabilidad'),
	(9, 'Pablo', 'Marmol', '1995-09-25',21564233, '01469856872', 'pablo@gmail.com', 'cafetal', 5, 'A', '2016-2017', 2, 'contabilidad'),
	(10, 'Alejandra', 'Aguilera','1995-09-25', 21458745, '04145684573', 'alejandra@gmail.com', 'los ruices', 4, 'C', '2016-2017', 10, 'Tecnología Gráfica'),
	(11, 'Patricia', 'Gonzalez', '1995-09-25',20365485, '04140254896', 'paty@gmail.com', 'los ruices', 4, 'A', '2016-2017', 4, 'Electrónica'),
	(12, 'Karla', 'Rodriguez', '1995-09-25',26358965, '04166985748', 'karla@gmail.com', 'los ruices', 4, 'A', '2016-2017', 4, 'Mecánica'),
	(13, 'Alvaro', 'Sanabria', '1995-09-25',24659854, '04165412356', 'alvarito@gmail.com', 'Av. Panteon', 4, 'A', '2016-2017', 4, 'Electrónica'),
	(14, 'Gregorio', 'Castro','1995-09-25', 24635907, '04140179052', 'josegregorio994@gmail.com', 'Los Palos Grandes', 4, 'A', '2016-2017', 3, 'Tecnología Gráfica');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.secciones
CREATE TABLE IF NOT EXISTS `secciones` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ano` int(1) DEFAULT NULL,
  `curso` varchar(20) DEFAULT NULL,
  `ano_escolar` varchar(10) DEFAULT NULL,
  `secciones` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla don_bosco.secciones: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `secciones` DISABLE KEYS */;
INSERT INTO `secciones` (`ID`, `ano`, `curso`, `ano_escolar`, `secciones`) VALUES
	(1, 4, 'Tecnología Gráfica', '2016-2017', 3),
	(2, 4, 'Contabilidad', '2016-2017', 1),
	(3, 4, 'Mecánica', '2016-2017', 1),
	(4, 4, 'Electrónica', '2016-2017', 1),
	(5, 5, 'Tecnología Gráfica', '2016-2017', 1),
	(6, 5, 'Contabilidad', '2016-2017', 1),
	(7, 5, 'Mecánica', '2016-2017', 1),
	(8, 5, 'Electrónica', '2016-2017', 1),
	(9, 6, 'Tecnología Gráfica', '2016-2017', 1),
	(10, 6, 'Contabilidad', '2016-2017', 1),
	(11, 6, 'Mecánica', '2016-2017', 1),
	(12, 6, 'Electrónica', '2016-2017', 1);
/*!40000 ALTER TABLE `secciones` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
