-- MySQL dump 10.13  Distrib 5.7.10, for Win64 (x86_64)
--
-- Host: localhost    Database: risiko
-- ------------------------------------------------------
-- Server version	5.7.10-log

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
-- Table structure for table `amico`
--

DROP TABLE IF EXISTS `amico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amico` (
  `amicoa` varchar(25) NOT NULL,
  `amicob` varchar(25) NOT NULL,
  PRIMARY KEY (`amicoa`,`amicob`),
  KEY `amicob` (`amicob`),
  CONSTRAINT `amico_ibfk_1` FOREIGN KEY (`amicoa`) REFERENCES `utente` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `amico_ibfk_2` FOREIGN KEY (`amicob`) REFERENCES `utente` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carta`
--

DROP TABLE IF EXISTS `carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `simbolo` enum('fante','cannone','cavaliere','jolly') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comprende`
--

DROP TABLE IF EXISTS `comprende`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comprende` (
  `obiettivo` int(11) NOT NULL,
  `territorio` varchar(25) NOT NULL,
  PRIMARY KEY (`obiettivo`,`territorio`),
  KEY `territorio` (`territorio`),
  CONSTRAINT `comprende_ibfk_1` FOREIGN KEY (`obiettivo`) REFERENCES `obiettivo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comprende_ibfk_2` FOREIGN KEY (`territorio`) REFERENCES `territorio` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confina`
--

DROP TABLE IF EXISTS `confina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confina` (
  `territorioa` varchar(25) NOT NULL,
  `territoriob` varchar(25) NOT NULL,
  PRIMARY KEY (`territorioa`,`territoriob`),
  KEY `territoriob` (`territoriob`),
  CONSTRAINT `confina_ibfk_1` FOREIGN KEY (`territorioa`) REFERENCES `territorio` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `confina_ibfk_2` FOREIGN KEY (`territoriob`) REFERENCES `territorio` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `continente`
--

DROP TABLE IF EXISTS `continente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continente` (
  `nome` varchar(20) NOT NULL,
  `bonus` int(11) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `giocatore`
--

DROP TABLE IF EXISTS `giocatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `giocatore` (
  `utente` varchar(25) NOT NULL,
  `partita` int(11) NOT NULL,
  `obiettivo` int(11) NOT NULL,
  PRIMARY KEY (`utente`,`partita`),
  KEY `partita` (`partita`),
  CONSTRAINT `giocatore_ibfk_1` FOREIGN KEY (`utente`) REFERENCES `utente` (`username`) ON UPDATE CASCADE,
  CONSTRAINT `giocatore_ibfk_2` FOREIGN KEY (`partita`) REFERENCES `partita` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER obiettivo_insert BEFORE INSERT ON Giocatore
FOR EACH ROW
BEGIN
   IF (NEW.obiettivo, NEW.partita) IN
      (SELECT
         obiettivo,partita
      FROM
         Giocatore
      WHERE 
         obiettivo = NEW.obiettivo 
         AND partita = NEW.partita)
   THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Obiettivo già assegnato';
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lingua`
--

DROP TABLE IF EXISTS `lingua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lingua` (
  `codice` char(2) NOT NULL,
  `nome` varchar(25) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lingue`
--

DROP TABLE IF EXISTS `lingue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lingue` (
  `nazione` varchar(50) NOT NULL,
  `lingua` char(2) NOT NULL,
  `principale` tinyint(1) NOT NULL,
  PRIMARY KEY (`nazione`,`lingua`),
  KEY `lingua` (`lingua`),
  CONSTRAINT `lingue_ibfk_1` FOREIGN KEY (`nazione`) REFERENCES `nazione` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lingue_ibfk_2` FOREIGN KEY (`lingua`) REFERENCES `lingua` (`codice`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nazione`
--

DROP TABLE IF EXISTS `nazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nazione` (
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `obiettivo`
--

DROP TABLE IF EXISTS `obiettivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obiettivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `occupa`
--

DROP TABLE IF EXISTS `occupa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occupa` (
  `utente` varchar(25) NOT NULL,
  `partita` int(11) NOT NULL,
  `territorio` varchar(25) NOT NULL,
  `armate` int(11) NOT NULL,
  PRIMARY KEY (`utente`,`partita`,`territorio`),
  KEY `territorio` (`territorio`),
  CONSTRAINT `occupa_ibfk_1` FOREIGN KEY (`utente`, `partita`) REFERENCES `giocatore` (`utente`, `partita`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `occupa_ibfk_2` FOREIGN KEY (`territorio`) REFERENCES `territorio` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER armate_insert BEFORE INSERT ON Occupa
FOR EACH ROW
BEGIN
   IF NEW.armate < 1 THEN
      SET NEW.armate = 1;
   ELSEIF NEW.armate > 10 THEN
      SET NEW.armate = 10;
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER territorio_insert BEFORE INSERT ON Occupa
FOR EACH ROW
BEGIN
   IF (NEW.territorio, NEW.partita) IN
      (SELECT
         territorio,partita
      FROM
         Occupa
      WHERE 
         territorio = NEW.territorio 
         AND partita = NEW.partita)
   THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Territorio già occupato';
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER armate_update BEFORE UPDATE ON Occupa
FOR EACH ROW
BEGIN
   IF NEW.armate < 1 THEN
      SET NEW.armate = 1;
   ELSEIF NEW.armate > 10 THEN
      SET NEW.armate = 10;
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `partita`
--

DROP TABLE IF EXISTS `partita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partita` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `possiede`
--

DROP TABLE IF EXISTS `possiede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `possiede` (
  `utente` varchar(25) NOT NULL,
  `partita` int(11) NOT NULL,
  `carta` int(11) NOT NULL,
  PRIMARY KEY (`utente`,`partita`,`carta`),
  KEY `carta` (`carta`),
  CONSTRAINT `possiede_ibfk_1` FOREIGN KEY (`utente`, `partita`) REFERENCES `giocatore` (`utente`, `partita`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `possiede_ibfk_2` FOREIGN KEY (`carta`) REFERENCES `carta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER carta_insert BEFORE INSERT ON Possiede
FOR EACH ROW
BEGIN
   IF (NEW.carta, NEW.partita) IN
      (SELECT
         carta,partita
      FROM
         Possiede
      WHERE 
         carta = NEW.carta 
         AND partita = NEW.partita)
   THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Carta già posseduta';
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER max_carte BEFORE INSERT ON Possiede
FOR EACH ROW
BEGIN
   IF (NEW.utente, NEW.partita) IN
      (SELECT
         utente,partita
      FROM
         Possiede
      WHERE
         utente = NEW.utente 
         AND partita = NEW.partita
      GROUP BY (utente)
      HAVING
         COUNT(*)=5)
   THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Limite carte raggiunto';
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `territorio`
--

DROP TABLE IF EXISTS `territorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `territorio` (
  `nome` varchar(25) NOT NULL,
  `punteggio` int(11) NOT NULL,
  `continente` varchar(20) NOT NULL,
  PRIMARY KEY (`nome`),
  KEY `continente` (`continente`),
  CONSTRAINT `territorio_ibfk_1` FOREIGN KEY (`continente`) REFERENCES `continente` (`nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utente` (
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `data_di_nascita` date DEFAULT NULL,
  `nazione` varchar(50) NOT NULL,
  `lingua` char(2) NOT NULL DEFAULT 'en',
  PRIMARY KEY (`username`),
  KEY `nazione` (`nazione`),
  KEY `lingua` (`lingua`),
  CONSTRAINT `utente_ibfk_1` FOREIGN KEY (`nazione`) REFERENCES `nazione` (`nome`) ON UPDATE CASCADE,
  CONSTRAINT `utente_ibfk_2` FOREIGN KEY (`lingua`) REFERENCES `lingua` (`codice`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-25 18:16:09
