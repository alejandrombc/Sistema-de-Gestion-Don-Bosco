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

-- Volcando estructura para tabla don_bosco.correo_enviado
CREATE TABLE IF NOT EXISTS `correo_enviado` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `correo` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Lista a los correos que se les han enviado algo';

-- Volcando datos para la tabla don_bosco.correo_enviado: ~2 rows (aproximadamente)
DELETE FROM `correo_enviado`;
/*!40000 ALTER TABLE `correo_enviado` DISABLE KEYS */;
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

-- Volcando datos para la tabla don_bosco.cursa: ~34 rows (aproximadamente)
DELETE FROM `cursa`;
/*!40000 ALTER TABLE `cursa` DISABLE KEYS */;
INSERT INTO `cursa` (`Cedula`, `Periodo_ID`, `Carrera_ID`, `Seccion_actual`, `Inasistencias`) VALUES
	(27039134, 1, 4, 'A', 0),
	(27448834, 1, 1, 'A', 0),
	(27545280, 1, 4, 'A', 0),
	(27622859, 1, 4, 'A', 0),
	(27671132, 1, 1, 'A', 0),
	(27692921, 1, 1, 'A', 0),
	(27752874, 1, 1, 'A', 0),
	(27769120, 1, 4, 'A', 0),
	(27769131, 1, 2, 'A', 0),
	(27769161, 1, 2, 'A', 0),
	(27769609, 1, 2, 'A', 0),
	(27769849, 1, 2, 'A', 0),
	(27770003, 1, 2, 'A', 0),
	(27788897, 1, 2, 'A', 0),
	(27793842, 1, 4, 'A', 0),
	(27818571, 1, 2, 'A', 0),
	(27818583, 1, 1, 'A', 0),
	(27818835, 1, 2, 'A', 0),
	(27818877, 1, 2, 'A', 0),
	(27818944, 1, 1, 'A', 0),
	(27879185, 1, 2, 'A', 0),
	(27916560, 1, 1, 'A', 0),
	(27978695, 1, 4, 'A', 0),
	(27978799, 1, 1, 'A', 0),
	(27978839, 1, 1, 'A', 0),
	(28007026, 1, 4, 'A', 0),
	(28007205, 1, 2, 'A', 0),
	(28007320, 1, 2, 'A', 0),
	(28007419, 1, 4, 'A', 0),
	(28007425, 1, 2, 'A', 0),
	(28007444, 1, 1, 'A', 0),
	(28007782, 1, 1, 'A', 0),
	(28015421, 1, 1, 'A', 0),
	(28052196, 1, 1, 'A', 0),
	(28052474, 1, 2, 'A', 0),
	(28052971, 1, 4, 'A', 0),
	(28053300, 1, 4, 'A', 0),
	(28053393, 1, 1, 'A', 0),
	(28053753, 1, 1, 'A', 0),
	(28058266, 1, 4, 'A', 0),
	(28076457, 1, 1, 'A', 0),
	(28101714, 1, 2, 'A', 0),
	(28116858, 1, 2, 'A', 0),
	(28117130, 1, 2, 'A', 0),
	(28143615, 1, 4, 'A', 0),
	(28146413, 1, 4, 'A', 0),
	(28158342, 1, 1, 'A', 0),
	(28158365, 1, 1, 'A', 0),
	(28158446, 1, 2, 'A', 0),
	(28158887, 1, 1, 'A', 0),
	(28180284, 1, 4, 'A', 0),
	(28209447, 1, 1, 'A', 0),
	(28218130, 1, 2, 'A', 0),
	(28218618, 1, 1, 'A', 0),
	(28309415, 1, 2, 'A', 0),
	(28332612, 1, 1, 'A', 0),
	(28332945, 1, 1, 'A', 0),
	(28333395, 1, 4, 'A', 0),
	(28484815, 1, 1, 'A', 0),
	(28484989, 1, 2, 'A', 0),
	(29518741, 1, 1, 'A', 0),
	(29537588, 1, 4, 'A', 0),
	(29537724, 1, 1, 'A', 0),
	(29537992, 1, 2, 'A', 0),
	(29577802, 1, 4, 'A', 0),
	(29578687, 1, 2, 'A', 0),
	(29621425, 1, 1, 'A', 0),
	(29621763, 1, 2, 'A', 0),
	(29662025, 1, 2, 'A', 0),
	(29677939, 1, 1, 'A', 0),
	(29706478, 1, 2, 'A', 0),
	(29832761, 1, 1, 'A', 0),
	(29888595, 1, 4, 'A', 0),
	(30062535, 1, 2, 'A', 0),
	(30154177, 1, 1, 'A', 0),
	(30165034, 1, 1, 'A', 0),
	(30248162, 1, 2, 'A', 0),
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

-- Volcando datos para la tabla don_bosco.estudiante: ~34 rows (aproximadamente)
DELETE FROM `estudiante`;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` (`Cedula`, `Nombres`, `Apellidos`, `Direccion`, `Correo`, `Numero_de_telefono`, `Fecha_de_nacimiento`) VALUES
	(27039134, 'Ana Carolina', 'Fernandez Perez', 'Caucaguita - Turumo', '', '04123991552', '1900-01-01'),
	(27448834, 'Ambar Luzcali', 'Sanchez Meza ', '', '', '04162667310', '1900-01-01'),
	(27545280, 'Raiverzon Jesus', 'Marquez Carrillo', '', '', '', '1900-01-01'),
	(27622859, 'Angie Andreina', 'Duque Camacho', '', '', '', '1900-01-01'),
	(27671132, 'Wilendy del Carmen', 'Casique Romero ', 'Caucaguita - La "I"', 'wilendycasique@hotmail.com', '04129012778', '1900-01-01'),
	(27692921, 'Angel Luis', 'Garcia Hernandez', 'San Blas - Petare', '', '04167217565', '1900-01-01'),
	(27752874, 'Agelim Chiquinquira', 'Ascanio Ramirez', 'Capuchinos - San Martín', 'weedzyramirez@gmail.com', '02124610790', '1900-01-01'),
	(27769120, 'Jordan Alfonso ', 'Escalona Escalona', 'Petare - La 37', 'jordan1020@hotmail.com', '02122933639', '1900-01-01'),
	(27769131, 'Joel Leonardo', 'Parra Duarte', '', '', '', '1900-01-01'),
	(27769161, 'Sander Jose', 'Reyes Fuentes', '', '', '', '1900-01-01'),
	(27769609, 'Mauro Alexzander', 'Reyes Rivas ', '', '', '', '1900-01-01'),
	(27769849, 'Reminton Brosnan', 'Bracho Dominguez', '', '', '', '1900-01-01'),
	(27770003, 'Omar Enrique', 'Rodriguez Melendez ', '', '', '', '1900-01-01'),
	(27788897, 'Jouse Jose', 'Torres Ñañez', '', '', '', '1900-01-01'),
	(27793842, 'Marcelo Alejandro', 'Diaz Diaz', 'Montalbán - Antímano', 'marcelo-a-d-diaz@hotmail.com', '04128274425', '1900-01-01'),
	(27818571, 'Jonas Alejandro', 'Padron Morgado', '', '', '', '1900-01-01'),
	(27818583, 'Aurismar Carolina', 'Rodriguez Rodriguez', '', '', '', '1900-01-01'),
	(27818835, 'Andriu Alexander', 'Cedeño Mendez', '', '', '', '1900-01-01'),
	(27818877, 'Richard Samuel', 'Gil Quintana', '', '', '', '1900-01-01'),
	(27818944, 'Juan Pablo', 'Pacheco Bracamonte ', '', '', '', '1900-01-01'),
	(27879185, 'Gian Franco', 'Guidicelli Diaz', '', '', '', '1900-01-01'),
	(27916560, 'Jonaly Maria', 'Rojas Torres', '', '', '', '1900-01-01'),
	(27978695, 'Brian Antonio', 'Cifuentes Castillo', 'Petare', 'briancifuentes10@gmail.com', '04242028436', '1900-01-01'),
	(27978799, 'Andrea Valentina', 'Beomont Yanez ', 'Petare - 5 de Julio', 'yanezandreav@gmail.com', '02122414463', '1900-01-01'),
	(27978839, 'Luis Angel ', 'Hernandez Gamboa ', 'Caucaguita - El Carmen ', 'luishernandezgamboa@gmail.com', '02122441185', '1900-01-01'),
	(28007026, 'Eduard Wladimir', 'Artiga Acosta', 'Brisas de Petare', '', '04165964246', '1900-01-01'),
	(28007205, 'Wilkely Alexandra', 'Matos Lozada', '', '', '', '1900-01-01'),
	(28007320, 'Josue Steven', 'Aponte Duran ', '', '', '', '1900-01-01'),
	(28007419, 'Stefany Alejandro', 'Castillo Martinez', 'Petare - Barrio Bolívar', 'tefv.alei22@gmail.com', '04242196200', '1900-01-01'),
	(28007425, 'Albanys Karolina', 'Machado Peña', '', '', '', '1900-01-01'),
	(28007444, 'Katiuska Aracelis', 'Tovar Barreto ', '', '', '', '1900-01-01'),
	(28007782, 'Danyerlic Francelys', 'Valera Justo ', '', '', '', '1900-01-01'),
	(28015421, 'Yeison Enrique', 'Bolivar Venales', 'Palo Verde - José Félix Ribas - Zona 6', 'yeison.bolivar.venales@gmail.com', '04142341324', '1900-01-01'),
	(28052196, 'Branklin Salvador', 'Rodriguez Daniele', 'Vista Hermosa - Petare', 'branklin36@gmail.com', '04160140065', '1900-01-01'),
	(28052474, 'Gabriel Eduardo', 'Escalona Pacheco', '', '', '', '1900-01-01'),
	(28052971, 'Joan Gabriel', 'Marquez Gomez', 'Carpintero - Petare - Valle Alto', '', '04242086534', '1900-01-01'),
	(28053300, 'Kewis Yonier', 'Baez Perez', 'Petare - Campo Rico', 'kewis-2001@hotmail.com', '04261051867', '1900-01-01'),
	(28053393, 'Dainer Josue', 'Hernandez Caracas', 'Caucaguita - El Bruzón', 'dainerjosue_2013@hotmail.com', '04266072647', '1900-01-01'),
	(28053753, 'Franyerlis', 'Alcazar Mercado', 'Guarenas - Ciudad Belen', 'framyelis815@gmail.com', '04269004010', '1900-01-01'),
	(28058266, 'Yolfran David', 'Castro Zambrano', 'Caucaguita - El Carmen ', 'yolfran04@gmail.com', '04243996819', '1900-01-01'),
	(28076457, 'Katherine Cecilia', 'Mayorga Dickson ', '', '', '', '1900-01-01'),
	(28101714, 'Hector David', 'Marin Pereira', '', '', '', '1900-01-01'),
	(28116858, 'Jose Gregorio', 'Montilla Mejias', '', '', '', '1900-01-01'),
	(28117130, 'Miguel Angel', 'Manotas Pacheco', '', '', '', '1900-01-01'),
	(28143615, 'Norkelys del Carmen', 'Manzanilla Ramirez', 'San Agustín Norte', 'norkys10.escorpion@gmail.com', '04261246830', '1900-01-01'),
	(28146413, 'Luis Miguel', 'Herrera Rondon', 'Petare - Carpintero', 'luismhr12@hotmail.com', '04166128542', '1900-01-01'),
	(28158342, 'Abraham Jose', 'Milano Gil ', '', '', '', '1900-01-01'),
	(28158365, 'Ismary Yetzary', 'Armas Barrios', 'Barrio Unión - Petare', 'ismaryyetzary@hotmail.com', '04241874427', '1900-01-01'),
	(28158446, 'Angher Javier', 'Rodriguez Villarroel', '', '', '', '1900-01-01'),
	(28158887, 'Ediling Andreina', 'Rivas Ramirez', '', '', '', '1900-01-01'),
	(28180284, 'Ruben David', 'Baquero Bayuelo', 'Petare - Barrio Unión', 'ruben1610200@hotmail.com', '04127247543', '1900-01-01'),
	(28209447, 'Ghineivi Maria', 'Carreño Canelon ', 'Isaías Medina Angarita', 'ghineivy-14@hotmail.com', '04242177095', '1900-01-01'),
	(28218130, 'Jeimer Eduardo', 'Mendoza Jimenez', '', '', '', '1900-01-01'),
	(28218618, 'Jose Gregorio', 'Flores Yanez', 'Mariche - La Dolorita', 'josegregorioflores068@gmail.com', '04143567724', '1900-01-01'),
	(28309415, 'Leandro Jose', 'Chirino Sangronis', '', '', '', '1900-01-01'),
	(28332612, 'Rachely Nayly', 'Castellano Cordero', 'Caucaguita - Aguacatico', 'rachelybella_11@hotmail.com', '02124163546', '1900-01-01'),
	(28332945, 'Cristian Jose', 'Camacaro Guevara', 'Petare - Barrio Sucre', 'cristian.camacaro@gmail.com', '04120179996', '1900-01-01'),
	(28333395, 'Gabriel Jose', 'Bravo Guzman ', 'Petare - El Cerrito', 'gabobravo11@hotmail.com', '04140106759', '1900-01-01'),
	(28484815, 'Sorangelys Nahomy', 'Polo Barrios', 'Mesuca', 'soranpb07@gmail.com', '04129775711', '1900-01-01'),
	(28484989, 'Joel Felipe', 'Santana Crespo ', '', '', '', '1900-01-01'),
	(29518741, 'Claudia Valentina', 'Salas Alves ', 'Petare - El Nazareno', 'clau-queen@hotmail.com', '04149901395', '1900-01-01'),
	(29537588, 'Jose Miguel', 'Echenique Gutierrez', 'Caucaguita - El Carmen', 'jose.ma2012@hotmail.com', '02129376408', '1900-01-01'),
	(29537724, 'Wiklerman Alexander', 'Perez Betancourt', '', '', '', '1900-01-01'),
	(29537992, 'Eudys Rolando', 'Chirinos Hernandez', '', '', '', '1900-01-01'),
	(29577802, 'Axel Armando', 'Mantilla Barreto ', 'Caucaguita', 'axel.mantilla@hotmail.com', '04241400186', '1900-01-01'),
	(29578687, 'Luis Miguel', 'Garcia Moreno', '', '', '', '1900-01-01'),
	(29621425, 'Andrea Julieth', 'Gonzalez Vargas ', 'Petare - La Agricultura', 'andrea.jgv@gmail.com', '04127007754', '1900-01-01'),
	(29621763, 'Brayan Oswaldo', 'Oviedo Navarro', '', '', '', '1900-01-01'),
	(29662025, 'Anthony Daniel', 'Torres Alcala ', '', '', '', '1900-01-01'),
	(29677939, 'Gregory Isaac ', 'Sosa Majano ', 'Petare - El Morro', 'isaacsosamajano@gmail.com', '04242366415', '1900-01-01'),
	(29706478, 'Brayan Jose', 'Rueda Castro', '', '', '', '1900-01-01'),
	(29832761, 'Eduar Jose ', 'Petaquero Perdomo', 'Carpintero - Petare', 'eduarpetaper25@gmail.com', '04268122642', '1900-01-01'),
	(29888595, 'Yicsy Carolay', 'Marquina Perez', 'Turumo', 'gipsymarquina@gmail.com', '04241212802', '1900-01-01'),
	(30062535, 'Kleiber Jose', 'Nadales Rojas', '', '', '', '1900-01-01'),
	(30154177, 'Yon Jose', 'Payan Rocha ', '', '', '', '1900-01-01'),
	(30165034, 'Maria Alejandra', 'Landaez Chacon ', 'Las Brisas - El Llanito', 'maria.landaez173@gmail.com', '04169226502', '1900-01-01'),
	(30248162, 'Juan Eduardo', 'Requena Merchan', '', '', '', '1900-01-01'),
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

-- Volcando datos para la tabla don_bosco.periodo: ~2 rows (aproximadamente)
DELETE FROM `periodo`;
/*!40000 ALTER TABLE `periodo` DISABLE KEYS */;
INSERT INTO `periodo` (`Periodo_ID`, `Periodo_nombre`, `Eliminada`) VALUES
	(1, '2016-2017', 0);
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

-- Volcando datos para la tabla don_bosco.seccion: ~12 rows (aproximadamente)
DELETE FROM `seccion`;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` (`Carrera_ID`, `Periodo_ID`, `Cantidad`) VALUES
	(1, 1, 1),
	(2, 1, 1),
	(3, 1, 1),
	(4, 1, 1),
	(5, 1, 1),
	(6, 1, 1),
	(7, 1, 1),
	(8, 1, 1),
	(9, 1, 1),
	(10, 1, 1),
	(11, 1, 1),
	(12, 1, 1);
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
