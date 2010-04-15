-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.22-community-nt


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
INSERT INTO `user_logic_auction` (`id`,`owner_id`,`card_id`,`bidder_id`,`auctioncenter_id`,`price`,`time_start`,`time_latest`,`count_bid`) VALUES 
 (6,1,28,1,3,5,'2010-04-15 09:51:31','2010-04-15 10:26:40',1),
 (7,2,68,2,3,5,'2010-04-15 10:38:18','2010-04-15 13:50:20',2);
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
  `name` varchar(32) character set utf8 NOT NULL,
  `description` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_auctioncenter`
--

/*!40000 ALTER TABLE `user_logic_auctioncenter` DISABLE KEYS */;
INSERT INTO `user_logic_auctioncenter` (`id`,`max_player`,`count_player`,`phase`,`name`,`description`) VALUES 
 (1,10,0,4,'苏富比拍卖行','苏富比拍卖行的描述，to be continued'),
 (2,10,0,0,'佳士得拍卖行','佳士得拍卖行的描述，to be continued'),
 (3,10,2,0,'菲利普拍卖行','菲利普拍卖行的描述，to be continued'),
 (4,10,1,0,'纳高拍卖公司','纳高拍卖公司的描述，to be continued');
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
INSERT INTO `user_logic_bid` (`id`,`auction_id`,`player_id`,`price`) VALUES 
 (3,6,1,5),
 (4,7,2,5),
 (5,7,1,1);
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
  `description` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_card`
--

/*!40000 ALTER TABLE `user_logic_card` DISABLE KEYS */;
INSERT INTO `user_logic_card` (`id`,`card_class`,`auction_type`,`content`,`name`,`description`) VALUES 
 (1,0,1,1,'中国类藏品1','中国类藏品1的描述，to be continued'),
 (2,0,2,1,'中国类藏品1','中国类藏品1的描述，to be continued'),
 (3,0,3,1,'中国类藏品1','中国类藏品1的描述，to be continued'),
 (4,0,1,2,'中国类藏品2','中国类藏品2的描述，to be continued'),
 (5,0,2,2,'中国类藏品2','中国类藏品2的描述，to be continued'),
 (6,0,3,2,'中国类藏品2','中国类藏品2的描述，to be continued'),
 (7,0,1,3,'中国类藏品3','中国类藏品3的描述，to be continued'),
 (8,0,2,3,'中国类藏品3','中国类藏品3的描述，to be continued'),
 (9,0,3,3,'中国类藏品3','中国类藏品3的描述，to be continued'),
 (10,1,1,4,'古巴比伦类藏品1','古巴比伦类藏品1的描述，to be continued'),
 (11,1,2,4,'古巴比伦类藏品1','古巴比伦类藏品1的描述，to be continued'),
 (12,1,3,4,'古巴比伦类藏品1','古巴比伦类藏品1的描述，to be continued'),
 (13,1,1,5,'古巴比伦类藏品2','古巴比伦类藏品2的描述，to be continued'),
 (14,1,2,5,'古巴比伦类藏品2','古巴比伦类藏品2的描述，to be continued'),
 (15,1,3,5,'古巴比伦类藏品2','古巴比伦类藏品2的描述，to be continued'),
 (16,1,1,6,'古巴比伦类藏品3','古巴比伦类藏品3的描述，to be continued'),
 (17,1,2,6,'古巴比伦类藏品3','古巴比伦类藏品3的描述，to be continued'),
 (18,1,3,6,'古巴比伦类藏品3','古巴比伦类藏品3的描述，to be continued'),
 (19,2,1,7,'古印度类藏品1','古印度类藏品1的描述，to be continued'),
 (20,2,2,7,'古印度类藏品1','古印度类藏品1的描述，to be continued'),
 (21,2,3,7,'古印度类藏品1','古印度类藏品1的描述，to be continued'),
 (22,2,1,8,'古印度类藏品2','古印度类藏品2的描述，to be continued'),
 (23,2,2,8,'古印度类藏品2','古印度类藏品2的描述，to be continued'),
 (24,2,3,8,'古印度类藏品2','古印度类藏品2的描述，to be continued'),
 (25,2,1,9,'古印度类藏品3','古印度类藏品3的描述，to be continued'),
 (26,2,2,9,'古印度类藏品3','古印度类藏品3的描述，to be continued'),
 (27,2,3,9,'古印度类藏品3','古印度类藏品3的描述，to be continued'),
 (28,3,1,10,'古埃及类藏品1','古埃及类藏品1的描述，to be continued'),
 (29,3,2,10,'古埃及类藏品1','古埃及类藏品1的描述，to be continued'),
 (30,3,3,10,'古埃及类藏品1','古埃及类藏品1的描述，to be continued'),
 (31,3,1,11,'古埃及类藏品2','古埃及类藏品2的描述，to be continued'),
 (32,3,2,11,'古埃及类藏品2','古埃及类藏品2的描述，to be continued'),
 (33,3,3,11,'古埃及类藏品2','古埃及类藏品2的描述，to be continued'),
 (34,3,1,12,'古埃及类藏品3','古埃及类藏品3的描述，to be continued'),
 (35,3,2,12,'古埃及类藏品3','古埃及类藏品3的描述，to be continued'),
 (36,3,3,12,'古埃及类藏品3','古埃及类藏品3的描述，to be continued'),
 (37,4,1,13,'古希腊类藏品1','古希腊类藏品1的描述，to be continued'),
 (38,4,2,13,'古希腊类藏品1','古希腊类藏品1的描述，to be continued'),
 (39,4,3,13,'古希腊类藏品1','古希腊类藏品1的描述，to be continued'),
 (40,4,1,14,'古希腊类藏品2','古希腊类藏品2的描述，to be continued'),
 (41,4,2,14,'古希腊类藏品2','古希腊类藏品2的描述，to be continued'),
 (42,4,3,14,'古希腊类藏品2','古希腊类藏品2的描述，to be continued'),
 (43,4,1,15,'古希腊类藏品3','古希腊类藏品3的描述，to be continued'),
 (44,4,2,15,'古希腊类藏品3','古希腊类藏品3的描述，to be continued'),
 (45,4,3,15,'古希腊类藏品3','古希腊类藏品3的描述，to be continued'),
 (46,5,1,16,'古罗马类藏品1','古罗马类藏品1的描述，to be continued'),
 (47,5,2,16,'古罗马类藏品1','古罗马类藏品1的描述，to be continued'),
 (48,5,3,16,'古罗马类藏品1','古罗马类藏品1的描述，to be continued'),
 (49,5,1,17,'古罗马类藏品2','古罗马类藏品2的描述，to be continued'),
 (50,5,2,17,'古罗马类藏品2','古罗马类藏品2的描述，to be continued'),
 (51,5,3,17,'古罗马类藏品2','古罗马类藏品2的描述，to be continued'),
 (52,5,1,18,'古罗马类藏品3','古罗马类藏品3的描述，to be continued'),
 (53,5,2,18,'古罗马类藏品3','古罗马类藏品3的描述，to be continued'),
 (54,5,3,18,'古罗马类藏品3','古罗马类藏品3的描述，to be continued'),
 (55,6,1,19,'美洲类藏品1','美洲类藏品1的描述，to be continued'),
 (56,6,2,19,'美洲类藏品1','美洲类藏品1的描述，to be continued'),
 (57,6,3,19,'美洲类藏品1','美洲类藏品1的描述，to be continued'),
 (58,6,1,20,'美洲类藏品2','美洲类藏品2的描述，to be continued'),
 (59,6,2,20,'美洲类藏品2','美洲类藏品2的描述，to be continued'),
 (60,6,3,20,'美洲类藏品2','美洲类藏品2的描述，to be continued'),
 (61,6,1,21,'美洲类藏品3','美洲类藏品3的描述，to be continued'),
 (62,6,2,21,'美洲类藏品3','美洲类藏品3的描述，to be continued'),
 (63,6,3,21,'美洲类藏品3','美洲类藏品3的描述，to be continued'),
 (64,7,1,22,'非洲类藏品1','非洲类藏品1的描述，to be continued'),
 (65,7,2,22,'非洲类藏品1','非洲类藏品1的描述，to be continued'),
 (66,7,3,22,'非洲类藏品1','非洲类藏品1的描述，to be continued'),
 (67,7,1,23,'非洲类藏品2','非洲类藏品2的描述，to be continued'),
 (68,7,2,23,'非洲类藏品2','非洲类藏品2的描述，to be continued'),
 (69,7,3,23,'非洲类藏品2','非洲类藏品2的描述，to be continued'),
 (70,7,1,24,'非洲类藏品3','非洲类藏品3的描述，to be continued'),
 (71,7,2,24,'非洲类藏品3','非洲类藏品3的描述，to be continued'),
 (72,7,3,24,'非洲类藏品3','非洲类藏品3的描述，to be continued');
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
  `name` varchar(32) character set utf8 NOT NULL,
  `xn_id` varchar(32) NOT NULL,
  PRIMARY KEY  USING BTREE (`id`,`xn_id`),
  KEY `user_logic_player_auctioncenter` (`auctioncenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_logic_player`
--

/*!40000 ALTER TABLE `user_logic_player` DISABLE KEYS */;
INSERT INTO `user_logic_player` (`id`,`gold`,`gold_frozen`,`exp`,`in_auction`,`auctioncenter_id`,`max_card`,`count_card`,`name`,`xn_id`) VALUES 
 (1,938,6,100,1,3,10,10,'袁昕','crossin'),
 (2,1979,5,200,1,3,10,10,'王震','zinking'),
 (3,3000,0,300,0,NULL,10,0,'赵欣','hatevol'),
 (4,4000,0,400,0,NULL,10,0,'杨展鑫','etxian'),
 (5,5000,0,500,0,NULL,10,0,'马雷','malei'),
 (6,6000,0,600,0,4,10,10,'谭雪婷','tanjie');
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
INSERT INTO `user_logic_player_card` (`id`,`player_id`,`card_id`,`is_new`,`is_bought`) VALUES 
 (1,6,2,1,0),
 (2,6,29,1,0),
 (3,6,22,1,0),
 (4,6,21,1,0),
 (5,6,42,1,0),
 (6,6,12,1,0),
 (7,6,5,1,0),
 (8,6,40,1,0),
 (9,6,68,1,0),
 (10,6,67,1,0),
 (53,1,32,1,0),
 (54,1,53,1,0),
 (56,1,62,1,0),
 (57,1,68,1,0),
 (59,1,66,1,0),
 (60,1,51,1,0),
 (61,1,35,1,0),
 (62,1,49,1,0),
 (64,2,46,1,0),
 (65,2,39,1,0),
 (67,2,34,1,0),
 (69,2,19,1,0),
 (70,2,25,1,0),
 (71,2,44,1,0),
 (72,2,43,1,0),
 (73,2,27,0,1),
 (74,2,21,0,1),
 (75,2,38,0,1);
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
INSERT INTO `user_logic_playerlog` (`id`,`player_id`,`time`,`message`) VALUES 
 (74,1,'2010-04-13 10:08:42','发起拍卖<b><font color=\'#990000\'>美洲类藏品1</font></b>'),
 (75,1,'2010-04-13 10:08:45','以<b><font color=\'#ff6600\'>11</font></b>金购得<b><font color=\'#990000\'>美洲类藏品1</font></b>'),
 (76,1,'2010-04-13 10:29:30','发起拍卖<b><font color=\'#990000\'>古印度类藏品1</font></b>'),
 (77,1,'2010-04-13 10:29:34','以<b><font color=\'#ff3300\'>5</font></b>金购得<b><font color=\'#990000\'>古印度类藏品1</font></b>'),
 (78,1,'2010-04-13 10:29:54','进入拍卖行<b><font color=\'#990000\'>苏富比拍卖行</font></b>'),
 (79,1,'2010-04-13 10:29:59','进入拍卖行<b><font color=\'#990000\'>佳士得拍卖行</font></b>'),
 (80,1,'2010-04-13 10:32:25','发起拍卖<b><font color=\'#990000\'>中国类藏品1</font></b>'),
 (81,1,'2010-04-13 10:32:44','以<b><font color=\'#ff3300\'>6</font></b>金购得<b><font color=\'#990000\'>中国类藏品1</font></b>'),
 (82,1,'2010-04-13 10:32:47','发起拍卖<b><font color=\'#990000\'>非洲类藏品3</font></b>'),
 (83,1,'2010-04-13 10:32:50','以<b><font color=\'#ff3300\'>5</font></b>金购得<b><font color=\'#990000\'>非洲类藏品3</font></b>'),
 (84,1,'2010-04-13 10:32:54','发起拍卖<b><font color=\'#990000\'>古罗马类藏品3</font></b>'),
 (85,1,'2010-04-13 10:32:57','以<b><font color=\'#ff3300\'>5</font></b>金购得<b><font color=\'#990000\'>古罗马类藏品3</font></b>'),
 (86,1,'2010-04-13 10:33:11','进入拍卖行<b><font color=\'#990000\'>纳高拍卖公司</font></b>'),
 (87,1,'2010-04-13 10:33:15','发起拍卖<b><font color=\'#990000\'>美洲类藏品3</font></b>'),
 (88,1,'2010-04-13 10:33:17','以<b><font color=\'#ff3300\'>5</font></b>金购得<b><font color=\'#990000\'>美洲类藏品3</font></b>'),
 (89,1,'2010-04-14 10:21:17','进入拍卖行<b><font color=\'#990000\'>菲利普拍卖行</font></b>'),
 (90,1,'2010-04-15 04:51:08','发起拍卖<b><font color=\'#990000\'>古希腊类藏品1</font></b>'),
 (91,1,'2010-04-15 04:54:21','以<b><font color=\'#ff3300\'>1</font></b>金购得<b><font color=\'#990000\'>古希腊类藏品1</font></b>'),
 (92,1,'2010-04-15 04:55:12','发起拍卖<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (93,1,'2010-04-15 04:55:34','以<b><font color=\'#ff3300\'>1</font></b>金购得<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (94,1,'2010-04-15 04:55:53','进入拍卖行<b><font color=\'#990000\'>纳高拍卖公司</font></b>'),
 (95,1,'2010-04-15 04:59:04','进入拍卖行<b><font color=\'#990000\'>菲利普拍卖行</font></b>'),
 (96,1,'2010-04-15 05:00:43','进入拍卖行<b><font color=\'#990000\'>纳高拍卖公司</font></b>'),
 (97,1,'2010-04-15 05:11:58','进入拍卖行<b><font color=\'#990000\'>菲利普拍卖行</font></b>'),
 (98,1,'2010-04-15 05:12:18','发起拍卖<b><font color=\'#990000\'>古印度类藏品1</font></b>'),
 (99,2,'2010-04-15 07:49:39','进入拍卖行<b><font color=\'#990000\'>菲利普拍卖行</font></b>'),
 (100,2,'2010-04-15 07:49:45','发起拍卖<b><font color=\'#990000\'>古印度类藏品3</font></b>'),
 (101,2,'2010-04-15 08:59:26','以<b><font color=\'#ff3300\'>5</font></b>金购得<b><font color=\'#990000\'>古印度类藏品3</font></b>'),
 (102,1,'2010-04-15 08:59:30','以<b><font color=\'#ff3300\'>1</font></b>金售出<b><font color=\'#990000\'>古印度类藏品1</font></b>'),
 (103,2,'2010-04-15 08:59:30','以<b><font color=\'#ff3300\'>1</font></b>金购得<b><font color=\'#990000\'>古印度类藏品1</font></b>'),
 (104,2,'2010-04-15 08:59:42','发起拍卖<b><font color=\'#990000\'>古希腊类藏品1</font></b>'),
 (105,2,'2010-04-15 08:59:51','以<b><font color=\'#ff3300\'>15</font></b>金竞拍<b><font color=\'#990000\'>古希腊类藏品1</font></b>'),
 (106,1,'2010-04-15 09:41:40','以<b><font color=\'#ff3300\'>1</font></b>金竞拍<b><font color=\'#990000\'>古希腊类藏品1</font></b>'),
 (107,2,'2010-04-15 09:42:48','以<b><font color=\'#ff3300\'>15</font></b>金购得<b><font color=\'#990000\'>古希腊类藏品1</font></b>'),
 (108,1,'2010-04-15 09:51:31','发起拍卖<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (109,1,'2010-04-15 10:26:40','以<b><font color=\'#ff3300\'>5</font></b>金竞拍<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (110,2,'2010-04-15 10:38:18','发起拍卖<b><font color=\'#990000\'>非洲类藏品2</font></b>'),
 (111,2,'2010-04-15 13:41:02','以<b><font color=\'#ff3300\'>5</font></b>金竞拍<b><font color=\'#990000\'>非洲类藏品2</font></b>'),
 (112,1,'2010-04-15 13:50:20','以<b><font color=\'#ff3300\'>1</font></b>金竞拍<b><font color=\'#990000\'>非洲类藏品2</font></b>');
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
 (1,1,0,1,30,60,90,0),
 (2,1,1,2,20,40,60,0),
 (3,1,2,1,10,20,30,0),
 (4,1,3,0,0,0,0,0),
 (5,1,4,0,0,0,0,0),
 (6,1,5,2,0,0,0,0),
 (7,1,6,1,0,0,0,0),
 (8,1,7,1,50,100,150,0),
 (9,2,0,1,30,60,90,0),
 (10,2,1,0,20,40,60,0),
 (11,2,2,0,10,20,30,0),
 (12,2,3,0,0,0,0,0),
 (13,2,4,0,0,0,0,0),
 (14,2,5,1,0,0,0,0),
 (15,2,6,0,0,0,0,0),
 (16,2,7,1,50,100,150,0),
 (17,3,0,0,30,60,90,0),
 (18,3,1,0,20,40,60,0),
 (19,3,2,3,10,20,30,0),
 (20,3,3,2,0,0,0,0),
 (33,3,4,3,0,0,0,0),
 (34,3,5,1,0,0,0,0),
 (35,3,6,0,0,0,0,0),
 (36,3,7,0,50,100,150,0),
 (37,4,0,0,30,60,90,0),
 (38,4,1,0,20,40,60,0),
 (39,4,2,2,10,20,30,0),
 (40,4,3,0,0,0,0,0),
 (41,4,4,1,0,0,0,0),
 (42,4,5,1,0,0,0,0),
 (43,4,6,4,0,0,0,0),
 (44,4,7,1,50,100,150,0);
/*!40000 ALTER TABLE `user_logic_repurchaseprice` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
