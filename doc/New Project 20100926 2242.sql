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
 (1,1,31,1,4,1,'2010-09-11 13:52:04','2010-09-26 14:42:00',1);
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
 (1,10,0,2,'苏富比拍卖行','苏富比拍卖行的描述，to be continued'),
 (2,10,0,0,'佳士得拍卖行','佳士得拍卖行的描述，to be continued'),
 (3,10,1,0,'菲利普拍卖行','菲利普拍卖行的描述，to be continued'),
 (4,10,2,0,'纳高拍卖公司','纳高拍卖公司的描述，to be continued');
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
 (1,1,1,1);
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
 (1,0,1,1,'科罗拉多大峡谷','位于美国西部亚利桑那州西北部的凯巴布高原上，科罗拉多河穿流其中。'),
 (2,0,2,1,'科罗拉多大峡谷','位于美国西部亚利桑那州西北部的凯巴布高原上，科罗拉多河穿流其中。'),
 (3,0,3,1,'科罗拉多大峡谷','位于美国西部亚利桑那州西北部的凯巴布高原上，科罗拉多河穿流其中。'),
 (4,0,1,2,'维多利亚瀑布','位于非洲赞比西河中游，赞比亚与津巴布韦接壤处，为世界著名瀑布奇观之一。'),
 (5,0,2,2,'维多利亚瀑布','位于非洲赞比西河中游，赞比亚与津巴布韦接壤处，为世界著名瀑布奇观之一。'),
 (6,0,3,2,'维多利亚瀑布','位于非洲赞比西河中游，赞比亚与津巴布韦接壤处，为世界著名瀑布奇观之一。'),
 (7,0,1,3,'贝加尔湖','容量最大，最深的淡水湖，被称为“西伯利亚的蓝眼睛”，是东亚地区不少民族的发源地。'),
 (8,0,2,3,'贝加尔湖','容量最大，最深的淡水湖，被称为“西伯利亚的蓝眼睛”，是东亚地区不少民族的发源地。'),
 (9,0,3,3,'贝加尔湖','容量最大，最深的淡水湖，被称为“西伯利亚的蓝眼睛”，是东亚地区不少民族的发源地。'),
 (10,0,1,4,'阿拉斯加冰河湾','形成于四千年前的小冰河时期，数千年后冰河不断向前推进，并在1750年时达到鼎盛。'),
 (11,0,2,4,'阿拉斯加冰河湾','形成于四千年前的小冰河时期，数千年后冰河不断向前推进，并在1750年时达到鼎盛。'),
 (12,0,3,4,'阿拉斯加冰河湾','形成于四千年前的小冰河时期，数千年后冰河不断向前推进，并在1750年时达到鼎盛。'),
 (13,0,1,5,'乞力马扎罗山','非洲最高的山脉，素有“非洲屋脊”之称，而许多地理学家则喜欢称它为“非洲之王”。'),
 (14,0,2,5,'乞力马扎罗山','非洲最高的山脉，素有“非洲屋脊”之称，而许多地理学家则喜欢称它为“非洲之王”。'),
 (15,0,3,5,'乞力马扎罗山','非洲最高的山脉，素有“非洲屋脊”之称，而许多地理学家则喜欢称它为“非洲之王”。'),
 (16,1,1,6,'卢浮宫','世界上最古老、最大、最著名的博物馆之一，位于法国巴黎市中心的塞纳河北岸。'),
 (17,1,2,6,'卢浮宫','世界上最古老、最大、最著名的博物馆之一，位于法国巴黎市中心的塞纳河北岸。'),
 (18,1,3,6,'卢浮宫','世界上最古老、最大、最著名的博物馆之一，位于法国巴黎市中心的塞纳河北岸。'),
 (19,1,1,7,'胡夫金字塔','埃及现存规模最大的金字塔，被喻为“世界古代七大奇迹”之一。'),
 (20,1,2,7,'胡夫金字塔','埃及现存规模最大的金字塔，被喻为“世界古代七大奇迹”之一。'),
 (21,1,3,7,'胡夫金字塔','埃及现存规模最大的金字塔，被喻为“世界古代七大奇迹”之一。'),
 (22,1,1,8,'罗马斗兽场','古罗马文明的象征。遗址位于意大利首都罗马市中心，可以容纳近九万人数的观众。'),
 (23,1,2,8,'罗马斗兽场','古罗马文明的象征。遗址位于意大利首都罗马市中心，可以容纳近九万人数的观众。'),
 (24,1,3,8,'罗马斗兽场','古罗马文明的象征。遗址位于意大利首都罗马市中心，可以容纳近九万人数的观众。'),
 (25,1,1,9,'雅典卫城','希腊最杰出的古建筑群，也称为雅典的阿克罗波利斯，为宗教政治的中心地。'),
 (26,1,2,9,'雅典卫城','希腊最杰出的古建筑群，也称为雅典的阿克罗波利斯，为宗教政治的中心地。'),
 (27,1,3,9,'雅典卫城','希腊最杰出的古建筑群，也称为雅典的阿克罗波利斯，为宗教政治的中心地。'),
 (28,1,1,10,'北京故宫','又名紫禁城，位于北京市中心，意为过去的皇宫。世界现存最大、最完整的古建筑群。'),
 (29,1,2,10,'北京故宫','又名紫禁城，位于北京市中心，意为过去的皇宫。世界现存最大、最完整的古建筑群。'),
 (30,1,3,10,'北京故宫','又名紫禁城，位于北京市中心，意为过去的皇宫。世界现存最大、最完整的古建筑群。'),
 (31,2,1,11,'自由女神像','坐落于美国纽约州纽约市附近的自由岛，是法国在1876年赠送给美国独立100周年的礼物。'),
 (32,2,2,11,'自由女神像','坐落于美国纽约州纽约市附近的自由岛，是法国在1876年赠送给美国独立100周年的礼物。'),
 (33,2,3,11,'自由女神像','坐落于美国纽约州纽约市附近的自由岛，是法国在1876年赠送给美国独立100周年的礼物。'),
 (34,2,1,12,'思想者','最初罗丹给这尊雕像命名为《诗人》，意在象征着但丁对于地狱中种种罪恶幽灵的思考。'),
 (35,2,2,12,'思想者','最初罗丹给这尊雕像命名为《诗人》，意在象征着但丁对于地狱中种种罪恶幽灵的思考。'),
 (36,2,3,12,'思想者','最初罗丹给这尊雕像命名为《诗人》，意在象征着但丁对于地狱中种种罪恶幽灵的思考。'),
 (37,2,1,13,'掷铁饼者','这尊被誉为“体育运动之神”的雕像，一望而知是表现投掷铁饼的一个典型瞬间动作。'),
 (38,2,2,13,'掷铁饼者','这尊被誉为“体育运动之神”的雕像，一望而知是表现投掷铁饼的一个典型瞬间动作。'),
 (39,2,3,13,'掷铁饼者','这尊被誉为“体育运动之神”的雕像，一望而知是表现投掷铁饼的一个典型瞬间动作。'),
 (40,2,1,14,'大卫','西方美术史上最值得夸耀的男性人体雕像之一。是思想解放运动在艺术上得到表达的象征。'),
 (41,2,2,14,'大卫','西方美术史上最值得夸耀的男性人体雕像之一。是思想解放运动在艺术上得到表达的象征。\r\n'),
 (42,2,3,14,'大卫','西方美术史上最值得夸耀的男性人体雕像之一。是思想解放运动在艺术上得到表达的象征。'),
 (43,2,1,15,'狮身人面像','又名“斯芬克斯”，坐落在开罗西南的吉萨金字塔群旁，古埃及文明最有代表性的遗迹。'),
 (44,2,2,15,'狮身人面像','又名“斯芬克斯”，坐落在开罗西南的吉萨金字塔群旁，古埃及文明最有代表性的遗迹。'),
 (45,2,3,15,'狮身人面像','又名“斯芬克斯”，坐落在开罗西南的吉萨金字塔群旁，古埃及文明最有代表性的遗迹。'),
 (46,3,1,16,'兰亭序','王羲之得意之笔，被誉为“天下第一行书”，真迹被唐太宗视为稀世珍品而最终殉葬。'),
 (47,3,2,16,'兰亭序','王羲之得意之笔，被誉为“天下第一行书”，真迹被唐太宗视为稀世珍品而最终殉葬。'),
 (48,3,3,16,'兰亭序','王羲之得意之笔，被誉为“天下第一行书”，真迹被唐太宗视为稀世珍品而最终殉葬。'),
 (49,3,1,17,'死海古卷','在死海附近的山洞中发现的羊皮卷，被验证为是一些用希伯莱文书写的早期基督教的圣经。'),
 (50,3,2,17,'死海古卷','在死海附近的山洞中发现的羊皮卷，被验证为是一些用希伯莱文书写的早期基督教的圣经。'),
 (51,3,3,17,'死海古卷','在死海附近的山洞中发现的羊皮卷，被验证为是一些用希伯莱文书写的早期基督教的圣经。'),
 (52,3,1,18,'独立宣言','北美洲十三个英属殖民地宣告自大不列颠王国独立，并宣明此举正当性之文告。'),
 (53,3,2,18,'独立宣言','北美洲十三个英属殖民地宣告自大不列颠王国独立，并宣明此举正当性之文告。'),
 (54,3,3,18,'独立宣言','北美洲十三个英属殖民地宣告自大不列颠王国独立，并宣明此举正当性之文告。'),
 (55,3,1,19,'汉谟拉比法典','目前所知的世界上第一部比较完整的成文法典，汉谟拉比为了向神明显示自己的功绩而纂集。'),
 (56,3,2,19,'汉谟拉比法典','目前所知的世界上第一部比较完整的成文法典，汉谟拉比为了向神明显示自己的功绩而纂集。'),
 (57,3,3,19,'汉谟拉比法典','目前所知的世界上第一部比较完整的成文法典，汉谟拉比为了向神明显示自己的功绩而纂集。'),
 (58,3,1,20,'罗塞塔石碑','石碑上用希腊文字、古埃及文字和当时的通俗体文字刻了埃及国王托勒密五世诏书。'),
 (59,3,2,20,'罗塞塔石碑','石碑上用希腊文字、古埃及文字和当时的通俗体文字刻了埃及国王托勒密五世诏书。'),
 (60,3,3,20,'罗塞塔石碑','石碑上用希腊文字、古埃及文字和当时的通俗体文字刻了埃及国王托勒密五世诏书。'),
 (61,4,1,21,'牛顿','发明了微积分，发现了万有引力定律和经典力学，设计并实际制造了第一架反射式望远镜。'),
 (62,4,2,21,'牛顿','发明了微积分，发现了万有引力定律和经典力学，设计并实际制造了第一架反射式望远镜。'),
 (63,4,3,21,'牛顿','发明了微积分，发现了万有引力定律和经典力学，设计并实际制造了第一架反射式望远镜。'),
 (64,4,1,22,'孔子','编撰了我国第一部编年体史书《春秋》，其言行思想主要载于语录体散文集《论语》。'),
 (65,4,2,22,'孔子','编撰了我国第一部编年体史书《春秋》，其言行思想主要载于语录体散文集《论语》。'),
 (66,4,3,22,'孔子','编撰了我国第一部编年体史书《春秋》，其言行思想主要载于语录体散文集《论语》。'),
 (67,4,1,23,'爱因斯坦','现代物理学的开创者和奠基人，相对论的提出者，“决定论量子力学诠释”的捍卫者。'),
 (68,4,2,23,'爱因斯坦','现代物理学的开创者和奠基人，相对论的提出者，“决定论量子力学诠释”的捍卫者。'),
 (69,4,3,23,'爱因斯坦','现代物理学的开创者和奠基人，相对论的提出者，“决定论量子力学诠释”的捍卫者。'),
 (70,4,1,24,'君士坦丁大帝','世界历史上第一位信仰基督教的皇帝，承认基督教为合法且自由的宗教。'),
 (71,4,2,24,'君士坦丁大帝','世界历史上第一位信仰基督教的皇帝，承认基督教为合法且自由的宗教。'),
 (72,4,3,24,'君士坦丁大帝','世界历史上第一位信仰基督教的皇帝，承认基督教为合法且自由的宗教。'),
 (73,4,1,25,'达尔文','出版了《物种起源》这一划时代的著作，提出了生物进化论学说。'),
 (74,4,2,25,'达尔文','出版了《物种起源》这一划时代的著作，提出了生物进化论学说。'),
 (75,4,3,25,'达尔文','出版了《物种起源》这一划时代的著作，提出了生物进化论学说。'),
 (76,5,1,26,'伊苏斯之战','亚历山大大帝与波斯帝国末代国王大流士三世在伊苏斯进行的一场大战。'),
 (77,5,2,26,'伊苏斯之战','亚历山大大帝与波斯帝国末代国王大流士三世在伊苏斯进行的一场大战。'),
 (78,5,3,26,'伊苏斯之战','亚历山大大帝与波斯帝国末代国王大流士三世在伊苏斯进行的一场大战。'),
 (79,5,1,27,'特洛伊战争','以阿伽门农及阿喀琉斯为首的希腊军进攻以帕里斯及赫克托尔为首的特洛伊城的十年攻城战。'),
 (80,5,2,27,'特洛伊战争','以阿伽门农及阿喀琉斯为首的希腊军进攻以帕里斯及赫克托尔为首的特洛伊城的十年攻城战。'),
 (81,5,3,27,'特洛伊战争','以阿伽门农及阿喀琉斯为首的希腊军进攻以帕里斯及赫克托尔为首的特洛伊城的十年攻城战。'),
 (82,5,1,28,'滑铁卢战役','拿破仑一世的最后一战，这次战役结束了拿破仑帝国。后世用来形容惨败。'),
 (83,5,2,28,'滑铁卢战役','拿破仑一世的最后一战，这次战役结束了拿破仑帝国。后世用来形容惨败。'),
 (84,5,3,28,'滑铁卢战役','拿破仑一世的最后一战，这次战役结束了拿破仑帝国。后世用来形容惨败。'),
 (85,5,1,29,'诺曼底登陆','迄今世界上最大的一次海上登陆作战，接近三百万士兵渡过英吉利海峡前往法国诺曼底。'),
 (86,5,2,29,'诺曼底登陆','迄今世界上最大的一次海上登陆作战，接近三百万士兵渡过英吉利海峡前往法国诺曼底。'),
 (87,5,3,29,'诺曼底登陆','迄今世界上最大的一次海上登陆作战，接近三百万士兵渡过英吉利海峡前往法国诺曼底。'),
 (88,5,1,30,'淝水之战','东晋在淝水以八万军力大胜八十余万前秦军，是我国历史上著名的以弱胜强的战例。'),
 (89,5,2,30,'淝水之战','东晋在淝水以八万军力大胜八十余万前秦军，是我国历史上著名的以弱胜强的战例。'),
 (90,5,3,30,'淝水之战','东晋在淝水以八万军力大胜八十余万前秦军，是我国历史上著名的以弱胜强的战例。'),
 (91,6,1,31,'阿斯匹林','阿斯匹林从发明至今已有百年的历史，人们不断地发现它的新效用，称其为“神奇药”。'),
 (92,6,2,31,'阿斯匹林','阿斯匹林从发明至今已有百年的历史，人们不断地发现它的新效用，称其为“神奇药”。'),
 (93,6,3,31,'阿斯匹林','阿斯匹林从发明至今已有百年的历史，人们不断地发现它的新效用，称其为“神奇药”。'),
 (94,6,1,32,'轮子','被视做人类最古老、最重要的发明，是交通运输的一大突破，更是人类技术的一项重要成就。'),
 (95,6,2,32,'轮子','被视做人类最古老、最重要的发明，是交通运输的一大突破，更是人类技术的一项重要成就。'),
 (96,6,3,32,'轮子','被视做人类最古老、最重要的发明，是交通运输的一大突破，更是人类技术的一项重要成就。'),
 (97,6,1,33,'斐波那契数列','1、1、2、3、5、8……随着数列项数的增加，前一项与后一项之比越来越逼近黄金分割。'),
 (98,6,2,33,'斐波那契数列','1、1、2、3、5、8……随着数列项数的增加，前一项与后一项之比越来越逼近黄金分割。'),
 (99,6,3,33,'斐波那契数列','1、1、2、3、5、8……随着数列项数的增加，前一项与后一项之比越来越逼近黄金分割。'),
 (100,6,1,34,'细胞学说','一切生物都由细胞组成。论证了整个生物界在结构上的统一性，以及在进化上的共同起源。'),
 (101,6,2,34,'细胞学说','一切生物都由细胞组成。论证了整个生物界在结构上的统一性，以及在进化上的共同起源。'),
 (102,6,3,34,'细胞学说','一切生物都由细胞组成。论证了整个生物界在结构上的统一性，以及在进化上的共同起源。'),
 (103,6,1,35,'阿基米德定律','浸在液体（或气体）里的物体受到向上的浮力作用，浮力大小等于被该物体排开液体的重力。'),
 (104,6,2,35,'阿基米德定律','浸在液体（或气体）里的物体受到向上的浮力作用，浮力大小等于被该物体排开液体的重力。'),
 (105,6,3,35,'阿基米德定律','浸在液体（或气体）里的物体受到向上的浮力作用，浮力大小等于被该物体排开液体的重力。'),
 (106,7,1,36,'最后的晚餐','世界美术宝库中最完美的典范杰作。由达·芬奇直接画在米兰一座修道院的餐厅墙上。'),
 (107,7,2,36,'最后的晚餐','世界美术宝库中最完美的典范杰作。由达·芬奇直接画在米兰一座修道院的餐厅墙上。'),
 (108,7,3,36,'最后的晚餐','世界美术宝库中最完美的典范杰作。由达·芬奇直接画在米兰一座修道院的餐厅墙上。'),
 (109,7,1,37,'自由引导人民','取材于1830年法国的七月革命事件，是德拉克罗瓦最具有浪漫主义色彩的作品之一。'),
 (110,7,2,37,'自由引导人民','取材于1830年法国的七月革命事件，是德拉克罗瓦最具有浪漫主义色彩的作品之一。'),
 (111,7,3,37,'自由引导人民','取材于1830年法国的七月革命事件，是德拉克罗瓦最具有浪漫主义色彩的作品之一。'),
 (112,7,1,38,'向日葵','梵高在阳光明媚灿烂的法国南部所作，粗厚和单纯中却又充满了智慧和灵气。'),
 (113,7,2,38,'向日葵','梵高在阳光明媚灿烂的法国南部所作，粗厚和单纯中却又充满了智慧和灵气。'),
 (114,7,3,38,'向日葵','梵高在阳光明媚灿烂的法国南部所作，粗厚和单纯中却又充满了智慧和灵气。'),
 (115,7,1,39,'清明上河图','中国十大传世名画之一，以精致的工笔记录了北宋汴京郊区和城内汴河两岸的建筑和民生。 '),
 (116,7,2,39,'清明上河图','中国十大传世名画之一，以精致的工笔记录了北宋汴京郊区和城内汴河两岸的建筑和民生。 '),
 (117,7,3,39,'清明上河图','中国十大传世名画之一，以精致的工笔记录了北宋汴京郊区和城内汴河两岸的建筑和民生。 '),
 (118,7,1,40,'西斯廷圣母','拉斐尔“圣母像”中的代表作，它以甜美、悠然的抒情风格而闻名遐迩。'),
 (119,7,2,40,'西斯廷圣母','拉斐尔“圣母像”中的代表作，它以甜美、悠然的抒情风格而闻名遐迩。'),
 (120,7,3,40,'西斯廷圣母','拉斐尔“圣母像”中的代表作，它以甜美、悠然的抒情风格而闻名遐迩。');
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
 (1,2983,1,100,1,4,10,10,'袁昕','crossin'),
 (2,60,0,200,0,3,10,10,'王震','zinking'),
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
 (64,2,46,1,0),
 (65,2,39,1,0),
 (67,2,34,1,0),
 (69,2,19,1,0),
 (70,2,25,1,0),
 (72,2,43,1,0),
 (81,1,45,1,0),
 (82,1,25,1,0),
 (83,1,27,1,0),
 (85,1,12,1,0),
 (86,1,3,1,0),
 (87,1,64,1,0),
 (88,1,58,1,0),
 (89,1,26,1,0),
 (90,1,20,1,0);
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
 (112,1,'2010-04-15 13:50:20','以<b><font color=\'#ff3300\'>1</font></b>金竞拍<b><font color=\'#990000\'>非洲类藏品2</font></b>'),
 (113,2,'2010-04-16 03:50:24','以<b><font color=\'#ff3300\'>5</font></b>金竞拍<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (114,1,'2010-04-16 03:53:58','以<b><font color=\'#ff3300\'>6</font></b>金竞拍<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (115,1,'2010-04-16 05:33:25','以<b><font color=\'#ff3300\'>6</font></b>金购得<b><font color=\'#990000\'>古埃及类藏品1</font></b>'),
 (116,2,'2010-04-16 05:33:26','以<b><font color=\'#ff3300\'>5</font></b>金购得<b><font color=\'#990000\'>非洲类藏品2</font></b>'),
 (117,1,'2010-04-16 05:34:16','发起拍卖<b><font color=\'#990000\'>古罗马类藏品2</font></b>'),
 (118,1,'2010-04-16 05:43:07','以<b><font color=\'#ff3300\'>2</font></b>金竞拍<b><font color=\'#990000\'>古罗马类藏品2</font></b>'),
 (119,2,'2010-04-16 05:56:25','以<b><font color=\'#ff3300\'>994</font></b>金竞拍<b><font color=\'#990000\'>古罗马类藏品2</font></b>'),
 (120,2,'2010-04-16 05:56:29','发起拍卖<b><font color=\'#990000\'>古希腊类藏品3</font></b>'),
 (121,2,'2010-04-16 05:56:57','以<b><font color=\'#ff3300\'>6</font></b>金竞拍<b><font color=\'#990000\'>古希腊类藏品3</font></b>'),
 (122,1,'2010-04-16 05:57:44','以<b><font color=\'#ff3300\'>1</font></b>金竞拍<b><font color=\'#990000\'>古希腊类藏品3</font></b>'),
 (123,1,'2010-04-16 05:57:55','以<b><font color=\'#ff3300\'>994</font></b>金售出<b><font color=\'#990000\'>古罗马类藏品2</font></b>'),
 (124,2,'2010-04-16 05:57:55','以<b><font color=\'#ff3300\'>994</font></b>金购得<b><font color=\'#990000\'>古罗马类藏品2</font></b>'),
 (125,1,'2010-04-16 05:58:51','发起拍卖<b><font color=\'#990000\'>非洲类藏品1</font></b>'),
 (126,1,'2010-04-16 05:59:05','以<b><font color=\'#ff3300\'>995</font></b>金售出<b><font color=\'#990000\'>非洲类藏品1</font></b>'),
 (127,2,'2010-04-16 05:59:05','以<b><font color=\'#ff3300\'>995</font></b>金购得<b><font color=\'#990000\'>非洲类藏品1</font></b>'),
 (128,2,'2010-09-10 08:31:00','以<b><font color=\'#ff3300\'>6</font></b>金购得<b><font color=\'#990000\'>古希腊类藏品3</font></b>'),
 (129,1,'2010-09-10 09:00:02','<b><font color=\'#990000\'>古埃及类藏品1</font></b>以<b><font color=\'#ff3300\'>10</font></b>金被回购'),
 (130,2,'2010-09-10 09:00:02','<b><font color=\'#990000\'>古印度类藏品3</font></b>以<b><font color=\'#ff3300\'>50</font></b>金被回购'),
 (131,2,'2010-09-10 09:00:02','<b><font color=\'#990000\'>古印度类藏品1</font></b>以<b><font color=\'#ff3300\'>50</font></b>金被回购'),
 (132,2,'2010-09-10 09:00:02','<b><font color=\'#990000\'>古希腊类藏品1</font></b>以<b><font color=\'#ff3300\'>30</font></b>金被回购'),
 (133,2,'2010-09-10 09:00:02','<b><font color=\'#990000\'>古希腊类藏品3</font></b>以<b><font color=\'#ff3300\'>30</font></b>金被回购'),
 (134,1,'2010-09-10 09:19:15','进入拍卖行<b><font color=\'#990000\'>纳高拍卖公司</font></b>'),
 (135,1,'2010-09-11 13:52:04','发起拍卖<b><font color=\'#990000\'>古埃及类藏品2</font></b>'),
 (136,1,'2010-09-26 14:42:00','以<b><font color=\'#ff3300\'>1</font></b>金竞拍<b><font color=\'#990000\'>自由女神像</font></b>');
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
 (1,1,0,0,30,0,0,0),
 (2,1,1,0,20,0,0,0),
 (3,1,2,0,10,0,0,0),
 (4,1,3,0,0,0,0,0),
 (5,1,4,0,0,0,0,0),
 (6,1,5,0,0,0,0,0),
 (7,1,6,0,0,0,0,0),
 (8,1,7,0,50,0,0,0),
 (9,2,0,0,30,0,0,0),
 (10,2,1,0,20,0,0,0),
 (11,2,2,0,10,0,0,0),
 (12,2,3,0,0,0,0,0),
 (13,2,4,0,0,0,0,0),
 (14,2,5,0,0,0,0,0),
 (15,2,6,0,0,0,0,0),
 (16,2,7,0,50,0,0,0),
 (17,3,0,0,30,0,0,0),
 (18,3,1,0,20,0,0,0),
 (19,3,2,0,10,0,0,0),
 (20,3,3,0,0,0,0,0),
 (33,3,4,0,0,0,0,0),
 (34,3,5,0,0,0,0,0),
 (35,3,6,0,0,0,0,0),
 (36,3,7,0,50,0,0,0),
 (37,4,0,0,30,0,0,0),
 (38,4,1,0,20,0,0,0),
 (39,4,2,0,10,0,0,0),
 (40,4,3,0,0,0,0,0),
 (41,4,4,0,0,0,0,0),
 (42,4,5,0,0,0,0,0),
 (43,4,6,0,0,0,0,0),
 (44,4,7,0,50,0,0,0);
/*!40000 ALTER TABLE `user_logic_repurchaseprice` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
