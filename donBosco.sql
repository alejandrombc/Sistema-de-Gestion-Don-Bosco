-- MySQL dump 10.13  Distrib 5.7.15, for Win64 (x86_64)
--
-- Host: localhost    Database: don_bosco
-- ------------------------------------------------------
-- Server version	5.7.15-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carrera`
--

DROP TABLE IF EXISTS `carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrera` (
  `Carrera_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de las carreras',
  `Carrera_Nombre` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Nombre de las carreras',
  `Ano_escolar` tinyint(4) NOT NULL COMMENT 'Ano escolar ',
  PRIMARY KEY (`Carrera_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Todas las carreras de la escuela tecnica popular don bosco';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` VALUES (1,'Tecnologia_Grafica',4),(2,'Mecanica',4),(3,'Electronica',4),(4,'Contabilidad',4),(5,'Tecnologia_Grafica',5),(6,'Mecanica',5),(7,'Electronica',5),(8,'Contabilidad',5),(9,'Tecnologia_Grafica',6),(10,'Mecanica',6),(11,'Electronica',6),(12,'Contabilidad',6);
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `correo_enviado`
--

DROP TABLE IF EXISTS `correo_enviado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `correo_enviado` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `correo` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Lista a los correos que se les han enviado algo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correo_enviado`
--

LOCK TABLES `correo_enviado` WRITE;
/*!40000 ALTER TABLE `correo_enviado` DISABLE KEYS */;
INSERT INTO `correo_enviado` VALUES (3,'alejandrombc@gmail.com'),(4,'josemalvarezg1@gmail.com');
/*!40000 ALTER TABLE `correo_enviado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursa`
--

DROP TABLE IF EXISTS `cursa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursa` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursa`
--

LOCK TABLES `cursa` WRITE;
/*!40000 ALTER TABLE `cursa` DISABLE KEYS */;
INSERT INTO `cursa` VALUES (24218040,1,3,'A',0),(26993444,1,4,'A',0),(27039134,1,4,'A',0),(27426203,1,4,'A',0),(27448779,1,3,'A',0),(27448834,1,1,'A',0),(27488079,1,3,'A',0),(27545280,1,4,'A',0),(27545403,1,4,'A',0),(27622859,1,4,'A',0),(27671132,1,1,'A',0),(27692921,1,1,'A',0),(27752874,1,1,'A',0),(27769120,1,4,'A',0),(27769131,1,2,'A',0),(27769161,1,2,'A',0),(27769263,1,3,'A',0),(27769449,1,3,'A',0),(27769483,1,4,'A',0),(27769609,1,2,'A',0),(27769849,1,2,'A',0),(27770003,1,2,'A',0),(27772211,1,4,'A',0),(27788897,1,2,'A',0),(27790147,1,4,'A',0),(27790281,1,4,'A',0),(27793842,1,4,'A',0),(27818571,1,2,'A',0),(27818583,1,1,'A',0),(27818835,1,2,'A',0),(27818877,1,2,'A',0),(27818944,1,1,'A',0),(27879185,1,2,'A',0),(27916560,1,1,'A',0),(27978116,1,3,'A',0),(27978695,1,4,'A',0),(27978799,1,1,'A',0),(27978839,1,1,'A',0),(28007026,1,4,'A',0),(28007205,1,2,'A',0),(28007320,1,2,'A',0),(28007419,1,4,'A',0),(28007425,1,2,'A',0),(28007444,1,1,'A',0),(28007535,1,1,'A',0),(28007782,1,1,'A',0),(28015421,1,1,'A',0),(28015915,1,4,'A',0),(28052196,1,1,'A',0),(28052197,1,3,'A',0),(28052474,1,2,'A',0),(28052971,1,4,'A',0),(28053300,1,4,'A',0),(28053393,1,1,'A',0),(28053753,1,1,'A',0),(28058266,1,4,'A',0),(28076457,1,1,'A',0),(28101680,1,3,'A',0),(28101714,1,2,'A',0),(28116623,1,3,'A',0),(28116858,1,2,'A',0),(28117130,1,2,'A',0),(28143615,1,4,'A',0),(28146413,1,4,'A',0),(28158342,1,1,'A',0),(28158365,1,1,'A',0),(28158376,1,3,'A',0),(28158446,1,2,'A',0),(28158548,1,3,'A',0),(28158887,1,1,'A',0),(28180284,1,4,'A',0),(28209447,1,1,'A',0),(28218130,1,2,'A',0),(28218209,1,3,'A',0),(28218618,1,1,'A',0),(28308847,1,3,'A',0),(28309415,1,2,'A',0),(28317843,1,3,'A',0),(28324759,1,4,'A',0),(28325252,1,4,'A',0),(28332612,1,1,'A',0),(28332945,1,1,'A',0),(28333395,1,4,'A',0),(28448034,1,3,'A',0),(28448832,1,4,'A',0),(28469300,1,3,'A',0),(28484815,1,1,'A',0),(28484989,1,2,'A',0),(29518741,1,1,'A',0),(29537192,1,3,'A',0),(29537588,1,4,'A',0),(29537724,1,1,'A',0),(29537992,1,2,'A',0),(29577802,1,4,'A',0),(29578687,1,2,'A',0),(29589945,1,3,'A',0),(29621425,1,1,'A',0),(29621763,1,2,'A',0),(29621846,1,4,'A',0),(29662025,1,2,'A',0),(29677939,1,1,'A',0),(29706478,1,2,'A',0),(29832761,1,1,'A',0),(29883426,1,4,'A',0),(29883723,1,4,'A',0),(29888595,1,4,'A',0),(29935980,1,3,'A',0),(30062535,1,2,'A',0),(30154177,1,1,'A',0),(30165034,1,1,'A',0),(30246595,1,4,'A',0),(30247758,1,3,'A',0),(30248162,1,2,'A',0),(30612847,1,2,'A',0),(31408318,1,1,'A',0);
/*!40000 ALTER TABLE `cursa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiante` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula del estudiante',
  `Nombres` varchar(50) NOT NULL COMMENT 'Nombre del estudiante',
  `Apellidos` varchar(50) NOT NULL COMMENT 'Apellido del estudiante',
  `Direccion` varchar(100) DEFAULT NULL COMMENT 'Direccion del estudiante',
  `Correo` varchar(50) DEFAULT NULL COMMENT 'Correo del estudiante',
  `Numero_de_telefono` varchar(50) DEFAULT NULL COMMENT 'Numero de telefono del estudiante',
  `Fecha_de_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento del estudiante',
  PRIMARY KEY (`Cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informacion de estudiantes de la escuela tecnica popular don bosco';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` VALUES (24218040,'Edward Orlando Jose','Diaz Rodriguez','Petare - Barrio El Carmen','jackdryckk@gmail.com','','1900-01-01'),(26993444,'Niurka Betania','Pereira Barrios','La Dolorita','niurkabetania@gmail.com','04142273082','1900-01-01'),(27039134,'Ana Carolina','Fernandez Perez','Caucaguita - Turumo','','04123991552','1900-01-01'),(27426203,'Paola Nalleris','Seijas Valero','','','','1900-01-01'),(27448779,'Leonardo Rafael','Castellanos Hernandez','Guaicoco - Petare','leorafacastellano@hotmail.com','04241620421','1900-01-01'),(27448834,'Ambar Luzcali','Sanchez Meza ','','','04162667310','1900-01-01'),(27488079,'Isaac Jesus','Bello Azuaje','Julián Blanco - Mariche','isaac.j0108@hotmail.com','04264865036','1900-01-01'),(27545280,'Raiverzon Jesus','Marquez Carrillo','','','','1900-01-01'),(27545403,'Laura Vanesa','Sanchez Barrios ','Caucaguita','celeste-12.virgo@hotmail.com','04165396311','1900-01-01'),(27622859,'Angie Andreina','Duque Camacho','','','','1900-01-01'),(27671132,'Wilendy del Carmen','Casique Romero ','Caucaguita - La \"I\"','wilendycasique@hotmail.com','04129012778','1900-01-01'),(27692921,'Angel Luis','Garcia Hernandez','San Blas - Petare','','04167217565','1900-01-01'),(27752874,'Agelim Chiquinquira','Ascanio Ramirez','Capuchinos - San Martín','weedzyramirez@gmail.com','02124610790','1900-01-01'),(27769120,'Jordan Alfonso ','Escalona Escalona','Petare - La 37','jordan1020@hotmail.com','02122933639','1900-01-01'),(27769131,'Joel Leonardo','Parra Duarte','','','','1900-01-01'),(27769161,'Sander Jose','Reyes Fuentes','','','','1900-01-01'),(27769263,'Enzon Enmanuel','Contreras Guerra','Petare - Barrio Unión','','04167128885','1900-01-01'),(27769449,'Germain Xavier','Acosta Rodriguez','Palo Verde - Lomas del Ávila','geeracosta@hotmail.com','04241035472','1900-01-01'),(27769483,'Nuris Franyeli','Rivas Urbina ','Petare - 19 de Abril','nurysyeli@live.com.mx','04242941132','1900-01-01'),(27769609,'Mauro Alexzander','Reyes Rivas ','','','','1900-01-01'),(27769849,'Reminton Brosnan','Bracho Dominguez','','','','1900-01-01'),(27770003,'Omar Enrique','Rodriguez Melendez ','','','','1900-01-01'),(27772211,'Vivian Alexandra','Rojas Montoya','Palo Verde','vivianalexandra.rojas@hotmail.com','04261062493','1900-01-01'),(27788897,'Jouse Jose','Torres Ñañez','','','','1900-01-01'),(27790147,'Rossnelli Judith','Marrero Berroteran','Julián Blanco','rossne2016@gmail.com','04249210164','1900-01-01'),(27790281,'Loriannys Michelle','Romero Cabeza','Petare - Barrio Unión','','04241406295','1900-01-01'),(27793842,'Marcelo Alejandro','Diaz Diaz','Montalbán - Antímano','marcelo-a-d-diaz@hotmail.com','04128274425','1900-01-01'),(27818571,'Jonas Alejandro','Padron Morgado','','','','1900-01-01'),(27818583,'Aurismar Carolina','Rodriguez Rodriguez','','','','1900-01-01'),(27818835,'Andriu Alexander','Cedeño Mendez','','','','1900-01-01'),(27818877,'Richard Samuel','Gil Quintana','','','','1900-01-01'),(27818944,'Juan Pablo','Pacheco Bracamonte ','','','','1900-01-01'),(27879185,'Gian Franco','Guidicelli Diaz','','','','1900-01-01'),(27916560,'Jonaly Maria','Rojas Torres','','','','1900-01-01'),(27978116,'Jeyker Steven','Herrera Palacios','Petare - Carpintero','jeykercry@gmail.com','04262616984','1900-01-01'),(27978695,'Brian Antonio','Cifuentes Castillo','Petare','briancifuentes10@gmail.com','04242028436','1900-01-01'),(27978799,'Andrea Valentina','Beomont Yanez ','Petare - 5 de Julio','yanezandreav@gmail.com','02122414463','1900-01-01'),(27978839,'Luis Angel ','Hernandez Gamboa ','Caucaguita - El Carmen ','luishernandezgamboa@gmail.com','02122441185','1900-01-01'),(28007026,'Eduard Wladimir','Artiga Acosta','Brisas de Petare','','04165964246','1900-01-01'),(28007205,'Wilkely Alexandra','Matos Lozada','','','','1900-01-01'),(28007320,'Josue Steven','Aponte Duran ','','','','1900-01-01'),(28007419,'Stefany Alejandro','Castillo Martinez','Petare - Barrio Bolívar','tefv.alei22@gmail.com','04242196200','1900-01-01'),(28007425,'Albanys Karolina','Machado Peña','','','','1900-01-01'),(28007444,'Katiuska Aracelis','Tovar Barreto ','','','','1900-01-01'),(28007535,'Erineck Yilberly','Rangel Ramirez','Petare - La Agricultura','yilberly@hotmail.com','02122517038','1900-01-01'),(28007782,'Danyerlic Francelys','Valera Justo ','','','','1900-01-01'),(28015421,'Yeison Enrique','Bolivar Venales','Palo Verde - José Félix Ribas - Zona 6','yeison.bolivar.venales@gmail.com','04142341324','1900-01-01'),(28015915,'Karelys Randely','Rivero Garcia','La Dolorita','karelysrivero297@gmail.com','04266892756','1900-01-01'),(28052196,'Branklin Salvador','Rodriguez Daniele','Vista Hermosa - Petare','branklin36@gmail.com','04160140065','1900-01-01'),(28052197,'Elvis Josue','Marchena Andrade','','','','1900-01-01'),(28052474,'Gabriel Eduardo','Escalona Pacheco','','','','1900-01-01'),(28052971,'Joan Gabriel','Marquez Gomez','Carpintero - Petare - Valle Alto','','04242086534','1900-01-01'),(28053300,'Kewis Yonier','Baez Perez','Petare - Campo Rico','kewis-2001@hotmail.com','04261051867','1900-01-01'),(28053393,'Dainer Josue','Hernandez Caracas','Caucaguita - El Bruzón','dainerjosue_2013@hotmail.com','04266072647','1900-01-01'),(28053753,'Franyerlis','Alcazar Mercado','Guarenas - Ciudad Belen','framyelis815@gmail.com','04269004010','1900-01-01'),(28058266,'Yolfran David','Castro Zambrano','Caucaguita - El Carmen ','yolfran04@gmail.com','04243996819','1900-01-01'),(28076457,'Katherine Cecilia','Mayorga Dickson ','','','','1900-01-01'),(28101680,'Luis Manuel','Barcelo Gonzalez','La Dolorita - Mariche','barcelox28101680@gmail.com','04265209719','1900-01-01'),(28101714,'Hector David','Marin Pereira','','','','1900-01-01'),(28116623,'Lisandro Heiderk','Lugo Benavente','Caucaguita - Los Bloques','lisandrolugo_269@hotmail.com','04164139813','1900-01-01'),(28116858,'Jose Gregorio','Montilla Mejias','','','','1900-01-01'),(28117130,'Miguel Angel','Manotas Pacheco','','','','1900-01-01'),(28143615,'Norkelys del Carmen','Manzanilla Ramirez','San Agustín Norte','norkys10.escorpion@gmail.com','04261246830','1900-01-01'),(28146413,'Luis Miguel','Herrera Rondon','Petare - Carpintero','luismhr12@hotmail.com','04166128542','1900-01-01'),(28158342,'Abraham Jose','Milano Gil ','','','','1900-01-01'),(28158365,'Ismary Yetzary','Armas Barrios','Barrio Unión - Petare','ismaryyetzary@hotmail.com','04241874427','1900-01-01'),(28158376,'Jesus Alberto','Armas Barrios','Petare - Barrio Unión','jesus-armas599@hotmail.com','04141264902','1900-01-01'),(28158446,'Angher Javier','Rodriguez Villarroel','','','','1900-01-01'),(28158548,'Jose Alfonso','Ferrer Garcia','Mirador del Este','ferrerjose467@gmail.com','04165640247','1900-01-01'),(28158887,'Ediling Andreina','Rivas Ramirez','','','','1900-01-01'),(28180284,'Ruben David','Baquero Bayuelo','Petare - Barrio Unión','ruben1610200@hotmail.com','04127247543','1900-01-01'),(28209447,'Ghineivi Maria','Carreño Canelon ','Isaías Medina Angarita','ghineivy-14@hotmail.com','04242177095','1900-01-01'),(28218130,'Jeimer Eduardo','Mendoza Jimenez','','','','1900-01-01'),(28218209,'Dylan Armando ','Lozada Torrealba','Petare - Llanito - Mirador del Este','dylanlt.0826@hotmail.com','04165349992','1900-01-01'),(28218618,'Jose Gregorio','Flores Yanez','Mariche - La Dolorita','josegregorioflores068@gmail.com','04143567724','1900-01-01'),(28308847,'Carlos Eduardo','Bracamonte Espinoza','San Pascual - Mesuca','bracamontecarlos229@hotmail.com','04142605159','1900-01-01'),(28309415,'Leandro Jose','Chirino Sangronis','','','','1900-01-01'),(28317843,'Josue Misael','Bonilla Dionicio','San Pascual - Mesuca','','04160628413','1900-01-01'),(28324759,'Kendry Maribel','Rausseo Parada','','','','1900-01-01'),(28325252,'Nathalia Beatriz','Sanmartin Sumba ','Petare - Julián Blanco','','04141167044','1900-01-01'),(28332612,'Rachely Nayly','Castellano Cordero','Caucaguita - Aguacatico','rachelybella_11@hotmail.com','02124163546','1900-01-01'),(28332945,'Cristian Jose','Camacaro Guevara','Petare - Barrio Sucre','cristian.camacaro@gmail.com','04120179996','1900-01-01'),(28333395,'Gabriel Jose','Bravo Guzman ','Petare - El Cerrito','gabobravo11@hotmail.com','04140106759','1900-01-01'),(28448034,'Luis Oswaldo','Abello Rodriguez','Petare - Barrio Carpintero','','04261045729','1900-01-01'),(28448832,'Gabriela Isabel','Molina Garcia','Caucaguita','gabrielaiisabel@hotmail.com','04261059555','1900-01-01'),(28469300,'Gabriel Alejandro','Delgado Perez','Chacao - Av. José Félix Sosa','gabridelperez2@gmail.com','04241999321','1900-01-01'),(28484815,'Sorangelys Nahomy','Polo Barrios','Mesuca','soranpb07@gmail.com','04129775711','1900-01-01'),(28484989,'Joel Felipe','Santana Crespo ','','','','1900-01-01'),(29518741,'Claudia Valentina','Salas Alves ','Petare - El Nazareno','clau-queen@hotmail.com','04149901395','1900-01-01'),(29537192,'Anthony Jose','Landaez Malave','Petare - 24 de Abril','landaez.malavenuevo@hotmail.com','','1900-01-01'),(29537588,'Jose Miguel','Echenique Gutierrez','Caucaguita - El Carmen','jose.ma2012@hotmail.com','02129376408','1900-01-01'),(29537724,'Wiklerman Alexander','Perez Betancourt','','','','1900-01-01'),(29537992,'Eudys Rolando','Chirinos Hernandez','','','','1900-01-01'),(29577802,'Axel Armando','Mantilla Barreto ','Caucaguita','axel.mantilla@hotmail.com','04241400186','1900-01-01'),(29578687,'Luis Miguel','Garcia Moreno','','','','1900-01-01'),(29589945,'Abel Alfonzo','Marquez Bosson','Av. Palmarito - La California','abelmarquez08@gmail.com','04164867096','1900-01-01'),(29621425,'Andrea Julieth','Gonzalez Vargas ','Petare - La Agricultura','andrea.jgv@gmail.com','04127007754','1900-01-01'),(29621763,'Brayan Oswaldo','Oviedo Navarro','','','','1900-01-01'),(29621846,'Neurelkis Dayana','Ramirez Sanchez','La Agricultura - Petare','neurelkis74@gmail.com','04242243571','1900-01-01'),(29662025,'Anthony Daniel','Torres Alcala ','','','','1900-01-01'),(29677939,'Gregory Isaac ','Sosa Majano ','Petare - El Morro','isaacsosamajano@gmail.com','04242366415','1900-01-01'),(29706478,'Brayan Jose','Rueda Castro','','','','1900-01-01'),(29832761,'Eduar Jose ','Petaquero Perdomo','Carpintero - Petare','eduarpetaper25@gmail.com','04268122642','1900-01-01'),(29883426,'Mianllyli Mayerlig','Osorio Perez','Caucaguita','mianllily@hotmail.com','04242737595','1900-01-01'),(29883723,'Brayan Jorge Julian','Rebolledo Milla','Petare - 24 de Julio','brebolledo27@gmail.com','04242602574','1900-01-01'),(29888595,'Yicsy Carolay','Marquina Perez','Turumo','gipsymarquina@gmail.com','04241212802','1900-01-01'),(29935980,'Franklin Jose','Guerra Carpio ','','mateo.guerra.caarpio@gmail.com','04165245194','1900-01-01'),(30062535,'Kleiber Jose','Nadales Rojas','','','','1900-01-01'),(30154177,'Yon Jose','Payan Rocha ','','','','1900-01-01'),(30165034,'Maria Alejandra','Landaez Chacon ','Las Brisas - El Llanito','maria.landaez173@gmail.com','04169226502','1900-01-01'),(30246595,'Cristhian Enrique','Olivar Barreto','Caucaguita','cristhianolivar@gmail.com','04264022751','1900-01-01'),(30247758,'Humberto Rafael','Aguilera Avila','Petare - Barrio Carpintero','','04262186679','1900-01-01'),(30248162,'Juan Eduardo','Requena Merchan','','','','1900-01-01'),(30612847,'Enyerbeth Jose','Torres Ugas','','','','1900-01-01'),(31408318,'Fabiola Alejandra','Mendoza Cervantes ','Carpintero - Petare','swagiifabi@gmail.com','04141502016','1900-01-01');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodo`
--

DROP TABLE IF EXISTS `periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodo` (
  `Periodo_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del periodo',
  `Periodo_nombre` varchar(10) NOT NULL DEFAULT '0' COMMENT 'Periodo ',
  `Eliminada` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si el periodo esta eliminado o no',
  PRIMARY KEY (`Periodo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Periodos en la escuela tecnica popular don bosco';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodo`
--

LOCK TABLES `periodo` WRITE;
/*!40000 ALTER TABLE `periodo` DISABLE KEYS */;
INSERT INTO `periodo` VALUES (1,'2016-2017',0);
/*!40000 ALTER TABLE `periodo` ENABLE KEYS */;
UNLOCK TABLES;

-- Volcando estructura para tabla don_bosco.tipo_trabajador
CREATE TABLE  `tipo_trabajador` (
  `id_tipo` int(1) NOT NULL,
  `cargo` varchar(255) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

-- Volcando datos para la tabla don_bosco.tipo_trabajador
INSERT INTO `tipo_trabajador` (`id_tipo`, `cargo`) VALUES
(1, 'Docente'),
(2, 'Administrativo'),
(3, 'Obrero');

-- Volcando estructura para tabla don_bosco.personal
CREATE TABLE IF NOT EXISTS `personal` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula del trabajador',
  `Tipo` int(1) NOT NULL COMMENT 'Tipo de trabajador',
  `Nombres` varchar(50) NOT NULL COMMENT 'Nombre del trabajador',
  `Apellidos` varchar(50) NOT NULL COMMENT 'Apellido del trabajador',
  `Direccion` varchar(100) DEFAULT NULL COMMENT 'Direccion del trabajador',
  `Correo` varchar(50) DEFAULT NULL COMMENT 'Correo del trabajador',
  `Numero_de_telefono` varchar(50) DEFAULT NULL COMMENT 'Numero de telefono del trabajador',
  CONSTRAINT `Tipo` FOREIGN KEY (`Tipo`) REFERENCES `tipo_trabajador` (`id_tipo`),
  PRIMARY KEY (`Cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informacion de trabajadores de la escuela tecnica popular don bosco';

-- Volcando estructura para tabla don_bosco.trabaja
CREATE TABLE IF NOT EXISTS `trabaja` (
  `Cedula` int(11) NOT NULL COMMENT 'Cedula de los trabajadores',
  `Tipo` int(1) NOT NULL COMMENT 'Tipo de trabajador',
  `Periodo_ID` int(11) NOT NULL COMMENT 'ID del periodo lectivo',
  `Inasistencias` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Las inasistencias del estudiante en ese periodo',
  PRIMARY KEY (`Cedula`,`Periodo_ID`),
  KEY `Periodo` (`Periodo_ID`),
  CONSTRAINT `Cedula_Trabajador` FOREIGN KEY (`Cedula`) REFERENCES `personal` (`Cedula`),
  CONSTRAINT `Tipo_Trabajador` FOREIGN KEY (`Tipo`) REFERENCES `personal` (`Tipo`),
  CONSTRAINT `Periodo_Trabajador` FOREIGN KEY (`Periodo_ID`) REFERENCES `periodo` (`Periodo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre los trabajadores y el periodo';

--
-- Table structure for table `seccion`
--

DROP TABLE IF EXISTS `seccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seccion` (
  `Carrera_ID` int(11) NOT NULL COMMENT 'ID de la carrera ',
  `Periodo_ID` int(11) NOT NULL COMMENT 'ID del periodo lectivo',
  `Cantidad` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Cantidad de secciones ',
  PRIMARY KEY (`Carrera_ID`,`Periodo_ID`),
  KEY `Periodo_ID` (`Periodo_ID`),
  CONSTRAINT `Carrera_ID` FOREIGN KEY (`Carrera_ID`) REFERENCES `carrera` (`Carrera_ID`),
  CONSTRAINT `Periodo_ID` FOREIGN KEY (`Periodo_ID`) REFERENCES `periodo` (`Periodo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cantidad de secciones segun periodo y carrera';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seccion`
--

LOCK TABLES `seccion` WRITE;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` VALUES (1,1,1),(2,1,1),(3,1,1),(4,1,1),(5,1,1),(6,1,1),(7,1,1),(8,1,1),(9,1,1),(10,1,1),(11,1,1),(12,1,1);
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-14 19:09:12
