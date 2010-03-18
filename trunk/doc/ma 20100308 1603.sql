-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.18


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema modern_art
--

CREATE DATABASE IF NOT EXISTS modern_art;
USE modern_art;

--
-- Definition of table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_group`
--

/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;


--
-- Definition of table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `permission_id_refs_id_5886d21f` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_group_permissions`
--

/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;


--
-- Definition of table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `auth_message_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_message`
--

/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;


--
-- Definition of table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id` (`content_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`,`name`,`content_type_id`,`codename`) VALUES 
 (1,'Can add permission',1,'add_permission'),
 (2,'Can change permission',1,'change_permission'),
 (3,'Can delete permission',1,'delete_permission'),
 (4,'Can add group',2,'add_group'),
 (5,'Can change group',2,'change_group'),
 (6,'Can delete group',2,'delete_group'),
 (7,'Can add user',3,'add_user'),
 (8,'Can change user',3,'change_user'),
 (9,'Can delete user',3,'delete_user'),
 (10,'Can add message',4,'add_message'),
 (11,'Can change message',4,'change_message'),
 (12,'Can delete message',4,'delete_message'),
 (13,'Can add content type',5,'add_contenttype'),
 (14,'Can change content type',5,'change_contenttype'),
 (15,'Can delete content type',5,'delete_contenttype'),
 (16,'Can add session',6,'add_session'),
 (17,'Can change session',6,'change_session'),
 (18,'Can delete session',6,'delete_session'),
 (19,'Can add site',7,'add_site'),
 (20,'Can change site',7,'change_site'),
 (21,'Can delete site',7,'delete_site'),
 (22,'Can add auction center',8,'add_auctioncenter'),
 (23,'Can change auction center',8,'change_auctioncenter'),
 (24,'Can delete auction center',8,'delete_auctioncenter'),
 (25,'Can add player',9,'add_player'),
 (26,'Can change player',9,'change_player'),
 (27,'Can delete player',9,'delete_player'),
 (28,'Can add card',10,'add_card'),
 (29,'Can change card',10,'change_card'),
 (30,'Can delete card',10,'delete_card'),
 (31,'Can add player_ card',11,'add_player_card'),
 (32,'Can change player_ card',11,'change_player_card'),
 (33,'Can delete player_ card',11,'delete_player_card'),
 (34,'Can add auction',12,'add_auction'),
 (35,'Can change auction',12,'change_auction'),
 (36,'Can delete auction',12,'delete_auction'),
 (37,'Can add bid',13,'add_bid'),
 (38,'Can change bid',13,'change_bid'),
 (39,'Can delete bid',13,'delete_bid'),
 (40,'Can add repurchase price',14,'add_repurchaseprice'),
 (41,'Can change repurchase price',14,'change_repurchaseprice'),
 (42,'Can delete repurchase price',14,'delete_repurchaseprice'),
 (43,'Can add player log',15,'add_playerlog'),
 (44,'Can change player log',15,'change_playerlog'),
 (45,'Can delete player log',15,'delete_playerlog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;


--
-- Definition of table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user`
--

/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;


--
-- Definition of table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `group_id_refs_id_f116770` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user_groups`
--

/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;


--
-- Definition of table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `permission_id_refs_id_67e79cb` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user_user_permissions`
--

/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;


--
-- Definition of table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`,`name`,`app_label`,`model`) VALUES 
 (1,'permission','auth','permission'),
 (2,'group','auth','group'),
 (3,'user','auth','user'),
 (4,'message','auth','message'),
 (5,'content type','contenttypes','contenttype'),
 (6,'session','sessions','session'),
 (7,'site','sites','site'),
 (8,'auction center','user_logic','auctioncenter'),
 (9,'player','user_logic','player'),
 (10,'card','user_logic','card'),
 (11,'player_ card','user_logic','player_card'),
 (12,'auction','user_logic','auction'),
 (13,'bid','user_logic','bid'),
 (14,'repurchase price','user_logic','repurchaseprice'),
 (15,'player log','user_logic','playerlog');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;


--
-- Definition of table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY  (`session_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;


--
-- Definition of table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL auto_increment,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_site`
--

/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` (`id`,`domain`,`name`) VALUES 
 (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;


--
-- Definition of table `user_logic_auction`
--

DROP TABLE IF EXISTS `user_logic_auction`;
CREATE TABLE `user_logic_auction` (
  `id` int(11) NOT NULL auto_increment,
  `owner_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `bidder_id` int(11) default NULL,
  `auctioncenter_id` int(11) NOT NULL,
  `price` double NOT NULL,
  `time_start` datetime NOT NULL,
  `time_latest` datetime NOT NULL,
  `count_bid` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  KEY `user_logic_auction_card_id` (`card_id`),
  KEY `user_logic_auction_bidder_id` (`bidder_id`),
  KEY `user_logic_auction_auctioncente` (`auctioncenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_auction`
--

/*!40000 ALTER TABLE `user_logic_auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logic_auction` ENABLE KEYS */;


--
-- Definition of table `user_logic_auctioncenter`
--

DROP TABLE IF EXISTS `user_logic_auctioncenter`;
CREATE TABLE `user_logic_auctioncenter` (
  `id` int(11) NOT NULL auto_increment,
  `max_player` int(11) NOT NULL,
  `count_player` int(11) NOT NULL,
  `phase` int(4) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_auctioncenter`
--

/*!40000 ALTER TABLE `user_logic_auctioncenter` DISABLE KEYS */;
INSERT INTO `user_logic_auctioncenter` (`id`,`max_player`,`count_player`,`phase`) VALUES 
 (1,10,0,1),
 (2,10,0,0),
 (3,10,0,0),
 (4,10,0,0);
/*!40000 ALTER TABLE `user_logic_auctioncenter` ENABLE KEYS */;


--
-- Definition of table `user_logic_bid`
--

DROP TABLE IF EXISTS `user_logic_bid`;
CREATE TABLE `user_logic_bid` (
  `id` int(11) NOT NULL auto_increment,
  `auction_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_logic_bid_auction_id` (`auction_id`),
  KEY `user_logic_bid_player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_bid`
--

/*!40000 ALTER TABLE `user_logic_bid` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logic_bid` ENABLE KEYS */;


--
-- Definition of table `user_logic_card`
--

DROP TABLE IF EXISTS `user_logic_card`;
CREATE TABLE `user_logic_card` (
  `id` int(11) NOT NULL auto_increment,
  `card_class` int(11) NOT NULL,
  `auction_type` int(11) NOT NULL,
  `content` int(11) NOT NULL,
  `name` varchar(16) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_card`
--

/*!40000 ALTER TABLE `user_logic_card` DISABLE KEYS */;
INSERT INTO `user_logic_card` (`id`,`card_class`,`auction_type`,`content`,`name`) VALUES 
 (1,0,1,1,'名字'),
 (2,0,2,1,'名字'),
 (3,0,3,1,'名字'),
 (4,0,1,2,'名字'),
 (5,0,2,2,'名字'),
 (6,0,3,2,'名字'),
 (7,0,1,3,'名字'),
 (8,0,2,3,'名字'),
 (9,0,3,3,'名字'),
 (10,1,1,4,'名字'),
 (11,1,2,4,'名字'),
 (12,1,3,4,'名字'),
 (13,1,1,5,'名字'),
 (14,1,2,5,'名字'),
 (15,1,3,5,'名字'),
 (16,1,1,6,'名字'),
 (17,1,2,6,'名字'),
 (18,1,3,6,'名字'),
 (19,2,1,7,'名字'),
 (20,2,2,7,'名字'),
 (21,2,3,7,'名字'),
 (22,2,1,8,'名字'),
 (23,2,2,8,'名字'),
 (24,2,3,8,'名字'),
 (25,2,1,9,'名字'),
 (26,2,2,9,'名字'),
 (27,2,3,9,'名字'),
 (28,3,1,10,'名字'),
 (29,3,2,10,'名字'),
 (30,3,3,10,'名字'),
 (31,3,1,11,'名字'),
 (32,3,2,11,'名字'),
 (33,3,3,11,'名字'),
 (34,3,1,12,'名字'),
 (35,3,2,12,'名字'),
 (36,3,3,12,'名字'),
 (37,4,1,13,'名字'),
 (38,4,2,13,'名字'),
 (39,4,3,13,'名字'),
 (40,4,1,14,'名字'),
 (41,4,2,14,'名字'),
 (42,4,3,14,'名字'),
 (43,4,1,15,'名字'),
 (44,4,2,15,'名字'),
 (45,4,3,15,'名字'),
 (46,5,1,16,'名字'),
 (47,5,2,16,'名字'),
 (48,5,3,16,'名字'),
 (49,5,1,17,'名字'),
 (50,5,2,17,'名字'),
 (51,5,3,17,'名字'),
 (52,5,1,18,'名字'),
 (53,5,2,18,'名字'),
 (54,5,3,18,'名字'),
 (55,6,1,19,'名字'),
 (56,6,2,19,'名字'),
 (57,6,3,19,'名字'),
 (58,6,1,20,'名字'),
 (59,6,2,20,'名字'),
 (60,6,3,20,'名字'),
 (61,6,1,21,'名字'),
 (62,6,2,21,'名字'),
 (63,6,3,21,'名字'),
 (64,7,1,22,'名字'),
 (65,7,2,22,'名字'),
 (66,7,3,22,'名字'),
 (67,7,1,23,'名字'),
 (68,7,2,23,'名字'),
 (69,7,3,23,'名字'),
 (70,7,1,24,'名字'),
 (71,7,2,24,'名字'),
 (72,7,3,24,'名字');
/*!40000 ALTER TABLE `user_logic_card` ENABLE KEYS */;


--
-- Definition of table `user_logic_player`
--

DROP TABLE IF EXISTS `user_logic_player`;
CREATE TABLE `user_logic_player` (
  `id` int(11) NOT NULL auto_increment,
  `gold` int(11) NOT NULL,
  `gold_frozen` int(11) NOT NULL,
  `exp` int(11) NOT NULL,
  `in_auction` tinyint(1) NOT NULL,
  `auctioncenter_id` int(11) default NULL,
  `max_card` int(11) NOT NULL,
  `count_card` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_logic_player_auctioncenter` (`auctioncenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_player`
--

/*!40000 ALTER TABLE `user_logic_player` DISABLE KEYS */;
INSERT INTO `user_logic_player` (`id`,`gold`,`gold_frozen`,`exp`,`in_auction`,`auctioncenter_id`,`max_card`,`count_card`,`name`) VALUES 
 (1,1000,0,100,0,NULL,10,0,'yuanxin'),
 (2,2000,0,200,0,NULL,10,0,'wangzhen'),
 (3,3000,0,300,0,NULL,10,0,'zhaoxin'),
 (4,4000,0,400,0,NULL,10,0,'yangzhanxin'),
 (5,5000,0,500,0,NULL,10,0,'malei'),
 (6,6000,0,600,0,NULL,10,0,'tanxueting');
/*!40000 ALTER TABLE `user_logic_player` ENABLE KEYS */;


--
-- Definition of table `user_logic_player_card`
--

DROP TABLE IF EXISTS `user_logic_player_card`;
CREATE TABLE `user_logic_player_card` (
  `id` int(11) NOT NULL auto_increment,
  `player_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `is_new` tinyint(1) NOT NULL,
  `is_bought` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_logic_player_card_player_id` (`player_id`),
  KEY `user_logic_player_card_card_id` (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_player_card`
--

/*!40000 ALTER TABLE `user_logic_player_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logic_player_card` ENABLE KEYS */;


--
-- Definition of table `user_logic_playerlog`
--

DROP TABLE IF EXISTS `user_logic_playerlog`;
CREATE TABLE `user_logic_playerlog` (
  `id` int(11) NOT NULL auto_increment,
  `player_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `message` varchar(200) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_logic_playerlog_player_id` (`player_id`),
  CONSTRAINT `player_id_refs_id_2a8ab2a` FOREIGN KEY (`player_id`) REFERENCES `user_logic_player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_playerlog`
--

/*!40000 ALTER TABLE `user_logic_playerlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logic_playerlog` ENABLE KEYS */;


--
-- Definition of table `user_logic_repurchaseprice`
--

DROP TABLE IF EXISTS `user_logic_repurchaseprice`;
CREATE TABLE `user_logic_repurchaseprice` (
  `id` int(11) NOT NULL auto_increment,
  `auctioncenter_id` int(11) NOT NULL,
  `card_class` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `price_1` double NOT NULL,
  `price_2` double NOT NULL,
  `price_3` double NOT NULL,
  `price_4` double NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_logic_repurchaseprice_auct` (`auctioncenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_repurchaseprice`
--

/*!40000 ALTER TABLE `user_logic_repurchaseprice` DISABLE KEYS */;
INSERT INTO `user_logic_repurchaseprice` (`id`,`auctioncenter_id`,`card_class`,`count`,`price_1`,`price_2`,`price_3`,`price_4`) VALUES 
 (1,1,0,0,0,0,0,0),
 (2,1,1,0,0,0,0,0),
 (3,1,2,0,0,0,0,0),
 (4,1,3,0,0,0,0,0),
 (5,1,4,0,0,0,0,0),
 (6,1,5,0,0,0,0,0),
 (7,1,6,0,0,0,0,0),
 (8,1,7,0,0,0,0,0),
 (9,2,0,0,0,0,0,0),
 (10,2,1,0,0,0,0,0),
 (11,2,2,0,0,0,0,0),
 (12,2,3,0,0,0,0,0),
 (13,2,4,0,0,0,0,0),
 (14,2,5,0,0,0,0,0),
 (15,2,6,0,0,0,0,0),
 (16,2,7,0,0,0,0,0),
 (17,3,0,0,0,0,0,0),
 (18,3,1,0,0,0,0,0),
 (19,3,2,0,0,0,0,0),
 (20,3,3,0,0,0,0,0),
 (33,3,4,0,0,0,0,0),
 (34,3,5,0,0,0,0,0),
 (35,3,6,0,0,0,0,0),
 (36,3,7,0,0,0,0,0),
 (37,4,0,0,0,0,0,0),
 (38,4,1,0,0,0,0,0),
 (39,4,2,0,0,0,0,0),
 (40,4,3,0,0,0,0,0),
 (41,4,4,0,0,0,0,0),
 (42,4,5,0,0,0,0,0),
 (43,4,6,0,0,0,0,0),
 (44,4,7,0,0,0,0,0);
/*!40000 ALTER TABLE `user_logic_repurchaseprice` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
