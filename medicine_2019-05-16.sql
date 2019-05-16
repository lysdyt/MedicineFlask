# ************************************************************
# Sequel Pro SQL dump
# Version 5224
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.0.16)
# Database: medicine
# Generation Time: 2019-05-16 09:25:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table alembic_version
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alembic_version`;

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;

INSERT INTO `alembic_version` (`version_num`)
VALUES
	('587c8e1a6499');

/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_answer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_answer`;

CREATE TABLE `mi_answer` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expert_id` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expert_id` (`expert_id`),
  KEY `question_id` (`question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `mi_answer_ibfk_1` FOREIGN KEY (`expert_id`) REFERENCES `mi_expert_profile` (`id`),
  CONSTRAINT `mi_answer_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `mi_question` (`id`),
  CONSTRAINT `mi_answer_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `mi_user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_answer` WRITE;
/*!40000 ALTER TABLE `mi_answer` DISABLE KEYS */;

INSERT INTO `mi_answer` (`create_time`, `update_time`, `id`, `question_id`, `user_id`, `expert_id`, `content`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:22:24',1,1,NULL,1,'吗丁啉？'),
	('2019-05-16 17:00:25','2019-05-16 17:22:37',2,2,NULL,2,'999？'),
	('2019-05-16 17:00:25','2019-05-16 17:22:52',3,3,NULL,3,'氟哌酸？'),
	('2019-05-16 17:00:25','2019-05-16 17:23:06',4,3,1,NULL,'医生说氟哌酸？'),
	('2019-05-16 17:00:25','2019-05-16 17:23:21',5,2,2,NULL,'楼上正解？'),
	('2019-05-16 17:00:25','2019-05-16 17:23:27',6,1,3,NULL,'楼上正解？');

/*!40000 ALTER TABLE `mi_answer` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_essay
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_essay`;

CREATE TABLE `mi_essay` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `abstract` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `cover_img_url` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `types` enum('common','shop') COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_essay` WRITE;
/*!40000 ALTER TABLE `mi_essay` DISABLE KEYS */;

INSERT INTO `mi_essay` (`create_time`, `update_time`, `id`, `title`, `abstract`, `cover_img_url`, `content`, `types`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:19:20',1,'测试商家软文','5月10号 测试商家软文',NULL,'图片暂时先不测试','shop'),
	('2019-05-16 17:00:25','2019-05-16 17:19:25',2,'测试商家软文','5月16号 测试商家软文',NULL,'图片暂时先不测试','shop'),
	('2019-05-16 17:00:25','2019-05-16 17:19:53',3,'测试软文','5月16号 测试软文',NULL,'图片暂时先不测试','common'),
	('2019-05-16 17:00:25','2019-05-16 17:19:59',4,'测试软文','5月20号 测试软文',NULL,'图片暂时先不测试','common');

/*!40000 ALTER TABLE `mi_essay` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_expert_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_expert_profile`;

CREATE TABLE `mi_expert_profile` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_general_ci NOT NULL,
  `age` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `grade` enum('professor','assprofessor') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `major` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `position_id` (`position_id`),
  CONSTRAINT `mi_expert_profile_ibfk_1` FOREIGN KEY (`position_id`) REFERENCES `mi_position` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_expert_profile` WRITE;
/*!40000 ALTER TABLE `mi_expert_profile` DISABLE KEYS */;

INSERT INTO `mi_expert_profile` (`create_time`, `update_time`, `id`, `name`, `password`, `phone`, `age`, `email`, `avatar_url`, `address`, `grade`, `major`, `position_id`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:03:05',1,'17608037129','pbkdf2:sha256:50000$xuyfTEfk$7299796b1263f17531739364e6ef0aef344518a8be9116f9e5a064c323b48297','17608037129',NULL,NULL,NULL,NULL,NULL,NULL,1),
	('2019-05-16 17:00:25','2019-05-16 17:03:36',2,'17608037130','pbkdf2:sha256:50000$Zt2B3A6Z$48ad1acd13aab273cd3bb52f327dc63185417e96410e7a7b4e55a13bce838520','17608037130',NULL,NULL,NULL,NULL,NULL,NULL,2),
	('2019-05-16 17:00:25','2019-05-16 17:03:56',3,'17608037131','pbkdf2:sha256:50000$OSIROchl$6a497a6ac4076705b76587bab7070420d87e6206dfc6bfdd2d11a59de4d30735','17608037131',NULL,NULL,NULL,NULL,NULL,NULL,3);

/*!40000 ALTER TABLE `mi_expert_profile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_medicine_shop
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_medicine_shop`;

CREATE TABLE `mi_medicine_shop` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_list` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_medicine_shop` WRITE;
/*!40000 ALTER TABLE `mi_medicine_shop` DISABLE KEYS */;

INSERT INTO `mi_medicine_shop` (`create_time`, `update_time`, `id`, `name`, `activity_list`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:09:25',1,'达克宁药膳','达克达克'),
	('2019-05-16 17:00:25','2019-05-16 17:09:58',2,'罗红霉素药膳','消炎药'),
	('2019-05-16 17:00:25','2019-05-16 17:10:05',3,'头孢氨苄药膳','消炎药'),
	('2019-05-16 17:00:25','2019-05-16 17:10:19',4,'999药膳','感冒药'),
	('2019-05-16 17:00:25','2019-05-16 17:10:35',5,'银黄颗粒药膳','感冒药');

/*!40000 ALTER TABLE `mi_medicine_shop` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_position
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_position`;

CREATE TABLE `mi_position` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_position` WRITE;
/*!40000 ALTER TABLE `mi_position` DISABLE KEYS */;

INSERT INTO `mi_position` (`create_time`, `update_time`, `id`, `nickname`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:04:54',1,'中医专家'),
	('2019-05-16 17:00:25','2019-05-16 17:05:10',2,'养生保健专家'),
	('2019-05-16 17:00:25','2019-05-16 17:05:20',3,'心理专家'),
	('2019-05-16 17:00:25','2019-05-16 17:05:31',4,'胃痛专家'),
	('2019-05-16 17:00:25','2019-05-16 17:05:37',5,'手痛专家'),
	('2019-05-16 17:00:25','2019-05-16 17:05:42',6,'西药专家'),
	('2019-05-16 17:00:25','2019-05-16 17:05:50',7,'脊椎专家'),
	('2019-05-16 17:00:25','2019-05-16 17:06:25',8,'外科专家'),
	('2019-05-16 17:00:25','2019-05-16 17:06:29',9,'内科专家'),
	('2019-05-16 17:00:25','2019-05-16 17:06:35',10,'牙疼专家');

/*!40000 ALTER TABLE `mi_position` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_private_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_private_order`;

CREATE TABLE `mi_private_order` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar_url` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_private_order` WRITE;
/*!40000 ALTER TABLE `mi_private_order` DISABLE KEYS */;

INSERT INTO `mi_private_order` (`create_time`, `update_time`, `id`, `avatar_url`, `title`)
VALUES
	('2019-05-16 17:00:25',NULL,1,NULL,'汉堡包'),
	('2019-05-16 17:00:20',NULL,2,NULL,'炸鸡腿'),
	('2019-05-16 17:00:15',NULL,3,NULL,'氟哌酸'),
	('2019-05-16 17:00:10',NULL,4,NULL,'头孢氨苄'),
	('2019-05-16 17:00:05',NULL,5,NULL,'罗红霉素');

/*!40000 ALTER TABLE `mi_private_order` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_question
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_question`;

CREATE TABLE `mi_question` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `mi_question_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `mi_user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_question` WRITE;
/*!40000 ALTER TABLE `mi_question` DISABLE KEYS */;

INSERT INTO `mi_question` (`create_time`, `update_time`, `id`, `content`, `user_id`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:21:47',1,'我一直拉肚子，怎么？',1),
	('2019-05-16 17:00:25','2019-05-16 17:21:57',2,'我一直头疼，怎么？',2),
	('2019-05-16 17:00:25','2019-05-16 17:22:03',3,'我一直上厕所，怎么？',3);

/*!40000 ALTER TABLE `mi_question` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_user_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_user_profile`;

CREATE TABLE `mi_user_profile` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_general_ci NOT NULL,
  `age` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_url` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `level` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `grade` enum('common','vip') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('null','min','max') COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_user_profile` WRITE;
/*!40000 ALTER TABLE `mi_user_profile` DISABLE KEYS */;

INSERT INTO `mi_user_profile` (`create_time`, `update_time`, `id`, `name`, `password`, `phone`, `age`, `email`, `avatar_url`, `address`, `level`, `grade`, `status`)
VALUES
	('2019-05-16 17:00:25','2019-05-16 17:00:47',1,'17608037125','pbkdf2:sha256:50000$Nc2hR8F9$a1860fe11a5a396cfba26c557a2c14e85438c202d92de0e89a89e7be55102983','17608037125',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('2019-05-16 17:00:25','2019-05-16 17:01:32',2,'17608037126','pbkdf2:sha256:50000$fMTM1261$c6418f38d9f6a711145ef1e8af9339bba459c54993f49a58c553b9e829901cb5','17608037126',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('2019-05-16 17:00:25','2019-05-16 17:01:52',3,'17608037127','pbkdf2:sha256:50000$imMh37AF$8af444ae27f176c352784e50061909727b82cab6e6abd5ac0deab3a4236fa352','17608037127',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('2019-05-16 17:00:25','2019-05-16 17:02:32',4,'17608037128','pbkdf2:sha256:50000$mrK8AG00$6918a6cd7ecdcf99746dee53bb133f800e0276370a49ad8ea1b00f121973fd7a','17608037128',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `mi_user_profile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mi_video
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mi_video`;

CREATE TABLE `mi_video` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar_url` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `video_url` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `medicine_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `medicine_id` (`medicine_id`),
  CONSTRAINT `mi_video_ibfk_1` FOREIGN KEY (`medicine_id`) REFERENCES `mi_medicine_shop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mi_video` WRITE;
/*!40000 ALTER TABLE `mi_video` DISABLE KEYS */;

INSERT INTO `mi_video` (`create_time`, `update_time`, `id`, `avatar_url`, `video_url`, `medicine_id`)
VALUES
	('2019-05-16 17:00:25',NULL,1,NULL,'https://v.qq.com/x/cover/120m3xjxyr69vlz.html',1),
	('2019-05-16 17:00:20',NULL,2,NULL,'https://v.qq.com/x/cover/aox91j5e2nis6sc.html',2),
	('2019-05-16 17:00:15',NULL,5,NULL,'https://v.qq.com/x/cover/8rpyk6div4sku7g.html',3),
	('2019-05-16 17:00:10',NULL,7,NULL,'https://v.qq.com/x/cover/3fvg46217gw800n.html',4);

/*!40000 ALTER TABLE `mi_video` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
