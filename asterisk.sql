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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `variable` varchar(20) NOT NULL default '',
  `value` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`variable`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('need_reload','false'),('version','2.8.1');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ampusers`
--

DROP TABLE IF EXISTS `ampusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ampusers` (
  `username` varchar(20) NOT NULL default '',
  `password_sha1` varchar(40) NOT NULL,
  `extension_low` varchar(20) NOT NULL default '',
  `extension_high` varchar(20) NOT NULL default '',
  `deptname` varchar(20) NOT NULL default '',
  `sections` blob NOT NULL,
  PRIMARY KEY  (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ampusers`
--

LOCK TABLES `ampusers` WRITE;
/*!40000 ALTER TABLE `ampusers` DISABLE KEYS */;
INSERT INTO `ampusers` VALUES ('admin','4cf7195e22df3327469e64b62b790d775a85ef1a','','','','*');
/*!40000 ALTER TABLE `ampusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement` (
  `announcement_id` int(11) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  `recording_id` int(11) default NULL,
  `allow_skip` int(11) default NULL,
  `post_dest` varchar(255) default NULL,
  `return_ivr` tinyint(1) NOT NULL default '0',
  `noanswer` tinyint(1) NOT NULL default '0',
  `repeat_msg` varchar(2) NOT NULL default '',
  PRIMARY KEY  (`announcement_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement`
--

LOCK TABLES `announcement` WRITE;
/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
INSERT INTO `announcement` VALUES (1,'Nextor_Spt_NoAnswer',17,0,'app-announcement-5,s,1',0,0,''),(2,'VM_Mambo',4,0,'ext-local,vms460,1',0,0,''),(3,'VM_Vozero',22,0,'vmblast-grp,501,1',0,0,''),(4,'Vozero_Spt_NoAnswer',21,0,'app-announcement-3,s,1',0,0,''),(5,'VM_Nexttor',4,0,'vmblast-grp,500,1',0,0,'');
/*!40000 ALTER TABLE `announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup`
--

DROP TABLE IF EXISTS `backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup` (
  `name` varchar(50) default NULL,
  `voicemail` varchar(50) default NULL,
  `recordings` varchar(50) default NULL,
  `configurations` varchar(50) default NULL,
  `cdr` varchar(55) default NULL,
  `fop` varchar(50) default NULL,
  `minutes` varchar(50) default NULL,
  `hours` varchar(50) default NULL,
  `days` varchar(50) default NULL,
  `months` varchar(50) default NULL,
  `weekdays` varchar(50) default NULL,
  `command` varchar(200) default NULL,
  `method` varchar(50) default NULL,
  `id` int(11) NOT NULL auto_increment,
  `ftpuser` varchar(50) default NULL,
  `ftppass` varchar(50) default NULL,
  `ftphost` varchar(50) default NULL,
  `ftpdir` varchar(150) default NULL,
  `sshuser` varchar(50) default NULL,
  `sshkey` varchar(150) default NULL,
  `sshhost` varchar(50) default NULL,
  `sshdir` varchar(150) default NULL,
  `emailaddr` varchar(75) default NULL,
  `emailmaxsize` varchar(25) default NULL,
  `emailmaxtype` varchar(5) default NULL,
  `admin` varchar(10) default NULL,
  `include` blob,
  `exclude` blob,
  `sudo` varchar(25) default NULL,
  `remotesshhost` varchar(50) default NULL,
  `remotesshuser` varchar(50) default NULL,
  `remotesshkey` varchar(150) default NULL,
  `remoterestore` varchar(5) default NULL,
  `overwritebackup` varchar(5) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup`
--

LOCK TABLES `backup` WRITE;
/*!40000 ALTER TABLE `backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `callback`
--

DROP TABLE IF EXISTS `callback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callback` (
  `callback_id` int(11) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  `callbacknum` varchar(100) default NULL,
  `destination` varchar(50) default NULL,
  `sleep` int(11) default NULL,
  `deptname` varchar(50) default NULL,
  PRIMARY KEY  (`callback_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `callback`
--

LOCK TABLES `callback` WRITE;
/*!40000 ALTER TABLE `callback` DISABLE KEYS */;
/*!40000 ALTER TABLE `callback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidlookup`
--

DROP TABLE IF EXISTS `cidlookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidlookup` (
  `cidlookup_id` int(11) NOT NULL auto_increment,
  `description` varchar(50) NOT NULL,
  `sourcetype` varchar(100) NOT NULL,
  `cache` tinyint(1) NOT NULL default '0',
  `deptname` varchar(30) default NULL,
  `http_host` varchar(30) default NULL,
  `http_port` varchar(30) default NULL,
  `http_username` varchar(30) default NULL,
  `http_password` varchar(30) default NULL,
  `http_path` varchar(100) default NULL,
  `http_query` varchar(100) default NULL,
  `mysql_host` varchar(60) default NULL,
  `mysql_dbname` varchar(60) default NULL,
  `mysql_query` text,
  `mysql_username` varchar(30) default NULL,
  `mysql_password` varchar(30) default NULL,
  PRIMARY KEY  (`cidlookup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidlookup`
--

LOCK TABLES `cidlookup` WRITE;
/*!40000 ALTER TABLE `cidlookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `cidlookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidlookup_incoming`
--

DROP TABLE IF EXISTS `cidlookup_incoming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidlookup_incoming` (
  `cidlookup_id` int(11) NOT NULL,
  `extension` varchar(50) default NULL,
  `cidnum` varchar(30) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidlookup_incoming`
--

LOCK TABLES `cidlookup_incoming` WRITE;
/*!40000 ALTER TABLE `cidlookup_incoming` DISABLE KEYS */;
INSERT INTO `cidlookup_incoming` VALUES (0,'528000220276',''),(0,'Cameconferencia9000',''),(0,'_229XXXXXXX',''),(0,'5514540017','5514541561'),(0,'5514542510',''),(0,'Mentusmxdid',''),(0,'5514540017',''),(0,'582123357574',''),(0,'018000700010',''),(0,'5514540010',''),(0,'018000440003',''),(0,'5514540020',''),(0,'3314540020',''),(0,'8114540020',''),(0,'5514542525',''),(0,'018000220587','');
/*!40000 ALTER TABLE `cidlookup_incoming` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cronmanager`
--

DROP TABLE IF EXISTS `cronmanager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cronmanager` (
  `module` varchar(24) NOT NULL default '',
  `id` varchar(24) NOT NULL default '',
  `time` varchar(5) default NULL,
  `freq` int(11) NOT NULL default '0',
  `lasttime` int(11) NOT NULL default '0',
  `command` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`module`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cronmanager`
--

LOCK TABLES `cronmanager` WRITE;
/*!40000 ALTER TABLE `cronmanager` DISABLE KEYS */;
INSERT INTO `cronmanager` VALUES ('module_admin','UPDATES','21',24,1376884501,'/var/lib/asterisk/bin/module_admin listonline');
/*!40000 ALTER TABLE `cronmanager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_destinations`
--

DROP TABLE IF EXISTS `custom_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_destinations` (
  `custom_dest` varchar(80) NOT NULL default '',
  `description` varchar(40) NOT NULL default '',
  `notes` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`custom_dest`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_destinations`
--

LOCK TABLES `custom_destinations` WRITE;
/*!40000 ALTER TABLE `custom_destinations` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_destinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_extensions`
--

DROP TABLE IF EXISTS `custom_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_extensions` (
  `custom_exten` varchar(80) NOT NULL default '',
  `description` varchar(40) NOT NULL default '',
  `notes` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`custom_exten`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_extensions`
--

LOCK TABLES `custom_extensions` WRITE;
/*!40000 ALTER TABLE `custom_extensions` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerdb`
--

DROP TABLE IF EXISTS `customerdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customerdb` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `addr1` varchar(150) NOT NULL,
  `addr2` varchar(150) default NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(5) NOT NULL,
  `zip` varchar(12) default NULL,
  `sip` varchar(20) default NULL,
  `did` varchar(45) default NULL,
  `device` varchar(50) default NULL,
  `ip` varchar(20) default NULL,
  `serial` varchar(50) default NULL,
  `account` varchar(6) default NULL,
  `email` varchar(150) default NULL,
  `username` varchar(25) default NULL,
  `password` varchar(25) default NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerdb`
--

LOCK TABLES `customerdb` WRITE;
/*!40000 ALTER TABLE `customerdb` DISABLE KEYS */;
/*!40000 ALTER TABLE `customerdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dahdi`
--

DROP TABLE IF EXISTS `dahdi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dahdi` (
  `id` varchar(20) NOT NULL default '-1',
  `keyword` varchar(30) NOT NULL default '',
  `data` varchar(255) NOT NULL default '',
  `flags` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dahdi`
--

LOCK TABLES `dahdi` WRITE;
/*!40000 ALTER TABLE `dahdi` DISABLE KEYS */;
/*!40000 ALTER TABLE `dahdi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daynight`
--

DROP TABLE IF EXISTS `daynight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daynight` (
  `ext` varchar(10) NOT NULL default '',
  `dmode` varchar(40) NOT NULL default '',
  `dest` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`ext`,`dmode`,`dest`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daynight`
--

LOCK TABLES `daynight` WRITE;
/*!40000 ALTER TABLE `daynight` DISABLE KEYS */;
INSERT INTO `daynight` VALUES ('0','day','timeconditions,1,1'),('0','day_recording_id','0'),('0','fc_description','Mambo'),('0','night','ivr-5,s,1'),('0','night_recording_id','0'),('1','day','timeconditions,2,1'),('1','day_recording_id','0'),('1','fc_description','Nextor'),('1','night','ivr-7,s,1'),('1','night_recording_id','0'),('2','day','timeconditions,3,1'),('2','day_recording_id','0'),('2','fc_description','Vozero'),('2','night','ivr-9,s,1'),('2','night_recording_id','0');
/*!40000 ALTER TABLE `daynight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` varchar(20) NOT NULL default '',
  `tech` varchar(10) NOT NULL default '',
  `dial` varchar(50) NOT NULL default '',
  `devicetype` varchar(5) NOT NULL default '',
  `user` varchar(50) default NULL,
  `description` varchar(50) default NULL,
  `emergency_cid` varchar(100) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES ('4660','sip','SIP/4660','fixed','4660','Adrian Casa',''),('469','sip','SIP/469','fixed','469','Sebastian Fensham',''),('466','sip','SIP/466','fixed','466','Adrian Zamacona',''),('460','sip','SIP/460','fixed','460','Rocio Checa',''),('468','sip','SIP/468','fixed','468','Augusto Sepulveda',''),('464','sip','SIP/464','fixed','464','Alfonso Lizarraga',''),('463','sip','SIP/463','fixed','463','Edgar Hernandez',''),('470','sip','SIP/470','fixed','470','Paul Fensham',''),('999','sip','SIP/999','fixed','999','999',''),('4680','sip','SIP/4680','fixed','4680','Augusto Sepulveda',''),('4690','sip','SIP/4690','fixed','4690','SEF Laptop',''),('5000','sip','SIP/5000','fixed','5000','Vanesa Roldan',''),('5001','sip','SIP/5001','fixed','5001','Papas Lirol',''),('5002','sip','SIP/5002','fixed','5002','Sef Casa',''),('6000','sip','SIP/6000','fixed','6000','Augusto Sepulveda',''),('6001','sip','SIP/6001','fixed','6001','Webphone',''),('715','iax2','IAX2/715','fixed','715','715',''),('4691','iax2','IAX2/4691','fixed','4691','4691 SEF','');
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disa`
--

DROP TABLE IF EXISTS `disa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disa` (
  `disa_id` int(11) NOT NULL auto_increment,
  `displayname` varchar(50) default NULL,
  `pin` varchar(50) default NULL,
  `cid` varchar(50) default NULL,
  `context` varchar(50) default NULL,
  `digittimeout` int(11) default NULL,
  `resptimeout` int(11) default NULL,
  `needconf` varchar(10) default NULL,
  `hangup` varchar(10) default NULL,
  PRIMARY KEY  (`disa_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disa`
--

LOCK TABLES `disa` WRITE;
/*!40000 ALTER TABLE `disa` DISABLE KEYS */;
/*!40000 ALTER TABLE `disa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extensions`
--

DROP TABLE IF EXISTS `extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extensions` (
  `context` varchar(45) NOT NULL default 'default',
  `extension` varchar(45) NOT NULL default '',
  `priority` varchar(5) NOT NULL default '1',
  `application` varchar(45) NOT NULL default '',
  `args` varchar(255) default NULL,
  `descr` text,
  `flags` int(1) NOT NULL default '0',
  PRIMARY KEY  (`context`,`extension`,`priority`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extensions`
--

LOCK TABLES `extensions` WRITE;
/*!40000 ALTER TABLE `extensions` DISABLE KEYS */;
INSERT INTO `extensions` VALUES ('outrt-001-9_outside','_9.','1','Macro','dialout-trunk,1,${EXTEN:1}',NULL,0),('outrt-001-9_outside','_9.','2','Macro','outisbusy','No available circuits',0),('outbound-allroutes','include','1','outrt-001-9_outside','','',2);
/*!40000 ALTER TABLE `extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fax_details`
--

DROP TABLE IF EXISTS `fax_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fax_details` (
  `key` varchar(50) default NULL,
  `value` varchar(510) default NULL,
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fax_details`
--

LOCK TABLES `fax_details` WRITE;
/*!40000 ALTER TABLE `fax_details` DISABLE KEYS */;
INSERT INTO `fax_details` VALUES ('minrate','14400'),('maxrate','14400'),('ecm','yes'),('legacy_mode','no'),('force_detection','no'),('sender_address','freepbx@gmail.com'),('fax_rx_email','fax@mydomain.com');
/*!40000 ALTER TABLE `fax_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fax_incoming`
--

DROP TABLE IF EXISTS `fax_incoming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fax_incoming` (
  `cidnum` varchar(20) default NULL,
  `extension` varchar(50) default NULL,
  `detection` varchar(20) default NULL,
  `detectionwait` varchar(5) default NULL,
  `destination` varchar(50) default NULL,
  `legacy_email` varchar(50) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fax_incoming`
--

LOCK TABLES `fax_incoming` WRITE;
/*!40000 ALTER TABLE `fax_incoming` DISABLE KEYS */;
/*!40000 ALTER TABLE `fax_incoming` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fax_users`
--

DROP TABLE IF EXISTS `fax_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fax_users` (
  `user` varchar(15) default NULL,
  `faxenabled` varchar(10) default NULL,
  `faxemail` varchar(50) default NULL,
  UNIQUE KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fax_users`
--

LOCK TABLES `fax_users` WRITE;
/*!40000 ALTER TABLE `fax_users` DISABLE KEYS */;
INSERT INTO `fax_users` VALUES ('466','',''),('469','',''),('460','',''),('464','',''),('468','',''),('4660','',''),('4680','',''),('463','',''),('715','','');
/*!40000 ALTER TABLE `fax_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featurecodes`
--

DROP TABLE IF EXISTS `featurecodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featurecodes` (
  `modulename` varchar(50) NOT NULL default '',
  `featurename` varchar(50) NOT NULL default '',
  `description` varchar(200) NOT NULL default '',
  `defaultcode` varchar(20) default NULL,
  `customcode` varchar(20) default NULL,
  `enabled` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`modulename`,`featurename`),
  KEY `enabled` (`enabled`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featurecodes`
--

LOCK TABLES `featurecodes` WRITE;
/*!40000 ALTER TABLE `featurecodes` DISABLE KEYS */;
INSERT INTO `featurecodes` VALUES ('core','userlogon','User Logon','*11',NULL,1),('core','userlogoff','User Logoff','*12',NULL,1),('core','zapbarge','ZapBarge','888',NULL,1),('core','simu_pstn','Simulate Incoming Call','7777',NULL,1),('fax','simu_fax','Dial System FAX','666',NULL,1),('core','chanspy','ChanSpy','555',NULL,1),('core','pickup','Directed Call Pickup','**',NULL,1),('core','pickupexten','Asterisk General Call Pickup','*8',NULL,1),('core','blindxfer','In-Call Asterisk Blind Transfer','##',NULL,1),('core','atxfer','In-Call Asterisk Attended Transfer','*2',NULL,1),('core','automon','In-Call Asterisk Toggle Call Recording','*1',NULL,1),('core','disconnect','In-Call Asterisk Disconnect Code','**',NULL,1),('infoservices','directory','Directory','#',NULL,1),('infoservices','calltrace','Call Trace','*69',NULL,1),('infoservices','echotest','Echo Test','*43',NULL,1),('infoservices','speakingclock','Speaking Clock','*60',NULL,1),('infoservices','speakextennum','Speak Your Exten Number','*65',NULL,1),('voicemail','myvoicemail','My Voicemail','*97',NULL,1),('voicemail','dialvoicemail','Dial Voicemail','*98',NULL,1),('recordings','record_save','Save Recording','*77',NULL,1),('recordings','record_check','Check Recording','*99',NULL,1),('callforward','cfon','Call Forward All Activate','*72',NULL,1),('callforward','cfoff','Call Forward All Deactivate','*73',NULL,1),('callforward','cfoff_any','Call Forward All Prompting Deactivate','*74',NULL,1),('callforward','cfbon','Call Forward Busy Activate','*90',NULL,1),('callforward','cfboff','Call Forward Busy Deactivate','*91',NULL,1),('callforward','cfboff_any','Call Forward Busy Prompting Deactivate','*92',NULL,1),('callforward','cfuon','Call Forward No Answer/Unavailable Activate','*52',NULL,1),('callforward','cfuoff','Call Forward No Answer/Unavailable Deactivate','*53',NULL,1),('callwaiting','cwon','Call Waiting - Activate','*70',NULL,1),('callwaiting','cwoff','Call Waiting - Deactivate','*71',NULL,1),('dictate','dodictate','Perform dictation','*34',NULL,1),('dictate','senddictate','Email completed dictation','*35',NULL,1),('donotdisturb','dnd_on','DND Activate','*78',NULL,1),('donotdisturb','dnd_off','DND Deactivate','*79',NULL,1),('donotdisturb','dnd_toggle','DND Toggle','*76',NULL,1),('findmefollow','fmf_toggle','Findme Follow Toggle','*21',NULL,1),('paging','intercom-prefix','Intercom prefix','*80',NULL,0),('paging','intercom-on','User Intercom Allow','*54',NULL,0),('paging','intercom-off','User Intercom Disallow','*55',NULL,0),('pbdirectory','app-pbdirectory','Phonebook dial-by-name directory','411',NULL,1),('blacklist','blacklist_add','Blacklist a number','*30',NULL,1),('blacklist','blacklist_remove','Remove a number from the blacklist','*31',NULL,1),('blacklist','blacklist_last','Blacklist the last caller','*32',NULL,1),('speeddial','callspeeddial','Speeddial prefix','*0',NULL,1),('speeddial','setspeeddial','Set user speed dial','*75',NULL,1),('gabcast','gabdial','Connect to Gabcast','*422',NULL,1),('queues','que_toggle','Queue Toggle','*45',NULL,1),('callforward','cf_toggle','Call Forward Toggle','*740',NULL,1),('daynight','toggle-mode-0','0: Mambo','*280',NULL,1),('daynight','toggle-mode-1','1: Nextor','*281',NULL,1),('daynight','toggle-mode-2','2: Vozero','*282',NULL,1);
/*!40000 ALTER TABLE `featurecodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `findmefollow`
--

DROP TABLE IF EXISTS `findmefollow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `findmefollow` (
  `grpnum` varchar(20) NOT NULL,
  `strategy` varchar(50) NOT NULL,
  `grptime` smallint(6) NOT NULL,
  `grppre` varchar(100) default NULL,
  `grplist` varchar(255) NOT NULL,
  `annmsg_id` int(11) default NULL,
  `postdest` varchar(255) default NULL,
  `dring` varchar(255) default NULL,
  `remotealert_id` int(11) default NULL,
  `needsconf` varchar(10) default NULL,
  `toolate_id` int(11) default NULL,
  `pre_ring` smallint(6) NOT NULL default '0',
  `ringing` varchar(80) default NULL,
  PRIMARY KEY  (`grpnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `findmefollow`
--

LOCK TABLES `findmefollow` WRITE;
/*!40000 ALTER TABLE `findmefollow` DISABLE KEYS */;
/*!40000 ALTER TABLE `findmefollow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `freepbx_log`
--

DROP TABLE IF EXISTS `freepbx_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `freepbx_log` (
  `id` int(11) NOT NULL auto_increment,
  `time` datetime NOT NULL default '0000-00-00 00:00:00',
  `section` varchar(50) default NULL,
  `level` enum('error','warning','debug','devel-debug') NOT NULL default 'error',
  `status` int(11) NOT NULL default '0',
  `message` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `time` (`time`,`level`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `freepbx_log`
--

LOCK TABLES `freepbx_log` WRITE;
/*!40000 ALTER TABLE `freepbx_log` DISABLE KEYS */;
INSERT INTO `freepbx_log` VALUES (1,'2006-11-06 01:55:36','retrieve_conf','devel-debug',0,'Started retrieve_conf, DB Connection OK'),(2,'2006-11-06 01:55:36','retrieve_conf','devel-debug',0,'Writing extensions_additional.conf');
/*!40000 ALTER TABLE `freepbx_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gabcast`
--

DROP TABLE IF EXISTS `gabcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gabcast` (
  `ext` varchar(50) NOT NULL,
  `channbr` varchar(50) default NULL,
  `pin` varchar(50) default NULL,
  PRIMARY KEY  (`ext`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gabcast`
--

LOCK TABLES `gabcast` WRITE;
/*!40000 ALTER TABLE `gabcast` DISABLE KEYS */;
/*!40000 ALTER TABLE `gabcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globals`
--

DROP TABLE IF EXISTS `globals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globals` (
  `variable` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY  (`variable`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globals`
--

LOCK TABLES `globals` WRITE;
/*!40000 ALTER TABLE `globals` DISABLE KEYS */;
INSERT INTO `globals` VALUES ('CALLFILENAME','\"\"'),('DIAL_OPTIONS','tr'),('TRUNK_OPTIONS',''),('DIAL_OUT','9'),('FAX',''),('FAX_RX','system'),('FAX_RX_EMAIL','fax@mydomain.com'),('FAX_RX_FROM','freepbx@gmail.com'),('INCOMING','group-all'),('NULL','\"\"'),('OPERATOR',''),('OPERATOR_XTN',''),('PARKNOTIFY','SIP/200'),('RECORDEXTEN','\"\"'),('RINGTIMER','15'),('DIRECTORY','last'),('AFTER_INCOMING',''),('IN_OVERRIDE','forcereghours'),('REGTIME','7:55-17:05'),('REGDAYS','mon-fri'),('DIRECTORY_OPTS',''),('DIALOUTIDS','1'),('VM_PREFIX','*'),('VM_OPTS',''),('VM_GAIN',''),('VM_DDTYPE','u'),('TIMEFORMAT','kM'),('TONEZONE','us'),('ALLOW_SIP_ANON','no'),('VMX_CONTEXT','from-internal'),('VMX_PRI','1'),('VMX_TIMEDEST_CONTEXT',''),('VMX_TIMEDEST_EXT','dovm'),('VMX_TIMEDEST_PRI','1'),('VMX_LOOPDEST_CONTEXT',''),('VMX_LOOPDEST_EXT','dovm'),('VMX_LOOPDEST_PRI','1'),('VMX_OPTS_TIMEOUT',''),('VMX_OPTS_LOOP',''),('VMX_OPTS_DOVM',''),('VMX_TIMEOUT','2'),('VMX_REPEAT','1'),('VMX_LOOPS','1'),('TRANSFER_CONTEXT','from-internal-xfer'),('MIXMON_FORMAT','wav'),('MIXMON_DIR',''),('MIXMON_POST',''),('RECORDING_STATE','ENABLED');
/*!40000 ALTER TABLE `globals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iax`
--

DROP TABLE IF EXISTS `iax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iax` (
  `id` varchar(20) NOT NULL default '-1',
  `keyword` varchar(30) NOT NULL default '',
  `data` varchar(255) NOT NULL,
  `flags` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iax`
--

LOCK TABLES `iax` WRITE;
/*!40000 ALTER TABLE `iax` DISABLE KEYS */;
INSERT INTO `iax` VALUES ('tr-peer-2','account','Anextor',2),('tr-peer-2','username','Bnextor',3),('tr-peer-2','type','friend',4),('tr-peer-2','trunk','yes',5),('tr-peer-2','secret','P8XPbXNextoR$#@173',6),('tr-peer-2','requirecalltoken','no',7),('tr-peer-2','qualify','yes',8),('tr-peer-2','host','209.190.122.165',9),('tr-peer-2','encryption','aes128',10),('tr-peer-2','context','from-internal',11),('tr-peer-2','auth','md5',12),('tr-peer-2','disallow','all',13),('tr-peer-2','allow','gsm',14),('715','record_out','Adhoc',21),('715','record_in','Adhoc',20),('715','setvar','REALCALLERIDNUM=715',19),('715','callerid','device <715>',18),('715','account','715',17),('715','permit','0.0.0.0/0.0.0.0',15),('715','requirecalltoken','',16),('715','deny','0.0.0.0/0.0.0.0',14),('715','mailbox','715@device',13),('715','accountcode','',12),('715','dial','IAX2/715',11),('715','allow','g729&ulaw&alaw',10),('715','disallow','all',9),('715','qualify','yes',8),('715','port','4569',7),('715','type','friend',6),('715','host','dynamic',5),('715','context','from-internal',4),('715','notransfer','yes',3),('715','secret','erg5d.qxexR$Q14ts',2),('4691','secret','Nomames4747!!TalBes2',2),('4691','notransfer','yes',3),('4691','context','from-internal',4),('4691','host','dynamic',5),('4691','type','friend',6),('4691','port','4569',7),('4691','qualify','yes',8),('4691','disallow','',9),('4691','allow','',10),('4691','dial','IAX2/4691',11),('4691','accountcode','',12),('4691','mailbox','4691@device',13),('4691','deny','0.0.0.0/0.0.0.0',14),('4691','permit','0.0.0.0/0.0.0.0',15),('4691','requirecalltoken','',16),('4691','account','4691',17),('4691','callerid','device <4691>',18),('4691','setvar','REALCALLERIDNUM=4691',19),('4691','record_in','Adhoc',20),('4691','record_out','Adhoc',21);
/*!40000 ALTER TABLE `iax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iaxsettings`
--

DROP TABLE IF EXISTS `iaxsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iaxsettings` (
  `keyword` varchar(50) NOT NULL default '',
  `data` varchar(255) NOT NULL default '',
  `seq` tinyint(1) NOT NULL default '0',
  `type` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`keyword`,`seq`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iaxsettings`
--

LOCK TABLES `iaxsettings` WRITE;
/*!40000 ALTER TABLE `iaxsettings` DISABLE KEYS */;
INSERT INTO `iaxsettings` VALUES ('codecpriority','host',0,0),('bandwidth','unset',0,0),('videosupport','no',10,0),('maxregexpire','3600',10,0),('minregexpire','60',10,0),('jitterbuffer','no',4,0),('forcejitterbuffer','no',5,0),('maxjitterbuffer','200',5,0),('resyncthreshold','1000',5,0),('maxjitterinterps','10',5,0),('iax_language','',0,0),('bindaddr','',2,0),('bindport','4569',1,0),('delayreject','yes',0,0),('ulaw','1',0,1),('gsm','2',1,1),('alaw','3',2,1),('adpcm','',3,1),('lpc10','',4,1),('speex','',5,1),('g722','',6,1),('g726aal2','',7,1),('ilbc','',8,1),('slin','',9,1),('g726','',10,1),('g729','',11,1),('g723','',12,1),('h264','',0,2),('h263p','',1,2),('h263','',2,2),('h261','',3,2);
/*!40000 ALTER TABLE `iaxsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incoming`
--

DROP TABLE IF EXISTS `incoming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incoming` (
  `cidnum` varchar(20) default NULL,
  `extension` varchar(50) NOT NULL,
  `destination` varchar(50) default NULL,
  `faxexten` varchar(20) default NULL,
  `faxemail` varchar(50) default NULL,
  `answer` tinyint(1) default NULL,
  `wait` int(2) default NULL,
  `privacyman` tinyint(1) default NULL,
  `alertinfo` varchar(255) default NULL,
  `ringing` varchar(20) default NULL,
  `mohclass` varchar(80) NOT NULL default 'default',
  `description` varchar(80) default NULL,
  `grppre` varchar(80) default NULL,
  `delay_answer` int(2) default NULL,
  `pricid` varchar(20) default NULL,
  `pmmaxretries` varchar(2) default NULL,
  `pmminlength` varchar(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incoming`
--

LOCK TABLES `incoming` WRITE;
/*!40000 ALTER TABLE `incoming` DISABLE KEYS */;
INSERT INTO `incoming` VALUES ('','528000220276','ext-miscdests,2,1',NULL,NULL,NULL,NULL,0,'','','default','Melia','',0,'','3','10'),('','Cameconferencia9000','ivr-10,s,1',NULL,NULL,NULL,NULL,0,'','','default','','',0,'','3','10'),('','_229XXXXXXX','app-daynight,1,1',NULL,NULL,NULL,NULL,0,'','','default','','',0,'CHECKED','3','10'),('5514541561','5514540017','ivr-10,s,1',NULL,NULL,NULL,NULL,0,'','','default','Conf_Came','',0,'','3','10'),('','5514542510','from-did-direct,5002,1',NULL,NULL,NULL,NULL,0,'','','default','SEF casa','',0,'','3','10'),('','Mentusmxdid','ext-miscdests,4,1',NULL,NULL,NULL,NULL,0,'','','default','Mentusmxdid','',0,'','3','10'),('','5514540017','ivr-3,s,1',NULL,NULL,NULL,NULL,0,'','','default','360','',0,'','3','10'),('','582123357574','app-daynight,1,1',NULL,NULL,NULL,NULL,0,'','','default','582123357574','',0,'','3','10'),('','018000700010','app-daynight,0,1',NULL,NULL,NULL,NULL,0,'','','default','Mambo800','',0,'','3','10'),('','5514540010','app-daynight,0,1',NULL,NULL,NULL,NULL,0,'','','default','MamboDF','',0,'','3','10'),('','018000440003','app-daynight,1,1',NULL,NULL,NULL,NULL,0,'','','default','Nextor800','',0,'','3','10'),('','5514540020','app-daynight,1,1',NULL,NULL,NULL,NULL,0,'','','default','NextorDF','',0,'','3','10'),('','3314540020','app-daynight,1,1',NULL,NULL,NULL,NULL,0,'','','default','NextorGDL','',0,'','3','10'),('','8114540020','app-daynight,1,1',NULL,NULL,NULL,NULL,0,'','','default','NextorMTY','',0,'','3','10'),('','5514542525','app-daynight,2,1',NULL,NULL,NULL,NULL,0,'','','default','Vozero','',0,'','3','10'),('','018000220587','app-daynight,2,1',NULL,NULL,NULL,NULL,0,'','','default','Vozero_800','',0,'','3','10');
/*!40000 ALTER TABLE `incoming` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventorydb`
--

DROP TABLE IF EXISTS `inventorydb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventorydb` (
  `id` int(11) NOT NULL auto_increment,
  `empnum` varchar(10) default NULL,
  `empname` varchar(20) NOT NULL,
  `building` varchar(150) default NULL,
  `floor` varchar(10) default NULL,
  `room` varchar(10) default NULL,
  `section` varchar(6) default NULL,
  `cubicle` varchar(6) default NULL,
  `desk` varchar(6) default NULL,
  `exten` varchar(8) default NULL,
  `phusername` varchar(10) default NULL,
  `phpassword` varchar(10) default NULL,
  `mac` varchar(18) default NULL,
  `serial` varchar(20) default NULL,
  `device` varchar(20) default NULL,
  `distdate` varchar(10) default NULL,
  `ip` varchar(14) default NULL,
  `pbxbox` varchar(20) default NULL,
  `extrainfo` varchar(256) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventorydb`
--

LOCK TABLES `inventorydb` WRITE;
/*!40000 ALTER TABLE `inventorydb` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventorydb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr`
--

DROP TABLE IF EXISTS `ivr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr` (
  `ivr_id` int(11) NOT NULL auto_increment,
  `displayname` varchar(50) default NULL,
  `deptname` varchar(50) default NULL,
  `enable_directory` varchar(8) default NULL,
  `enable_directdial` varchar(8) default NULL,
  `timeout` int(11) default NULL,
  `dircontext` varchar(50) default 'default',
  `alt_timeout` varchar(8) default NULL,
  `alt_invalid` varchar(8) default NULL,
  `loops` tinyint(1) NOT NULL default '2',
  `announcement_id` int(11) default NULL,
  `timeout_id` int(11) default NULL,
  `invalid_id` int(11) default NULL,
  `retvm` varchar(8) default NULL,
  PRIMARY KEY  (`ivr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr`
--

LOCK TABLES `ivr` WRITE;
/*!40000 ALTER TABLE `ivr` DISABLE KEYS */;
INSERT INTO `ivr` VALUES (1,'__install_done','1',NULL,NULL,NULL,'default',NULL,NULL,2,NULL,NULL,NULL,NULL),(3,'360',NULL,'','CHECKED',3,'default','','',2,3,0,0,''),(4,'Mambo_Dia',NULL,'','CHECKED',3,'','CHECKED','CHECKED',2,5,0,0,''),(5,'Mambo_Noche',NULL,'','CHECKED',3,'','CHECKED','CHECKED',2,6,0,0,''),(6,'Nextor_DÃ­a',NULL,'','CHECKED',3,'','CHECKED','CHECKED',1,15,0,0,''),(7,'Nextor_Noche',NULL,'','CHECKED',3,'','','CHECKED',1,16,0,0,''),(8,'Vozero_Dia',NULL,'','CHECKED',3,'','CHECKED','CHECKED',1,18,0,0,''),(9,'Vozero_Noche',NULL,'','CHECKED',3,'','','',2,20,0,0,''),(10,'Conferencias_CAME',NULL,'','',4,'','CHECKED','CHECKED',4,0,0,0,'');
/*!40000 ALTER TABLE `ivr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_dests`
--

DROP TABLE IF EXISTS `ivr_dests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_dests` (
  `ivr_id` int(11) NOT NULL,
  `selection` varchar(10) default NULL,
  `dest` varchar(50) default NULL,
  `ivr_ret` tinyint(1) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_dests`
--

LOCK TABLES `ivr_dests` WRITE;
/*!40000 ALTER TABLE `ivr_dests` DISABLE KEYS */;
INSERT INTO `ivr_dests` VALUES (3,'1','ext-queues,1001,1',0),(3,'2','ext-queues,1001,1',0),(3,'t','ext-queues,1001,1',0),(4,'4','ext-queues,1000,1',0),(4,'3','ext-queues,1000,1',0),(4,'2','ext-queues,1000,1',0),(4,'1','ext-queues,1000,1',0),(4,'0','ext-queues,1000,1',0),(5,'1','app-announcement-2,s,1',0),(5,'0','app-announcement-2,s,1',0),(6,'t','ext-queues,1002,1',0),(6,'i','ext-queues,1002,1',0),(6,'90','ext-meetme,9000,1',0),(6,'3','ext-queues,1003,1',0),(6,'2','ext-queues,1002,1',0),(6,'1','ext-queues,1002,1',0),(6,'0','ext-queues,1002,1',0),(7,'t','ext-group,600,1',0),(7,'i','ext-group,600,1',0),(7,'1','ext-group,600,1',0),(7,'0','ext-group,600,1',0),(8,'t','ext-queues,1004,1',0),(8,'i','ext-queues,1004,1',0),(8,'2','ext-queues,1005,1',0),(8,'1','ext-queues,1004,1',0),(9,'t','app-announcement-3,s,1',0),(9,'2','app-announcement-3,s,1',0),(9,'1','ext-group,602,1',0),(10,'i','app-blackhole,hangup,1',0),(10,'9006','ext-meetme,9006,1',0),(10,'9005','ext-meetme,9005,1',0),(10,'9004','ext-meetme,9004,1',0),(10,'9003','ext-meetme,9003,1',0),(10,'9002','ext-meetme,9002,1',0),(10,'9001','ext-meetme,9001,1',0),(10,'9000','ext-meetme,9000,1',0),(10,'t','ivr-10,s,1',0);
/*!40000 ALTER TABLE `ivr_dests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_incoming`
--

DROP TABLE IF EXISTS `language_incoming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_incoming` (
  `extension` varchar(50) default NULL,
  `cidnum` varchar(50) default NULL,
  `language` varchar(10) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_incoming`
--

LOCK TABLES `language_incoming` WRITE;
/*!40000 ALTER TABLE `language_incoming` DISABLE KEYS */;
/*!40000 ALTER TABLE `language_incoming` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `language_id` int(11) NOT NULL auto_increment,
  `lang_code` varchar(50) default NULL,
  `description` varchar(50) default NULL,
  `dest` varchar(255) default NULL,
  PRIMARY KEY  (`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager` (
  `manager_id` int(11) NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  `secret` varchar(50) default NULL,
  `deny` varchar(255) default NULL,
  `permit` varchar(255) default NULL,
  `read` varchar(255) default NULL,
  `write` varchar(255) default NULL,
  PRIMARY KEY  (`manager_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetme`
--

DROP TABLE IF EXISTS `meetme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meetme` (
  `exten` varchar(50) NOT NULL,
  `options` varchar(15) default NULL,
  `userpin` varchar(50) default NULL,
  `adminpin` varchar(50) default NULL,
  `description` varchar(50) default NULL,
  `joinmsg_id` int(11) default NULL,
  `music` varchar(80) default NULL,
  `users` tinyint(4) default '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetme`
--

LOCK TABLES `meetme` WRITE;
/*!40000 ALTER TABLE `meetme` DISABLE KEYS */;
INSERT INTO `meetme` VALUES ('9000','oTcMsr','','','Direccion General',0,'inherit',0),('9001','oTcMsr','99278','','Subdireccion 2',0,'inherit',0),('9002','oTcMsr','64831','','Subdireccion 3',0,'inherit',0),('9003','oTcMsr','51972','','Subdireccion 4',0,'inherit',0),('9004','oTcMsr','27008','','Subdireccion 5',0,'inherit',0),('9005','TcMsr','56438','','Sala 6',0,'inherit',0),('9006','oTcM','89745','','Sala 7',0,'inherit',0);
/*!40000 ALTER TABLE `meetme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `miscapps`
--

DROP TABLE IF EXISTS `miscapps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `miscapps` (
  `miscapps_id` int(11) NOT NULL auto_increment,
  `ext` varchar(50) default NULL,
  `description` varchar(50) default NULL,
  `dest` varchar(255) default NULL,
  PRIMARY KEY  (`miscapps_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miscapps`
--

LOCK TABLES `miscapps` WRITE;
/*!40000 ALTER TABLE `miscapps` DISABLE KEYS */;
/*!40000 ALTER TABLE `miscapps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `miscdests`
--

DROP TABLE IF EXISTS `miscdests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `miscdests` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(100) NOT NULL,
  `destdial` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miscdests`
--

LOCK TABLES `miscdests` WRITE;
/*!40000 ALTER TABLE `miscdests` DISABLE KEYS */;
INSERT INTO `miscdests` VALUES (2,'Melia','528000220276'),(3,'Mail Soporte','0813'),(4,'Mentus','20001100');
/*!40000 ALTER TABLE `miscdests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_xml`
--

DROP TABLE IF EXISTS `module_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_xml` (
  `id` varchar(20) NOT NULL default 'xml',
  `time` int(11) NOT NULL default '0',
  `data` mediumblob NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_xml`
--

LOCK TABLES `module_xml` WRITE;
/*!40000 ALTER TABLE `module_xml` DISABLE KEYS */;
INSERT INTO `module_xml` VALUES ('installid',1226611102,'a2bd413a30de2c2eae6f4de9d32f6d5c'),('type',1226611102,'vmware'),('module_repo',1374548101,'http://mirror.freepbx.org/extended-'),('mod_serialized',1376884501,'a:61:{s:7:\"builtin\";a:12:{s:7:\"rawname\";s:7:\"builtin\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"name\";s:7:\"Builtin\";s:7:\"version\";s:7:\"2.3.0.2\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:9:\"changelog\";s:24:\"\n		*0.1* First release\n	\";s:9:\"menuitems\";a:2:{s:8:\"modules1\";s:12:\"Module Admin\";s:8:\"modules2\";s:12:\"Module Admin\";}s:11:\"displayname\";s:7:\"Builtin\";s:5:\"items\";a:2:{s:8:\"modules1\";a:5:{s:4:\"name\";s:12:\"Module Admin\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:5:\"Admin\";s:4:\"sort\";s:2:\"-9\";s:7:\"display\";s:7:\"modules\";}s:8:\"modules2\";a:5:{s:4:\"name\";s:12:\"Module Admin\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Admin\";s:4:\"sort\";s:2:\"-9\";s:7:\"display\";s:7:\"modules\";}}s:6:\"status\";i:2;}s:12:\"donotdisturb\";a:14:{s:7:\"rawname\";s:12:\"donotdisturb\";s:4:\"name\";s:20:\"Do-Not-Disturb (DND)\";s:7:\"version\";s:7:\"2.7.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:541:\"\n		*2.7.0.1* #4294\n		*2.7.0.0* localizations\n	  *2.6.0.1* Added publisher/lic\n		*2.6.0.0* #3650, #3651\n		*2.5.0.5* #3274\n		*2.5.0.4* #3215, localization fixes\n		*2.5.0.3* localization, xml description, Swedish\n		*2.5.0.2* #2969 change default value to *76\n		*2.5.0.1* #2909 Add DND hints\n		*2.5.0* added toggle and support for func_devstate\n		*2.4.0* bunp for 2.4\n		*1.0.2.2* changed category\n		*1.0.2.1* bump for rc1\n		*1.0.2* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.0.1* First release for 2.2\n	\";s:11:\"description\";s:34:\"Provides donotdisturb featurecodes\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:8:\"location\";s:36:\"release/2.7/donotdisturb-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"796751b59b61d4ef4267808e4e2b1bc0\";s:11:\"displayname\";s:20:\"Do-Not-Disturb (DND)\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.7.0.1\";}s:11:\"iaxsettings\";a:16:{s:7:\"rawname\";s:11:\"iaxsettings\";s:4:\"name\";s:21:\"Asterisk IAX Settings\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:13:\"Bandwidth.com\";s:7:\"license\";s:6:\"AGPLv3\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"menuitems\";a:1:{s:11:\"iaxsettings\";s:21:\"Asterisk IAX Settings\";}s:11:\"description\";s:210:\"Use to configure Various Asterisk IAX Settings in the General section of iax.conf. The module assumes Asterisk version 1.4 or higher. Some settings may not exist in Asterisk 1.2 and will be ignored by Asterisk.\";s:9:\"changelog\";s:399:\"\n		*2.8.0.0* #4681\n		*2.7.0.2* #4216\n		*2.7.0.1* localizations\n		*2.7.0.0* #3976 allows codec priorities\n		*2.6.0.5* #3866\n		*2.6.0.4* localizations, misc\n		*2.6.0.3* #3832\n		*2.6.0.2* #3811, #3813\n		*2.6.0.1* corrected publisher/lic\n		*2.6.0.0* install script \'if not exists\' missing\n		*2.6.0beta1.1* install script \'if not exists\' missing\n		*2.6.0beta1.0* lots of tweaks, fixed install.php error\n	\";s:8:\"location\";s:35:\"release/2.8/iaxsettings-2.7.0.3.tgz\";s:6:\"md5sum\";s:32:\"5ec51d977e8e9fe78a2556f4a57cbd33\";s:11:\"displayname\";s:21:\"Asterisk IAX Settings\";s:5:\"items\";a:1:{s:11:\"iaxsettings\";a:4:{s:4:\"name\";s:21:\"Asterisk IAX Settings\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";s:2:\"-6\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:6:\"queues\";a:17:{s:7:\"rawname\";s:6:\"queues\";s:4:\"name\";s:6:\"Queues\";s:7:\"version\";s:7:\"2.8.0.4\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:198:\"Creates a queue where calls are placed on hold and answered on a first-in, first-out basis. Many options are available, including ring strategy for agents, caller announcements, max wait times, etc.\";s:9:\"changelog\";s:2657:\"\n		*2.8.0.4* #4671\n		*2.8.0.3* localization updates\n		*2.8.0.2* #4327\n		*2.8.0.1* #4297\n		*2.8.0.0* #4165, #4187, #4279, #4280, #2203\n		*2.7.0.2* #4120 again fixed typo in variable name\n		*2.7.0.1* #4120, spelling typo\n		*2.7.0.0* #4084, spelling, tooltips changes, localizations\n		*2.7.0beta1.5* #4084, #4068 (support for experimental dial-one)\n		*2.7.0beta1.4* #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0beta1.3* #4048\n		*2.7.0beta1.2* #4038\n		*2.7.0beta1.1* #2085\n		*2.7.0beta1.0* #3594\n		*2.6.0.3* #3945,#3984\n		*2.6.0.2* #3794, #3496, #3562 (with use of USEQUEUESTATE=yes and Asterisk patch: 15168\n		*2.6.0.1* #3044 (add per device queue login/blf enabled toggle feature code)\n		*2.6.0.0* #3546, #2768, #3685, #3686\n		*2.5.4.8* #3664\n		*2.5.4.7* #3618, localization udpates\n		*2.5.4.6* localization updates\n		*2.5.4.5* #3400, #3380, various translations\n		*2.5.4.4* #3242, #3230, localization fixes\n		*2.5.4.3* #3222 sqlite3\n		*2.5.4.2* #3200 and localization string fixes\n		*2.5.4.1* #3171 and localize queues_timeString()\n		*2.5.4* #3138, #3147 add the Queues App n option as Retry alternative, see tooltip\n		*2.5.3* #3098 WARNING: subtle queue behavior might change: set persistenetmembers=yes so dynamic agents are retained on asterisk restarting, and added option for autofill\n		*2.5.2.4* #3069 add queue weight option to queues\n		*2.5.2.3* #3083, setting ringinuse causes transfered call to keep agent as unavailable, removing since it is not needed for FreePBX standard agents\n		*2.5.2.2* #2987, #3010 sqlite3 install script, spelling\n		*2.5.2.1* #2970 periodic-announce message not being configured (re #2068 change)\n		*2.5.2* #2073 add a Queue hold time CID prepend to report how long the caller has been holding\n		*2.5.1* #2068 recordings_id, don\'t list IVRs with compound messages\n		*2.5.0.1* #2875, #2768\n		*2.5.0.0* #2976 Add Optional Regex to filter user agent numbers that they can input\n		*2.4.0.8* #2757 allow spaces and other alphanumeric characters in description\n		*2.4.0.7* #2604, #2707, #2843 fix mal-formed html tags, typo, Russian Translation, add oldstyle module hook\n		*2.4.0.6* added depends on 2.4.0\n		*2.4.0.5* #2637, monitor-join=yes not supported in asterisk 1.6\n		*2.4.0.4* #2636 Queues Options member status allways show No\n		*2.4.0.3* #2579 added strict to joinempty and leavewhenempy, #2627 ringing box ignored\n		*2.4.0.2* #2528 add context = \'ext-queues\' when getting destination statement\n		*2.4.0.1* added out() and outn() to install script\n		*2.4.0* Migration from legacy tables, added queues_conf class, Extension/dest registry, #2282, #2487, it translations\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";a:2:{i:0;s:19:\"recordings ge 3.3.8\";i:1;s:18:\"core ge 2.6.0beta1\";}}s:9:\"menuitems\";a:1:{s:6:\"queues\";s:6:\"Queues\";}s:8:\"location\";s:30:\"release/2.8/queues-2.8.0.3.tgz\";s:6:\"md5sum\";s:32:\"28f889b3a8cc68050509038dc5190d31\";s:11:\"displayname\";s:6:\"Queues\";s:5:\"items\";a:1:{s:6:\"queues\";a:5:{s:4:\"name\";s:6:\"Queues\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;s:13:\"needsenginedb\";s:3:\"yes\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.4\";}s:11:\"conferences\";a:17:{s:7:\"rawname\";s:11:\"conferences\";s:4:\"name\";s:11:\"Conferences\";s:7:\"version\";s:7:\"2.8.0.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:85:\"Allow creation of conference rooms (meet-me) where multiple people can talk together.\";s:9:\"changelog\";s:1491:\"\n		*2.8.0.3* #4697\n		*2.8.0.2* #4660\n		*2.8.0.1* #4309\n		*2.8.0.0* #3331 max participants option\n		*2.7.0.1* spelling fixes, localization updates\n		*2.7.0.0* #4051, #3967 add MoH class choice require MoH module 2.7.0.0+\n		*2.6.0.2* #3126\n		*2.6.0.1* tabindex init\n		*2.6.0.0* #3392, localizations\n		*2.5.1.6* #3392 and some localizations\n		*2.5.1.5* localization strings enclosed\n		*2.5.1.4* #3237\n		*2.5.1.3* #3192 set dir for recordings, localization cleanup and Swedish\n		*2.5.1.2* #3135 variable initialization\n		*2.5.1.1* #3087 add hook to module code\n		*2.5.1* #2064 Migrate recordings to recording ids\n		*2.5.0* #2845, added blf hints, added delete and add icons\n		*2.4.0.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* #2158 add recording option, add support for Extension and Destination Registries, it translations\n		*1.2.2* don\'t ask for name confirmation when recording names on Asterisk 1.3 (new option I replaces i)\n		*1.2.1.3* move Macro(user-callerid) to be called with each conf to accomodate future language settings\n		*1.2.1.2* add call to Macro(user-callerid) to get proper CID in Meetme Conference\n		*1.2.1.1* bump for rc1\n		*1.2.1* changed syntax error in meetme_additional.conf form \'|\' to \',\' separator\n		*1.2* Fixed raising asterisk error on empty dialstatus #1708\n		*1.1.2* Add he_IL translation\n		*1.1.1* Updated for 2.2.0RC1\n		*1.1* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:9:\"menuitems\";a:1:{s:11:\"conferences\";s:11:\"Conferences\";}s:8:\"location\";s:35:\"release/2.8/conferences-2.8.0.2.tgz\";s:6:\"md5sum\";s:32:\"261cf9c7f621998ad99759af1b001722\";s:11:\"displayname\";s:11:\"Conferences\";s:5:\"items\";a:1:{s:11:\"conferences\";a:4:{s:4:\"name\";s:11:\"Conferences\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.3\";}s:7:\"phpinfo\";a:15:{s:7:\"rawname\";s:7:\"phpinfo\";s:4:\"name\";s:8:\"PHP Info\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:176:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* misc\n		*2.4.0* bump for 2.4\n		*1.1.0.1* bump for rc1\n		*1.1.0* #1442 remove access problem and iframe\n	\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"menuitems\";a:1:{s:7:\"phpinfo\";s:8:\"PHP Info\";}s:8:\"location\";s:31:\"release/2.7/phpinfo-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"b884625fba678524d81a725a3d9175c6\";s:11:\"displayname\";s:8:\"PHP Info\";s:5:\"items\";a:1:{s:7:\"phpinfo\";a:4:{s:4:\"name\";s:8:\"PHP Info\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:7:\"dictate\";a:14:{s:7:\"rawname\";s:7:\"dictate\";s:4:\"name\";s:9:\"Dictation\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:9:\"changelog\";s:827:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.1* localizations\n		*2.7.0.0* #3873\n		*2.6.0.0* localizations\n		*2.5.0.2* localization string enclosures\n		*2.5.0.1* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0* typo in $_GLOBALS variable\n		*2.4.0* abort if user/extension conflict and move hook after user/extnesion hook\n		*1.1.2.3* #2312 fix dictate in devicesandusers mode\n		*1.1.2.2* changed categories\n		*1.1.2.1* bump for rc1\n		*1.1.2* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.1.1* Fix for Dictation not appearing on User page when in Device and User mode.\n		*1.1* Fix changes not sticking when creating an extension, replace Rob-sounds with Allison-sounds.\n		*1.0.1* Replaced \'invalid extension\' with \'feature not available on this line\' when disabled\n		*1.0.0* Original Release\n	\";s:11:\"description\";s:189:\"This uses the app_dictate module of Asterisk to let users record dictate into their phones. When complete, the dictations can be emailed to an email address specified in the extension page.\";s:8:\"location\";s:31:\"release/2.7/dictate-2.7.0.1.tgz\";s:6:\"md5sum\";s:32:\"713e2f52a4f9a024cbbf14a45eca1817\";s:11:\"displayname\";s:9:\"Dictation\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:6:\"backup\";a:17:{s:7:\"rawname\";s:6:\"backup\";s:4:\"name\";s:16:\"Backup & Restore\";s:7:\"version\";s:7:\"2.8.0.7\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:45:\"Backup & Restore for your FreePBX environment\";s:9:\"menuitems\";a:1:{s:6:\"backup\";s:16:\"Backup & Restore\";}s:7:\"depends\";a:1:{s:6:\"module\";s:4:\"core\";}s:9:\"changelog\";s:1214:\"\n		*2.8.0.7* #4463\n		*2.8.0.6* #4371\n		*2.8.0.5* #4079, #4290\n		*2.8.0.4* #4167, set execute prop on ampbackup.php\n		*2.8.0.0* minor fix\n		*2.7.0.5* spelling fixes, localization updates\n		*2.7.0.4* #4081\n		*2.7.0.3* #4064\n		*2.7.0.2* #4061, #4062, #4063\n		*2.7.0.1beta1.2* #1386\n		*2.7.0.1beta1.0* #1386\n		*2.7.0beta1.0* #3982, #3996, #3999\n		*2.6.0.4* #3975 - multipal backup improvements\n		*2.6.0.3* #3839\n		*2.6.0.2* #3577\n		*2.6.0.1* added publisher/lic\n		*2.6.0.0* #3224, #3640\n		*2.5.1.6* localization updates\n		*2.5.1.5* #3323 backup fails if zaptel.conf or dahdi directory not present\n		*2.5.1.4* #3238, spelling\n		*2.5.1.3* description added to xml, Swedish\n		*2.5.1.2* #3077 (DAHDI Support), Swedish Translations\n		*2.5.1.1* spelling\n		*2.5.1* #2987, #2995, #3037 sqlite3 support, removal of retrieve_backup_cron.pl\n		*2.5.0.2* #2743 don\'t delete the current astdb entries if the new astdb.dump is empty\n		*2.5.0.1* #2884 include zaptel.conf in backup\n		*2.5.0* #2889, #2845, #2353, added delete and add icons\n		*2.4.1.1* #2694 display problem with any all selection\n		*2.4.1* #2269 clear several of the astdb objects before restore, and other bug fixes\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	\";s:8:\"location\";s:30:\"release/2.8/backup-2.8.0.6.tgz\";s:6:\"md5sum\";s:32:\"7347624045cf64f127da2da087d5fee6\";s:11:\"displayname\";s:16:\"Backup & Restore\";s:5:\"items\";a:1:{s:6:\"backup\";a:5:{s:4:\"name\";s:16:\"Backup & Restore\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;s:13:\"needsenginedb\";s:3:\"yes\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.7\";}s:4:\"core\";a:19:{s:7:\"rawname\";s:4:\"core\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"name\";s:4:\"Core\";s:7:\"version\";s:7:\"2.8.1.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:9:\"changelog\";s:2962:\"\n		*2.8.1.0* bump to 2.8.1 to match framework base\n		*2.8.0.8* #4749 (Avoid Asterisk Security Vulnerability)\n		*2.8.0.7* #4689, #4697, #4730\n		*2.8.0.6* #4634, #4453, #4563\n		*2.8.0.5* #4549, #4615 (Security Bug)\n		*2.8.0.4* #4574, #4572, #4575\n		*2.8.0.3* #4401, #4525, #4507, #4499\n		*2.8.0.2* #4443, #4444, #4460, #4414\n		*2.8.0.1* #4426\n		*2.8.0.0* #4396\n		*2.8.0.0RC1.4* #4390\n		*2.8.0.0RC1.3* #4380\n		*2.8.0.0RC1.2* #4379 again\n		*2.8.0.0RC1.1* #4378, #4379\n		*2.8.0.0RC1.0* #4374\n		*2.8.0.0beta2.4* #4350, #4357\n		*2.8.0.0beta2.3* #4338\n		*2.8.0.0beta2.2* #4309, remove legacy directory settings if no IVRs using them\n		*2.8.0.0beta2.1* #4293\n		*2.8.0.0beta2.0* #4273, #4230, #4242, #4196, #3519, #4288, #4270, #4219\n		*2.8.0.0beta1.9* #4205, #4208, #4155, #4212\n		*2.8.0.0beta1.8* #4202\n		*2.8.0.0beta1.7* #4174, #4190, #4201, #4161\n		*2.8.0.0beta1.6* #4181, #4184\n		*2.8.0.0beta1.5* #4155\n		*2.8.0.0beta1.4* #4071, #4152, #4156, #4159, #4160\n		*2.8.0.0beta1.3* #4151\n		*2.8.0.0beta1.2* #4146, #4148, triming local changelog\n		*2.8.0.0beta1.1* #4132, #2833, #4068, #4135, #4143, #4144\n		*2.8.0.0beta1.0* #4100, #4102, #4110 New Outbound Routing Schema and features\n		*2.7.0.2* really fix #4092\n		*2.7.0.1* #4093, #4094, #4095, #4092\n		*2.7.0.0* minor tweaks\n		*2.7.0RC1.5* #4075, #4078, #4080, #4053\n		*2.7.0RC1.4* #4072\n		*2.7.0RC1.3* #4068, (#4069 available but not used)\n		*2.7.0RC1.2* #4067\n		*2.7.0RC1.1* #4058, #4065, #4066\n		*2.7.0RC1.0* #4041, #4042, #4047, #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0beta1.3* #4037\n		*2.7.0beta1.2* #3993 (#3934, #3889)\n		*2.7.0beta1.1* #4020, #2389, #3980, #3992, #3939, #333, #3721, #3185\n		*2.7.0beta1.0* #3882, #4000, #1718, #3927, #3805, #4007, #3998, #3951, sql injections fixes\n		*2.6.0.1* #3889 reverted, #3900, #3962, #2787, #3793, #3377, #3386, #3717\n		*2.6.0.0* #3889, #3919\n		*2.6.0RC2.1* #3886, #3885, #3875 revisited\n		*2.6.0RC2.0* #3854, #3872, #3871, #3877\n		*2.6.0RC1.1* #3751\n		*2.6.0RC1.0* #3529, #3864, #3538\n		*2.6.0beta2.2* #3722, #3848, #3841, #3700\n		*2.6.0beta2.1* #3844 (revert #3423), #3846, #3849\n		*2.6.0beta2.0* #3075, #3501, #3636, #3581, #3266, #3701, #3545, #3430, #3798, #3609, #3836\n		*2.6.0beta1.3* trunk tab improvements\n		*2.6.0beta1.2* added more sql escape in devices\n		*2.6.0beta1.1* #3696, (needs framework updated), #3702, #3706, #3712, #3691, #3693, #3705, #3644, #3739, #3741, #3744, #3790 \n		*2.6.0beta1.0* #3478, #3423, #3648, #3685, #3686, #1380\n		*2.6.0alpha1.4* fixes re #3649\n		*2.6.0alpha1.3* #3653, #3591, #3650\n		*2.6.0alpha1.2* #3451, $932, #3426, #3474, #3439, #3526, #3534, $3648, #3649, #3517 moved macro-vm to auto-generation (WARNING: custom modification of macro-vm in extensions_custom.conf need to be moved to extensions_override_freepbx.conf\n		*2.6.0alpha1.1* #3380, #3358, #3387, localizations\n		*2.6.0alpha1.0* #3321, #3328, #3345 inbound CID routing fix, adds vm-callme voicemail access option\n		*2.5* CHANGELOG TRUNCATED See SVN Repository\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:10:\"2.6.0beta1\";}s:12:\"requirements\";a:1:{s:4:\"file\";s:18:\"/usr/sbin/asterisk\";}s:9:\"menuitems\";a:10:{s:10:\"extensions\";s:10:\"Extensions\";s:5:\"users\";s:5:\"Users\";s:7:\"devices\";s:7:\"Devices\";s:3:\"did\";s:14:\"Inbound Routes\";s:11:\"zapchandids\";s:16:\"Zap Channel DIDs\";s:7:\"routing\";s:15:\"Outbound Routes\";s:6:\"trunks\";s:6:\"Trunks\";s:7:\"general\";s:16:\"General Settings\";s:8:\"ampusers\";s:14:\"Administrators\";s:4:\"wiki\";s:15:\"FreePBX Support\";}s:8:\"location\";s:28:\"release/2.8/core-2.8.0.8.tgz\";s:6:\"md5sum\";s:32:\"ae9fd59075231858de7518a320e0a5af\";s:11:\"displayname\";s:4:\"Core\";s:5:\"items\";a:10:{s:10:\"extensions\";a:5:{s:4:\"name\";s:10:\"Extensions\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";s:2:\"-4\";s:13:\"needsenginedb\";s:3:\"yes\";}s:5:\"users\";a:5:{s:4:\"name\";s:5:\"Users\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";s:2:\"-3\";s:13:\"needsenginedb\";s:3:\"yes\";}s:7:\"devices\";a:5:{s:4:\"name\";s:7:\"Devices\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";s:2:\"-4\";s:13:\"needsenginedb\";s:3:\"yes\";}s:3:\"did\";a:4:{s:4:\"name\";s:14:\"Inbound Routes\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";s:2:\"-5\";}s:11:\"zapchandids\";a:4:{s:4:\"name\";s:16:\"Zap Channel DIDs\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";s:2:\"-5\";}s:7:\"routing\";a:4:{s:4:\"name\";s:15:\"Outbound Routes\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";i:0;}s:6:\"trunks\";a:4:{s:4:\"name\";s:6:\"Trunks\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";i:0;}s:7:\"general\";a:4:{s:4:\"name\";s:16:\"General Settings\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";i:0;}s:8:\"ampusers\";a:4:{s:4:\"name\";s:14:\"Administrators\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";s:1:\"5\";}s:4:\"wiki\";a:7:{s:4:\"name\";s:15:\"FreePBX Support\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:7:\"Support\";s:4:\"sort\";s:1:\"5\";s:4:\"href\";s:18:\"http://freepbx.org\";s:6:\"target\";s:6:\"_blank\";s:6:\"access\";s:3:\"all\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.1.0\";}s:7:\"manager\";a:15:{s:7:\"rawname\";s:7:\"manager\";s:4:\"name\";s:12:\"Asterisk API\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"menuitems\";a:1:{s:7:\"manager\";s:12:\"Asterisk API\";}s:9:\"changelog\";s:367:\"\n		*2.8.0.0* #4309\n		*2.7.0.1* localizations\n		*2.7.0.0* #3884\n		*2.6.0.0* localizations, misc\n		*2.5.0.1* #3191 unitialized vars\n		*2.5.0* #2845 tabindex\n		*2.4.0* it translations\n		*1.3.1* bump for rc1\n		*1.3* Added SQLite3 support, fixes ticket 1776\n		*1.2* Fix UI issues, and \'Array\' message.\n		*1.1* First 2.2 release. Added he_IL support, fixed some warnings.\n	\";s:8:\"location\";s:31:\"release/2.7/manager-2.7.0.1.tgz\";s:6:\"md5sum\";s:32:\"b6100959db196c3868ecb15680e13342\";s:11:\"displayname\";s:12:\"Asterisk API\";s:5:\"items\";a:1:{s:7:\"manager\";a:4:{s:4:\"name\";s:12:\"Asterisk API\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:9:\"miscdests\";a:17:{s:7:\"rawname\";s:9:\"miscdests\";s:4:\"name\";s:17:\"Misc Destinations\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:190:\"Allows creating destinations that dial any local number (extensions, feature codes, outside phone numbers) that can be used by other modules (eg, IVR, time conditions) as a call destination.\";s:9:\"changelog\";s:787:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* localization string enclosures\n		*2.5.0.1* #3018, #3043 spelling and delete link does not show if not being used as dest\n		*2.5.0* #2845 tabindex, added delete and add icons\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension/dest registry, it translation\n		*1.3.4.3* changed categories\n		*1.3.4.2* bump for rc1\n		*1.3.4.1* changed freePBX to FreePBX\n		*1.3.4* destination changed from Dial(Local/nnn@from-internal) to Goto(from-internal,nnn,1), no reason a new channel should be created\n		*1.3.3* Minor formatting changes\n		*1.3.2* Add he_IL translation\n		*1.3.1* Updated help text\n		*1.3* First release for FreePBX 2.2 - Fixed GUI issues\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:9:\"menuitems\";a:1:{s:9:\"miscdests\";s:17:\"Misc Destinations\";}s:8:\"location\";s:33:\"release/2.7/miscdests-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"148c5e62663e167d2731c811fa624fee\";s:11:\"displayname\";s:17:\"Misc Destinations\";s:5:\"items\";a:1:{s:9:\"miscdests\";a:4:{s:4:\"name\";s:17:\"Misc Destinations\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:7:\"javassh\";a:16:{s:7:\"rawname\";s:7:\"javassh\";s:4:\"name\";s:8:\"Java SSH\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:7:\"FREEUSE\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:220:\"Provides a Java applet to access the system shell using SSH. SSH client is provided by Appgate (www.appgate.com) and licensed is Free Limited Use, http://www.appgate.com/index/products/mindterm/mindterm_end_user_lic.html\";s:9:\"menuitems\";a:1:{s:7:\"javassh\";s:8:\"Java SSH\";}s:9:\"changelog\";s:301:\"\n		*2.8.0.1* #4473\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* security setting updates: r7432\n		*2.5.0.1* localization updates\n		*2.5.0* localization fixes, Swedish\n		*2.4.0* bump for 2.4\n		*1.0.1.1* bump for rc1\n		*1.0.1* First Changelog\n	\";s:8:\"location\";s:31:\"release/2.8/javassh-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"8dc23cb942a94b77077837cd964a6e4f\";s:11:\"displayname\";s:8:\"Java SSH\";s:5:\"items\";a:1:{s:7:\"javassh\";a:4:{s:4:\"name\";s:8:\"Java SSH\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:9:\"queueprio\";a:17:{s:7:\"rawname\";s:9:\"queueprio\";s:4:\"name\";s:16:\"Queue Priorities\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:73:\"Adds the ability to set a callers priority higher before entering a queue\";s:9:\"menuitems\";a:1:{s:9:\"queueprio\";s:16:\"Queue Priorities\";}s:9:\"changelog\";s:240:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.1* #3654\n		*2.6.0.0* misc\n		*2.5.0.4* #3246, #3254\n		*2.5.0.3* #3214\n		*2.5.0.2* #3110, #3138 Sqlite3 fixes\n		*2.5.0.1* #2845 tabindex\n		*2.5.0* First release of module\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:8:\"location\";s:33:\"release/2.7/queueprio-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"ac666993935735827c3c507e9d2d9a6e\";s:11:\"displayname\";s:16:\"Queue Priorities\";s:5:\"items\";a:1:{s:9:\"queueprio\";a:4:{s:4:\"name\";s:16:\"Queue Priorities\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:8:\"logfiles\";a:15:{s:7:\"rawname\";s:8:\"logfiles\";s:4:\"name\";s:17:\"Asterisk Logfiles\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:388:\"\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.1* #3763, #3978\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* #3645\n		*2.5.0.1* localization updates\n		*2.5.0* #2776: filter out potentially bad html tags from log file\n		*2.4.0* bumped for 2.4\n		*1.1.1* bump for rc1\n		*1.1.0* #1442 remove access problem and have log display in same window\n		*1.0.2* #2070 fix proper use of script tags\n	\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:7:\"Support\";s:9:\"menuitems\";a:1:{s:8:\"logfiles\";s:17:\"Asterisk Logfiles\";}s:8:\"location\";s:32:\"release/2.7/logfiles-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"d36680752d21f960aea2e197d9b8ef69\";s:11:\"displayname\";s:17:\"Asterisk Logfiles\";s:5:\"items\";a:1:{s:8:\"logfiles\";a:4:{s:4:\"name\";s:17:\"Asterisk Logfiles\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:7:\"Support\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:11:\"callforward\";a:14:{s:7:\"rawname\";s:11:\"callforward\";s:4:\"name\";s:12:\"Call Forward\";s:7:\"version\";s:7:\"2.8.0.4\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:640:\"\n		*2.8.0.4* #4578\n		*2.8.0.3* #4294\n		*2.8.0.2* #4114, #4115, #3605\n		*2.8.0.1* #4214\n		*2.8.0.0* #4116, #4105 again\n		*2.7.0.2* #4103, #4104, #4105\n		*2.7.0.1* localizations\n		*2.7.0.0* #4047 CF toggle + devstate and hint additions\n		*2.6.0.1* Added publisher/lic\n		*2.6.0.0* #3650, #3651, localizations\n		*2.5.0.1* localization fixes\n		*2.5.0* localization fixes, Swedish\n		*2.4.0* bumped for 2.4\n		*1.1.2* #2321 fixed CF AMPUSER(number) issue, syntax problem\n		*1.1.1.2* changed categories\n		*1.1.1.1* bump for rc1\n		*1.1.1* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.1* First release for 2.2\n	\";s:11:\"description\";s:33:\"Provides callforward featurecodes\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:8:\"location\";s:35:\"release/2.8/callforward-2.8.0.3.tgz\";s:6:\"md5sum\";s:32:\"f19293902cbaf162d27342743077e27b\";s:11:\"displayname\";s:12:\"Call Forward\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.4\";}s:11:\"inventorydb\";a:13:{s:7:\"rawname\";s:11:\"inventorydb\";s:4:\"name\";s:9:\"Inventory\";s:7:\"version\";s:7:\"2.5.0.2\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:17:\"Third Party Addon\";s:9:\"menuitems\";a:1:{s:11:\"inventorydb\";s:9:\"Inventory\";}s:9:\"changelog\";s:303:\"\n		*2.5.0.2* localization updates\n		*2.5.0.1* localization, Swedish\n		*2.5.0* #2845 tabindex\n		*2.4.0.1* #2645 API error - NOTICE: This module will be removed from future versions\n		*2.4.0* bumped for 2.4\n		*1.1.0* Added SQLite3 support. Fixes ticket:1783, bump for rc1\n		*1.0.3* Add he_IL translation\n	\";s:8:\"location\";s:35:\"release/2.5/inventorydb-2.5.0.1.tgz\";s:6:\"md5sum\";s:32:\"d58202723720afbc8538b9a5a62cb585\";s:11:\"displayname\";s:9:\"Inventory\";s:5:\"items\";a:1:{s:11:\"inventorydb\";a:4:{s:4:\"name\";s:9:\"Inventory\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:17:\"Third Party Addon\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.5.0.2\";}s:7:\"gabcast\";a:14:{s:7:\"rawname\";s:7:\"gabcast\";s:4:\"name\";s:7:\"Gabcast\";s:7:\"version\";s:7:\"2.5.0.2\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:17:\"Third Party Addon\";s:9:\"menuitems\";a:1:{s:7:\"gabcast\";s:7:\"Gabcast\";}s:9:\"changelog\";s:440:\"\n		*2.5.0.2* localization updates\n		*2.5.0.1* added localization ability\n		*2.5.0* localization fixes\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* add dest registry, fix rnav formating\n		*1.2.5.1* bump for rc1\n		*1.2.5* #2070 fix proper use of script tags\n	  *1.2.4* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.2.3* Add he_IL translation\n		*1.2.2* Fix issue where you were unable to add a channel \n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"location\";s:31:\"release/2.5/gabcast-2.5.0.1.tgz\";s:6:\"md5sum\";s:32:\"14a5c68313c25d48d294b90c13a68401\";s:11:\"displayname\";s:7:\"Gabcast\";s:5:\"items\";a:1:{s:7:\"gabcast\";a:4:{s:4:\"name\";s:7:\"Gabcast\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:17:\"Third Party Addon\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.5.0.2\";}s:4:\"disa\";a:17:{s:7:\"rawname\";s:4:\"disa\";s:4:\"name\";s:4:\"DISA\";s:7:\"version\";s:7:\"2.8.0.2\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:9:\"menuitems\";a:1:{s:4:\"disa\";s:4:\"DISA\";}s:11:\"description\";s:261:\"DISA Allows you \'Direct Inward System Access\'. This gives you the ability to have an option on an IVR that gives you a dial tone, and you\'re able to dial out from the FreePBX machine as if you were connected to a standard extension. It appears as a Destination.\";s:9:\"changelog\";s:1210:\"\n		*2.8.0.2* #4783, #4859\n		*2.8.0.1* #4537\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling errors, localization\n		*2.6.0.0* init tabindex\n		*2.5.1.8* #3457\n		*2.5.1.7* localization updates\n		*2.5.1.6* localizatoin string enclosures\n		*2.5.1.5* #3138 Sqlite3 fixes\n		*2.5.1.4* #3090 replace str_replace with addslashes to better protect all input in sql\n		*2.5.1.3* #3074 play busy and allow another call when trunk reports busy\n		*2.5.1.2* #2996, #3056 allow all numbers to be dialed and update tooltip\n		*2.5.1.1* #2955 check if pinset file exists to avoid warnings\n		*2.5.1* #2922, #2949 allow consecutive calls once DISA is entered\n		*2.5.0* #1784, #2845 tabindex, added delete and add icons\n		*2.4.0.3* #2859 DISA CID not being set on trunks with default trunk CID set\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* #2463 no password cid fix, extension/dest registry, it translation\n		*2.2.3* #2463 Set CID when no pin, added support for Destination Registry\n		*2.2.2.2* #2172 deprecated use of |, changed category\n		*2.2.2.1* bump for rc1\n		*2.2.2* bump so higher that 2.2 branch\n		*2.2*   First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"location\";s:28:\"release/2.8/disa-2.8.0.1.tgz\";s:6:\"md5sum\";s:32:\"922417ae95249fcea824d9c11f895d35\";s:11:\"displayname\";s:4:\"DISA\";s:5:\"items\";a:1:{s:4:\"disa\";a:4:{s:4:\"name\";s:4:\"DISA\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.2\";}s:12:\"announcement\";a:17:{s:7:\"rawname\";s:12:\"announcement\";s:4:\"name\";s:13:\"Announcements\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:723:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling fixes, localization updates\n		*2.6.0.2* #3829\n		*2.6.0.1* #3804\n		*2.6.0.0* localizations, misc\n		*2.5.1.7* localization string enclosures, spelling\n		*2.5.1.6* spelling, localization fixes\n		*2.5.1.5* spelling fixes, Swedish\n		*2.5.1.4* #3196 typo in index\n		*2.5.1.3* #3195, localization fixes, Swedish\n		*2.5.1.2* #3138 Sqlite3 fixes, spellings\n		*2.5.1.1* #2987 sqlite3 install script changes\n		*2.5.1* #2063 Migrate recordings to recording ids\n		*2.5.0* #2845 tabindex\n		*2.4.0.3* #2872 mispelled Announcement\n		*2.4.0.2* #2604, #2843 mal-formed html tag, Russian translations\n		*2.4.0.1* added 2.4.0 dependency\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:119:\"Plays back one of the system recordings (optionally allowing the user to skip it) and then goes to another destination.\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:9:\"menuitems\";a:1:{s:12:\"announcement\";s:13:\"Announcements\";}s:8:\"location\";s:36:\"release/2.7/announcement-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"207446bd5bb1bf185000fe9555885ec4\";s:11:\"displayname\";s:13:\"Announcements\";s:5:\"items\";a:1:{s:12:\"announcement\";a:4:{s:4:\"name\";s:13:\"Announcements\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:15:\"printextensions\";a:16:{s:7:\"rawname\";s:15:\"printextensions\";s:4:\"name\";s:16:\"Print Extensions\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:13:\"Bandwidth.com\";s:7:\"license\";s:5:\"GPLv2\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:130:\"Creates a printable list of extension numbers used throughout the system from all modules that provide an internal callable number\";s:9:\"menuitems\";a:1:{s:15:\"printextensions\";s:16:\"Print Extensions\";}s:9:\"changelog\";s:685:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.4* change fc sort order\n		*2.6.0.3* misc\n		*2.6.0.2* replace Core with Extensions re #3662, sort Extensions first always\n		*2.6.0.1* minor tweaks, localizations\n		*2.6.0.0* add rnav checkboxes to collapse/expand extension sections\n		*2.5.0.3* fixes to get localization working from other module domains\n		*2.5.0.2* formating cleanup, code removed\n		*2.5.0.1* right justify Extension heading\n		*2.5.0* remove directdid (no longer in 2.5), change to provide full PBX extension layout\n		*2.4.0* it translations, bump for 2.4\n		*1.3.2* Fixed uninizialized variable errors, bump for rc1\n		*1.3.1* Add he_IL translation\n	\";s:8:\"location\";s:39:\"release/2.7/printextensions-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"81094d01099d4261dc72759c91f2c065\";s:11:\"displayname\";s:16:\"Print Extensions\";s:5:\"items\";a:1:{s:15:\"printextensions\";a:4:{s:4:\"name\";s:16:\"Print Extensions\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:9:\"blacklist\";a:16:{s:7:\"rawname\";s:9:\"blacklist\";s:4:\"name\";s:9:\"Blacklist\";s:7:\"version\";s:7:\"2.7.0.2\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:9:\"menuitems\";a:1:{s:9:\"blacklist\";s:9:\"Blacklist\";}s:9:\"changelog\";s:1073:\"\n		*2.7.0.2* #4726\n		*2.7.0.1* #4266, #4186\n		*2.7.0.0* localizations\n		*2.6.0.2* #3430\n		*2.6.0.1* Added publisher/lic\n		*2.6.0.0* Added support for Unknown/Blocked CID\n		*2.5.0.5* #3557 and localization updates\n		*2.5.0.4* localization updates\n		*2.5.0.3* #3345, translations\n		*2.5.0.2* Swedish Translations\n		*2.5.0.1* #3100, #3101 changes to work with new inbound route changes and fixes previous bug\n		*2.5.0* #2956 no need to try and splice from-zaptel macros anymore\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* minor fixes, it translations, bumped for 2.4\n		*1.1.4* #2416 Enable Asterisk 1.6+ support\n		*1.1.3.6* #2455 allow + and other valid dial digits\n		*1.1.3.5* changed categories\n		*1.1.3.4* bump for rc1\n		*1.1.3.3* added xml attribute needsenginedb\n		*1.1.3.2* #2070 syntax fix from below\n		*1.1.3.1* #2070 fix proper use of script tags\n		*1.1.3* #2061 fixed to work with Asterisk 1.4 (wait for confirmation of 1)\n		*1.1.2* #1638 remove duplicate of zapateller instruction\n		*1.1.1* Add he_IL translation\n		*1.1* First 2.2 release. Fix minor warnings.\n	\";s:7:\"depends\";a:1:{s:6:\"module\";s:15:\"core ge 2.5.1.2\";}s:8:\"location\";s:33:\"release/2.7/blacklist-2.7.0.2.tgz\";s:6:\"md5sum\";s:32:\"e1612c979ddf37cca977136b06cf57de\";s:11:\"displayname\";s:9:\"Blacklist\";s:5:\"items\";a:1:{s:9:\"blacklist\";a:5:{s:4:\"name\";s:9:\"Blacklist\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;s:13:\"needsenginedb\";s:3:\"yes\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.7.0.2\";}s:9:\"languages\";a:17:{s:7:\"rawname\";s:9:\"languages\";s:4:\"name\";s:9:\"Languages\";s:7:\"version\";s:7:\"2.8.0.2\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:96:\"Adds the ability to changes the language within a call flow and add language attribute to users.\";s:9:\"menuitems\";a:1:{s:9:\"languages\";s:9:\"Languages\";}s:9:\"changelog\";s:747:\"\n	  *2.8.0.2* localization updates\n	  *2.8.0.1* #4353\n	  *2.8.0.0* localizations, dbug statment removed\n	  *2.7.0.2* localizations\n	  *2.7.0.1* re #4004\n		*2.7.0.0* #4004 add language option to inbound routes\n		*2.6.0.0* localizations, misc\n		*2.5.0.6* localization, Swedish\n		*2.5.0.5* #3174 fix validation code\n		*2.5.0.4* #3110, #3138\n		*2.5.0.3* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0.2* fix depends to 2.5.0alpha1\n		*2.5.0.1* r6123 inject macro-user-callerid with required language setting (was hardcoded)\n		*2.5.0* #2845 tabindex\n		*2.4.0.3* #2843 Russian Translation, removal of un-needed code\n		*2.4.0.2* added depends on 2.4.0\n		*2.4.0.1* #2578 use setlanguage to handle changes in Asterisk 1.6\n		*2.4.0* First release of module\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:8:\"location\";s:33:\"release/2.8/languages-2.8.0.1.tgz\";s:6:\"md5sum\";s:32:\"26b0540cdf0a0e73ab45e1a2ac753af4\";s:11:\"displayname\";s:9:\"Languages\";s:5:\"items\";a:1:{s:9:\"languages\";a:4:{s:4:\"name\";s:9:\"Languages\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.2\";}s:9:\"framework\";a:16:{s:7:\"rawname\";s:9:\"framework\";s:4:\"name\";s:17:\"FreePBX Framework\";s:7:\"version\";s:7:\"2.8.1.4\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:9:\"changelog\";s:4083:\"\n		*2.8.1.4* add distro to online checking\n		*2.8.1.3* #4858\n		*2.8.1.2* #4844\n		*2.8.1.1* #4501, send phpversion to online repo, enable versionupgrade to work better\n		*2.8.1.0* #4616, #4693, #4719, #4680\n		*2.8.0.4* #4585, #4587, #4549, #4602, #4603, #4494, #4615 (Security Bug)\n		*2.8.0.3* misc fixes\n		*2.8.0.2* #4245, #4461\n		*2.8.0.1* #4385\n		*2.8.0.0* #4400, #4388, #4185, #4403, #3963, #4411, #4413, #4418\n		*2.8.0rc1.3* #4388, #4389 cleanup\n		*2.8.0rc1.2* #4389\n		*2.8.0rc1.1* #4376, #4381, #4382, #4386\n		*2.8.0rc1.0* #4366, #4354 \n		*2.8.0beta2.4* #4179, #4345, #4331, #4339\n		*2.8.0beta2.3* #4307, #4253, #4311\n		*2.8.0beta2.2* #4307, revert #4306\n		*2.8.0beta2.1* #4256, #4299, #4306\n		*2.8.0beta2.0* #4247, #4264, #4242, #4086, #4183, #4292\n		*2.8.0beta1.3* #4164, #4163, #4106, #4172, #3981, #3914, #3552, #3708, #4134, #4127, #4207, #4188, #4223 Security Vulnerability\n		*2.8.0beta1.2* #4164\n		*2.8.0beta1.1* #4071, #4152, #4158, misc CSS changes\n		*2.8.0beta1.0* bumping to beta\n		*2.8.0.0alpha2.1* #4109, #3375, jquery update to 1.4.2\n		*2.8.0.0alpha2.0* #4110, #4138, #4135, #1798, #4143, #4144\n		*2.8.0.0alpha1.0* #2181, #4110, #3375, #4109, #4123, #4121, #4125, #4126, add jquery.toggleval.js to FreePBX\n		*2.7.0.0* localizations\n		*2.7.0RC1.2* #4068\n		*2.7.0RC1.1* #4057\n		*2.7.0RC1.0* #2839, #3980, #3992, #4024, #4051, #3575\n		*2.7.0beta1.0* #3707, #4007, #3940, #3929, #3974\n		*2.6.0.1* #3971, #3977, #3900, #3987\n		*2.6.0.0* #3885, #3878, #3295, #3883, #3903, #3889\n		*2.6.0RC2.1* #3870\n		*2.6.0RC2.0* #3854\n		*2.6.0RC1.1* #3807, #3843, #3856, #3857\n		*2.6.0RC1.0* #3850, #3837, #3858, #3861, #3678\n		*2.6.0beta2.2* #3840, misc warning fixes\n		*2.6.0beta2.1* #2880, #3291, #3835\n		*2.6.0beta2.0* #3075, #3780, #3559, #3606, #3599, #3642, #3608, #3581, #3266, #3562, #3639, #3305\n		*2.6.0beta1.4* added param to featurecode class function\n		*2.6.0beta1.3* rename moduleauthor to modulepublisher class in css, update CHANGES\n		*2.6.0beta1.2* add sql() def to migration table\n		*2.6.0beta1.1* add trunk migration code to tables.php\n		*2.6.0beta1.0* renamed to beta1\n		*2.6.0beta0.2* packed js library updated\n		*2.6.0beta0.1* changed to pull from 2.6 branch\n		*2.6.0beta0.0* #1957, #3673, #1380, #3680, #3694, #3696, #3698\n		*2.6.0alpha1.2* fix bug introduced from #3660\n		*2.6.0alpha1.1* Friendly Warning re: #3660\n		*2.6.0alpha1.0* Security Vulnerability: #3660; #3324, #3327, #3368, #3380, #3224, #3462, #3446, #3469, #3588, #3592, r7324, #3271, #3449, #3556, #3641, #3513, #3525, #3658, #3490, #3582, #3570, #3264\n		*2.5.1.0* #3271, #3309, localization fixes\n		*2.5.0.1* #2792, #3223, #3225, #3235, #3234, #3242, #3246, #3247, #3248, #3221\n		*2.5.0.0* #3176, #3191, #3204, #3209 - fixes SECURITY VULNERABILITY in CDR Reporting\n		*2.5.0rc3.0* #3145, #3151, #3154, #3155, #3156, #3164, #3166, #3165, #3077, #3170 (DAHDI Support)\n		*2.5.0rc2.4* #3131, #3137 several changes to better cache module data and boost performance of page loads\n		*2.5.0rc2.3* #2750, #3128, #3124, #3134, #3131\n		*2.5.0rc2.2* #3107, #3093, #3090, #3113, $3117\n		*2.5.0rc2.1* #3104 fix some urlencoding/decoding re: #3102 changes\n		*2.5.0rc2.0* #3067, #3086, #3082, #3102\n		*2.5.0rc1.1* published wrong, including rc1.0 additions\n		*2.5.0rc1.0* #2913, #3052 delay_answer schema and CSS fix\n		*2.5.0beta1.2* #3014, #3030, #2992, #3026, #3027\n		*2.5.0beta1.1* #2635, #2792 CDR Reporting pie chart errors, and fix bug introduced by #2963\n		*2.5.0beta1.0* #2854, #2978, #2980, #2981, #2982, #2963, #2985\n		*2.5.0alpha1.2* #2957 fix fatal failure in retrieve_conf from change to splice\n		*2.5.0alpha1.1* #2941, #2924, #1539, #2950, #2944, #2945, #2699, #2686, #2946, #2606, #2772, #2565, #1679\n		*2.5.0alpha1.0* #1628, #1715, #1843, #2497, #2604, #2606, #2609, #2686, #2701, #2703, #2739, #2766, #2777, #2782, #2784, #2793, #2798, #2799, #2809, #2818, #2829, #2843, #2845, #2855, #2862, #2881, #2890, #2891, #2897, #2903, #2910, #2911, #2921, #2924\n		*2.4.0.1* #2843, #2701, #2818, #2784, #2604, #2766, #2798, #2809, #2799, #2685, #2676\n		*2.4.0.0* CHANGELOG TRUNCATED See SVN Repository\n	\";s:11:\"description\";s:115:\"This module provides a facility to install bug fixes to the framework code that is not otherwise housed in a module\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:8:\"location\";s:33:\"release/2.8/framework-2.8.1.3.tgz\";s:6:\"md5sum\";s:32:\"684a3fbb214eda430c1e3b075487480e\";s:11:\"displayname\";s:17:\"FreePBX Framework\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.1.4\";}s:12:\"infoservices\";a:16:{s:7:\"rawname\";s:12:\"infoservices\";s:4:\"name\";s:13:\"Info Services\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:180:\"Provides a number of applications accessible by feature codes: company directory, call trace (last call information), echo test, speaking clock, and speak current extension number.\";s:9:\"changelog\";s:671:\"\n		*2.8.0.0* #4396\n		*2.7.0.0* spelling errors, localizations\n		*2.6.0.1* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.1* localization fixes\n		*2.5.0* localization, Swedish\n		*2.4.0.1* #2731 fix press 0 for operator in directory\n		*2.4.0* bumped for 2.4\n		*1.3.5.2* changed categories\n		*1.3.5.1* bump for rc1\n		*1.3.5* #2145 add waitexten while waiting for user input, and make uninstallable\n		*1.3.4* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.3.3* Fixed SpeakExtension - replaced depricated ${CALLERID} variable\n		*1.3.2* Fixed SpeakExtension - add macro-user-callerid\n		*1.3.1* Improved accuracy of speaking clock\n	\";s:8:\"location\";s:36:\"release/2.7/infoservices-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"ba07f8ef2d9fc8c7575d3b912f18a30f\";s:11:\"displayname\";s:13:\"Info Services\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:11:\"callwaiting\";a:14:{s:7:\"rawname\";s:11:\"callwaiting\";s:4:\"name\";s:12:\"Call Waiting\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:407:\"\n	*2.8.0.0* published 2.8 version\n	*2.7.0.0* localizations\n	*2.6.0.1* Added publisher/lic\n	*2.6.0.0* #3650, #3651, localizations\n	*2.5.0* localization string enclosures\n	*2.4.0* bumped for 2.4\n	*1.1.2.2* changed categories\n	*1.1.2.1* bump for rc1\n	*1.1.2* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n	*1.1.1* Fixed typo Provdes to Provides*\n	*1.1* First release for 2.2\n	\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:46:\"Provides an option to turn on/off call waiting\";s:8:\"location\";s:35:\"release/2.7/callwaiting-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"e58b5ea3f6f34aee8cedf46b5e95f455\";s:11:\"displayname\";s:12:\"Call Waiting\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:16:\"featurecodeadmin\";a:18:{s:7:\"rawname\";s:16:\"featurecodeadmin\";s:4:\"name\";s:18:\"Feature Code Admin\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:9:\"menuitems\";a:1:{s:16:\"featurecodeadmin\";s:13:\"Feature Codes\";}s:8:\"location\";s:40:\"release/2.8/featurecodeadmin-2.8.0.0.tgz\";s:9:\"changelog\";s:885:\"\n		*2.8.0.1* #4617\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.1* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.3* fix for proper core localization\n		*2.5.0.2* #3173 don\'t report conflicting extensions with featurmap codes\n		*2.5.0.1* #2461 Localization now works using i18n from hosting featurecode modules\n		*2.5.0* #2845 tabindex, added ability to define default values in freepbx_featurecodes.conf\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension/dest registry, it translation\n	  *1.0.5.3* changed categories\n	  *1.0.5.2* added canuninstall = no for module admin, bump for rc1\n	  *1.0.5.1* added candisable = no for module admin\n		*1.0.5* Fix install bug with featurecode release\n		*1.0.4* Add support for duplicate feature codes\n		*1.0.3* Add he_IL translation\n		*1.0.2* Fix minor font/display issues\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:6:\"md5sum\";s:32:\"531628f1d9f7e4d09cf4c54bbe40c545\";s:11:\"displayname\";s:18:\"Feature Code Admin\";s:5:\"items\";a:1:{s:16:\"featurecodeadmin\";a:4:{s:4:\"name\";s:13:\"Feature Codes\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:8:\"callback\";a:16:{s:7:\"rawname\";s:8:\"callback\";s:4:\"name\";s:8:\"Callback\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:9:\"menuitems\";a:1:{s:8:\"callback\";s:8:\"Callback\";}s:9:\"changelog\";s:765:\"\n	*2.8.0.0* published 2.8 version\n	*2.7.0.0* localizations\n	*2.6.0.1* #3838\n	*2.6.0.0* localizations, misc\n	*2.5.0.2* #3272 missing callback_check_destinations(), localization fixes\n	*2.5.0.1* Swedish Translations, fix Italian Translations\n	*2.5.0* #2845 tabindex\n	*2.4.0.2* #2843 Russian Translation\n	*2.4.0.1* add 2.4.0 dependency\n	*2.4.0* extension/destination registry, it translations\n	*1.4.2.3* changed categories\n	*1.4.2.2* bump for rc1\n	*1.4.2.1* changed freePBX to FreePBX\n	*1.4.2* merge findmefollow/core extension destinations if any\n	*1.4.1* Moved callback agi script from core to module\n	*1.4.0* SQLite3 support, fixes ticket:1793 (only for FreePBX 2.3)\n	*1.3.1* Add he_IL translation\n	*1.3* Fixed UI errors for new 2.2 look.\n	*1.2* First 2.2 release\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"location\";s:32:\"release/2.7/callback-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"986f3ae3d1eb5061014059870076512b\";s:11:\"displayname\";s:8:\"Callback\";s:5:\"items\";a:1:{s:8:\"callback\";a:4:{s:4:\"name\";s:8:\"Callback\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:7:\"parking\";a:17:{s:7:\"rawname\";s:7:\"parking\";s:4:\"name\";s:11:\"Parking Lot\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:139:\"Manages parking lot extensions and other options.	Parking is a way of putting calls \"on hold\", and then picking them up from any extension.\";s:9:\"menuitems\";a:1:{s:7:\"parking\";s:11:\"Parking Lot\";}s:9:\"changelog\";s:1087:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.2* #3815\n		*2.6.0.1* #3611, #3435, #3317, #3307\n		*2.6.0.0* localizations, misc\n		*2.5.1.3* localization fixes\n		*2.5.1.2* localization fixes\n		*2.5.1.1* #2718 fix orphaned call not going to destination\n		*2.5.1* #2067 change recording to recording id\n		*2.5.0* #2845 tabindex\n		*2.4.0.6* #2604, #2716, #2843 fix mal-formed html tags, localization fix, Russian Translation\n		*2.4.0.5* added depends on 2.4.0\n		*2.4.0.4* removed parkhints on Asterisk 1.2, metermaid already does and this creates undesired hints\n		*2.4.0.3* change to core_conf and features_general_addtional.conf, no more parking_additianal.inc\n		*2.4.0.2* create hints for Asterisk 1.4 and above\n		*2.4.0.1* add parking_conf class, support PARKINGPATCH config\n		*2.4.0* Destination registry, it translation\n		*2.1.2.1* bump for rc1\n		*2.1.2* merge findmefollow/core extension destinations if any\n		*2.1.1* fix pseudo hardcoded path issue (hardcoded form missing global)\n		*2.1* Remove settings on uninstall bug #1597\n		*2.0.2* Add he_IL translation\n	\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:8:\"location\";s:31:\"release/2.7/parking-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"8ac7ee92a4e13a668eaaf3a093e783bc\";s:11:\"displayname\";s:11:\"Parking Lot\";s:5:\"items\";a:1:{s:7:\"parking\";a:4:{s:4:\"name\";s:11:\"Parking Lot\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:6:\"paging\";a:17:{s:7:\"rawname\";s:6:\"paging\";s:4:\"name\";s:19:\"Paging and Intercom\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:9:\"changelog\";s:1118:\"\n		*2.8.0.1* #4359\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.3* #3692\n		*2.6.0.2* added publisher/lic\n		*2.6.0.1* #3734\n		*2.6.0.0* #3448, perf improvments in large page groups\n		*2.5.0.6* localization fixes\n		*2.5.0.5* #3208, localization\n		*2.5.0.4* #3138 Sqlite3 fixes\n		*2.5.0.3* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0.2* #2987, #3008 sqlite3 install script, spelling\n		*2.5.0.1* fix to make sure SIPURI is clear if not default set\n		*2.5.0.0* #2390, #2723 added configurable dial options (so beep can be removed), VXML_URL and any other custom channel variableoption to autoanswer\n		*2.4.0.5* #1939, #2843 Mitel Phone Support, Russian Translation, oldstyle module hooks added\n		*2.4.0.4* #2758 don\'t show intercom instructions when disabled, bogus codes were displayed\n		*2.4.0.3* added depends on 2.4.0\n		*2.4.0.2* small fix so duplicate extension link is displayed when conflicts are found\n		*2.4.0.1* #2559 typo in install script, extra \\\\ needed (you must un-install and re-install or delete paging_autoanswer table entries to take effect)\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:11:\"description\";s:345:\"Allows creation of paging groups to make announcements using the speaker built into most SIP phones. 	Also creates an Intercom feature code that can be used as a prefix to talk directly to one person, as well as optional feature codes to block/allow intercom calls to all users as well as blocking specific users or only allowing specific users.\";s:9:\"menuitems\";a:1:{s:6:\"paging\";s:19:\"Paging and Intercom\";}s:8:\"location\";s:30:\"release/2.8/paging-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"174038268592f2343df09394e9dbeb53\";s:11:\"displayname\";s:19:\"Paging and Intercom\";s:5:\"items\";a:1:{s:6:\"paging\";a:4:{s:4:\"name\";s:19:\"Paging and Intercom\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:7:\"pinsets\";a:16:{s:7:\"rawname\";s:7:\"pinsets\";s:4:\"name\";s:8:\"PIN Sets\";s:7:\"version\";s:7:\"2.8.0.5\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:103:\"Allow creation of lists of PINs (numbers for passwords) that can be used by other modules (eg, trunks).\";s:9:\"changelog\";s:747:\"\n		*2.8.0.5* #4431\n		*2.8.0.4* localization updates\n		*2.8.0.3* #4197\n		*2.8.0.2* #4141\n		*2.8.0.1* #4131\n		*2.8.0.0* #4124 (#4110)\n		*2.7.0.0* localizations\n		*2.6.0.0* misc\n		*2.5.0.1* #3240, #3258\n		*2.5.0* #2845, #2764 tabindex\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* bump for 2.4\n		*1.2.3* #2393 add support for pinless dialing\n		*1.2.2.2* #2172 deprecated use of |\n		*1.2.2.1* bump for rc1\n		*1.2.2* Put None label in menu hook\n		*1.2.1* #1770 added proper uninstall\n		*1.2* Add SQLite3 support, fixes http://freepbx.org/trac/ticket/1778\n		*1.1* Add he_IL translation, add naftali5\'s fixes where pinsets were being lost when moved around.\n		*1.0.11* Stop potential error where a random pinset is appearing when creating a new trunk\n	\";s:9:\"menuitems\";a:1:{s:7:\"pinsets\";s:8:\"PIN Sets\";}s:8:\"location\";s:31:\"release/2.8/pinsets-2.8.0.4.tgz\";s:6:\"md5sum\";s:32:\"1e443da60aa3397e1603863d83d3419d\";s:11:\"displayname\";s:8:\"PIN Sets\";s:5:\"items\";a:1:{s:7:\"pinsets\";a:4:{s:4:\"name\";s:8:\"PIN Sets\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.5\";}s:8:\"daynight\";a:17:{s:7:\"rawname\";s:8:\"daynight\";s:4:\"name\";s:14:\"Day Night Mode\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:134:\"Day / Night control - allows for two destinations to be chosen and provides a feature code		that toggles between the two destinations.\";s:9:\"changelog\";s:1318:\"\n		*2.8.0.0* #4309\n		*2.7.0.0* spelling errors, localizations\n		*2.6.0.2* #3585 custom recordings\n		*2.6.0.1* init tabindex\n		*2.6.0.0* #3650, #3651\n		*2.5.0.12* #3350\n		*2.5.0.11* localization updates\n		*2.5.0.10* #3318 set BLF in GUI\n		*2.5.0.9* localization string enclosures\n		*2.5.0.8* #3215\n		*2.5.0.7* #3214, #3222\n		*2.5.0.6* localization, Swedish\n		*2.5.0.5* #3138 Sqlite3 fixes\n		*2.5.0.4* #2998, #3004 fix link status to timecondition, spelling\n		*2.5.0.3* #2954 hint not getting written fixed\n		*2.5.0.2* #2903, #2882 more changes, depends on 2.5.0\n		*2.5.0.1* #2882: added hook to associated a timecondtion with a daynight mode condtion\n		*2.5.0* change to create feature code for each index, add func_devstate blf\n		*2.4.0.3* #2734 fixed issue creating index with no description made it disapear\n		*2.4.0.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.0.1* #2591 added depends on 2.4.0\n		*2.4.0* extension/dest registry, it translation\n		*1.0.2.4* #2414 fix other unmatched ) syntax error\n		*1.0.2.3* #2414 fix unmatched ) syntax error\n		*1.0.2.2* bump for rc1\n		*1.0.2.1* added xml attribute needsenginedb, fixed some undefined vars\n		*1.0.2* Added red/green color coding of rnav to see current mode\n		*1.0.1* #2047 got day/night reversed\n		*1.0.0* First release for FreePBX 2.3 \n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:9:\"menuitems\";a:1:{s:8:\"daynight\";s:17:\"Day/Night Control\";}s:8:\"location\";s:32:\"release/2.7/daynight-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"db85d5605fd72f43d9f3de8a1166774b\";s:11:\"displayname\";s:14:\"Day Night Mode\";s:5:\"items\";a:1:{s:8:\"daynight\";a:5:{s:4:\"name\";s:17:\"Day/Night Control\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;s:13:\"needsenginedb\";s:3:\"yes\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:13:\"customappsreg\";a:17:{s:7:\"rawname\";s:13:\"customappsreg\";s:4:\"name\";s:19:\"Custom Applications\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:147:\"Registry to add custom extensions and destinations that may be created and used so that the Extensions and Destinations Registry can include these.\";s:9:\"menuitems\";a:2:{s:12:\"customextens\";s:17:\"Custom Extensions\";s:11:\"customdests\";s:19:\"Custom Destinations\";}s:9:\"changelog\";s:660:\"\n		*2.8.0.1* #4618 XSS patch\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.2* localizations\n		*2.6.0.1* localizations, misc\n		*2.6.0.0* stoped harmless php warning msg\n		*2.5.0.4* #3263, localization fixes\n		*2.5.0.3* localizations fixes\n		*2.5.0.2* localization, Swedish\n		*2.5.0.1* #3003 spelling\n		*2.5.0* #2845 tabindex\n		*2.4.0.5* #2843 Russian Translation\n		*2.4.0.4* #2700 block editing of destination field when once other modules are using it\n		*2.4.0.3* added depends on 2.4.0\n		*2.4.0.2* #2558 can\'t edit/del custom extension\n		*2.4.0.1* Fix typo in install script, non-existent primary key\n		*2.4.0* First release of module\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"location\";s:37:\"release/2.8/customappsreg-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"9c35cea0178fdf94d1932f0998d0855e\";s:11:\"displayname\";s:19:\"Custom Applications\";s:5:\"items\";a:2:{s:12:\"customextens\";a:4:{s:4:\"name\";s:17:\"Custom Extensions\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}s:11:\"customdests\";a:4:{s:4:\"name\";s:19:\"Custom Destinations\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:12:\"asterisk-cli\";a:17:{s:7:\"rawname\";s:12:\"asterisk-cli\";s:4:\"name\";s:12:\"Asterisk CLI\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:88:\"Provides an interface allowing you to run a command as if it was typed into Asterisk CLI\";s:9:\"menuitems\";a:1:{s:3:\"cli\";s:12:\"Asterisk CLI\";}s:7:\"depends\";a:1:{s:6:\"engine\";s:8:\"asterisk\";}s:8:\"location\";s:36:\"release/2.7/asterisk-cli-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"23d372f67a86d8e4a6a6f4686085c4b7\";s:9:\"changelog\";s:582:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling fixes, localization updates\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* description added to xml\n		*2.5.0.1* r6547 Swedish Translations\n		*2.5.0* #2917 execute CLI command direct through manager to remove vulnerabilities\n		*2.4.0* 2.4 branch (added IT translations also)\n		*1.1.2.1* bump for rc1\n		*1.1.2* fix syntax error, extra =\n		*1.1.1* #2070 fix proper use of script tags\n		*1.1* #2006 Fixed display on systems with colored asterisk console\n		*1.0* Fixed security issue, first release in 2.2\n		*0.001* Original Release\n	\";s:11:\"displayname\";s:12:\"Asterisk CLI\";s:5:\"items\";a:1:{s:3:\"cli\";a:4:{s:4:\"name\";s:12:\"Asterisk CLI\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:13:\"weakpasswords\";a:17:{s:7:\"rawname\";s:13:\"weakpasswords\";s:4:\"name\";s:23:\"Weak Password Detection\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:15:\"Schmoozecom.com\";s:7:\"license\";s:5:\"GPLv2\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"changelog\";s:321:\"\n		*2.8.0.0* #4309\n		*2.7.0.0* spelling, localizations\n		*2.6.0.1* #3735\n		*2.6.0.0* misc\n		*2.5.0.3* #3663\n		*2.5.0.2* changes to warning msg, moved to Tools tab, System Administration\n		*2.5.0.1* Consolidated individual security notices to a single notice with all details in extended text\n		*2.5.0.0* Initial release\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.5.0\";}s:11:\"description\";s:80:\"This module detects weak SIP secrets and sets security notifications accordingly\";s:9:\"menuitems\";a:1:{s:13:\"weakpasswords\";s:23:\"Weak Password Detection\";}s:8:\"location\";s:37:\"release/2.7/weakpasswords-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"45d3f8eb1856eb7c50b0cc2f959f94b5\";s:11:\"displayname\";s:23:\"Weak Password Detection\";s:5:\"items\";a:1:{s:13:\"weakpasswords\";a:4:{s:4:\"name\";s:23:\"Weak Password Detection\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:10:\"recordings\";a:19:{s:7:\"rawname\";s:10:\"recordings\";s:4:\"name\";s:10:\"Recordings\";s:7:\"version\";s:8:\"3.3.10.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:76:\"Creates and manages system recordings, used by many other modules (eg, IVR).\";s:9:\"changelog\";s:1486:\"\n		*3.3.10.3* #4604 (Security Bug)\n		*3.3.10.2* #4568 Security Patch\n		*3.3.10.1* #4553 Security Patch\n		*3.3.10.0* #4244, #4309\n		*3.3.9.4* localizations\n		*3.3.9.3* #3529\n		*3.3.9.2* #3779\n		*3.3.9.1* localizations, misc\n		*3.3.9.0* #3059, #3604\n		*3.3.8.8* localization fixes, misc\n		*3.3.8.7* #3108, #3138 Sqlite3 fix\n		*3.3.8.6* #3058 really again, use encodeURIComponent() in javascript, and remove urlencoding from crypt function\n		*3.3.8.5* #3058 again, revert crypt.php again\n		*3.3.8.4* #3058 properly display messages for unplayble formats and revert r6234 for crypt.php\n		*3.3.8.3* #2987, #3011, #3036 sqlite3 install, spelling, remove popup.css\n		*3.3.8.2* #2547, #2983 remove access violation so modules dir can be locked down, fix bug in sound file path, add back encryption\n		*3.3.8.1* fixed typo in recordings_list\n		*3.3.8* #2063, #2064, #2065, #2066, #2067, #2068, #2069\n		*3.3.7.1* dependency to 2.5\n		*3.3.7* #2889 add optional feature codes linked to recordings to be able to easily change\n		*3.3.6.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*3.3.6.1* #2591, enhance code so bad directory copy errors are reported\n		*3.3.6* it translations, removed legacy ext-recordings left in error\n		*3.3.5.4* #2426 remove non-functioning download link\n		*3.3.5.3* #2409 syntax error in audio.php could cause playback problems\n		*3.3.5.2* #2016 allow amportal.conf AMPLAYKEY override hardcoded crypt key\n		*3.3.5.1* CHANGELOG TRUNCATED See SVN Repository\n	\";s:9:\"menuitems\";a:1:{s:10:\"recordings\";s:17:\"System Recordings\";}s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:8:\"location\";s:35:\"release/2.8/recordings-3.3.10.2.tgz\";s:6:\"md5sum\";s:32:\"389243d8d7ff97dd2ca3726b604d3d08\";s:11:\"displayname\";s:10:\"Recordings\";s:5:\"items\";a:1:{s:10:\"recordings\";a:4:{s:4:\"name\";s:17:\"System Recordings\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:8:\"3.3.10.3\";}s:12:\"asteriskinfo\";a:17:{s:7:\"rawname\";s:12:\"asteriskinfo\";s:4:\"name\";s:13:\"Asterisk Info\";s:7:\"version\";s:7:\"2.8.0.2\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:57:\"Provides a snapshot of the current Asterisk configuration\";s:9:\"menuitems\";a:1:{s:12:\"asteriskinfo\";s:13:\"Asterisk Info\";}s:7:\"depends\";a:2:{s:6:\"engine\";s:8:\"asterisk\";s:7:\"version\";s:8:\"2.5.0rc3\";}s:9:\"changelog\";s:481:\"\n		*2.8.0.2* localization updates\n		*2.8.0.1* #4209\n		*2.8.0.0* #3703\n		*2.7.0.0* spelling fixes, localization updates\n		*2.6.0.0* localizations, misc\n		*2.5.0.1* #3157, #3153, #3077 (DAHDI Support)\n		*2.5.0* #2845 tabindex\n		*2.4.0.1* #2704 Asterisk 1.6 tweaks\n		*2.4.0* bumped to 2.4\n		*0.3.0.1* bump for rc1\n		*0.3.0* #2187 Fix for Asterisk 1.4\n		*0.2.0* Add depends asterisk xml tag, proper error checking for manager connection, center table titles\n		*0.1.0* Initial release\n	\";s:8:\"location\";s:36:\"release/2.8/asteriskinfo-2.8.0.1.tgz\";s:6:\"md5sum\";s:32:\"87130a9ac7d28dba23114fc4a2676786\";s:11:\"displayname\";s:13:\"Asterisk Info\";s:5:\"items\";a:1:{s:12:\"asteriskinfo\";a:4:{s:4:\"name\";s:13:\"Asterisk Info\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.2\";}s:6:\"fw_ari\";a:16:{s:7:\"rawname\";s:6:\"fw_ari\";s:4:\"name\";s:21:\"FreePBX ARI Framework\";s:7:\"version\";s:7:\"2.8.0.6\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:9:\"changelog\";s:1037:\"\n		*2.8.0.6* #4501\n		*2.8.0.5* #4509, #4134, #4501\n		*2.8.0.4* #4461\n		*2.8.0.3* #4423\n		*2.8.0.2* #4402\n		*2.8.0.1* #4255, #4333\n		*2.8.0.0* #3981, #3914, #3552, #3708, #4134, #4127, #4282, #4254, #4281\n		*2.7.0.1* #4158\n		*2.7.0.0* bumped\n		*2.6.0.3* inlcude js libraries\n		*2.6.0.2* #3382, #3642, #3621\n		*2.6.0.1* changed to pull from 2.6 branch\n		*2.6.0.0* Security Vulnerability: #3660; #3215, #3158, #3416, #3383, #3447\n		*2.5.2.2* #3446, #3540\n		*2.5.2.1* fixes some unreported bugs: r7140, r7235, localization updates\n		*2.5.2.rc1* #3042 remove player popup, embed in page and add call screening settings to phone features\n		*2.5.1.1* #3202, #3203\n		*2.5.1* #3184 SECURITY VULNERABILITY fix\n		*2.5.0.3* #3165, #3077, #2609 and additional fixes related to #3161\n		*2.5.0.2* r6505, #3161 SQL Injection vulnerability that could allow and authenticated user to access all CDRs and recordings\n		*2.5.0.1* remove inclusion of libfreepbx.install.php in install script resulting in warnings\n		*2.5.0* #3104 and First release of fw_ari\n	\";s:11:\"description\";s:202:\"This module provides a facility to install bug fixes to the ARI code that is not otherwise housed in a module, it used to be part of framework but has been removed to isolate ARI from Framework updates.\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:8:\"location\";s:30:\"release/2.8/fw_ari-2.8.0.5.tgz\";s:6:\"md5sum\";s:32:\"2765644f0f37bbeb5e2ef245591c3664\";s:11:\"displayname\";s:21:\"FreePBX ARI Framework\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.6\";}s:12:\"fw_langpacks\";a:14:{s:7:\"rawname\";s:12:\"fw_langpacks\";s:4:\"name\";s:28:\"FreePBX Localization Updates\";s:7:\"version\";s:7:\"2.8.1.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:490:\"\n		*2.8.1.1* language updates\n		*2.8.1.0* language updates\n		*2.8.0.1* language updates\n		*2.8.0.0* more language updates\n		*2.7.0.1* more language updates\n		*2.7.0.0* more language updates\n		*2.6.0.3* more language updates\n		*2.6.0.2* french and other updates\n		*2.6.0.1* updates\n		*2.6.0.0* localization updates\n		*2.5.1.1* Spanish, Italian, Bulgarian, Hungarian updates\n		*2.5.1* Swedish, Russian updates\n		*2.5.0.2* Swedish updates, Russian\n		*2.5.0.1* Swedish\n		*2.5.0* First release\n	\";s:11:\"description\";s:502:\"This module provides a facility to install new and updated localization translations for all components in FreePBX. Localization i18n translations are still kept with each module and other components such as the User Portal (ARI). This provides an easy ability to bring all components up-to-date without the need of publishing dozens of modules for every minor change. The localization updates used will be the latest available for all modules and will not consider the current version you are running.\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:8:\"location\";s:36:\"release/2.8/fw_langpacks-2.8.1.0.tgz\";s:6:\"md5sum\";s:32:\"f4e446d325a98f914e726f5a9a968085\";s:11:\"displayname\";s:28:\"FreePBX Localization Updates\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.1.1\";}s:5:\"music\";a:18:{s:7:\"rawname\";s:5:\"music\";s:4:\"name\";s:13:\"Music on Hold\";s:7:\"version\";s:7:\"2.8.0.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:80:\"Uploading and management of sound files (wav, mp3) to be used for on-hold music.\";s:9:\"changelog\";s:1619:\"\n		*2.8.0.3* #4604 (Security Bug)\n		*2.8.0.2* localization updates\n		*2.8.0.1* #4179\n		*2.8.0.0* #4309, #4310\n		*2.7.0.5* #4261\n		*2.7.0.4* #4157\n		*2.7.0.3* #4111\n		*2.7.0.2* #4087\n		*2.7.0.1* text tweaks\n		*2.7.0.0* #4051 allow moh subdir to be defined\n		*2.6.0.2* localizations\n		*2.6.0.1* 3436\n		*2.6.0.0* added publisher/lic\n		*2.5.1.4* #3711 and localizations\n		*2.5.1.3* #3380, #3443, localization updates\n		*2.5.1.2* #3346\n		*2.5.1.1* #3297, localization changes\n		*2.5.1* #3156 add option to put Streaming Sources as well as downloaded files as music category\n		*2.5.0.1* #3007 spelling\n		*2.5.0* #2773, #2845, #2928, added delete and add icons\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* #2591 localization fixes\n		*2.4.0* it translations, bump for 2.4\n		*1.5.2* #1923 Add option to no encode wav to mp3 (but recode it to 8K samples)\n		*1.5.1.5* #2193 moh path hardcoded\n		*1.5.1.4* bump for rc1\n		*1.5.1.3* #1969 fix javascript validation, add canunninstall:no\n		*1.5.1.2* #2070 fix proper use of script tags\n		*1.5.1.1* added candisable = no for module admin\n		*1.5.1* Added a \'none\' category that results in silence played\n		*1.5* Fixed upload bug, #1646 could not upload files\n		*1.4.2* List wav files\n		*1.4.1* Add redirect_standard() call to avoid #1616\n		*1.4* Fix an issue of a new install not having a working MOH until they visit the page.\n		*1.3.2* Add he_IL translation\n		*1.3.1* Changed name to Music on Hold (from On Hold Music) \n		*1.3* Bumped version to assist upgraders from the 2.1 tree. No other changes.\n		*1.2* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	\";s:9:\"menuitems\";a:1:{s:5:\"music\";s:13:\"Music on Hold\";}s:8:\"location\";s:29:\"release/2.8/music-2.8.0.2.tgz\";s:6:\"md5sum\";s:32:\"7f39d628a922abca3e93bf877ab46500\";s:11:\"displayname\";s:13:\"Music on Hold\";s:5:\"items\";a:1:{s:5:\"music\";a:4:{s:4:\"name\";s:13:\"Music on Hold\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.3\";}s:3:\"fax\";a:17:{s:7:\"rawname\";s:3:\"fax\";s:4:\"name\";s:17:\"Fax Configuration\";s:7:\"version\";s:7:\"2.8.0.5\";s:9:\"publisher\";s:15:\"Schmoozecom.com\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:9:\"menuitems\";a:1:{s:3:\"fax\";s:17:\"Fax Configuration\";}s:11:\"description\";s:55:\"Adds configurations, options and GUI for inbound faxing\";s:9:\"changelog\";s:623:\"\n		*2.8.0.5* various localization cleanup\n		*2.8.0.4* #4326, #4336\n		*2.8.0.3* #4277, #4227\n		*2.8.0.2* #4166\n		*2.8.0.1* #4118\n		*2.8.0.0* #4099, #4117, adjust presentation becasue of #1798\n		*2.7.0.16* #4101, #4112, #4113\n		*2.7.0.15* #4096 (workaround for Asterisk bug in 1.6.2)\n		*2.7.0.14* #4090\n		*2.7.0.13* localizations\n		*2.7.0.12* #4077\n		*2.7.0.11* #4056, #4059\n		*2.7.0.10* #4029, #4046, #4045 again\n		*2.7.0.9* #4045 again\n		*2.7.0.8* #4045\n		*2.7.0.7* #4040\n		*2.7.0.6* #4031\n		*2.7.0.5* #4021\n		*2.7.0.4* #4021\n		*2.7.0.3* #4020\n		*2.7.0.2* #4019\n		*2.7.0.1* #4018\n		*2.7.0.0* Initial reelase: #4007, #4010\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:10:\"2.7.0beta1\";}s:8:\"location\";s:27:\"release/2.8/fax-2.8.0.4.tgz\";s:6:\"md5sum\";s:32:\"87f41681192a5decb2839014c9d4a138\";s:11:\"displayname\";s:17:\"Fax Configuration\";s:5:\"items\";a:1:{s:3:\"fax\";a:4:{s:4:\"name\";s:17:\"Fax Configuration\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.5\";}s:3:\"irc\";a:16:{s:7:\"rawname\";s:3:\"irc\";s:4:\"name\";s:14:\"Online Support\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:7:\"Support\";s:11:\"description\";s:144:\"This module lets you connect to the IRC network where developers and other users chat. You can chat to the developers live, if you have problems\";s:9:\"changelog\";s:568:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling, localizations\n		*2.6.0.0* added publisher/lic\n		*2.5.0.2* remove auto display of kernel info into IRC channel r7432\n		*2.5.0.1* localization updates\n		*2.5.0* localization, Swedish\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* bumped for 2.4\n		*1.1.1.3* change Dcoumentation left nav to Online Resource and fix url\n		*1.1.1.2* bump for rc1\n		*1.1.1.1* #2070 fix proper use of script tags\n		*1.1.1* Add he_IL translation\n		*1.1* First release for 2.2, changed the window so it pops-out of the normal web page\n	\";s:9:\"menuitems\";a:1:{s:3:\"irc\";s:14:\"Online Support\";}s:8:\"location\";s:27:\"release/2.7/irc-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"553797351e5eefd381f40fd37856964a\";s:11:\"displayname\";s:14:\"Online Support\";s:5:\"items\";a:1:{s:3:\"irc\";a:4:{s:4:\"name\";s:14:\"Online Support\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:7:\"Support\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:9:\"cidlookup\";a:17:{s:7:\"rawname\";s:9:\"cidlookup\";s:4:\"name\";s:16:\"Caller ID Lookup\";s:7:\"version\";s:7:\"2.8.0.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:11:\"description\";s:105:\"Allows Caller ID Lookup of incoming calls against different sources (MySQL, HTTP, ENUM, Phonebook Module)\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:9:\"menuitems\";a:1:{s:9:\"cidlookup\";s:23:\"CallerID Lookup Sources\";}s:7:\"depends\";a:2:{s:6:\"engine\";s:12:\"asterisk 1.2\";s:6:\"module\";s:15:\"core ge 2.5.1.2\";}s:8:\"location\";s:33:\"release/2.8/cidlookup-2.8.0.3.tgz\";s:6:\"md5sum\";s:32:\"ba53492fdba4587c0555888cca51689f\";s:9:\"changelog\";s:1299:\"\n	  *2.8.0.3* #4791, one more fix for cache reults\n		*2.8.0.2* #4791\n		*2.8.0.1* #4679\n		*2.8.0.0* update to 2.8\n		*2.7.0.2* #3979\n		*2.7.0.1* might effect #3979\n		*2.7.0.0* localizations\n		*2.6.0.1* #3599, #3821\n		*2.6.0.0* localizations, misc\n		*2.5.0.5* #3345\n		*2.5.0.4* #3260, other localization work\n		*2.5.0.3* localization fixes, Swedish\n		*2.5.0.2* #3100, #3101 changes to work with new inbound route changes and fixes previous bug\n		*2.5.0.1* #2987, #3001 sqlite3 install script and spelling fixes\n		*2.5.0* #2845 tabindex\n		*2.4.0.3* remove cidlookup field from core incoming table - should never have been there\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* #2541 migrate from channel routing and re-enable functionality\n		*2.4.0* it translations, bump for 2.4\n		*1.2.1.3* #2172 deprecated use of |, changed categories\n		*1.2.1.2* bump for rc1\n		*1.2.1.1* shorten menu name\n		*1.2.1* changed freePBX to FreePBX\n		*1.2.0* Added SQLite3 support, fixes ticket:1796 (FreePBX 2.3 only)\n		*1.1.1* Add he_IL translation\n		*1.1* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n		*1.0.4* Updated module.xml format\n		*1.0.3* Fixes from #999\n		*1.0.1* Added possibility to cache in astDB\n			Added lookup from cache before querying external source\n		*1.0.0* First release\n	\";s:11:\"displayname\";s:16:\"Caller ID Lookup\";s:5:\"items\";a:1:{s:9:\"cidlookup\";a:4:{s:4:\"name\";s:23:\"CallerID Lookup Sources\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.3\";}s:11:\"sipsettings\";a:16:{s:7:\"rawname\";s:11:\"sipsettings\";s:4:\"name\";s:21:\"Asterisk SIP Settings\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:13:\"Bandwidth.com\";s:7:\"license\";s:6:\"AGPLv3\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"menuitems\";a:1:{s:11:\"sipsettings\";s:21:\"Asterisk SIP Settings\";}s:11:\"description\";s:278:\"Use to configure Various Asterisk SIP Settings in the General section of sip.conf. Also includes an auto-configuration tool to determine NAT settings. The module assumes Asterisk version 1.4 or higher. Some settings may not exist in Asterisk 1.2 and will be ignored by Asterisk.\";s:9:\"changelog\";s:561:\"\n		*2.8.0.1* #4681\n		*2.8.0.0* published 2.8 version\n		*2.7.0.1* localizations\n		*2.7.0.0* #3976 allows codec priorities\n		*2.6.0.7* #3866\n		*2.6.0.6* #3722, localizations\n		*2.6.0.5* #3831, #3722\n		*2.6.0.4* spelling errors\n		*2.6.0.3* #3814\n		*2.6.0.2* #3808, #3809, #3810\n		*2.6.0.1* corrected publisher/lic\n		*2.6.0.0* localizations, misc\n		*2.6.0beta1.2* install script \'if not exists\' missing\n		*2.6.0beta1.1* misc bugs, typos\n		*2.6.0beta1.0* lots of tweaks, fixed install.php error\n		*2.6.0alpha1.1* Added db\n		*2.6.0alpha1.0* Incomplete screen mockup\n	\";s:8:\"location\";s:35:\"release/2.8/sipsettings-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"4c39e93a6cf0dc280b49b08e1e0ec624\";s:11:\"displayname\";s:21:\"Asterisk SIP Settings\";s:5:\"items\";a:1:{s:11:\"sipsettings\";a:4:{s:4:\"name\";s:21:\"Asterisk SIP Settings\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";s:2:\"-6\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:9:\"speeddial\";a:14:{s:7:\"rawname\";s:9:\"speeddial\";s:4:\"name\";s:20:\"Speed Dial Functions\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:496:\"\n		*2.8.0.1* #4694\n		*2.8.0.0* published 2.8 version\n		*2.7.0.1* localizations, change back to from-internal changed in #3949\n		*2.7.0.0* #3949\n		*2.6.0.0* localizations, misc\n		*2.5.0* #2887\n		*2.4.0* bump for 2.4\n		*1.0.4.2* #2329 add WaitExten after background\n		*1.0.4.1* bump for rc1\n		*1.0.4* #2049 remove use of speedial-clean, allow leading 0s\n		*1.0.3* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.0.2* No comment\n		*1.0.1* First release for 2.2\n	\";s:4:\"type\";s:6:\"module\";s:8:\"category\";s:25:\"CID \n&\n Number Management\";s:7:\"depends\";a:1:{s:6:\"module\";s:9:\"phonebook\";}s:8:\"location\";s:33:\"release/2.8/speeddial-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"458f51f52d12448cf93ca421a96a69ab\";s:11:\"displayname\";s:20:\"Speed Dial Functions\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:9:\"dashboard\";a:19:{s:7:\"rawname\";s:9:\"dashboard\";s:4:\"name\";s:16:\"System Dashboard\";s:7:\"version\";s:7:\"2.8.0.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:5:\"Basic\";s:11:\"description\";s:117:\"Provides a system information dashboard, showing information about Calls, CPU, Memory, Disks, Network, and processes.\";s:9:\"menuitems\";a:2:{s:10:\"dashboard1\";s:21:\"FreePBX System Status\";s:10:\"dashboard2\";s:21:\"FreePBX System Status\";}s:7:\"depends\";a:1:{s:7:\"version\";s:10:\"2.3.0beta2\";}s:9:\"changelog\";s:2072:\"\n		*2.8.0.3* #4474\n		*2.8.0.2* #4175 (better fix)\n		*2.8.0.1* #4175\n		*2.8.0.0* #4268, #4276, #4283\n		*2.7.0.1* #4082, localizations\n		*2.7.0.0* #3547\n		*2.6.0.2* localizations\n		*2.6.0.1* #3226, #3353\n		*2.6.0.0* localizations, misc\n		*2.5.0.7* #3652, localization updates\n		*2.5.0.6* #3409, localization fixes, updates\n		*2.5.0.5* #3404 correction\n		*2.5.0.4* #3401, #3404\n		*2.5.0.3* #3348, localizations\n		*2.5.0.2* localization string enclosures\n		*2.5.0.1* #3170, Swedish Translation\n		*2.5.0* #3134 add amportal DASHBOARD_STATS_UPDATE_TIME, DASHBOARD_INFO_UPDATE_TIME\n		*2.4.0.3* #2871 do not show Sangoma wanpipe interfaces in the Network Stats\n		*2.4.0.2* #2701, #2843 add proper JSON header to fix some proxy servers, Russian Translation\n		*2.4.0.1* #2620 adjust to new format of core_trunks_list(true)\n		*2.4.0* #2415 1.6 support, #2301, it translation\n		*0.3.3.3* #2365 don\'t make readonly disk devices red when 100%\n		*0.3.3.2* #2469 fix division my zero in cpu usage\n		*0.3.3.1* Cosmetic fix (#2278 - long mount point paths)\n		*0.3.3* Improved detection of webserver failing, More MySQL detection fixes\n		*0.3.2.1* #2246 make FreePBX Connections visible, #2250 check for SSHPORT\n		*0.3.2* Allow mysql server to be on another host/port (#2229), fix image path problem\n		*0.3.1* Fix issue with miscounting total registrations, minor styling details\n		*0.3* Show IP phones and trunks separately (#2209)\n		*0.2.5.4* make always accessible even in database mode, fix minor javascript bug\n		*0.2.5.3* remove deprecated javascript call\n		*0.2.5.2* #2194 don\'t fail when Asterisk is not running\n		*0.2.5.1* disable debug logging, make uninstallable\n		*0.2.5* #2142 fix online phones for Asterisk 1.4 format, #2140 divide by 0 again\n		*0.2.4* #2133 again, #2140 divide by 0, #2141 with temp log to determine real issue\n		*0.2.3* #2133 fixed number format error resulting in bogus percentage displays\n		*0.2.2* #2131 fix Undefined Index warnings\n		*0.2.1* make module permanent, should not be able to disable\n		*0.2.0* Add real-time updates\n		*0.1.0* Initial release\n	\";s:8:\"location\";s:33:\"release/2.8/dashboard-2.8.0.2.tgz\";s:6:\"md5sum\";s:32:\"b2c1aac5e0ec24206f89a28bb73ec85a\";s:11:\"displayname\";s:16:\"System Dashboard\";s:5:\"items\";a:2:{s:10:\"dashboard1\";a:6:{s:4:\"name\";s:21:\"FreePBX System Status\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:5:\"Admin\";s:4:\"sort\";s:3:\"-10\";s:7:\"display\";s:5:\"index\";s:6:\"access\";s:3:\"all\";}s:10:\"dashboard2\";a:6:{s:4:\"name\";s:21:\"FreePBX System Status\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Admin\";s:4:\"sort\";s:3:\"-10\";s:7:\"display\";s:5:\"index\";s:6:\"access\";s:3:\"all\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.3\";}s:11:\"outroutemsg\";a:17:{s:7:\"rawname\";s:11:\"outroutemsg\";s:4:\"name\";s:25:\"Route Congestion Messages\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:13:\"Bandwidth.com\";s:7:\"license\";s:5:\"GPLv2\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:11:\"description\";s:154:\"Configures message or congestion tones played when all trunks are busy in a route. Allows different messages for Emergency Routes and Intra-Company Routes\";s:9:\"menuitems\";a:1:{s:11:\"outroutemsg\";s:25:\"Route Congestion Messages\";}s:9:\"changelog\";s:201:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.2* localizations\n		*2.7.0.1* #4042\n		*2.7.0.0* #3805\n		*2.6.0.3* #3865\n		*2.6.0.2* minor tootlip tweaks\n		*2.6.0.1* init tabindex\n		*2.6.0* Initial Version\n	\";s:7:\"depends\";a:1:{s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:8:\"location\";s:35:\"release/2.7/outroutemsg-2.7.0.2.tgz\";s:6:\"md5sum\";s:32:\"0280f70ad7e261b49ceacc2ae8a128bf\";s:11:\"displayname\";s:25:\"Route Congestion Messages\";s:5:\"items\";a:1:{s:11:\"outroutemsg\";a:4:{s:4:\"name\";s:25:\"Route Congestion Messages\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:10:\"customerdb\";a:13:{s:7:\"rawname\";s:10:\"customerdb\";s:4:\"name\";s:11:\"Customer DB\";s:7:\"version\";s:7:\"2.5.0.4\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:17:\"Third Party Addon\";s:9:\"menuitems\";a:1:{s:10:\"customerdb\";s:11:\"Customer DB\";}s:9:\"changelog\";s:288:\"\n		*2.5.0.4* localization updates\n		*2.5.0.3* localization enclosures\n		*2.5.0.2* #2987 sqlite3 install script changes\n		*2.5.0.1* #2781 allow sqlite table creation\n		*2.5.0* #2845 tabindex\n		*2.4.0* it translations, bump for 2.4\n		*1.2.3.1* bump for rc1\n		*1.2.3* Add he_IL translation\n	\";s:8:\"location\";s:34:\"release/2.5/customerdb-2.5.0.3.tgz\";s:6:\"md5sum\";s:32:\"7c2af4ef858ee56de9379ad1b2f51683\";s:11:\"displayname\";s:11:\"Customer DB\";s:5:\"items\";a:1:{s:10:\"customerdb\";a:4:{s:4:\"name\";s:11:\"Customer DB\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:17:\"Third Party Addon\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.5.0.4\";}s:6:\"fw_fop\";a:16:{s:7:\"rawname\";s:6:\"fw_fop\";s:4:\"name\";s:21:\"FreePBX FOP Framework\";s:7:\"version\";s:7:\"2.8.0.6\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:9:\"changelog\";s:470:\"\n		*2.8.0.6* #4602\n		*2.8.0.5* #4429, #4185\n		*2.8.0.4* reverting 2.8.0.3 fixed elsewhere\n		*2.8.0.3* #4388\n		*2.8.0.2* #4381\n		*2.8.0.1* #4269, remove uninitialized variable\n		*2.8.0.0* install script fixes when used with install_amp\n		*2.7.0.0* bumped\n		*2.6.0.3* #3883, #3278, #3295\n		*2.6.0.2* #3740 FOP 0.30 (Asterisk 1.6 compatible)\n		*2.6.0.1* changed to pull from 2.6 branch\n		*2.6.0.0* misc\n		*2.5.0.1* typo in install script\n		*2.5.0* First release of fw_fop\n	\";s:11:\"description\";s:202:\"This module provides a facility to install bug fixes to the FOP code that is not otherwise housed in a module, it used to be part of framework but has been removed to isolate FOP from Framework updates.\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:8:\"location\";s:30:\"release/2.8/fw_fop-2.8.0.5.tgz\";s:6:\"md5sum\";s:32:\"1d1544098f13fc8f644f297299e70d4a\";s:11:\"displayname\";s:21:\"FreePBX FOP Framework\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.6\";}s:10:\"dundicheck\";a:17:{s:7:\"rawname\";s:10:\"dundicheck\";s:4:\"name\";s:21:\"DUNDi Lookup Registry\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:135:\"\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling errors, localizations\n		*2.6.0.0* localizations\n		*2.5.0* #2918 First release\n	\";s:11:\"description\";s:334:\"This module will check all configured and enabled DUNDi trunks as part of the extension registry function, and report back conflicts if		other sites have the same extensions. This does not filter against the route patterns - it will take any number being created and		report a conflict if that trunk could be used to call that number.\";s:4:\"type\";s:4:\"tool\";s:9:\"menuitems\";a:1:{s:10:\"dundicheck\";s:12:\"DUNDi Lookup\";}s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"category\";s:21:\"System Administration\";s:8:\"location\";s:34:\"release/2.7/dundicheck-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"9ec289c1f2a1d07357b2f2b6b00c2386\";s:11:\"displayname\";s:21:\"DUNDi Lookup Registry\";s:5:\"items\";a:1:{s:10:\"dundicheck\";a:4:{s:4:\"name\";s:12:\"DUNDi Lookup\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:3:\"ivr\";a:17:{s:7:\"rawname\";s:3:\"ivr\";s:4:\"name\";s:3:\"IVR\";s:7:\"version\";s:7:\"2.8.0.5\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:221:\"Creates Digital Receptionist (aka Auto-Attendant, aka Interactive Voice Response) menus. These can be used to send callers to different locations (eg, \"Press 1 for sales\") and/or allow direct-dialing of extension numbers.\";s:9:\"changelog\";s:1500:\"\n		*2.8.0.5* localization updates\n		*2.8.0.4* #4309, #4310, #4313\n		*2.8.0.3* #4296\n		*2.8.0.2* #4275, #4286\n		*2.8.0.1* #4257 allow direct extension dialing to Directory \"contexts\"\n		*2.8.0.0* cleanup of IVR based on new drawselects: #1798\n		*2.7.0.2* localizations\n		*2.7.0.1* #4025\n		*2.7.0.0* #3923, #4013\n		*2.6.0.3* #4013\n		*2.6.0.2* #3780\n		*2.6.0.1* #3732\n		*2.6.0.0* #3384, add hook support\n		*2.5.20.5* localization string enclosures\n		*2.5.20.4* #3245, localization fixes\n		*2.5.20.3* localization, Swedish\n		*2.5.20.2* #3188 clear MSG var if no message\n		*2.5.20.1* Sqlite3 fixes, move ivr_init() to install script\n		*2.5.20* #3099 allows a return to IVR from voicemail option and from busy phone\n		*2.5.19.2* #2987, #3005 sqlite3 install script, spelling\n		*2.5.19.1* #2965 not working on IE fixed\n		*2.5.19* #2865 Add alternative messages to play if t or i are hit, replacing the first announcmement\n		*2.5.18.1* #2948 don\'t allow deletion if used by a Queue and show list\n		*2.5.18* #2066 Migrate recordings to recording ids\n		*2.5.17.1* #2845 tabindex\n		*2.5.17* #2858 Better handing of i and t options, added loop count and ability to loop before going to user defined i, t options\n		*2.5.16.3* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.5.16.2* #2687 breakout from Queue to Company Directory blocks voicemail\n		*2.5.16.1* #2591, added depends on 2.4.0\n		*2.5.16* Extension/dest registry, #2303, it translation\n		*2.5.15* CHANGELOG TRUNCATED See SVN Repository\n	\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:9:\"menuitems\";a:1:{s:3:\"ivr\";s:3:\"IVR\";}s:8:\"location\";s:27:\"release/2.8/ivr-2.8.0.4.tgz\";s:6:\"md5sum\";s:32:\"7317b548b34fdaf76cfc0bcc92536837\";s:11:\"displayname\";s:3:\"IVR\";s:5:\"items\";a:1:{s:3:\"ivr\";a:4:{s:4:\"name\";s:3:\"IVR\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.5\";}s:7:\"vmblast\";a:17:{s:7:\"rawname\";s:7:\"vmblast\";s:4:\"name\";s:18:\"VoiceMail Blasting\";s:7:\"version\";s:7:\"2.8.0.2\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:123:\"Creates a group of extensions that calls a group of voicemail boxes and allows you to leave a message for them all at once.\";s:9:\"changelog\";s:1436:\"\n		*2.8.0.2* #4551\n		*2.8.0.1* localization updates\n		*2.8.0.0* #4309, #4310\n		*2.7.0.0* spelling, localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.6* #3697\n		*2.5.0.5* localization updates\n		*2.5.0.4* #3380\n		*2.5.0.3* localization string enclosures\n		*2.5.0.2* #3138, #3165 Sqlite3 fixes\n		*2.5.0.1* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0* #2845 tabindex\n		*2.4.3.3* add oldstyle module hook\n		*2.4.3.2* added depends on 2.4.0\n		*2.4.3.1* #2632 red bar addressed now also\n		*2.4.3* #2632 audio_lable, password, default_group not saved on initial config, and fix odd refresh behavior after add\n		*2.4.2* #2630 fixed errors requiring register_globals=on to be set in php.ini\n		*2.4.1* add beep only, no confirmation option to vmblast audio label\n		*2.4.0* first official version imported into 2.4 branch\n		*1.2.0* change to use proper multi-select list, fix bug in js validation of empty list, add default vmblast group\n		*1.1.2* add vmblast_group table and migrate from old grplist field\n		*1.1.1* fixed a couple SQL bugs, improved dialplan so you can skip annoucement and messages immeditiately (except if saydigits used)\n		*1.1.0* add audio label, password protect, fix bug for javascript validation to work, add extension/dest registry support\n		*1.0.2* increase grouplist field to varchar(255) to increase the vmblast list\n		*1.0.l* fix: context, redisplay of groups, get proper vm contexts, beep before leaving msg\n	\";s:9:\"menuitems\";a:1:{s:7:\"vmblast\";s:18:\"VoiceMail Blasting\";}s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"location\";s:31:\"release/2.8/vmblast-2.8.0.1.tgz\";s:6:\"md5sum\";s:32:\"787b516d6b6fb6313bca20178a268e3c\";s:11:\"displayname\";s:18:\"VoiceMail Blasting\";s:5:\"items\";a:1:{s:7:\"vmblast\";a:4:{s:4:\"name\";s:18:\"VoiceMail Blasting\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.2\";}s:14:\"timeconditions\";a:17:{s:7:\"rawname\";s:14:\"timeconditions\";s:4:\"name\";s:15:\"Time Conditions\";s:7:\"version\";s:7:\"2.8.0.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:238:\"Creates a condition where calls will go to one of two destinations (eg, an extension, IVR, ring group..) based on the time and/or date. This can be used for example to ring a receptionist during the day, or go directly to an IVR at night.\";s:9:\"changelog\";s:1457:\"\n		*2.8.0.3* #4584\n		*2.8.0.2* #4309, #4310\n		*2.8.0.1* #4184\n		*2.8.0.0* #4128 add option to timeconditions_timegroups_drawgroupselect()\n		*2.7.0.0* spelling, localizations, format tweaks\n		*2.6.0.0* localizations, misc\n		*2.5.0.8* #3325 timecondition install script fails going from 2.4 to 2.5\n		*2.5.0.7* localization string enclosures\n		*2.5.0.6* #3222 salite3\n		*2.5.0.5* #3138 Sqlite3 fix, localization fixes\n		*2.5.0.4* #2987, #3012 sqlite3 install script, spelling\n		*2.5.0.3* update initial table creatino for new installs\n		*2.5.0.2* #2936 remove warning when not timegroups present\n		*2.5.0.1* tweaks to timegroups, added delete and add icons\n		*2.5.0* #774, #1695: Merged timegroups and timecondition changes from contributed_modules originally submitted by naftali5\n		*2.4.4.3* #2604, #2765, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.4.2* generate all timeconditions when using database mode authorization and deptarments\n		*2.4.4.1* added depends on 2.4.0\n		*2.4.4* Extension/dest registry, it translation\n		*2.4.3.1* bump for rc1\n		*2.4.3* Added SQLite3 support, fixed ticket http://freepbx.org/trac/ticket/1774\n		*2.4.2* merge findmefollow/core extension destinations if any\n		*2.4.1* Add he_IL translation\n		*2.4* Upgrading module version to assist with trixbox upgrades, that have 2.3.1 already, so this needs to be higher. No other changes.	\n		*2.3* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:9:\"menuitems\";a:2:{s:14:\"timeconditions\";s:15:\"Time Conditions\";s:10:\"timegroups\";s:11:\"Time Groups\";}s:8:\"location\";s:38:\"release/2.8/timeconditions-2.8.0.2.tgz\";s:6:\"md5sum\";s:32:\"c4f903b0fa2c716a556e19bcd88c0c1b\";s:11:\"displayname\";s:15:\"Time Conditions\";s:5:\"items\";a:2:{s:14:\"timeconditions\";a:4:{s:4:\"name\";s:15:\"Time Conditions\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}s:10:\"timegroups\";a:4:{s:4:\"name\";s:11:\"Time Groups\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.3\";}s:10:\"ringgroups\";a:17:{s:7:\"rawname\";s:10:\"ringgroups\";s:4:\"name\";s:11:\"Ring Groups\";s:7:\"version\";s:7:\"2.8.0.3\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:317:\"Creates a group of extensions that all ring together. Extensions can be rung all at once, or in various \'hunt\' configurations. Additionally, external numbers are supported, and there is a call confirmation option where the callee has to confirm if they actually want to take the call before the caller is transferred.\";s:9:\"changelog\";s:1007:\"\n		*2.8.0.3* #4671\n		*2.8.0.2* #4484\n		*2.8.0.1* #4422\n		*2.8.0.0* #4133\n		*2.7.0.2* localizations\n		*2.7.0.1* #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0.0* #4050\n		*2.6.0.1* #3610\n		*2.6.0.0* #3697\n		*2.5.1.9* #3664\n		*2.5.1.8* #3580, localization updates\n		*2.5.1.7* #3380, localization updates\n		*2.5.1.6* localization fixes\n		*2.5.1.5* #3222 sqlite3\n		*2.5.1.4* #3200 and localization fixes\n		*2.5.1.3* #3165 Sqlite3 fix\n		*2.5.1.2* #3000 spelling\n		*2.5.1.1* #2069 Minor bug in change for ids\n		*2.5.1* #2069 Migrate recordings to recording ids\n		*2.5.0.1* changed depends to 2.5\n		*2.5.0* #1795, #2845, #2391, #2853, #2925 add tabindexing, Skip Busy Agent and Ignore Call Forward options\n		*2.4.0.2* #2604, #2843 fix mal-formed html tags, Russian Translation, add oldstyle module hook\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension/dest registry, extension quickpick, added hunt strategy with confirmation, it trans, formatting changes\n		*2.2.16.2* CHANGELOG TRUNCATED See SVN Repository\n	\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:9:\"menuitems\";a:1:{s:10:\"ringgroups\";s:11:\"Ring Groups\";}s:8:\"location\";s:34:\"release/2.8/ringgroups-2.8.0.2.tgz\";s:6:\"md5sum\";s:32:\"283f79fa6c8810d38282dbb3477f6a86\";s:11:\"displayname\";s:11:\"Ring Groups\";s:5:\"items\";a:1:{s:10:\"ringgroups\";a:4:{s:4:\"name\";s:11:\"Ring Groups\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.3\";}s:12:\"findmefollow\";a:17:{s:7:\"rawname\";s:12:\"findmefollow\";s:4:\"name\";s:9:\"Follow Me\";s:7:\"version\";s:7:\"2.8.0.4\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:9:\"changelog\";s:1670:\"\n		*2.8.0.4* #4484\n		*2.8.0.3* #4383\n		*2.8.0.2* #4324\n		*2.8.0.1* #4294\n		*2.8.0.0* version bump\n		*2.7.0.4* localizations\n		*2.7.0.3* #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0.2* debug statement removed\n		*2.7.0.1* #4026\n		*2.7.0.0* #1718\n		*2.6.0.1* #3780\n		*2.6.0.0* localizations, misc\n		*2.5.1.7* #3274, localization string enclosures\n		*2.5.1.6* #3246, #3215, localization fixes\n		*2.5.1.5* #3222 sqlite3\n		*2.5.1.4* localization, Swedish\n		*2.5.1.3* #3177 don\'t auto-add vmbox dest to users with novm\n		*2.5.1.2* #3152, #3165, set voicemail as default dest on new followme\n		*2.5.1.1* #2987, #3006, #3029 sqlite3 install, spelling, cidprefix missing fix\n		*2.5.1* #2065 Migrate recordings to recording ids\n		*2.5.0.1* #2391, #2908, #2845, #1791, added delete and add icons\n		*2.5.0* Add enable/disable featurecode with blf support, new confirmation sound file announces cid availability\n		*2.4.14.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.14.1* added depends on 2.4.0\n		*2.4.14* Extension/dest registry, extension quickpick, added hunt strategy with confirmation, it trans, formatting changes\n		*2.4.13.2* #2193 moh path hardcoded\n		*2.4.13.1* bump for rc1\n		*2.4.13* added xml attribute needsenginedb, #1961 enabled to work with extension numbers leading with 0s\n		*2.4.12.3* #2057 don\'t strip CID prefix if no prefix is being added\n		*2.4.12.2* merge findmefollow/core extension destinations if any, and remove findmefollow destinations as a destination since they are handled by core\n		*2.4.12.1* #2002 IF() statement can\'t handle : in the string and can\'t escape them anyhow\n		*2.4.12* CHANGELOG TRUNCATED See SVN Repository\n	\";s:7:\"depends\";a:2:{s:7:\"version\";s:11:\"2.5.0alpha1\";s:6:\"module\";s:19:\"recordings ge 3.3.8\";}s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:11:\"description\";s:358:\"Much like a ring group, but works on individual extensions. When someone calls the extension, it can be setup to ring for a number of seconds before trying to ring other extensions and/or external numbers, or to ring all at once, or in other various \'hunt\' configurations. Most commonly used to ring someone\'s cell phone if they don\'t answer their extension.\";s:9:\"menuitems\";a:1:{s:12:\"findmefollow\";s:9:\"Follow Me\";}s:8:\"location\";s:36:\"release/2.8/findmefollow-2.8.0.3.tgz\";s:6:\"md5sum\";s:32:\"551aae7647a28d19bcbfc235cc68a986\";s:11:\"displayname\";s:9:\"Follow Me\";s:5:\"items\";a:1:{s:12:\"findmefollow\";a:5:{s:4:\"name\";s:9:\"Follow Me\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:20:\"Inbound Call Control\";s:4:\"sort\";i:0;s:13:\"needsenginedb\";s:3:\"yes\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.4\";}s:9:\"phonebook\";a:16:{s:7:\"rawname\";s:9:\"phonebook\";s:4:\"name\";s:9:\"Phonebook\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:11:\"description\";s:92:\"Provides a phonebook for FreePBX, it can be used as base for Caller ID Lookup and Speed Dial\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"menuitems\";a:1:{s:9:\"phonebook\";s:18:\"Asterisk Phonebook\";}s:8:\"location\";s:33:\"release/2.8/phonebook-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"ffdf8b37f516af8bc48ff968629257e2\";s:9:\"changelog\";s:284:\"\n		*2.8.0.1* #4590\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* localization changes, Swedish\n		*2.5.0.1* #3009 spelling\n		*2.5.0* #1821, #2845 tabindex\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	\";s:11:\"displayname\";s:9:\"Phonebook\";s:5:\"items\";a:1:{s:9:\"phonebook\";a:5:{s:4:\"name\";s:18:\"Asterisk Phonebook\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;s:13:\"needsenginedb\";s:3:\"yes\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:8:\"miscapps\";a:17:{s:7:\"rawname\";s:8:\"miscapps\";s:4:\"name\";s:17:\"Misc Applications\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:11:\"description\";s:105:\"Adds the ability to create feature codes that can go to any FreePBX destination (such as an IVR or queue)\";s:9:\"menuitems\";a:1:{s:8:\"miscapps\";s:17:\"Misc Applications\";}s:9:\"changelog\";s:993:\"\n		*2.8.0.1* #4724\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.3* localization enclosures, spelling\n		*2.5.0.2* spelling, Swedish\n		*2.5.0.1* #3138 Sqlite3 fixes\n		*2.5.0* #2845 tabindex\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension / dest registry, it translation\n		*0.2.3.5* #2305 Feature Status broken\n		*0.2.3.3* fixed some undefined variables, bump for rc1\n		*0.2.3.2* #2177: removed apparently corrupted newline at end of file\n		*0.2.3.1* added proper uninstall, removes any feature codes and then table\n		*0.2.3* #1902 miscapp always sets/pulls default code now regardless of custom override in featurecodes\n		*0.2.2* added SQLite3 support, fixes http://freepbx.org/trac/ticket/1775\n		*0.2.1.1* changed freePBX to FreePBX\n		*0.2.1* merge findmefollow/core extension destinations if any\n		*0.2* Fix bug with adding new apps\n		*0.1.1* Fixed publish location for trunk/2.3 repository\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:8:\"location\";s:32:\"release/2.8/miscapps-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"840d998c92c429a57efd97533b32b97a\";s:11:\"displayname\";s:17:\"Misc Applications\";s:5:\"items\";a:1:{s:8:\"miscapps\";a:4:{s:4:\"name\";s:17:\"Misc Applications\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:9:\"voicemail\";a:17:{s:7:\"rawname\";s:9:\"voicemail\";s:4:\"name\";s:9:\"Voicemail\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:10:\"candisable\";s:2:\"no\";s:12:\"canuninstall\";s:2:\"no\";s:9:\"changelog\";s:1147:\"\n		*2.8.0.0* #4310\n		*2.7.0.1* #4210\n		*2.7.0.0* localizations\n		*2.6.0.2* #3867\n		*2.6.0.1* #3780\n		*2.6.0.0* #1957, localizations, misc\n		*2.5.1.7* #3698\n		*2.5.1.6* localization updates\n		*2.5.1.5* #3399 and language updates\n		*2.5.1.4* localization string enclosures\n		*2.5.1.3* localization fixes\n		*2.5.1.2* #3191 unitialized var, localization\n		*2.5.1.1* #3152 uninitialized variable bug\n		*2.5.1* #3099 allows a return to IVR from voicemail option\n		*2.5.0.2* #3013, #2530 spelling, typo _GLOBALS should be GLOBALS and cleanup display when users/extension conflicts occur\n		*2.5.0.1* #2973 enable javascript to enable/disable voicemail and vmx fields when creating extension\n		*2.5.0* #2754, #2903, #2785, #2647, #2593 Added VmX config, added O extension config, better javascript interactions\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* #2457 vm dial code to vmexten in sip_general_additional.conf, make hooks abort if extension confilct, misc fixes\n		*2.0.3.4* Fix some labeling and make localization friendly\n		*2.0.3.3* #2232 call to VoiceMailMain() need ${AMPUSER} was fixed wrong\n		*2.0.3.2* CHANGELOG TRUNCATED See SVN Repository\n	\";s:11:\"description\";s:69:\"This module allows you to configure Voicemail for a user or extension\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:7:\"depends\";a:1:{s:7:\"version\";s:11:\"2.5.0alpha1\";}s:8:\"location\";s:33:\"release/2.8/voicemail-2.7.0.1.tgz\";s:6:\"md5sum\";s:32:\"548e3ac98bc66302d1b1a935c4ddc271\";s:11:\"displayname\";s:9:\"Voicemail\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:10:\"phpagiconf\";a:16:{s:7:\"rawname\";s:10:\"phpagiconf\";s:4:\"name\";s:13:\"PHPAGI Config\";s:7:\"version\";s:7:\"2.8.0.0\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:9:\"menuitems\";a:1:{s:10:\"phpagiconf\";s:13:\"PHPAGI Config\";}s:7:\"depends\";a:1:{s:6:\"module\";s:15:\"manager ge1.0.4\";}s:9:\"changelog\";s:420:\"\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.0* misc\n		*2.5.0.2* #3191 uninitialized vars\n		*2.5.0.1* #2987 sqlite3 install script\n		*2.5.0* #1779, #2845 tabindex\n		*2.4.0* bump for 2.4\n		*1.2.2* Changed categories\n		*1.2.1* Fixed javascript error, removed unused script, bump for rc1\n		*1.2* Create tmp files in /etc/asterisk, fixes ticket:1910\n		*1.1* Removed old dependancy checking code, first 2.2 release\n	\";s:8:\"location\";s:34:\"release/2.7/phpagiconf-2.7.0.0.tgz\";s:6:\"md5sum\";s:32:\"87eaa3ff591a18e70259d3c830292ed5\";s:11:\"displayname\";s:13:\"PHPAGI Config\";s:5:\"items\";a:1:{s:10:\"phpagiconf\";a:4:{s:4:\"name\";s:13:\"PHPAGI Config\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:21:\"System Administration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.0\";}s:11:\"pbdirectory\";a:16:{s:7:\"rawname\";s:11:\"pbdirectory\";s:4:\"name\";s:19:\"Phonebook Directory\";s:7:\"version\";s:7:\"2.7.0.1\";s:9:\"publisher\";s:7:\"FreePBX\";s:7:\"license\";s:6:\"GPLv2+\";s:4:\"type\";s:4:\"tool\";s:8:\"category\";s:25:\"CID \n&\n Number Management\";s:8:\"location\";s:35:\"release/2.7/pbdirectory-2.7.0.0.tgz\";s:11:\"description\";s:55:\"Provides a dial-by-name directory for phonebook entries\";s:9:\"changelog\";s:502:\"\n		*2.7.0.1* #4237\n		*2.7.0.0* localizations\n		*2.6.0.1* #3468\n		*2.6.0.0* localizations, misc\n		*2.5.0* localization string enclosures\n		*2.4.0.2* removed 2.4.0 requirement possible causing broken module issue\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Destination registry, added missing macro-user-callerid call\n		*0.3.1.2* #2343 pbdirectory script errors\n		*0.3.1.1* bump for rc1\n		*0.3.1* fixed some hard coded paths, requires core modules:  2.3.0beta1.6 or above\n		*0.3* First changelog entry\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.4.0\";}s:12:\"requirements\";a:1:{s:6:\"module\";a:2:{i:0;s:9:\"phonebook\";i:1;s:9:\"speeddial\";}}s:6:\"md5sum\";s:32:\"27ba7dc9af5e5c2a4667eaa907ac25bc\";s:11:\"displayname\";s:19:\"Phonebook Directory\";s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.7.0.1\";}s:7:\"restart\";a:17:{s:7:\"rawname\";s:7:\"restart\";s:4:\"name\";s:18:\"Bulk Phone Restart\";s:7:\"version\";s:7:\"2.8.0.1\";s:9:\"publisher\";s:15:\"Schmoozecom.com\";s:7:\"license\";s:5:\"GPLv2\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:34:\"Internal Options \n&\n Configuration\";s:9:\"changelog\";s:110:\"\n		*2.8.0.1* #4426\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.1* #3912\n		*2.6.0.0* Initial release\n	\";s:7:\"depends\";a:1:{s:7:\"version\";s:5:\"2.5.0\";}s:11:\"description\";s:147:\"This module allows users to restart one or multiple phones that support being restarted via a SIP NOTIFY command through Asterisk\'s sip_notify.conf\";s:9:\"menuitems\";a:1:{s:7:\"restart\";s:13:\"Phone Restart\";}s:8:\"location\";s:31:\"release/2.8/restart-2.8.0.0.tgz\";s:6:\"md5sum\";s:32:\"821fc61510ca203c83e046ddd7bc4322\";s:11:\"displayname\";s:18:\"Bulk Phone Restart\";s:5:\"items\";a:1:{s:7:\"restart\";a:4:{s:4:\"name\";s:13:\"Phone Restart\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:32:\"Internal Options & Configuration\";s:4:\"sort\";i:0;}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.1\";}s:10:\"sipstation\";a:16:{s:7:\"rawname\";s:10:\"sipstation\";s:4:\"name\";s:10:\"SIPSTATION\";s:7:\"version\";s:7:\"2.8.0.8\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:9:\"menuitems\";a:1:{s:10:\"sipstation\";s:10:\"SIPSTATION\";}s:11:\"description\";s:207:\"This module is used to configure, manage and troubleshoot your SIPSTATION(tm) FreePBX.com SIP trunks and DIDs. The license on this source code is NOT GPL Open Source, it is a proprietary Free to Use license.\";s:9:\"publisher\";s:13:\"Bandwidth.com\";s:7:\"license\";s:10:\"COMMERCIAL\";s:9:\"changelog\";s:1346:\"\n		*2.8.0.8* Allows dtmfmode to be set to other valid values, qualify, qualifyfreq, and context to be set/removed differently without errors reported\n		*2.8.0.7* Add remove Trunks and Keys option to SIPSTATION\n		*2.8.0.6* #4448\n		*2.8.0.5* #4310 undefined variables and spelling errors\n		*2.8.0.4* increase ajax and CURL TIMEOUT\n		*2.8.0.3* redefine core_routing_trunk_del and only if extension table is still there\n		*2.8.0.2* switch to new trunk dialrule apis\n		*2.8.0.1* report proper TEMPNOTAVAIL status when server replies with that, minor changes to install script\n		*2.8.0.0* update to use new Outbound Route APIs\n		*2.7.0.0* spelling, localizations\n		*2.6.0.3* add better error warnings when Contact/Network IP are different and not from private IP range\n		*2.6.0.2* bug fix that was not showing warning when Contact IP and Network IP were yellow\n		*2.6.0.1* add more details to noserver error\n		*2.6.0.0* tooltip edits, first release\n		*2.6.0RC1.0* Changed to gw1/gw2 separate registrations\n		*2.6.0beta1.6* collapsable section mods, added failover fields for future use, curl changes\n		*2.6.0beta1.5* css mods, new URL for xml access\n		*2.6.0beta1.4* many more bug fixes and tweaks\n		*2.6.0beta1.3* more status, lots of bug fixes\n		*2.6.0beta1.2* added install script to cleanup potential phantom trunks\n		*2.6.0beta1.1* first release\n	\";s:8:\"location\";s:34:\"release/2.8/sipstation-2.8.0.7.tgz\";s:6:\"md5sum\";s:32:\"2a8478d43a7768c48140b2c57289829e\";s:11:\"displayname\";s:10:\"SIPSTATION\";s:5:\"items\";a:1:{s:10:\"sipstation\";a:4:{s:4:\"name\";s:10:\"SIPSTATION\";s:4:\"type\";s:5:\"setup\";s:8:\"category\";s:5:\"Basic\";s:4:\"sort\";s:2:\"-9\";}}s:6:\"status\";i:2;s:9:\"dbversion\";s:7:\"2.8.0.8\";}}'),('xml',1376884502,'<xml><module>\n	<rawname>infoservices</rawname>\n	<name>Info Services</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Provides a number of applications accessible by feature codes: company directory, call trace (last call information), echo test, speaking clock, and speak current extension number.</description>\n	<changelog>\n		*2.8.0.0* #4396\n		*2.7.0.0* spelling errors, localizations\n		*2.6.0.1* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.1* localization fixes\n		*2.5.0* localization, Swedish\n		*2.4.0.1* #2731 fix press 0 for operator in directory\n		*2.4.0* bumped for 2.4\n		*1.3.5.2* changed categories\n		*1.3.5.1* bump for rc1\n		*1.3.5* #2145 add waitexten while waiting for user input, and make uninstallable\n		*1.3.4* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.3.3* Fixed SpeakExtension - replaced depricated ${CALLERID} variable\n		*1.3.2* Fixed SpeakExtension - add macro-user-callerid\n		*1.3.1* Improved accuracy of speaking clock\n	</changelog>\n	<location>release/2.8/infoservices-2.8.0.0.tgz</location>\n	<md5sum>9e46d8b02a0d66960221862226c9155e</md5sum>\n</module>\n<module>\n	<rawname>weakpasswords</rawname>\n	<name>Weak Password Detection</name>\n	<version>2.8.0.0</version>\n	<publisher>Schmoozecom.com</publisher>\n	<license>GPLv2</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<changelog>\n		*2.8.0.0* #4309\n		*2.7.0.0* spelling, localizations\n		*2.6.0.1* #3735\n		*2.6.0.0* misc\n		*2.5.0.3* #3663\n		*2.5.0.2* changes to warning msg, moved to Tools tab, System Administration\n		*2.5.0.1* Consolidated individual security notices to a single notice with all details in extended text\n		*2.5.0.0* Initial release\n	</changelog>\n	<depends>\n		<version>2.5.0</version>\n	</depends>\n	<description>This module detects weak SIP secrets and sets security notifications accordingly\n	</description>\n	<menuitems>\n		<weakpasswords>Weak Password Detection</weakpasswords>\n	</menuitems>\n	<location>release/2.8/weakpasswords-2.8.0.0.tgz</location>\n	<md5sum>bf04ede9eb3efe0ccf2e71b9569b8013</md5sum>\n</module>\n<module>\n	<rawname>blacklist</rawname>\n	<name>Blacklist</name>\n	<version>2.7.0.2</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<menuitems>\n		<blacklist needsenginedb=\"yes\">Blacklist</blacklist>\n	</menuitems>\n	<changelog>\n		*2.7.0.2* #4726\n		*2.7.0.1* #4266, #4186\n		*2.7.0.0* localizations\n		*2.6.0.2* #3430\n		*2.6.0.1* Added publisher/lic\n		*2.6.0.0* Added support for Unknown/Blocked CID\n		*2.5.0.5* #3557 and localization updates\n		*2.5.0.4* localization updates\n		*2.5.0.3* #3345, translations\n		*2.5.0.2* Swedish Translations\n		*2.5.0.1* #3100, #3101 changes to work with new inbound route changes and fixes previous bug\n		*2.5.0* #2956 no need to try and splice from-zaptel macros anymore\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* minor fixes, it translations, bumped for 2.4\n		*1.1.4* #2416 Enable Asterisk 1.6+ support\n		*1.1.3.6* #2455 allow + and other valid dial digits\n		*1.1.3.5* changed categories\n		*1.1.3.4* bump for rc1\n		*1.1.3.3* added xml attribute needsenginedb\n		*1.1.3.2* #2070 syntax fix from below\n		*1.1.3.1* #2070 fix proper use of script tags\n		*1.1.3* #2061 fixed to work with Asterisk 1.4 (wait for confirmation of 1)\n		*1.1.2* #1638 remove duplicate of zapateller instruction\n		*1.1.1* Add he_IL translation\n		*1.1* First 2.2 release. Fix minor warnings.\n	</changelog>\n	<depends>\n		<module>core ge 2.5.1.2</module>\n	</depends>\n	<location>release/2.8/blacklist-2.7.0.2.tgz</location>\n	<md5sum>1115707d9f8904445f23f8134f1dd93c</md5sum>\n</module>\n<module>\n	<rawname>cidlookup</rawname>\n	<name>Caller ID Lookup</name>\n	<version>2.8.0.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<description>Allows Caller ID Lookup of incoming calls against different sources (MySQL, HTTP, ENUM, Phonebook Module)</description>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<menuitems>\n		<cidlookup>CallerID Lookup Sources</cidlookup>\n	</menuitems>\n	<depends>\n		<engine>asterisk 1.2</engine>\n		<module>core ge 2.5.1.2</module>\n	</depends>\n	<location>release/2.8/cidlookup-2.8.0.3.tgz</location>\n	<md5sum>04f89143e28661ef07894a7af07c8b6c</md5sum>\n	<changelog>\n	  *2.8.0.3* #4791, one more fix for cache reults\n		*2.8.0.2* #4791\n		*2.8.0.1* #4679\n		*2.8.0.0* update to 2.8\n		*2.7.0.2* #3979\n		*2.7.0.1* might effect #3979\n		*2.7.0.0* localizations\n		*2.6.0.1* #3599, #3821\n		*2.6.0.0* localizations, misc\n		*2.5.0.5* #3345\n		*2.5.0.4* #3260, other localization work\n		*2.5.0.3* localization fixes, Swedish\n		*2.5.0.2* #3100, #3101 changes to work with new inbound route changes and fixes previous bug\n		*2.5.0.1* #2987, #3001 sqlite3 install script and spelling fixes\n		*2.5.0* #2845 tabindex\n		*2.4.0.3* remove cidlookup field from core incoming table - should never have been there\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* #2541 migrate from channel routing and re-enable functionality\n		*2.4.0* it translations, bump for 2.4\n		*1.2.1.3* #2172 deprecated use of |, changed categories\n		*1.2.1.2* bump for rc1\n		*1.2.1.1* shorten menu name\n		*1.2.1* changed freePBX to FreePBX\n		*1.2.0* Added SQLite3 support, fixes ticket:1796 (FreePBX 2.3 only)\n		*1.1.1* Add he_IL translation\n		*1.1* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n		*1.0.4* Updated module.xml format\n		*1.0.3* Fixes from #999\n		*1.0.1* Added possibility to cache in astDB\n			Added lookup from cache before querying external source\n		*1.0.0* First release\n	</changelog>\n</module>\n<module>\n	<rawname>featurecodeadmin</rawname>\n	<name>Feature Code Admin</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<type>setup</type>\n	<category>Basic</category>\n	<menuitems>\n		<featurecodeadmin>Feature Codes</featurecodeadmin>\n	</menuitems>\n	<location>release/2.8/featurecodeadmin-2.8.0.1.tgz</location>\n	<changelog>\n		*2.8.0.1* #4617\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.1* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.3* fix for proper core localization\n		*2.5.0.2* #3173 don\'t report conflicting extensions with featurmap codes\n		*2.5.0.1* #2461 Localization now works using i18n from hosting featurecode modules\n		*2.5.0* #2845 tabindex, added ability to define default values in freepbx_featurecodes.conf\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension/dest registry, it translation\n	  *1.0.5.3* changed categories\n	  *1.0.5.2* added canuninstall = no for module admin, bump for rc1\n	  *1.0.5.1* added candisable = no for module admin\n		*1.0.5* Fix install bug with featurecode release\n		*1.0.4* Add support for duplicate feature codes\n		*1.0.3* Add he_IL translation\n		*1.0.2* Fix minor font/display issues\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<md5sum>39a0f68a9846da446dcb81d1c75a11cb</md5sum>\n</module>\n<module>\n	<rawname>manager</rawname>\n	<name>Asterisk API</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<menuitems>\n		<manager>Asterisk API</manager>\n	</menuitems>\n	<changelog>\n		*2.8.0.0* #4309\n		*2.7.0.1* localizations\n		*2.7.0.0* #3884\n		*2.6.0.0* localizations, misc\n		*2.5.0.1* #3191 unitialized vars\n		*2.5.0* #2845 tabindex\n		*2.4.0* it translations\n		*1.3.1* bump for rc1\n		*1.3* Added SQLite3 support, fixes ticket 1776\n		*1.2* Fix UI issues, and \'Array\' message.\n		*1.1* First 2.2 release. Added he_IL support, fixed some warnings.\n	</changelog>\n	<location>release/2.8/manager-2.8.0.0.tgz</location>\n	<md5sum>67307d8388e218f35d845cf167bd790e</md5sum>\n</module>\n<module>\n	<rawname>languages</rawname>\n	<name>Languages</name>\n	<version>2.8.0.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>\n		Adds the ability to changes the language within a call flow and add language attribute to users.\n	</description>\n	<menuitems>\n		<languages>Languages</languages>\n	</menuitems>\n	<changelog>\n	  *2.8.0.3* #5312\n	  *2.8.0.2* localization updates\n	  *2.8.0.1* #4353\n	  *2.8.0.0* localizations, dbug statment removed\n	  *2.7.0.2* localizations\n	  *2.7.0.1* re #4004\n		*2.7.0.0* #4004 add language option to inbound routes\n		*2.6.0.0* localizations, misc\n		*2.5.0.6* localization, Swedish\n		*2.5.0.5* #3174 fix validation code\n		*2.5.0.4* #3110, #3138\n		*2.5.0.3* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0.2* fix depends to 2.5.0alpha1\n		*2.5.0.1* r6123 inject macro-user-callerid with required language setting (was hardcoded)\n		*2.5.0* #2845 tabindex\n		*2.4.0.3* #2843 Russian Translation, removal of un-needed code\n		*2.4.0.2* added depends on 2.4.0\n		*2.4.0.1* #2578 use setlanguage to handle changes in Asterisk 1.6\n		*2.4.0* First release of module\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<location>release/2.8/languages-2.8.0.3.tgz</location>\n	<md5sum>f8c3f4f3362605495ff64a7e25325bba</md5sum>\n</module>\n<module>\n	<rawname>miscapps</rawname>\n	<name>Misc Applications</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>\n		Adds the ability to create feature codes that can go to any FreePBX destination (such as an IVR or queue)\n	</description>\n	<menuitems>\n		<miscapps>Misc Applications</miscapps>\n	</menuitems>\n	<changelog>\n		*2.8.0.1* #4724\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.3* localization enclosures, spelling\n		*2.5.0.2* spelling, Swedish\n		*2.5.0.1* #3138 Sqlite3 fixes\n		*2.5.0* #2845 tabindex\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension / dest registry, it translation\n		*0.2.3.5* #2305 Feature Status broken\n		*0.2.3.3* fixed some undefined variables, bump for rc1\n		*0.2.3.2* #2177: removed apparently corrupted newline at end of file\n		*0.2.3.1* added proper uninstall, removes any feature codes and then table\n		*0.2.3* #1902 miscapp always sets/pulls default code now regardless of custom override in featurecodes\n		*0.2.2* added SQLite3 support, fixes http://freepbx.org/trac/ticket/1775\n		*0.2.1.1* changed freePBX to FreePBX\n		*0.2.1* merge findmefollow/core extension destinations if any\n		*0.2* Fix bug with adding new apps\n		*0.1.1* Fixed publish location for trunk/2.3 repository\n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<location>release/2.8/miscapps-2.8.0.1.tgz</location>\n	<md5sum>d8e9a0d5afbe9f6609bbfacaa0cc8a28</md5sum>\n</module>\n<module>\n	<rawname>callback</rawname>\n	<name>Callback</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<menuitems>\n		<callback>Callback</callback>\n	</menuitems>\n	<changelog>\n	*2.8.0.0* published 2.8 version\n	*2.7.0.0* localizations\n	*2.6.0.1* #3838\n	*2.6.0.0* localizations, misc\n	*2.5.0.2* #3272 missing callback_check_destinations(), localization fixes\n	*2.5.0.1* Swedish Translations, fix Italian Translations\n	*2.5.0* #2845 tabindex\n	*2.4.0.2* #2843 Russian Translation\n	*2.4.0.1* add 2.4.0 dependency\n	*2.4.0* extension/destination registry, it translations\n	*1.4.2.3* changed categories\n	*1.4.2.2* bump for rc1\n	*1.4.2.1* changed freePBX to FreePBX\n	*1.4.2* merge findmefollow/core extension destinations if any\n	*1.4.1* Moved callback agi script from core to module\n	*1.4.0* SQLite3 support, fixes ticket:1793 (only for FreePBX 2.3)\n	*1.3.1* Add he_IL translation\n	*1.3* Fixed UI errors for new 2.2 look.\n	*1.2* First 2.2 release\n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<location>release/2.8/callback-2.8.0.0.tgz</location>\n	<md5sum>3e6acf09530623157a54e159e56c0f76</md5sum>\n</module>\n<module>\n	<rawname>parking</rawname>\n	<name>Parking Lot</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Manages parking lot extensions and other options.\n	Parking is a way of putting calls \"on hold\", and then picking them up from any extension.</description>\n	<menuitems>\n		<parking>Parking Lot</parking>\n	</menuitems>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.2* #3815\n		*2.6.0.1* #3611, #3435, #3317, #3307\n		*2.6.0.0* localizations, misc\n		*2.5.1.3* localization fixes\n		*2.5.1.2* localization fixes\n		*2.5.1.1* #2718 fix orphaned call not going to destination\n		*2.5.1* #2067 change recording to recording id\n		*2.5.0* #2845 tabindex\n		*2.4.0.6* #2604, #2716, #2843 fix mal-formed html tags, localization fix, Russian Translation\n		*2.4.0.5* added depends on 2.4.0\n		*2.4.0.4* removed parkhints on Asterisk 1.2, metermaid already does and this creates undesired hints\n		*2.4.0.3* change to core_conf and features_general_addtional.conf, no more parking_additianal.inc\n		*2.4.0.2* create hints for Asterisk 1.4 and above\n		*2.4.0.1* add parking_conf class, support PARKINGPATCH config\n		*2.4.0* Destination registry, it translation\n		*2.1.2.1* bump for rc1\n		*2.1.2* merge findmefollow/core extension destinations if any\n		*2.1.1* fix pseudo hardcoded path issue (hardcoded form missing global)\n		*2.1* Remove settings on uninstall bug #1597\n		*2.0.2* Add he_IL translation\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<location>release/2.8/parking-2.8.0.0.tgz</location>\n	<md5sum>1455a1102a2458cc25ebaa14fa4ae011</md5sum>\n</module>\n<module>\n	<rawname>speeddial</rawname>\n	<name>Speed Dial Functions</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.1* #4694\n		*2.8.0.0* published 2.8 version\n		*2.7.0.1* localizations, change back to from-internal changed in #3949\n		*2.7.0.0* #3949\n		*2.6.0.0* localizations, misc\n		*2.5.0* #2887\n		*2.4.0* bump for 2.4\n		*1.0.4.2* #2329 add WaitExten after background\n		*1.0.4.1* bump for rc1\n		*1.0.4* #2049 remove use of speedial-clean, allow leading 0s\n		*1.0.3* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.0.2* No comment\n		*1.0.1* First release for 2.2\n	</changelog>\n	<type>module</type>\n	<category>CID &amp; Number Management</category>\n	<depends>\n		<module>phonebook</module>\n	</depends>\n	<location>release/2.8/speeddial-2.8.0.1.tgz</location>\n	<md5sum>fdc32ff3a28992fa69c19d275fe9072e</md5sum>\n</module>\n<module>\n	<rawname>findmefollow</rawname>\n	<name>Follow Me</name>\n	<version>2.8.0.4</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.4* #4484\n		*2.8.0.3* #4383\n		*2.8.0.2* #4324\n		*2.8.0.1* #4294\n		*2.8.0.0* version bump\n		*2.7.0.4* localizations\n		*2.7.0.3* #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0.2* debug statement removed\n		*2.7.0.1* #4026\n		*2.7.0.0* #1718\n		*2.6.0.1* #3780\n		*2.6.0.0* localizations, misc\n		*2.5.1.7* #3274, localization string enclosures\n		*2.5.1.6* #3246, #3215, localization fixes\n		*2.5.1.5* #3222 sqlite3\n		*2.5.1.4* localization, Swedish\n		*2.5.1.3* #3177 don\'t auto-add vmbox dest to users with novm\n		*2.5.1.2* #3152, #3165, set voicemail as default dest on new followme\n		*2.5.1.1* #2987, #3006, #3029 sqlite3 install, spelling, cidprefix missing fix\n		*2.5.1* #2065 Migrate recordings to recording ids\n		*2.5.0.1* #2391, #2908, #2845, #1791, added delete and add icons\n		*2.5.0* Add enable/disable featurecode with blf support, new confirmation sound file announces cid availability\n		*2.4.14.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.14.1* added depends on 2.4.0\n		*2.4.14* Extension/dest registry, extension quickpick, added hunt strategy with confirmation, it trans, formatting changes\n		*2.4.13.2* #2193 moh path hardcoded\n		*2.4.13.1* bump for rc1\n		*2.4.13* added xml attribute needsenginedb, #1961 enabled to work with extension numbers leading with 0s\n		*2.4.12.3* #2057 don\'t strip CID prefix if no prefix is being added\n		*2.4.12.2* merge findmefollow/core extension destinations if any, and remove findmefollow destinations as a destination since they are handled by core\n		*2.4.12.1* #2002 IF() statement can\'t handle : in the string and can\'t escape them anyhow\n		*2.4.12* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Much like a ring group, but works on individual extensions. When someone calls the extension, it can be setup to ring for a number of seconds before trying to ring other extensions and/or external numbers, or to ring all at once, or in other various \'hunt\' configurations. Most commonly used to ring someone\'s cell phone if they don\'t answer their extension.\n	</description>\n	<menuitems>\n		<findmefollow needsenginedb=\"yes\">Follow Me</findmefollow>\n	</menuitems>\n	<location>release/2.8/findmefollow-2.8.0.4.tgz</location>\n	<md5sum>ce7503b6396599df95f3f00d1ccb1723</md5sum>\n</module>\n<module>\n	<rawname>backup</rawname>\n	<name>Backup &amp; Restore</name>\n	<version>2.8.0.7</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>Backup &amp; Restore for your FreePBX environment</description>\n	<menuitems>\n		<backup needsenginedb=\"yes\">Backup &amp; Restore</backup>\n	</menuitems>\n	<depends>\n		<module>core</module>\n	</depends>\n	<changelog>\n		*2.8.0.7* #4463\n		*2.8.0.6* #4371\n		*2.8.0.5* #4079, #4290\n		*2.8.0.4* #4167, set execute prop on ampbackup.php\n		*2.8.0.0* minor fix\n		*2.7.0.5* spelling fixes, localization updates\n		*2.7.0.4* #4081\n		*2.7.0.3* #4064\n		*2.7.0.2* #4061, #4062, #4063\n		*2.7.0.1beta1.2* #1386\n		*2.7.0.1beta1.0* #1386\n		*2.7.0beta1.0* #3982, #3996, #3999\n		*2.6.0.4* #3975 - multipal backup improvements\n		*2.6.0.3* #3839\n		*2.6.0.2* #3577\n		*2.6.0.1* added publisher/lic\n		*2.6.0.0* #3224, #3640\n		*2.5.1.6* localization updates\n		*2.5.1.5* #3323 backup fails if zaptel.conf or dahdi directory not present\n		*2.5.1.4* #3238, spelling\n		*2.5.1.3* description added to xml, Swedish\n		*2.5.1.2* #3077 (DAHDI Support), Swedish Translations\n		*2.5.1.1* spelling\n		*2.5.1* #2987, #2995, #3037 sqlite3 support, removal of retrieve_backup_cron.pl\n		*2.5.0.2* #2743 don\'t delete the current astdb entries if the new astdb.dump is empty\n		*2.5.0.1* #2884 include zaptel.conf in backup\n		*2.5.0* #2889, #2845, #2353, added delete and add icons\n		*2.4.1.1* #2694 display problem with any all selection\n		*2.4.1* #2269 clear several of the astdb objects before restore, and other bug fixes\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<location>release/2.8/backup-2.8.0.7.tgz</location>\n	<md5sum>a5aa612c9d2f456893a635d3ee82790e</md5sum>\n</module>\n<module>\n	<rawname>phonebook</rawname>\n	<name>Phonebook</name>\n	<version>2.8.0.2</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<description>Provides a phonebook for FreePBX, it can be used as base for Caller ID Lookup and Speed Dial</description>\n	<type>tool</type>\n	<category>System Administration</category>\n	<menuitems>\n		<phonebook needsenginedb=\"yes\">Asterisk Phonebook</phonebook>\n	</menuitems>\n	<location>release/2.8/phonebook-2.8.0.2.tgz</location>\n	<md5sum>9675ae94eea0b57433167810eaae14c6</md5sum>\n	<changelog>\n		*2.8.0.2* #5355\n		*2.8.0.1* #4590\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* localization changes, Swedish\n		*2.5.0.1* #3009 spelling\n		*2.5.0* #1821, #2845 tabindex\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n</module>\n<module>\n	<rawname>queues</rawname>\n	<name>Queues</name>\n	<version>2.8.0.4</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Creates a queue where calls are placed on hold and answered on a first-in, first-out basis. Many options are available, including ring strategy for agents, caller announcements, max wait times, etc. \n	</description>\n	<changelog>\n		*2.8.0.4* #4671\n		*2.8.0.3* localization updates\n		*2.8.0.2* #4327\n		*2.8.0.1* #4297\n		*2.8.0.0* #4165, #4187, #4279, #4280, #2203\n		*2.7.0.2* #4120 again fixed typo in variable name\n		*2.7.0.1* #4120, spelling typo\n		*2.7.0.0* #4084, spelling, tooltips changes, localizations\n		*2.7.0beta1.5* #4084, #4068 (support for experimental dial-one)\n		*2.7.0beta1.4* #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0beta1.3* #4048\n		*2.7.0beta1.2* #4038\n		*2.7.0beta1.1* #2085\n		*2.7.0beta1.0* #3594\n		*2.6.0.3* #3945,#3984\n		*2.6.0.2* #3794, #3496, #3562 (with use of USEQUEUESTATE=yes and Asterisk patch: 15168\n		*2.6.0.1* #3044 (add per device queue login/blf enabled toggle feature code)\n		*2.6.0.0* #3546, #2768, #3685, #3686\n		*2.5.4.8* #3664\n		*2.5.4.7* #3618, localization udpates\n		*2.5.4.6* localization updates\n		*2.5.4.5* #3400, #3380, various translations\n		*2.5.4.4* #3242, #3230, localization fixes\n		*2.5.4.3* #3222 sqlite3\n		*2.5.4.2* #3200 and localization string fixes\n		*2.5.4.1* #3171 and localize queues_timeString()\n		*2.5.4* #3138, #3147 add the Queues App n option as Retry alternative, see tooltip\n		*2.5.3* #3098 WARNING: subtle queue behavior might change: set persistenetmembers=yes so dynamic agents are retained on asterisk restarting, and added option for autofill\n		*2.5.2.4* #3069 add queue weight option to queues\n		*2.5.2.3* #3083, setting ringinuse causes transfered call to keep agent as unavailable, removing since it is not needed for FreePBX standard agents\n		*2.5.2.2* #2987, #3010 sqlite3 install script, spelling\n		*2.5.2.1* #2970 periodic-announce message not being configured (re #2068 change)\n		*2.5.2* #2073 add a Queue hold time CID prepend to report how long the caller has been holding\n		*2.5.1* #2068 recordings_id, don\'t list IVRs with compound messages\n		*2.5.0.1* #2875, #2768\n		*2.5.0.0* #2976 Add Optional Regex to filter user agent numbers that they can input\n		*2.4.0.8* #2757 allow spaces and other alphanumeric characters in description\n		*2.4.0.7* #2604, #2707, #2843 fix mal-formed html tags, typo, Russian Translation, add oldstyle module hook\n		*2.4.0.6* added depends on 2.4.0\n		*2.4.0.5* #2637, monitor-join=yes not supported in asterisk 1.6\n		*2.4.0.4* #2636 Queues Options member status allways show No\n		*2.4.0.3* #2579 added strict to joinempty and leavewhenempy, #2627 ringing box ignored\n		*2.4.0.2* #2528 add context = \'ext-queues\' when getting destination statement\n		*2.4.0.1* added out() and outn() to install script\n		*2.4.0* Migration from legacy tables, added queues_conf class, Extension/dest registry, #2282, #2487, it translations\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n		<module>core ge 2.6.0beta1</module>\n	</depends>\n	<menuitems>\n		<queues needsenginedb=\"yes\">Queues</queues>\n	</menuitems>\n	<location>release/2.8/queues-2.8.0.4.tgz</location>\n	<md5sum>9219bd5a354a33cf1442a26f0e73d748</md5sum>\n</module>\n<module>\n	<rawname>versionupgrade</rawname>\n	<name>2.9 Upgrade Tool</name>\n	<version>2.8.0.0</version>\n	<changelog>\n		*2.8.0.0* #5227\n		*2.8.0rc1.0* #4954\n		*2.8.0beta1.0* add function to throttle module_admin available modules\n		*2.8.0beta0.0* update for 2.9 upgrade\n	</changelog>\n	<description>\n		This module allows the current version to be upgraded to the next major version. For example, if the current version is 2.7.X it will bump up to the latest 2.8.X version available after finsished. Using an example of 2.7.0 as the current version, it provides a button that will bump up the major version number to 2.8.0alpha0 which has the effect of directing Module Admin to use the 2.8 repository. Doing such will then allow the user to upgrade all require modules and framework to enable 2.8. Installing the module is safe and will provide more details about how to upgrade. You will have ample opportunity to decide if you want to do the upgrade after installation.\n	</description>\n	<type>tool</type>\n	<menuitems>\n		<versionupgrade1 display=\"versionupgrade\" type=\"tool\" category=\"Admin\" sort=\"10\">2.9 Upgrade Tool</versionupgrade1>\n		<versionupgrade2 display=\"versionupgrade\" type=\"setup\" category=\"Admin\" sort=\"10\">2.9 Upgrade Tool</versionupgrade2>\n	</menuitems>\n	<depends>\n		<version>lt 2.9.0alpha1</version>\n		<version>ge 2.8.1</version>\n		<module>framework ge 2.8.1.1</module>\n		<module>fw_ari</module>\n		<module>fw_fop</module>\n	</depends>\n	<category>Basic</category>\n	<location>release/2.8/versionupgrade-2.8.0.0.tgz</location>\n	<md5sum>13da2fd1580e2a6c67c981b816ff894e</md5sum>\n</module>\n<module>\n	<rawname>irc</rawname>\n	<name>Online Support</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>Support</category>\n	<description>This module lets you connect to the IRC network where developers and other users chat. You can chat to the developers live, if you have problems</description>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling, localizations\n		*2.6.0.0* added publisher/lic\n		*2.5.0.2* remove auto display of kernel info into IRC channel r7432\n		*2.5.0.1* localization updates\n		*2.5.0* localization, Swedish\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* bumped for 2.4\n		*1.1.1.3* change Dcoumentation left nav to Online Resource and fix url\n		*1.1.1.2* bump for rc1\n		*1.1.1.1* #2070 fix proper use of script tags\n		*1.1.1* Add he_IL translation\n		*1.1* First release for 2.2, changed the window so it pops-out of the normal web page\n	</changelog>\n	<menuitems>\n		<irc>Online Support</irc>\n	</menuitems>\n	<location>release/2.8/irc-2.8.0.0.tgz</location>\n	<md5sum>7c592fb1bf68581d3a7c1a910a3acc4f</md5sum>\n</module>\n<module>\n	<rawname>timeconditions</rawname>\n	<name>Time Conditions</name>\n	<version>2.8.0.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Creates a condition where calls will go to one of two destinations (eg, an extension, IVR, ring group..) based on the time and/or date. This can be used for example to ring a receptionist during the day, or go directly to an IVR at night.\n	</description>\n	<changelog>\n		*2.8.0.3* #4584\n		*2.8.0.2* #4309, #4310\n		*2.8.0.1* #4184\n		*2.8.0.0* #4128 add option to timeconditions_timegroups_drawgroupselect()\n		*2.7.0.0* spelling, localizations, format tweaks\n		*2.6.0.0* localizations, misc\n		*2.5.0.8* #3325 timecondition install script fails going from 2.4 to 2.5\n		*2.5.0.7* localization string enclosures\n		*2.5.0.6* #3222 salite3\n		*2.5.0.5* #3138 Sqlite3 fix, localization fixes\n		*2.5.0.4* #2987, #3012 sqlite3 install script, spelling\n		*2.5.0.3* update initial table creatino for new installs\n		*2.5.0.2* #2936 remove warning when not timegroups present\n		*2.5.0.1* tweaks to timegroups, added delete and add icons\n		*2.5.0* #774, #1695: Merged timegroups and timecondition changes from contributed_modules originally submitted by naftali5\n		*2.4.4.3* #2604, #2765, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.4.2* generate all timeconditions when using database mode authorization and deptarments\n		*2.4.4.1* added depends on 2.4.0\n		*2.4.4* Extension/dest registry, it translation\n		*2.4.3.1* bump for rc1\n		*2.4.3* Added SQLite3 support, fixed ticket http://freepbx.org/trac/ticket/1774\n		*2.4.2* merge findmefollow/core extension destinations if any\n		*2.4.1* Add he_IL translation\n		*2.4* Upgrading module version to assist with trixbox upgrades, that have 2.3.1 already, so this needs to be higher. No other changes.	\n		*2.3* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<menuitems>\n		<timeconditions>Time Conditions</timeconditions>\n		<timegroups>Time Groups</timegroups>\n	</menuitems>\n	<location>release/2.8/timeconditions-2.8.0.3.tgz</location>\n	<md5sum>ff6985224514d32833b8c94ca95581d1</md5sum>\n</module>\n<module>\n	<rawname>announcement</rawname>\n	<name>Announcements</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling fixes, localization updates\n		*2.6.0.2* #3829\n		*2.6.0.1* #3804\n		*2.6.0.0* localizations, misc\n		*2.5.1.7* localization string enclosures, spelling\n		*2.5.1.6* spelling, localization fixes\n		*2.5.1.5* spelling fixes, Swedish\n		*2.5.1.4* #3196 typo in index\n		*2.5.1.3* #3195, localization fixes, Swedish\n		*2.5.1.2* #3138 Sqlite3 fixes, spellings\n		*2.5.1.1* #2987 sqlite3 install script changes\n		*2.5.1* #2063 Migrate recordings to recording ids\n		*2.5.0* #2845 tabindex\n		*2.4.0.3* #2872 mispelled Announcement\n		*2.4.0.2* #2604, #2843 mal-formed html tag, Russian translations\n		*2.4.0.1* added 2.4.0 dependency\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Plays back one of the system recordings (optionally allowing the user to skip it) and then goes to another destination.\n	</description>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<menuitems>\n		<announcement>Announcements</announcement>\n	</menuitems>\n	<location>release/2.8/announcement-2.8.0.0.tgz</location>\n	<md5sum>639d8e88a8405d382c7de6a1c1e4fe72</md5sum>\n</module>\n<module>\n	<rawname>voicemail</rawname>\n	<name>Voicemail</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<changelog>\n		*2.8.0.0* #4310\n		*2.7.0.1* #4210\n		*2.7.0.0* localizations\n		*2.6.0.2* #3867\n		*2.6.0.1* #3780\n		*2.6.0.0* #1957, localizations, misc\n		*2.5.1.7* #3698\n		*2.5.1.6* localization updates\n		*2.5.1.5* #3399 and language updates\n		*2.5.1.4* localization string enclosures\n		*2.5.1.3* localization fixes\n		*2.5.1.2* #3191 unitialized var, localization\n		*2.5.1.1* #3152 uninitialized variable bug\n		*2.5.1* #3099 allows a return to IVR from voicemail option\n		*2.5.0.2* #3013, #2530 spelling, typo _GLOBALS should be GLOBALS and cleanup display when users/extension conflicts occur\n		*2.5.0.1* #2973 enable javascript to enable/disable voicemail and vmx fields when creating extension\n		*2.5.0* #2754, #2903, #2785, #2647, #2593 Added VmX config, added O extension config, better javascript interactions\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* #2457 vm dial code to vmexten in sip_general_additional.conf, make hooks abort if extension confilct, misc fixes\n		*2.0.3.4* Fix some labeling and make localization friendly\n		*2.0.3.3* #2232 call to VoiceMailMain() need ${AMPUSER} was fixed wrong\n		*2.0.3.2* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<description>This module allows you to configure Voicemail for a user or extension</description>\n	<type>setup</type>\n	<category>Basic</category>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<location>release/2.8/voicemail-2.8.0.0.tgz</location>\n	<md5sum>8e1259c0192146aa1ead4512d56efa8b</md5sum>\n</module>\n<module>\n	<rawname>customappsreg</rawname>\n	<name>Custom Applications</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>\n		Registry to add custom extensions and destinations that may be created and used so that the Extensions and Destinations Registry can include these.\n	</description>\n	<menuitems>\n		<customextens>Custom Extensions</customextens>\n		<customdests>Custom Destinations</customdests>\n	</menuitems>\n	<changelog>\n		*2.8.0.1* #4618 XSS patch\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.2* localizations\n		*2.6.0.1* localizations, misc\n		*2.6.0.0* stoped harmless php warning msg\n		*2.5.0.4* #3263, localization fixes\n		*2.5.0.3* localizations fixes\n		*2.5.0.2* localization, Swedish\n		*2.5.0.1* #3003 spelling\n		*2.5.0* #2845 tabindex\n		*2.4.0.5* #2843 Russian Translation\n		*2.4.0.4* #2700 block editing of destination field when once other modules are using it\n		*2.4.0.3* added depends on 2.4.0\n		*2.4.0.2* #2558 can\'t edit/del custom extension\n		*2.4.0.1* Fix typo in install script, non-existent primary key\n		*2.4.0* First release of module\n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<location>release/2.8/customappsreg-2.8.0.1.tgz</location>\n	<md5sum>3ba3b0db0e334dd265a05f6d945c5ba0</md5sum>\n</module>\n<module>\n	<rawname>callwaiting</rawname>\n	<name>Call Waiting</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n	*2.8.0.0* published 2.8 version\n	*2.7.0.0* localizations\n	*2.6.0.1* Added publisher/lic\n	*2.6.0.0* #3650, #3651, localizations\n	*2.5.0* localization string enclosures\n	*2.4.0* bumped for 2.4\n	*1.1.2.2* changed categories\n	*1.1.2.1* bump for rc1\n	*1.1.2* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n	*1.1.1* Fixed typo Provdes to Provides*\n	*1.1* First release for 2.2\n	</changelog>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Provides an option to turn on/off call waiting</description>\n	<location>release/2.8/callwaiting-2.8.0.0.tgz</location>\n	<md5sum>a50329330a78595cd992d7fc48efe517</md5sum>\n</module>\n<module>\n	<rawname>dundicheck</rawname>\n	<name>DUNDi Lookup Registry</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling errors, localizations\n		*2.6.0.0* localizations\n		*2.5.0* #2918 First release\n	</changelog>\n	<description>\n		This module will check all configured and enabled DUNDi trunks as part of the extension registry function, and report back conflicts if\n		other sites have the same extensions. This does not filter against the route patterns - it will take any number being created and\n		report a conflict if that trunk could be used to call that number.\n	</description>\n	<type>tool</type>\n	<menuitems>\n		<dundicheck>DUNDi Lookup</dundicheck>\n	</menuitems>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<category>System Administration</category>\n	<location>release/2.8/dundicheck-2.8.0.0.tgz</location>\n	<md5sum>c4bd2ce010ed24bceae5bc8eae453bd3</md5sum>\n</module>\n<module>\n	<rawname>disa</rawname>\n	<name>DISA</name>\n	<version>2.8.0.2</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<menuitems>\n		<disa>DISA</disa>\n	</menuitems>\n	<description>DISA Allows you \'Direct Inward System Access\'. This gives you the ability to have an option on an IVR that gives you a dial tone, and you\'re able to dial out from the FreePBX machine as if you were connected to a standard extension. It appears as a Destination.</description>\n	<changelog>\n		*2.8.0.2* #4783, #4859\n		*2.8.0.1* #4537\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling errors, localization\n		*2.6.0.0* init tabindex\n		*2.5.1.8* #3457\n		*2.5.1.7* localization updates\n		*2.5.1.6* localizatoin string enclosures\n		*2.5.1.5* #3138 Sqlite3 fixes\n		*2.5.1.4* #3090 replace str_replace with addslashes to better protect all input in sql\n		*2.5.1.3* #3074 play busy and allow another call when trunk reports busy\n		*2.5.1.2* #2996, #3056 allow all numbers to be dialed and update tooltip\n		*2.5.1.1* #2955 check if pinset file exists to avoid warnings\n		*2.5.1* #2922, #2949 allow consecutive calls once DISA is entered\n		*2.5.0* #1784, #2845 tabindex, added delete and add icons\n		*2.4.0.3* #2859 DISA CID not being set on trunks with default trunk CID set\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* #2463 no password cid fix, extension/dest registry, it translation\n		*2.2.3* #2463 Set CID when no pin, added support for Destination Registry\n		*2.2.2.2* #2172 deprecated use of |, changed category\n		*2.2.2.1* bump for rc1\n		*2.2.2* bump so higher that 2.2 branch\n		*2.2*   First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<location>release/2.8/disa-2.8.0.2.tgz</location>\n	<md5sum>52b54db899abd04c17b96cb499f43302</md5sum>\n</module>\n<module>\n	<rawname>asteriskinfo</rawname>\n	<name>Asterisk Info</name>\n	<version>2.8.0.2</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>\n		Provides a snapshot of the current Asterisk configuration\n	</description>\n	<menuitems>\n		<asteriskinfo>Asterisk Info</asteriskinfo>\n	</menuitems>\n	<depends>\n		<engine>asterisk</engine>\n		<version>2.5.0rc3</version>\n	</depends>\n	<changelog>\n		*2.8.0.2* localization updates\n		*2.8.0.1* #4209\n		*2.8.0.0* #3703\n		*2.7.0.0* spelling fixes, localization updates\n		*2.6.0.0* localizations, misc\n		*2.5.0.1* #3157, #3153, #3077 (DAHDI Support)\n		*2.5.0* #2845 tabindex\n		*2.4.0.1* #2704 Asterisk 1.6 tweaks\n		*2.4.0* bumped to 2.4\n		*0.3.0.1* bump for rc1\n		*0.3.0* #2187 Fix for Asterisk 1.4\n		*0.2.0* Add depends asterisk xml tag, proper error checking for manager connection, center table titles\n		*0.1.0* Initial release\n	</changelog>\n	<location>release/2.8/asteriskinfo-2.8.0.2.tgz</location>\n	<md5sum>6ae5dfd4441ab0f1f8ecd62a5c43cf3c</md5sum>\n</module>\n<module>\n	<rawname>callforward</rawname>\n	<name>Call Forward</name>\n	<version>2.8.0.4</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.4* #4578\n		*2.8.0.3* #4294\n		*2.8.0.2* #4114, #4115, #3605\n		*2.8.0.1* #4214\n		*2.8.0.0* #4116, #4105 again\n		*2.7.0.2* #4103, #4104, #4105\n		*2.7.0.1* localizations\n		*2.7.0.0* #4047 CF toggle + devstate and hint additions\n		*2.6.0.1* Added publisher/lic\n		*2.6.0.0* #3650, #3651, localizations\n		*2.5.0.1* localization fixes\n		*2.5.0* localization fixes, Swedish\n		*2.4.0* bumped for 2.4\n		*1.1.2* #2321 fixed CF AMPUSER(number) issue, syntax problem\n		*1.1.1.2* changed categories\n		*1.1.1.1* bump for rc1\n		*1.1.1* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.1* First release for 2.2\n	</changelog>\n	<description>Provides callforward featurecodes</description>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<location>release/2.8/callforward-2.8.0.4.tgz</location>\n	<md5sum>0cacfa87351b837c639a63ce8cd0d788</md5sum>\n</module>\n<module>\n	<rawname>paging</rawname>\n	<name>Paging and Intercom</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<changelog>\n		*2.8.0.1* #4359\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.3* #3692\n		*2.6.0.2* added publisher/lic\n		*2.6.0.1* #3734\n		*2.6.0.0* #3448, perf improvments in large page groups\n		*2.5.0.6* localization fixes\n		*2.5.0.5* #3208, localization\n		*2.5.0.4* #3138 Sqlite3 fixes\n		*2.5.0.3* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0.2* #2987, #3008 sqlite3 install script, spelling\n		*2.5.0.1* fix to make sure SIPURI is clear if not default set\n		*2.5.0.0* #2390, #2723 added configurable dial options (so beep can be removed), VXML_URL and any other custom channel variableoption to autoanswer\n		*2.4.0.5* #1939, #2843 Mitel Phone Support, Russian Translation, oldstyle module hooks added\n		*2.4.0.4* #2758 don\'t show intercom instructions when disabled, bogus codes were displayed\n		*2.4.0.3* added depends on 2.4.0\n		*2.4.0.2* small fix so duplicate extension link is displayed when conflicts are found\n		*2.4.0.1* #2559 typo in install script, extra \\\\ needed (you must un-install and re-install or delete paging_autoanswer table entries to take effect)\n		*2.4.0* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<description>Allows creation of paging groups to make announcements using the speaker built into most SIP phones. \n	Also creates an Intercom feature code that can be used as a prefix to talk directly to one person, as well as optional feature codes to block/allow intercom calls to all users as well as blocking specific users or only allowing specific users.</description>\n	<menuitems>\n		<paging>Paging and Intercom</paging>\n	</menuitems>\n	<location>release/2.8/paging-2.8.0.1.tgz</location>\n	<md5sum>5edee9e5e357cf5c6fa029c978de4a2e</md5sum>\n</module>\n<module>\n	<rawname>fw_fop</rawname>\n	<name>FreePBX FOP Framework</name>\n	<version>2.8.0.7</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<changelog>\n		*2.8.0.7* #4482, #5713 XSS Security Vulnerability\n		*2.8.0.6* #4602\n		*2.8.0.5* #4429, #4185\n		*2.8.0.4* reverting 2.8.0.3 fixed elsewhere\n		*2.8.0.3* #4388\n		*2.8.0.2* #4381\n		*2.8.0.1* #4269, remove uninitialized variable\n		*2.8.0.0* install script fixes when used with install_amp\n		*2.7.0.0* bumped\n		*2.6.0.3* #3883, #3278, #3295\n		*2.6.0.2* #3740 FOP 0.30 (Asterisk 1.6 compatible)\n		*2.6.0.1* changed to pull from 2.6 branch\n		*2.6.0.0* misc\n		*2.5.0.1* typo in install script\n		*2.5.0* First release of fw_fop\n	</changelog>\n	<description>\n		This module provides a facility to install bug fixes to the FOP code that is not otherwise housed in a module, it used to be part of framework but has been removed to isolate FOP from Framework updates.\n	</description>\n	<type>setup</type>\n	<category>Basic</category>\n	<location>release/2.8/fw_fop-2.8.0.7.tgz</location>\n	<md5sum>2a5bae58ea234e3b74037f5a588dc3ac</md5sum>\n</module>\n<module>\n	<rawname>sipsettings</rawname>\n	<name>Asterisk SIP Settings</name>\n	<version>2.8.0.1</version>\n	<publisher>Bandwidth.com</publisher>\n	<license>AGPLv3</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<menuitems>\n		<sipsettings sort=\"-6\">Asterisk SIP Settings</sipsettings>\n	</menuitems>\n	<description>\n		Use to configure Various Asterisk SIP Settings in the General section of sip.conf. Also includes an auto-configuration tool to determine NAT settings. The module assumes Asterisk version 1.4 or higher. Some settings may not exist in Asterisk 1.2 and will be ignored by Asterisk.\n	</description>\n	<changelog>\n		*2.8.0.1* #4681\n		*2.8.0.0* published 2.8 version\n		*2.7.0.1* localizations\n		*2.7.0.0* #3976 allows codec priorities\n		*2.6.0.7* #3866\n		*2.6.0.6* #3722, localizations\n		*2.6.0.5* #3831, #3722\n		*2.6.0.4* spelling errors\n		*2.6.0.3* #3814\n		*2.6.0.2* #3808, #3809, #3810\n		*2.6.0.1* corrected publisher/lic\n		*2.6.0.0* localizations, misc\n		*2.6.0beta1.2* install script \'if not exists\' missing\n		*2.6.0beta1.1* misc bugs, typos\n		*2.6.0beta1.0* lots of tweaks, fixed install.php error\n		*2.6.0alpha1.1* Added db\n		*2.6.0alpha1.0* Incomplete screen mockup\n	</changelog>\n	<location>release/2.8/sipsettings-2.8.0.1.tgz</location>\n	<md5sum>d451ea494718f51cbb4c3cb747b17b0e</md5sum>\n</module>\n<module>\n	<rawname>recordings</rawname>\n	<name>Recordings</name>\n	<version>3.3.10.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Creates and manages system recordings, used by many other modules (eg, IVR).</description>\n	<changelog>\n		*3.3.10.3* #4604 (Security Bug)\n		*3.3.10.2* #4568 Security Patch\n		*3.3.10.1* #4553 Security Patch\n		*3.3.10.0* #4244, #4309\n		*3.3.9.4* localizations\n		*3.3.9.3* #3529\n		*3.3.9.2* #3779\n		*3.3.9.1* localizations, misc\n		*3.3.9.0* #3059, #3604\n		*3.3.8.8* localization fixes, misc\n		*3.3.8.7* #3108, #3138 Sqlite3 fix\n		*3.3.8.6* #3058 really again, use encodeURIComponent() in javascript, and remove urlencoding from crypt function\n		*3.3.8.5* #3058 again, revert crypt.php again\n		*3.3.8.4* #3058 properly display messages for unplayble formats and revert r6234 for crypt.php\n		*3.3.8.3* #2987, #3011, #3036 sqlite3 install, spelling, remove popup.css\n		*3.3.8.2* #2547, #2983 remove access violation so modules dir can be locked down, fix bug in sound file path, add back encryption\n		*3.3.8.1* fixed typo in recordings_list\n		*3.3.8* #2063, #2064, #2065, #2066, #2067, #2068, #2069\n		*3.3.7.1* dependency to 2.5\n		*3.3.7* #2889 add optional feature codes linked to recordings to be able to easily change\n		*3.3.6.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*3.3.6.1* #2591, enhance code so bad directory copy errors are reported\n		*3.3.6* it translations, removed legacy ext-recordings left in error\n		*3.3.5.4* #2426 remove non-functioning download link\n		*3.3.5.3* #2409 syntax error in audio.php could cause playback problems\n		*3.3.5.2* #2016 allow amportal.conf AMPLAYKEY override hardcoded crypt key\n		*3.3.5.1* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<menuitems>\n		<recordings>System Recordings</recordings>\n	</menuitems>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<location>release/2.8/recordings-3.3.10.3.tgz</location>\n	<md5sum>7745dd18c1ae5c6f8f502fc86216ebf2</md5sum>\n</module>\n<module>\n	<rawname>restart</rawname>\n	<name>Bulk Phone Restart</name>\n	<version>2.8.0.1</version>\n	<publisher>Schmoozecom.com</publisher>\n	<license>GPLv2</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<changelog>\n		*2.8.0.1* #4426\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.1* #3912\n		*2.6.0.0* Initial release\n	</changelog>\n	<depends>\n		<version>2.5.0</version>\n	</depends>\n	<description>This module allows users to restart one or multiple phones that support being restarted via a SIP NOTIFY command through Asterisk\'s sip_notify.conf \n	</description>\n	<menuitems>\n		<restart>Phone Restart</restart>\n	</menuitems>\n	<location>release/2.8/restart-2.8.0.1.tgz</location>\n	<md5sum>9c5a52ea7969e972e33b99d36d6fd099</md5sum>\n</module>\n<module>\n	<rawname>sipstation</rawname>\n	<name>SIPSTATION</name>\n	<version>2.8.0.8</version>\n	<type>setup</type>\n	<category>Basic</category>\n	<menuitems>\n		<sipstation sort=\"-9\">SIPSTATION</sipstation>\n	</menuitems>\n	<description>\n		This module is used to configure, manage and troubleshoot your SIPSTATION(tm) FreePBX.com SIP trunks and DIDs. The license on this source code is NOT GPL Open Source, it is a proprietary Free to Use license.\n	</description>\n	<publisher>Bandwidth.com</publisher>\n	<license>COMMERCIAL</license>\n	<changelog>\n		*2.8.0.8* Allows dtmfmode to be set to other valid values, qualify, qualifyfreq, and context to be set/removed differently without errors reported\n		*2.8.0.7* Add remove Trunks and Keys option to SIPSTATION\n		*2.8.0.6* #4448\n		*2.8.0.5* #4310 undefined variables and spelling errors\n		*2.8.0.4* increase ajax and CURL TIMEOUT\n		*2.8.0.3* redefine core_routing_trunk_del and only if extension table is still there\n		*2.8.0.2* switch to new trunk dialrule apis\n		*2.8.0.1* report proper TEMPNOTAVAIL status when server replies with that, minor changes to install script\n		*2.8.0.0* update to use new Outbound Route APIs\n		*2.7.0.0* spelling, localizations\n		*2.6.0.3* add better error warnings when Contact/Network IP are different and not from private IP range\n		*2.6.0.2* bug fix that was not showing warning when Contact IP and Network IP were yellow\n		*2.6.0.1* add more details to noserver error\n		*2.6.0.0* tooltip edits, first release\n		*2.6.0RC1.0* Changed to gw1/gw2 separate registrations\n		*2.6.0beta1.6* collapsable section mods, added failover fields for future use, curl changes\n		*2.6.0beta1.5* css mods, new URL for xml access\n		*2.6.0beta1.4* many more bug fixes and tweaks\n		*2.6.0beta1.3* more status, lots of bug fixes\n		*2.6.0beta1.2* added install script to cleanup potential phantom trunks\n		*2.6.0beta1.1* first release\n	</changelog>\n	<location>release/2.8/sipstation-2.8.0.8.tgz</location>\n	<md5sum>3170e69ddeae5b4d81f55ff351fe8c71</md5sum>\n</module>\n<module>\n	<rawname>logfiles</rawname>\n	<name>Asterisk Logfiles</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.1* #3978\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.1* #3763, #3978\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* #3645\n		*2.5.0.1* localization updates\n		*2.5.0* #2776: filter out potentially bad html tags from log file\n		*2.4.0* bumped for 2.4\n		*1.1.1* bump for rc1\n		*1.1.0* #1442 remove access problem and have log display in same window\n		*1.0.2* #2070 fix proper use of script tags\n	</changelog>\n	<type>tool</type>\n	<category>Support</category>\n	<menuitems>\n		<logfiles>Asterisk Logfiles</logfiles>\n	</menuitems>\n	<location>release/2.8/logfiles-2.8.0.1.tgz</location>\n	<md5sum>9c21e419a297dbeab6ffce81814daea1</md5sum>\n</module>\n<module>\n	<rawname>dashboard</rawname>\n	<name>System Dashboard</name>\n	<version>2.8.0.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<type>tool</type>\n	<category>Basic</category>\n	<description>\n		Provides a system information dashboard, showing information about Calls, CPU, Memory, Disks, Network, and processes.\n	</description>\n	<menuitems>\n		<dashboard1 display=\"index\" type=\"tool\" category=\"Admin\" sort=\"-10\" access=\"all\">FreePBX System Status</dashboard1>\n		<dashboard2 display=\"index\" type=\"setup\" category=\"Admin\" sort=\"-10\" access=\"all\">FreePBX System Status</dashboard2>\n	</menuitems>\n	<depends>\n		<version>2.3.0beta2</version>\n	</depends>\n	<changelog>\n		*2.8.0.3* #4474\n		*2.8.0.2* #4175 (better fix)\n		*2.8.0.1* #4175\n		*2.8.0.0* #4268, #4276, #4283\n		*2.7.0.1* #4082, localizations\n		*2.7.0.0* #3547\n		*2.6.0.2* localizations\n		*2.6.0.1* #3226, #3353\n		*2.6.0.0* localizations, misc\n		*2.5.0.7* #3652, localization updates\n		*2.5.0.6* #3409, localization fixes, updates\n		*2.5.0.5* #3404 correction\n		*2.5.0.4* #3401, #3404\n		*2.5.0.3* #3348, localizations\n		*2.5.0.2* localization string enclosures\n		*2.5.0.1* #3170, Swedish Translation\n		*2.5.0* #3134 add amportal DASHBOARD_STATS_UPDATE_TIME, DASHBOARD_INFO_UPDATE_TIME\n		*2.4.0.3* #2871 do not show Sangoma wanpipe interfaces in the Network Stats\n		*2.4.0.2* #2701, #2843 add proper JSON header to fix some proxy servers, Russian Translation\n		*2.4.0.1* #2620 adjust to new format of core_trunks_list(true)\n		*2.4.0* #2415 1.6 support, #2301, it translation\n		*0.3.3.3* #2365 don\'t make readonly disk devices red when 100%\n		*0.3.3.2* #2469 fix division my zero in cpu usage\n		*0.3.3.1* Cosmetic fix (#2278 - long mount point paths)\n		*0.3.3* Improved detection of webserver failing, More MySQL detection fixes\n		*0.3.2.1* #2246 make FreePBX Connections visible, #2250 check for SSHPORT\n		*0.3.2* Allow mysql server to be on another host/port (#2229), fix image path problem\n		*0.3.1* Fix issue with miscounting total registrations, minor styling details\n		*0.3* Show IP phones and trunks separately (#2209)\n		*0.2.5.4* make always accessible even in database mode, fix minor javascript bug\n		*0.2.5.3* remove deprecated javascript call\n		*0.2.5.2* #2194 don\'t fail when Asterisk is not running\n		*0.2.5.1* disable debug logging, make uninstallable\n		*0.2.5* #2142 fix online phones for Asterisk 1.4 format, #2140 divide by 0 again\n		*0.2.4* #2133 again, #2140 divide by 0, #2141 with temp log to determine real issue\n		*0.2.3* #2133 fixed number format error resulting in bogus percentage displays\n		*0.2.2* #2131 fix Undefined Index warnings\n		*0.2.1* make module permanent, should not be able to disable\n		*0.2.0* Add real-time updates\n		*0.1.0* Initial release\n	</changelog>\n	<location>release/2.8/dashboard-2.8.0.3.tgz</location>\n	<md5sum>4c54ae88df6b93bc319e9cfd7de96bea</md5sum>\n</module>\n<module>\n	<rawname>core</rawname>\n	<type>setup</type>\n	<category>Basic</category>\n	<name>Core</name>\n	<version>2.8.1.2</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<changelog>\n		*2.8.1.2* #5468\n		*2.8.1.1* #4576, #5006, #5011, #5109, #5314\n		*2.8.1.0* bump to 2.8.1 to match framework base\n		*2.8.0.8* #4749 (Avoid Asterisk Security Vulnerability)\n		*2.8.0.7* #4689, #4697, #4730\n		*2.8.0.6* #4634, #4453, #4563\n		*2.8.0.5* #4549, #4615 (Security Bug)\n		*2.8.0.4* #4574, #4572, #4575\n		*2.8.0.3* #4401, #4525, #4507, #4499\n		*2.8.0.2* #4443, #4444, #4460, #4414\n		*2.8.0.1* #4426\n		*2.8.0.0* #4396\n		*2.8.0.0RC1.4* #4390\n		*2.8.0.0RC1.3* #4380\n		*2.8.0.0RC1.2* #4379 again\n		*2.8.0.0RC1.1* #4378, #4379\n		*2.8.0.0RC1.0* #4374\n		*2.8.0.0beta2.4* #4350, #4357\n		*2.8.0.0beta2.3* #4338\n		*2.8.0.0beta2.2* #4309, remove legacy directory settings if no IVRs using them\n		*2.8.0.0beta2.1* #4293\n		*2.8.0.0beta2.0* #4273, #4230, #4242, #4196, #3519, #4288, #4270, #4219\n		*2.8.0.0beta1.9* #4205, #4208, #4155, #4212\n		*2.8.0.0beta1.8* #4202\n		*2.8.0.0beta1.7* #4174, #4190, #4201, #4161\n		*2.8.0.0beta1.6* #4181, #4184\n		*2.8.0.0beta1.5* #4155\n		*2.8.0.0beta1.4* #4071, #4152, #4156, #4159, #4160\n		*2.8.0.0beta1.3* #4151\n		*2.8.0.0beta1.2* #4146, #4148, triming local changelog\n		*2.8.0.0beta1.1* #4132, #2833, #4068, #4135, #4143, #4144\n		*2.8.0.0beta1.0* #4100, #4102, #4110 New Outbound Routing Schema and features\n		*2.7.0.2* really fix #4092\n		*2.7.0.1* #4093, #4094, #4095, #4092\n		*2.7.0.0* minor tweaks\n		*2.7.0RC1.5* #4075, #4078, #4080, #4053\n		*2.7.0RC1.4* #4072\n		*2.7.0RC1.3* #4068, (#4069 available but not used)\n		*2.7.0RC1.2* #4067\n		*2.7.0RC1.1* #4058, #4065, #4066\n		*2.7.0RC1.0* #4041, #4042, #4047, #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0beta1.3* #4037\n		*2.7.0beta1.2* #3993 (#3934, #3889)\n		*2.7.0beta1.1* #4020, #2389, #3980, #3992, #3939, #333, #3721, #3185\n		*2.7.0beta1.0* #3882, #4000, #1718, #3927, #3805, #4007, #3998, #3951, sql injections fixes\n		*2.6.0.1* #3889 reverted, #3900, #3962, #2787, #3793, #3377, #3386, #3717\n		*2.6.0.0* #3889, #3919\n		*2.6.0RC2.1* #3886, #3885, #3875 revisited\n		*2.6.0RC2.0* #3854, #3872, #3871, #3877\n		*2.6.0RC1.1* #3751\n		*2.6.0RC1.0* #3529, #3864, #3538\n		*2.6.0beta2.2* #3722, #3848, #3841, #3700\n		*2.6.0beta2.1* #3844 (revert #3423), #3846, #3849\n		*2.6.0beta2.0* #3075, #3501, #3636, #3581, #3266, #3701, #3545, #3430, #3798, #3609, #3836\n		*2.6.0beta1.3* trunk tab improvements\n		*2.6.0beta1.2* added more sql escape in devices\n		*2.6.0beta1.1* #3696, (needs framework updated), #3702, #3706, #3712, #3691, #3693, #3705, #3644, #3739, #3741, #3744, #3790 \n		*2.6.0beta1.0* #3478, #3423, #3648, #3685, #3686, #1380\n		*2.6.0alpha1.4* fixes re #3649\n		*2.6.0alpha1.3* #3653, #3591, #3650\n		*2.6.0alpha1.2* #3451, $932, #3426, #3474, #3439, #3526, #3534, $3648, #3649, #3517 moved macro-vm to auto-generation (WARNING: custom modification of macro-vm in extensions_custom.conf need to be moved to extensions_override_freepbx.conf\n		*2.6.0alpha1.1* #3380, #3358, #3387, localizations\n		*2.6.0alpha1.0* #3321, #3328, #3345 inbound CID routing fix, adds vm-callme voicemail access option\n		*2.5* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<depends>\n		<version>2.6.0beta1</version>\n	</depends>\n	<requirements>\n		<file>/usr/sbin/asterisk</file>\n	</requirements>\n	<menuitems>\n		<extensions needsenginedb=\"yes\" sort=\"-4\">Extensions</extensions>\n		<users needsenginedb=\"yes\" sort=\"-3\">Users</users>\n		<devices needsenginedb=\"yes\" sort=\"-4\">Devices</devices>\n		<did category=\"Inbound Call Control\" sort=\"-5\">Inbound Routes</did>\n		<zapchandids category=\"Inbound Call Control\" sort=\"-5\">Zap Channel DIDs</zapchandids>\n		<routing>Outbound Routes</routing>\n		<trunks>Trunks</trunks>\n		<general>General Settings</general>\n		<ampusers sort=\"5\">Administrators</ampusers>\n		<wiki type=\"tool\" category=\"Support\" sort=\"5\" href=\"http://freepbx.org\" target=\"_blank\" access=\"all\">FreePBX Support</wiki>\n	</menuitems>\n	<location>release/2.8/core-2.8.1.2.tgz</location>\n	<md5sum>d02b5ea5872c49d77187798f6827b8ee</md5sum>\n</module>\n<module>\n	<rawname>phpagiconf</rawname>\n	<name>PHPAGI Config</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<menuitems>\n		<phpagiconf>PHPAGI Config</phpagiconf>\n	</menuitems>\n	<depends>\n		<module>manager ge1.0.4</module>\n	</depends> \n	<changelog>\n		*2.8.0.0* #4309\n		*2.7.0.0* localizations\n		*2.6.0.0* misc\n		*2.5.0.2* #3191 uninitialized vars\n		*2.5.0.1* #2987 sqlite3 install script\n		*2.5.0* #1779, #2845 tabindex\n		*2.4.0* bump for 2.4\n		*1.2.2* Changed categories\n		*1.2.1* Fixed javascript error, removed unused script, bump for rc1\n		*1.2* Create tmp files in /etc/asterisk, fixes ticket:1910\n		*1.1* Removed old dependancy checking code, first 2.2 release\n	</changelog>\n	<location>release/2.8/phpagiconf-2.8.0.0.tgz</location>\n	<md5sum>1930c42275efc4552d9409adebf70e2f</md5sum>\n</module>\n<module>\n	<rawname>queueprio</rawname>\n	<name>Queue Priorities</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Adds the ability to set a callers priority higher before entering a queue\n	</description>\n	<menuitems>\n		<queueprio>Queue Priorities</queueprio>\n	</menuitems>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.1* #3654\n		*2.6.0.0* misc\n		*2.5.0.4* #3246, #3254\n		*2.5.0.3* #3214\n		*2.5.0.2* #3110, #3138 Sqlite3 fixes\n		*2.5.0.1* #2845 tabindex\n		*2.5.0* First release of module\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<location>release/2.8/queueprio-2.8.0.0.tgz</location>\n	<md5sum>95ed9a3628ac612e25c805bde5baddd3</md5sum>\n</module>\n<module>\n	<rawname>fax</rawname>\n	<name>Fax Configuration</name>\n	<version>2.8.0.5</version>\n	<publisher>Schmoozecom.com</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Basic</category>\n	<menuitems>\n		<fax>Fax Configuration</fax>\n	</menuitems>\n	<description>Adds configurations, options and GUI for inbound faxing</description>\n	<changelog>\n		*2.8.0.5* various localization cleanup\n		*2.8.0.4* #4326, #4336\n		*2.8.0.3* #4277, #4227\n		*2.8.0.2* #4166\n		*2.8.0.1* #4118\n		*2.8.0.0* #4099, #4117, adjust presentation becasue of #1798\n		*2.7.0.16* #4101, #4112, #4113\n		*2.7.0.15* #4096 (workaround for Asterisk bug in 1.6.2)\n		*2.7.0.14* #4090\n		*2.7.0.13* localizations\n		*2.7.0.12* #4077\n		*2.7.0.11* #4056, #4059\n		*2.7.0.10* #4029, #4046, #4045 again\n		*2.7.0.9* #4045 again\n		*2.7.0.8* #4045\n		*2.7.0.7* #4040\n		*2.7.0.6* #4031\n		*2.7.0.5* #4021\n		*2.7.0.4* #4021\n		*2.7.0.3* #4020\n		*2.7.0.2* #4019\n		*2.7.0.1* #4018\n		*2.7.0.0* Initial reelase: #4007, #4010\n	</changelog>\n	<depends>\n		<version>2.7.0beta1</version>\n	</depends>\n	<location>release/2.8/fax-2.8.0.5.tgz</location>\n	<md5sum>d25a580c4b1a3760d7e7a1c6eb52cb2e</md5sum>\n</module>\n<module>\n	<rawname>donotdisturb</rawname>\n	<name>Do-Not-Disturb (DND)</name>\n	<version>2.7.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.7.0.1* #4294\n		*2.7.0.0* localizations\n	  *2.6.0.1* Added publisher/lic\n		*2.6.0.0* #3650, #3651\n		*2.5.0.5* #3274\n		*2.5.0.4* #3215, localization fixes\n		*2.5.0.3* localization, xml description, Swedish\n		*2.5.0.2* #2969 change default value to *76\n		*2.5.0.1* #2909 Add DND hints\n		*2.5.0* added toggle and support for func_devstate\n		*2.4.0* bunp for 2.4\n		*1.0.2.2* changed category\n		*1.0.2.1* bump for rc1\n		*1.0.2* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.0.1* First release for 2.2\n	</changelog>\n	<description>Provides donotdisturb featurecodes</description>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<location>release/2.8/donotdisturb-2.7.0.1.tgz</location>\n	<md5sum>9515658bf86bbaaffa080420c9e9c52b</md5sum>\n</module>\n<module>\n	<rawname>directory</rawname>\n	<name>Directory</name>\n	<version>2.8.0.4</version>\n	<publisher>Schmoozecom.com</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<menuitems>\n		<directory>Directory</directory>\n	</menuitems>\n	<depends>\n		<version>2.8.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<changelog>\n	*2.8.0.4* #4711\n	*2.8.0.3* #4750\n	*2.8.0.2* #4591\n	*2.8.0.1* #4614\n	*2.8.0.0* #4502\n	*2.8.0rc1.0* proper sounds files added\n	*2.8.0beta1.5* #4367, localization changes\n	*2.8.0beta1.4* #4365\n	*2.8.0beta1.3* #4360, #4361\n	*2.8.0beta1.2* #4147, #4310, #4318\n	*2.8.0beta1.1* #4298\n	*2.8.0beta1.0* #4291, various fixeS\n	*2.8.0alpha1.4* #4272, and additional AGI tweaks\n	*2.8.0alpha1.3* #4267, add announce extension, other tuning\n	*2.8.0alpha1.2* js/cosmetic changes\n	*2.8.0.0alpha1.1* fix broken vm greeting, hacky list of how many choices were found\n	*2.8.0.0alpha1.0* Schema changes requiring uninstall/reinstall, many enhancements and fixes\n	*2.8.0.0alpha0.2* Initial release\n	</changelog>\n	<location>release/2.8/directory-2.8.0.4.tgz</location>\n	<md5sum>1e9ead07f290d5b34c556c8f8cc2c6f6</md5sum>\n</module>\n<module>\n	<rawname>ringgroups</rawname>\n	<name>Ring Groups</name>\n	<version>2.8.0.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Creates a group of extensions that all ring together. Extensions can be rung all at once, or in various \'hunt\' configurations. Additionally, external numbers are supported, and there is a call confirmation option where the callee has to confirm if they actually want to take the call before the caller is transferred.\n	</description>\n	<changelog>\n		*2.8.0.3* #4671\n		*2.8.0.2* #4484\n		*2.8.0.1* #4422\n		*2.8.0.0* #4133\n		*2.7.0.2* localizations\n		*2.7.0.1* #4051 (requires MoH 2.7.0.0 or above)\n		*2.7.0.0* #4050\n		*2.6.0.1* #3610\n		*2.6.0.0* #3697\n		*2.5.1.9* #3664\n		*2.5.1.8* #3580, localization updates\n		*2.5.1.7* #3380, localization updates\n		*2.5.1.6* localization fixes\n		*2.5.1.5* #3222 sqlite3\n		*2.5.1.4* #3200 and localization fixes\n		*2.5.1.3* #3165 Sqlite3 fix\n		*2.5.1.2* #3000 spelling\n		*2.5.1.1* #2069 Minor bug in change for ids\n		*2.5.1* #2069 Migrate recordings to recording ids\n		*2.5.0.1* changed depends to 2.5\n		*2.5.0* #1795, #2845, #2391, #2853, #2925 add tabindexing, Skip Busy Agent and Ignore Call Forward options\n		*2.4.0.2* #2604, #2843 fix mal-formed html tags, Russian Translation, add oldstyle module hook\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension/dest registry, extension quickpick, added hunt strategy with confirmation, it trans, formatting changes\n		*2.2.16.2* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<menuitems>\n		<ringgroups>Ring Groups</ringgroups>\n	</menuitems>\n	<location>release/2.8/ringgroups-2.8.0.3.tgz</location>\n	<md5sum>a4d209b370c71b47728ad50c9e29707b</md5sum>\n</module>\n<module>\n	<rawname>outroutemsg</rawname>\n	<name>Route Congestion Messages</name>\n	<version>2.8.0.0</version>\n	<publisher>Bandwidth.com</publisher>\n	<license>GPLv2</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>Configures message or congestion tones played when all trunks are busy in a route. Allows different messages for Emergency Routes and Intra-Company Routes\n	</description>\n	<menuitems>\n		<outroutemsg>Route Congestion Messages</outroutemsg>\n	</menuitems>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.2* localizations\n		*2.7.0.1* #4042\n		*2.7.0.0* #3805\n		*2.6.0.3* #3865\n		*2.6.0.2* minor tootlip tweaks\n		*2.6.0.1* init tabindex\n		*2.6.0* Initial Version\n	</changelog>\n	<depends>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<location>release/2.8/outroutemsg-2.8.0.0.tgz</location>\n	<md5sum>fb1e0ed30692b69836aa431cc18d8732</md5sum>\n</module>\n<module>\n	<rawname>miscdests</rawname>\n	<name>Misc Destinations</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Allows creating destinations that dial any local number (extensions, feature codes, outside phone numbers) that can be used by other modules (eg, IVR, time conditions) as a call destination.</description>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* localization string enclosures\n		*2.5.0.1* #3018, #3043 spelling and delete link does not show if not being used as dest\n		*2.5.0* #2845 tabindex, added delete and add icons\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Extension/dest registry, it translation\n		*1.3.4.3* changed categories\n		*1.3.4.2* bump for rc1\n		*1.3.4.1* changed freePBX to FreePBX\n		*1.3.4* destination changed from Dial(Local/nnn@from-internal) to Goto(from-internal,nnn,1), no reason a new channel should be created\n		*1.3.3* Minor formatting changes\n		*1.3.2* Add he_IL translation\n		*1.3.1* Updated help text\n		*1.3* First release for FreePBX 2.2 - Fixed GUI issues\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<menuitems>\n		<miscdests>Misc Destinations</miscdests>\n	</menuitems>\n	<location>release/2.8/miscdests-2.8.0.0.tgz</location>\n	<md5sum>dab8bc69f2fbbcaea18c52f884bb6271</md5sum>\n</module>\n<module>\n	<rawname>pbdirectory</rawname>\n	<name>Phonebook Directory</name>\n	<version>2.7.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>CID &amp; Number Management</category>\n	<location>release/2.8/pbdirectory-2.7.0.1.tgz</location>\n	<description>Provides a dial-by-name directory for phonebook entries</description>\n	<changelog>\n		*2.7.0.1* #4237\n		*2.7.0.0* localizations\n		*2.6.0.1* #3468\n		*2.6.0.0* localizations, misc\n		*2.5.0* localization string enclosures\n		*2.4.0.2* removed 2.4.0 requirement possible causing broken module issue\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* Destination registry, added missing macro-user-callerid call\n		*0.3.1.2* #2343 pbdirectory script errors\n		*0.3.1.1* bump for rc1\n		*0.3.1* fixed some hard coded paths, requires core modules:  2.3.0beta1.6 or above\n		*0.3* First changelog entry\n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<requirements>\n		<module>phonebook</module>\n		<module>speeddial</module>\n	</requirements>\n	<md5sum>794126a05b363b60b280e2989fa9ee07</md5sum>\n</module>\n<module>\n	<rawname>iaxsettings</rawname>\n	<name>Asterisk IAX Settings</name>\n	<version>2.8.0.0</version>\n	<publisher>Bandwidth.com</publisher>\n	<license>AGPLv3</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<menuitems>\n		<iaxsettings sort=\"-6\">Asterisk IAX Settings</iaxsettings>\n	</menuitems>\n	<description>\n		Use to configure Various Asterisk IAX Settings in the General section of iax.conf. The module assumes Asterisk version 1.4 or higher. Some settings may not exist in Asterisk 1.2 and will be ignored by Asterisk.\n	</description>\n	<changelog>\n		*2.8.0.0* #4681\n		*2.7.0.2* #4216\n		*2.7.0.1* localizations\n		*2.7.0.0* #3976 allows codec priorities\n		*2.6.0.5* #3866\n		*2.6.0.4* localizations, misc\n		*2.6.0.3* #3832\n		*2.6.0.2* #3811, #3813\n		*2.6.0.1* corrected publisher/lic\n		*2.6.0.0* install script \'if not exists\' missing\n		*2.6.0beta1.1* install script \'if not exists\' missing\n		*2.6.0beta1.0* lots of tweaks, fixed install.php error\n	</changelog>\n	<location>release/2.8/iaxsettings-2.8.0.0.tgz</location>\n	<md5sum>eb380c6d9f2a1ebed487f4264ec5babd</md5sum>\n</module>\n<module>\n	<rawname>dictate</rawname>\n	<name>Dictation</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.1* localizations\n		*2.7.0.0* #3873\n		*2.6.0.0* localizations\n		*2.5.0.2* localization string enclosures\n		*2.5.0.1* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0* typo in $_GLOBALS variable\n		*2.4.0* abort if user/extension conflict and move hook after user/extnesion hook\n		*1.1.2.3* #2312 fix dictate in devicesandusers mode\n		*1.1.2.2* changed categories\n		*1.1.2.1* bump for rc1\n		*1.1.2* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.1.1* Fix for Dictation not appearing on User page when in Device and User mode.\n		*1.1* Fix changes not sticking when creating an extension, replace Rob-sounds with Allison-sounds.\n		*1.0.1* Replaced \'invalid extension\' with \'feature not available on this line\' when disabled\n		*1.0.0* Original Release\n	</changelog>\n	<description>This uses the app_dictate module of Asterisk to let users record dictate into their phones. When complete, the dictations can be emailed to an email address specified in the extension page.</description>\n	<location>release/2.8/dictate-2.8.0.0.tgz</location>\n	<md5sum>7b1e6c2f4471b4dc6c82e4a21401b455</md5sum>\n</module>\n<module>\n	<rawname>ivr</rawname>\n	<name>IVR</name>\n	<version>2.8.0.5</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Creates Digital Receptionist (aka Auto-Attendant, aka Interactive Voice Response) menus. These can be used to send callers to different locations (eg, \"Press 1 for sales\") and/or allow direct-dialing of extension numbers. \n	</description>\n	<changelog>\n		*2.8.0.5* localization updates\n		*2.8.0.4* #4309, #4310, #4313\n		*2.8.0.3* #4296\n		*2.8.0.2* #4275, #4286\n		*2.8.0.1* #4257 allow direct extension dialing to Directory \"contexts\"\n		*2.8.0.0* cleanup of IVR based on new drawselects: #1798\n		*2.7.0.2* localizations\n		*2.7.0.1* #4025\n		*2.7.0.0* #3923, #4013\n		*2.6.0.3* #4013\n		*2.6.0.2* #3780\n		*2.6.0.1* #3732\n		*2.6.0.0* #3384, add hook support\n		*2.5.20.5* localization string enclosures\n		*2.5.20.4* #3245, localization fixes\n		*2.5.20.3* localization, Swedish\n		*2.5.20.2* #3188 clear MSG var if no message\n		*2.5.20.1* Sqlite3 fixes, move ivr_init() to install script\n		*2.5.20* #3099 allows a return to IVR from voicemail option and from busy phone\n		*2.5.19.2* #2987, #3005 sqlite3 install script, spelling\n		*2.5.19.1* #2965 not working on IE fixed\n		*2.5.19* #2865 Add alternative messages to play if t or i are hit, replacing the first announcmement\n		*2.5.18.1* #2948 don\'t allow deletion if used by a Queue and show list\n		*2.5.18* #2066 Migrate recordings to recording ids\n		*2.5.17.1* #2845 tabindex\n		*2.5.17* #2858 Better handing of i and t options, added loop count and ability to loop before going to user defined i, t options\n		*2.5.16.3* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.5.16.2* #2687 breakout from Queue to Company Directory blocks voicemail\n		*2.5.16.1* #2591, added depends on 2.4.0\n		*2.5.16* Extension/dest registry, #2303, it translation\n		*2.5.15* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<menuitems>\n		<ivr>IVR</ivr>\n	</menuitems>\n	<location>release/2.8/ivr-2.8.0.5.tgz</location>\n	<md5sum>33ae19e91e41f03dab3a5029cbd0f7cb</md5sum>\n</module>\n<module>\n	<rawname>fw_langpacks</rawname>\n	<name>FreePBX Localization Updates</name>\n	<version>2.8.1.1</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.1.1* language updates\n		*2.8.1.0* language updates\n		*2.8.0.1* language updates\n		*2.8.0.0* more language updates\n		*2.7.0.1* more language updates\n		*2.7.0.0* more language updates\n		*2.6.0.3* more language updates\n		*2.6.0.2* french and other updates\n		*2.6.0.1* updates\n		*2.6.0.0* localization updates\n		*2.5.1.1* Spanish, Italian, Bulgarian, Hungarian updates\n		*2.5.1* Swedish, Russian updates\n		*2.5.0.2* Swedish updates, Russian\n		*2.5.0.1* Swedish\n		*2.5.0* First release\n	</changelog>\n	<description>\n		This module provides a facility to install new and updated localization translations for all components in FreePBX. Localization i18n translations are still kept with each module and other components such as the User Portal (ARI). This provides an easy ability to bring all components up-to-date without the need of publishing dozens of modules for every minor change. The localization updates used will be the latest available for all modules and will not consider the current version you are running.\n	</description>\n	<type>setup</type>\n	<category>Basic</category>\n	<location>release/2.8/fw_langpacks-2.8.1.1.tgz</location>\n	<md5sum>b6f7c02de095b1b22e2c543cc479f946</md5sum>\n</module>\n<module>\n	<rawname>fw_ari</rawname>\n	<name>FreePBX ARI Framework</name>\n	<version>2.8.0.8</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<changelog>\n		*2.8.0.8* #5729 Possible Authenticated user RCE Security Vulnerability\n		*2.8.0.7* #5711 RCE Security Vulnerability\n		*2.8.0.6* #4501\n		*2.8.0.5* #4509, #4134, #4501\n		*2.8.0.4* #4461\n		*2.8.0.3* #4423\n		*2.8.0.2* #4402\n		*2.8.0.1* #4255, #4333\n		*2.8.0.0* #3981, #3914, #3552, #3708, #4134, #4127, #4282, #4254, #4281\n		*2.7.0.1* #4158\n		*2.7.0.0* bumped\n		*2.6.0.3* inlcude js libraries\n		*2.6.0.2* #3382, #3642, #3621\n		*2.6.0.1* changed to pull from 2.6 branch\n		*2.6.0.0* Security Vulnerability: #3660; #3215, #3158, #3416, #3383, #3447\n		*2.5.2.2* #3446, #3540\n		*2.5.2.1* fixes some unreported bugs: r7140, r7235, localization updates\n		*2.5.2.rc1* #3042 remove player popup, embed in page and add call screening settings to phone features\n		*2.5.1.1* #3202, #3203\n		*2.5.1* #3184 SECURITY VULNERABILITY fix\n		*2.5.0.3* #3165, #3077, #2609 and additional fixes related to #3161\n		*2.5.0.2* r6505, #3161 SQL Injection vulnerability that could allow and authenticated user to access all CDRs and recordings\n		*2.5.0.1* remove inclusion of libfreepbx.install.php in install script resulting in warnings\n		*2.5.0* #3104 and First release of fw_ari\n	</changelog>\n	<description>\n		This module provides a facility to install bug fixes to the ARI code that is not otherwise housed in a module, it used to be part of framework but has been removed to isolate ARI from Framework updates.\n	</description>\n	<type>setup</type>\n	<category>Basic</category>\n	<location>release/2.8/fw_ari-2.8.0.8.tgz</location>\n	<md5sum>bb485818956695ed66f2c3884e4d719f</md5sum>\n</module>\n<module>\n	<rawname>printextensions</rawname>\n	<name>Print Extensions</name>\n	<version>2.8.0.0</version>\n	<publisher>Bandwidth.com</publisher>\n	<license>GPLv2</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>Creates a printable list of extension numbers used throughout the system from all modules that provide an internal callable number</description>\n	<menuitems>\n		<printextensions>Print Extensions</printextensions>\n	</menuitems>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.4* change fc sort order\n		*2.6.0.3* misc\n		*2.6.0.2* replace Core with Extensions re #3662, sort Extensions first always\n		*2.6.0.1* minor tweaks, localizations\n		*2.6.0.0* add rnav checkboxes to collapse/expand extension sections\n		*2.5.0.3* fixes to get localization working from other module domains\n		*2.5.0.2* formating cleanup, code removed\n		*2.5.0.1* right justify Extension heading\n		*2.5.0* remove directdid (no longer in 2.5), change to provide full PBX extension layout\n		*2.4.0* it translations, bump for 2.4\n		*1.3.2* Fixed uninizialized variable errors, bump for rc1\n		*1.3.1* Add he_IL translation\n	</changelog>\n	<location>release/2.8/printextensions-2.8.0.0.tgz</location>\n	<md5sum>91defb78cc3e034ab8460c0b1bcca402</md5sum>\n</module>\n<module>\n	<rawname>framework</rawname>\n	<name>FreePBX Framework</name>\n	<version>2.8.1.5</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<changelog>\n		*2.8.1.5* #5012, #5077, #5712 XSS Security Vulnerability\n		*2.8.1.4* add distro to online checking\n		*2.8.1.3* #4858\n		*2.8.1.2* #4844\n		*2.8.1.1* #4501, send phpversion to online repo, enable versionupgrade to work better\n		*2.8.1.0* #4616, #4693, #4719, #4680\n		*2.8.0.4* #4585, #4587, #4549, #4602, #4603, #4494, #4615 (Security Bug)\n		*2.8.0.3* misc fixes\n		*2.8.0.2* #4245, #4461\n		*2.8.0.1* #4385\n		*2.8.0.0* #4400, #4388, #4185, #4403, #3963, #4411, #4413, #4418\n		*2.8.0rc1.3* #4388, #4389 cleanup\n		*2.8.0rc1.2* #4389\n		*2.8.0rc1.1* #4376, #4381, #4382, #4386\n		*2.8.0rc1.0* #4366, #4354 \n		*2.8.0beta2.4* #4179, #4345, #4331, #4339\n		*2.8.0beta2.3* #4307, #4253, #4311\n		*2.8.0beta2.2* #4307, revert #4306\n		*2.8.0beta2.1* #4256, #4299, #4306\n		*2.8.0beta2.0* #4247, #4264, #4242, #4086, #4183, #4292\n		*2.8.0beta1.3* #4164, #4163, #4106, #4172, #3981, #3914, #3552, #3708, #4134, #4127, #4207, #4188, #4223 Security Vulnerability\n		*2.8.0beta1.2* #4164\n		*2.8.0beta1.1* #4071, #4152, #4158, misc CSS changes\n		*2.8.0beta1.0* bumping to beta\n		*2.8.0.0alpha2.1* #4109, #3375, jquery update to 1.4.2\n		*2.8.0.0alpha2.0* #4110, #4138, #4135, #1798, #4143, #4144\n		*2.8.0.0alpha1.0* #2181, #4110, #3375, #4109, #4123, #4121, #4125, #4126, add jquery.toggleval.js to FreePBX\n		*2.7.0.0* localizations\n		*2.7.0RC1.2* #4068\n		*2.7.0RC1.1* #4057\n		*2.7.0RC1.0* #2839, #3980, #3992, #4024, #4051, #3575\n		*2.7.0beta1.0* #3707, #4007, #3940, #3929, #3974\n		*2.6.0.1* #3971, #3977, #3900, #3987\n		*2.6.0.0* #3885, #3878, #3295, #3883, #3903, #3889\n		*2.6.0RC2.1* #3870\n		*2.6.0RC2.0* #3854\n		*2.6.0RC1.1* #3807, #3843, #3856, #3857\n		*2.6.0RC1.0* #3850, #3837, #3858, #3861, #3678\n		*2.6.0beta2.2* #3840, misc warning fixes\n		*2.6.0beta2.1* #2880, #3291, #3835\n		*2.6.0beta2.0* #3075, #3780, #3559, #3606, #3599, #3642, #3608, #3581, #3266, #3562, #3639, #3305\n		*2.6.0beta1.4* added param to featurecode class function\n		*2.6.0beta1.3* rename moduleauthor to modulepublisher class in css, update CHANGES\n		*2.6.0beta1.2* add sql() def to migration table\n		*2.6.0beta1.1* add trunk migration code to tables.php\n		*2.6.0beta1.0* renamed to beta1\n		*2.6.0beta0.2* packed js library updated\n		*2.6.0beta0.1* changed to pull from 2.6 branch\n		*2.6.0beta0.0* #1957, #3673, #1380, #3680, #3694, #3696, #3698\n		*2.6.0alpha1.2* fix bug introduced from #3660\n		*2.6.0alpha1.1* Friendly Warning re: #3660\n		*2.6.0alpha1.0* Security Vulnerability: #3660; #3324, #3327, #3368, #3380, #3224, #3462, #3446, #3469, #3588, #3592, r7324, #3271, #3449, #3556, #3641, #3513, #3525, #3658, #3490, #3582, #3570, #3264\n		*2.5.1.0* #3271, #3309, localization fixes\n		*2.5.0.1* #2792, #3223, #3225, #3235, #3234, #3242, #3246, #3247, #3248, #3221\n		*2.5.0.0* #3176, #3191, #3204, #3209 - fixes SECURITY VULNERABILITY in CDR Reporting\n		*2.5.0rc3.0* #3145, #3151, #3154, #3155, #3156, #3164, #3166, #3165, #3077, #3170 (DAHDI Support)\n		*2.5.0rc2.4* #3131, #3137 several changes to better cache module data and boost performance of page loads\n		*2.5.0rc2.3* #2750, #3128, #3124, #3134, #3131\n		*2.5.0rc2.2* #3107, #3093, #3090, #3113, $3117\n		*2.5.0rc2.1* #3104 fix some urlencoding/decoding re: #3102 changes\n		*2.5.0rc2.0* #3067, #3086, #3082, #3102\n		*2.5.0rc1.1* published wrong, including rc1.0 additions\n		*2.5.0rc1.0* #2913, #3052 delay_answer schema and CSS fix\n		*2.5.0beta1.2* #3014, #3030, #2992, #3026, #3027\n		*2.5.0beta1.1* #2635, #2792 CDR Reporting pie chart errors, and fix bug introduced by #2963\n		*2.5.0beta1.0* #2854, #2978, #2980, #2981, #2982, #2963, #2985\n		*2.5.0alpha1.2* #2957 fix fatal failure in retrieve_conf from change to splice\n		*2.5.0alpha1.1* #2941, #2924, #1539, #2950, #2944, #2945, #2699, #2686, #2946, #2606, #2772, #2565, #1679\n		*2.5.0alpha1.0* #1628, #1715, #1843, #2497, #2604, #2606, #2609, #2686, #2701, #2703, #2739, #2766, #2777, #2782, #2784, #2793, #2798, #2799, #2809, #2818, #2829, #2843, #2845, #2855, #2862, #2881, #2890, #2891, #2897, #2903, #2910, #2911, #2921, #2924\n		*2.4.0.1* #2843, #2701, #2818, #2784, #2604, #2766, #2798, #2809, #2799, #2685, #2676\n		*2.4.0.0* CHANGELOG TRUNCATED See SVN Repository\n	</changelog>\n	<description>\n		This module provides a facility to install bug fixes to the framework code that is not otherwise housed in a module\n	</description>\n	<type>setup</type>\n	<category>Basic</category>\n	<location>release/2.8/framework-2.8.1.5.tgz</location>\n	<md5sum>da59e064e7aeab790dc4f1ed08073c9c</md5sum>\n</module>\n<module>\n	<rawname>conferences</rawname>\n	<name>Conferences</name>\n	<version>2.8.0.4</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Allow creation of conference rooms (meet-me) where multiple people can talk together.</description>\n	<changelog>\n		*2.8.0.4* #4735\n		*2.8.0.3* #4697\n		*2.8.0.2* #4660\n		*2.8.0.1* #4309\n		*2.8.0.0* #3331 max participants option\n		*2.7.0.1* spelling fixes, localization updates\n		*2.7.0.0* #4051, #3967 add MoH class choice require MoH module 2.7.0.0+\n		*2.6.0.2* #3126\n		*2.6.0.1* tabindex init\n		*2.6.0.0* #3392, localizations\n		*2.5.1.6* #3392 and some localizations\n		*2.5.1.5* localization strings enclosed\n		*2.5.1.4* #3237\n		*2.5.1.3* #3192 set dir for recordings, localization cleanup and Swedish\n		*2.5.1.2* #3135 variable initialization\n		*2.5.1.1* #3087 add hook to module code\n		*2.5.1* #2064 Migrate recordings to recording ids\n		*2.5.0* #2845, added blf hints, added delete and add icons\n		*2.4.0.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* #2158 add recording option, add support for Extension and Destination Registries, it translations\n		*1.2.2* don\'t ask for name confirmation when recording names on Asterisk 1.3 (new option I replaces i)\n		*1.2.1.3* move Macro(user-callerid) to be called with each conf to accomodate future language settings\n		*1.2.1.2* add call to Macro(user-callerid) to get proper CID in Meetme Conference\n		*1.2.1.1* bump for rc1\n		*1.2.1* changed syntax error in meetme_additional.conf form \'|\' to \',\' separator\n		*1.2* Fixed raising asterisk error on empty dialstatus #1708\n		*1.1.2* Add he_IL translation\n		*1.1.1* Updated for 2.2.0RC1\n		*1.1* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n		<module>recordings ge 3.3.8</module>\n	</depends>\n	<menuitems>\n		<conferences>Conferences</conferences>\n	</menuitems>\n	<location>release/2.8/conferences-2.8.0.4.tgz</location>\n	<md5sum>4eff3a0e6747e1f9cb7e94931032f3d9</md5sum>\n</module>\n<module>\n	<rawname>javassh</rawname>\n	<name>Java SSH</name>\n	<version>2.8.0.1</version>\n	<publisher>FreePBX</publisher>\n	<license>FREEUSE</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>Provides a Java applet to access the system shell using SSH. SSH client is provided by Appgate (www.appgate.com) and licensed is Free Limited Use, http://www.appgate.com/index/products/mindterm/mindterm_end_user_lic.html</description>\n	<menuitems>\n		<javassh>Java SSH</javassh>\n	</menuitems>\n	<changelog>\n		*2.8.0.1* #4473\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* security setting updates: r7432\n		*2.5.0.1* localization updates\n		*2.5.0* localization fixes, Swedish\n		*2.4.0* bump for 2.4\n		*1.0.1.1* bump for rc1\n		*1.0.1* First Changelog\n	</changelog>\n	<location>release/2.8/javassh-2.8.0.1.tgz</location>\n	<md5sum>8231056c41b03a581503bed43339dc86</md5sum>\n</module>\n<module>\n	<rawname>phpinfo</rawname>\n	<name>PHP Info</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* localizations\n		*2.6.0.0* misc\n		*2.4.0* bump for 2.4\n		*1.1.0.1* bump for rc1\n		*1.1.0* #1442 remove access problem and iframe\n	</changelog>\n	<type>tool</type>\n	<category>System Administration</category>\n	<menuitems>\n		<phpinfo>PHP Info</phpinfo>\n	</menuitems>\n	<location>release/2.8/phpinfo-2.8.0.0.tgz</location>\n	<md5sum>7586c4646dc0747646bae3e1fb23db85</md5sum>\n</module>\n<module>\n	<rawname>vmblast</rawname>\n	<name>VoiceMail Blasting</name>\n	<version>2.8.0.2</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>\n		Creates a group of extensions that calls a group of voicemail boxes and allows you to leave a message for them all at once. \n	</description>\n	<changelog>\n		*2.8.0.2* #4551\n		*2.8.0.1* localization updates\n		*2.8.0.0* #4309, #4310\n		*2.7.0.0* spelling, localizations\n		*2.6.0.0* localizations, misc\n		*2.5.0.6* #3697\n		*2.5.0.5* localization updates\n		*2.5.0.4* #3380\n		*2.5.0.3* localization string enclosures\n		*2.5.0.2* #3138, #3165 Sqlite3 fixes\n		*2.5.0.1* #2530 typo _GLOBALS should be GLOBALS\n		*2.5.0* #2845 tabindex\n		*2.4.3.3* add oldstyle module hook\n		*2.4.3.2* added depends on 2.4.0\n		*2.4.3.1* #2632 red bar addressed now also\n		*2.4.3* #2632 audio_lable, password, default_group not saved on initial config, and fix odd refresh behavior after add\n		*2.4.2* #2630 fixed errors requiring register_globals=on to be set in php.ini\n		*2.4.1* add beep only, no confirmation option to vmblast audio label\n		*2.4.0* first official version imported into 2.4 branch\n		*1.2.0* change to use proper multi-select list, fix bug in js validation of empty list, add default vmblast group\n		*1.1.2* add vmblast_group table and migrate from old grplist field\n		*1.1.1* fixed a couple SQL bugs, improved dialplan so you can skip annoucement and messages immeditiately (except if saydigits used)\n		*1.1.0* add audio label, password protect, fix bug for javascript validation to work, add extension/dest registry support\n		*1.0.2* increase grouplist field to varchar(255) to increase the vmblast list\n		*1.0.l* fix: context, redisplay of groups, get proper vm contexts, beep before leaving msg\n	</changelog>\n	<menuitems>\n		<vmblast>VoiceMail Blasting</vmblast>\n	</menuitems>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<location>release/2.8/vmblast-2.8.0.2.tgz</location>\n	<md5sum>afaec49cab9655c9258bfdff5171b5ca</md5sum>\n</module>\n<module>\n	<rawname>asterisk-cli</rawname>\n	<name>Asterisk CLI</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>tool</type>\n	<category>System Administration</category>\n	<description>Provides an interface allowing you to run a command as if it was typed into Asterisk CLI</description>\n	<menuitems>\n		<cli>Asterisk CLI</cli>\n	</menuitems>\n	<depends>\n		<engine>asterisk</engine>\n	</depends>\n	<location>release/2.8/asterisk-cli-2.8.0.0.tgz</location>\n	<md5sum>a3a5fc712cbecbab44ad42e84ffb7d60</md5sum>\n	<changelog>\n		*2.8.0.0* published 2.8 version\n		*2.7.0.0* spelling fixes, localization updates\n		*2.6.0.0* localizations, misc\n		*2.5.0.2* description added to xml\n		*2.5.0.1* r6547 Swedish Translations\n		*2.5.0* #2917 execute CLI command direct through manager to remove vulnerabilities\n		*2.4.0* 2.4 branch (added IT translations also)\n		*1.1.2.1* bump for rc1\n		*1.1.2* fix syntax error, extra =\n		*1.1.1* #2070 fix proper use of script tags\n		*1.1* #2006 Fixed display on systems with colored asterisk console\n		*1.0* Fixed security issue, first release in 2.2\n		*0.001* Original Release\n	</changelog>\n</module>\n<module>\n	<rawname>music</rawname>\n	<name>Music on Hold</name>\n	<version>2.8.0.3</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<candisable>no</candisable>\n	<canuninstall>no</canuninstall>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Uploading and management of sound files (wav, mp3) to be used for on-hold music.</description>\n	<changelog>\n		*2.8.0.3* #4604 (Security Bug)\n		*2.8.0.2* localization updates\n		*2.8.0.1* #4179\n		*2.8.0.0* #4309, #4310\n		*2.7.0.5* #4261\n		*2.7.0.4* #4157\n		*2.7.0.3* #4111\n		*2.7.0.2* #4087\n		*2.7.0.1* text tweaks\n		*2.7.0.0* #4051 allow moh subdir to be defined\n		*2.6.0.2* localizations\n		*2.6.0.1* 3436\n		*2.6.0.0* added publisher/lic\n		*2.5.1.4* #3711 and localizations\n		*2.5.1.3* #3380, #3443, localization updates\n		*2.5.1.2* #3346\n		*2.5.1.1* #3297, localization changes\n		*2.5.1* #3156 add option to put Streaming Sources as well as downloaded files as music category\n		*2.5.0.1* #3007 spelling\n		*2.5.0* #2773, #2845, #2928, added delete and add icons\n		*2.4.0.2* #2843 Russian Translation\n		*2.4.0.1* #2591 localization fixes\n		*2.4.0* it translations, bump for 2.4\n		*1.5.2* #1923 Add option to no encode wav to mp3 (but recode it to 8K samples)\n		*1.5.1.5* #2193 moh path hardcoded\n		*1.5.1.4* bump for rc1\n		*1.5.1.3* #1969 fix javascript validation, add canunninstall:no\n		*1.5.1.2* #2070 fix proper use of script tags\n		*1.5.1.1* added candisable = no for module admin\n		*1.5.1* Added a \'none\' category that results in silence played\n		*1.5* Fixed upload bug, #1646 could not upload files\n		*1.4.2* List wav files\n		*1.4.1* Add redirect_standard() call to avoid #1616\n		*1.4* Fix an issue of a new install not having a working MOH until they visit the page.\n		*1.3.2* Add he_IL translation\n		*1.3.1* Changed name to Music on Hold (from On Hold Music) \n		*1.3* Bumped version to assist upgraders from the 2.1 tree. No other changes.\n		*1.2* First release for FreePBX 2.2 - Fixed compatibility issue with new UI\n	</changelog>\n	<menuitems>\n		<music>Music on Hold</music>\n	</menuitems>\n	<location>release/2.8/music-2.8.0.3.tgz</location>\n	<md5sum>6027a737953f15807bf3d6b819abe82f</md5sum>\n</module>\n<module>\n	<rawname>daynight</rawname>\n	<name>Day Night Mode</name>\n	<version>2.8.0.0</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Inbound Call Control</category>\n	<description>\n		Day / Night control - allows for two destinations to be chosen and provides a feature code\n		that toggles between the two destinations.\n	</description>\n	<changelog>\n		*2.8.0.0* #4309\n		*2.7.0.0* spelling errors, localizations\n		*2.6.0.2* #3585 custom recordings\n		*2.6.0.1* init tabindex\n		*2.6.0.0* #3650, #3651\n		*2.5.0.12* #3350\n		*2.5.0.11* localization updates\n		*2.5.0.10* #3318 set BLF in GUI\n		*2.5.0.9* localization string enclosures\n		*2.5.0.8* #3215\n		*2.5.0.7* #3214, #3222\n		*2.5.0.6* localization, Swedish\n		*2.5.0.5* #3138 Sqlite3 fixes\n		*2.5.0.4* #2998, #3004 fix link status to timecondition, spelling\n		*2.5.0.3* #2954 hint not getting written fixed\n		*2.5.0.2* #2903, #2882 more changes, depends on 2.5.0\n		*2.5.0.1* #2882: added hook to associated a timecondtion with a daynight mode condtion\n		*2.5.0* change to create feature code for each index, add func_devstate blf\n		*2.4.0.3* #2734 fixed issue creating index with no description made it disapear\n		*2.4.0.2* #2604, #2843 fix mal-formed html tags, Russian Translation\n		*2.4.0.1* #2591 added depends on 2.4.0\n		*2.4.0* extension/dest registry, it translation\n		*1.0.2.4* #2414 fix other unmatched ) syntax error\n		*1.0.2.3* #2414 fix unmatched ) syntax error\n		*1.0.2.2* bump for rc1\n		*1.0.2.1* added xml attribute needsenginedb, fixed some undefined vars\n		*1.0.2* Added red/green color coding of rnav to see current mode\n		*1.0.1* #2047 got day/night reversed\n		*1.0.0* First release for FreePBX 2.3 \n	</changelog>\n	<depends>\n		<version>2.5.0alpha1</version>\n	</depends>\n	<menuitems>\n		<daynight needsenginedb=\"yes\">Day/Night Control</daynight>\n	</menuitems>\n	<location>release/2.8/daynight-2.8.0.0.tgz</location>\n	<md5sum>a3ae165da6d4175581cd36535719bea8</md5sum>\n</module>\n<module>\n	<rawname>pinsets</rawname>\n	<name>PIN Sets</name>\n	<version>2.8.0.5</version>\n	<publisher>FreePBX</publisher>\n	<license>GPLv2+</license>\n	<type>setup</type>\n	<category>Internal Options &amp; Configuration</category>\n	<description>Allow creation of lists of PINs (numbers for passwords) that can be used by other modules (eg, trunks).</description>\n	<changelog>\n		*2.8.0.5* #4431\n		*2.8.0.4* localization updates\n		*2.8.0.3* #4197\n		*2.8.0.2* #4141\n		*2.8.0.1* #4131\n		*2.8.0.0* #4124 (#4110)\n		*2.7.0.0* localizations\n		*2.6.0.0* misc\n		*2.5.0.1* #3240, #3258\n		*2.5.0* #2845, #2764 tabindex\n		*2.4.0.1* #2843 Russian Translation\n		*2.4.0* bump for 2.4\n		*1.2.3* #2393 add support for pinless dialing\n		*1.2.2.2* #2172 deprecated use of |\n		*1.2.2.1* bump for rc1\n		*1.2.2* Put None label in menu hook\n		*1.2.1* #1770 added proper uninstall\n		*1.2* Add SQLite3 support, fixes http://freepbx.org/trac/ticket/1778\n		*1.1* Add he_IL translation, add naftali5\'s fixes where pinsets were being lost when moved around.\n		*1.0.11* Stop potential error where a random pinset is appearing when creating a new trunk\n	</changelog>\n	<menuitems>\n		<pinsets>PIN Sets</pinsets>\n	</menuitems>\n	<location>release/2.8/pinsets-2.8.0.5.tgz</location>\n	<md5sum>0ad6606985a445e72a26d8f0e49f1efe</md5sum>\n</module>\n\n<module>\n	<rawname>bulkdids</rawname>\n	<name>Bulk DIDs</name>\n	<description>Bulk DIDs uses CSV files to import bulk DIDs with a destination.</description>\n	<version>2.5.0.3</version>\n	<type>tool</type>\n	<category>Third Party Addon</category>\n	<menuitems>\n		<bulkdids>Bulk DIDs</bulkdids>\n	</menuitems>\n	<depends>\n		<version>ge2.5</version>\n	</depends>\n	<location>contributed_modules/release/bulkdids-2.5.0.3.tgz</location>\n	<info></info>\n	<changelog>\n		*2.5.0.3* Updated licensing\n		*2.5.0.2* Fixed export functionality\n		*2.5.0.1* Fixed conflict with bulkextensions module\n		*2.5.0.0* Initial Release\n	</changelog>\n	<md5sum>119b9335e95f6919cbbe45a257cc4052</md5sum>\n</module>\n\n<module>\n	<rawname>vmailadmin</rawname>\n	<name>Voicemail Admin</name>\n	<description>Allows voicemail administration independent of user administration.</description>\n	<version>2.5.7.1</version>\n	<type>setup</type>\n	<category>Third Party Addon</category>\n	<menuitems>\n		<vmailadmin>Voicemail Admin</vmailadmin>\n	</menuitems>\n	<depends>\n		<version>ge2.4</version>\n	</depends>\n	<changelog>\n		*2.5.7.1* Re-Publish to get location and md5sum info update\n		*2.5.7* Performance tuning, consolidated some looping constructs.\n		*2.5.6* Unreleased - Title on each page changed to indicate \"Voicemail Administration\". Bug fixed for modification of (basic) account settings (attach/saycid/envelope/delete options are now correctly handled).\n		*2.5.5* Unreleased - Added javascript to auto-scroll right-hand menu list to currently-viewed account; removed unneeded checks of voicemail context; prefixed all function names with \"vmailadmin_\"; new check for extensions vs. deviceanduser mode so that links for disabled accounts go to extensions or users page (depending on the mode)\n		*2.5.4* Unreleased - Added display of account name on individual account settings page\n		*2.5.3* Unreleased - Improved the layout of the usage view; made password fields into password html boxes; made a settings page and a separate advanced settings page for individual accounts; added support for name and vmcontext fields for individual accounts settings\n		*2.5.2* Unreleased - Changed navigation links; eliminated unecessary context usage view; improved tooltips; alphabetized options listed in settings pages; completed overhaul of timezone definitions page\n		*2.5.1* Unreleased - Improved interface and performance; only abandoned greetings at least 1 day old can be deleted.\n		*2.5* First release\n	</changelog>\n	<location>contributed_modules/release/vmailadmin-2.5.7.1.tgz</location>\n	<info></info>\n	<md5sum>8b2e358f2baf695f596140092aac7b02</md5sum>\n</module>\n<module>\n	<rawname>setcid</rawname>\n	<name>Set CallerID</name>\n	<version>2.8.2</version>\n	<type>setup</type>\n	<category>Third Party Addon</category>\n	<description>\n		Adds the ability to change the CallerID within a call flow.\n	</description>\n	<menuitems>\n		<setcid>Set CallerID</setcid>\n	</menuitems>\n	<changelog>\n		*2.8.2* #4609\n		*2.8.1* Remove debug leftover\n		*2.8.0* #4284, #4316\n		*2.5.0* First release of module\n	</changelog>\n	<depends>\n		<version>2.5.0</version>\n	</depends>\n	<location>contributed_modules/release/setcid-2.8.2.tgz</location>\n	<md5sum>54a499feb49459627a4b9536f5ddd4db</md5sum>\n</module>\n<module>\n	<rawname>gabcast</rawname>\n	<name>Gabcast</name>\n	<version>2.5.0.1</version>\n	<type>tool</type>\n	<category>Third Party Addon</category>\n	<menuitems>\n		<gabcast>Gabcast</gabcast>\n	</menuitems>\n	<changelog>\n		*2.5.0.1* added localization ability\n		*2.5.0* localization fixes\n		*2.4.0.1* added depends on 2.4.0\n		*2.4.0* add dest registry, fix rnav formating\n		*1.2.5.1* bump for rc1\n		*1.2.5* #2070 fix proper use of script tags\n	  *1.2.4* changed ${CALLERID(number)} to ${AMPUSER} to accomodate CID number masquerading\n		*1.2.3* Add he_IL translation\n		*1.2.2* Fix issue where you were unable to add a channel \n	</changelog>\n	<depends>\n		<version>2.4.0</version>\n	</depends>\n	<location>contributed_modules/release/gabcast-2.5.0.1.tgz</location>\n	<md5sum>0e8981420ee20f75a3d4a640f8b3964f</md5sum>\n</module>\n<module>\n	<rawname>customerdb</rawname>\n	<name>Customer DB</name>\n	<version>2.5.0.4</version>\n	<type>tool</type>\n	<category>Third Party Addon</category>\n	<menuitems>\n		<customerdb>Customer DB</customerdb>\n	</menuitems>\n	<changelog>\n		*2.5.0.4* localization updates\n		*2.5.0.3* localization enclosures\n		*2.5.0.2* #2987 sqlite3 install script changes\n		*2.5.0.1* #2781 allow sqlite table creation\n		*2.5.0* #2845 tabindex\n		*2.4.0* it translations, bump for 2.4\n		*1.2.3.1* bump for rc1\n		*1.2.3* Add he_IL translation\n	</changelog>\n	<location>contributed_modules/release/customerdb-2.5.0.4.tgz</location>\n	<md5sum>e3c194354948e73ff1cb3d28a25441c7</md5sum>\n</module>\n\n<module>\n	<rawname>inventorydb</rawname>\n	<name>Inventory</name>\n	<version>2.5.0.2</version>\n	<type>tool</type>\n	<category>Third Party Addon</category>\n	<menuitems>\n		<inventorydb>Inventory</inventorydb>\n	</menuitems>\n	<changelog>\n		*2.5.0.2* localization, French\n		*2.5.0.1* localization, Swedish\n		*2.5.0* #2845 tabindex\n		*2.4.0.1* #2645 API error - NOTICE: This module will be removed from future versions\n		*2.4.0* bumped for 2.4\n		*1.1.0* Added SQLite3 support. Fixes ticket:1783, bump for rc1\n		*1.0.3* Add he_IL translation\n	</changelog>\n	<location>contributed_modules/release/inventorydb-2.5.0.2.tgz</location>\n	<md5sum>12348c43e449b8ec067807914704d76d</md5sum>\n</module>\n\n<module>\n	<rawname>customcontexts</rawname>\n	<name>Custom Contexts</name>\n	<version>2.8.0rc1.1</version>\n	<type>setup</type>\n	<category>Third Party Addon</category>\n	<description>\n		Creates custom contexts which can be used to allow limited access to dialplan applications. Allows for time restrictions on any dialplan access. Allows for pattern matching to allow/deny. Allows for failover destinations, and PIN protected failover. This can be very useful for multi-tennant systems. Inbound routing can be done using DID or zap channel routing,	this module allows for selective outbound routing. House/public phones can be placed in a restricted context allowing them only internal calls.\n	</description>\n	<menuitems>\n		<customcontexts>Custom Contexts</customcontexts>\n		<customcontextsadmin type=\"tool\" category=\"System Administration\">Custom Contexts Admin</customcontextsadmin>\n	</menuitems>\n        <depends>\n					<version>2.8.0alpha1</version>\n					<module>core</module>\n        </depends>\n        <changelog>\n					*2.8.0rc1.1* #4384\n					*2.8.0rc1.0* #4369\n					*2.8.0beta1.4* display contexts in order of priorities\n					*2.8.0beta1.3* #3994 properly fix this\n					*2.8.0beta1.2* #4335 Fix migration, remove time conditions stuff\n					*2.8.0beta1.1* #4335\n					*2.8.0beta1.0* #4335 migration and changes to support 2.8\n					*0.3.7* remove EOL warnings\n					*0.3.6* fix version, End of Life warning, dependency requirement\n					*0.3.5* #3994 current context on extension page not sticking\n					*0.3.4* see http://freepbx.org/forum/freepbx/users/custom-contexts-broken-in-freepbx-2-3-1-3\n					*0.3.3* Added Set All option to quickly allow/deny all. Fixed bug which caused routes to be denied after rename/sort/or delete other route.\n					*0.3.2* Optional PIN to protect failover destination. Contexts can now be used as destinations. An IVR menu, Time Condition, etc. can now send a caller into a custom context. (This last feature requires a bugfix in 2.2 after rc1. bug #1549)\n					*0.3.1* Now prompts on delete. After duplicate you are editing new context. Allows rename context.\n					*0.3.0* New Features: Allow or Deny based on pattern matching. Failover Destination (one for regular extension, one for failed feature codes) Bugfixes: Adjusted Gui, Duplicate context, now duplicates the description too.\n					*0.2.2* Bugfix: Duplicate Context now copies the priority also.\n					*0.2.1* Added Duplicate Context option to easily copy an entire set of rules.\n					*0.2.0* Added priority feature to allow the user to control in what order the allowed contexts are included.\n					*0.1.3* Made it obvious when allowing one include may allow another entire context.\n					*0.1.2* Bugfixes- deleted routes, etc. now are removed. Context tests for spaces and illegal chars. Moved admin to tools to reduce confusion. Added option to allow entire internal dialplan. (Usefull for time limit on everything) Made description for outbound-allroutes clearer that allowing overrides to allow all routes.\n					*0.1.1* Still Beta, added time groups and bugfixes\n					*0.0.1* Beta release\n        </changelog>\n	<attention>\n		This is an advanced module, and you should not use it without understanding asterisk dialplans! This is meant as a convenience tool for someone who would have had to resort to config editing. If you experience problems with it, just disable it and no harm done. REMEMBER! Any device placed in a restricted context will have no access to the dialplan if this module is disabled until it is placed in a normal context!\n	</attention>\n	<depends>\n		<module>timeconditions</module>\n	</depends>\n	<location>contributed_modules/release/customcontexts-2.8.0rc1.1.tgz</location>\n	<md5sum>c629f30b239b6088e1a09e60c6007894</md5sum>\n</module>\n<module>\n	<rawname>bulkextensions</rawname>\n	<name>Bulk Extensions</name>\n	<description>Bulk Extensions uses CSV files to import and export extensions.</description>\n	<version>2.7.0.1</version>\n	<type>tool</type>\n	<category>Third Party Addon</category>\n	<menuitems>\n		<bulkextensions>Bulk Extensions</bulkextensions>\n	</menuitems>\n	<depends>\n		<version>ge2.7</version>\n	</depends>\n	<location>contributed_modules/release/bulkextensions-2.7.0.1.tgz</location>\n	<info></info>\n	<changelog>\n		*2.7.0.1* #5091 missing fields from template.csv\n		*2.7.0.0* #4567 Add fax setting\n		*2.6.0.7* #4495\n		*2.5.0.6* #4150\n		*2.5.0.5* Add permit/deny fields provided by 4Colo. Fixed a small bug in table.csv. Fixed spelling error in template.csv. Added localization for table.csv. See CHANGES for how-to.\n		*2.5.0.4* No changes, re-publishing to get md5sum and location info updated\n		*2.5.0.3* Fixed bug - every notification email after the first one had increasing amounts of unwanted white space at the beginning of the message\n		*2.5.0.2* New feature - Enforce extension range restrictions for admin users - thanks dinhtrung\n			  New feature - Email notification for new accounts\n		*2.5.0.1* changed includes to include_once\n		*2.5.0* Version for FreePBX 2.5\n		*0.2.1*	Beta support for FreePBX 2.5 (unreleased)\n		*0.2.0*	New feature - Export Extensions Documented all supported Extension fields Minor code clean ups\n		*0.1.1*	Fixed bad path and error in tar file\n		*0.1*	First release\n	</changelog>\n	<md5sum>d9d0311e3e46bfdc3d4953150a958915</md5sum>\n</module>\n\n</xml>\n');
/*!40000 ALTER TABLE `module_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `id` int(11) NOT NULL auto_increment,
  `modulename` varchar(50) NOT NULL default '',
  `version` varchar(20) NOT NULL default '',
  `enabled` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'featurecodeadmin','2.8.0.1',1),(2,'core','2.8.1.0',1),(3,'infoservices','2.8.0.0',1),(4,'music','2.8.0.3',1),(5,'voicemail','2.8.0.0',1),(6,'framework','2.8.1.4',1),(7,'recordings','3.3.10.3',1),(8,'customappsreg','2.8.0.1',1),(9,'dashboard','2.8.0.3',1),(10,'fw_ari','2.8.0.6',1),(11,'fw_fop','2.8.0.6',1),(12,'fw_langpacks','2.8.1.1',1),(43,'queueprio','2.8.0.0',1),(14,'queues','2.8.0.4',1),(15,'announcement','2.8.0.0',1),(16,'backup','2.8.0.7',1),(17,'callback','2.8.0.0',1),(18,'callforward','2.8.0.4',1),(19,'callwaiting','2.8.0.0',1),(20,'conferences','2.8.0.3',1),(21,'dictate','2.8.0.0',1),(22,'disa','2.8.0.2',1),(23,'donotdisturb','2.7.0.1',1),(24,'findmefollow','2.8.0.4',1),(25,'irc','2.8.0.0',1),(26,'ivr','2.8.0.5',1),(27,'logfiles','2.8.0.0',1),(28,'manager','2.8.0.0',1),(29,'miscapps','2.8.0.1',1),(30,'miscdests','2.8.0.0',1),(31,'paging','2.8.0.1',1),(32,'parking','2.8.0.0',1),(33,'pbdirectory','2.7.0.1',1),(34,'phonebook','2.8.0.1',1),(35,'pinsets','2.8.0.5',1),(36,'ringgroups','2.8.0.3',1),(37,'timeconditions','2.8.0.3',1),(38,'vmblast','2.8.0.2',1),(39,'blacklist','2.7.0.2',1),(40,'cidlookup','2.8.0.3',1),(41,'languages','2.8.0.2',1),(42,'speeddial','2.8.0.1',1),(44,'daynight','2.8.0.0',1),(59,'outroutemsg','2.8.0.0',1),(60,'restart','2.8.0.1',1),(61,'sipsettings','2.8.0.1',1),(45,'asterisk-cli','2.8.0.0',1),(46,'asteriskinfo','2.8.0.2',1),(47,'customerdb','2.5.0.4',1),(48,'dundicheck','2.8.0.0',1),(49,'gabcast','2.5.0.2',1),(50,'inventorydb','2.5.0.2',1),(51,'javassh','2.8.0.1',1),(52,'phpagiconf','2.8.0.0',1),(53,'phpinfo','2.8.0.0',1),(54,'printextensions','2.8.0.0',1),(55,'weakpasswords','2.8.0.0',1),(56,'sipstation','2.8.0.8',1),(58,'iaxsettings','2.8.0.0',1),(63,'fax','2.8.0.5',1);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `module` varchar(24) NOT NULL default '',
  `id` varchar(24) NOT NULL default '',
  `level` int(11) NOT NULL default '0',
  `display_text` varchar(255) NOT NULL default '',
  `extended_text` blob NOT NULL,
  `link` varchar(255) NOT NULL default '',
  `reset` tinyint(4) NOT NULL default '0',
  `candelete` tinyint(4) NOT NULL default '0',
  `timestamp` int(11) NOT NULL default '0',
  PRIMARY KEY  (`module`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES ('freepbx','NEWMODS',600,'8 New modules are available','The following new modules are available for download. Click delete icon on the right to remove this notice.<br />bulkdids (2.5.0.3)<br />vmailadmin (2.5.7.1)<br />setcid (2.8.2)<br />gabcast (2.5.0.1)<br />customerdb (2.5.0.4)<br />inventorydb (2.5.0.2)<br />customcontexts (2.8.0rc1.1)<br />bulkextensions (2.7.0.1)<br />','',0,1,1374548102),('freepbx','NOEMAIL',600,'No email address for online update checks','You are automatically checking for online updates nightly but you have no email address setup to send the results. This can be set on the General Tab. They will continue to show up here.','',0,0,1376938501),('weakpasswords','all',200,'1 extension/trunk has weak secret','Warning: The use of weak SIP/IAX passwords can compromise this system resulting in toll theft of your telephony service.  You should change the reported devices and trunks to use strong secrets.<br /><br />SIP Trunk: 8119319275 / Secret less than 6 digits<br>','',0,0,1376940093),('ivr','DIRECTORY_DEPRECATED',600,'Deprecated Directory used by 1 IVRs','There are 1 IVRs that have the legacy Directory dialing enabled. This has been deprecated and will be removed from future releases. You should convert your IVRs to use the Directory module for this functionality and assign an IVR destination to a desired Directory. You can install the Directory module from the Online Module Repository','',0,1,1295646727),('retrieve_conf','BADDEST',400,'There are 2 bad destinations','DEST STATUS: EMPTY\n   Queue: Mambo (1000)\n   Queue: 360 (1001)\n','',0,0,1376940093),('freepbx','NEWUPDATES',300,'There are 8 modules available for online upgrades','conferences 2.8.0.4 (current: 2.8.0.3)\ncore 2.8.1.2 (current: 2.8.1.0)\nlogfiles 2.8.0.1 (current: 2.8.0.0)\nlanguages 2.8.0.3 (current: 2.8.0.2)\nframework 2.8.1.5 (current: 2.8.1.4)\nfw_ari 2.8.0.8 (current: 2.8.0.6)\nfw_fop 2.8.0.7 (current: 2.8.0.6)\nphonebook 2.8.0.2 (current: 2.8.0.1)\n','',0,0,1376884502);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound_route_patterns`
--

DROP TABLE IF EXISTS `outbound_route_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbound_route_patterns` (
  `route_id` int(11) NOT NULL,
  `match_pattern_prefix` varchar(60) NOT NULL default '',
  `match_pattern_pass` varchar(60) NOT NULL default '',
  `match_cid` varchar(60) NOT NULL default '',
  `prepend_digits` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`route_id`,`match_pattern_prefix`,`match_pattern_pass`,`match_cid`,`prepend_digits`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound_route_patterns`
--

LOCK TABLES `outbound_route_patterns` WRITE;
/*!40000 ALTER TABLE `outbound_route_patterns` DISABLE KEYS */;
INSERT INTO `outbound_route_patterns` VALUES (2,'','528000220276','',''),(3,'','0505','',''),(4,'','20001100','',''),(5,'9','00.','',''),(5,'9','01800.','',''),(5,'9','01XXXXXXXXXX','',''),(5,'9','044XXXXXXXXXX','',''),(5,'9','045XXXXXXXXXX','',''),(5,'9','XXXXXXXX','',''),(6,'','91191104455XXXXXXXX','',''),(6,'','91191104581XXXXXXXX','',''),(6,'','91191155XXXXXXXX','',''),(6,'','91291204455XXXXXXXX','',''),(6,'','91291204581XXXXXXXX','',''),(6,'','91291255XXXXXXXX','',''),(6,'7','00.','',''),(6,'7','01800.','',''),(6,'7','01XXXXXXXXXX','',''),(6,'7','045XXXXXXXXXX','',''),(7,'7','XXXXXXXX','',''),(8,'7','044XXXXXXXXXX','','');
/*!40000 ALTER TABLE `outbound_route_patterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound_route_sequence`
--

DROP TABLE IF EXISTS `outbound_route_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbound_route_sequence` (
  `route_id` int(11) NOT NULL,
  `seq` int(11) NOT NULL,
  PRIMARY KEY  (`route_id`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound_route_sequence`
--

LOCK TABLES `outbound_route_sequence` WRITE;
/*!40000 ALTER TABLE `outbound_route_sequence` DISABLE KEYS */;
INSERT INTO `outbound_route_sequence` VALUES (2,0),(3,1),(4,2),(5,3),(6,4),(7,5),(8,6);
/*!40000 ALTER TABLE `outbound_route_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound_route_trunks`
--

DROP TABLE IF EXISTS `outbound_route_trunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbound_route_trunks` (
  `route_id` int(11) NOT NULL,
  `trunk_id` int(11) NOT NULL,
  `seq` int(11) NOT NULL,
  PRIMARY KEY  (`route_id`,`trunk_id`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound_route_trunks`
--

LOCK TABLES `outbound_route_trunks` WRITE;
/*!40000 ALTER TABLE `outbound_route_trunks` DISABLE KEYS */;
INSERT INTO `outbound_route_trunks` VALUES (2,5,0),(2,6,1),(3,2,0),(4,8,0),(5,4,0),(6,8,0),(7,8,0),(8,8,0);
/*!40000 ALTER TABLE `outbound_route_trunks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound_routes`
--

DROP TABLE IF EXISTS `outbound_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbound_routes` (
  `route_id` int(11) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `outcid` varchar(40) default NULL,
  `outcid_mode` varchar(20) default NULL,
  `password` varchar(30) default NULL,
  `emergency_route` varchar(4) default NULL,
  `intracompany_route` varchar(4) default NULL,
  `mohclass` varchar(80) default NULL,
  `time_group_id` int(11) default NULL,
  PRIMARY KEY  (`route_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound_routes`
--

LOCK TABLES `outbound_routes` WRITE;
/*!40000 ALTER TABLE `outbound_routes` DISABLE KEYS */;
INSERT INTO `outbound_routes` VALUES (3,'Vozero','','','','','','default',NULL),(2,'Melia','','','','','','default',NULL),(4,'Mentus','','','','','','default',NULL),(5,'Mambo','','','','','','default',NULL),(6,'Nextor','','','','','','default',NULL),(7,'Locales','','','','','','default',NULL),(8,'Celulares','','','','','','default',NULL);
/*!40000 ALTER TABLE `outbound_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outroutemsg`
--

DROP TABLE IF EXISTS `outroutemsg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outroutemsg` (
  `keyword` varchar(40) NOT NULL default '',
  `data` varchar(10) NOT NULL,
  PRIMARY KEY  (`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outroutemsg`
--

LOCK TABLES `outroutemsg` WRITE;
/*!40000 ALTER TABLE `outroutemsg` DISABLE KEYS */;
/*!40000 ALTER TABLE `outroutemsg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paging_autoanswer`
--

DROP TABLE IF EXISTS `paging_autoanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paging_autoanswer` (
  `useragent` varchar(255) NOT NULL,
  `var` varchar(20) NOT NULL,
  `setting` varchar(255) NOT NULL,
  PRIMARY KEY  (`useragent`,`var`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paging_autoanswer`
--

LOCK TABLES `paging_autoanswer` WRITE;
/*!40000 ALTER TABLE `paging_autoanswer` DISABLE KEYS */;
INSERT INTO `paging_autoanswer` VALUES ('default','CALLINFO','Call-Info: <uri>\\;answer-after=0'),('default','ALERTINFO','Alert-Info: Ring Answer'),('default','SIPURI','intercom=true'),('Mitel','CALLINFO','Call-Info: <sip:broadworks.net>\\;answer-after=0');
/*!40000 ALTER TABLE `paging_autoanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paging_config`
--

DROP TABLE IF EXISTS `paging_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paging_config` (
  `page_group` varchar(255) NOT NULL default '',
  `force_page` int(1) NOT NULL,
  `duplex` int(1) NOT NULL default '0',
  `description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`page_group`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paging_config`
--

LOCK TABLES `paging_config` WRITE;
/*!40000 ALTER TABLE `paging_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `paging_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paging_groups`
--

DROP TABLE IF EXISTS `paging_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paging_groups` (
  `page_number` varchar(50) NOT NULL default '',
  `ext` varchar(25) NOT NULL default '',
  PRIMARY KEY  (`page_number`,`ext`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paging_groups`
--

LOCK TABLES `paging_groups` WRITE;
/*!40000 ALTER TABLE `paging_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `paging_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkinglot`
--

DROP TABLE IF EXISTS `parkinglot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parkinglot` (
  `id` varchar(20) NOT NULL default '1',
  `keyword` varchar(40) NOT NULL default '',
  `data` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`id`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkinglot`
--

LOCK TABLES `parkinglot` WRITE;
/*!40000 ALTER TABLE `parkinglot` DISABLE KEYS */;
/*!40000 ALTER TABLE `parkinglot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phpagiconf`
--

DROP TABLE IF EXISTS `phpagiconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpagiconf` (
  `phpagiid` int(11) NOT NULL auto_increment,
  `debug` tinyint(1) default NULL,
  `error_handler` tinyint(1) default NULL,
  `err_email` varchar(50) default NULL,
  `hostname` varchar(255) default NULL,
  `tempdir` varchar(255) default NULL,
  `festival_text2wave` varchar(255) default NULL,
  `asman_server` varchar(255) default NULL,
  `asman_port` int(11) NOT NULL,
  `asman_user` varchar(50) default NULL,
  `asman_secret` varchar(255) default NULL,
  `cepstral_swift` varchar(255) default NULL,
  `cepstral_voice` varchar(50) default NULL,
  `setuid` tinyint(1) default NULL,
  `basedir` varchar(255) default NULL,
  PRIMARY KEY  (`phpagiid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phpagiconf`
--

LOCK TABLES `phpagiconf` WRITE;
/*!40000 ALTER TABLE `phpagiconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `phpagiconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pinset_usage`
--

DROP TABLE IF EXISTS `pinset_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pinset_usage` (
  `pinsets_id` int(11) NOT NULL,
  `dispname` varchar(30) NOT NULL default '',
  `foreign_id` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`dispname`,`foreign_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pinset_usage`
--

LOCK TABLES `pinset_usage` WRITE;
/*!40000 ALTER TABLE `pinset_usage` DISABLE KEYS */;
INSERT INTO `pinset_usage` VALUES (2,'routing','7'),(1,'routing','8');
/*!40000 ALTER TABLE `pinset_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pinsets`
--

DROP TABLE IF EXISTS `pinsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pinsets` (
  `pinsets_id` int(11) NOT NULL auto_increment,
  `passwords` longtext,
  `description` varchar(50) default NULL,
  `addtocdr` tinyint(1) default NULL,
  `deptname` varchar(50) default NULL,
  PRIMARY KEY  (`pinsets_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pinsets`
--

LOCK TABLES `pinsets` WRITE;
/*!40000 ALTER TABLE `pinsets` DISABLE KEYS */;
INSERT INTO `pinsets` VALUES (1,'123\n456\n789','Celulares',1,''),(2,'123\n789','Locales',1,''),(3,'123\n456','LDI',1,'');
/*!40000 ALTER TABLE `pinsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queueprio`
--

DROP TABLE IF EXISTS `queueprio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queueprio` (
  `queueprio_id` int(11) NOT NULL auto_increment,
  `queue_priority` varchar(50) default NULL,
  `description` varchar(50) default NULL,
  `dest` varchar(255) default NULL,
  PRIMARY KEY  (`queueprio_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queueprio`
--

LOCK TABLES `queueprio` WRITE;
/*!40000 ALTER TABLE `queueprio` DISABLE KEYS */;
/*!40000 ALTER TABLE `queueprio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queues_config`
--

DROP TABLE IF EXISTS `queues_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queues_config` (
  `extension` varchar(20) NOT NULL default '',
  `descr` varchar(35) NOT NULL default '',
  `grppre` varchar(100) NOT NULL default '',
  `alertinfo` varchar(254) NOT NULL default '',
  `ringing` tinyint(1) NOT NULL default '0',
  `maxwait` varchar(8) NOT NULL default '',
  `password` varchar(20) NOT NULL default '',
  `ivr_id` varchar(8) NOT NULL default '0',
  `dest` varchar(50) NOT NULL default '',
  `cwignore` tinyint(1) NOT NULL default '0',
  `qregex` varchar(255) default NULL,
  `agentannounce_id` int(11) default NULL,
  `joinannounce_id` int(11) default NULL,
  `queuewait` tinyint(1) default '0',
  `use_queue_context` tinyint(1) default '0',
  `togglehint` tinyint(1) default '0',
  PRIMARY KEY  (`extension`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queues_config`
--

LOCK TABLES `queues_config` WRITE;
/*!40000 ALTER TABLE `queues_config` DISABLE KEYS */;
INSERT INTO `queues_config` VALUES ('1002','Nextor Atn','ANextor- ','',0,'40','','none','ext-queues,1003,1',1,'',0,0,0,0,0),('1003','Nextor Soporte','SNextor- ','',0,'40','','none','ext-group,600,1',1,'',0,0,0,0,0),('1004','Vozero Atn','AVozero- ','',0,'40','','none','ext-queues,1005,1',1,'',0,0,0,0,0),('1005','Vozero Soporte','SVozero- ','',0,'40','','none','ext-group,602,1',1,'',0,0,0,0,0),('1000','Mambo','Mambo- ','',0,'','','none','',0,'',0,0,0,0,0),('1001','360','360- ','',0,'','','none','',0,'',0,0,0,0,0);
/*!40000 ALTER TABLE `queues_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queues_details`
--

DROP TABLE IF EXISTS `queues_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queues_details` (
  `id` varchar(45) NOT NULL default '-1',
  `keyword` varchar(30) NOT NULL default '',
  `data` varchar(150) NOT NULL default '',
  `flags` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`,`keyword`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queues_details`
--

LOCK TABLES `queues_details` WRITE;
/*!40000 ALTER TABLE `queues_details` DISABLE KEYS */;
INSERT INTO `queues_details` VALUES ('1000','ringinuse','yes',0),('1000','eventwhencalled','no',0),('1000','eventmemberstatus','no',0),('1000','weight','0',0),('1000','autofill','no',0),('1000','joinempty','yes',0),('1000','leavewhenempty','no',0),('1000','strategy','ringall',0),('1000','timeout','15',0),('1000','retry','5',0),('1000','wrapuptime','0',0),('1000','announce-frequency','0',0),('1000','announce-holdtime','no',0),('1000','announce-position','no',0),('1000','queue-youarenext','silence/1',0),('1000','queue-thereare','silence/1',0),('1000','maxlen','0',0),('1001','periodic-announce-frequency','0',0),('1001','eventmemberstatus','no',0),('1001','maxlen','0',0),('1001','joinempty','yes',0),('1001','leavewhenempty','no',0),('1001','strategy','ringall',0),('1001','timeout','15',0),('1001','retry','5',0),('1001','wrapuptime','0',0),('1001','announce-frequency','0',0),('1001','announce-holdtime','no',0),('1001','announce-position','no',0),('1001','queue-youarenext','silence/1',0),('1001','queue-thereare','silence/1',0),('1001','queue-callswaiting','silence/1',0),('1001','queue-thankyou','',0),('1000','monitor-join','yes',0),('1002','member','SIP/460,0',0),('1002','member','SIP/466,0',1),('1002','member','SIP/4660,0',2),('1002','music','queues',0),('1002','monitor-format','wav49',0),('1002','monitor-join','yes',0),('1002','eventwhencalled','yes',0),('1002','eventmemberstatus','yes',0),('1002','leavewhenempty','no',0),('1002','strategy','ringall',0),('1002','timeout','15',0),('1002','retry','1',0),('1002','wrapuptime','0',0),('1002','announce-frequency','0',0),('1002','announce-holdtime','no',0),('1002','announce-position','no',0),('1002','queue-youarenext','silence/1',0),('1002','queue-thereare','silence/1',0),('1003','timeout','15',0),('1003','retry','1',0),('1003','wrapuptime','0',0),('1003','announce-frequency','0',0),('1003','announce-holdtime','no',0),('1003','announce-position','no',0),('1003','queue-youarenext','silence/1',0),('1003','queue-thereare','silence/1',0),('1003','queue-callswaiting','silence/1',0),('1003','queue-thankyou','',0),('1003','periodic-announce-frequency','0',0),('1003','monitor-format','wav49',0),('1003','monitor-join','yes',0),('1003','eventwhencalled','yes',0),('1003','eventmemberstatus','yes',0),('1003','weight','0',0),('1003','autofill','yes',0),('1003','ringinuse','yes',0),('1003','reportholdtime','no',0),('1002','autofill','yes',0),('1002','ringinuse','yes',0),('1002','reportholdtime','no',0),('1002','servicelevel','60',0),('1002','maxlen','0',0),('1002','joinempty','yes',0),('1003','member','SIP/463,0',5),('1003','member','SIP/469,0',4),('1003','member','SIP/468,0',3),('1003','member','SIP/4660,0',2),('1003','member','SIP/466,0',1),('1004','music','queues',0),('1004','member','SIP/460,0',0),('1004','member','SIP/466,0',1),('1004','member','SIP/469,0',2),('1004','reportholdtime','no',0),('1004','monitor-format','wav49',0),('1004','monitor-join','yes',0),('1004','retry','1',0),('1004','wrapuptime','0',0),('1004','announce-frequency','0',0),('1004','announce-holdtime','no',0),('1004','announce-position','no',0),('1004','queue-youarenext','silence/1',0),('1004','queue-thereare','silence/1',0),('1004','queue-callswaiting','silence/1',0),('1004','queue-thankyou','',0),('1004','periodic-announce-frequency','0',0),('1005','member','SIP/468,0',2),('1005','announce-frequency','0',0),('1005','announce-holdtime','no',0),('1005','announce-position','no',0),('1005','strategy','ringall',0),('1005','queue-youarenext','silence/1',0),('1005','queue-thereare','silence/1',0),('1005','queue-callswaiting','silence/1',0),('1005','queue-thankyou','',0),('1005','periodic-announce-frequency','0',0),('1005','monitor-format','wav49',0),('1005','wrapuptime','0',0),('1005','timeout','15',0),('1005','retry','1',0),('1005','maxlen','0',0),('1005','joinempty','yes',0),('1005','leavewhenempty','no',0),('1004','maxlen','0',0),('1004','joinempty','yes',0),('1004','leavewhenempty','no',0),('1004','strategy','ringall',0),('1004','timeout','15',0),('1005','monitor-join','yes',0),('1005','eventwhencalled','yes',0),('1005','eventmemberstatus','yes',0),('1005','weight','0',0),('1005','autofill','yes',0),('1005','ringinuse','yes',0),('1005','reportholdtime','no',0),('1002','weight','0',0),('1002','queue-callswaiting','silence/1',0),('1002','queue-thankyou','',0),('1002','periodic-announce-frequency','0',0),('1003','member','SIP/460,0',0),('1003','music','queues',0),('1000','member','Local/463@from-queue/n,0',1),('1000','monitor-format','',0),('1000','queue-callswaiting','silence/1',0),('1000','queue-thankyou','',0),('1000','periodic-announce-frequency','0',0),('1001','weight','0',0),('1001','autofill','no',0),('1001','ringinuse','yes',0),('1001','reportholdtime','no',0),('1001','monitor-join','yes',0),('1001','monitor-format','',0),('1004','servicelevel','60',0),('1004','eventmemberstatus','yes',0),('1004','eventwhencalled','yes',0),('1005','servicelevel','60',0),('1005','music','queues',0),('1005','member','SIP/460,0',0),('1005','member','SIP/466,0',1),('1000','reportholdtime','no',0),('1000','servicelevel','60',0),('1000','music','queues',0),('1001','eventwhencalled','no',0),('1003','servicelevel','60',0),('1003','strategy','ringall',0),('1003','leavewhenempty','no',0),('1004','weight','0',0),('1004','ringinuse','yes',0),('1004','autofill','yes',0),('1003','joinempty','strict',0),('1003','maxlen','0',0),('1000','member','Local/460@from-queue/n,0',0),('1001','servicelevel','60',0),('1002','member','SIP/469,0',3),('1004','member','SIP/468,0',3),('1005','member','SIP/469,0',3),('1001','music','queues',0),('1001','member','Local/460@from-queue/n,0',0),('1001','member','Local/463@from-queue/n,0',1),('1002','member','SIP/468,0',4),('1002','member','SIP/463,0',5);
/*!40000 ALTER TABLE `queues_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recordings`
--

DROP TABLE IF EXISTS `recordings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recordings` (
  `id` int(11) NOT NULL auto_increment,
  `displayname` varchar(50) default NULL,
  `filename` blob,
  `description` varchar(254) default NULL,
  `fcode` tinyint(1) default '0',
  `fcode_pass` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recordings`
--

LOCK TABLES `recordings` WRITE;
/*!40000 ALTER TABLE `recordings` DISABLE KEYS */;
INSERT INTO `recordings` VALUES (1,'__invalid','install done','',0,NULL),(3,'360_Dia','custom/360_Dia','No long description available',0,NULL),(4,'Buzon','custom/Buzon','No long description available',0,NULL),(5,'Mambo_IVR_Dia','custom/Mambo_IVR_Dia','No long description available',0,NULL),(6,'Mambo_IVR_Noche','custom/Mambo_IVR_Noche','No long description available',0,NULL),(7,'MAMBOCAMBIO_TEL_81','custom/MAMBOCAMBIO_TEL_81','No long description available',0,NULL),(8,'MAMBOCAMBIO_TEL_222','custom/MAMBOCAMBIO_TEL_222','No long description available',0,NULL),(9,'MAMBOCAMBIO_TEL_442','custom/MAMBOCAMBIO_TEL_442','No long description available',0,NULL),(10,'MAMBOCAMBIO_TEL_443','custom/MAMBOCAMBIO_TEL_443','No long description available',0,NULL),(11,'MAMBOCAMBIO_TEL_477','custom/MAMBOCAMBIO_TEL_477','No long description available',0,NULL),(12,'MAMBOCAMBIO_TEL_722','custom/MAMBOCAMBIO_TEL_722','No long description available',0,NULL),(13,'MAMBOCAMBIO_TEL_777','custom/MAMBOCAMBIO_TEL_777','No long description available',0,NULL),(14,'MAMBOCAMBIO_TEL_DF','custom/MAMBOCAMBIO_TEL_DF','No long description available',0,NULL),(15,'Nextor_IVR_Dia','custom/Nextor_IVR_Dia','No long description available',0,NULL),(16,'Nextor_IVR_Noche','custom/Nextor_IVR_Noche','No long description available',0,NULL),(17,'nextorsptnocontesta','custom/nextorsptnocontesta','No long description available',0,NULL),(18,'vozerointro','custom/vozerointro','No long description available',0,NULL),(19,'vozerointroa','custom/vozerointroa','No long description available',0,NULL),(20,'vozeronoche','custom/vozeronoche','No long description available',0,NULL),(21,'vozerosptnocontesta','custom/vozerosptnocontesta','No long description available',0,NULL),(22,'vozerovm','custom/vozerovm','No long description available',0,NULL),(23,'vozerovma','custom/vozerovma','No long description available',0,NULL),(24,'GpoSimetric','custom/GpoSimetric','No hay una descripciÃ³n disponible',0,NULL),(25,'GpoH','custom/GpoH','No hay una descripciÃ³n disponible',0,NULL),(26,'TravelNoGrabado','custom/TravelNoGrabado','No hay una descripciÃ³n disponible',0,NULL),(27,'TravelNoGrabado2','custom/TravelNoGrabado2','No hay una descripciÃ³n disponible',0,NULL),(28,'GSALeasing','custom/GSALeasing','No hay una descripciÃ³n disponible',0,NULL),(29,'TravelNoGrabado3','custom/TravelNoGrabado3','No hay una descripciÃ³n disponible',0,NULL);
/*!40000 ALTER TABLE `recordings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ringgroups`
--

DROP TABLE IF EXISTS `ringgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ringgroups` (
  `grpnum` varchar(20) NOT NULL,
  `strategy` varchar(50) NOT NULL,
  `grptime` smallint(6) NOT NULL,
  `grppre` varchar(100) default NULL,
  `grplist` varchar(255) NOT NULL,
  `annmsg_id` int(11) default NULL,
  `postdest` varchar(255) default NULL,
  `description` varchar(35) NOT NULL,
  `alertinfo` varchar(255) default NULL,
  `remotealert_id` int(11) default NULL,
  `needsconf` varchar(10) default NULL,
  `toolate_id` int(11) default NULL,
  `ringing` varchar(80) default NULL,
  `cwignore` varchar(10) default NULL,
  `cfignore` varchar(10) default NULL,
  PRIMARY KEY  (`grpnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ringgroups`
--

LOCK TABLES `ringgroups` WRITE;
/*!40000 ALTER TABLE `ringgroups` DISABLE KEYS */;
INSERT INTO `ringgroups` VALUES ('603','ringall',1,'','0813#',0,'app-announcement-1,s,1','SoporteNextorMail','',0,'',0,'Ring','',''),('600','ringall',22,'','9119110445515023672#-9119110445540554516#-9119115546205936#-9119110458119178432#',0,'ext-group,603,1','SoporteNextor','',0,'CHECKED',0,'Ring','',''),('601','ringall',60,'','468-6000',0,'app-blackhole,hangup,1','Chucho','',0,'',0,'Ring','',''),('602','ringall',22,'','9129120445515023672#-9129120445540554516#-9129125546205936#-9129120458119178432#',0,'ext-group,604,1','SoporteVozero','',0,'CHECKED',0,'Ring','',''),('604','ringall',1,'','0814#',0,'app-announcement-4,s,1','SoproteVozeroMail','',0,'',0,'Ring','','');
/*!40000 ALTER TABLE `ringgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sip`
--

DROP TABLE IF EXISTS `sip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sip` (
  `id` varchar(20) NOT NULL default '-1',
  `keyword` varchar(30) NOT NULL default '',
  `data` varchar(255) NOT NULL,
  `flags` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sip`
--

LOCK TABLES `sip` WRITE;
/*!40000 ALTER TABLE `sip` DISABLE KEYS */;
INSERT INTO `sip` VALUES ('tr-peer-3','account','8119319275',2),('tr-peer-3','username','10002981393ip',3),('tr-peer-3','type','friend',4),('tr-peer-3','secret','7891',5),('tr-peer-3','qualify','yes',6),('tr-peer-3','insecure','very',7),('tr-peer-3','host','mty13.axtel.net',8),('tr-peer-3','fromuser','10002981393ip',9),('tr-peer-3','fromdomain','mty13.axtel.net',10),('tr-peer-3','dtmfmode','rfc2833',11),('tr-peer-3','disallow','all',12),('tr-peer-3','context','from-pstn',13),('tr-peer-3','canreinvite','no',14),('tr-peer-3','allow','alaw&ulaw&gsm',15),('tr-peer-3','port','5060',16),('tr-reg-3','register','10002981393ip:7891@mty12.axtel.net/8119319275',0),('tr-peer-4','account','mambo',2),('tr-peer-4','type','peer',3),('tr-peer-4','qualify','yes',4),('tr-peer-4','port','5060',5),('tr-peer-4','host','209.190.122.218',6),('tr-peer-4','dtmfmode','rfc2833',7),('tr-peer-4','disallow','all',8),('tr-peer-4','allow','gsm&ulaw&alaw&g729',9),('tr-peer-5','account','Melia1',2),('tr-peer-5','host','209.177.157.85',3),('tr-peer-5','type','peer',4),('tr-peer-5','qualify','yes',5),('tr-peer-6','account','Melia2',2),('tr-peer-6','host','192.73.243.199',3),('tr-peer-6','type','peer',4),('tr-peer-6','qualify','yes',5),('tr-peer-7','account','Meliaregistro',2),('tr-peer-7','host','209.190.122.218',3),('tr-peer-7','username','16$MezzaAntoUc',4),('tr-peer-7','secret','H9vOnJALts1',5),('tr-peer-7','type','peer',6),('tr-reg-7','register','16$MezzaAntoUc:H9vOnJALts1@209.190.122.218',0),('tr-peer-8','dtmfmode','rfc2833',7),('tr-peer-8','disallow','all',8),('tr-peer-8','account','Nextor',2),('tr-peer-8','type','peer',3),('tr-peer-8','qualify','yes',4),('tr-peer-8','port','5060',5),('tr-peer-8','host','209.190.122.218',6),('4660','deny','0.0.0.0/0.0.0.0',18),('4660','permit','0.0.0.0/0.0.0.0',19),('4660','account','4660',20),('4660','mailbox','4660@device',17),('4660','dtmfmode','rfc2833',3),('4660','canreinvite','no',4),('4660','context','from-internal',5),('4660','host','dynamic',6),('4660','type','friend',7),('4660','nat','yes',8),('4660','port','5060',9),('4660','qualify','yes',10),('4660','callgroup','',11),('4660','pickupgroup','',12),('4660','secret','asfxdgERHCSe23s2.x46444$.ssQ',2),('469','record_in','Always',22),('469','mailbox','469@device',17),('469','deny','0.0.0.0/0.0.0.0',18),('469','permit','0.0.0.0/0.0.0.0',19),('469','account','469',20),('469','callerid','device <469>',21),('469','disallow','',13),('469','allow','',14),('469','dial','SIP/469',15),('469','accountcode','',16),('469','secret','N@tryeh67.hsfkjsdNtGr',2),('469','dtmfmode','rfc2833',3),('469','canreinvite','no',4),('469','context','from-internal',5),('466','callerid','device <466>',21),('466','record_in','Always',22),('466','record_out','Always',23),('466','account','466',20),('466','secret','ahyt/uhjh/jhlkdsjfl$54',2),('466','permit','0.0.0.0/0.0.0.0',19),('466','pickupgroup','',12),('466','disallow','',13),('466','allow','',14),('466','dial','SIP/466',15),('466','accountcode','',16),('466','mailbox','466@device',17),('466','deny','0.0.0.0/0.0.0.0',18),('466','dtmfmode','rfc2833',3),('466','canreinvite','no',4),('466','context','from-internal',5),('466','host','dynamic',6),('466','type','friend',7),('466','nat','yes',8),('466','port','5060',9),('469','type','friend',7),('469','nat','yes',8),('469','port','5060',9),('469','qualify','yes',10),('469','callgroup','',11),('460','record_in','Always',22),('460','permit','0.0.0.0/0.0.0.0',19),('460','account','460',20),('460','callerid','device <460>',21),('460','dtmfmode','rfc2833',3),('460','canreinvite','no',4),('460','context','from-internal',5),('460','host','dynamic',6),('460','type','friend',7),('460','secret','vdwokfvwrufscf5841654))(',2),('460','disallow','',13),('460','callgroup','',11),('460','pickupgroup','',12),('460','nat','yes',8),('468','record_in','Always',22),('468','callerid','device <468>',21),('468','accountcode','',16),('468','mailbox','468@default',17),('468','deny','0.0.0.0/0.0.0.0',18),('468','permit','0.0.0.0/0.0.0.0',19),('468','qualify','yes',10),('468','callgroup','',11),('468','pickupgroup','',12),('468','disallow','',13),('468','allow','',14),('468','dial','SIP/468',15),('468','secret','rim_ott(Cr#(pu)#',2),('468','dtmfmode','rfc2833',3),('464','accountcode','',16),('464','mailbox','464@device',17),('464','deny','0.0.0.0/0.0.0.0',18),('464','dial','SIP/464',15),('464','dtmfmode','rfc2833',3),('464','canreinvite','no',4),('464','context','from-internal',5),('464','host','dynamic',6),('464','type','friend',7),('464','nat','yes',8),('464','port','5060',9),('464','qualify','yes',10),('464','callgroup','',11),('464','secret','macapaca3%4kvdfdWkP.54$',2),('460','dial','SIP/460',15),('460','accountcode','',16),('460','mailbox','460@device',17),('460','deny','0.0.0.0/0.0.0.0',18),('460','allow','',14),('463','accountcode','',16),('463','mailbox','463@device',17),('463','deny','0.0.0.0/0.0.0.0',18),('463','dial','SIP/463',15),('463','dtmfmode','rfc2833',3),('463','canreinvite','no',4),('463','context','from-internal',5),('463','host','dynamic',6),('463','type','friend',7),('463','nat','yes',8),('463','port','5060',9),('463','qualify','yes',10),('463','callgroup','',11),('463','secret','dfonfDDJ649841!!!cdkdDdD',2),('464','permit','0.0.0.0/0.0.0.0',19),('464','allow','',14),('464','account','464',20),('464','disallow','',13),('464','pickupgroup','',12),('466','callgroup','',11),('466','qualify','yes',10),('468','record_out','Always',23),('468','host','dynamic',6),('468','type','friend',7),('468','nat','yes',8),('468','port','5060',9),('469','pickupgroup','',12),('4660','accountcode','',16),('4660','dial','SIP/4660',15),('4660','callerid','device <4660>',21),('4660','allow','',14),('4660','disallow','',13),('470','secret','ulreHous+*_*',2),('470','dtmfmode','rfc2833',3),('470','canreinvite','no',4),('470','context','from-internal',5),('470','host','dynamic',6),('470','type','friend',7),('470','nat','yes',8),('470','port','5060',9),('470','qualify','yes',10),('470','callgroup','',11),('470','pickupgroup','',12),('470','disallow','',13),('470','allow','',14),('470','dial','SIP/470',15),('470','accountcode','',16),('470','mailbox','470@device',17),('470','deny','0.0.0.0/0.0.0.0',18),('470','permit','0.0.0.0/0.0.0.0',19),('470','account','470',20),('470','callerid','device <470>',21),('470','record_in','Adhoc',22),('470','record_out','Adhoc',23),('999','secret','999Abc123$',2),('999','dtmfmode','rfc2833',3),('999','canreinvite','no',4),('999','context','from-internal',5),('999','host','dynamic',6),('999','type','friend',7),('999','nat','yes',8),('999','port','5060',9),('999','qualify','yes',10),('999','callgroup','',11),('999','pickupgroup','',12),('999','disallow','',13),('999','allow','',14),('999','dial','SIP/999',15),('999','accountcode','',16),('999','mailbox','999@device',17),('999','deny','0.0.0.0/0.0.0.0',18),('999','permit','0.0.0.0/0.0.0.0',19),('999','account','999',20),('999','callerid','device <999>',21),('999','record_in','Adhoc',22),('999','record_out','Adhoc',23),('4680','dtmfmode','rfc2833',3),('4680','canreinvite','no',4),('4680','context','from-internal',5),('4680','secret','Au14785236',2),('4680','port','5060',9),('4680','nat','yes',8),('4680','qualify','yes',10),('4680','callgroup','',11),('4680','pickupgroup','',12),('4680','disallow','',13),('4680','allow','',14),('4680','dial','SIP/4680',15),('4680','accountcode','',16),('4680','type','friend',7),('4680','host','dynamic',6),('4690','secret','Nomames4747!!TalBes2',2),('4690','dtmfmode','rfc2833',3),('4690','canreinvite','no',4),('4690','context','from-internal',5),('4690','host','dynamic',6),('4690','type','friend',7),('4690','nat','yes',8),('4690','port','5060',9),('4690','qualify','yes',10),('4690','callgroup','',11),('4690','pickupgroup','',12),('4690','disallow','',13),('4690','allow','',14),('4690','dial','SIP/4690',15),('4690','accountcode','',16),('4690','mailbox','4690@device',17),('4690','deny','0.0.0.0/0.0.0.0',18),('4690','permit','0.0.0.0/0.0.0.0',19),('4690','account','4690',20),('4690','callerid','device <4690>',21),('4690','record_in','Adhoc',22),('4690','record_out','Adhoc',23),('5000','secret','1q2w3efre',2),('5000','dtmfmode','rfc2833',3),('5000','canreinvite','no',4),('5000','context','from-internal',5),('5000','host','dynamic',6),('5000','type','friend',7),('5000','nat','yes',8),('5000','port','5060',9),('5000','qualify','yes',10),('5000','callgroup','',11),('5000','pickupgroup','',12),('5000','disallow','',13),('5000','allow','',14),('5000','dial','SIP/5000',15),('5000','accountcode','',16),('5000','mailbox','5000@device',17),('5000','deny','0.0.0.0/0.0.0.0',18),('5000','permit','0.0.0.0/0.0.0.0',19),('5000','account','5000',20),('5000','callerid','device <5000>',21),('5000','record_in','Adhoc',22),('5000','record_out','Adhoc',23),('5001','secret','5001Au#H87UIsaa',2),('5001','dtmfmode','rfc2833',3),('5001','canreinvite','no',4),('5001','context','from-internal',5),('5001','host','dynamic',6),('5001','type','friend',7),('5001','nat','yes',8),('5001','port','5060',9),('5001','qualify','yes',10),('5001','callgroup','',11),('5001','pickupgroup','',12),('5001','disallow','',13),('5001','allow','',14),('5001','dial','SIP/5001',15),('5001','accountcode','',16),('5001','mailbox','5001@device',17),('5001','deny','0.0.0.0/0.0.0.0',18),('5001','permit','0.0.0.0/0.0.0.0',19),('5001','account','5001',20),('5001','callerid','device <5001>',21),('5001','record_in','Adhoc',22),('5001','record_out','Adhoc',23),('5002','secret','nzxt/14540020@$',2),('5002','dtmfmode','rfc2833',3),('5002','canreinvite','no',4),('5002','context','from-internal',5),('5002','host','dynamic',6),('5002','type','friend',7),('5002','nat','yes',8),('5002','port','5060',9),('5002','qualify','yes',10),('5002','callgroup','',11),('5002','pickupgroup','',12),('5002','disallow','',13),('5002','allow','',14),('5002','dial','SIP/5002',15),('5002','accountcode','',16),('5002','mailbox','5002@device',17),('5002','deny','0.0.0.0/0.0.0.0',18),('5002','permit','0.0.0.0/0.0.0.0',19),('5002','account','5002',20),('5002','callerid','device <5002>',21),('5002','record_in','Adhoc',22),('5002','record_out','Adhoc',23),('6000','secret','dfsd6876HJds67GUhkjsdhf768hjkgHJG',2),('6000','dtmfmode','rfc2833',3),('6000','canreinvite','no',4),('6000','context','from-internal',5),('6000','host','dynamic',6),('6000','type','friend',7),('6000','nat','yes',8),('6000','port','5060',9),('6000','qualify','yes',10),('6000','callgroup','',11),('6000','pickupgroup','',12),('6000','disallow','',13),('6000','allow','',14),('6000','dial','SIP/6000',15),('6000','accountcode','',16),('6000','mailbox','6000@device',17),('6000','deny','0.0.0.0/0.0.0.0',18),('6000','permit','0.0.0.0/0.0.0.0',19),('6000','account','6000',20),('6000','callerid','device <6000>',21),('6000','record_in','Adhoc',22),('6000','record_out','Adhoc',23),('6001','secret','5415189ggJ',2),('6001','dtmfmode','rfc2833',3),('6001','canreinvite','no',4),('6001','context','from-internal',5),('6001','host','dynamic',6),('6001','type','friend',7),('6001','nat','yes',8),('6001','port','5060',9),('6001','qualify','yes',10),('6001','callgroup','',11),('6001','pickupgroup','',12),('6001','disallow','',13),('6001','allow','',14),('6001','dial','SIP/6001',15),('6001','accountcode','',16),('6001','mailbox','6001@device',17),('6001','deny','0.0.0.0/0.0.0.0',18),('6001','permit','0.0.0.0/0.0.0.0',19),('6001','account','6001',20),('6001','callerid','device <6001>',21),('6001','record_in','Adhoc',22),('6001','record_out','Adhoc',23),('460','qualify','yes',10),('460','port','5060',9),('468','context','from-internal',5),('4680','mailbox','4680@device',17),('4680','deny','0.0.0.0/0.0.0.0',18),('4680','permit','0.0.0.0/0.0.0.0',19),('4680','account','4680',20),('4680','callerid','device <4680>',21),('4680','record_in','Adhoc',22),('4680','record_out','Adhoc',23),('tr-peer-8','allow','ulaw&alaw',9),('tr-peer-8','context','from-pstn',10),('468','account','468',20),('468','canreinvite','no',4),('463','permit','0.0.0.0/0.0.0.0',19),('463','allow','',14),('463','account','463',20),('463','disallow','',13),('463','pickupgroup','',12),('469','host','dynamic',6),('460','record_out','Always',23),('464','callerid','device <464>',21),('464','record_in','Always',22),('464','record_out','Always',23),('469','record_out','Always',23),('4660','record_in','Always',22),('4660','record_out','Always',23),('463','callerid','device <463>',21),('463','record_in','Adhoc',22),('463','record_out','Adhoc',23);
/*!40000 ALTER TABLE `sip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sipsettings`
--

DROP TABLE IF EXISTS `sipsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sipsettings` (
  `keyword` varchar(50) NOT NULL default '',
  `data` varchar(255) NOT NULL default '',
  `seq` tinyint(1) NOT NULL default '0',
  `type` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`keyword`,`seq`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sipsettings`
--

LOCK TABLES `sipsettings` WRITE;
/*!40000 ALTER TABLE `sipsettings` DISABLE KEYS */;
INSERT INTO `sipsettings` VALUES ('nat','yes',39,0),('nat_mode','externip',10,0),('externip_val','209.190.122.117',40,0),('externhost_val','',40,0),('externrefresh','120',41,0),('localnet_0','172.16.5.0',42,0),('netmask_0','255.255.255.0',0,0),('g726nonstandard','no',10,0),('t38pt_udptl','no',10,0),('videosupport','yes',10,0),('maxcallbitrate','384',10,0),('canreinvite','no',10,0),('rtptimeout','30',10,0),('rtpholdtimeout','300',10,0),('rtpkeepalive','0',10,0),('checkmwi','10',10,0),('notifyringing','yes',10,0),('notifyhold','yes',10,0),('registertimeout','20',10,0),('registerattempts','0',10,0),('maxexpiry','3600',10,0),('minexpiry','60',10,0),('defaultexpiry','120',10,0),('jbenable','no',4,0),('jbforce','no',5,0),('jbimpl','fixed',5,0),('jbmaxsize','200',5,0),('jbresyncthreshold','1000',5,0),('jblog','no',5,0),('sip_language','es',0,0),('context','',0,0),('bindaddr','',2,0),('bindport','',1,0),('allowguest','no',10,0),('srvlookup','no',10,0),('ulaw','1',0,1),('gsm','2',1,1),('alaw','3',2,1),('g729','4',3,1),('lpc10','',4,1),('speex','',5,1),('g722','',6,1),('adpcm','',7,1),('ilbc','',8,1),('slin','',9,1),('g726','',10,1),('g723','',11,1),('g726aal2','',12,1),('h264','1',0,2),('h263p','2',1,2),('h263','3',2,2),('h261','4',3,2);
/*!40000 ALTER TABLE `sipsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeconditions`
--

DROP TABLE IF EXISTS `timeconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeconditions` (
  `timeconditions_id` int(11) NOT NULL auto_increment,
  `displayname` varchar(50) default NULL,
  `time` int(11) default NULL,
  `truegoto` varchar(50) default NULL,
  `falsegoto` varchar(50) default NULL,
  `deptname` varchar(50) default NULL,
  PRIMARY KEY  (`timeconditions_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeconditions`
--

LOCK TABLES `timeconditions` WRITE;
/*!40000 ALTER TABLE `timeconditions` DISABLE KEYS */;
INSERT INTO `timeconditions` VALUES (1,'Mambo',1,'ext-queues,1000,1','ivr-5,s,1',''),(2,'Nextor',2,'ivr-6,s,1','ivr-7,s,1',''),(3,'Vozero',2,'ivr-8,s,1','ivr-9,s,1','');
/*!40000 ALTER TABLE `timeconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timegroups_details`
--

DROP TABLE IF EXISTS `timegroups_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timegroups_details` (
  `id` int(11) NOT NULL auto_increment,
  `timegroupid` int(11) NOT NULL default '0',
  `time` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timegroups_details`
--

LOCK TABLES `timegroups_details` WRITE;
/*!40000 ALTER TABLE `timegroups_details` DISABLE KEYS */;
INSERT INTO `timegroups_details` VALUES (2,1,'09:15-15:00|mon-fri|1-31|jan-dec'),(3,1,'16:00-18:00|mon-thu|1-31|jan-dec'),(4,2,'08:30-18:00|mon-fri|1-31|jan-dec');
/*!40000 ALTER TABLE `timegroups_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timegroups_groups`
--

DROP TABLE IF EXISTS `timegroups_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timegroups_groups` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `display` (`description`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timegroups_groups`
--

LOCK TABLES `timegroups_groups` WRITE;
/*!40000 ALTER TABLE `timegroups_groups` DISABLE KEYS */;
INSERT INTO `timegroups_groups` VALUES (1,'Mambo'),(2,'Nextor');
/*!40000 ALTER TABLE `timegroups_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trunk_dialpatterns`
--

DROP TABLE IF EXISTS `trunk_dialpatterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trunk_dialpatterns` (
  `trunkid` int(11) NOT NULL default '0',
  `match_pattern_prefix` varchar(50) NOT NULL default '',
  `match_pattern_pass` varchar(50) NOT NULL default '',
  `prepend_digits` varchar(50) NOT NULL default '',
  `seq` int(11) NOT NULL default '0',
  PRIMARY KEY  (`trunkid`,`match_pattern_prefix`,`match_pattern_pass`,`prepend_digits`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trunk_dialpatterns`
--

LOCK TABLES `trunk_dialpatterns` WRITE;
/*!40000 ALTER TABLE `trunk_dialpatterns` DISABLE KEYS */;
INSERT INTO `trunk_dialpatterns` VALUES (4,'','XXXXXXXX','5255',5),(4,'00','.','',0),(4,'01','800.','52',2),(4,'01','XXXXXXXXXX','52',1),(4,'044','XXXXXXXXXX','521',3),(4,'045','XXXXXXXXXX','521',4),(8,'','XXXXXXXX','5255',5),(8,'00','.','',0),(8,'01','800.','52',2),(8,'01','XXXXXXXXXX','52',1),(8,'044','XXXXXXXXXX','521',3),(8,'045','XXXXXXXXXX','521',4);
/*!40000 ALTER TABLE `trunk_dialpatterns` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `extension` varchar(20) NOT NULL default '',
  `password` varchar(20) default NULL,
  `name` varchar(50) default NULL,
  `voicemail` varchar(50) default NULL,
  `ringtimer` int(3) default NULL,
  `noanswer` varchar(100) default NULL,
  `recording` varchar(50) default NULL,
  `outboundcid` varchar(50) default NULL,
  `sipname` varchar(50) default NULL,
  `mohclass` varchar(80) default 'default'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('4660','','Adrian Casa','novm',0,'','out=Always|in=Always','','','default'),('466','','Adrian Zamacona','default',0,'','out=Always|in=Always','','','default'),('469','','Sebastian Fensham','default',0,'','out=Always|in=Always','','','default'),('464','','Alfonso Lizarraga','novm',0,'','out=Always|in=Always','','','default'),('463','','Edgar Hernandez','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('470','','Paul Fensham','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('999','','999','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('4680','','Augusto Sepulveda','default',0,'','out=Adhoc|in=Adhoc','','','default'),('4690','','SEF Laptop','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('5000','','Vanesa Roldan','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('5001','','Papas Lirol','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('5002','','Sef Casa','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('6000','','Augusto Sepulveda','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('6001','','Webphone','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('460','','Rocio Checa','default',0,'','out=Always|in=Always','','','default'),('468','','Augusto Sepulveda','default',0,'','out=Always|in=Always','','','default'),('715','','715','novm',0,'','out=Adhoc|in=Adhoc','','','default'),('4691','','4691 SEF','novm',0,'','out=Adhoc|in=Adhoc','','','default');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vmblast`
--

DROP TABLE IF EXISTS `vmblast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmblast` (
  `grpnum` int(11) NOT NULL,
  `description` varchar(35) NOT NULL,
  `audio_label` int(11) NOT NULL default '-1',
  `password` varchar(20) NOT NULL,
  PRIMARY KEY  (`grpnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vmblast`
--

LOCK TABLES `vmblast` WRITE;
/*!40000 ALTER TABLE `vmblast` DISABLE KEYS */;
INSERT INTO `vmblast` VALUES (500,'Nextor',-2,''),(501,'Vozero',-2,'');
/*!40000 ALTER TABLE `vmblast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vmblast_groups`
--

DROP TABLE IF EXISTS `vmblast_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmblast_groups` (
  `grpnum` varchar(50) NOT NULL default '',
  `ext` varchar(25) NOT NULL default '',
  PRIMARY KEY  (`grpnum`,`ext`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vmblast_groups`
--

LOCK TABLES `vmblast_groups` WRITE;
/*!40000 ALTER TABLE `vmblast_groups` DISABLE KEYS */;
INSERT INTO `vmblast_groups` VALUES ('500','460'),('500','466'),('500','469'),('501','460'),('501','466'),('501','469');
/*!40000 ALTER TABLE `vmblast_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zap`
--

DROP TABLE IF EXISTS `zap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zap` (
  `id` varchar(20) NOT NULL default '-1',
  `keyword` varchar(30) NOT NULL default '',
  `data` varchar(255) NOT NULL,
  `flags` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zap`
--

LOCK TABLES `zap` WRITE;
/*!40000 ALTER TABLE `zap` DISABLE KEYS */;
/*!40000 ALTER TABLE `zap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zapchandids`
--

DROP TABLE IF EXISTS `zapchandids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zapchandids` (
  `channel` int(11) NOT NULL default '0',
  `description` varchar(40) NOT NULL default '',
  `did` varchar(60) NOT NULL default '',
  PRIMARY KEY  (`channel`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zapchandids`
--

LOCK TABLES `zapchandids` WRITE;
/*!40000 ALTER TABLE `zapchandids` DISABLE KEYS */;
/*!40000 ALTER TABLE `zapchandids` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-19 14:24:44
