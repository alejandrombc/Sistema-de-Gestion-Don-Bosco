-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.15-log - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para don_bosco
CREATE DATABASE IF NOT EXISTS `don_bosco` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `don_bosco`;

-- Volcando estructura para tabla don_bosco.carrera
CREATE TABLE IF NOT EXISTS `carrera` (
  `Carrera_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de las carreras',
  `Carrera_Nombre` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Nombre de las carreras',
  `Ano_escolar` tinyint(4) NOT NULL COMMENT 'Ano escolar ',
  PRIMARY KEY (`Carrera_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Todas las carreras de la escuela tecnica popular don bosco';

-- Volcando datos para la tabla don_bosco.carrera: ~11 rows (aproximadamente)
DELETE FROM `carrera`;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` (`Carrera_ID`, `Carrera_Nombre`, `Ano_escolar`) VALUES
	(1, 'Tecnologia_Grafica', 4),
	(2, 'Mecanica', 4),
	(3, 'Electronica', 4),
	(4, 'Contabilidad', 4),
	(5, 'Tecnologia_Grafica', 5),
	(6, 'Mecanica', 5),
	(7, 'Electronica', 5),
	(8, 'Contabilidad', 5),
	(9, 'Tecnologia_Grafica', 6),
	(10, 'Mecanica', 6),
	(11, 'Electronica', 6),
	(12, 'Contabilidad', 6);
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.cursa
CREATE TABLE IF NOT EXISTS `cursa` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula de los estudiantes',
  `Periodo_ID` int(11) NOT NULL COMMENT 'ID del periodo lectivo',
  `Carrera_ID` int(11) NOT NULL COMMENT 'ID de la carrera cursada',
  `Seccion_actual` varchar(1) NOT NULL COMMENT 'La seccion que cursa el estudiante',
  `Inasistencias` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Las inasistencias del estudiante en ese periodo',
  PRIMARY KEY (`Cedula`,`Periodo_ID`),
  KEY `Periodo` (`Periodo_ID`),
  KEY `Carrera` (`Carrera_ID`),
  CONSTRAINT `Carrera` FOREIGN KEY (`Carrera_ID`) REFERENCES `carrera` (`Carrera_ID`),
  CONSTRAINT `Cedula` FOREIGN KEY (`Cedula`) REFERENCES `estudiante` (`Cedula`),
  CONSTRAINT `Periodo` FOREIGN KEY (`Periodo_ID`) REFERENCES `periodo` (`Periodo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre estudiantes, periodo y carrera';

-- Volcando datos para la tabla don_bosco.cursa: ~6 rows (aproximadamente)
DELETE FROM `cursa`;
/*!40000 ALTER TABLE `cursa` DISABLE KEYS */;
INSERT INTO `cursa` (`Cedula`, `Periodo_ID`, `Carrera_ID`, `Seccion_actual`, `Inasistencias`) VALUES
	(10098987, 1, 2, 'A', 1),
	(12341132, 1, 1, 'A', 0),
	(12345661, 1, 2, 'B', 0),
	(20876514, 1, 4, 'A', 0),
	(21908765, 1, 2, 'B', 50),
	(22456834, 1, 3, 'B', 7),
	(23890102, 1, 3, 'A', 4),
	(24206267, 1, 4, 'A', 0),
	(25245273, 1, 3, 'B', 4);
/*!40000 ALTER TABLE `cursa` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.estudiante
CREATE TABLE IF NOT EXISTS `estudiante` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula del estudiante',
  `Nombres` varchar(50) NOT NULL COMMENT 'Nombre del estudiante',
  `Apellidos` varchar(50) NOT NULL COMMENT 'Apellido del estudiante',
  `Direccion` varchar(100) DEFAULT NULL COMMENT 'Direccion del estudiante',
  `Correo` varchar(50) DEFAULT NULL COMMENT 'Correo del estudiante',
  `Numero_de_telefono` varchar(50) DEFAULT NULL COMMENT 'Numero de telefono del estudiante',
  `Fecha_de_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento del estudiante',
  PRIMARY KEY (`Cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informacion de estudiantes de la escuela tecnica popular don bosco';

-- Volcando datos para la tabla don_bosco.estudiante: ~6 rows (aproximadamente)
DELETE FROM `estudiante`;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` (`Cedula`, `Nombres`, `Apellidos`, `Direccion`, `Correo`, `Numero_de_telefono`, `Fecha_de_nacimiento`) VALUES
	(10098987, 'Jose Manuel', 'Alvarez Garcia', 'Cua', 'josema@gmail.com', '04246517861', '1997-03-04'),
	(12341132, 'Wladimir', 'Reinaga', '', 'soyaabb@gmail.com', '', '1900-01-01'),
	(12345661, 'Jose', 'Soto', '', '', '', '1900-01-01'),
	(20876514, 'Leon', 'Grimau', '', 'soyviolador@gmail.com', '', '1900-01-01'),
	(21908765, 'Alexander Robert', 'Yammine Al Halabi', 'Marico', 'alex@gmail.com', '', '1900-01-01'),
	(22456834, 'Daniel Enrique', 'Rodriguez De la Cruz', 'Trabaja elmio', 'danielpuramusica@gmail.com', '04167659283', '2011-03-04'),
	(23890102, 'Jose Gregorio', 'Castro Lazo', 'Elmio', 'gregcastro@gmail.com', '', '1997-03-04'),
	(24206267, 'Alejandro Moises', 'Barone Cavalieri', '', 'alejandrombc@gmail.com', '', '1900-01-01'),
	(25245273, 'Jesus Alberto', 'Cibeira Castiblanco', 'Cotiza - Barca kaliche', 'jacibas@gmail.com', '02122131323', '1995-03-04');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.periodo
CREATE TABLE IF NOT EXISTS `periodo` (
  `Periodo_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del periodo',
  `Periodo_nombre` varchar(10) NOT NULL DEFAULT '0' COMMENT 'Periodo ',
  `Eliminada` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si el periodo esta eliminado o no',
  PRIMARY KEY (`Periodo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Periodos en la escuela tecnica popular don bosco';

-- Volcando datos para la tabla don_bosco.periodo: ~4 rows (aproximadamente)
DELETE FROM `periodo`;
/*!40000 ALTER TABLE `periodo` DISABLE KEYS */;
INSERT INTO `periodo` (`Periodo_ID`, `Periodo_nombre`, `Eliminada`) VALUES
	(1, '2016-2017', 0),
	(2, '2031-3016', 1),
	(3, '2017-2018', 1),
	(4, '2019-2020', 0);
/*!40000 ALTER TABLE `periodo` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.seccion
CREATE TABLE IF NOT EXISTS `seccion` (
  `Carrera_ID` int(11) NOT NULL COMMENT 'ID de la carrera ',
  `Periodo_ID` int(11) NOT NULL COMMENT 'ID del periodo lectivo',
  `Cantidad` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Cantidad de secciones ',
  PRIMARY KEY (`Carrera_ID`,`Periodo_ID`),
  KEY `Periodo_ID` (`Periodo_ID`),
  CONSTRAINT `Carrera_ID` FOREIGN KEY (`Carrera_ID`) REFERENCES `carrera` (`Carrera_ID`),
  CONSTRAINT `Periodo_ID` FOREIGN KEY (`Periodo_ID`) REFERENCES `periodo` (`Periodo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cantidad de secciones segun periodo y carrera';

-- Volcando datos para la tabla don_bosco.seccion: ~36 rows (aproximadamente)
DELETE FROM `seccion`;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` (`Carrera_ID`, `Periodo_ID`, `Cantidad`) VALUES
	(1, 1, 1),
	(1, 3, 1),
	(1, 4, 1),
	(2, 1, 2),
	(2, 3, 1),
	(2, 4, 1),
	(3, 1, 2),
	(3, 3, 1),
	(3, 4, 1),
	(4, 1, 1),
	(4, 3, 1),
	(4, 4, 1),
	(5, 1, 1),
	(5, 3, 1),
	(5, 4, 1),
	(6, 1, 1),
	(6, 3, 1),
	(6, 4, 1),
	(7, 1, 1),
	(7, 3, 1),
	(7, 4, 1),
	(8, 1, 1),
	(8, 3, 1),
	(8, 4, 1),
	(9, 1, 1),
	(9, 3, 1),
	(9, 4, 1),
	(10, 1, 1),
	(10, 3, 1),
	(10, 4, 1),
	(11, 1, 1),
	(11, 3, 1),
	(11, 4, 1),
	(12, 1, 1),
	(12, 3, 1),
	(12, 4, 1);
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
