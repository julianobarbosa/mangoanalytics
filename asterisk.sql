-- MySQL dump 10.11
--
-- Host: localhost    Database: asterisk
-- ------------------------------------------------------
-- Server version	5.0.95

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
-- Table structure for table `trunks`
--

DROP TABLE IF EXISTS `trunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trunks` (
  `trunkid` int(11) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `tech` varchar(20) NOT NULL,
  `outcid` varchar(40) NOT NULL default '',
  `keepcid` varchar(4) default 'off',
  `maxchans` varchar(6) default '',
  `failscript` varchar(255) NOT NULL default '',
  `dialoutprefix` varchar(255) NOT NULL default '',
  `channelid` varchar(255) NOT NULL default '',
  `usercontext` varchar(255) default NULL,
  `provider` varchar(40) default NULL,
  `disabled` varchar(4) default 'off',
  PRIMARY KEY  (`trunkid`,`tech`,`channelid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trunks`
--

LOCK TABLES `trunks` WRITE;
/*!40000 ALTER TABLE `trunks` DISABLE KEYS */;
INSERT INTO `trunks` VALUES (1,'','zap','','','','','','g0','',NULL,'off'),(2,'Vozero','iax2','NZXT','off','','','','Anextor','','','off'),(3,'Axtel Chucho','sip','','off','2','','','8119319275','','','off'),(4,'Mambo','sip','5514540010','off','','','','mambo','','','off'),(5,'Melia1','sip','','off','','','','Melia1','','','off'),(6,'Melia2','sip','','off','','','','Melia2','','','off'),(7,'MeliaRegistro','sip','','off','','','','Meliaregistro','','','off'),(8,'Nextor','sip','','off','','','','Nextor','','','off');
/*!40000 ALTER TABLE `trunks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-01 13:04:07
