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
CREATE DATABASE IF NOT EXISTS `don_bosco` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `don_bosco`;

-- Volcando estructura para tabla don_bosco.carrera
CREATE TABLE IF NOT EXISTS `carrera` (
  `Carrera_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de las carreras',
  `Carrera_Nombre` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Nombre de las carreras',
  `Ano_escolar` tinyint(4) NOT NULL COMMENT 'Ano escolar ',
  PRIMARY KEY (`Carrera_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Todas las carreras de la escuela tecnica popular don bosco';

-- Volcando datos para la tabla don_bosco.carrera: ~12 rows (aproximadamente)
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

-- Volcando estructura para tabla don_bosco.correo_enviado
CREATE TABLE IF NOT EXISTS `correo_enviado` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `correo` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Lista a los correos que se les han enviado algo';

-- Volcando datos para la tabla don_bosco.correo_enviado: ~3 rows (aproximadamente)
DELETE FROM `correo_enviado`;
/*!40000 ALTER TABLE `correo_enviado` DISABLE KEYS */;
INSERT INTO `correo_enviado` (`ID`, `correo`) VALUES
	(3, 'alejandrombc@gmail.com'),
	(4, 'josemalvarezg1@gmail.com'),
	(7, 'josegregorio994@gmail.com');
/*!40000 ALTER TABLE `correo_enviado` ENABLE KEYS */;

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

-- Volcando datos para la tabla don_bosco.cursa: ~205 rows (aproximadamente)
DELETE FROM `cursa`;
/*!40000 ALTER TABLE `cursa` DISABLE KEYS */;
INSERT INTO `cursa` (`Cedula`, `Periodo_ID`, `Carrera_ID`, `Seccion_actual`, `Inasistencias`) VALUES
	(24218040, 1, 3, 'A', 0),
	(26104468, 1, 6, 'A', 0),
	(26104748, 1, 7, 'B', 0),
	(26272185, 1, 7, 'B', 0),
	(26489708, 1, 8, 'A', 0),
	(26576175, 1, 7, 'B', 0),
	(26576852, 1, 8, 'A', 0),
	(26610414, 1, 7, 'A', 0),
	(26726192, 1, 7, 'B', 0),
	(26824336, 1, 7, 'B', 0),
	(26966020, 1, 6, 'A', 0),
	(26966364, 1, 7, 'B', 0),
	(26993313, 1, 7, 'B', 0),
	(26993444, 1, 4, 'A', 0),
	(27007551, 1, 7, 'A', 0),
	(27007564, 1, 7, 'B', 0),
	(27007671, 1, 7, 'A', 0),
	(27007783, 1, 7, 'B', 0),
	(27039133, 1, 7, 'A', 0),
	(27039134, 1, 4, 'A', 0),
	(27111856, 1, 6, 'A', 0),
	(27111953, 1, 7, 'B', 0),
	(27159493, 1, 3, 'A', 0),
	(27159726, 1, 7, 'B', 0),
	(27159735, 1, 7, 'A', 0),
	(27223509, 1, 3, 'A', 0),
	(27246779, 1, 7, 'A', 0),
	(27246998, 1, 3, 'B', 0),
	(27321523, 1, 8, 'A', 0),
	(27321875, 1, 6, 'A', 0),
	(27322291, 1, 6, 'A', 0),
	(27333819, 1, 8, 'A', 0),
	(27342125, 1, 8, 'A', 0),
	(27344221, 1, 7, 'A', 0),
	(27346614, 1, 7, 'B', 0),
	(27359345, 1, 3, 'B', 0),
	(27359360, 1, 6, 'A', 0),
	(27371276, 1, 3, 'A', 0),
	(27391414, 1, 7, 'B', 0),
	(27426203, 1, 4, 'A', 0),
	(27426295, 1, 3, 'B', 0),
	(27426758, 1, 7, 'A', 0),
	(27426859, 1, 6, 'A', 0),
	(27439674, 1, 7, 'B', 0),
	(27448072, 1, 6, 'A', 0),
	(27448779, 1, 3, 'A', 0),
	(27448834, 1, 1, 'A', 0),
	(27448869, 1, 3, 'B', 0),
	(27449886, 1, 3, 'A', 0),
	(27488079, 1, 3, 'A', 0),
	(27488634, 1, 3, 'B', 0),
	(27488670, 1, 7, 'A', 0),
	(27488674, 1, 3, 'A', 0),
	(27513098, 1, 6, 'A', 0),
	(27545280, 1, 4, 'A', 0),
	(27545281, 1, 8, 'A', 0),
	(27545403, 1, 4, 'A', 0),
	(27545912, 1, 7, 'A', 0),
	(27588620, 1, 7, 'A', 0),
	(27622655, 1, 7, 'B', 0),
	(27622859, 1, 4, 'A', 0),
	(27624610, 1, 6, 'A', 0),
	(27624819, 1, 6, 'A', 0),
	(27625201, 1, 3, 'B', 0),
	(27659293, 1, 6, 'A', 0),
	(27671132, 1, 1, 'A', 0),
	(27692858, 1, 7, 'A', 0),
	(27692921, 1, 1, 'A', 0),
	(27693166, 1, 6, 'A', 0),
	(27693200, 1, 7, 'A', 0),
	(27693218, 1, 1, 'A', 0),
	(27703437, 1, 7, 'B', 0),
	(27704060, 1, 7, 'A', 0),
	(27752874, 1, 1, 'A', 0),
	(27761518, 1, 3, 'B', 0),
	(27769120, 1, 4, 'A', 0),
	(27769131, 1, 2, 'A', 0),
	(27769161, 1, 2, 'A', 0),
	(27769263, 1, 3, 'A', 0),
	(27769441, 1, 3, 'A', 0),
	(27769447, 1, 3, 'B', 0),
	(27769449, 1, 3, 'A', 0),
	(27769483, 1, 4, 'A', 0),
	(27769609, 1, 2, 'A', 0),
	(27769674, 1, 3, 'B', 0),
	(27769849, 1, 2, 'A', 0),
	(27769932, 1, 3, 'B', 0),
	(27770003, 1, 2, 'A', 0),
	(27770256, 1, 6, 'A', 0),
	(27772211, 1, 4, 'A', 0),
	(27788897, 1, 2, 'A', 0),
	(27790147, 1, 4, 'A', 0),
	(27790281, 1, 4, 'A', 0),
	(27790452, 1, 3, 'B', 0),
	(27790472, 1, 3, 'B', 0),
	(27790952, 1, 3, 'B', 0),
	(27793842, 1, 4, 'A', 0),
	(27794045, 1, 3, 'A', 0),
	(27818422, 1, 7, 'A', 0),
	(27818571, 1, 2, 'A', 0),
	(27818583, 1, 1, 'A', 0),
	(27818596, 1, 3, 'A', 0),
	(27818835, 1, 2, 'A', 0),
	(27818877, 1, 2, 'A', 0),
	(27818944, 1, 1, 'A', 0),
	(27860405, 1, 3, 'B', 0),
	(27879185, 1, 2, 'A', 0),
	(27883682, 1, 6, 'A', 0),
	(27916045, 1, 3, 'B', 0),
	(27916155, 1, 6, 'A', 0),
	(27916560, 1, 1, 'A', 0),
	(27916722, 1, 7, 'A', 0),
	(27978116, 1, 3, 'A', 0),
	(27978507, 1, 7, 'A', 0),
	(27978695, 1, 4, 'A', 0),
	(27978799, 1, 1, 'A', 0),
	(27978839, 1, 1, 'A', 0),
	(28006317, 1, 3, 'B', 0),
	(28007026, 1, 4, 'A', 0),
	(28007071, 1, 3, 'B', 0),
	(28007205, 1, 2, 'A', 0),
	(28007320, 1, 2, 'A', 0),
	(28007419, 1, 4, 'A', 0),
	(28007425, 1, 2, 'A', 0),
	(28007444, 1, 1, 'A', 0),
	(28007535, 1, 1, 'A', 0),
	(28007546, 1, 3, 'B', 0),
	(28007782, 1, 1, 'A', 0),
	(28014115, 1, 7, 'B', 0),
	(28015421, 1, 1, 'A', 0),
	(28015915, 1, 4, 'A', 0),
	(28052112, 1, 7, 'B', 0),
	(28052196, 1, 1, 'A', 0),
	(28052197, 1, 3, 'A', 0),
	(28052338, 1, 7, 'B', 0),
	(28052473, 1, 3, 'B', 0),
	(28052474, 1, 2, 'A', 0),
	(28052569, 1, 3, 'B', 0),
	(28052726, 1, 8, 'A', 0),
	(28052971, 1, 4, 'A', 0),
	(28053300, 1, 4, 'A', 0),
	(28053393, 1, 1, 'A', 0),
	(28053753, 1, 1, 'A', 0),
	(28058266, 1, 4, 'A', 0),
	(28076457, 1, 1, 'A', 0),
	(28101501, 1, 7, 'A', 0),
	(28101680, 1, 3, 'A', 0),
	(28101714, 1, 2, 'A', 0),
	(28116113, 1, 3, 'B', 0),
	(28116269, 1, 6, 'A', 0),
	(28116623, 1, 3, 'A', 0),
	(28116858, 1, 2, 'A', 0),
	(28117130, 1, 2, 'A', 0),
	(28135158, 1, 3, 'A', 0),
	(28143615, 1, 4, 'A', 0),
	(28146413, 1, 4, 'A', 0),
	(28154139, 1, 7, 'A', 0),
	(28158289, 1, 3, 'B', 0),
	(28158342, 1, 1, 'A', 0),
	(28158365, 1, 1, 'A', 0),
	(28158376, 1, 3, 'A', 0),
	(28158446, 1, 2, 'A', 0),
	(28158548, 1, 3, 'A', 0),
	(28158887, 1, 1, 'A', 0),
	(28180284, 1, 4, 'A', 0),
	(28209447, 1, 1, 'A', 0),
	(28218130, 1, 2, 'A', 0),
	(28218209, 1, 3, 'A', 0),
	(28218335, 1, 6, 'A', 0),
	(28218533, 1, 3, 'B', 0),
	(28218618, 1, 1, 'A', 0),
	(28308847, 1, 3, 'A', 0),
	(28309079, 1, 3, 'A', 0),
	(28309415, 1, 2, 'A', 0),
	(28317843, 1, 3, 'A', 0),
	(28324759, 1, 4, 'A', 0),
	(28325252, 1, 4, 'A', 0),
	(28330354, 1, 3, 'A', 0),
	(28332612, 1, 1, 'A', 0),
	(28332945, 1, 1, 'A', 0),
	(28333395, 1, 4, 'A', 0),
	(28448034, 1, 3, 'A', 0),
	(28448041, 1, 3, 'B', 0),
	(28448664, 1, 3, 'B', 0),
	(28448832, 1, 4, 'A', 0),
	(28469300, 1, 3, 'A', 0),
	(28484815, 1, 1, 'A', 0),
	(28484989, 1, 2, 'A', 0),
	(29501461, 1, 3, 'A', 0),
	(29518741, 1, 1, 'A', 0),
	(29537192, 1, 3, 'A', 0),
	(29537298, 1, 3, 'B', 0),
	(29537588, 1, 4, 'A', 0),
	(29537724, 1, 1, 'A', 0),
	(29537992, 1, 2, 'A', 0),
	(29577358, 1, 3, 'B', 0),
	(29577802, 1, 4, 'A', 0),
	(29577930, 1, 8, 'A', 0),
	(29578687, 1, 2, 'A', 0),
	(29589945, 1, 3, 'A', 0),
	(29609295, 1, 3, 'B', 0),
	(29621425, 1, 1, 'A', 0),
	(29621763, 1, 2, 'A', 0),
	(29621846, 1, 4, 'A', 0),
	(29662025, 1, 2, 'A', 0),
	(29662966, 1, 3, 'B', 0),
	(29677939, 1, 1, 'A', 0),
	(29706478, 1, 2, 'A', 0),
	(29720517, 1, 3, 'B', 0),
	(29784944, 1, 3, 'A', 0),
	(29832761, 1, 1, 'A', 0),
	(29865277, 1, 3, 'B', 0),
	(29883426, 1, 4, 'A', 0),
	(29883723, 1, 4, 'A', 0),
	(29888595, 1, 4, 'A', 0),
	(29904321, 1, 3, 'B', 0),
	(29935980, 1, 3, 'A', 0),
	(30062535, 1, 2, 'A', 0),
	(30154177, 1, 1, 'A', 0),
	(30165034, 1, 1, 'A', 0),
	(30165214, 1, 3, 'B', 0),
	(30246595, 1, 4, 'A', 0),
	(30247758, 1, 3, 'A', 0),
	(30248162, 1, 2, 'A', 0),
	(30358006, 1, 7, 'A', 0),
	(30612847, 1, 2, 'A', 0),
	(31408318, 1, 1, 'A', 0);
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

-- Volcando datos para la tabla don_bosco.estudiante: ~205 rows (aproximadamente)
DELETE FROM `estudiante`;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` (`Cedula`, `Nombres`, `Apellidos`, `Direccion`, `Correo`, `Numero_de_telefono`, `Fecha_de_nacimiento`) VALUES
	(24218040, 'Edward Orlando Jose', 'Diaz Rodriguez', 'Petare - Barrio El Carmen', 'jackdryckk@gmail.com', '', '1900-01-01'),
	(26104468, 'Jose Gregorio', 'Ugas Quintero', 'Petare - Barrio Bolívar', 'iguq_3098@hotmail.com', '04242816166', '1900-01-01'),
	(26104748, 'Cesar Augusto', 'Recuero Castro', 'Petare - Barrio el Campito', 'recuero_21@hotmail.com', '04128260093', '1900-01-01'),
	(26272185, 'Cleyver David', 'Almenar Perez', '', '', '', '1900-01-01'),
	(26489708, 'Yuleidys del Carmen', 'Caibe Fernandez', 'Petare - 24 de Marzo', '', '04149130577', '1900-01-01'),
	(26576175, 'Andres Alfonso', 'Perez Viloria', 'Petare', 'andres_viloria_24@hotmail.com', '04262185578', '1900-01-01'),
	(26576852, 'Lina Fernanda', 'Barreto Lopez', 'Petare - José Félix Ribas', 'linabarreto0111@gmail.com', '04123675530', '1900-01-01'),
	(26610414, 'Anniel Leonardo', 'Rodriguez Muñoz ', 'La Dolorita', 'annielleonardo15@gmail.com', '04167188334', '1900-01-01'),
	(26726192, 'Angel Joel', 'Ascanio Gimon', 'José Félix Ribas', 'joelascaniog@gmail.com', '04242247715', '1900-01-01'),
	(26824336, 'Edie Javier', 'Mendoza Delgado', 'Petare - Barrio Metropolitano', 'edie_javier99@hotmail.com', '04242171245', '1900-01-01'),
	(26966020, 'Andrew Alfredo', 'Gomez Correa', '', '', '', '1900-01-01'),
	(26966364, 'Brian Jose', 'Torres Mendoza', 'Petare - 1 de Noviembre', 'bjtm2911@hotmail.com', '04264050824', '1900-01-01'),
	(26993313, 'Alejandro Antonio', 'Mora Muñoz ', 'Petare - José Félix Ribas', '', '04269110044', '1900-01-01'),
	(26993444, 'Niurka Betania', 'Pereira Barrios', 'La Dolorita', 'niurkabetania@gmail.com', '04142273082', '1900-01-01'),
	(27007551, 'Rafael Enrique', 'Trias Martinez ', 'Petare - Guaicoco', 'rafaeltrias@hotmail.com', '04120166368', '1900-01-01'),
	(27007564, 'Manuel Alejandro', 'Rivero Mata', 'Boleita Norte', '', '04129998888', '1900-01-01'),
	(27007671, 'David Alejandro', 'Seitiffe Torres ', 'Lomas del Ávila', 'minivaina99@gmail.com', '04163436227', '1900-01-01'),
	(27007783, 'Juan Carlos', 'Rodriguez Teran', 'Petare', '', '04169158567', '1900-01-01'),
	(27039133, 'Jhorman Alexander', 'Guarisma Blanco', 'Turumo - Caucaguita', 'justdoit@gmail.com', '04128155491', '1900-01-01'),
	(27039134, 'Ana Carolina', 'Fernandez Perez', 'Caucaguita - Turumo', '', '04123991552', '1900-01-01'),
	(27111856, 'Cristhian Eduardo', 'Diaz Duque', 'Campo Rico - Petare', 'lmfao.8064@gmail.com', '04268144065', '1900-01-01'),
	(27111953, 'Wladimir Jose', 'Ferreira Arroyo', 'Carretera Vieja Petare - Guarenas', 'wladimirferreira2014@hotmail.com', '04268202005', '1900-01-01'),
	(27159493, 'Edison Alberto', 'Salazar Gonzalez', 'Las Brisas de Petare', 'oabolie28@yahoo.com', '04268343073', '1900-01-01'),
	(27159726, 'Diosmar Adrian', 'Brito Ascanio', 'José Félix Ribas', 'britodiosmar@gmail.com', '04141350637', '1900-01-01'),
	(27159735, 'Angelo Abraham', 'Morales Ascanio', 'José Félix Ribas', 'angelo.abraham_morales@hotmail.com', '04262050081', '1900-01-01'),
	(27223509, 'Carlos Javier', 'Rodriguez Lobaton', '', '', '', '1900-01-01'),
	(27246779, 'Daniel Alejandro', 'Fajardo Duran', 'Av. Los Chorros', '', '02124167637', '1900-01-01'),
	(27246998, 'Jean Carlos', 'Villafañe Arias', '', '', '', '1900-01-01'),
	(27321523, 'Jose Gregorio', 'Bravo Guzman', 'Petare - El Cerrito', '', '04140196759', '1900-01-01'),
	(27321875, 'Ivanois Duvan', 'Perez Mundarain', 'Petare - José Féliz Ribas', 'ivanoisperez7@gmail.com', '04242358485', '1900-01-01'),
	(27322291, 'Juan Jose', 'Gonzalez Castellano ', 'Petare - Barrio Bolívar', 'jjgonga2424@gmail.com', '04142383702', '1900-01-01'),
	(27333819, 'Jose Alejandro', 'Albarran Echenagucia', 'Campo Rico - Petare', 'josealejandroalbarran@gmail.com', '04142325601', '1900-01-01'),
	(27342125, 'Angela Lisbeth', 'Cañongo Reyes', 'Petare - La Dolorita', '', '04149212285', '1900-01-01'),
	(27344221, 'Enderson Jesus', 'Caseres Gomez', 'San Pascual - Petare', 'endercaceres3@gmail.com', '02129376975', '1900-01-01'),
	(27346614, 'Hendry Luis', 'Araujo Angel ', 'Petare - La Ceiba', 'hendryluisaa@hotmail.com', '04149182170', '1900-01-01'),
	(27359345, 'Bemjamin Abraham', 'Perez Longa', 'Guatire - Parque Alto', 'abrahammozo5@hotmail.com', '04241542637', '1900-01-01'),
	(27359360, 'Moises Aaron', 'Avila Goita ', 'Petare - Barrio Unión', 'moises_avila2013@hotmail.com', '04149119817', '1900-01-01'),
	(27371276, 'Danyer Leonardo', 'Tovar Guillen ', 'Mariche ', 'peligroleo2000@hotmail.com', '04129969682', '1900-01-01'),
	(27391414, 'Daniela Fernanda', 'Mata Ramirez', 'La California', 'mata-daniela@hotmail.com', '04142869319', '1900-01-01'),
	(27426203, 'Paola Nalleris', 'Seijas Valero', '', '', '', '1900-01-01'),
	(27426295, 'Abraham Isidro', 'Duran Zorrilla ', 'Petare - Nazareno', 'duranabraham@hotmail.com', '04241113977', '1900-01-01'),
	(27426758, 'Victor Daniel', 'Baller Perez ', 'San Blas - Petare', 'davidballer@outlook.com', '04142260600', '1900-01-01'),
	(27426859, 'Bryan Jose', 'Suarez Rangel', 'Petare - Barrio Bolívar', '', '04164173952', '1900-01-01'),
	(27439674, 'Hector Gabriel', 'Damas Monasterios', 'La Dolorita', 'hectorgabrieldm@hotmail.com', '04161317702', '1900-01-01'),
	(27448072, 'Moises David', 'Quintero Paiva', 'California - Campo Rico', 'moisesvladimir@hotmail.com', '04169051588', '1900-01-01'),
	(27448779, 'Leonardo Rafael', 'Castellanos Hernandez', 'Guaicoco - Petare', 'leorafacastellano@hotmail.com', '04241620421', '1900-01-01'),
	(27448834, 'Ambar Luzcali', 'Sanchez Meza ', '', '', '04162667310', '1900-01-01'),
	(27448869, 'Jhexend Alexander', 'Marcano Rodriguez ', 'Petare - El Esfuerzo', 'scooby_doo2411@hotmail.com', '04248906226', '1900-01-01'),
	(27449886, 'Maura Yuleika', 'Palacio Castillo', 'Carretera Vieja Petare - Guarenas', 'yulepalacio7@gmail.com', '04168388163', '1900-01-01'),
	(27488079, 'Isaac Jesus', 'Bello Azuaje', 'Julián Blanco - Mariche', 'isaac.j0108@hotmail.com', '04264865036', '1900-01-01'),
	(27488634, 'Jose Andres', 'Hernandez Mendoza', 'Los Dos Caminos', 'j.a.hm1610@gmail.com', '04149083632', '1900-01-01'),
	(27488670, 'Anthony Alejandro', 'Carrillo Molina', 'Carretera Petare - Santa Lucía', 'anthonyeselnene@gmail.com', '04164117610', '1900-01-01'),
	(27488674, 'Sixto Luis', 'Puente Liebano ', 'Petare - 5 de Julio', 'puentesixto@gmail.com', '04263146681', '1900-01-01'),
	(27513098, 'Jean Alfonso', 'Carmona Gil', 'Caucaguita ', 'jeanc27513098@gmail.com', '04162461187', '1900-01-01'),
	(27545280, 'Raiverzon Jesus', 'Marquez Carrillo', '', '', '', '1900-01-01'),
	(27545281, 'Marlys Dayana', 'Chavez Plata ', 'Petare - 19 de Abril', 'mar_plata02@hotmail.com', '04142266564', '1900-01-01'),
	(27545403, 'Laura Vanesa', 'Sanchez Barrios ', 'Caucaguita', 'celeste-12.virgo@hotmail.com', '04165396311', '1900-01-01'),
	(27545912, 'Danny Johander', 'Ballestero Niño', 'Carretera Petare - Santa Lucía', 'darknessdancer34@gmail.com', '04129597338', '1900-01-01'),
	(27588620, 'Reinaldo Jose', 'Perez Sanchez', 'Caucaguita', 'reyps04@gmail.com', '04264106689', '1900-01-01'),
	(27622655, 'Niorlem Alejandra', 'Niño Otero', 'Carretera Petare - Guarenas', 'norlem@hotmail.com', '04162183886', '1900-01-01'),
	(27622859, 'Angie Andreina', 'Duque Camacho', '', '', '', '1900-01-01'),
	(27624610, 'Jhonnaiker Wilfredo', 'Caracas Valladares', '', '', '', '1900-01-01'),
	(27624819, 'Jefferson Daniel', 'Gutierrez Castillo', 'Petare - Nazareno', 'yefo-castillo@hotmail.com', '04269113899', '1900-01-01'),
	(27625201, 'Johann Jesus', 'Arena Arteaga', 'Petare - Barrio Carpintero', 'jjesusarenas18@gmail.com', '04143063786', '1900-01-01'),
	(27659293, 'Leonardo David', 'Carnicella Chacon ', '', '', '', '1900-01-01'),
	(27671132, 'Wilendy del Carmen', 'Casique Romero ', 'Caucaguita - La "I"', 'wilendycasique@hotmail.com', '04129012778', '1900-01-01'),
	(27692858, 'Maiikol Antonio', 'Rodriguez Navarro', 'Petare - San Jose', 'maikolrodriguez07@gmail.com', '', '1900-01-01'),
	(27692921, 'Angel Luis', 'Garcia Hernandez', 'San Blas - Petare', '', '04167217565', '1900-01-01'),
	(27693166, 'Dario Alejandro', 'Vega Romero', 'Petare - José Félix Ribas', 'dario2020@hotmail.com', '04169242226', '1900-01-01'),
	(27693200, 'Gabriel Alejandro', 'Martinez Marin', 'Petare - 19 de Abril', 'gabrielmartinez.12@hotmail.com', '04261677670', '1900-01-01'),
	(27693218, 'Jose Francisco', 'Garcia Peraza ', 'Guatire - Barrio Las Barrancas', 'jose_jfrancisco@hotmail.com', '02123445632', '1900-01-01'),
	(27703437, 'Jose Angel', 'Restrepo Gualdron', 'La Dolorita', 'restrepoj313@gmail.com', '04143653579', '1900-01-01'),
	(27704060, 'Gabriel Alejandro', 'Hernandez Salinas ', 'José Féliz Ribas', 'robertometro2do@hotmail.com', '04241082032', '1900-01-01'),
	(27752874, 'Agelim Chiquinquira', 'Ascanio Ramirez', 'Capuchinos - San Martín', 'weedzyramirez@gmail.com', '02124610790', '1900-01-01'),
	(27761518, 'Carlos Javier', 'Nieto Teran', 'Petare', 'javiernt8200l@hotmail.com', '04122042287', '1900-01-01'),
	(27769120, 'Jordan Alfonso ', 'Escalona Escalona', 'Petare - La 37', 'jordan1020@hotmail.com', '02122933639', '1900-01-01'),
	(27769131, 'Joel Leonardo', 'Parra Duarte', '', '', '', '1900-01-01'),
	(27769161, 'Sander Jose', 'Reyes Fuentes', '', '', '', '1900-01-01'),
	(27769263, 'Enzon Enmanuel', 'Contreras Guerra', 'Petare - Barrio Unión', '', '04167128885', '1900-01-01'),
	(27769441, 'Bernis Onas', 'Mendoza Gonzalez', 'Las Brisas del Llanito', '', '04167157382', '1900-01-01'),
	(27769447, 'Grace Patricia', 'Zambrano Rincon ', 'Palo Verde', 'patty.onedirection@gmail.com', '04129959221', '1900-01-01'),
	(27769449, 'Germain Xavier', 'Acosta Rodriguez', 'Palo Verde - Lomas del Ávila', 'geeracosta@hotmail.com', '04241035472', '1900-01-01'),
	(27769483, 'Nuris Franyeli', 'Rivas Urbina ', 'Petare - 19 de Abril', 'nurysyeli@live.com.mx', '04242941132', '1900-01-01'),
	(27769609, 'Mauro Alexzander', 'Reyes Rivas ', '', '', '', '1900-01-01'),
	(27769674, 'Jeison Andres', 'Chiquillo Esteila', 'Petare - Turumo', 'jeisonandresesteila@hotmail.com', '04140127544', '1900-01-01'),
	(27769849, 'Reminton Brosnan', 'Bracho Dominguez', '', '', '', '1900-01-01'),
	(27769932, 'Jhonaiker Alexis', 'Gomez Velasquez', 'Petare - 19 de Abril', 'jhonaikergomez2015@gmail.com', '04241263363', '1900-01-01'),
	(27770003, 'Omar Enrique', 'Rodriguez Melendez ', '', '', '', '1900-01-01'),
	(27770256, 'Sergio Alexander', 'Narvaez Vargas', 'Petare - Barrio Bolívar', 'sergionarvaezv@gmail.com', '', '1900-01-01'),
	(27772211, 'Vivian Alexandra', 'Rojas Montoya', 'Palo Verde', 'vivianalexandra.rojas@hotmail.com', '04261062493', '1900-01-01'),
	(27788897, 'Jouse Jose', 'Torres Ñañez', '', '', '', '1900-01-01'),
	(27790147, 'Rossnelli Judith', 'Marrero Berroteran', 'Julián Blanco', 'rossne2016@gmail.com', '04249210164', '1900-01-01'),
	(27790281, 'Loriannys Michelle', 'Romero Cabeza', 'Petare - Barrio Unión', '', '04241406295', '1900-01-01'),
	(27790452, 'Jhostyn Moises', 'Junco Sumba', 'Petare - Santa Lucía - Julián Blanco', 'jhostynmoisesjunco@hotmail.com', '04168209825', '1900-01-01'),
	(27790472, 'Luis Sebastian', 'Bello Oviedo', '', '', '', '1900-01-01'),
	(27790952, 'Tifany Nahomi', 'Suarez Corro ', 'Carretera Vieja San Isidro', 'tifanysuarez@hotmail.com', '04148997096', '1900-01-01'),
	(27793842, 'Marcelo Alejandro', 'Diaz Diaz', 'Montalbán - Antímano', 'marcelo-a-d-diaz@hotmail.com', '04128274425', '1900-01-01'),
	(27794045, 'David Alejandro', 'Martinez Muñoz', 'San Agustín Sur', 'cinededavid@hotmail.com', '04261345561', '1900-01-01'),
	(27818422, 'Frank Eduardo', 'Rodriguez Miranda', 'Mariche', 'frank.rodriguez15@gmail.com', '04128110176', '1900-01-01'),
	(27818571, 'Jonas Alejandro', 'Padron Morgado', '', '', '', '1900-01-01'),
	(27818583, 'Aurismar Carolina', 'Rodriguez Rodriguez', '', '', '', '1900-01-01'),
	(27818596, 'Rafael Angel', 'Romero Martinez', 'Barrio Unión - Petare', 'rafaelitorm@hotmail.com', '04168287593', '1900-01-01'),
	(27818835, 'Andriu Alexander', 'Cedeño Mendez', '', '', '', '1900-01-01'),
	(27818877, 'Richard Samuel', 'Gil Quintana', '', '', '', '1900-01-01'),
	(27818944, 'Juan Pablo', 'Pacheco Bracamonte ', '', '', '', '1900-01-01'),
	(27860405, 'Jusset Isael', 'Serrano Segura', 'Ciudad Caribia - Vargas', 'jussetserrano2017@hotmail.com', '02123579589', '1900-01-01'),
	(27879185, 'Gian Franco', 'Guidicelli Diaz', '', '', '', '1900-01-01'),
	(27883682, 'Kenyember Jose', 'Ramos Key', 'Petare - José Felix', 'kenyer_15@outlook.com', '04168365443', '1900-01-01'),
	(27916045, 'Jhostin Jose', 'Velazquez Quijada', 'Guarenas', '', '04267042656', '1900-01-01'),
	(27916155, 'Reddy Orlando', 'Puentes Mejias', '', 'reddypuentes@hotmail.com', '', '1900-01-01'),
	(27916560, 'Jonaly Maria', 'Rojas Torres', '', '', '', '1900-01-01'),
	(27916722, 'Ludwuing Jose', 'Contreras Pinto', 'Agua Salud', 'ludwuingcontreras@gmail.com', '04142420770', '1900-01-01'),
	(27978116, 'Jeyker Steven', 'Herrera Palacios', 'Petare - Carpintero', 'jeykercry@gmail.com', '04262616984', '1900-01-01'),
	(27978507, 'Diego Andres', 'Romero Ramirez', '', '', '', '1900-01-01'),
	(27978695, 'Brian Antonio', 'Cifuentes Castillo', 'Petare', 'briancifuentes10@gmail.com', '04242028436', '1900-01-01'),
	(27978799, 'Andrea Valentina', 'Beomont Yanez ', 'Petare - 5 de Julio', 'yanezandreav@gmail.com', '02122414463', '1900-01-01'),
	(27978839, 'Luis Angel ', 'Hernandez Gamboa ', 'Caucaguita - El Carmen ', 'luishernandezgamboa@gmail.com', '02122441185', '1900-01-01'),
	(28006317, 'Ezequiel David', 'Ibarra Valera', 'Guatire - Antares del Ávila', 'ezequiel-davith@hotmail.com', '04241510644', '1900-01-01'),
	(28007026, 'Eduard Wladimir', 'Artiga Acosta', 'Brisas de Petare', '', '04165964246', '1900-01-01'),
	(28007071, 'Marlon Alejandro', 'Perozo Hernandez ', 'Petare - El Llanito', 'marlon123alejandro@gmail.com', '04129588373', '1900-01-01'),
	(28007205, 'Wilkely Alexandra', 'Matos Lozada', '', '', '', '1900-01-01'),
	(28007320, 'Josue Steven', 'Aponte Duran ', '', '', '', '1900-01-01'),
	(28007419, 'Stefany Alejandro', 'Castillo Martinez', 'Petare - Barrio Bolívar', 'tefv.alei22@gmail.com', '04242196200', '1900-01-01'),
	(28007425, 'Albanys Karolina', 'Machado Peña', '', '', '', '1900-01-01'),
	(28007444, 'Katiuska Aracelis', 'Tovar Barreto ', '', '', '', '1900-01-01'),
	(28007535, 'Erineck Yilberly', 'Rangel Ramirez', 'Petare - La Agricultura', 'yilberly@hotmail.com', '02122517038', '1900-01-01'),
	(28007546, 'Wilyer Jesus', 'Osto Sosa', 'Petare - La Paz', 'wilyersos@gmail.com', '04169056634', '1900-01-01'),
	(28007782, 'Danyerlic Francelys', 'Valera Justo ', '', '', '', '1900-01-01'),
	(28014115, 'Andres Alejandro', 'Rodriguez Cabeza', 'Petare', 'andrespere_@hotmail.com', '', '1900-01-01'),
	(28015421, 'Yeison Enrique', 'Bolivar Venales', 'Palo Verde - José Félix Ribas - Zona 6', 'yeison.bolivar.venales@gmail.com', '04142341324', '1900-01-01'),
	(28015915, 'Karelys Randely', 'Rivero Garcia', 'La Dolorita', 'karelysrivero297@gmail.com', '04266892756', '1900-01-01'),
	(28052112, 'Pedro Luis', 'Moreno Villarroel', 'Petare - José Félix Ribas', 'pedromoreno2012@hotmail.com', '02128937310', '1900-01-01'),
	(28052196, 'Branklin Salvador', 'Rodriguez Daniele', 'Vista Hermosa - Petare', 'branklin36@gmail.com', '04160140065', '1900-01-01'),
	(28052197, 'Elvis Josue', 'Marchena Andrade', '', '', '', '1900-01-01'),
	(28052338, 'Daiver Ivan', 'Lara Rondon', 'Petare - Barrio Unión ', 'daiver-2014@hotmail.com', '04120244901', '1900-01-01'),
	(28052473, 'Norland Jesus', 'Rodriguez Torres', 'Petare - La Agricultura', 'norlandrodriguez12@gmail.com', '04143283078', '1900-01-01'),
	(28052474, 'Gabriel Eduardo', 'Escalona Pacheco', '', '', '', '1900-01-01'),
	(28052569, 'Jorge Manuel', 'Torres Mendoza ', 'Petare - Guicoco', 'jt462018@gmail.com', '04140292603', '1900-01-01'),
	(28052726, 'Daniel Nicolas', 'Blanco Torres', 'Petare - Guarenas', 'danielklan92@gmail.com', '04169119850', '1900-01-01'),
	(28052971, 'Joan Gabriel', 'Marquez Gomez', 'Carpintero - Petare - Valle Alto', '', '04242086534', '1900-01-01'),
	(28053300, 'Kewis Yonier', 'Baez Perez', 'Petare - Campo Rico', 'kewis-2001@hotmail.com', '04261051867', '1900-01-01'),
	(28053393, 'Dainer Josue', 'Hernandez Caracas', 'Caucaguita - El Bruzón', 'dainerjosue_2013@hotmail.com', '04266072647', '1900-01-01'),
	(28053753, 'Franyerlis', 'Alcazar Mercado', 'Guarenas - Ciudad Belen', 'framyelis815@gmail.com', '04269004010', '1900-01-01'),
	(28058266, 'Yolfran David', 'Castro Zambrano', 'Caucaguita - El Carmen ', 'yolfran04@gmail.com', '04243996819', '1900-01-01'),
	(28076457, 'Katherine Cecilia', 'Mayorga Dickson ', '', '', '', '1900-01-01'),
	(28101501, 'Daniela de la Concepcion', 'Carrillo Tovar', 'Petare - Barrio El Encantado', 'danielacarrillo966@gmail.com', '04168194008', '1900-01-01'),
	(28101680, 'Luis Manuel', 'Barcelo Gonzalez', 'La Dolorita - Mariche', 'barcelox28101680@gmail.com', '04265209719', '1900-01-01'),
	(28101714, 'Hector David', 'Marin Pereira', '', '', '', '1900-01-01'),
	(28116113, 'Alejandro Jose', 'Gudiño Briceño ', 'Petare - La Dolorita', 'alejandro26jgb@hotmail.com', '04242659775', '1900-01-01'),
	(28116269, 'Johander Daniel', 'Moncada Caracas', '', '', '', '1900-01-01'),
	(28116623, 'Lisandro Heiderk', 'Lugo Benavente', 'Caucaguita - Los Bloques', 'lisandrolugo_269@hotmail.com', '04164139813', '1900-01-01'),
	(28116858, 'Jose Gregorio', 'Montilla Mejias', '', '', '', '1900-01-01'),
	(28117130, 'Miguel Angel', 'Manotas Pacheco', '', '', '', '1900-01-01'),
	(28135158, 'Deiver Alexander', 'Molina Perez ', '', '', '', '1900-01-01'),
	(28143615, 'Norkelys del Carmen', 'Manzanilla Ramirez', 'San Agustín Norte', 'norkys10.escorpion@gmail.com', '04261246830', '1900-01-01'),
	(28146413, 'Luis Miguel', 'Herrera Rondon', 'Petare - Carpintero', 'luismhr12@hotmail.com', '04166128542', '1900-01-01'),
	(28154139, 'Victor Hugo', 'Torres Lara', 'Artigas - Atlántico', 'victorhugotorreslara@gmail.com', '04263203813', '1900-01-01'),
	(28158289, 'Joel Martin', 'Carta Moreno', 'Petare - Barrio Carpintero', '', '04267737667', '1900-01-01'),
	(28158342, 'Abraham Jose', 'Milano Gil ', '', '', '', '1900-01-01'),
	(28158365, 'Ismary Yetzary', 'Armas Barrios', 'Barrio Unión - Petare', 'ismaryyetzary@hotmail.com', '04241874427', '1900-01-01'),
	(28158376, 'Jesus Alberto', 'Armas Barrios', 'Petare - Barrio Unión', 'jesus-armas599@hotmail.com', '04141264902', '1900-01-01'),
	(28158446, 'Angher Javier', 'Rodriguez Villarroel', '', '', '', '1900-01-01'),
	(28158548, 'Jose Alfonso', 'Ferrer Garcia', 'Mirador del Este', 'ferrerjose467@gmail.com', '04165640247', '1900-01-01'),
	(28158887, 'Ediling Andreina', 'Rivas Ramirez', '', '', '', '1900-01-01'),
	(28180284, 'Ruben David', 'Baquero Bayuelo', 'Petare - Barrio Unión', 'ruben1610200@hotmail.com', '04127247543', '1900-01-01'),
	(28209447, 'Ghineivi Maria', 'Carreño Canelon ', 'Isaías Medina Angarita', 'ghineivy-14@hotmail.com', '04242177095', '1900-01-01'),
	(28218130, 'Jeimer Eduardo', 'Mendoza Jimenez', '', '', '', '1900-01-01'),
	(28218209, 'Dylan Armando ', 'Lozada Torrealba', 'Petare - Llanito - Mirador del Este', 'dylanlt.0826@hotmail.com', '04165349992', '1900-01-01'),
	(28218335, 'Jhoan de Jesus', 'Sarmiento Sarmiento', 'Petare - Bombilla', 'sarmientodejesus33@gmail.com', '', '1900-01-01'),
	(28218533, 'Ithaal Ammydha', 'Hurtado Navarrete', 'Petare - La Urbina - Barrio San José', 'boreteli@hotmail.com', '04242915231', '1900-01-01'),
	(28218618, 'Jose Gregorio', 'Flores Yanez', 'Mariche - La Dolorita', 'josegregorioflores068@gmail.com', '04143567724', '1900-01-01'),
	(28308847, 'Carlos Eduardo', 'Bracamonte Espinoza', 'San Pascual - Mesuca', 'bracamontecarlos229@hotmail.com', '04142605159', '1900-01-01'),
	(28309079, 'Antoni Jose', 'Polo Chourio ', '', '', '', '1900-01-01'),
	(28309415, 'Leandro Jose', 'Chirino Sangronis', '', '', '', '1900-01-01'),
	(28317843, 'Josue Misael', 'Bonilla Dionicio', 'San Pascual - Mesuca', '', '04160628413', '1900-01-01'),
	(28324759, 'Kendry Maribel', 'Rausseo Parada', '', '', '', '1900-01-01'),
	(28325252, 'Nathalia Beatriz', 'Sanmartin Sumba ', 'Petare - Julián Blanco', '', '04141167044', '1900-01-01'),
	(28330354, 'Carlos Marcelo', 'Sanfiel Cadiz', 'Barrio Unión - Petare', 'carlossanfiel28@hotmail.com', '04241308863', '1900-01-01'),
	(28332612, 'Rachely Nayly', 'Castellano Cordero', 'Caucaguita - Aguacatico', 'rachelybella_11@hotmail.com', '02124163546', '1900-01-01'),
	(28332945, 'Cristian Jose', 'Camacaro Guevara', 'Petare - Barrio Sucre', 'cristian.camacaro@gmail.com', '04120179996', '1900-01-01'),
	(28333395, 'Gabriel Jose', 'Bravo Guzman ', 'Petare - El Cerrito', 'gabobravo11@hotmail.com', '04140106759', '1900-01-01'),
	(28448034, 'Luis Oswaldo', 'Abello Rodriguez', 'Petare - Barrio Carpintero', '', '04261045729', '1900-01-01'),
	(28448041, 'Emilio Jose', 'Gutierrez Morales', 'Petare - Zona Colonial', 'emigut041@gmail.com', '04164010920', '1900-01-01'),
	(28448664, 'Carlos Alberto', 'Avendaño Campos ', '', '', '', '1900-01-01'),
	(28448832, 'Gabriela Isabel', 'Molina Garcia', 'Caucaguita', 'gabrielaiisabel@hotmail.com', '04261059555', '1900-01-01'),
	(28469300, 'Gabriel Alejandro', 'Delgado Perez', 'Chacao - Av. José Félix Sosa', 'gabridelperez2@gmail.com', '04241999321', '1900-01-01'),
	(28484815, 'Sorangelys Nahomy', 'Polo Barrios', 'Mesuca', 'soranpb07@gmail.com', '04129775711', '1900-01-01'),
	(28484989, 'Joel Felipe', 'Santana Crespo ', '', '', '', '1900-01-01'),
	(29501461, 'Migue Angel', 'Ortega Bellorin', 'Guatire - Parque Alto', 'miguelaortegamoda.mb2001@gmail.com', '04263127329', '1900-01-01'),
	(29518741, 'Claudia Valentina', 'Salas Alves ', 'Petare - El Nazareno', 'clau-queen@hotmail.com', '04149901395', '1900-01-01'),
	(29537192, 'Anthony Jose', 'Landaez Malave', 'Petare - 24 de Abril', 'landaez.malavenuevo@hotmail.com', '', '1900-01-01'),
	(29537298, 'Gabriel Enrique', 'Martinez Flores', 'Guarenas - Urb. Turumo', 'gabrielme2000@hotmail.com', '04242924180', '1900-01-01'),
	(29537588, 'Jose Miguel', 'Echenique Gutierrez', 'Caucaguita - El Carmen', 'jose.ma2012@hotmail.com', '02129376408', '1900-01-01'),
	(29537724, 'Wiklerman Alexander', 'Perez Betancourt', '', '', '', '1900-01-01'),
	(29537992, 'Eudys Rolando', 'Chirinos Hernandez', '', '', '', '1900-01-01'),
	(29577358, 'Giovanny Javier', 'Pernia Godoy', 'Petare - San Rafael', 'giovannypernia@hotmail.com', '04169022315', '1900-01-01'),
	(29577802, 'Axel Armando', 'Mantilla Barreto ', 'Caucaguita', 'axel.mantilla@hotmail.com', '04241400186', '1900-01-01'),
	(29577930, 'Jeison Jose', 'Blanco Padron', 'Petare - San Isidro', 'jeisonb11@gmail.com', '04241974562', '1900-01-01'),
	(29578687, 'Luis Miguel', 'Garcia Moreno', '', '', '', '1900-01-01'),
	(29589945, 'Abel Alfonzo', 'Marquez Bosson', 'Av. Palmarito - La California', 'abelmarquez08@gmail.com', '04164867096', '1900-01-01'),
	(29609295, 'Deiker Daniel', 'Castillo Canelon', 'La Urbina', 'deikerdcastillo@hotmail.com', '04128008952', '1900-01-01'),
	(29621425, 'Andrea Julieth', 'Gonzalez Vargas ', 'Petare - La Agricultura', 'andrea.jgv@gmail.com', '04127007754', '1900-01-01'),
	(29621763, 'Brayan Oswaldo', 'Oviedo Navarro', '', '', '', '1900-01-01'),
	(29621846, 'Neurelkis Dayana', 'Ramirez Sanchez', 'La Agricultura - Petare', 'neurelkis74@gmail.com', '04242243571', '1900-01-01'),
	(29662025, 'Anthony Daniel', 'Torres Alcala ', '', '', '', '1900-01-01'),
	(29662966, 'Daniel Eduardo', 'Avila Avila', 'Petare- Barrio Bolívar', 'danieleavila2001@hotmail.com', '04242418265', '1900-01-01'),
	(29677939, 'Gregory Isaac ', 'Sosa Majano ', 'Petare - El Morro', 'isaacsosamajano@gmail.com', '04242366415', '1900-01-01'),
	(29706478, 'Brayan Jose', 'Rueda Castro', '', '', '', '1900-01-01'),
	(29720517, 'Jeremmi Alexander', 'Lugo Wetzstein', '', '', '', '1900-01-01'),
	(29784944, 'Luis Alfonso', 'Perez Vergel', 'La Dolorita - Guaicoco', 'luiszero9@hotmail.com', '04141343808', '1900-01-01'),
	(29832761, 'Eduar Jose ', 'Petaquero Perdomo', 'Carpintero - Petare', 'eduarpetaper25@gmail.com', '04268122642', '1900-01-01'),
	(29865277, 'Leonel Alejandro', 'Maneiro Garcia', 'Guatire', '', '', '1900-01-01'),
	(29883426, 'Mianllyli Mayerlig', 'Osorio Perez', 'Caucaguita', 'mianllily@hotmail.com', '04242737595', '1900-01-01'),
	(29883723, 'Brayan Jorge Julian', 'Rebolledo Milla', 'Petare - 24 de Julio', 'brebolledo27@gmail.com', '04242602574', '1900-01-01'),
	(29888595, 'Yicsy Carolay', 'Marquina Perez', 'Turumo', 'gipsymarquina@gmail.com', '04241212802', '1900-01-01'),
	(29904321, 'Kleiderman Alberto', 'Ramirez Garcia', 'Petare - El Llanito', 'kleiderman123@outlook.com', '04127009731', '1900-01-01'),
	(29935980, 'Franklin Jose', 'Guerra Carpio ', '', 'mateo.guerra.caarpio@gmail.com', '04165245194', '1900-01-01'),
	(30062535, 'Kleiber Jose', 'Nadales Rojas', '', '', '', '1900-01-01'),
	(30154177, 'Yon Jose', 'Payan Rocha ', '', '', '', '1900-01-01'),
	(30165034, 'Maria Alejandra', 'Landaez Chacon ', 'Las Brisas - El Llanito', 'maria.landaez173@gmail.com', '04169226502', '1900-01-01'),
	(30165214, 'Renee Gabriel', 'Rodriguez Delgado', 'Petare - Mariche', 'rgrodriguez1001@gmail.com', '04264051069', '1900-01-01'),
	(30246595, 'Cristhian Enrique', 'Olivar Barreto', 'Caucaguita', 'cristhianolivar@gmail.com', '04264022751', '1900-01-01'),
	(30247758, 'Humberto Rafael', 'Aguilera Avila', 'Petare - Barrio Carpintero', '', '04262186679', '1900-01-01'),
	(30248162, 'Juan Eduardo', 'Requena Merchan', '', '', '', '1900-01-01'),
	(30358006, 'Carlos Eduardo', 'Gomez Villamizar', 'Petare - Barrio Carpintero', 'carl_carlos_gomez@hotmail.com', '04142561230', '1900-01-01'),
	(30612847, 'Enyerbeth Jose', 'Torres Ugas', '', '', '', '1900-01-01'),
	(31408318, 'Fabiola Alejandra', 'Mendoza Cervantes ', 'Carpintero - Petare', 'swagiifabi@gmail.com', '04141502016', '1900-01-01');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.periodo
CREATE TABLE IF NOT EXISTS `periodo` (
  `Periodo_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del periodo',
  `Periodo_nombre` varchar(10) NOT NULL DEFAULT '0' COMMENT 'Periodo ',
  `Eliminada` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si el periodo esta eliminado o no',
  PRIMARY KEY (`Periodo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Periodos en la escuela tecnica popular don bosco';

-- Volcando datos para la tabla don_bosco.periodo: ~0 rows (aproximadamente)
DELETE FROM `periodo`;
/*!40000 ALTER TABLE `periodo` DISABLE KEYS */;
INSERT INTO `periodo` (`Periodo_ID`, `Periodo_nombre`, `Eliminada`) VALUES
	(1, '2016-2017', 0);
/*!40000 ALTER TABLE `periodo` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.personal
CREATE TABLE IF NOT EXISTS `personal` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula del trabajador',
  `Nombres` varchar(50) NOT NULL COMMENT 'Nombre del trabajador',
  `Apellidos` varchar(50) NOT NULL COMMENT 'Apellido del trabajador',
  `Direccion` varchar(100) DEFAULT NULL COMMENT 'Direccion del trabajador',
  `Correo` varchar(50) DEFAULT NULL COMMENT 'Correo del trabajador',
  `Numero_de_telefono` varchar(50) DEFAULT NULL COMMENT 'Numero de telefono del trabajador',
  PRIMARY KEY (`Cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informacion de trabajadores de la escuela tecnica popular don bosco';

-- Volcando datos para la tabla don_bosco.personal: ~7 rows (aproximadamente)
DELETE FROM `personal`;
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;

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

-- Volcando datos para la tabla don_bosco.seccion: ~12 rows (aproximadamente)
DELETE FROM `seccion`;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` (`Carrera_ID`, `Periodo_ID`, `Cantidad`) VALUES
	(1, 1, 1),
	(2, 1, 1),
	(3, 1, 2),
	(4, 1, 1),
	(5, 1, 1),
	(6, 1, 1),
	(7, 1, 2),
	(8, 1, 1),
	(9, 1, 1),
	(10, 1, 1),
	(11, 1, 1),
	(12, 1, 1);
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.tipo_trabajador
CREATE TABLE IF NOT EXISTS `tipo_trabajador` (
  `id_tipo` int(1) NOT NULL,
  `cargo` varchar(255) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla don_bosco.tipo_trabajador: ~3 rows (aproximadamente)
DELETE FROM `tipo_trabajador`;
/*!40000 ALTER TABLE `tipo_trabajador` DISABLE KEYS */;
INSERT INTO `tipo_trabajador` (`id_tipo`, `cargo`) VALUES
	(1, 'Docente'),
	(2, 'Administrativo'),
	(3, 'Obrero');
/*!40000 ALTER TABLE `tipo_trabajador` ENABLE KEYS */;

-- Volcando estructura para tabla don_bosco.trabaja
CREATE TABLE IF NOT EXISTS `trabaja` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula de los trabajadores',
  `Tipo` int(1) NOT NULL COMMENT 'Tipo de trabajador',
  `Periodo_ID` int(11) NOT NULL COMMENT 'ID del periodo lectivo',
  `Inasistencias` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Las inasistencias del estudiante en ese periodo',
  PRIMARY KEY (`Cedula`,`Periodo_ID`),
  KEY `Periodo` (`Periodo_ID`),
  KEY `fk_trabaja_tipo` (`Tipo`),
  CONSTRAINT `Cedula_Trabajador` FOREIGN KEY (`Cedula`) REFERENCES `personal` (`Cedula`),
  CONSTRAINT `Periodo_Trabajador` FOREIGN KEY (`Periodo_ID`) REFERENCES `periodo` (`Periodo_ID`),
  CONSTRAINT `fk_trabaja_tipo` FOREIGN KEY (`Tipo`) REFERENCES `tipo_trabajador` (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre los trabajadores y el periodo';

-- Volcando datos para la tabla don_bosco.trabaja: ~7 rows (aproximadamente)
DELETE FROM `trabaja`;
/*!40000 ALTER TABLE `trabaja` DISABLE KEYS */;
/*!40000 ALTER TABLE `trabaja` ENABLE KEYS */;

-- Volcando estructura para vista don_bosco.view_correos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `view_correos` (
	`correo` VARCHAR(50) NULL COMMENT 'Correo del trabajador' COLLATE 'utf8_general_ci',
	`tipo` INT(1) NOT NULL COMMENT 'Tipo de trabajador'
) ENGINE=MyISAM;

-- Volcando estructura para vista don_bosco.view_correos
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `view_correos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_correos` AS select `p`.`Correo` AS `correo`,`t`.`Tipo` AS `tipo` from (`personal` `p` join `trabaja` `t`) where (`p`.`Cedula` = `t`.`Cedula`);

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
