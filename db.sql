# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: us-cdbr-east-03.cleardb.com (MySQL 5.6.50-log)
# Database: heroku_0793ceb702f6fd9
# Generation Time: 2021-07-26 10:06:13 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification` tinyint(1) DEFAULT '0',
  `profile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`),
  KEY `admins_organization_id_foreign` (`organization_id`),
  CONSTRAINT `admins_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;

INSERT INTO `admins` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `phone`, `verification`, `profile`, `referral_code`, `created_at`, `updated_at`, `organization_id`, `publicId`)
VALUES
	(14,'Success Arudovwen','succcy2010@gmail.com',NULL,'$2y$10$Cf8pBG6u.e9T4pyVmLsYROCUCV3lR2KhZm1eyHW1DBa217fDC7znC','administrator','08102588399',0,NULL,'ND4748','2021-06-03 13:21:45','2021-06-03 13:21:45',14,NULL),
	(24,'David Komoni','bizguruh@gmail.com',NULL,'$2y$10$eoNBhn/ZtoDFxJz5qSFUE.ZFHKu7uz6hZDt7AZOoLJaUo08JZFgCW','administrator','08166741200',0,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622736314/arudovwen_20210320_1_msvxt4.jpg','FB8128','2021-06-03 13:29:05','2021-06-03 16:05:15',14,NULL),
	(44,'Joy Onyekwere','joyonyekwere0@gmail.com',NULL,'$2y$10$DOHphG4/t4QCK8ylOofzJ.1acdUkFUYdnH9rIf0fGKMEHN0NTyhQG','administrator','09051313691',0,NULL,'Joy_OnyekwereFY2899','2021-06-21 11:14:57','2021-06-21 11:14:57',24,NULL),
	(54,'Oluchi Igbojekwe','oigbojekwe@gmail.com',NULL,'$2y$10$RYv1dc1mwyiDUkOkjav4JuWirAslEKXnHvDyQv/Qoi4SbVIGTHlq2','administrator','08138580831',1,NULL,'Oluchi_IgbojekweCK1775','2021-06-24 11:12:22','2021-06-24 11:16:57',74,NULL),
	(64,'Success Ahon','successahon@gmail.com',NULL,'$2y$10$pVOdJVLUENQRfPiD.sBOhOuVt9K6NnAJPy5z58MeCEDmsXwHG5FhC','administrator','08102588390',1,NULL,'success_ahon_6845','2021-07-25 12:15:58','2021-07-25 19:43:52',104,NULL);

/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table answered_questionnaire
# ------------------------------------------------------------

DROP TABLE IF EXISTS `answered_questionnaire`;

CREATE TABLE `answered_questionnaire` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `module_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `question_template_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_score` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `your_score` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answered_questionnaire_user_id_foreign` (`user_id`),
  KEY `answered_questionnaire_course_id_foreign` (`course_id`),
  KEY `answered_questionnaire_module_id_foreign` (`module_id`),
  KEY `answered_questionnaire_question_template_id_foreign` (`question_template_id`),
  CONSTRAINT `answered_questionnaire_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answered_questionnaire_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answered_questionnaire_question_template_id_foreign` FOREIGN KEY (`question_template_id`) REFERENCES `question_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answered_questionnaire_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `answered_questionnaire` WRITE;
/*!40000 ALTER TABLE `answered_questionnaire` DISABLE KEYS */;

INSERT INTO `answered_questionnaire` (`id`, `content`, `user_id`, `course_id`, `module_id`, `created_at`, `updated_at`, `question_template_id`, `status`, `total_score`, `your_score`)
VALUES
	(34,'{\"id\":34,\"module_id\":24,\"course_id\":4,\"course_title\":\"Crypto Life\",\"title\":\"Test\",\"sections\":[{\"title\":\"Section oNE\",\"description\":null,\"questions\":[{\"fixed\":false,\"question\":\"hOW ARE O?\",\"response\":\"Very well\",\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]}',4,4,24,'2021-07-07 10:18:38','2021-07-08 11:19:50',34,'draft',NULL,NULL),
	(44,'{\"id\":344,\"totalscore\":0,\"title\":\"Javascript\",\"type\":null,\"sections\":[{\"title\":\"Section One\",\"description\":\"<p>Just tell everything you know about Javascript<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is javascript?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Not long answer\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Methods in Javscript\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"What is a method?\",\"placeholders\":[{\"placeholder\":\"One answer\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"Types of methods?\",\"placeholders\":[{\"placeholder\":\"Type here\",\"response\":null},{\"placeholder\":\"Type here\",\"response\":null},{\"placeholder\":\"Type here\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Explain what you understand by Arrays\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Everything you know\",\"response\":null}],\"placeholder\":null,\"hint\":\"Arrays in javascript\",\"score\":0}]}]}',54,184,204,'2021-07-26 02:18:58','2021-07-26 02:19:09',344,'edit',NULL,NULL);

/*!40000 ALTER TABLE `answered_questionnaire` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assessment_responses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment_responses`;

CREATE TABLE `assessment_responses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `your_score` int(11) NOT NULL,
  `total_score` int(11) NOT NULL,
  `response` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `assessment_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_responses_user_id_foreign` (`user_id`),
  KEY `assessment_responses_assessment_id_foreign` (`assessment_id`),
  CONSTRAINT `assessment_responses_assessment_id_foreign` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assessment_responses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `assessment_responses` WRITE;
/*!40000 ALTER TABLE `assessment_responses` DISABLE KEYS */;

INSERT INTO `assessment_responses` (`id`, `your_score`, `total_score`, `response`, `user_id`, `assessment_id`, `created_at`, `updated_at`)
VALUES
	(4,0,30,'{\"id\":214,\"sections\":[{\"title\":\"Quiz Time\",\"description\":\"<p>Answer all questions as fast as possible<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 2 + 2 ?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":\"4\",\"responses\":[],\"result\":5,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"2\"},{\"value\":\"4\"},{\"value\":\"6\"},{\"value\":\"8\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"4\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 2 X 3?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":\"6\",\"responses\":[],\"result\":5,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"6\"},{\"value\":\"5\"},{\"value\":\"8\"},{\"value\":\"9\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"6\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 5 -3\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":\"2\",\"responses\":[],\"result\":5,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"2\"},{\"value\":\"6\"},{\"value\":\"4\"},{\"value\":\"1\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"2\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Solve all the equations below\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"3*3\",\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":\"4\"},{\"value\":\"5\"},{\"value\":\"8\"},{\"value\":\"99\"}],\"answer\":null,\"answers\":[{\"value\":\"9\"}],\"response\":\"99\",\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"5 + 6\",\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":\"11\"},{\"value\":\"12\"},{\"value\":\"14\"},{\"value\":\"15\"}],\"answer\":null,\"answers\":[{\"value\":\"11\"}],\"response\":\"11\",\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5}]},{\"title\":\"Section two\",\"description\":\"<p>This is a description of section two<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"How are you?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Briefly state\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Describe all these about you\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Health\",\"response\":null},{\"placeholder\":\"Mentality\",\"response\":null},{\"placeholder\":\"Passion\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":true,\"question\":\"List 3 examples\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"Health\",\"placeholders\":[{\"placeholder\":\"One\",\"response\":null},{\"placeholder\":\"Two\",\"response\":null},{\"placeholder\":\"Three\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"Mental\",\"placeholders\":[{\"placeholder\":\"One\",\"response\":null},{\"placeholder\":\"Two\",\"response\":null},{\"placeholder\":\"Three\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}],\"title\":\"My Assignment\"}',4,24,'2021-07-08 09:30:03','2021-07-08 09:30:03');

/*!40000 ALTER TABLE `assessment_responses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assessments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessments`;

CREATE TABLE `assessments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `start` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `feedback` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tools` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_template_id` bigint(20) unsigned NOT NULL,
  `facilitator_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assessments_question_template_id_foreign` (`question_template_id`),
  KEY `assessments_facilitator_id_foreign` (`facilitator_id`),
  KEY `assessments_course_id_foreign` (`course_id`),
  CONSTRAINT `assessments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assessments_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assessments_question_template_id_foreign` FOREIGN KEY (`question_template_id`) REFERENCES `question_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `assessments` WRITE;
/*!40000 ALTER TABLE `assessments` DISABLE KEYS */;

INSERT INTO `assessments` (`id`, `start`, `end`, `feedback`, `type`, `duration`, `tools`, `status`, `question_template_id`, `facilitator_id`, `created_at`, `updated_at`, `course_id`)
VALUES
	(4,'2021-07-07T16:50:57.370Z','2021-07-31T16:50:57.370Z','Great job','quiz','15','[\"calculator\"]','pending',204,4,'2021-07-07 16:51:26','2021-07-07 16:51:26',4),
	(14,'2021-07-07T16:54:44.625Z','2021-07-31T16:54:44.625Z','Great','quiz','20','[\"calculator\"]','pending',204,4,'2021-07-07 16:55:05','2021-07-07 16:55:05',44),
	(24,'2021-07-08T01:54:10.021Z','2021-07-30T01:54:10.021Z','Great job','assignment','60','[\"calculator\"]','pending',214,4,'2021-07-08 01:54:37','2021-07-08 01:54:37',44),
	(34,'2021-07-31T20:41:43.529Z','2021-08-31T20:41:43.529Z','Completed','assignment','60','[]','pending',344,54,'2021-07-25 20:42:19','2021-07-25 20:42:19',184);

/*!40000 ALTER TABLE `assessments` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table connections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `connections`;

CREATE TABLE `connections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `follow_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `following_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `connections_user_id_foreign` (`user_id`),
  KEY `connections_facilitator_id_foreign` (`facilitator_id`),
  KEY `connections_admin_id_foreign` (`admin_id`),
  CONSTRAINT `connections_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `connections_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `connections_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `connections` WRITE;
/*!40000 ALTER TABLE `connections` DISABLE KEYS */;

INSERT INTO `connections` (`id`, `follow_type`, `following_id`, `user_id`, `facilitator_id`, `admin_id`, `created_at`, `updated_at`)
VALUES
	(4,'facilitator','4',4,NULL,NULL,'2021-06-04 11:38:18','2021-06-04 11:38:18'),
	(14,'user','4',4,NULL,NULL,'2021-07-19 17:50:49','2021-07-19 17:50:49');

/*!40000 ALTER TABLE `connections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table contributors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contributors`;

CREATE TABLE `contributors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `discussion_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contributors_discussion_id_foreign` (`discussion_id`),
  KEY `contributors_user_id_foreign` (`user_id`),
  KEY `contributors_facilitator_id_foreign` (`facilitator_id`),
  KEY `contributors_admin_id_foreign` (`admin_id`),
  CONSTRAINT `contributors_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contributors_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contributors_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contributors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `contributors` WRITE;
/*!40000 ALTER TABLE `contributors` DISABLE KEYS */;

INSERT INTO `contributors` (`id`, `type`, `count`, `discussion_id`, `user_id`, `facilitator_id`, `admin_id`, `created_at`, `updated_at`)
VALUES
	(4,'discussion',7,4,4,NULL,NULL,'2021-07-08 13:15:02','2021-07-19 17:48:51'),
	(14,'discussion',1,4,NULL,4,NULL,'2021-07-08 16:34:53','2021-07-08 16:34:53');

/*!40000 ALTER TABLE `contributors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table course_communities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_communities`;

CREATE TABLE `course_communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_communities_user_id_foreign` (`user_id`),
  KEY `course_communities_course_id_foreign` (`course_id`),
  KEY `course_communities_admin_id_foreign` (`admin_id`),
  KEY `course_communities_facilitator_id_foreign` (`facilitator_id`),
  CONSTRAINT `course_communities_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_communities_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_communities_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_communities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `course_communities` WRITE;
/*!40000 ALTER TABLE `course_communities` DISABLE KEYS */;

INSERT INTO `course_communities` (`id`, `code`, `user_id`, `created_at`, `updated_at`, `course_id`, `admin_id`, `facilitator_id`)
VALUES
	(4,'group-4823',4,'2021-06-09 00:41:51','2021-06-09 00:41:51',4,NULL,NULL),
	(14,'group-9535',4,'2021-06-09 11:46:16','2021-06-09 11:46:16',44,NULL,NULL);

/*!40000 ALTER TABLE `course_communities` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table course_community_links
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_community_links`;

CREATE TABLE `course_community_links` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_community_links_course_id_foreign` (`course_id`),
  KEY `course_community_links_user_id_foreign` (`user_id`),
  CONSTRAINT `course_community_links_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_community_links_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `course_community_links` WRITE;
/*!40000 ALTER TABLE `course_community_links` DISABLE KEYS */;

INSERT INTO `course_community_links` (`id`, `code`, `amount`, `course_id`, `user_id`, `created_at`, `updated_at`)
VALUES
	(4,'group-4823','10',4,4,'2021-06-09 00:41:51','2021-06-09 00:41:51'),
	(14,'group-9535','5',44,4,'2021-06-09 11:46:16','2021-06-09 11:46:16');

/*!40000 ALTER TABLE `course_community_links` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table course_facilitators
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_facilitators`;

CREATE TABLE `course_facilitators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `facilitator_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_facilitators_facilitator_id_foreign` (`facilitator_id`),
  KEY `course_facilitators_course_id_foreign` (`course_id`),
  CONSTRAINT `course_facilitators_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_facilitators_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table course_outlines
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_outlines`;

CREATE TABLE `course_outlines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `knowledge_areas` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modules` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `certification` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faqs` text COLLATE utf8mb4_unicode_ci,
  `overview` text COLLATE utf8mb4_unicode_ci,
  `additional_info` text COLLATE utf8mb4_unicode_ci,
  `course_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_outlines_course_id_foreign` (`course_id`),
  CONSTRAINT `course_outlines_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `course_outlines` WRITE;
/*!40000 ALTER TABLE `course_outlines` DISABLE KEYS */;

INSERT INTO `course_outlines` (`id`, `knowledge_areas`, `modules`, `duration`, `certification`, `faqs`, `overview`, `additional_info`, `course_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,'{\"value\":\"Crypto\",\"icon\":\"bullseye\",\"color\":\"#0AFFFF\"}','[{\"fixed\":false,\"module\":\"My Bright Idea\"},{\"fixed\":false,\"module\":\"My Business Vision\"},{\"fixed\":false,\"module\":\"My Business Mission\"},{\"fixed\":false,\"module\":\"My Business Values\"}]','1 Weeks','yes','[{\"question\":\"What is Cryptocurrency and how does it work?\",\"answer\":\"Cryptocurrency is a form of payment that can be exchanged online for goods and services.\"},{\"question\":\"Is Cryptocurrency good or bad?\",\"answer\":\"Investing in currencies such as Bitcoin and Ethereum is considered a \\u201chigh-risk\\u201d investment.\"},{\"question\":\"Bitcoin Definition: How Does Bitcoin Work?\",\"answer\":\"You can start a new cryptocurrency by creating an entirely new blockchain with a coin or by forking an existing one and creating a token.\"},{\"question\":\"Who owns the most bitcoin?\",\"answer\":\"At the top of the list is Satoshi Nakamoto, the founder of Bitcoin, who is rumoured to own around 1 million Bitcoins \\u2013 although no one knows who he really is. Satoshi Nakamoto is actually a pseudonym for a person or persons who invented Bitcoin and authored the first Bitcoin white paper back in 2008.\"}]','A cryptocurrency is a digital or virtual currency that is secured by cryptography, which makes it nearly impossible to counterfeit or double-spend. Many cryptocurrencies are decentralized networks based on blockchain technology—a distributed ledger enforced by a disparate network of computers.','Morris notes. “A crash is possible but we suspect each bear market will be smaller than the last.” “The shocks seem to be lessening in magnitude,” he says. “That said, bitcoin remains a volatile asset and behaves in a not dissimilar way to a speculative growth stock.',4,14,'2021-06-03 14:17:34','2021-07-15 08:19:01'),
	(14,'{\"value\":\"Business Management\",\"icon\":\"calendar2-event-fill\",\"color\":\"#307D7E\"}','[{\"fixed\":false,\"module\":\"My Bright Idea\"},{\"fixed\":false,\"module\":\"My Business Vision\"},{\"fixed\":false,\"module\":\"My Business Mission\"},{\"fixed\":false,\"module\":\"My Business Values\"}]','2 weeks','yes','[{\"question\":\"What are the types of business finance?\",\"answer\":\"Term loan. A lump sum repiad over a fixed time. Line of credit\\/credit card. Funds that are available to use when needed. Peer-to-peer lending. A crowdfunded loan. Friends and family. When those close to you lend you money. Invoice financing. An advance on the invoices you\'ve issued.\"},{\"question\":\"What is Business Finance and its functions?\",\"answer\":\"Business finance, also known as corporate finance in the business world, is responsible for allocating resources, creating economic forecasts, reviewing opportunities for equity and debt financing, and other functions within your organization.\"},{\"question\":\"What is business finance and explain its types?\",\"answer\":\"Finance is a board term that describes the activities related to banking, leverage or debt, credit, capital markets, money and investments. Business finance tells about the funds and credit employed in the business\"},{\"question\":\"How much does a career in finance pay?\",\"answer\":\"The median pay for analysts in 2018 was $85,660 per year, according to the BLS. However, working for large Wall Street banks can be even more lucrative. Professionals there often start out making between $100,000 and $125,000, according to the job site WayUp.\"}]','Business finance refers to funds availed by business owners to meet their needs that may include commencing a business, obtaining top-up funds to finance business operations, obtaining finance to purchase capital assets for the business, or to deal with a sudden cash crunch faced by the business.','Finance is a board term that describes the activities related to banking, leverage or debt, credit, capital markets, money and investments.',14,14,'2021-06-03 14:41:33','2021-06-03 14:41:33'),
	(44,'{\"value\":\"Marketing\",\"icon\":\"basket-fill\",\"color\":\"#8A2BE2\"}','[{\"fixed\":false,\"module\":\"My Bright Idea\"},{\"fixed\":false,\"module\":\"My Business Vision\"},{\"fixed\":false,\"module\":\"My Business Mission\"},{\"fixed\":false,\"module\":\"My Business Values\"}]','1 Week','no','[{\"question\":\"Who can enroll for this course?\",\"answer\":\"Anybody!\"},{\"question\":\"Is this course online or offline?\",\"answer\":\"Fully Online\"}]','You probably know that you should have some kind of marketing plan for your business.  However, if you’ve never put one together before, it can be difficult to know where to start. To help small business owners who are serious about putting together a marketing plan, we’ve created a straightforward marketing plan template to help small business owners make the most of their marketing investments and achieve results.',NULL,44,14,'2021-06-08 22:53:16','2021-06-10 11:56:36'),
	(54,'{\"value\":\"Marketing\",\"icon\":\"basket-fill\",\"color\":\"#8A2BE2\"}','[{\"fixed\":false,\"module\":\"My Bright Idea\"},{\"fixed\":false,\"module\":\"My Business Vision\"},{\"fixed\":false,\"module\":\"My Business Mission\"},{\"fixed\":false,\"module\":\"My Business Values\"}]','6 Weeks','no','[{\"question\":\"How much is the enrollment fee?\",\"answer\":\"None at all, just you and four friends can unlock and take the course together\"},{\"question\":\"How does group access work?\",\"answer\":\"You get to access a course by inviting your friends to join the course. You can all learn together and hold group discussions in your private chat room. It\'ll be like a party, I promise!\"}]','You probably know that you should have some kind of marketing plan for your business.  However, if you’ve never put one together before, it can be difficult to know where to start. \nThe aim of this course is to sharpen your understanding of your marketplace: your competitors, geographical boundaries, types of customers you sell to, existing distribution channels, latest and most useful demographic data, any information on trends in your markets (both demographic and product-related).',NULL,74,74,'2021-06-24 14:23:19','2021-06-24 14:23:19'),
	(124,'{\"value\":\"Entrepreneurship\",\"icon\":\"card-heading\",\"color\":\"#3C565B\"}','[{\"fixed\":false,\"module\":\"Worksheet Guide\"},{\"fixed\":false,\"module\":\"Getting to know me\"},{\"fixed\":false,\"module\":\"The people in my life\"},{\"fixed\":false,\"module\":\"The road ahead\"}]','2 Weeks','no','[{\"question\":\"How much do I need to pay?\",\"answer\":\"This is a community course, meaning that you do not need to pay for access, you only need to invite your friends to take the course with you. The more the merrier!\"},{\"question\":\"What does group access mean?\",\"answer\":\"Group access means that you do not have to pay to access the course, but you can access it as a group of the required number of users\"}]','<p>While growing a business is awesome, do you know what&rsquo;s even better? Being at peace with who you really are while doing so; this is why we start right here at discovering what is within. Once completed, you will be empowered with renewed self- awareness and voice, so that you will be led to tell your own story through your entrepreneurial journey; the products and services that you develop to serve humanity.</p>\n<p>Finally, you will be able to develop and deploy strategies that best align your resources and capabilities to the requirements of your business operating environment and vision.</p>',NULL,144,74,'2021-07-05 10:38:33','2021-07-18 17:55:38'),
	(134,'{\"value\":\"Entrepreneurship\",\"icon\":\"card-heading\",\"color\":\"#3C565B\"}','[{\"fixed\":false,\"module\":\"My Business Overview\"},{\"fixed\":false,\"module\":\"My Customer Segment\"},{\"fixed\":false,\"module\":\"My Unique Value Proposition\"}]','2 Weeks','no','[{\"question\":\"How do I pay for this course?\",\"answer\":\"It is free to enroll for this course, but it is fun to share this knowledge with others so invite your friends to take it. along with you.\"},{\"question\":\"What is group access?\",\"answer\":\"Group access makes learning a party. Try it!\"}]','OK, so you have your inspiration, and you’ve seen an opportunity in the market . . . now how do those translate into your particular business concept? Exactly what are you going to sell? To whom? How? \nSimply put, your business model can make or break your business. It is essentially like laying a foundation for your business. \nConsider this: If you intend to build a story sky scraper, would it make sense to lay a foundation that is fit for a two story? \nThis segment of the program will help you understand how your company differs from others, so that your better positioned to compete.',NULL,154,74,'2021-07-06 12:44:54','2021-07-06 13:02:39'),
	(154,'{\"value\":\"Entrepreneurship\",\"icon\":\"card-heading\",\"color\":\"#3C565B\"}','[{\"fixed\":false,\"module\":\"My Bright Idea\"},{\"fixed\":false,\"module\":\"My Business Vision\"},{\"fixed\":false,\"module\":\"My Business Mission\"},{\"fixed\":false,\"module\":\"My Business Values\"}]','2 Weeks','no','[{\"question\":\"What does group access mean?\",\"answer\":\"Group access means that you do not have to pay to access the course, but you can access it as a group of the required number of users\"}]','<p>All entrepreneurs are inspired&mdash; by an idea, a person or an opportunity. That inspiration not only gets you started; it also keeps you going.What inspired this business idea? What excites you about your business idea? If you have two or three ideas, what do you like best about each one? Where did the idea come from? How has it evolved since you started the process of turning the idea into a business??&nbsp;</p>\n<p >By looking at how you initially got inspiration for your business, you can take the next step toward determining how you might get others excited about your business as well. You will find it useful to have a record of what initially inspired you, to which you can refer from time to time, especially as your business grows.</p>',NULL,174,74,'2021-07-19 12:35:33','2021-07-19 14:32:45'),
	(164,'{\"value\":\"Tech\",\"icon\":\"cpu\",\"color\":\"#347C2C\"}','[{\"fixed\":false,\"module\":\"Introduction\"},{\"fixed\":false,\"module\":\"OOP\"},{\"fixed\":false,\"module\":\"Functions\"},{\"fixed\":false,\"module\":\"Arrays\"},{\"fixed\":false,\"module\":\"Async\\/Await\"}]','2 weeks','yes','[{\"question\":\"What are functions?\",\"answer\":\"Functions are one of the fundamental building blocks in JavaScript. A function in JavaScript is similar to a procedure\\u2014a set of statements\"}]','<p><span style=\"color: #4d5156; font-family: arial, sans-serif; font-size: 14px; background-color: #ffffff;\">JavaScript is high-level, often just-in-time compiled, and multi-paradigm. It has curly-bracket syntax, dynamic typing, prototype-based object-orientation, and first-class functions.</span><span style=\"color: #4d5156; font-family: arial, sans-serif; font-size: 14px; background-color: #ffffff;\">&nbsp;</span></p>','A function in JavaScript is similar to a procedure—a set of statements',184,104,'2021-07-25 15:23:03','2021-07-25 15:23:03');

/*!40000 ALTER TABLE `course_outlines` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table course_schedules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_schedules`;

CREATE TABLE `course_schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `day` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `venue` text COLLATE utf8mb4_unicode_ci,
  `all` tinyint(1) NOT NULL,
  `modules` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_schedules_facilitator_id_foreign` (`facilitator_id`),
  KEY `course_schedules_course_id_foreign` (`course_id`),
  CONSTRAINT `course_schedules_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_schedules_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `course_schedules` WRITE;
/*!40000 ALTER TABLE `course_schedules` DISABLE KEYS */;

INSERT INTO `course_schedules` (`id`, `day`, `start_time`, `end_time`, `facilitator_id`, `course_id`, `organization_id`, `created_at`, `updated_at`, `url`, `status`, `venue`, `all`, `modules`)
VALUES
	(84,'monday','2021-06-11T11:54:47.730Z','2021-06-15T11:54:47.730Z',4,44,14,'2021-06-09 11:56:27','2021-06-09 11:56:27','https://zoom.com/4747877','inactive','Online',0,''),
	(114,'default','2021-06-24T11:17:17.360Z','2021-12-01T11:17:17.360Z',NULL,74,74,'2021-06-24 14:23:19','2021-06-24 14:23:19',NULL,'inactive','N/A',0,'[\"Redefining My MVVs\",\"My Situational Analysis (SWOT)\",\"Industry Analysis\",\"Marketing Strategy\",\"Marketing Mix\",\"Implementation and Control\"]'),
	(144,'default','2021-06-24T11:17:17.360Z','2021-12-01T11:17:17.360Z',NULL,14,74,'2021-06-24 14:23:19','2021-06-24 14:23:19',NULL,'inactive','N/A',0,''),
	(294,'default','2021-08-01T11:00:00.000Z','2021-08-31T11:00:00.000Z',44,154,74,'2021-07-06 13:02:39','2021-07-06 13:02:39',NULL,'inactive','N/A',1,'[\"My Business Overview\",\"My Customer Segment\",\"My Unique Value Proposition\"]'),
	(384,'default','2021-06-24T11:17:17.360Z','2021-12-01T11:17:17.360Z',24,4,14,'2021-07-15 08:19:01','2021-07-15 08:19:01',NULL,'inactive','N/A',1,'[\"Ovevriew\",\"Cryptomania\",\"Information\",\"Crypto Algorithm\",\"Epilogue\",\"Monologue\"]'),
	(394,'default','2021-07-12T11:00:00.000Z','2021-08-30T11:00:00.000Z',44,144,74,'2021-07-18 17:55:38','2021-07-18 17:55:38',NULL,'inactive','N/A',1,'[\"Worksheet Guide\",\"Getting to know me\",\"The people in my life\",\"The road ahead\",\"Self-reflection\",\"Affirmation\"]'),
	(434,'default','2021-07-20T11:00:00.000Z','2021-08-02T11:00:00.000Z',44,174,74,'2021-07-19 14:32:45','2021-07-19 14:32:45',NULL,'inactive','N/A',1,'[\"My Bright Idea\",\"My Business Vision\",\"My Business Mission\",\"My Business Values\"]'),
	(444,'default','2021-08-01T15:18:42.832Z','2021-08-14T15:18:42.832Z',54,184,104,'2021-07-25 15:23:03','2021-07-25 15:23:03','https://zoom.com','inactive','Online Zoom',1,'[\"Introduction\",\"OOP\",\"Functions\",\"Arrays\",\"Async\\/Await\"]');

/*!40000 ALTER TABLE `course_schedules` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table course_view_counts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_view_counts`;

CREATE TABLE `course_view_counts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `count` int(11) NOT NULL DEFAULT '0',
  `course_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_view_counts_course_id_foreign` (`course_id`),
  CONSTRAINT `course_view_counts_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `course_view_counts` WRITE;
/*!40000 ALTER TABLE `course_view_counts` DISABLE KEYS */;

INSERT INTO `course_view_counts` (`id`, `count`, `course_id`, `created_at`, `updated_at`)
VALUES
	(4,20,14,'2021-06-28 00:20:46','2021-07-23 15:05:00'),
	(14,12,74,'2021-06-28 08:24:19','2021-07-23 15:04:53'),
	(24,39,44,'2021-06-28 08:24:23','2021-07-23 15:04:54'),
	(34,10,4,'2021-06-28 08:25:08','2021-07-19 01:51:23'),
	(44,29,144,'2021-07-07 10:09:18','2021-07-23 15:04:35'),
	(54,28,154,'2021-07-07 10:10:14','2021-07-23 15:04:37'),
	(74,41,174,'2021-07-19 12:44:58','2021-07-23 15:04:52'),
	(84,6,184,'2021-07-25 23:45:57','2021-07-26 01:10:42');

/*!40000 ALTER TABLE `course_view_counts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table courses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `courses`;

CREATE TABLE `courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `course_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_organization_id_foreign` (`organization_id`),
  CONSTRAINT `courses_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;

INSERT INTO `courses` (`id`, `title`, `description`, `cover`, `course_code`, `organization_id`, `created_at`, `updated_at`, `type`, `amount`, `publicId`)
VALUES
	(4,'Crypto Life','A cryptocurrency is a digital or virtual currency that is secured by cryptography, which makes it nearly impossible to counterfeit or double-spend.','https://res.cloudinary.com/bizguruh-com/image/upload/v1622729450/jorg-angeli-CAMwIxYk5Xg-unsplash_nrj8wu.jpg',NULL,14,'2021-06-03 14:17:34','2021-06-03 14:17:34','group','10',NULL),
	(14,'Business Finannce','Business finance refers to funds availed by business owners to meet their needs that may include commencing a business, obtaining top-up funds to finance business operations, obtaining finance to purchase capital assets for the business, or to deal with a sudden cash crunch faced by the business.','https://res.cloudinary.com/bizguruh-com/image/upload/v1622730384/download_ucvkad.png',NULL,14,'2021-06-03 14:41:33','2021-06-03 14:41:33','paid','5000',NULL),
	(44,'Designing your Small Business Marketing Plan','This course will sharpen your understanding of your marketplace: your competitors, geographical boundaries, types of customers you sell to, existing distribution channels, latest and most useful demographic data, any information on trends in your markets (both demographic and product-related)','https://res.cloudinary.com/bizguruh-com/image/upload/v1623192315/Small_Business_Marketing_mgd0uw.jpg',NULL,14,'2021-06-08 22:53:16','2021-06-10 11:56:36','free','5',NULL),
	(74,'Your Small Business Marketing Plan','This straightforward marketing plan template will help small business owners make the most of their marketing investments and achieve results.','https://res.cloudinary.com/bizguruh-com/image/upload/v1624534444/Small_Business_Marketing_npbonn.jpg',NULL,74,'2021-06-24 14:23:19','2021-06-24 14:23:19','group','5',NULL),
	(144,'Discovering What\'s Within','A six-part Business Acceleration Program designed for the entrepreneur who is ready to be heard loud and clear through their business.','https://res.cloudinary.com/bizguruh-com/image/upload/v1625762387/self_discovery_wsddiy.jpg',NULL,74,'2021-07-05 10:38:33','2021-07-15 08:12:09','group','5',NULL),
	(154,'Business Acceleration Program 2','A six-part Business Acceleration Program designed for the entrepreneur who is ready to be heard loud and clear through their business.','https://res.cloudinary.com/bizguruh-com/image/upload/v1625574748/Business_model_blocks_ehseam.png',NULL,74,'2021-07-06 12:44:54','2021-07-06 12:44:54','group','10',NULL),
	(174,'Idea to Business','A six-part Business Acceleration Program designed for the entrepreneur who is ready to be heard loud and clear through their business.','https://res.cloudinary.com/bizguruh-com/image/upload/v1626705152/bright_idea_1_vyey8j.jpg',NULL,74,'2021-07-19 12:35:33','2021-07-19 14:32:45','group','10',NULL),
	(184,'Introduction to Javascript','JavaScript, often abbreviated as JS, is a programming language that conforms to the ECMAScript specification.','https://res.cloudinary.com/skillsguruh/image/upload/v1627226410/javascript-1567486564472_phdtde.jpg',NULL,104,'2021-07-25 15:23:03','2021-07-25 15:23:03','paid','5000',NULL);

/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table curriculums
# ------------------------------------------------------------

DROP TABLE IF EXISTS `curriculums`;

CREATE TABLE `curriculums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `curriculums_course_id_foreign` (`course_id`),
  KEY `curriculums_organization_id_foreign` (`organization_id`),
  CONSTRAINT `curriculums_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `curriculums_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table discussion_message_comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `discussion_message_comments`;

CREATE TABLE `discussion_message_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `discussion_message_id` bigint(20) unsigned NOT NULL,
  `discussion_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discussion_message_comments_admin_id_foreign` (`admin_id`),
  KEY `discussion_message_comments_user_id_foreign` (`user_id`),
  KEY `discussion_message_comments_facilitator_id_foreign` (`facilitator_id`),
  KEY `discussion_message_comments_discussion_message_id_foreign` (`discussion_message_id`),
  KEY `discussion_message_comments_discussion_id_foreign` (`discussion_id`),
  KEY `discussion_message_comments_organization_id_foreign` (`organization_id`),
  CONSTRAINT `discussion_message_comments_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_message_comments_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_message_comments_discussion_message_id_foreign` FOREIGN KEY (`discussion_message_id`) REFERENCES `discussion_messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_message_comments_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_message_comments_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_message_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table discussion_messages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `discussion_messages`;

CREATE TABLE `discussion_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `discussion_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discussion_messages_admin_id_foreign` (`admin_id`),
  KEY `discussion_messages_user_id_foreign` (`user_id`),
  KEY `discussion_messages_facilitator_id_foreign` (`facilitator_id`),
  KEY `discussion_messages_discussion_id_foreign` (`discussion_id`),
  KEY `discussion_messages_organization_id_foreign` (`organization_id`),
  CONSTRAINT `discussion_messages_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_messages_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_messages_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_messages_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `discussion_messages` WRITE;
/*!40000 ALTER TABLE `discussion_messages` DISABLE KEYS */;

INSERT INTO `discussion_messages` (`id`, `message`, `attachment`, `admin_id`, `user_id`, `facilitator_id`, `discussion_id`, `organization_id`, `created_at`, `updated_at`, `publicId`)
VALUES
	(4,'Hi guys',NULL,NULL,4,NULL,24,14,'2021-07-08 13:15:02','2021-07-08 13:15:02',NULL),
	(14,'Welcome',NULL,NULL,NULL,4,4,14,'2021-07-08 16:34:53','2021-07-08 16:34:53',NULL),
	(24,NULL,NULL,NULL,4,NULL,4,14,'2021-07-18 13:10:59','2021-07-18 13:10:59',NULL),
	(34,NULL,NULL,NULL,4,NULL,4,14,'2021-07-18 13:11:00','2021-07-18 13:11:00',NULL),
	(44,NULL,NULL,NULL,4,NULL,4,14,'2021-07-18 13:11:29','2021-07-18 13:11:29',NULL),
	(54,'Hello',NULL,NULL,4,NULL,4,14,'2021-07-18 15:39:12','2021-07-18 15:39:12',NULL),
	(64,'Let’s talk about fun things',NULL,NULL,4,NULL,4,14,'2021-07-18 15:39:29','2021-07-18 15:39:29',NULL),
	(74,'hi success I\'m testing voice to speech on my laptop and it seems to be working .',NULL,NULL,4,NULL,4,14,'2021-07-19 17:48:51','2021-07-19 17:48:51',NULL);

/*!40000 ALTER TABLE `discussion_messages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table discussion_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `discussion_requests`;

CREATE TABLE `discussion_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discussion_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `response` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `discussion_requests_user_id_foreign` (`user_id`),
  KEY `discussion_requests_admin_id_foreign` (`admin_id`),
  KEY `discussion_requests_facilitator_id_foreign` (`facilitator_id`),
  CONSTRAINT `discussion_requests_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_requests_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table discussion_views
# ------------------------------------------------------------

DROP TABLE IF EXISTS `discussion_views`;

CREATE TABLE `discussion_views` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `view` int(11) NOT NULL DEFAULT '0',
  `discussion_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discussion_views_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `discussion_views_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `discussion_views` WRITE;
/*!40000 ALTER TABLE `discussion_views` DISABLE KEYS */;

INSERT INTO `discussion_views` (`id`, `view`, `discussion_id`, `created_at`, `updated_at`)
VALUES
	(4,62,4,'2021-06-03 16:51:39','2021-07-23 21:19:26'),
	(14,1,14,'2021-06-06 22:09:16','2021-06-06 22:09:16'),
	(24,3,24,'2021-07-08 12:05:24','2021-07-19 16:12:33'),
	(54,4,44,'2021-07-25 14:20:15','2021-07-26 00:50:08');

/*!40000 ALTER TABLE `discussion_views` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table discussion_votes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `discussion_votes`;

CREATE TABLE `discussion_votes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vote` tinyint(1) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `discussion_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discussion_votes_user_id_foreign` (`user_id`),
  KEY `discussion_votes_facilitator_id_foreign` (`facilitator_id`),
  KEY `discussion_votes_admin_id_foreign` (`admin_id`),
  KEY `discussion_votes_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `discussion_votes_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_votes_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_votes_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_votes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `discussion_votes` WRITE;
/*!40000 ALTER TABLE `discussion_votes` DISABLE KEYS */;

INSERT INTO `discussion_votes` (`id`, `vote`, `user_id`, `facilitator_id`, `admin_id`, `discussion_id`, `created_at`, `updated_at`)
VALUES
	(4,1,4,NULL,NULL,4,'2021-06-30 11:11:54','2021-06-30 11:11:54'),
	(14,1,NULL,4,NULL,4,'2021-07-08 16:34:42','2021-07-08 16:34:42');

/*!40000 ALTER TABLE `discussion_votes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table discussions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `discussions`;

CREATE TABLE `discussions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discussions_user_id_foreign` (`user_id`),
  KEY `discussions_facilitator_id_foreign` (`facilitator_id`),
  KEY `discussions_admin_id_foreign` (`admin_id`),
  KEY `discussions_course_id_foreign` (`course_id`),
  KEY `discussions_organization_id_foreign` (`organization_id`),
  CONSTRAINT `discussions_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussions_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussions_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussions_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `discussions` WRITE;
/*!40000 ALTER TABLE `discussions` DISABLE KEYS */;

INSERT INTO `discussions` (`id`, `name`, `type`, `creator`, `description`, `tags`, `user_id`, `facilitator_id`, `admin_id`, `course_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,'How to mine crypto','public','admin','A detailed guide on learning to mine crypto currency','[{\"value\":\"Crypto\",\"icon\":\"bullseye\",\"color\":\"#0AFFFF\"}]',NULL,NULL,24,NULL,14,'2021-06-03 15:20:02','2021-06-03 15:20:02'),
	(14,'Get your Financial Advise','private','admin','Get your Financial Advise','[{\"value\":\"Business Management\",\"icon\":\"calendar2-event-fill\",\"color\":\"#307D7E\"}]',NULL,NULL,24,14,14,'2021-06-03 15:21:12','2021-06-03 15:21:12'),
	(24,'Group+Course-3861','private','user','A cryptocurrency is a digital or virtual currency that is secured by cryptography, which makes it nearly impossible to counterfeit or double-spend.','[]',4,NULL,NULL,4,14,'2021-07-08 12:01:15','2021-07-08 12:01:15'),
	(34,'How to become a fullstack developer','public','admin','A full stack developer is an engineer who can handle all the work of databases, servers, systems engineering, and clients. As one of the hottest topics for developers, the discussions have never stopped. On LinkedIn and Facebook, lots of people put their job title as a full stack developer.','[{\"value\":\"Tech\",\"icon\":\"cpu\",\"color\":\"#347C2C\"}]',NULL,NULL,64,NULL,104,'2021-07-25 14:19:04','2021-07-25 14:19:04'),
	(44,'Javascript Functions','public','admin','A function in JavaScript is similar to a procedure—a set of statements that performs a task or calculates a value, but for a procedure to qualify as a function, it should take some input and return an output where there is some obvious relationship between the input and the output.','[{\"value\":\"Tech\",\"icon\":\"cpu\",\"color\":\"#347C2C\"}]',NULL,NULL,64,NULL,104,'2021-07-25 14:20:08','2021-07-25 14:20:08');

/*!40000 ALTER TABLE `discussions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table enroll_counts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enroll_counts`;

CREATE TABLE `enroll_counts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `count` int(11) NOT NULL DEFAULT '0',
  `course_id` bigint(20) unsigned NOT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enroll_counts_course_id_foreign` (`course_id`),
  KEY `enroll_counts_facilitator_id_foreign` (`facilitator_id`),
  KEY `enroll_counts_organization_id_foreign` (`organization_id`),
  CONSTRAINT `enroll_counts_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enroll_counts_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enroll_counts_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `enroll_counts` WRITE;
/*!40000 ALTER TABLE `enroll_counts` DISABLE KEYS */;

INSERT INTO `enroll_counts` (`id`, `count`, `course_id`, `facilitator_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,1,44,NULL,14,'2021-06-10 11:57:07','2021-06-10 11:57:07'),
	(14,1,14,NULL,14,'2021-06-28 00:29:11','2021-06-28 00:29:11'),
	(34,1,184,NULL,104,'2021-07-26 01:11:49','2021-07-26 01:11:49');

/*!40000 ALTER TABLE `enroll_counts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event_attendances
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event_attendances`;

CREATE TABLE `event_attendances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_attendances_user_id_foreign` (`user_id`),
  KEY `event_attendances_event_id_foreign` (`event_id`),
  CONSTRAINT `event_attendances_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `event_attendances` WRITE;
/*!40000 ALTER TABLE `event_attendances` DISABLE KEYS */;

INSERT INTO `event_attendances` (`id`, `user_id`, `event_id`, `created_at`, `updated_at`)
VALUES
	(4,54,34,'2021-07-26 00:45:47','2021-07-26 00:45:47');

/*!40000 ALTER TABLE `event_attendances` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `schedule` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `facilitators` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `resource` text COLLATE utf8mb4_unicode_ci,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `start` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `venue` text COLLATE utf8mb4_unicode_ci,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `events_organization_id_foreign` (`organization_id`),
  KEY `events_facilitator_id_foreign` (`facilitator_id`),
  KEY `events_admin_id_foreign` (`admin_id`),
  CONSTRAINT `events_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `events_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `events_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;

INSERT INTO `events` (`id`, `type`, `title`, `description`, `schedule`, `facilitators`, `url`, `resource`, `cover`, `created_at`, `updated_at`, `organization_id`, `start`, `end`, `status`, `facilitator_id`, `admin_id`, `venue`, `publicId`)
VALUES
	(4,'seminar','SkillsGuruh Business Seminar','Finance represents the money management and the process of acquiring the funds. Finance is a board term that describes the activities related to banking, leverage or debt, credit, capital markets, money and investments. Business finance tells about the funds and credit employed in the business.','1 week','[4,14]','https://zoom.com/t57757','https://res.cloudinary.com/bizguruh-com/video/upload/v1622732389/Pilot_ciwgby.mp4','https://res.cloudinary.com/bizguruh-com/image/upload/v1622732386/smartmockups_kmcqaof5_sxndfm.jpg','2021-06-03 15:06:08','2021-06-03 15:06:08',14,'2021-07-16T09:57:00.000Z','2021-08-01T08:57:00.000Z','pending',NULL,24,'Online Zoom Seminar',NULL),
	(14,'seminar','Africa Revenue Summit (AFRES)','Scaling Growth, Optimizing Margins','3 days','[4]',NULL,NULL,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622733283/abaytours_qzbwnu.jpg','2021-06-03 15:17:25','2021-06-08 15:06:37',14,'2021-06-05T15:06:09.275Z','2021-06-08T15:06:09.275Z','expired',NULL,24,'The Campbell Center, Lagos',NULL),
	(24,'seminar','SkillsGuruh Seminar','An introduction to skillsguruh. has a social platform for learning','3 days','[24,4]',NULL,'https://res.cloudinary.com/bizguruh-com/video/upload/v1623240183/Pilot_qvtgav.mp4','https://res.cloudinary.com/bizguruh-com/image/upload/v1623240155/smartmockups_kmcm0vtk_u8cnd7.jpg','2021-06-09 12:03:10','2021-06-09 12:03:10',14,'2021-06-16T12:01:00.000Z','2021-06-19T12:01:38.480Z','pending',4,NULL,'Mega-1 Events Place',NULL),
	(34,'seminar','IT Training Seminar','JavaScript is high-level, often just-in-time compiled, and multi-paradigm. It has curly-bracket syntax, dynamic typing, prototype-based object-orientation, and first-class functions.','2 weeks','[54]',NULL,'https://res.cloudinary.com/skillsguruh/video/upload/v1627222654/Pilot_rgvceb.mp4','https://res.cloudinary.com/skillsguruh/image/upload/v1627222658/Illustration_rbr4zt.png','2021-07-25 14:17:45','2021-07-25 14:17:45',104,'2021-08-01T14:17:12.569Z','2021-08-14T14:17:17.356Z','pending',NULL,64,'Functional Hall',NULL);

/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table facilitator_modules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `facilitator_modules`;

CREATE TABLE `facilitator_modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `modules` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `facilitator_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facilitator_modules_course_id_foreign` (`course_id`),
  KEY `facilitator_modules_facilitator_id_foreign` (`facilitator_id`),
  CONSTRAINT `facilitator_modules_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `facilitator_modules_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `facilitator_modules` WRITE;
/*!40000 ALTER TABLE `facilitator_modules` DISABLE KEYS */;

INSERT INTO `facilitator_modules` (`id`, `modules`, `course_id`, `facilitator_id`, `created_at`, `updated_at`)
VALUES
	(44,'[\"Worksheet Guide\",\"Getting to know me\",\"The people in my life\",\"The road ahead\",\"Self-reflection\",\"Affirmation\"]',144,44,'2021-07-05 10:38:33','2021-07-15 08:09:37'),
	(54,'[\"My Business Overview\",\"My Customer Segment\",\"My Unique Value Proposition\"]',154,44,'2021-07-06 12:44:54','2021-07-06 12:44:54'),
	(74,'[\"My Bright Idea\",\"My Business Vision\",\"My Business Mission\",\"My Business Values\"]',174,44,'2021-07-19 12:35:33','2021-07-19 12:35:33'),
	(84,'[\"Introduction\",\"OOP\",\"Functions\",\"Arrays\",\"Async\\/Await\"]',184,54,'2021-07-25 15:23:03','2021-07-25 15:23:03');

/*!40000 ALTER TABLE `facilitator_modules` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table facilitators
# ------------------------------------------------------------

DROP TABLE IF EXISTS `facilitators`;

CREATE TABLE `facilitators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `profile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qualifications` text COLLATE utf8mb4_unicode_ci,
  `verification` tinyint(1) DEFAULT '0',
  `referral_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `interests` longtext COLLATE utf8mb4_unicode_ci,
  `age` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lga` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facilitator_role` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` bigint(20) DEFAULT NULL,
  `voice` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `facilitators_email_unique` (`email`),
  KEY `facilitators_organization_id_foreign` (`organization_id`),
  CONSTRAINT `facilitators_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `facilitators` WRITE;
/*!40000 ALTER TABLE `facilitators` DISABLE KEYS */;

INSERT INTO `facilitators` (`id`, `name`, `email`, `email_verified_at`, `password`, `phone`, `address`, `bio`, `profile`, `qualifications`, `verification`, `referral_code`, `created_at`, `updated_at`, `organization_id`, `interests`, `age`, `gender`, `lga`, `state`, `country`, `facilitator_role`, `bank_name`, `account_number`, `voice`, `publicId`)
VALUES
	(4,'David Komoni','bizguruh@gmail.com',NULL,'$2y$10$m67W3urVNO2G9YVIp7V3cu3XlJYeW2t31h4JsN.Ci5GYbRKC5j8jS','08166741279',NULL,NULL,NULL,'null',0,'OQ4567','2021-06-03 13:32:14','2021-06-03 16:27:51',14,'[\"Marketing\",\"Business Management\",\"Personal Development\",\"SDGs\",\"Politics\",\"Fitness\",\"Racism\",\"Crypto\",\"Public Speaking\",\"Legal\",\"Fashion\",\"Agriculture\",\"Living\",\"Digital Media\",\"Leisure\",\"Global Trends\",\"Creativity\"]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL),
	(24,'Kerry Johnson','succcy2010@gmail.com',NULL,'$2y$10$DPE/jAksVYHzq6JYHagXIurWEseWcop50qNX69KPhX8I1H57CQ3Ia','415601304',NULL,NULL,NULL,'null',0,'VP7638','2021-06-03 13:34:24','2021-06-03 13:34:24',14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL),
	(34,'Ann','annonyinye12@gmail.com',NULL,'$2y$10$Wjz7PjpJpQOURSQB5TjqPuuPkQkDAu1QiIyq8GZ2zmRxV59DxYinO','0502703613',NULL,NULL,NULL,'null',0,'AnnGP1027','2021-06-21 11:16:13','2021-06-21 11:16:13',24,NULL,NULL,NULL,NULL,NULL,'NG',NULL,NULL,NULL,'1',NULL),
	(44,'Oluchi Igbojekwe','oigbojekwe@gmail.com',NULL,'$2y$10$2HeF6dMk7aPzWbNA7I6kpe3xSCd0yibL2sXZuNDYBk40qnGF8t3/i','08138580831',NULL,NULL,NULL,'null',1,'Oluchi_IgbojekweSC9398','2021-06-24 11:07:34','2021-06-24 11:12:02',74,NULL,NULL,NULL,NULL,NULL,'NG',NULL,NULL,NULL,'1',NULL),
	(54,'Success Ahon','successahon@gmail.com',NULL,'$2y$10$ISvNgj0B49Fjc//PXBnPg.K26QICeN5EV6F.mLttw/vnC4BLfEmUC','08102588390',NULL,NULL,NULL,'null',1,'Success_Ahon_5051','2021-07-25 12:17:40','2021-07-25 21:58:58',104,NULL,NULL,NULL,NULL,'Lagos','NG','facilitator',NULL,NULL,'1',NULL);

/*!40000 ALTER TABLE `facilitators` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table failed_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table feed_comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feed_comments`;

CREATE TABLE `feed_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `feed_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `feed_comments` WRITE;
/*!40000 ALTER TABLE `feed_comments` DISABLE KEYS */;

INSERT INTO `feed_comments` (`id`, `comment`, `feed_id`, `user_id`, `facilitator_id`, `admin_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,'The Igbo girl in me does not agree with this.?',4,4,NULL,NULL,14,'2021-06-04 11:39:37','2021-06-04 11:39:37'),
	(14,'Nice video... very funny ???',24,4,NULL,NULL,14,'2021-06-06 21:17:37','2021-06-06 21:17:37'),
	(24,'?',14,NULL,4,NULL,14,'2021-06-06 21:24:33','2021-06-06 21:24:33'),
	(34,'????',14,4,NULL,NULL,14,'2021-06-06 21:24:48','2021-06-06 21:24:48'),
	(44,'LOL..',4,NULL,4,NULL,14,'2021-06-06 21:25:21','2021-06-06 21:25:21'),
	(54,'Testung my comments',84,NULL,4,NULL,14,'2021-07-20 23:57:53','2021-07-20 23:57:53');

/*!40000 ALTER TABLE `feed_comments` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table feed_likes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feed_likes`;

CREATE TABLE `feed_likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `like` tinyint(1) NOT NULL,
  `feed_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `feed_likes` WRITE;
/*!40000 ALTER TABLE `feed_likes` DISABLE KEYS */;

INSERT INTO `feed_likes` (`id`, `like`, `feed_id`, `user_id`, `facilitator_id`, `admin_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,1,34,4,NULL,NULL,14,'2021-06-12 16:41:04','2021-06-12 16:41:04'),
	(14,1,114,NULL,4,NULL,14,'2021-07-08 16:29:12','2021-07-08 16:29:12');

/*!40000 ALTER TABLE `feed_likes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table feed_stars
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feed_stars`;

CREATE TABLE `feed_stars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `star` tinyint(1) NOT NULL,
  `feed_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `feed_stars` WRITE;
/*!40000 ALTER TABLE `feed_stars` DISABLE KEYS */;

INSERT INTO `feed_stars` (`id`, `star`, `feed_id`, `user_id`, `facilitator_id`, `admin_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,1,34,4,NULL,NULL,14,'2021-06-12 16:41:01','2021-06-12 16:41:01'),
	(14,1,114,NULL,4,NULL,14,'2021-07-08 16:29:10','2021-07-08 16:29:10');

/*!40000 ALTER TABLE `feed_stars` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table feedbacks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rating` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `feedback` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `event_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_course_id_foreign` (`course_id`),
  KEY `feedbacks_event_id_foreign` (`event_id`),
  KEY `feedbacks_user_id_foreign` (`user_id`),
  CONSTRAINT `feedbacks_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feedbacks_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feedbacks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table feeds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feeds`;

CREATE TABLE `feeds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media` text COLLATE utf8mb4_unicode_ci,
  `message` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` text COLLATE utf8mb4_unicode_ci,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `feeds` WRITE;
/*!40000 ALTER TABLE `feeds` DISABLE KEYS */;

INSERT INTO `feeds` (`id`, `media`, `message`, `user_id`, `facilitator_id`, `admin_id`, `organization_id`, `created_at`, `updated_at`, `url`, `tags`, `publicId`)
VALUES
	(4,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622731832/download_mhwcbm.jpg','This is brand new day and a time to become a better person',NULL,NULL,24,14,'2021-06-03 14:50:43','2021-06-03 14:50:43',NULL,NULL,NULL),
	(14,'https://res.cloudinary.com/bizguruh-com/video/upload/v1622731967/Pilot_qz0hjl.mp4','Check this out !!!  ???',NULL,NULL,24,14,'2021-06-03 14:55:15','2021-06-03 14:55:15',NULL,NULL,NULL),
	(24,'https://res.cloudinary.com/bizguruh-com/video/upload/v1622738965/Overview_ne40bg.mp4','New Video alert.  ??',4,NULL,NULL,14,'2021-06-03 16:50:50','2021-06-03 16:50:50',NULL,NULL,NULL),
	(34,'https://res.cloudinary.com/bizguruh-com/image/upload/v1623192315/Small_Business_Marketing_mgd0uw.jpg','I enrolled for the Designing your Small Business Marketing Plan course and I think you’d like it. Join me!',4,NULL,NULL,14,'2021-06-12 16:40:38','2021-06-12 16:40:38','https://skillsguruh.herokuapp.com/learner/courses/?course_id=44',NULL,NULL),
	(44,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622730384/download_ucvkad.png','I enrolled for the course, the Business Finannce course and I think you’d like it. Join me!',4,NULL,NULL,14,'2021-07-03 20:25:29','2021-07-03 20:25:29','https://skillsguruh.com/learner/courses/?course_id=14',NULL,NULL),
	(84,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622729450/jorg-angeli-CAMwIxYk5Xg-unsplash_nrj8wu.jpg','Check out my course, CRYPTO LIFE on SkillsGuruh and I think you’d like it. Join me!',NULL,4,NULL,14,'2021-07-07 10:32:29','2021-07-07 10:32:29','https://skillsguruh.com/learner/courses/?course_id=4',NULL,NULL),
	(94,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622729450/jorg-angeli-CAMwIxYk5Xg-unsplash_nrj8wu.jpg','Check out my course, CRYPTO LIFE on SkillsGuruh and I think you’d like it. Join me!',NULL,4,NULL,14,'2021-07-07 10:32:30','2021-07-07 10:32:30','https://skillsguruh.com/learner/courses/?course_id=4',NULL,NULL),
	(104,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622730384/download_ucvkad.png','I enrolled for the course, the Business Finannce course and I think you’d like it. Join me!',4,NULL,NULL,14,'2021-07-07 16:00:23','2021-07-07 16:00:23','https://skillsguruh.com/learner/courses/?course_id=14',NULL,NULL),
	(114,'https://res.cloudinary.com/bizguruh-com/image/upload/v1622729450/jorg-angeli-CAMwIxYk5Xg-unsplash_nrj8wu.jpg','Check out my course, CRYPTO LIFE on SkillsGuruh and I think you’d like it. Join me!',NULL,4,NULL,14,'2021-07-07 19:29:48','2021-07-07 19:29:48','https://skillsguruh.com/learner/courses/?course_id=4',NULL,NULL),
	(124,NULL,'<p>I enrolled for the course, Group Course course and I think you’d like it. Join me!</p> <p>dESCRIPTION...</p>',4,NULL,NULL,14,'2021-07-08 11:42:35','2021-07-08 11:42:35','https://skillsguruh.herokuapp.com/learner/courses/?course_id=164',NULL,NULL),
	(134,NULL,'Add feed',NULL,24,NULL,14,'2021-07-12 15:02:22','2021-07-12 15:02:22',NULL,'[]',NULL),
	(144,NULL,'About to complete my course on self-discovery. Watch out for it!',NULL,44,NULL,74,'2021-07-15 07:46:18','2021-07-15 07:46:18',NULL,'[{\"text\":\"Entrepreneurship\",\"value\":\"Entrepreneurship\",\"color\":\"#3C565B\",\"icon\":\"card-heading\"},{\"text\":\"Business Management\",\"value\":\"Business Management\",\"color\":\"#307D7E\",\"icon\":\"calendar2-event-fill\"},{\"text\":\"Mental health\",\"value\":\"Mental health\",\"color\":\"#3C565B\",\"icon\":\"diagram2-fill\"},{\"text\":\"Productivity\",\"value\":\"Productivity\",\"color\":\"#191970\",\"icon\":\"collection-fill\"}]',NULL),
	(154,NULL,'Happy Sunday Everyone',NULL,NULL,64,104,'2021-07-25 14:16:20','2021-07-25 14:16:20',NULL,'[]',NULL),
	(164,'https://res.cloudinary.com/skillsguruh/image/upload/v1627223750/javascript-1567486564472_zalrln.jpg','Watch out for my new javascript course , coming out the new wekk guys ????',NULL,NULL,64,104,'2021-07-25 14:36:20','2021-07-25 14:36:20',NULL,'[{\"text\":\"Tech\",\"value\":\"Tech\",\"color\":\"#347C2C\",\"icon\":\"cpu\"}]','javascript-1567486564472_zalrln'),
	(174,NULL,'A big welcome to everybody ?',NULL,54,NULL,104,'2021-07-25 20:44:39','2021-07-25 20:44:39',NULL,'[]',NULL),
	(184,'https://res.cloudinary.com/skillsguruh/image/upload/v1627226410/javascript-1567486564472_phdtde.jpg','I created a course titled, <b>Introduction to Javascript</b>, Check it out here',NULL,54,NULL,104,'2021-07-25 20:54:50','2021-07-25 20:54:50','https://skillsguruh.com/learner/courses/?course_id=184','null',NULL),
	(194,NULL,'?',54,NULL,NULL,104,'2021-07-26 02:06:38','2021-07-26 02:06:38',NULL,'[]',NULL);

/*!40000 ALTER TABLE `feeds` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table highest_earning_courses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `highest_earning_courses`;

CREATE TABLE `highest_earning_courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `revenue` bigint(20) NOT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `highest_earning_courses_course_id_foreign` (`course_id`),
  KEY `highest_earning_courses_organization_id_foreign` (`organization_id`),
  CONSTRAINT `highest_earning_courses_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `highest_earning_courses_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `highest_earning_courses` WRITE;
/*!40000 ALTER TABLE `highest_earning_courses` DISABLE KEYS */;

INSERT INTO `highest_earning_courses` (`id`, `revenue`, `course_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,5000,184,104,'2021-07-26 01:11:49','2021-07-26 01:11:49');

/*!40000 ALTER TABLE `highest_earning_courses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table inboxes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `inboxes`;

CREATE TABLE `inboxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inboxes_user_id_foreign` (`user_id`),
  KEY `inboxes_facilitator_id_foreign` (`facilitator_id`),
  KEY `inboxes_admin_id_foreign` (`admin_id`),
  CONSTRAINT `inboxes_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inboxes_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inboxes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `inboxes` WRITE;
/*!40000 ALTER TABLE `inboxes` DISABLE KEYS */;

INSERT INTO `inboxes` (`id`, `message`, `attachment`, `receiver`, `receiver_id`, `user_id`, `facilitator_id`, `admin_id`, `status`, `created_at`, `updated_at`, `publicId`)
VALUES
	(64,'Hi',NULL,'facilitator','4',4,NULL,NULL,1,'2021-06-17 13:33:46','2021-07-22 16:29:39',NULL),
	(74,'Hello',NULL,'facilitator','4',4,NULL,NULL,1,'2021-07-08 13:20:17','2021-07-22 16:29:39',NULL),
	(84,'Hi Kery',NULL,'user','4',NULL,4,NULL,1,'2021-07-08 16:30:42','2021-07-22 16:29:39',NULL),
	(94,'?',NULL,'facilitator','4',4,NULL,NULL,1,'2021-07-13 12:31:54','2021-07-22 16:29:39',NULL),
	(104,'? Testing the chat',NULL,'user','4',NULL,4,NULL,1,'2021-07-20 23:44:25','2021-07-22 16:29:39',NULL),
	(114,'#Nice','https://res.cloudinary.com/bizguruh-com/image/upload/v1626824777/Screenshot_2021-05-29-11-38-20-865_com.instagram.android_dbzipx.jpg','user','4',NULL,4,NULL,1,'2021-07-20 23:46:34','2021-07-22 16:29:39',NULL),
	(124,'Nice','https://res.cloudinary.com/bizguruh-com/image/upload/v1626824829/Screenshot_2021-07-21-00-45-02-979_com.android.chrome_zpfjgc.jpg','user','4',NULL,4,NULL,1,'2021-07-20 23:47:23','2021-07-22 16:29:39',NULL),
	(134,'Testing Video','https://res.cloudinary.com/bizguruh-com/video/upload/v1626825041/VID-20210716-WA0009_erjujp.mp4','user','4',NULL,4,NULL,1,'2021-07-20 23:50:59','2021-07-22 16:29:39',NULL),
	(144,NULL,'https://res.cloudinary.com/bizguruh-com/image/upload/v1626826447/IMG-20210720-WA0006_i7iqme.jpg','facilitator','4',4,NULL,NULL,1,'2021-07-21 00:14:13','2021-07-22 16:29:39',NULL),
	(154,NULL,'https://res.cloudinary.com/bizguruh-com/image/upload/v1626826684/IMG-20210719-WA0040_hteqk0.jpg','user','4',NULL,4,NULL,1,'2021-07-21 00:18:09','2021-07-22 16:29:39',NULL);

/*!40000 ALTER TABLE `inboxes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table learner_assessments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `learner_assessments`;

CREATE TABLE `learner_assessments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `assessment_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `learner_assessments_user_id_foreign` (`user_id`),
  KEY `learner_assessments_assessment_id_foreign` (`assessment_id`),
  CONSTRAINT `learner_assessments_assessment_id_foreign` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `learner_assessments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table libraries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libraries`;

CREATE TABLE `libraries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `progress` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_module` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_modules` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assessment_id` bigint(20) unsigned DEFAULT NULL,
  `assessment_response_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libraries_course_id_foreign` (`course_id`),
  KEY `libraries_user_id_foreign` (`user_id`),
  KEY `libraries_assessment_id_foreign` (`assessment_id`),
  KEY `libraries_assessment_response_id_foreign` (`assessment_response_id`),
  CONSTRAINT `libraries_assessment_id_foreign` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libraries_assessment_response_id_foreign` FOREIGN KEY (`assessment_response_id`) REFERENCES `assessment_responses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libraries_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libraries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `libraries` WRITE;
/*!40000 ALTER TABLE `libraries` DISABLE KEYS */;

INSERT INTO `libraries` (`id`, `course_id`, `user_id`, `created_at`, `updated_at`, `progress`, `current_module`, `total_modules`, `assessment_id`, `assessment_response_id`)
VALUES
	(24,44,4,'2021-06-10 11:57:07','2021-06-10 11:57:07',NULL,NULL,NULL,NULL,NULL),
	(34,4,4,'2021-06-10 11:57:07','2021-06-25 12:28:40','100','6','6',NULL,NULL),
	(94,184,54,'2021-07-26 01:11:49','2021-07-26 01:14:06','100','1','1',NULL,NULL);

/*!40000 ALTER TABLE `libraries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table linked_social_accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linked_social_accounts`;

CREATE TABLE `linked_social_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `linked_social_accounts_user_id_foreign` (`user_id`),
  CONSTRAINT `linked_social_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `linked_social_accounts` WRITE;
/*!40000 ALTER TABLE `linked_social_accounts` DISABLE KEYS */;

INSERT INTO `linked_social_accounts` (`id`, `provider_id`, `provider_name`, `user_id`, `created_at`, `updated_at`)
VALUES
	(4,'102418319970772093165','google',14,'2021-07-14 23:10:27','2021-07-14 23:10:27');

/*!40000 ALTER TABLE `linked_social_accounts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table login_histories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `login_histories`;

CREATE TABLE `login_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `record` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2514 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `login_histories` WRITE;
/*!40000 ALTER TABLE `login_histories` DISABLE KEYS */;

INSERT INTO `login_histories` (`id`, `record`, `user_id`, `facilitator_id`, `admin_id`, `created_at`, `updated_at`)
VALUES
	(4,'2021-06-03 13:51:28',NULL,NULL,24,'2021-06-03 13:51:28','2021-06-03 13:51:28'),
	(14,'2021-06-03 16:05:02',NULL,NULL,24,'2021-06-03 16:05:02','2021-06-03 16:05:02'),
	(24,'2021-06-03 16:05:42',NULL,NULL,24,'2021-06-03 16:05:42','2021-06-03 16:05:42'),
	(34,'2021-06-03 16:23:30',NULL,4,NULL,'2021-06-03 16:23:30','2021-06-03 16:23:30'),
	(44,'2021-06-03 16:40:16',4,NULL,NULL,'2021-06-03 16:40:16','2021-06-03 16:40:16'),
	(54,'2021-06-04 01:50:03',4,NULL,NULL,'2021-06-04 01:50:03','2021-06-04 01:50:03'),
	(64,'2021-06-04 06:13:42',4,NULL,NULL,'2021-06-04 06:13:42','2021-06-04 06:13:42'),
	(74,'2021-06-04 06:13:42',4,NULL,NULL,'2021-06-04 06:13:42','2021-06-04 06:13:42'),
	(84,'2021-06-04 11:36:27',4,NULL,NULL,'2021-06-04 11:36:27','2021-06-04 11:36:27'),
	(94,'2021-06-04 11:36:27',4,NULL,NULL,'2021-06-04 11:36:27','2021-06-04 11:36:27'),
	(104,'2021-06-04 12:19:35',NULL,4,NULL,'2021-06-04 12:19:35','2021-06-04 12:19:35'),
	(114,'2021-06-04 14:31:09',NULL,4,NULL,'2021-06-04 14:31:09','2021-06-04 14:31:09'),
	(124,'2021-06-04 20:37:23',4,NULL,NULL,'2021-06-04 20:37:23','2021-06-04 20:37:23'),
	(134,'2021-06-04 20:37:24',4,NULL,NULL,'2021-06-04 20:37:24','2021-06-04 20:37:24'),
	(144,'2021-06-05 13:50:10',4,NULL,NULL,'2021-06-05 13:50:10','2021-06-05 13:50:10'),
	(154,'2021-06-05 13:50:10',4,NULL,NULL,'2021-06-05 13:50:10','2021-06-05 13:50:10'),
	(164,'2021-06-06 20:12:40',NULL,NULL,24,'2021-06-06 20:12:40','2021-06-06 20:12:40'),
	(174,'2021-06-06 20:13:49',NULL,4,NULL,'2021-06-06 20:13:49','2021-06-06 20:13:49'),
	(184,'2021-06-06 20:14:07',4,NULL,NULL,'2021-06-06 20:14:07','2021-06-06 20:14:07'),
	(194,'2021-06-06 21:42:48',4,NULL,NULL,'2021-06-06 21:42:48','2021-06-06 21:42:48'),
	(204,'2021-06-06 21:55:32',NULL,4,NULL,'2021-06-06 21:55:32','2021-06-06 21:55:32'),
	(214,'2021-06-06 21:57:19',NULL,NULL,24,'2021-06-06 21:57:19','2021-06-06 21:57:19'),
	(224,'2021-06-07 10:52:56',NULL,NULL,24,'2021-06-07 10:52:56','2021-06-07 10:52:56'),
	(234,'2021-06-07 10:56:01',NULL,NULL,24,'2021-06-07 10:56:01','2021-06-07 10:56:01'),
	(244,'2021-06-07 11:34:24',4,NULL,NULL,'2021-06-07 11:34:24','2021-06-07 11:34:24'),
	(254,'2021-06-07 12:34:28',NULL,NULL,24,'2021-06-07 12:34:28','2021-06-07 12:34:28'),
	(264,'2021-06-07 12:34:30',NULL,NULL,24,'2021-06-07 12:34:30','2021-06-07 12:34:30'),
	(274,'2021-06-07 12:36:02',NULL,NULL,24,'2021-06-07 12:36:02','2021-06-07 12:36:02'),
	(284,'2021-06-07 12:41:58',4,NULL,NULL,'2021-06-07 12:41:58','2021-06-07 12:41:58'),
	(294,'2021-06-07 20:13:02',NULL,4,NULL,'2021-06-07 20:13:02','2021-06-07 20:13:02'),
	(304,'2021-06-08 08:34:43',4,NULL,NULL,'2021-06-08 08:34:43','2021-06-08 08:34:43'),
	(314,'2021-06-08 21:51:54',4,NULL,NULL,'2021-06-08 21:51:54','2021-06-08 21:51:54'),
	(324,'2021-06-08 22:31:22',NULL,4,NULL,'2021-06-08 22:31:22','2021-06-08 22:31:22'),
	(334,'2021-06-09 07:20:42',4,NULL,NULL,'2021-06-09 07:20:42','2021-06-09 07:20:42'),
	(344,'2021-06-09 07:23:33',NULL,4,NULL,'2021-06-09 07:23:33','2021-06-09 07:23:33'),
	(354,'2021-06-09 08:09:28',NULL,NULL,24,'2021-06-09 08:09:28','2021-06-09 08:09:28'),
	(364,'2021-06-09 08:10:33',NULL,4,NULL,'2021-06-09 08:10:33','2021-06-09 08:10:33'),
	(374,'2021-06-09 15:23:05',NULL,4,NULL,'2021-06-09 15:23:05','2021-06-09 15:23:05'),
	(384,'2021-06-10 11:10:39',4,NULL,NULL,'2021-06-10 11:10:39','2021-06-10 11:10:39'),
	(394,'2021-06-10 11:14:09',NULL,4,NULL,'2021-06-10 11:14:09','2021-06-10 11:14:09'),
	(404,'2021-06-10 12:10:21',NULL,4,NULL,'2021-06-10 12:10:21','2021-06-10 12:10:21'),
	(414,'2021-06-10 12:12:06',4,NULL,NULL,'2021-06-10 12:12:06','2021-06-10 12:12:06'),
	(424,'2021-06-10 17:16:30',4,NULL,NULL,'2021-06-10 17:16:30','2021-06-10 17:16:30'),
	(434,'2021-06-10 17:17:43',NULL,4,NULL,'2021-06-10 17:17:43','2021-06-10 17:17:43'),
	(444,'2021-06-11 06:37:05',4,NULL,NULL,'2021-06-11 06:37:05','2021-06-11 06:37:05'),
	(454,'2021-06-11 06:46:00',NULL,4,NULL,'2021-06-11 06:46:00','2021-06-11 06:46:00'),
	(464,'2021-06-11 06:47:41',NULL,4,NULL,'2021-06-11 06:47:41','2021-06-11 06:47:41'),
	(474,'2021-06-11 10:28:55',4,NULL,NULL,'2021-06-11 10:28:55','2021-06-11 10:28:55'),
	(484,'2021-06-11 13:01:15',NULL,NULL,24,'2021-06-11 13:01:15','2021-06-11 13:01:15'),
	(494,'2021-06-11 13:14:49',NULL,NULL,24,'2021-06-11 13:14:49','2021-06-11 13:14:49'),
	(504,'2021-06-11 18:00:22',4,NULL,NULL,'2021-06-11 18:00:22','2021-06-11 18:00:22'),
	(514,'2021-06-11 20:05:26',NULL,4,NULL,'2021-06-11 20:05:26','2021-06-11 20:05:26'),
	(524,'2021-06-12 09:29:08',4,NULL,NULL,'2021-06-12 09:29:08','2021-06-12 09:29:08'),
	(534,'2021-06-12 12:42:25',NULL,4,NULL,'2021-06-12 12:42:25','2021-06-12 12:42:25'),
	(544,'2021-06-12 12:43:22',NULL,4,NULL,'2021-06-12 12:43:22','2021-06-12 12:43:22'),
	(554,'2021-06-12 14:41:23',4,NULL,NULL,'2021-06-12 14:41:23','2021-06-12 14:41:23'),
	(564,'2021-06-12 14:49:54',4,NULL,NULL,'2021-06-12 14:49:54','2021-06-12 14:49:54'),
	(574,'2021-06-13 20:23:07',4,NULL,NULL,'2021-06-13 20:23:07','2021-06-13 20:23:07'),
	(584,'2021-06-14 17:22:37',4,NULL,NULL,'2021-06-14 17:22:37','2021-06-14 17:22:37'),
	(594,'2021-06-15 07:03:14',NULL,4,NULL,'2021-06-15 07:03:14','2021-06-15 07:03:14'),
	(604,'2021-06-16 20:37:24',4,NULL,NULL,'2021-06-16 20:37:24','2021-06-16 20:37:24'),
	(614,'2021-06-17 12:43:43',4,NULL,NULL,'2021-06-17 12:43:43','2021-06-17 12:43:43'),
	(624,'2021-06-17 13:31:11',4,NULL,NULL,'2021-06-17 13:31:11','2021-06-17 13:31:11'),
	(634,'2021-06-20 20:51:28',NULL,24,NULL,'2021-06-20 20:51:28','2021-06-20 20:51:28'),
	(644,'2021-06-20 21:02:06',NULL,24,NULL,'2021-06-20 21:02:06','2021-06-20 21:02:06'),
	(654,'2021-06-20 21:03:14',NULL,24,NULL,'2021-06-20 21:03:14','2021-06-20 21:03:14'),
	(664,'2021-06-20 21:03:41',NULL,24,NULL,'2021-06-20 21:03:41','2021-06-20 21:03:41'),
	(674,'2021-06-21 11:12:56',4,NULL,NULL,'2021-06-21 11:12:56','2021-06-21 11:12:56'),
	(684,'2021-06-21 11:14:28',NULL,4,NULL,'2021-06-21 11:14:28','2021-06-21 11:14:28'),
	(694,'2021-06-21 11:19:21',NULL,NULL,44,'2021-06-21 11:19:21','2021-06-21 11:19:21'),
	(704,'2021-06-21 11:33:28',4,NULL,NULL,'2021-06-21 11:33:28','2021-06-21 11:33:28'),
	(714,'2021-06-22 00:06:54',4,NULL,NULL,'2021-06-22 00:06:54','2021-06-22 00:06:54'),
	(724,'2021-06-22 10:27:02',NULL,4,NULL,'2021-06-22 10:27:02','2021-06-22 10:27:02'),
	(734,'2021-06-22 10:43:53',4,NULL,NULL,'2021-06-22 10:43:53','2021-06-22 10:43:53'),
	(744,'2021-06-22 10:44:41',NULL,4,NULL,'2021-06-22 10:44:41','2021-06-22 10:44:41'),
	(754,'2021-06-22 17:50:50',NULL,NULL,24,'2021-06-22 17:50:50','2021-06-22 17:50:50'),
	(764,'2021-06-22 18:08:11',4,NULL,NULL,'2021-06-22 18:08:11','2021-06-22 18:08:11'),
	(774,'2021-06-23 06:08:47',4,NULL,NULL,'2021-06-23 06:08:47','2021-06-23 06:08:47'),
	(784,'2021-06-23 06:09:43',NULL,4,NULL,'2021-06-23 06:09:43','2021-06-23 06:09:43'),
	(794,'2021-06-23 19:28:59',4,NULL,NULL,'2021-06-23 19:28:59','2021-06-23 19:28:59'),
	(804,'2021-06-23 19:38:31',NULL,4,NULL,'2021-06-23 19:38:31','2021-06-23 19:38:31'),
	(814,'2021-06-24 10:56:05',4,NULL,NULL,'2021-06-24 10:56:05','2021-06-24 10:56:05'),
	(824,'2021-06-24 10:58:29',4,NULL,NULL,'2021-06-24 10:58:29','2021-06-24 10:58:29'),
	(834,'2021-06-24 11:11:58',NULL,44,NULL,'2021-06-24 11:11:58','2021-06-24 11:11:58'),
	(844,'2021-06-24 11:13:19',NULL,NULL,54,'2021-06-24 11:13:19','2021-06-24 11:13:19'),
	(854,'2021-06-24 16:09:45',NULL,NULL,54,'2021-06-24 16:09:45','2021-06-24 16:09:45'),
	(864,'2021-06-24 16:10:15',NULL,44,NULL,'2021-06-24 16:10:15','2021-06-24 16:10:15'),
	(874,'2021-06-24 18:47:56',NULL,NULL,54,'2021-06-24 18:47:56','2021-06-24 18:47:56'),
	(884,'2021-06-24 18:52:31',NULL,4,NULL,'2021-06-24 18:52:31','2021-06-24 18:52:31'),
	(894,'2021-06-24 19:40:30',4,NULL,NULL,'2021-06-24 19:40:30','2021-06-24 19:40:30'),
	(904,'2021-06-24 20:32:36',4,NULL,NULL,'2021-06-24 20:32:36','2021-06-24 20:32:36'),
	(914,'2021-06-25 09:51:56',NULL,4,NULL,'2021-06-25 09:51:56','2021-06-25 09:51:56'),
	(924,'2021-06-25 09:59:47',NULL,4,NULL,'2021-06-25 09:59:47','2021-06-25 09:59:47'),
	(934,'2021-06-25 10:07:31',NULL,44,NULL,'2021-06-25 10:07:31','2021-06-25 10:07:31'),
	(944,'2021-06-25 10:12:55',NULL,NULL,24,'2021-06-25 10:12:55','2021-06-25 10:12:55'),
	(954,'2021-06-25 11:07:05',NULL,4,NULL,'2021-06-25 11:07:05','2021-06-25 11:07:05'),
	(964,'2021-06-25 11:16:25',NULL,NULL,54,'2021-06-25 11:16:25','2021-06-25 11:16:25'),
	(974,'2021-06-25 11:17:28',4,NULL,NULL,'2021-06-25 11:17:28','2021-06-25 11:17:28'),
	(984,'2021-06-25 11:19:06',4,NULL,NULL,'2021-06-25 11:19:06','2021-06-25 11:19:06'),
	(994,'2021-06-25 11:40:03',4,NULL,NULL,'2021-06-25 11:40:03','2021-06-25 11:40:03'),
	(1004,'2021-06-25 12:24:13',NULL,4,NULL,'2021-06-25 12:24:13','2021-06-25 12:24:13'),
	(1014,'2021-06-25 13:18:15',4,NULL,NULL,'2021-06-25 13:18:15','2021-06-25 13:18:15'),
	(1024,'2021-06-28 00:16:09',NULL,4,NULL,'2021-06-28 00:16:09','2021-06-28 00:16:09'),
	(1034,'2021-06-28 00:19:53',4,NULL,NULL,'2021-06-28 00:19:53','2021-06-28 00:19:53'),
	(1044,'2021-06-28 08:26:22',4,NULL,NULL,'2021-06-28 08:26:22','2021-06-28 08:26:22'),
	(1054,'2021-06-28 08:38:48',NULL,4,NULL,'2021-06-28 08:38:48','2021-06-28 08:38:48'),
	(1064,'2021-06-28 21:09:12',4,NULL,NULL,'2021-06-28 21:09:12','2021-06-28 21:09:12'),
	(1074,'2021-06-29 07:07:55',4,NULL,NULL,'2021-06-29 07:07:55','2021-06-29 07:07:55'),
	(1084,'2021-06-29 11:00:16',4,NULL,NULL,'2021-06-29 11:00:16','2021-06-29 11:00:16'),
	(1094,'2021-06-29 11:05:18',4,NULL,NULL,'2021-06-29 11:05:18','2021-06-29 11:05:18'),
	(1104,'2021-06-29 11:07:44',NULL,4,NULL,'2021-06-29 11:07:44','2021-06-29 11:07:44'),
	(1114,'2021-06-29 12:14:07',NULL,NULL,54,'2021-06-29 12:14:07','2021-06-29 12:14:07'),
	(1124,'2021-06-29 12:17:57',4,NULL,NULL,'2021-06-29 12:17:57','2021-06-29 12:17:57'),
	(1134,'2021-06-29 12:34:43',NULL,NULL,24,'2021-06-29 12:34:43','2021-06-29 12:34:43'),
	(1144,'2021-06-29 19:42:49',4,NULL,NULL,'2021-06-29 19:42:49','2021-06-29 19:42:49'),
	(1154,'2021-06-30 00:26:59',4,NULL,NULL,'2021-06-30 00:26:59','2021-06-30 00:26:59'),
	(1164,'2021-06-30 08:18:56',4,NULL,NULL,'2021-06-30 08:18:56','2021-06-30 08:18:56'),
	(1174,'2021-06-30 10:58:46',4,NULL,NULL,'2021-06-30 10:58:46','2021-06-30 10:58:46'),
	(1184,'2021-06-30 16:34:20',4,NULL,NULL,'2021-06-30 16:34:20','2021-06-30 16:34:20'),
	(1194,'2021-06-30 17:01:49',NULL,NULL,54,'2021-06-30 17:01:49','2021-06-30 17:01:49'),
	(1204,'2021-06-30 21:23:49',NULL,NULL,24,'2021-06-30 21:23:49','2021-06-30 21:23:49'),
	(1214,'2021-06-30 21:35:17',NULL,4,NULL,'2021-06-30 21:35:17','2021-06-30 21:35:17'),
	(1224,'2021-06-30 21:38:59',NULL,NULL,24,'2021-06-30 21:38:59','2021-06-30 21:38:59'),
	(1234,'2021-07-01 05:59:48',4,NULL,NULL,'2021-07-01 05:59:48','2021-07-01 05:59:48'),
	(1244,'2021-07-01 06:05:10',NULL,4,NULL,'2021-07-01 06:05:10','2021-07-01 06:05:10'),
	(1254,'2021-07-01 09:32:09',4,NULL,NULL,'2021-07-01 09:32:09','2021-07-01 09:32:09'),
	(1264,'2021-07-01 09:35:50',NULL,4,NULL,'2021-07-01 09:35:50','2021-07-01 09:35:50'),
	(1274,'2021-07-01 09:36:40',NULL,4,NULL,'2021-07-01 09:36:40','2021-07-01 09:36:40'),
	(1284,'2021-07-01 09:36:50',NULL,44,NULL,'2021-07-01 09:36:50','2021-07-01 09:36:50'),
	(1294,'2021-07-01 09:37:49',NULL,4,NULL,'2021-07-01 09:37:49','2021-07-01 09:37:49'),
	(1304,'2021-07-01 09:38:05',4,NULL,NULL,'2021-07-01 09:38:05','2021-07-01 09:38:05'),
	(1314,'2021-07-01 09:38:18',NULL,NULL,24,'2021-07-01 09:38:18','2021-07-01 09:38:18'),
	(1324,'2021-07-01 10:03:35',NULL,4,NULL,'2021-07-01 10:03:35','2021-07-01 10:03:35'),
	(1334,'2021-07-01 10:06:44',NULL,44,NULL,'2021-07-01 10:06:44','2021-07-01 10:06:44'),
	(1344,'2021-07-01 21:49:08',4,NULL,NULL,'2021-07-01 21:49:08','2021-07-01 21:49:08'),
	(1354,'2021-07-01 21:51:31',NULL,44,NULL,'2021-07-01 21:51:31','2021-07-01 21:51:31'),
	(1364,'2021-07-02 08:49:14',4,NULL,NULL,'2021-07-02 08:49:14','2021-07-02 08:49:14'),
	(1374,'2021-07-02 08:51:25',NULL,44,NULL,'2021-07-02 08:51:25','2021-07-02 08:51:25'),
	(1384,'2021-07-02 12:12:18',NULL,NULL,54,'2021-07-02 12:12:18','2021-07-02 12:12:18'),
	(1394,'2021-07-02 21:19:10',NULL,4,NULL,'2021-07-02 21:19:10','2021-07-02 21:19:10'),
	(1404,'2021-07-03 20:23:38',4,NULL,NULL,'2021-07-03 20:23:38','2021-07-03 20:23:38'),
	(1414,'2021-07-03 20:27:25',NULL,NULL,54,'2021-07-03 20:27:25','2021-07-03 20:27:25'),
	(1424,'2021-07-03 20:29:48',NULL,44,NULL,'2021-07-03 20:29:48','2021-07-03 20:29:48'),
	(1434,'2021-07-04 19:49:08',NULL,NULL,54,'2021-07-04 19:49:08','2021-07-04 19:49:08'),
	(1444,'2021-07-05 09:25:32',NULL,NULL,54,'2021-07-05 09:25:32','2021-07-05 09:25:32'),
	(1454,'2021-07-05 09:48:15',NULL,NULL,54,'2021-07-05 09:48:15','2021-07-05 09:48:15'),
	(1464,'2021-07-05 09:48:40',NULL,4,NULL,'2021-07-05 09:48:40','2021-07-05 09:48:40'),
	(1474,'2021-07-05 09:56:55',NULL,NULL,54,'2021-07-05 09:56:55','2021-07-05 09:56:55'),
	(1484,'2021-07-05 10:01:26',NULL,NULL,54,'2021-07-05 10:01:26','2021-07-05 10:01:26'),
	(1494,'2021-07-05 10:57:17',NULL,44,NULL,'2021-07-05 10:57:17','2021-07-05 10:57:17'),
	(1504,'2021-07-05 13:17:31',NULL,4,NULL,'2021-07-05 13:17:31','2021-07-05 13:17:31'),
	(1514,'2021-07-05 13:21:22',NULL,44,NULL,'2021-07-05 13:21:22','2021-07-05 13:21:22'),
	(1524,'2021-07-05 15:14:30',NULL,NULL,54,'2021-07-05 15:14:30','2021-07-05 15:14:30'),
	(1534,'2021-07-05 15:18:42',NULL,4,NULL,'2021-07-05 15:18:42','2021-07-05 15:18:42'),
	(1544,'2021-07-05 15:34:36',NULL,44,NULL,'2021-07-05 15:34:36','2021-07-05 15:34:36'),
	(1554,'2021-07-06 08:36:00',NULL,44,NULL,'2021-07-06 08:36:00','2021-07-06 08:36:00'),
	(1564,'2021-07-06 10:36:29',4,NULL,NULL,'2021-07-06 10:36:29','2021-07-06 10:36:29'),
	(1574,'2021-07-06 10:55:40',NULL,NULL,54,'2021-07-06 10:55:40','2021-07-06 10:55:40'),
	(1584,'2021-07-07 10:03:14',4,NULL,NULL,'2021-07-07 10:03:14','2021-07-07 10:03:14'),
	(1594,'2021-07-07 10:29:43',4,NULL,NULL,'2021-07-07 10:29:43','2021-07-07 10:29:43'),
	(1604,'2021-07-07 10:31:26',NULL,4,NULL,'2021-07-07 10:31:26','2021-07-07 10:31:26'),
	(1614,'2021-07-07 10:38:36',NULL,NULL,54,'2021-07-07 10:38:36','2021-07-07 10:38:36'),
	(1624,'2021-07-07 10:46:13',NULL,44,NULL,'2021-07-07 10:46:13','2021-07-07 10:46:13'),
	(1634,'2021-07-07 11:40:09',NULL,4,NULL,'2021-07-07 11:40:09','2021-07-07 11:40:09'),
	(1644,'2021-07-07 11:42:49',NULL,4,NULL,'2021-07-07 11:42:49','2021-07-07 11:42:49'),
	(1654,'2021-07-07 11:43:39',NULL,NULL,24,'2021-07-07 11:43:39','2021-07-07 11:43:39'),
	(1664,'2021-07-07 12:18:30',NULL,4,NULL,'2021-07-07 12:18:30','2021-07-07 12:18:30'),
	(1674,'2021-07-07 12:34:51',4,NULL,NULL,'2021-07-07 12:34:51','2021-07-07 12:34:51'),
	(1684,'2021-07-07 12:37:21',4,NULL,NULL,'2021-07-07 12:37:21','2021-07-07 12:37:21'),
	(1694,'2021-07-07 16:34:51',NULL,4,NULL,'2021-07-07 16:34:51','2021-07-07 16:34:51'),
	(1704,'2021-07-07 16:52:32',4,NULL,NULL,'2021-07-07 16:52:32','2021-07-07 16:52:32'),
	(1714,'2021-07-07 16:54:22',NULL,4,NULL,'2021-07-07 16:54:22','2021-07-07 16:54:22'),
	(1724,'2021-07-07 16:55:42',4,NULL,NULL,'2021-07-07 16:55:42','2021-07-07 16:55:42'),
	(1734,'2021-07-07 19:27:19',4,NULL,NULL,'2021-07-07 19:27:19','2021-07-07 19:27:19'),
	(1744,'2021-07-07 19:28:27',NULL,4,NULL,'2021-07-07 19:28:27','2021-07-07 19:28:27'),
	(1754,'2021-07-07 19:30:30',NULL,44,NULL,'2021-07-07 19:30:30','2021-07-07 19:30:30'),
	(1764,'2021-07-07 21:15:44',NULL,4,NULL,'2021-07-07 21:15:44','2021-07-07 21:15:44'),
	(1774,'2021-07-08 01:56:45',4,NULL,NULL,'2021-07-08 01:56:45','2021-07-08 01:56:45'),
	(1784,'2021-07-08 09:19:19',4,NULL,NULL,'2021-07-08 09:19:19','2021-07-08 09:19:19'),
	(1794,'2021-07-08 11:07:27',NULL,4,NULL,'2021-07-08 11:07:27','2021-07-08 11:07:27'),
	(1804,'2021-07-08 11:15:27',4,NULL,NULL,'2021-07-08 11:15:27','2021-07-08 11:15:27'),
	(1814,'2021-07-08 11:41:22',4,NULL,NULL,'2021-07-08 11:41:22','2021-07-08 11:41:22'),
	(1824,'2021-07-08 12:01:55',44,NULL,NULL,'2021-07-08 12:01:55','2021-07-08 12:01:55'),
	(1834,'2021-07-08 16:16:41',4,NULL,NULL,'2021-07-08 16:16:41','2021-07-08 16:16:41'),
	(1844,'2021-07-08 16:25:55',NULL,4,NULL,'2021-07-08 16:25:55','2021-07-08 16:25:55'),
	(1854,'2021-07-08 16:35:56',NULL,44,NULL,'2021-07-08 16:35:56','2021-07-08 16:35:56'),
	(1864,'2021-07-09 10:38:35',4,NULL,NULL,'2021-07-09 10:38:35','2021-07-09 10:38:35'),
	(1874,'2021-07-09 11:07:31',NULL,4,NULL,'2021-07-09 11:07:31','2021-07-09 11:07:31'),
	(1884,'2021-07-09 22:59:22',4,NULL,NULL,'2021-07-09 22:59:22','2021-07-09 22:59:22'),
	(1894,'2021-07-09 22:59:45',NULL,4,NULL,'2021-07-09 22:59:45','2021-07-09 22:59:45'),
	(1904,'2021-07-11 14:50:34',NULL,4,NULL,'2021-07-11 14:50:34','2021-07-11 14:50:34'),
	(1914,'2021-07-11 15:21:09',4,NULL,NULL,'2021-07-11 15:21:09','2021-07-11 15:21:09'),
	(1924,'2021-07-11 15:22:20',4,NULL,NULL,'2021-07-11 15:22:20','2021-07-11 15:22:20'),
	(1934,'2021-07-11 20:45:23',4,NULL,NULL,'2021-07-11 20:45:23','2021-07-11 20:45:23'),
	(1944,'2021-07-11 21:21:25',4,NULL,NULL,'2021-07-11 21:21:25','2021-07-11 21:21:25'),
	(1954,'2021-07-11 22:47:17',NULL,44,NULL,'2021-07-11 22:47:17','2021-07-11 22:47:17'),
	(1964,'2021-07-12 06:45:59',NULL,44,NULL,'2021-07-12 06:45:59','2021-07-12 06:45:59'),
	(1974,'2021-07-12 13:51:18',4,NULL,NULL,'2021-07-12 13:51:18','2021-07-12 13:51:18'),
	(1984,'2021-07-12 15:01:08',NULL,24,NULL,'2021-07-12 15:01:08','2021-07-12 15:01:08'),
	(1994,'2021-07-12 15:02:52',NULL,24,NULL,'2021-07-12 15:02:52','2021-07-12 15:02:52'),
	(2004,'2021-07-12 22:17:41',14,NULL,NULL,'2021-07-12 22:17:41','2021-07-12 22:17:41'),
	(2014,'2021-07-12 22:19:06',14,NULL,NULL,'2021-07-12 22:19:06','2021-07-12 22:19:06'),
	(2024,'2021-07-13 11:09:08',14,NULL,NULL,'2021-07-13 11:09:08','2021-07-13 11:09:08'),
	(2034,'2021-07-13 11:21:12',4,NULL,NULL,'2021-07-13 11:21:12','2021-07-13 11:21:12'),
	(2044,'2021-07-14 22:38:33',4,NULL,NULL,'2021-07-14 22:38:33','2021-07-14 22:38:33'),
	(2054,'2021-07-14 23:10:28',14,NULL,NULL,'2021-07-14 23:10:28','2021-07-14 23:10:28'),
	(2064,'2021-07-15 08:11:24',NULL,NULL,54,'2021-07-15 08:11:24','2021-07-15 08:11:24'),
	(2074,'2021-07-15 08:15:03',NULL,4,NULL,'2021-07-15 08:15:03','2021-07-15 08:15:03'),
	(2084,'2021-07-15 13:17:04',NULL,44,NULL,'2021-07-15 13:17:04','2021-07-15 13:17:04'),
	(2094,'2021-07-16 11:36:58',4,NULL,NULL,'2021-07-16 11:36:58','2021-07-16 11:36:58'),
	(2104,'2021-07-18 00:13:06',14,NULL,NULL,'2021-07-18 00:13:06','2021-07-18 00:13:06'),
	(2114,'2021-07-18 00:23:43',4,NULL,NULL,'2021-07-18 00:23:43','2021-07-18 00:23:43'),
	(2124,'2021-07-18 11:30:58',NULL,4,NULL,'2021-07-18 11:30:58','2021-07-18 11:30:58'),
	(2134,'2021-07-18 13:06:36',4,NULL,NULL,'2021-07-18 13:06:36','2021-07-18 13:06:36'),
	(2144,'2021-07-18 16:45:03',4,NULL,NULL,'2021-07-18 16:45:03','2021-07-18 16:45:03'),
	(2154,'2021-07-18 16:48:42',NULL,44,NULL,'2021-07-18 16:48:42','2021-07-18 16:48:42'),
	(2164,'2021-07-18 18:17:09',NULL,4,NULL,'2021-07-18 18:17:09','2021-07-18 18:17:09'),
	(2174,'2021-07-18 18:19:01',NULL,4,NULL,'2021-07-18 18:19:01','2021-07-18 18:19:01'),
	(2184,'2021-07-19 01:46:53',14,NULL,NULL,'2021-07-19 01:46:53','2021-07-19 01:46:53'),
	(2194,'2021-07-19 01:47:45',14,NULL,NULL,'2021-07-19 01:47:45','2021-07-19 01:47:45'),
	(2204,'2021-07-19 01:47:58',4,NULL,NULL,'2021-07-19 01:47:58','2021-07-19 01:47:58'),
	(2214,'2021-07-19 07:48:32',NULL,44,NULL,'2021-07-19 07:48:32','2021-07-19 07:48:32'),
	(2224,'2021-07-19 07:56:14',NULL,4,NULL,'2021-07-19 07:56:14','2021-07-19 07:56:14'),
	(2234,'2021-07-19 09:52:45',4,NULL,NULL,'2021-07-19 09:52:45','2021-07-19 09:52:45'),
	(2244,'2021-07-19 16:05:16',4,NULL,NULL,'2021-07-19 16:05:16','2021-07-19 16:05:16'),
	(2254,'2021-07-19 16:13:24',NULL,4,NULL,'2021-07-19 16:13:24','2021-07-19 16:13:24'),
	(2264,'2021-07-19 17:17:17',NULL,4,NULL,'2021-07-19 17:17:17','2021-07-19 17:17:17'),
	(2274,'2021-07-19 17:17:24',NULL,4,NULL,'2021-07-19 17:17:24','2021-07-19 17:17:24'),
	(2284,'2021-07-19 17:44:02',4,NULL,NULL,'2021-07-19 17:44:02','2021-07-19 17:44:02'),
	(2294,'2021-07-19 17:45:36',4,NULL,NULL,'2021-07-19 17:45:36','2021-07-19 17:45:36'),
	(2304,'2021-07-20 05:50:02',4,NULL,NULL,'2021-07-20 05:50:02','2021-07-20 05:50:02'),
	(2314,'2021-07-20 12:19:04',NULL,4,NULL,'2021-07-20 12:19:04','2021-07-20 12:19:04'),
	(2324,'2021-07-20 12:57:52',NULL,4,NULL,'2021-07-20 12:57:52','2021-07-20 12:57:52'),
	(2334,'2021-07-21 00:11:15',4,NULL,NULL,'2021-07-21 00:11:15','2021-07-21 00:11:15'),
	(2344,'2021-07-21 00:17:13',NULL,4,NULL,'2021-07-21 00:17:13','2021-07-21 00:17:13'),
	(2354,'2021-07-21 17:28:57',NULL,44,NULL,'2021-07-21 17:28:57','2021-07-21 17:28:57'),
	(2364,'2021-07-23 11:30:19',NULL,4,NULL,'2021-07-23 11:30:19','2021-07-23 11:30:19'),
	(2374,'2021-07-23 12:32:35',NULL,44,NULL,'2021-07-23 12:32:35','2021-07-23 12:32:35'),
	(2384,'2021-07-23 14:07:57',NULL,4,NULL,'2021-07-23 14:07:57','2021-07-23 14:07:57'),
	(2394,'2021-07-23 14:13:34',NULL,44,NULL,'2021-07-23 14:13:34','2021-07-23 14:13:34'),
	(2404,'2021-07-23 14:18:57',NULL,44,NULL,'2021-07-23 14:18:57','2021-07-23 14:18:57'),
	(2414,'2021-07-23 15:52:35',NULL,44,NULL,'2021-07-23 15:52:35','2021-07-23 15:52:35'),
	(2424,'2021-07-23 21:22:01',NULL,44,NULL,'2021-07-23 21:22:01','2021-07-23 21:22:01'),
	(2434,'2021-07-23 21:27:03',4,NULL,NULL,'2021-07-23 21:27:03','2021-07-23 21:27:03'),
	(2444,'2021-07-24 23:13:12',4,NULL,NULL,'2021-07-24 23:13:12','2021-07-24 23:13:12'),
	(2454,'2021-07-24 23:16:04',4,NULL,NULL,'2021-07-24 23:16:04','2021-07-24 23:16:04'),
	(2464,'2021-07-25 12:37:31',NULL,NULL,64,'2021-07-25 12:37:31','2021-07-25 12:37:31'),
	(2474,'2021-07-25 19:51:19',NULL,54,NULL,'2021-07-25 19:51:19','2021-07-25 19:51:19'),
	(2484,'2021-07-25 22:00:39',54,NULL,NULL,'2021-07-25 22:00:39','2021-07-25 22:00:39'),
	(2494,'2021-07-26 09:23:34',NULL,44,NULL,'2021-07-26 09:23:34','2021-07-26 09:23:34'),
	(2504,'2021-07-26 09:29:33',NULL,44,NULL,'2021-07-26 09:29:33','2021-07-26 09:29:33');

/*!40000 ALTER TABLE `login_histories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=984 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(4,'2014_10_12_000000_create_users_table',1),
	(14,'2014_10_12_100000_create_password_resets_table',1),
	(24,'2016_06_01_000001_create_oauth_auth_codes_table',1),
	(34,'2016_06_01_000002_create_oauth_access_tokens_table',1),
	(44,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),
	(54,'2016_06_01_000004_create_oauth_clients_table',1),
	(64,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),
	(74,'2019_08_19_000000_create_failed_jobs_table',1),
	(84,'2021_04_07_163425_create_organizations_table',1),
	(94,'2021_04_07_163427_create_admins_table',1),
	(104,'2021_05_01_134246_create_facilitators_table',1),
	(114,'2021_05_01_193748_add_phone_bio_profile_organization_id_verfication_address_to_users_table',1),
	(124,'2021_05_03_082720_create_events_table',1),
	(134,'2021_05_06_094837_create_todos_table',1),
	(144,'2021_05_08_235549_create_courses_table',1),
	(154,'2021_05_12_102714_create_discussions_table',1),
	(164,'2021_05_15_145951_create_discussion_views_table',1),
	(174,'2021_05_15_145955_create_discussion_messages_table',1),
	(184,'2021_05_15_150007_create_discussion_votes_table',1),
	(194,'2021_05_15_233629_create_tags_table',1),
	(204,'2021_05_16_202323_create_feeds_table',1),
	(214,'2021_05_16_230411_create_feed_comments_table',1),
	(224,'2021_05_16_230439_create_feed_likes_table',1),
	(234,'2021_05_16_230450_create_feed_stars_table',1),
	(244,'2021_05_17_084030_create_inboxes_table',1),
	(254,'2021_05_17_085759_create_login_history_table',1),
	(264,'2021_05_17_235551_create_course_outlines_table',1),
	(274,'2021_05_18_000115_create_course_schedules_table',1),
	(284,'2021_05_18_000214_create_course_facilitators_table',1),
	(294,'2021_05_18_095334_create_curriculums_table',1),
	(304,'2021_05_19_092807_create_feedbacks_table',1),
	(314,'2021_05_19_113902_add_status_start_end_to_events_table',1),
	(324,'2021_05_20_130524_create_notifications_table',1),
	(334,'2021_05_21_223932_create_connections_table',1),
	(344,'2021_05_22_090953_create_modules_table',1),
	(354,'2021_05_24_132426_create_library_table',1),
	(364,'2021_05_24_141943_add_url_status_to_course_schedules_table',1),
	(374,'2021_05_26_044627_create_questionnaire_table',1),
	(384,'2021_05_26_123159_add_admin_id_to_modules_table',1),
	(394,'2021_05_31_191022_create_answered_questionnaire_table',1),
	(404,'2021_06_01_153652_add_interests_to_users_table',1),
	(414,'2021_06_01_153715_add_interests_to_facilitators_table',1),
	(424,'2021_06_02_195602_add_venue_to_course_schedules_table',1),
	(434,'2021_06_02_235923_add_venue_to_events_table',1),
	(444,'2021_06_03_032819_create_referrals_table',1),
	(454,'2021_06_03_033509_add_gender_state_country_age_lga_to_facilitators_table',1),
	(464,'2021_06_03_033521_add_gender_state_country_age_lga_to_users_table',1),
	(474,'2021_06_05_163804_create_discussion_requests_table',2),
	(484,'2021_06_05_203942_add_type_amount_to_courses_table',2),
	(494,'2021_06_05_204728_create_course_community_links_table',2),
	(504,'2021_06_05_204749_create_course_communities_table',2),
	(514,'2021_06_06_005445_add_course_id_to_course_communities_table',3),
	(524,'2021_06_07_213638_add_progress_to_libraries_table',4),
	(534,'2021_06_09_002615_add_facilitator_id_to_course_communities_table',5),
	(544,'2021_06_09_010037_create_reviews_table',5),
	(554,'2021_06_09_011035_create_enroll_counts_table',5),
	(564,'2021_06_10_154928_create_contributors_table',6),
	(574,'2021_06_11_115544_create_question_templates_table',7),
	(584,'2021_06_11_153811_add_type_to_questionnaires_table',8),
	(594,'2021_06_12_122624_add_url_to_feeds_table',9),
	(604,'2021_06_18_151214_create_private_discusions_members_table',10),
	(614,'2021_06_18_185847_add_response_to_discussion_requests_table',10),
	(624,'2021_06_21_070245_create_question_drafts_table',11),
	(634,'2021_06_21_073608_add_to_question_templates_table',11),
	(644,'2021_06_22_151539_create_linked_social_accounts_table',11),
	(654,'2021_06_23_135423_create_question_responses_table',12),
	(664,'2021_06_24_002425_create_assessments_table',12),
	(674,'2021_06_24_021514_create_assessment_responses_table',13),
	(684,'2021_06_24_021543_create_learner_assessments_table',13),
	(694,'2021_06_24_110355_add_course_id_to_assessments_table',13),
	(704,'2021_06_24_112959_add_assessment_id_to_libraries_table',13),
	(714,'2021_06_24_182011_add_totalscore_to_question_templates_table',13),
	(724,'2021_06_24_183426_add_question_template_id_to_answer_questionnaire_table',13),
	(734,'2021_06_24_221514_create_orders_table',13),
	(744,'2021_06_25_181323_add_status_to_answered_questionnaire_table',14),
	(754,'2021_06_27_231758_create_course_view_counts_table',14),
	(764,'2021_06_30_092846_create_facilitator_modules_table',15),
	(774,'2021_06_30_201441_add_modules_add_to_course_schedules_table',16),
	(784,'2021_07_01_122430_add_organization_id_to_orders_table',17),
	(794,'2021_07_01_122430_create_revenues_table',17),
	(804,'2021_07_01_140333_create_highest_earning_courses_table',17),
	(814,'2021_07_01_180706_add_facilitator_role_to_facilitators_table',17),
	(824,'2021_07_02_001611_create_event_attendance_table',18),
	(834,'2021_07_06_132419_add_options_to_question_templates_table',19),
	(844,'2021_07_09_123739_add_tags_to_feeds_table',20),
	(864,'2021_07_17_224338_add_voice_to_user_table',21),
	(874,'2021_07_17_224358_add_voice_to_facilitator_table',21),
	(884,'2021_07_20_204301_add_public_id_to_feeds_table',21),
	(894,'2021_07_20_204315_add_public_id_to_inboxes_table',21),
	(904,'2021_07_20_204346_add_public_id_to_courses_table',21),
	(914,'2021_07_20_204359_add_public_id_to_users_table',21),
	(924,'2021_07_20_204412_add_public_id_to_facilitators_table',21),
	(934,'2021_07_20_204426_add_public_id_to_admins_table',21),
	(944,'2021_07_20_204441_add_public_id_to_organizations_table',21),
	(954,'2021_07_20_204502_add_public_id_to_events_table',21),
	(964,'2021_07_20_204838_add_public_id_to_discussion_messages_table',21),
	(974,'2021_07_22_181134_create_discussion_message_comments_table',22);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table modules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modules` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modules_course_id_foreign` (`course_id`),
  KEY `modules_facilitator_id_foreign` (`facilitator_id`),
  KEY `modules_organization_id_foreign` (`organization_id`),
  KEY `modules_admin_id_foreign` (`admin_id`),
  CONSTRAINT `modules_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `modules_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `modules_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `modules_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;

INSERT INTO `modules` (`id`, `module`, `modules`, `course_id`, `facilitator_id`, `organization_id`, `created_at`, `updated_at`, `admin_id`)
VALUES
	(4,'Ovevriew','[{\"title\":\"Test\",\"overview\":\"Overview\",\"file_type\":\"video\",\"file\":\"https:\\/\\/res.cloudinary.com\\/bizguruh-com\\/video\\/upload\\/v1622827730\\/BizGuruh_USSD_Accounting_Demo.MOV_njlaws.mp4\"}]',4,4,14,'2021-06-04 17:29:16','2021-06-04 17:29:16',NULL),
	(14,'Introduction','[{\"title\":\"Introduction to crypto\",\"overview\":\"facilitator - A brief story on the earlier years of crypto currnecy\",\"file_type\":\"video\",\"file\":\"https:\\/\\/res.cloudinary.com\\/bizguruh-com\\/video\\/upload\\/v1623464169\\/Overview_rapepo.mp4\"},{\"template\":[],\"type\":null,\"course_id\":null,\"module\":null,\"modules\":[{\"title\":null,\"overview\":null,\"file_type\":\"video\",\"file\":null}],\"cover_image\":null,\"questionnaires\":[],\"title\":\"History\",\"overview\":\"Brief History\",\"file_type\":\"document\",\"file\":\"https:\\/\\/res.cloudinary.com\\/bizguruh-com\\/image\\/upload\\/v1623464200\\/Success_Ahon_-_Full_Stack_Web_Developer_hiqhgh.pdf\"}]',4,4,14,'2021-06-12 02:16:49','2021-06-12 02:16:49',NULL),
	(24,'Cryptomania','[{\"title\":\"Test\",\"overview\":\"This is a test\",\"file_type\":\"template\",\"file\":null,\"template\":{\"id\":34,\"sections\":\"[{\\\"title\\\":\\\"Section oNE\\\",\\\"description\\\":null,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"question\\\":\\\"hOW ARE O?\\\",\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":1,\\\"options\\\":[{\\\"title\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[{\\\"title\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"asScore\\\":false,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Test\",\"organization_id\":14,\"created_at\":\"2021-06-22T18:01:47.000000Z\",\"updated_at\":\"2021-06-22T18:01:47.000000Z\",\"type\":\"quiz\",\"status\":\"active\",\"user_id\":null,\"admin_id\":24,\"facilitator_id\":null},\"templates\":[],\"type\":\"quiz\"}]',4,NULL,14,'2021-06-22 18:07:28','2021-06-22 18:07:28',24),
	(34,'Information','[{\"title\":\"Information\",\"overview\":\"You will be needed to provide a detailed information about you\",\"file_type\":\"template\",\"file\":null,\"template\":{\"id\":44,\"sections\":\"[{\\\"title\\\":\\\"Section\\\",\\\"description\\\":\\\"<p>This is my description<\\\\\\/p>\\\",\\\"questions\\\":[{\\\"fixed\\\":false,\\\"question\\\":\\\"How are you?\\\",\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":1,\\\"options\\\":[{\\\"title\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[{\\\"title\\\":null}],\\\"placeholder\\\":\\\"Provide your name\\\",\\\"hint\\\":\\\"Give your full name\\\",\\\"asScore\\\":false,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Pure Chemistry\",\"organization_id\":14,\"created_at\":\"2021-06-25T10:10:24.000000Z\",\"updated_at\":\"2021-06-25T10:10:24.000000Z\",\"type\":\"questionnaire\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":4,\"totalscore\":null},\"templates\":[],\"type\":\"questionnaire\"}]',4,4,14,'2021-06-25 11:38:59','2021-06-25 11:38:59',NULL),
	(54,'Epilogue','[{\"title\":\"Epilogue\",\"overview\":\"Ovevriew\",\"file_type\":\"template\",\"file\":null,\"template\":{\"id\":45,\"sections\":\"[{\\\"title\\\":\\\"Section\\\",\\\"description\\\":\\\"<p>This is my description<\\\\\\/p>\\\",\\\"questions\\\":[{\\\"fixed\\\":false,\\\"question\\\":\\\"How are you?\\\",\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":1,\\\"options\\\":[{\\\"title\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[{\\\"title\\\":null}],\\\"placeholder\\\":\\\"Provide your name\\\",\\\"hint\\\":\\\"Give your full name\\\",\\\"asScore\\\":false,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Pure Chemistry\",\"organization_id\":14,\"created_at\":\"2021-06-25T10:10:24.000000Z\",\"updated_at\":\"2021-06-25T10:10:24.000000Z\",\"type\":\"questionnaire\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":4,\"totalscore\":null},\"templates\":[],\"type\":\"questionnaire\"}]',4,4,14,'2021-06-25 12:28:13','2021-06-25 12:28:13',NULL),
	(74,'Getting to know me','[{\"show\":true,\"title\":\"Getting to know me\",\"overview\":\"Sometimes all a business really needs to be successful is alignment with your inner man.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":224,\"sections\":\"[{\\\"title\\\":\\\"Getting to know me\\\",\\\"description\\\":\\\"<p class=\\\\\\\"p1\\\\\\\" style=\\\\\\\"text-align: center;\\\\\\\">\\\\\\\"Instead of just coasting through life and being reactive to the behaviors and opinions of others,<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\" style=\\\\\\\"text-align: center;\\\\\\\">I will get to know myself.\\\\\\\"<\\\\\\/p>\\\",\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"These 3 words describe me perfectly\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Others would use these 5 words to describe me:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"People often come to me to solve this kind of problem:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"I am mostly inspired by:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"The most unique thing about me, is:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Given the chance, I would take these two superpowers?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"I want others to think this about me:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"I value these five (5) things most:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null},{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"In other words, what matters to you most? Values play the biggest role in motivating our choices at work, at home, and in everyday life. Your values can be a combination of moral commitments such as honesty, compassion, integrity etc. or where you find the most joy in life, such as learning, fun, or having diverse experiences.\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"I believe my purpose is to:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Think of your purpose as being defined by what makes you feel authentic, excited and passionate. Meanwhile, give some thought to how this purpose might help others, even on a small scale.\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"These are my top goals in the following areas:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Spirituality\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Family Life\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Wellness\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Love\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Business\\\\\\/Career\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Financial\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Social\\\",\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"One for each category\\\",\\\"score\\\":0}]},{\\\"title\\\":\\\"Reflection\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Write an honest letter to your future self, highlighting your strengths and weaknesses. The idea it to demonstrate self-awareness.\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Getting to know me\",\"organization_id\":74,\"created_at\":\"2021-07-12T07:02:00.000000Z\",\"updated_at\":\"2021-07-18T18:09:03.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":null}]',144,44,74,'2021-07-18 18:25:32','2021-07-18 18:25:32',NULL),
	(84,'The people in my life','[{\"show\":true,\"title\":\"The people in my life\",\"overview\":\"Surround yourself with people who have already been where you want to go or working towards there.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":244,\"sections\":\"[{\\\"title\\\":\\\"The people in my life\\\",\\\"description\\\":\\\"<p class=\\\\\\\"p1\\\\\\\" style=\\\\\\\"text-align: center;\\\\\\\"><em>&ldquo;Keep company with people who uplift you, whose presence call forth your best.&rdquo;<\\\\\\/em><\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\" style=\\\\\\\"text-align: center;\\\\\\\">Epictetus<\\\\\\/p>\\\",\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"The people in my inner circle:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Spirituality\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Family Life\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Wellness\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Love\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Business\\\\\\/Career\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Financial\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Social\\\",\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"One for each category\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"These people hold me most accountable:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Spirituality\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Family Life\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Wellness\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Love\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Business\\\\\\/Career\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Financial\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Social\\\",\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"One for each category\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"These people inspire me most:\\\",\\\"addSubQuestion\\\":true,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":\\\"Spirituality\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"Family Life\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"Wellness\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"Love\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"Business\\\\\\/Career\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"Financial\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"Social\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Name\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Trait I admire\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"How I can apply it in my life\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"Reflection\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Write an honest letter to yourself, highlighting the people have had the most influence in your life; positive or negative. Understand that nobody has the power to make you a specific way and acknowledge the role you played in getting here.\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"The people in my life\",\"organization_id\":74,\"created_at\":\"2021-07-13T20:16:45.000000Z\",\"updated_at\":\"2021-07-18T18:18:13.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":null}]',144,44,74,'2021-07-18 18:33:01','2021-07-18 18:33:01',NULL),
	(94,'The road ahead','[{\"show\":true,\"title\":\"The road ahead\",\"overview\":\"The mission in life should be not only to survive, but to thrive, and to do so with some passion, compassion, humor and style.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":254,\"sections\":\"[{\\\"title\\\":\\\"The Road Ahead\\\",\\\"description\\\":\\\"<p><em>\\\\\\\"Direction is so much more important than speed; many are going nowhere, fast!\\\\\\\"<\\\\\\/em><\\\\\\/p>\\\",\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"I see myself here:\\\",\\\"addSubQuestion\\\":true,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":\\\"In 2 years:\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Spirituality\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Family Life\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Wellness\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Love\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Business\\\\\\/Career\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Financial\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Social\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"In 5 years:\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Spirituality\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Family Life\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Wellness\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Love\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Business\\\\\\/Career\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Financial\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Social\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"In 10 years\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Spirituality\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Family Life\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Wellness\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Love\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Business\\\\\\/Career\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Financial\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Social\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"Reflection\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Write a letter from your future self highlighting your achievements and how you feel about the life you have.\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"The Road Ahead\",\"organization_id\":74,\"created_at\":\"2021-07-13T20:23:56.000000Z\",\"updated_at\":\"2021-07-18T18:38:54.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":null}]',144,44,74,'2021-07-18 18:40:40','2021-07-18 18:40:40',NULL),
	(104,'Self-reflection','[{\"show\":true,\"title\":\"Self-reflection\",\"overview\":\"Find out how bad you want success and what you are willing to give up for it.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":274,\"sections\":\"[{\\\"title\\\":\\\"Reflection\\\",\\\"description\\\":\\\"<p>Time spent on self-reflection is never wasted, it is an intimate date with yourself.<\\\\\\/p>\\\",\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"What could be the impact of starting or growing my business in these areas of my life and how can I mitigate it?\\\",\\\"addSubQuestion\\\":true,\\\"subQuestion\\\":[{\\\"show\\\":false,\\\"question\\\":\\\"My Spirituality:\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Impact\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Mitigation\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"My Family Life:\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Impact\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Mitigation\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"My Love Life\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Impact\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Mitigation\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"My Social Life\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Impact\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Mitigation\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":false,\\\"question\\\":\\\"My Wellness\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Impact\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Mitigation\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"My Finances\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Impact\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Mitigation\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"Reflection\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Write a letter to yourself summarizing the trade-offs for your success. How bad do you want it and what are you willing to give up to get there?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Self-reflection\",\"organization_id\":74,\"created_at\":\"2021-07-15T07:35:27.000000Z\",\"updated_at\":\"2021-07-18T18:49:58.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":null}]',144,44,74,'2021-07-18 18:52:04','2021-07-18 18:52:04',NULL),
	(114,'Affirmation','[{\"show\":true,\"title\":\"Self-affirmation\",\"overview\":\"Note to self: I am going to make you so proud\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":264,\"sections\":\"[{\\\"title\\\":\\\"Self-affirmation\\\",\\\"description\\\":\\\"<p><span class=\\\\\\\"text-dark-green fs12\\\\\\\">When the vision is clear, the results will appear.<\\\\\\/span><\\\\\\/p>\\\",\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Write a letter to your future self (10 Years from now).\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Self-affirmation\",\"organization_id\":74,\"created_at\":\"2021-07-15T07:16:03.000000Z\",\"updated_at\":\"2021-07-18T18:57:26.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":null}]',144,44,74,'2021-07-18 18:58:30','2021-07-18 18:58:30',NULL),
	(124,'Worksheet Guide','[{\"show\":true,\"title\":\"Taking the first step\",\"overview\":\"Be led to tell your own version of your story\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":234,\"sections\":\"[{\\\"title\\\":\\\"Getting to know me\\\",\\\"description\\\":\\\"<div class=\\\\\\\"font-weight-bold mb-2 mt-2\\\\\\\" data-v-0a82314c=\\\\\\\"\\\\\\\"><span style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">Congratulations! You&rsquo;re mere weeks away from living the life of your dreams&mdash; purposeful, impactful and productive. We are so excited that the world is about to hear you loud and clear, through your business.<\\\\\\/span><\\\\\\/div>\\\\n<div data-v-0a82314c=\\\\\\\"\\\\\\\">\\\\n<p class=\\\\\\\"p1\\\\\\\">Perhaps you have heard by now that running a business is more than a full-time job, and for it to thrive there needs to be a product-market fit, the right branding, strategy, distribution channels etc. but you may not have heard that running a successful business takes self-awareness and round-the-clock physical, emotional and spiritual commitment.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Yes, sometimes all a business really needs to be successful is alignment with your inner man and commitment&mdash; lots of it, because when you own your own business you are not obligated to achieve your goals, heck, no one even knows them, so your motivation must come from within. Ultimately, it is easier to stay on course when those business goals are in alignment with who you really are.<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">We believe this, and that is why I start right here&mdash; discovering what is within.<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">So, how well do you really know yourself?<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">We are all mostly aware of the things that society wants us to do, or the people our families want us to be. We hear it so much that sometimes, it&rsquo;s easy to get caught up in projections of who we are; never quite discovering or perhaps losing touch with our core values, needs, and desires.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Well, I am here to tell you that if you don&rsquo;t know yourself very well, it&rsquo;s difficult to choose a life path that makes you feel happy and fulfilled, and while growing a business is awesome, do you know what&rsquo;s even better? Being at peace with who you really are while doing so.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Therefore, I implore you to answer the questions in this exercise very sincerely and with openness to whatever you find. Give thoughtful answers but do not be consumed by trying to find the one that present you the way you want to be seen, because that just defeats the purpose of this. Be honest enough to allow yourself to be surprised by some aspects of who you are. That should be exciting!<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Know this&mdash; whatever you find out about yourself today isn&rsquo;t a death sentence; life is dynamic, and you will always have the chance to re-write your story&mdash; especially here, just edit! lol.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">The aim of this phase of the program is to arm you with self-awareness through a journey of self-reflection. It is our hope that in doing this exercise, you learn to identify your own voice in a noisy world.<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Above all, I hope that empowered with this self-awareness, you will be led to tell your own story through your entrepreneurial journey&mdash; the products and services that you develop to serve humanity. We cant wait to see it manifest, so let&rsquo;s get started!<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Affirmation:&nbsp;\\\\\\\"<em>Instead of just coasting through life and being reactive to the behaviors and opinions of others, I will get to know myself.&rdquo;<\\\\\\/em><\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<\\\\\\/div>\\\",\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Are you excited to get to know yourself?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Couldn\'t be happier!\\\"},{\\\"value\\\":\\\"Proceeding with caution\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"A journey of self-reflection\",\"organization_id\":74,\"created_at\":\"2021-07-12T07:05:53.000000Z\",\"updated_at\":\"2021-07-18T18:59:35.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":null}]',144,44,74,'2021-07-18 19:01:15','2021-07-18 19:01:15',NULL),
	(134,'My Bright Idea','[{\"show\":true,\"title\":\"My Bright Idea\",\"overview\":\"By looking at how you initially got inspiration for your business, you can take the next step toward determining how you might get others excited about your business as well.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":284,\"sections\":\"[{\\\"title\\\":\\\"My Bright Idea\\\",\\\"description\\\":\\\"<p class=\\\\\\\"p1\\\\\\\">At some point in their business lives, all entrepreneurs are inspired&mdash; by an idea, a person or an opportunity. That inspiration not only gets you started; it also keeps you going. What inspired this business idea? What excites you about your business idea? If you have two or three ideas, what do you like best about each one? Where did the idea come from? How has it evolved since you started the process of turning the idea into a business?<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">By looking at how you initially got inspiration for your business, you can take the next step toward determining how you might get others excited about your business as well. You will find it useful to have a record of what initially inspired you, to which you can refer from time to time, especially as your business grows.<\\\\\\/p>\\\",\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What is my business idea?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"How did I come up with it?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What excites me about it?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"My Bright Idea\",\"organization_id\":74,\"created_at\":\"2021-07-19T10:40:26.000000Z\",\"updated_at\":\"2021-07-19T12:53:48.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":\"worksheet\"}]',174,44,74,'2021-07-19 13:00:15','2021-07-19 13:00:15',NULL),
	(154,'My Business Mission','[{\"show\":true,\"title\":\"My Business Mission\",\"overview\":\"Once you\\u2019ve written a mission statement worthy of your business, your job is only half-finished. A mission statement worthy of memorization can guide you for years to come.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":304,\"sections\":\"[{\\\"title\\\":\\\"Defining your business mission\\\",\\\"description\\\":\\\"<p class=\\\\\\\"p1\\\\\\\">A mission is a statement of why an organization exists. It puts forth how the company, business, or organization intends to achieve a realization of their vision.&nbsp;Even big companies have mission and vision issues. Take The Walt Disney Company. Disney used to have a very clear mission statement: &ldquo;Make People Happy.&rdquo; It didn&rsquo;t say make people happy through animation, or theme parks, or interactive experiences. Those are details. Its mission was simply to make people happy. To me, clarity of mission doesn&rsquo;t get better than this.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Here&rsquo;s how to get started on defining your business mission:<\\\\\\/p>\\\\n<ol>\\\\n<li class=\\\\\\\"p1\\\\\\\"><strong>Define your purpose: <\\\\\\/strong>Ask yourself why your company exists.<\\\\\\/li>\\\\n<li class=\\\\\\\"p1\\\\\\\"><strong style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">Be specific: <\\\\\\/strong><span style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">Buzzwords and jargon are generally ineffective in a mission statement. If you tell people that you &ldquo;deliver business efficiencies using optimized software solutions,&rdquo; they&rsquo;re unlikely to commit this phrase to memory. In plain man terms, what exactly do you do?<\\\\\\/span><\\\\\\/li>\\\\n<li class=\\\\\\\"p1\\\\\\\"><strong style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">Inspire: <\\\\\\/strong><span style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">It can also be powerful to include an inspirational element. This element can encourage your team members and partners to work toward your vision. <\\\\\\/span><\\\\\\/li>\\\\n<li class=\\\\\\\"p1\\\\\\\"><strong style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">Keep it succinct: <\\\\\\/strong><span style=\\\\\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\\\\\">try to be as concise as possible.<\\\\\\/span><\\\\\\/li>\\\\n<\\\\\\/ol>\\\\n<p class=\\\\\\\"p1\\\\\\\">Once you&rsquo;ve written a mission statement worthy of your business, your job is only half-finished. A mission statement is most effective when you impart its message to others, and when they align their actions with the mission&rsquo;s vision. An impactful statement can serve as a reminder of why you founded your business, and a mission statement worthy of memorization can guide you for years to come.<\\\\\\/p>\\\\n<p class=\\\\\\\"p3\\\\\\\">&nbsp;<\\\\\\/p>\\\",\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Ready to define your business mission?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yessur!\\\"},{\\\"value\\\":\\\"Need more time\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"My business mission\\\",\\\"description\\\":null,\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What do we do?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Clearly outline the main purpose of your organization, and what they do.\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"How do we do it?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Mention how you plan on achieving the mission\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Whom do we do it for?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Clearly state the audience of your mission\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"What value are we bringing?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Outline the benefits and values of your mission\\\",\\\"score\\\":0}]},{\\\"title\\\":\\\"My mission statement\\\",\\\"description\\\":null,\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Based on the foregoing, here is my mission statement:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"Test your mission statement\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Could my competitors use exactly the same statement?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Does it distinguish us from all other businesses?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"If I gave an employee or customer a blind screening test, asking her to read our mission statement and four others without identifying which is which, would she be able to tell which mission statement was ours?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"My Business Mission\",\"organization_id\":74,\"created_at\":\"2021-07-19T11:00:54.000000Z\",\"updated_at\":\"2021-07-19T12:54:44.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":\"worksheet\"}]',174,44,74,'2021-07-19 14:42:56','2021-07-19 14:42:56',NULL),
	(164,'My Business Values','[{\"show\":true,\"title\":\"My Business Values\",\"overview\":\"As we build our businesses, it is commonplace to focus on what our businesses will achieve for us. However, we should also consider how our businesses will impact others.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":314,\"sections\":\"[{\\\"title\\\":\\\"Defining my business values\\\",\\\"description\\\":\\\"<p class=\\\\\\\"p1\\\\\\\">Values play the biggest role in motivating our choices at work, at home, and in everyday life. Your values can be a combination of moral commitments such as honesty, compassion,&nbsp;integrity etc. or where you find the most joy in life, such as learning, fun, or having diverse experiences.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">As we build our businesses, it is commonplace to focus on what our businesses will achieve for us. However, we should also consider how our businesses will impact others: our employees, customer, the environment and our communities. Typically, for most entrepreneurs, the business values they want their company to project are part of their inspiration for getting started in the first place.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">Incorporating your values into your business will help you build a company that gives you greater satisfaction in the first place, and quite possibly, a more successful company. Be cautious however, that as you build your business around your values, you do not impose your personal beliefs (especially religious or political beliefs) on others.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">The worksheet below will help you clarify the values you would like to incorporate into your business.<\\\\\\/p>\\\",\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Are you pumped up for this?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Errr\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"My business values\\\",\\\"description\\\":null,\\\"showSection\\\":false,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What parts of my business am I most proud of?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What is important to me\\\\\\/us?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What will help guide me\\\\\\/us when faced with a difficult business decision?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"Test your values\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Is this something I\\\\u2019ll still believe in 5 years? 10 years?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Is this something that I\\\\u2019m willing to hire, fire or partner based on?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Is this something I can apply to customer relations?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"My business values\",\"organization_id\":74,\"created_at\":\"2021-07-19T12:21:26.000000Z\",\"updated_at\":\"2021-07-19T12:58:08.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":\"worksheet\"}]',174,44,74,'2021-07-19 14:45:43','2021-07-19 14:45:43',NULL),
	(174,'My Business Vision','[{\"show\":true,\"title\":\"My Business Vision\",\"overview\":\"When you imagine your business, what do you hope for? It is important to identify what you see your business becoming: what it will do or make, how it will grow and compete, how big it will get.\",\"file_type\":\"worksheet\",\"file\":null,\"template\":{\"id\":294,\"sections\":\"[{\\\"title\\\":\\\"Defining your business vision\\\",\\\"description\\\":\\\"<p class=\\\\\\\"p1\\\\\\\">If you had an idea to build a house, before you drew up the blueprints, laid the foundation, or even bought the land, you&rsquo;d first have a vision of what you&rsquo;d want the house to be: big or small, one story or two and the location. You&rsquo;d have a vision of your future home.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">The same principle applies to building a business: you need a vision of what you hope to achieve.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">When you imagine your business, what do you hope for? To make a lot of money? To use your creativity? Have more flexibility in your life? Do you see yourself working alone or building a company with employees? Do you hope your company grows very large or do you want it to stay small?<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">As you launch your new business, it is important to clarify and evaluate your business vision. What is your long term vision? What are your personal goals? What do you see as a business opportunity? Then from here you can begin to define your business specifics , such as what it does, whom it serves, how it differs from competition etc.&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">While some entrepreneurs are defined as &lsquo;visionaries&rsquo; who conceive grand schemes or bold new inventions, you must understand that a business vision does not have to be revolutionary. The most important part is that you identify what you see your business becoming: what it will do or make, how it will grow and compete, how big it will get.<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\"><strong>&ldquo; Visioning is a process, not an output.&rdquo;<\\\\\\/strong><\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">A vision should not be unchanging, over time, your business vision could change. As you gain experience and confidence, you may change the nature of your products or services, even your personal goals may evolve or if the world presents new opportunities, then the vision should be updated. Nevertheless, clarifying your current business vision and articulating your specific business concept gives you a stronger start as you begin building your business.<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p1\\\\\\\">&nbsp;<\\\\\\/p>\\\\n<p class=\\\\\\\"p2\\\\\\\">&nbsp;<\\\\\\/p>\\\",\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Ready to get started?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes!\\\"},{\\\"value\\\":\\\"Need more time\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]},{\\\"title\\\":\\\"My Big Hairy Audacious Vision\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"When I imagine my business I hope:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"To make a lot of money\\\"},{\\\"value\\\":\\\"To use my creativity\\\"},{\\\"value\\\":\\\"To have more flexibility in my life\\\"},{\\\"value\\\":\\\"To work mostly alone but profitably\\\"},{\\\"value\\\":\\\"To build my company with partners and employees\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Here is my Big Hairy Audacious Vision:\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Even if it seems unattainable at first glance that\\\\u2019s perfectly all right. It is what you envision, after all.\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"My achievement timeframe:\\\",\\\"addSubQuestion\\\":true,\\\"subQuestion\\\":[{\\\"show\\\":false,\\\"question\\\":\\\"Duration:\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"e.g. 6 Months\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"Set a date:\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"e.g. 06\\\\\\/07\\\\\\/2022\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"How long is the time period within which you expect to achieve the goal that you have envisioned?\\\",\\\"score\\\":0}]},{\\\"title\\\":\\\"Test your vision\\\",\\\"description\\\":null,\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Is it huge, incredible and bold?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Is it specific, clear and concise?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Will anyone who reads your vision be able to grasp it at first look without any need for questions or clarifications?\\\",\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Is it future-oriented\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"single\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":\\\"Yes\\\"},{\\\"value\\\":\\\"Not Quite\\\"}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"My Business Vision\",\"organization_id\":74,\"created_at\":\"2021-07-19T10:55:03.000000Z\",\"updated_at\":\"2021-07-19T12:53:31.000000Z\",\"type\":\"worksheet\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":44,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"templates\":[],\"type\":\"worksheet\"}]',174,44,74,'2021-07-19 14:48:06','2021-07-19 14:48:06',NULL),
	(204,'Introduction','[{\"show\":false,\"title\":\"Introduction to Javascript\",\"overview\":\"A brief introduction into the world of javascript\",\"file_type\":\"video\",\"file\":\"https:\\/\\/res.cloudinary.com\\/skillsguruh\\/video\\/upload\\/v1627245290\\/Pilot_ppryhb.mp4\",\"template\":[],\"templates\":[],\"type\":null},{\"template\":{\"id\":344,\"sections\":\"[{\\\"title\\\":\\\"Section One\\\",\\\"description\\\":\\\"<p>Just tell everything you know about Javascript<\\\\\\/p>\\\",\\\"showSection\\\":true,\\\"questions\\\":[{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"What is javascript?\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Not long answer\\\",\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":false,\\\"question\\\":\\\"Methods in Javscript\\\",\\\"addSubQuestion\\\":true,\\\"subQuestion\\\":[{\\\"show\\\":false,\\\"question\\\":\\\"What is a method?\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"One answer\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null},{\\\"show\\\":true,\\\"question\\\":\\\"Types of methods?\\\",\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Type here\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Type here\\\",\\\"response\\\":null},{\\\"placeholder\\\":\\\"Type here\\\",\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"short\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":null,\\\"score\\\":0},{\\\"fixed\\\":false,\\\"showQuestion\\\":true,\\\"question\\\":\\\"Explain what you understand by Arrays\\\",\\\"addSubQuestion\\\":false,\\\"subQuestion\\\":[{\\\"show\\\":true,\\\"question\\\":null,\\\"placeholders\\\":[{\\\"placeholder\\\":null,\\\"response\\\":null}],\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"answer\\\":null,\\\"answers\\\":[],\\\"response\\\":null,\\\"responses\\\":[],\\\"response_count\\\":null}],\\\"response\\\":null,\\\"responses\\\":[],\\\"result\\\":null,\\\"type\\\":\\\"long\\\",\\\"limit\\\":2,\\\"options\\\":[{\\\"value\\\":null}],\\\"showAnswer\\\":false,\\\"answer\\\":null,\\\"answers\\\":[],\\\"placeholders\\\":[{\\\"placeholder\\\":\\\"Everything you know\\\",\\\"response\\\":null}],\\\"placeholder\\\":null,\\\"hint\\\":\\\"Arrays in javascript\\\",\\\"score\\\":0}]}]\",\"interest\":null,\"title\":\"Javascript\",\"organization_id\":104,\"created_at\":\"2021-07-25T20:32:40.000000Z\",\"updated_at\":\"2021-07-25T20:32:40.000000Z\",\"type\":\"assignment\",\"status\":\"active\",\"user_id\":null,\"admin_id\":null,\"facilitator_id\":54,\"totalscore\":null,\"options\":\"{\\\"grading\\\":false,\\\"correct_answer\\\":false,\\\"time\\\":false}\",\"duration\":null},\"type\":\"assignment\",\"course_id\":null,\"module\":null,\"show\":false,\"modules\":[{\"title\":null,\"overview\":null,\"file_type\":\"video\",\"file\":null,\"template\":[],\"templates\":[],\"type\":null}],\"questionnaires\":[],\"title\":\"Assessment\",\"overview\":\"Test your knowledge so far\",\"file_type\":\"worksheet\"}]',184,54,104,'2021-07-25 20:35:36','2021-07-25 20:35:36',NULL);

/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`)
VALUES
	('005cbb69-ac84-4afe-91da-7c222a51684b','App\\Notifications\\SendNotification','App\\Models\\User',64,'{\"notification\":\"Welcome to EnterMarket, Find facilitators, courses,events according to your personal interests.\",\"id\":64,\"to\":\"user\"}',NULL,'2021-07-25 12:59:44','2021-07-25 12:59:44'),
	('03b3a31f-56fa-47d2-9435-046468f5336d','App\\Notifications\\SendNotification','App\\Models\\User',24,'{\"notification\":\"Welcome to BizGuruh, Find facilitators, courses,events according to your personal interests.\",\"id\":24,\"to\":\"user\"}',NULL,'2021-06-03 13:46:05','2021-06-03 13:46:05'),
	('0b90dbb3-bf53-4486-b4e9-e382151d8870','App\\Notifications\\SendNotification','App\\Models\\Facilitator',24,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":24,\"to\":\"facilitator\"}',NULL,'2021-06-03 13:34:24','2021-06-03 13:34:24'),
	('0c5ef5c9-f8c7-45ba-a131-070f3ba5cf8d','App\\Notifications\\SendNotification','App\\Models\\Facilitator',4,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":4,\"to\":\"facilitator\"}','2021-06-04 17:18:44','2021-06-03 13:32:14','2021-06-04 17:18:44'),
	('1aef4a31-72d0-4745-987e-928ed9faef68','App\\Notifications\\CoursePurchase','App\\Models\\User',54,'{\"notification\":\"Thanks for your purchase of the course, INTRODUCTION TO JAVASCRIPT, it has been added to your library \",\"id\":\"184\"}',NULL,'2021-07-26 01:11:49','2021-07-26 01:11:49'),
	('2b10eb36-a295-4961-959b-a06f4a1e48d4','App\\Notifications\\AddedToLibrary','App\\Models\\User',4,'{\"notification\":\"Group Course course has just been added to your library\"}','2021-07-08 13:12:10','2021-07-08 12:01:15','2021-07-08 13:12:10'),
	('42679b1c-e47d-4811-b534-99920aecde00','App\\Notifications\\SendNotification','App\\Models\\Admin',64,'{\"notification\":\"Welcome to EnterMarket, Access learners,Create courses,events and so much more.\",\"id\":64,\"to\":\"admin\"}',NULL,'2021-07-25 12:15:58','2021-07-25 12:15:58'),
	('471d9ed6-e7d0-4d70-96ca-91f2d3bcf6ca','App\\Notifications\\SendNotification','App\\Models\\Admin',34,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":34,\"to\":\"admin\"}',NULL,'2021-06-03 13:29:36','2021-06-03 13:29:36'),
	('4d91f375-bf88-48e7-a5f7-7db348bc5e31','App\\Notifications\\SendNotification','App\\Models\\User',4,'{\"notification\":\"Success Ahon accepted your invitation to take the course titled Group Course with you\",\"id\":44,\"to\":\"user\"}','2021-07-08 13:12:08','2021-07-08 12:01:15','2021-07-08 13:12:08'),
	('593755e2-2b9a-4e95-898e-4fe4671d5bc7','App\\Notifications\\SendNotification','App\\Models\\User',4,'{\"notification\":\"Welcome to BizGuruh, Find facilitators, courses,events according to your personal interests.\",\"id\":4,\"to\":\"user\"}','2021-06-03 22:29:04','2021-06-03 13:41:28','2021-06-03 22:29:04'),
	('59c75c9d-25f4-4bd2-9883-1af567216ba6','App\\Notifications\\SendNotification','App\\Models\\User',54,'{\"notification\":\"Welcome to EnterMarket, Find facilitators, courses,events according to your personal interests.\",\"id\":54,\"to\":\"user\"}',NULL,'2021-07-25 12:17:57','2021-07-25 12:17:57'),
	('61dbde5b-a938-4b25-a6b8-820b37ada652','App\\Notifications\\SendNotification','App\\Models\\User',34,'{\"notification\":\"Welcome to Edx, Find facilitators, courses,events according to your personal interests.\",\"id\":34,\"to\":\"user\"}',NULL,'2021-06-21 11:17:47','2021-06-21 11:17:47'),
	('719b6632-c1df-44cb-8059-9a8bc68ddc35','App\\Notifications\\CoursePurchase','App\\Models\\User',4,'{\"notification\":\"Thanks for your purchase of the course, BUSINESS FINANNCE, it has been added to your library \",\"id\":\"14\"}','2021-06-29 11:08:05','2021-06-28 00:29:11','2021-06-29 11:08:05'),
	('7aca85ad-5453-46f1-a0e4-3a1138a67a46','App\\Notifications\\SendNotification','App\\Models\\User',14,'{\"notification\":\"Welcome to BizGuruh, Find facilitators, courses,events according to your personal interests.\",\"id\":14,\"to\":\"user\"}','2021-07-13 11:09:59','2021-06-03 13:41:41','2021-07-13 11:09:59'),
	('8f593ff1-d9bd-43e9-9896-020dc08f407c','App\\Notifications\\SendNotification','App\\Models\\Facilitator',44,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":44,\"to\":\"facilitator\"}','2021-07-02 08:51:50','2021-06-24 11:07:34','2021-07-02 08:51:50'),
	('9614737d-bac9-4bc1-a685-04afae9ffcbd','App\\Notifications\\SendNotification','App\\Models\\Facilitator',54,'{\"notification\":\"Welcome to EnterMarket, Access learners,Create courses,events and so much more.\",\"id\":54,\"to\":\"facilitator\"}',NULL,'2021-07-25 12:17:40','2021-07-25 12:17:40'),
	('98da7050-67fe-4e50-af28-c0f8d1ed2d0d','App\\Notifications\\AddedToLibrary','App\\Models\\User',44,'{\"notification\":\"Group Course course has just been added to your library\"}',NULL,'2021-07-08 12:01:15','2021-07-08 12:01:15'),
	('9bc98639-e1f4-48e5-a961-c31f803184de','App\\Notifications\\SendNotification','App\\Models\\Admin',44,'{\"notification\":\"Welcome to Edx, Access learners,Create courses,events and so much more.\",\"id\":44,\"to\":\"admin\"}',NULL,'2021-06-21 11:14:57','2021-06-21 11:14:57'),
	('9c806a4e-9330-41a1-91a8-2298d9fb80b4','App\\Notifications\\SendNotification','App\\Models\\Facilitator',34,'{\"notification\":\"Welcome to Edx, Access learners,Create courses,events and so much more.\",\"id\":34,\"to\":\"facilitator\"}',NULL,'2021-06-21 11:16:13','2021-06-21 11:16:13'),
	('9fbedf62-9712-4f34-a946-fcca15b398d0','App\\Notifications\\SendNotification','App\\Models\\User',44,'{\"notification\":\"Welcome to BizGuruh, Find facilitators, courses,events according to your personal interests.\",\"id\":44,\"to\":\"user\"}',NULL,'2021-07-08 12:01:15','2021-07-08 12:01:15'),
	('ab66ce23-4691-4c9a-9ebc-101c0af86aaf','App\\Notifications\\EventSchedule','App\\Models\\User',54,'{\"notification\":\"You have just been registered to attend the event, IT Training Seminar which is scheduled for Sun, Aug 1, 2021 2:17 PM\"}',NULL,'2021-07-26 00:45:48','2021-07-26 00:45:48'),
	('dc6751fc-e2ee-459e-a4a2-f9d201fd8f20','App\\Notifications\\SendNotification','App\\Models\\Admin',14,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":14,\"to\":\"admin\"}',NULL,'2021-06-03 13:21:45','2021-06-03 13:21:45'),
	('e79e2325-0836-4845-a5f9-1a85e50dc2e0','App\\Notifications\\SendNotification','App\\Models\\Admin',4,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":4,\"to\":\"admin\"}',NULL,'2021-06-03 13:07:58','2021-06-03 13:07:58'),
	('e8b71f19-a137-4a32-a58d-f8a8e2e38011','App\\Notifications\\SendNotification','App\\Models\\Facilitator',14,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":14,\"to\":\"facilitator\"}',NULL,'2021-06-03 13:34:04','2021-06-03 13:34:04'),
	('ebb91ff5-368e-4a3a-afde-7e702d6993ea','App\\Notifications\\SendNotification','App\\Models\\Admin',54,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":54,\"to\":\"admin\"}','2021-06-24 11:17:06','2021-06-24 11:12:22','2021-06-24 11:17:06'),
	('ef53c80e-f5f3-4c1e-9503-df7b4b8c941a','App\\Notifications\\SendNotification','App\\Models\\Admin',24,'{\"notification\":\"Welcome to BizGuruh, Access learners,Create courses,events and so much more.\",\"id\":24,\"to\":\"admin\"}','2021-06-06 21:57:37','2021-06-03 13:29:05','2021-06-06 21:57:37');

/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_access_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_access_tokens`;

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`)
VALUES
	('003c452bd0b175e72d24127a2ec19e64c87689e7febd191b049e7ed891de4f6cdc20937f86931c6a',4,2,NULL,'[]',0,'2021-06-14 17:22:36','2021-06-14 17:22:36','2021-06-19 17:22:36'),
	('0066b33d3c4e2360e2286117b46ab6fba4efefddc279cc988c02004fa6ebf8b062e001ca3dadb84d',24,4,NULL,'[]',0,'2021-07-04 22:05:52','2021-07-04 22:05:52','2021-07-09 22:05:52'),
	('011ed244ed96cd95f7662a9823cf1ffadd73505c47d889f76c9864bb34bd6ebdc046ca3564021cc4',4,2,NULL,'[]',0,'2021-07-07 12:34:51','2021-07-07 12:34:51','2021-07-12 12:34:51'),
	('013521a21feb4c7600f754bfd738026366371f5c68494b58acc8a0f8653ebf51b276a7afdbab1f4c',4,2,NULL,'[]',0,'2021-06-10 11:10:37','2021-06-10 11:10:37','2021-06-15 11:10:37'),
	('02e7e8847119e122401a445a247894a90965a9ec54fe0f09dcaf5cdf1a665b9ed3c9792c5b1defb8',4,4,NULL,'[]',0,'2021-06-25 09:59:45','2021-06-25 09:59:45','2021-06-30 09:59:45'),
	('032c327775654689cde574a1c474b12d250ca210c00e6f75ffc522987f305925bda53b7771e2b2c5',44,4,NULL,'[]',0,'2021-07-05 15:34:34','2021-07-05 15:34:34','2021-07-10 15:34:34'),
	('0399f39e03553a77e188197416edc4bd55d10bbc8ff3784a66cff06f0dda7ab794779d5cedf41808',4,4,NULL,'[]',0,'2021-07-07 11:40:08','2021-07-07 11:40:08','2021-07-12 11:40:08'),
	('046c4da8dce6786ed9b755cfd1d11d882f12b10d252cd0c521d0b51d97bf8ec8473ed837aca08adb',4,2,NULL,'[]',0,'2021-07-01 09:32:08','2021-07-01 09:32:08','2021-07-06 09:32:08'),
	('048b061aec68108ce8e2af83d10a39b25b52a92959912045218052a4a9a13aa6eb5f5ee9effe546f',4,4,NULL,'[]',0,'2021-07-08 16:25:53','2021-07-08 16:25:53','2021-07-13 16:25:53'),
	('061ce85fc2506e99d994bac7e6a16cbfaa9ea91b2d9b99d12577d236cc94cffb926f63f37a664a74',14,2,NULL,'[]',0,'2021-07-12 22:17:40','2021-07-12 22:17:40','2021-07-17 22:17:40'),
	('06873ddbbd5551bf35cf4bf8874832deb3d988ce48a019a748114b571dc245424b2c98fce3c2bed2',4,2,NULL,'[]',0,'2021-07-09 22:59:21','2021-07-09 22:59:21','2021-07-14 22:59:21'),
	('06b0802850fb2fb2081d74a28c8efa6fff371fe020519803b802aec56e6804719d748a92914f0121',4,2,NULL,'[]',0,'2021-06-25 11:39:54','2021-06-25 11:39:54','2021-06-30 11:39:54'),
	('0775a83c47b4031680adf7a148cdc282f7bfe1ce5c473c09831f09eb7e337630f6c90b6048342dbf',44,4,NULL,'[]',0,'2021-07-23 14:13:33','2021-07-23 14:13:33','2021-07-28 14:13:33'),
	('0953db963e358bb79746318e100105405a129ea5c221cda636c42e80797cf6227710701b0c9cf4b1',4,2,NULL,'[]',0,'2021-07-07 10:03:07','2021-07-07 10:03:07','2021-07-12 10:03:07'),
	('097c6c378430a68ffbc041428b4cf494edcf6ccfdc1601513b7f1757e126cfce79b50c606fd98960',4,4,NULL,'[]',0,'2021-06-06 21:55:30','2021-06-06 21:55:30','2021-06-11 21:55:30'),
	('09aa53ef0ec644cf749571be9bd7d1560e6c6e164a8c095667699b11dc036be85e7a06419a3ba034',4,4,NULL,'[]',0,'2021-07-19 07:56:13','2021-07-19 07:56:13','2021-07-24 07:56:13'),
	('0a70ddeca389b7a723f684ab1fd411680f39bd41ef14aa44c91c6a8c7b4a55725e80471430d21c0c',44,4,NULL,'[]',0,'2021-07-01 09:36:48','2021-07-01 09:36:48','2021-07-06 09:36:48'),
	('0acce50c8f35101dfb3d7f8c41e11a4e3da98acf70996316f03dbd5da699c6690fda401bd1c23abe',4,4,NULL,'[]',0,'2021-06-10 17:17:41','2021-06-10 17:17:41','2021-06-15 17:17:41'),
	('0ae895978eb420d3846ee63fc84f8faa50cfde753d98057249dcc235c539f72271a4c97e21e82d34',4,4,NULL,'[]',0,'2021-06-21 11:14:27','2021-06-21 11:14:27','2021-06-26 11:14:27'),
	('0b001383468f4a231909c190dba3381d3c47f968fb56b4c030082af7d5b45bd8cb1eaf9459349ec1',4,4,NULL,'[]',0,'2021-06-11 06:45:59','2021-06-11 06:45:59','2021-06-16 06:45:59'),
	('0cc6daca024dc8d37c12db77bf6cbb89e0e5da6215b040f3ce40e6b97717a641edfc0bb79a307341',4,4,NULL,'[]',0,'2021-07-11 14:50:24','2021-07-11 14:50:24','2021-07-16 14:50:23'),
	('0fc02ffa1e29a3cf6e095f5fd452c310ef082d32756a78c2e9f4eda64ef9cd8d8ef43d9ab2951bbc',4,2,NULL,'[]',0,'2021-06-29 11:00:14','2021-06-29 11:00:14','2021-07-04 11:00:13'),
	('10e619bac91db8aa9ac07eed646be8d8223474bc8a06113d8a9547bb1f159a0413efdf0f48e59613',4,4,NULL,'[]',0,'2021-07-01 10:03:33','2021-07-01 10:03:33','2021-07-06 10:03:33'),
	('120be6f8c2f1aba64b687374e74213d5b23ed07a0efe37aaf38e4acfb236d3c62a4c2fa4d0ced1c9',54,3,NULL,'[]',0,'2021-07-04 19:49:07','2021-07-04 19:49:07','2021-07-09 19:49:07'),
	('12bff48a0a1ce930fac60a2a78cc61ed2c67bba584e3ff178e04f3624251a9b600022a6cbc7e0d23',4,4,NULL,'[]',0,'2021-07-18 11:30:57','2021-07-18 11:30:57','2021-07-23 11:30:57'),
	('131fcecccb03cea80ba3ca75713e585f518ad491dd6ef76a440ce7787ad4b508335c37d967ad8acc',4,4,NULL,'[]',0,'2021-06-28 00:16:08','2021-06-28 00:16:08','2021-07-03 00:16:08'),
	('135b9d05c06764781a2588c569aae8714e83c909e63530791545a0370c054057616acbb0a0109918',4,4,NULL,'[]',0,'2021-07-07 12:18:29','2021-07-07 12:18:29','2021-07-12 12:18:29'),
	('13f4709d99694bcb375327756a83c54d957e02324281b95497c0754855f90dad8a4ecac4af28852a',4,2,NULL,'[]',0,'2021-06-05 13:50:09','2021-06-05 13:50:09','2021-06-10 13:50:09'),
	('14fb27b57534416a06408b7d9bd7de0109dd9874b69b747dd1a964b347a0cf6b3f7aa11ae92f0730',4,2,NULL,'[]',0,'2021-07-06 10:36:28','2021-07-06 10:36:28','2021-07-11 10:36:28'),
	('154906026b8bf70ec82f1285b9d4fe42e07c1ab619b6fd4047fe61e2f251f4f8f113a344baa393b3',4,4,NULL,'[]',0,'2021-06-06 20:13:47','2021-06-06 20:13:47','2021-06-11 20:13:47'),
	('1688ea87020e4152a8b25a6274eb98dd86d92475ed171fc60a661a29a2cb8ba1b49e4d3f0b4aaaa5',4,2,NULL,'[]',0,'2021-06-07 12:41:56','2021-06-07 12:41:56','2021-06-12 12:41:56'),
	('16b3912375f441dab1a6b2f7fba9d053db855c930ec6869bfaaf7d0cc7ab91307728d524dedf6cd1',4,2,NULL,'[]',0,'2021-06-04 06:13:41','2021-06-04 06:13:41','2021-06-09 06:13:41'),
	('16b86db19c07be92e99507361e8f54e1c813fdb961087b7cdd3ac06c3a93d2b7fceb325c9ba0f2b5',4,2,NULL,'[]',0,'2021-07-08 16:16:40','2021-07-08 16:16:40','2021-07-13 16:16:40'),
	('17306eb10bb11eafa56b02b45c00ea7d5564fac57b2bfb10846b5a50d86113eff080d508d0b8ade8',24,3,NULL,'[]',0,'2021-07-01 09:38:17','2021-07-01 09:38:17','2021-07-06 09:38:17'),
	('17478bbc97848f5d90f2142e6e55a908072f5f0e8ac9406320f17feecca49e8eccc8546feaa54b66',24,3,NULL,'[]',0,'2021-06-22 17:50:49','2021-06-22 17:50:49','2021-06-27 17:50:49'),
	('17e084e8ca095eb8e771c0c24a09de8f96e0d15ac34ffd53fe93648988a0cabb1f6c2fce0229e3c1',4,2,NULL,'[]',0,'2021-06-06 21:42:47','2021-06-06 21:42:47','2021-06-11 21:42:47'),
	('17e0d83572c16ce13cac7730b43548eeca2b45de8ffc3c35e60a9eda66c642ec142bfacc8a5689e7',4,4,NULL,'[]',0,'2021-06-08 22:31:21','2021-06-08 22:31:21','2021-06-13 22:31:21'),
	('1a7d2bfc9627ebc44594ee88d36aad5e467e94ee579e8162cf05d10631daa57664a8048c1a684e29',4,2,NULL,'[]',0,'2021-06-24 20:32:34','2021-06-24 20:32:34','2021-06-29 20:32:34'),
	('1aca58cf09084ebfc2a481409fb6fffaaaa96d883aadae2b1ed6d076e61288f6f311b7a52d3f2a4a',4,4,NULL,'[]',0,'2021-06-25 12:24:11','2021-06-25 12:24:11','2021-06-30 12:24:10'),
	('1b04fc5411fd96407e6d1bd77199f8cab8c64fe6e66bfdcd9fc76bcc38ea3e7ae3ef0b5f610edfc7',54,3,NULL,'[]',0,'2021-07-03 20:27:23','2021-07-03 20:27:23','2021-07-08 20:27:23'),
	('1bdcd306e2cc1eefc6436a1047b9c59e7c06c443cc94082a1ac354d2b3ba47752793e8373c82f65b',4,4,NULL,'[]',0,'2021-07-23 11:30:17','2021-07-23 11:30:17','2021-07-28 11:30:17'),
	('1d5eda231c87eb65febd3238e28aa83eb2e1f7eaf1a767b63f6cf37a42d79573a5ad460f90d96764',4,4,NULL,'[]',0,'2021-07-08 11:07:26','2021-07-08 11:07:26','2021-07-13 11:07:26'),
	('1e18005481660cccd02cf56db64dfb20eaab8e8091e5b911062021b228b22c0326f3c5b44476957e',4,2,NULL,'[]',0,'2021-07-19 16:05:15','2021-07-19 16:05:15','2021-07-24 16:05:15'),
	('1eb41ae689c4e66307d419b7afc3bceb11eed73005551ed9cdd79cde0c5aca98438bb6c42dc89453',4,4,NULL,'[]',0,'2021-06-11 20:05:26','2021-06-11 20:05:26','2021-06-16 20:05:26'),
	('2006f1144bfe3f1c1e489e2afdb218a5049675c455ecb837b5c9b30770d04bf7259b7406c3fcc981',4,2,NULL,'[]',0,'2021-06-12 14:41:22','2021-06-12 14:41:22','2021-06-17 14:41:22'),
	('206f451fb834ec96a08b1eebfb81ac84875795dba83642a34933bb9ad90416d49d9f580125a86d33',104,5,NULL,'[]',0,'2021-07-25 12:12:51','2021-07-25 12:12:51','2021-07-30 12:12:51'),
	('2154a1c47c473d6267ad9c5c207e9a95d11eac4f674759a1647504be8578338e3e7be5ba877c4341',14,5,NULL,'[]',0,'2021-06-24 10:33:45','2021-06-24 10:33:45','2021-06-29 10:33:45'),
	('21e94ce1542a2a8ce3bccf64ec5eee6722c285ba75c0bbef98e606ab049329e5945a7db0a7bf4768',4,4,NULL,'[]',0,'2021-07-07 16:54:20','2021-07-07 16:54:20','2021-07-12 16:54:20'),
	('22398eacd31869180ef98379ee5771c03b3e2593de277bd8f429db82e0874496993d392dced59e10',24,4,NULL,'[]',0,'2021-06-20 21:03:13','2021-06-20 21:03:13','2021-06-25 21:03:12'),
	('230bb254a5a7a833a87f92eab620818edce5b26b80d1c41c31855a92cf6a46fb3baff9a76b1f395d',4,2,NULL,'[]',0,'2021-06-04 11:36:25','2021-06-04 11:36:25','2021-06-09 11:36:25'),
	('2345323fc2b7aa7a02c6cd49ee2c76e53b964223eed017d35ccf5f837dd29e979e68ddbaeb465e8a',4,2,NULL,'[]',0,'2021-06-28 08:26:21','2021-06-28 08:26:21','2021-07-03 08:26:21'),
	('245ba15944b3ae061111ed4e8be432ad3b6a35795519f8d31dd20cfde7ca6cc0aabb5eaf478154aa',64,3,NULL,'[]',0,'2021-07-25 12:37:30','2021-07-25 12:37:30','2021-07-30 12:37:29'),
	('257578a971e900dcd115f37bbd22e06a57b79380e39369527e3574e037f8fb9be3c219d4c3405993',4,2,NULL,'[]',0,'2021-07-01 21:49:06','2021-07-01 21:49:06','2021-07-06 21:49:05'),
	('26308660452ca8ba12e782a5a146ed6a15bfd43d6e2376be5d7856e992444114ded8b6e2caac39da',14,2,NULL,'[]',0,'2021-07-14 23:10:27','2021-07-14 23:10:27','2021-07-19 23:10:27'),
	('28af138f441dfd72936df88af72ad6d8192c709c03356da83cc8d9fee3b34d203f73ad92ce94eff4',24,3,NULL,'[]',0,'2021-06-09 08:09:27','2021-06-09 08:09:27','2021-06-14 08:09:27'),
	('28cff49c534b8b8deaf3cf9b6c06b350c800c7bbd8d3d77bfea76b265b792f00a9e3bc147af7075a',4,2,NULL,'[]',0,'2021-06-08 08:34:42','2021-06-08 08:34:42','2021-06-13 08:34:42'),
	('2a35aa54e47fea0339c78145f1548c871c9485db11432465379d89a482e776735bfd1ecf66fc743e',54,3,NULL,'[]',0,'2021-07-05 10:01:25','2021-07-05 10:01:25','2021-07-10 10:01:25'),
	('2d8742ee95203fdf53b712d95b510482041bf050291cebef7eb1f9f8c7591ab5fab38bae41939a1c',44,4,NULL,'[]',0,'2021-07-19 07:48:31','2021-07-19 07:48:31','2021-07-24 07:48:31'),
	('2df9068374c508b512ef05f90009d33a8dba4187058798ec3b20f4826e4130499cf0757bb0b59f7b',24,3,NULL,'[]',0,'2021-06-30 21:23:47','2021-06-30 21:23:47','2021-07-05 21:23:47'),
	('2f0d2dfaa602017a75b5c3ffe5b3fb05349b359175b45c35a35c93e7389ca82186e319686127dd58',4,2,NULL,'[]',0,'2021-06-25 11:17:27','2021-06-25 11:17:27','2021-06-30 11:17:27'),
	('2f31727ef5d0dd6aca577b89f930abcef1a12269974e540edad801fabf7aa07c82fe93d56d9de165',4,2,NULL,'[]',0,'2021-07-14 22:38:32','2021-07-14 22:38:32','2021-07-19 22:38:32'),
	('3032b99279029d410ec3ebcf68382a8943da64fca83bdf028d7755860d60e06dedbc23159cb4199a',14,5,NULL,'[]',0,'2021-06-24 10:51:12','2021-06-24 10:51:12','2021-06-29 10:51:12'),
	('3049a48d4b9e7554f5f7c6e6ae35ec4ee7cecf8006ceb05e5e5af96452c1bbe124f98c788523ebe8',4,4,NULL,'[]',0,'2021-07-01 09:36:39','2021-07-01 09:36:39','2021-07-06 09:36:38'),
	('30dfa971969dd1b522470d5ef21f855465a3cae3be313883224aeae63288e227416c25d6e7286aff',24,3,NULL,'[]',0,'2021-06-29 12:34:42','2021-06-29 12:34:42','2021-07-04 12:34:42'),
	('3234c906d414134b683a54662d3c062f0645f246b1fa8a090a344fad09fab9061f22d35d98374882',4,4,NULL,'[]',0,'2021-06-09 07:23:32','2021-06-09 07:23:32','2021-06-14 07:23:32'),
	('32575328f12b5bc0f74744f3d32d926d13b1b77e44cf029d465fca6d9c7155348760f2f7e25eb096',4,2,NULL,'[]',0,'2021-06-30 00:26:58','2021-06-30 00:26:58','2021-07-05 00:26:58'),
	('32d70723d662b7e69949247933ac25199a87db52905775d6fdf0b0a9255ef7d56144b3237e727161',4,2,NULL,'[]',0,'2021-06-11 18:00:19','2021-06-11 18:00:19','2021-06-16 18:00:19'),
	('332a3566b8eeccde2269f40eba3edd3d8b686e2d13ce256c739585a475fc4010ea65ba6e0ede6e01',4,4,NULL,'[]',0,'2021-06-22 10:27:01','2021-06-22 10:27:01','2021-06-27 10:27:01'),
	('3387457b08189490acd3da11bdd5888da450c945816c2dac2f4862996c906c512d597f9435873e09',44,4,NULL,'[]',0,'2021-07-23 15:52:34','2021-07-23 15:52:34','2021-07-28 15:52:34'),
	('34188b91e4401d14bfd4e675f3d6bc34eb8dd0f7d15e73efd5ac2af8d8e865885a996251c3cca0ff',44,4,NULL,'[]',0,'2021-07-23 12:32:34','2021-07-23 12:32:34','2021-07-28 12:32:34'),
	('34ef16497bdc80de0e4845bc94c508dbf08c30946ce7ad8c8d47d37316a889240f45b7334bf63f67',4,2,NULL,'[]',0,'2021-06-16 20:37:22','2021-06-16 20:37:22','2021-06-21 20:37:22'),
	('34f15e4e6a514963b45eadcc7e1e7e64e45e3b1620fb4ba75c1b0ff247f1903f4cf9718d303fcf69',44,4,NULL,'[]',0,'2021-07-11 22:47:16','2021-07-11 22:47:16','2021-07-16 22:47:16'),
	('351aee861cfed9264c319fd9121a12da2c31e101b3b377fec28ed4c05b56d73410837a8e6d663760',4,4,NULL,'[]',0,'2021-07-18 18:17:08','2021-07-18 18:17:08','2021-07-23 18:17:08'),
	('3560193e4839e0a2ffce52eb2e196c19731ab6d0c31439beaf983195ec236eb9e4ae656d91f5f8ed',24,4,NULL,'[]',0,'2021-06-20 21:03:40','2021-06-20 21:03:40','2021-06-25 21:03:40'),
	('3762d082618f424c5072b9d50ae0853b18eb02e8d0348bbabebaecdfc6beaa4eae5cfe52eb2cf5b3',4,2,NULL,'[]',0,'2021-06-06 20:14:06','2021-06-06 20:14:06','2021-06-11 20:14:06'),
	('384934c09f35926cefc9ac69530ab4cb4e4485878219de7945a3d39e74a203559eb9ceada6ec3c34',24,4,NULL,'[]',0,'2021-07-12 15:02:51','2021-07-12 15:02:51','2021-07-17 15:02:51'),
	('3937ad168fa096b96a7a91b58f9fb3810625ccf6e2fe83ecd94e02fbf8ee653ec99f02a9aef80ff2',4,2,NULL,'[]',0,'2021-06-24 10:47:41','2021-06-24 10:47:41','2021-06-29 10:47:41'),
	('395b05eae650f9b6d3016028ed26a61afc857f42df0ac4843bdfe498f07b1580261c20b7e95fc6fb',4,2,NULL,'[]',0,'2021-06-24 10:54:08','2021-06-24 10:54:08','2021-06-29 10:54:08'),
	('3a52486d037eac2f970dd2092778d952c2a265a367589c7ac6ccfdee9cac6521b693672f07e14e03',24,4,NULL,'[]',0,'2021-07-15 19:38:00','2021-07-15 19:38:00','2021-07-20 19:38:00'),
	('3ad00de97d043279156204e804289327b9758cdfb178962525241a0c7693ee5153ad9654fa09db1a',14,5,NULL,'[]',0,'2021-06-24 10:51:00','2021-06-24 10:51:00','2021-06-29 10:51:00'),
	('3bf8f045076dda36548ac22e21836eb9ee883be6b3ce8c4b50d57ccbcb3b414351c48e6bdff7d50f',4,2,NULL,'[]',0,'2021-07-08 11:41:21','2021-07-08 11:41:21','2021-07-13 11:41:21'),
	('3c389ef0969328e4d7993e42d33751daa0f46200a1bfc242bae01aef45822caa5f46545093bb4df4',44,4,NULL,'[]',0,'2021-07-07 10:46:12','2021-07-07 10:46:12','2021-07-12 10:46:12'),
	('3c8eaa2f8d9be41e13e49c6668568f70df02541912e779370d70f98db14db5795708121616629c5b',24,4,NULL,'[]',0,'2021-07-12 15:01:06','2021-07-12 15:01:06','2021-07-17 15:01:06'),
	('3e8deef0ca6b60b656e2878c6d5334a26ef62a5834edd4597031ed9cb6bfa8fd529010918e419780',44,4,NULL,'[]',0,'2021-07-05 10:57:15','2021-07-05 10:57:15','2021-07-10 10:57:15'),
	('3eb15bba72334fa9052b7aacd7221762b10c6857ba3677ade0fbcf7cdbe957346f6c991654fd6219',24,3,NULL,'[]',0,'2021-06-06 21:57:17','2021-06-06 21:57:17','2021-06-11 21:57:17'),
	('3f5ae372212e57f10420bc5d24d22fa488669a1672b6472b1cd1384966e308acfbdc39d553085669',4,2,NULL,'[]',0,'2021-07-13 11:21:11','2021-07-13 11:21:11','2021-07-18 11:21:11'),
	('4023f7318f724a9eba4c7972b0f7470641003f209e064bbb755cb05f9cbb89c45730a8397328725d',4,4,NULL,'[]',0,'2021-06-03 16:23:29','2021-06-03 16:23:29','2021-06-08 16:23:29'),
	('41ff7e66b812d79bb132ce91ded86c65b007128bfe03c0dee38dbefd28430d0289fe1e5386a5fea9',14,2,NULL,'[]',0,'2021-07-19 01:47:43','2021-07-19 01:47:43','2021-07-24 01:47:43'),
	('42473975fcb60ae40a522104c9214d479e06aeb36a1c529de53478e8aa5708308d7a5b696810e2de',4,2,NULL,'[]',0,'2021-06-28 21:09:10','2021-06-28 21:09:10','2021-07-03 21:09:10'),
	('4386e449c71dd137dad9d49ea7c1062269c98fa470c9156dfa135e394bf0ee84754442bc6d37d139',4,2,NULL,'[]',0,'2021-06-29 19:42:47','2021-06-29 19:42:47','2021-07-04 19:42:47'),
	('43992e5c63cdb08e3b149f8b69e6ab42c83f6eab9a9ae646379798d18a1435e1f34fbef631ca8adb',14,5,NULL,'[]',0,'2021-06-06 20:16:38','2021-06-06 20:16:38','2021-06-11 20:16:38'),
	('43dd30ed6cd2df4fdf2f53395241f92dbd46600604d0c67ef7697570e40ce0890cfb544415df9f49',4,2,NULL,'[]',0,'2021-07-01 09:38:03','2021-07-01 09:38:03','2021-07-06 09:38:03'),
	('4430be34c9faad61052010b90890109592dd858f66b44a58422d57c3720346f0f4e2ad994ba25b2b',44,2,NULL,'[]',0,'2021-07-08 12:01:52','2021-07-08 12:01:52','2021-07-13 12:01:52'),
	('443f142cd9b7009343f72067e273ba20e340da7eec728df6e87bc04cece29f91cdb97ac7713f3c34',4,4,NULL,'[]',0,'2021-07-07 19:28:25','2021-07-07 19:28:25','2021-07-12 19:28:25'),
	('4719f40cbcf0808fed002caff257ea146276160fcf655f7771114d56a36015a9e8b8b6a67dd6ec8f',14,3,NULL,'[]',0,'2021-06-25 10:34:33','2021-06-25 10:34:33','2021-06-30 10:34:32'),
	('4730cce28b12cb6abb3275c312ca87e3481c3b402afde7dc7bc2977d57cb8ec094b9fc76cf8bd1a3',24,5,NULL,'[]',0,'2021-06-21 11:13:47','2021-06-21 11:13:47','2021-06-26 11:13:47'),
	('4a2c0acd6f7dda75afe3f47c08adc209d75fa1e6a4b047c8b6bf7509ec15b865a034f9d9f7bf42a1',4,2,NULL,'[]',0,'2021-06-22 10:43:52','2021-06-22 10:43:52','2021-06-27 10:43:52'),
	('4ac521ab8133f98865b81c3c657da55b958bf11150d9d6717634cf28ebc2217adc899dd30710543c',44,4,NULL,'[]',0,'2021-07-23 21:21:58','2021-07-23 21:21:58','2021-07-28 21:21:58'),
	('4c788d8f157db71a2375c01fba99988f82b255fb453b2e06ffda18aa733790fefd54851655246b93',4,4,NULL,'[]',0,'2021-07-21 00:17:12','2021-07-21 00:17:12','2021-07-26 00:17:12'),
	('4d65b2d22da9a715be1b8febc5be11865e57e67dddd06b58fb8448593b68e74d00843fcfde7734a1',4,2,NULL,'[]',0,'2021-06-11 06:37:04','2021-06-11 06:37:04','2021-06-16 06:37:03'),
	('4e672c6bd8a70f4ff9fced331b03f89fffbd836b26df89551c8ce96913a1d61897805546ae3c35d6',4,2,NULL,'[]',0,'2021-06-22 18:08:09','2021-06-22 18:08:09','2021-06-27 18:08:09'),
	('4f6ae6ca9c1c8a3a041923fc99cfedda60927c52788fdf3a8a61e5021c1eafeb564d354021325979',44,4,NULL,'[]',0,'2021-07-15 13:17:03','2021-07-15 13:17:03','2021-07-20 13:17:03'),
	('50ac01558812c111a9a47e93db6dc82356c6caf9c192d945528a0f01d9c0971bc19cd5ec39c22809',4,2,NULL,'[]',0,'2021-07-11 15:22:19','2021-07-11 15:22:19','2021-07-16 15:22:19'),
	('50bc3227741732afd8475a2dacde96fa9dd16725ca8fe48f17cc966e45b25b4999ccef457a372891',4,4,NULL,'[]',0,'2021-07-19 17:17:16','2021-07-19 17:17:16','2021-07-24 17:17:16'),
	('50f51719749d21a3b386af56058fe4b95047ba70267e6fe8bf5b4881db3f7f4256e96f213ccc0184',74,5,NULL,'[]',0,'2021-07-05 15:14:09','2021-07-05 15:14:09','2021-07-10 15:14:09'),
	('519ccdddbd49c4b9a81606881eb074f5ecaba4956f31fbce90d02af3813db6f74417e88fffc462a6',4,4,NULL,'[]',0,'2021-06-30 21:35:15','2021-06-30 21:35:15','2021-07-05 21:35:15'),
	('527819ee4f465391855a827ae1b42071b84a1a82845af181ee22864cc4dcc20e22d8bfcde215a43b',4,4,NULL,'[]',0,'2021-06-23 19:38:29','2021-06-23 19:38:29','2021-06-28 19:38:29'),
	('54683abbc90155e6f96d1d57aeda88ca797d035de03be1fbf8c4493f7ff27b54f6bb130948e512e8',4,2,NULL,'[]',0,'2021-06-23 06:08:45','2021-06-23 06:08:45','2021-06-28 06:08:45'),
	('5508265d9991690f5293ea02dd4db93d14328f099aed786fa45228e23e14c866986a6e642f721f5c',44,4,NULL,'[]',0,'2021-07-02 08:51:24','2021-07-02 08:51:24','2021-07-07 08:51:24'),
	('5b36f45418a0803cb461bae441fb5de9aeb5b7067c69102e20695c31274cf7141a29e6f9d6dc2eb2',4,2,NULL,'[]',0,'2021-07-03 20:23:38','2021-07-03 20:23:38','2021-07-08 20:23:38'),
	('5bc0e2b998071d606f989e5aba2d45c66d3dd01dbd1e0bc1513960a7d5c18217bdd08a9feaaf0fa3',4,2,NULL,'[]',0,'2021-06-03 16:40:07','2021-06-03 16:40:07','2021-06-08 16:40:07'),
	('5d76ad5201110bb57a3493cfbb63f3d2a19f810ffeb8d8012783e006a9a88bb91f9bfbede9fd4bd5',4,2,NULL,'[]',0,'2021-07-07 19:27:18','2021-07-07 19:27:18','2021-07-12 19:27:18'),
	('5d79c638d17ad272c3b4a2f1f7197ab1185a7171b8a55c3c81217c277cf712b8cf4c648cf330ff4a',4,2,NULL,'[]',0,'2021-06-10 12:11:55','2021-06-10 12:11:55','2021-06-15 12:11:55'),
	('5e3f054556cc4536e10382acebdc721b812934854ae94adea0903e1e0098d00d4e9a503e73ca3dbe',14,2,NULL,'[]',0,'2021-07-19 01:46:52','2021-07-19 01:46:52','2021-07-24 01:46:52'),
	('60d554682fbe2703f6f928668098612aa405bcbe53bb694dae129699782aa62fb188daea33fa0355',4,2,NULL,'[]',0,'2021-06-04 20:37:22','2021-06-04 20:37:22','2021-06-09 20:37:22'),
	('611e29f031d98640507fd6c8b56944ca68ac835fb642528479d3989519c38209e5ea584e2868988e',4,4,NULL,'[]',0,'2021-07-01 09:37:48','2021-07-01 09:37:48','2021-07-06 09:37:48'),
	('61969d7d345221b5a815ff92da4cba1a79937f3baa7bffb9838f813b51825f980f435edafa4fdda2',24,3,NULL,'[]',0,'2021-06-11 13:01:14','2021-06-11 13:01:14','2021-06-16 13:01:14'),
	('61979d7f81fb517ae71ebd5299de84c0243b322202bd4898d400785023ab6dcc1c0c117cf0c9c937',44,4,NULL,'[]',0,'2021-06-24 16:10:14','2021-06-24 16:10:14','2021-06-29 16:10:14'),
	('6251f683f15c59b8632c6d0da9d69150d8c23e173c37e400f33b55c485b80d28e765fd40699d4897',4,2,NULL,'[]',0,'2021-06-29 11:05:16','2021-06-29 11:05:16','2021-07-04 11:05:16'),
	('6316db0d4cfab4c5aa3c988853614867225df76c29b558b025f9a65bd124952a2b1c54be65942c60',4,2,NULL,'[]',0,'2021-06-24 19:40:28','2021-06-24 19:40:28','2021-06-29 19:40:28'),
	('63ff97e28a80266659b394d8d1813d20db46f9cc7eb64519322350144176513613f6b433677ff5a0',4,4,NULL,'[]',0,'2021-06-24 18:52:30','2021-06-24 18:52:30','2021-06-29 18:52:30'),
	('65d2caab21011506b70ddbdb905e90d7dcc7b674a736d0dcea420fd82564d425466cbf031d741f8c',24,4,NULL,'[]',0,'2021-06-20 20:51:27','2021-06-20 20:51:27','2021-06-25 20:51:27'),
	('662762a4d3a853d875102bec3cf7594f04bac5867ae4961776164c19787dede116428af1154cff0b',4,2,NULL,'[]',0,'2021-07-20 05:50:01','2021-07-20 05:50:01','2021-07-25 05:50:01'),
	('66924712a82ea7ed8d4ce239e7c5c3d48cbfe2747038564091d5b3a083518a26208b735cf37a7275',54,3,NULL,'[]',0,'2021-07-05 09:56:54','2021-07-05 09:56:54','2021-07-10 09:56:54'),
	('67d2efa0cb649d7b44dec70cd7168526efd9e0a56e758bd59fec4ac8fb97c462a66e6e21825f60a7',4,4,NULL,'[]',0,'2021-06-15 07:03:12','2021-06-15 07:03:12','2021-06-20 07:03:12'),
	('68d8c1355f77d5430e6b63966cd3851f30f9c1358b09a20782b904397e513d03dde64098659efc0b',24,3,NULL,'[]',0,'2021-06-11 13:14:48','2021-06-11 13:14:48','2021-06-16 13:14:48'),
	('69d13ce9058ae326be5891303ba9d8ec3a0cdca0f63b05012bdb96eca1ef9ea18811521dcbd9cb4f',4,4,NULL,'[]',0,'2021-06-04 12:19:34','2021-06-04 12:19:34','2021-06-09 12:19:34'),
	('6bbfc14702d9fb5d16fedeaa940c0a5aca7c69b343e2b8e61560bb51be0c6f47dc0665a92febf12e',4,2,NULL,'[]',0,'2021-06-09 07:20:41','2021-06-09 07:20:41','2021-06-14 07:20:41'),
	('6bc3386679e428b44a393e00bc6739c6a2738b2008c9ced70fc35d0f4f7fe5b355c5f81cc237616b',14,2,NULL,'[]',0,'2021-07-12 22:19:03','2021-07-12 22:19:03','2021-07-17 22:19:03'),
	('6be97037343d55a4a96296a04710c42dace9c4212b9abf81939cd0dd69cef7bdce1629fbd08942e9',44,4,NULL,'[]',0,'2021-07-21 17:28:56','2021-07-21 17:28:56','2021-07-26 17:28:56'),
	('6cb637e9f82ef0e8fe2a9a042047f94432cf4cfefccf3ccd84bb990154e7f411caa9915a5e06b22c',4,4,NULL,'[]',0,'2021-07-07 21:15:43','2021-07-07 21:15:43','2021-07-12 21:15:42'),
	('6ce8a2c8e88010611dc6c675030a88aa655f233fc9ab008fc6117e44a33b027303381223dd986c20',4,4,NULL,'[]',0,'2021-06-28 08:38:47','2021-06-28 08:38:47','2021-07-03 08:38:47'),
	('6dcc77212746c11f2c1a3d72fef9c247e138f79ab09b07c58f5979a4c3a24b67da4b88e45effac7a',44,3,NULL,'[]',0,'2021-06-21 11:19:19','2021-06-21 11:19:19','2021-06-26 11:19:19'),
	('6e84f098e320b1b0710e11e7f4e9c85d70962beca46b7bcfc176533d74179e36a6e98afebd83c735',4,4,NULL,'[]',0,'2021-07-09 11:07:30','2021-07-09 11:07:30','2021-07-14 11:07:30'),
	('6f5f574cc2208d6c63c89cfdd43f99e66eecfb4a04ab46bae3b81dc157de2825dfefedd081eb23cb',4,2,NULL,'[]',0,'2021-07-02 08:49:13','2021-07-02 08:49:13','2021-07-07 08:49:13'),
	('705965cecd7e938cf743af2e9d2150863dc2cefb17f741da672449c65dd3f008583a66281f13e454',44,4,NULL,'[]',0,'2021-07-12 06:45:58','2021-07-12 06:45:58','2021-07-17 06:45:58'),
	('724e520941464006b1aaa1340e1bb81a0a66b29c6f99e9101907aade5d750fea7f3ba01b5d117b5a',4,4,NULL,'[]',0,'2021-06-09 15:23:04','2021-06-09 15:23:04','2021-06-14 15:23:04'),
	('727b3f533e1755d09638c1c7ee2c075581971d9fcc67245c3b55d91e6d7d190b2078e406c68d3156',4,2,NULL,'[]',0,'2021-07-16 11:36:57','2021-07-16 11:36:57','2021-07-21 11:36:57'),
	('72e8abe90a53dca350a6a609f7d760b988c4db15ff16f5fe0b70a71c78d5e3f80568a1112eb4f5ba',24,3,NULL,'[]',0,'2021-07-07 11:43:38','2021-07-07 11:43:38','2021-07-12 11:43:38'),
	('74f1fb29e6656831f880c1d56d7a290792a25c4b7f0d532f7169a3b2e6ad2651eeba550d9b13aa58',24,3,NULL,'[]',0,'2021-06-06 20:12:39','2021-06-06 20:12:39','2021-06-11 20:12:39'),
	('7597e7e048969fcc7a61f8ca9257ffba1f31c9fdbe75542d24fbed606e5dfc5d72f74b28610df11b',4,4,NULL,'[]',0,'2021-06-22 10:44:40','2021-06-22 10:44:40','2021-06-27 10:44:40'),
	('763a0df917b5dbee3c150c3092f54e3d024e050107c0808bf6a4b5a19e9fb04043607c0c6bd90690',4,4,NULL,'[]',0,'2021-07-09 22:59:44','2021-07-09 22:59:44','2021-07-14 22:59:44'),
	('772cd472fc327ff5d631312fa987f5b28184097a64994d2264cf1b35a92f4b5b2ee4d2d391da33a1',14,2,NULL,'[]',0,'2021-07-18 00:13:05','2021-07-18 00:13:05','2021-07-23 00:13:05'),
	('778ce5bf19c970a88dad34adfbd56432532217abb8b2664d52cf29106ee294babe4c980f0b7dd33a',4,4,NULL,'[]',0,'2021-06-04 14:31:08','2021-06-04 14:31:08','2021-06-09 14:31:08'),
	('7894718b95854f6b8dcd42aa08e49f1280af24ecd4de9e3df5b500bc0126c370dc97d8ccebe03ed3',4,2,NULL,'[]',0,'2021-06-10 17:16:29','2021-06-10 17:16:29','2021-06-15 17:16:28'),
	('799dbb0190ebcb8e963bf913387621d275fab8522b20b5a2fa19b222aa29c61b3394acb7003d2ae4',4,4,NULL,'[]',0,'2021-07-01 09:35:49','2021-07-01 09:35:49','2021-07-06 09:35:49'),
	('7afc62755d0dcdc3f44595ff2626e43a1e7434df55ac1a0bb45a6774ba918276e2c5e5caaa0a42a5',14,2,NULL,'[]',0,'2021-07-19 17:19:09','2021-07-19 17:19:09','2021-07-24 17:19:09'),
	('7bbd9ee987d6c7abdd5c17232a5b447fce18c751daa6cb92638d20e20908c326e8d612ff42777f85',44,4,NULL,'[]',0,'2021-07-26 09:23:33','2021-07-26 09:23:33','2021-07-31 09:23:33'),
	('7bdf217e6a332add93817acdd6236979a2fa8e496b049bf009967f968e804dedb337065924630676',4,2,NULL,'[]',0,'2021-07-12 13:51:15','2021-07-12 13:51:15','2021-07-17 13:51:14'),
	('7cfd8d9381e1845dcf8874e9c76efff697191797699e3e656e937cfab49aee8d8d23e6b75bdd3ae5',4,2,NULL,'[]',0,'2021-07-08 09:19:18','2021-07-08 09:19:18','2021-07-13 09:19:17'),
	('7d5f94252e90601a0a1c4caa716d0fad82c98ca779abe3559b5351d152abc02a83b6edff8ebdb922',54,3,NULL,'[]',0,'2021-07-07 10:38:34','2021-07-07 10:38:34','2021-07-12 10:38:34'),
	('7e6ee47c72bf08e5c7014e9911945a22280e6ad6c8482fac04d0cfffd3468e718a55b0cb8818e8ac',4,2,NULL,'[]',0,'2021-06-25 11:19:04','2021-06-25 11:19:04','2021-06-30 11:19:04'),
	('8021956f75d7091bf88a04ad557e30f48636fc1fe6ff17d229324210a37e7b9111e61ca952c8d3a6',4,2,NULL,'[]',0,'2021-07-19 01:47:57','2021-07-19 01:47:57','2021-07-24 01:47:57'),
	('805b986cfdf9ca22f1207d26adb9a3426bda0354bb7098b9d56d307010074012b36fa4a79ea1a720',4,2,NULL,'[]',0,'2021-07-07 16:52:30','2021-07-07 16:52:30','2021-07-12 16:52:30'),
	('82f80ba821f03ff08eb07ba7c588642d8ac3f398cd9369a9ad0b6e1e913a05245dc9616fe9baafc1',4,4,NULL,'[]',0,'2021-07-20 12:57:51','2021-07-20 12:57:51','2021-07-25 12:57:51'),
	('83c83be9f40f2dc123936785431392652caf87c686939fea6956ba5ba56c301bacc12a7732db189e',4,2,NULL,'[]',0,'2021-06-30 08:18:54','2021-06-30 08:18:54','2021-07-05 08:18:54'),
	('8580fdd8a33fdb5bdc9160daa75f288f0ebb27a59120ff803c5e8d9df21d03b9b95f2dcff81df815',4,4,NULL,'[]',0,'2021-06-25 09:51:48','2021-06-25 09:51:48','2021-06-30 09:51:48'),
	('85afa983d2baf6514af7380bceebf95a89190f4234ea0a050e2cc5acaec30f7e27857e165a15c790',14,5,NULL,'[]',0,'2021-06-29 11:09:52','2021-06-29 11:09:52','2021-07-04 11:09:52'),
	('86048ef2cedd7db5f07d66f42fb92e7f4d3bcbe2a8c898784888091a8dec904156e4a390ac42b084',54,2,NULL,'[]',0,'2021-07-25 22:00:37','2021-07-25 22:00:37','2021-07-30 22:00:37'),
	('872cc6640b3d17fcf2c379ebe45ca122ab2a0879cdeeeed03ad210a1948a4bd95028a416749973f9',54,3,NULL,'[]',0,'2021-07-15 08:11:23','2021-07-15 08:11:23','2021-07-20 08:11:23'),
	('8881d46884badb13c08599b6c8c5cd7cb8735da1e64ef49136ae57608e34ce74d36a846ac0bcc4c3',4,4,NULL,'[]',0,'2021-07-15 08:15:02','2021-07-15 08:15:02','2021-07-20 08:15:02'),
	('89bfb10da5f64be950ae150a54a558cb142d3e43c039ad114df4eca083f00f1a95c1b586285b5cdc',44,4,NULL,'[]',0,'2021-07-01 10:06:43','2021-07-01 10:06:43','2021-07-06 10:06:43'),
	('8d98e29a57fcfaaf76fef73969a2a6dd4d3916f0f909b8942919c8c7aa9314bc3371b17b598aaeb2',24,4,NULL,'[]',0,'2021-06-20 21:02:05','2021-06-20 21:02:05','2021-06-25 21:02:05'),
	('911103962b01fdcca9969cdc95e442e0fafb01ed53a94f5217af09ca953bdfe0ea2c8b68dcbd60e4',4,2,NULL,'[]',0,'2021-06-21 11:33:27','2021-06-21 11:33:27','2021-06-26 11:33:27'),
	('913da867482783c3c5d5deb5fadc7b22ea4ff1b12d83c32b0b40800a5b2b110d41ebe592373b04f0',4,2,NULL,'[]',0,'2021-07-08 11:15:26','2021-07-08 11:15:26','2021-07-13 11:15:26'),
	('93b7fd3ed9684e9dcb93f9282037d435b8eca330a3afde8fe0efc8167992da0010e1774185ce25b9',4,2,NULL,'[]',0,'2021-06-25 13:18:13','2021-06-25 13:18:13','2021-06-30 13:18:13'),
	('941181c5fcf958e597b86c13b322c66670c32708f82ecc5653c67c8b7f19b9ceac211ed8c3f17539',4,2,NULL,'[]',0,'2021-06-24 10:58:28','2021-06-24 10:58:28','2021-06-29 10:58:28'),
	('945e0b0e5580cd44512862266062a428d566b6c8743bb878de65cf220feb40ea5ab3ee39870014ee',4,2,NULL,'[]',0,'2021-06-30 10:58:45','2021-06-30 10:58:45','2021-07-05 10:58:45'),
	('965ab13b50de030a4a2c356bf9763f7b5741f8888cfd36cb73549908104ada3d892e160165bb698a',4,2,NULL,'[]',0,'2021-06-12 14:49:53','2021-06-12 14:49:53','2021-06-17 14:49:53'),
	('968cc23103fba594c2a42989f2e67208aadc2c3abf2cc7f3d1a356f24d9c3ab59221960cf8946cf6',4,2,NULL,'[]',0,'2021-06-11 10:28:54','2021-06-11 10:28:54','2021-06-16 10:28:54'),
	('9823692c29f0cb4b94b84b674b4f1b6b2ceddaf875f18f542188acff11936a3259d6c39eb48461f9',4,2,NULL,'[]',0,'2021-07-11 15:21:08','2021-07-11 15:21:08','2021-07-16 15:21:08'),
	('9873c8d7b539376a3798ed2d9e375ff995b975f1b0a7c21bca92d8e1e439491057ce539035ae9850',4,2,NULL,'[]',0,'2021-07-09 10:38:34','2021-07-09 10:38:34','2021-07-14 10:38:34'),
	('99690f37de7d67ae50773299dffcad7b111ab5475a089ff5fcc359a1edfa99cb0ca791fd36a7b4b6',4,2,NULL,'[]',0,'2021-07-21 00:11:13','2021-07-21 00:11:13','2021-07-26 00:11:13'),
	('9996fecc7a71fd7875d7712ad4fd2b3cc7e6565c898e8739171226f820a2d687f182d42b3795b3b6',4,4,NULL,'[]',0,'2021-06-12 12:43:21','2021-06-12 12:43:21','2021-06-17 12:43:21'),
	('9bbed24afbf7d6a6605aad4c72aa45c8d1076a869d85a4e78704dfe16b48a2a543c14235dbec90b5',54,3,NULL,'[]',0,'2021-06-24 18:47:52','2021-06-24 18:47:52','2021-06-29 18:47:52'),
	('9cb2c4d1953763c23aeac80dd347e31b9c6aefee03233d4983469409644553b28f1e72f0e34b147a',4,4,NULL,'[]',0,'2021-07-18 18:19:00','2021-07-18 18:19:00','2021-07-23 18:19:00'),
	('9db146cdd8b6554281211b7b8ed0e6c52bcc07b27773d4f98181cc7272ecd508f4b59e6c7f9abc36',44,4,NULL,'[]',0,'2021-07-26 09:29:32','2021-07-26 09:29:32','2021-07-31 09:29:31'),
	('9e1608bd2b5c87694760447511ea1b8612baaa96da6977609f29f42b1e8e34b80ef2b75610eef536',4,2,NULL,'[]',0,'2021-07-18 16:45:02','2021-07-18 16:45:02','2021-07-23 16:45:02'),
	('9ff10e7495c636a6fccc66a06f7ac5f16855f3c252da39ffda6fca3a401c5ff4c404edaa6eddaadb',54,3,NULL,'[]',0,'2021-06-30 17:01:44','2021-06-30 17:01:44','2021-07-05 17:01:44'),
	('a1cf96bd2aa39d39c56ae116294f87446d1145b24678ea074890ac7b5877ed82da37237dc2a18b4a',4,2,NULL,'[]',0,'2021-06-04 20:37:22','2021-06-04 20:37:22','2021-06-09 20:37:22'),
	('a3fbc74fdf14bd291ad646b9e7a49326c4625fd6fdcc3de20ef28e576b64ad446650c9826afec8a9',24,4,NULL,'[]',0,'2021-06-25 10:35:30','2021-06-25 10:35:30','2021-06-30 10:35:30'),
	('a409b940ee978e9455e539df202995e818faa840b90f3029f2401f14429790ecc1a5a4d30e012f15',4,2,NULL,'[]',0,'2021-06-07 11:34:23','2021-06-07 11:34:23','2021-06-12 11:34:23'),
	('a57847cce7a9640a5be6391f79b8719a298593182b186d3fa83553520e3d6975ca3f8760479fde84',4,2,NULL,'[]',0,'2021-06-23 19:28:57','2021-06-23 19:28:57','2021-06-28 19:28:57'),
	('a5ed54c7ad9e9c802e043b2571e37555c1397ce785e7cd611e8cb207291483adbe133b099694e07a',24,3,NULL,'[]',0,'2021-06-07 12:34:26','2021-06-07 12:34:26','2021-06-12 12:34:26'),
	('a6324e596a32447fb425813d6df2fa1246d086aa780893ea3622e34b196fd9b57839c756a5f3f28b',4,4,NULL,'[]',0,'2021-06-29 11:07:43','2021-06-29 11:07:43','2021-07-04 11:07:43'),
	('a87431feedf1e4f2ff398037175ada92563db597afc144e22cabbe35663c6997b29c892f8b21685a',4,2,NULL,'[]',0,'2021-06-24 10:46:39','2021-06-24 10:46:39','2021-06-29 10:46:39'),
	('aa4d9f53bbed1f0b37733942214a9e25377da41b686b6122a3073a64d4631a034fe104a02cdffe7a',4,2,NULL,'[]',0,'2021-07-08 01:56:44','2021-07-08 01:56:44','2021-07-13 01:56:43'),
	('ac326fca7451895f9995d0eb913f7799b5e38737a3fea74bae58675fe8abd2cef1ac7cc22c52f47d',4,2,NULL,'[]',0,'2021-07-11 21:21:24','2021-07-11 21:21:24','2021-07-16 21:21:24'),
	('ac863544b4bdad3e2fd2a95b08d1ed4e35afc4655068654f10a32bf75ef6144b5ea6ebe70cb5fa8b',54,4,NULL,'[]',0,'2021-07-25 19:51:18','2021-07-25 19:51:18','2021-07-30 19:51:18'),
	('ad02d43ff40739bb5ff68dffce550223451ba82888f18d100e65af2b914973479c20926d6c5fb669',4,2,NULL,'[]',0,'2021-06-05 13:50:09','2021-06-05 13:50:09','2021-06-10 13:50:09'),
	('b02acb06b27e35e7b5fd5c8b3296055924b667116a40d6836d808a2d5dce73f29b3bcc237db5a97d',4,2,NULL,'[]',0,'2021-06-04 20:37:24','2021-06-04 20:37:24','2021-06-09 20:37:24'),
	('b0c42d787d69fe376638945cc73a0d9e5ba567c08d2d8700f0c993f69e03029fde896587ab87d6a9',24,3,NULL,'[]',0,'2021-06-07 12:34:27','2021-06-07 12:34:27','2021-06-12 12:34:27'),
	('b26c3a9d5410cdcfc106d1e52a86a108bf4babee7a309e06978f43ce5efd7f25d359028e0cc7857c',4,4,NULL,'[]',0,'2021-07-07 11:42:48','2021-07-07 11:42:48','2021-07-12 11:42:48'),
	('b3589cd62e309157afacef4fb79fea8853d8ba400a10403062619dc099ac69e00847612885788f32',4,2,NULL,'[]',0,'2021-07-19 17:44:00','2021-07-19 17:44:00','2021-07-24 17:44:00'),
	('b3c168787e60f25700ad0008773b4b8be7e3d8614d67cb263010b0ea85c2c829864c339dee89870b',4,4,NULL,'[]',0,'2021-07-20 12:19:03','2021-07-20 12:19:03','2021-07-25 12:19:03'),
	('b3ed2392e79584aadf1a0e4af8d0f53bb9aaa1abd38a29db1701d148a7ecf4855bc8b86a11c34892',14,2,NULL,'[]',0,'2021-07-15 08:33:34','2021-07-15 08:33:34','2021-07-20 08:33:34'),
	('b431bfbbbaf84587255db6379e2b74feed2af6d33f65fb7bbadea3724fe2f50ce45b22938ed6c39c',44,4,NULL,'[]',0,'2021-07-08 16:35:52','2021-07-08 16:35:52','2021-07-13 16:35:52'),
	('b486588b40c7f3747c964f373c31923046f1967ddcde7f582bc16558135b97e1cc009275b0f4d64b',24,3,NULL,'[]',0,'2021-06-03 13:51:27','2021-06-03 13:51:27','2021-06-08 13:51:26'),
	('b50aa4778effd16e36db23d26ae177976b58e0f2c251d0c591bb78abda59f8cb0cf2a1543a070502',4,2,NULL,'[]',0,'2021-06-04 06:13:41','2021-06-04 06:13:41','2021-06-09 06:13:41'),
	('b523db406f2bee73432112c47e91876887d1fde341b932def13bb80a3b3abbf41efb9f69a52d4445',4,2,NULL,'[]',0,'2021-07-07 16:55:41','2021-07-07 16:55:41','2021-07-12 16:55:41'),
	('b67cd424227088d3ef055b4aa2a2e140bb696e2355088f976a4b8cb3e27ba1f318844717478c4255',4,4,NULL,'[]',0,'2021-06-23 06:09:42','2021-06-23 06:09:42','2021-06-28 06:09:42'),
	('b7d9beabff847e0d64e5347dbb2e0081074a61f1a230779230a9a7bcee599c773646af2b671248f7',14,5,NULL,'[]',0,'2021-06-24 10:46:28','2021-06-24 10:46:28','2021-06-29 10:46:28'),
	('b8eb80b079687439e4dc6fd538449871989fb3b65406211a6d3ff7fe49fbc99daf39af9215cf23bc',54,3,NULL,'[]',0,'2021-07-06 10:55:39','2021-07-06 10:55:39','2021-07-11 10:55:39'),
	('b900a83adda4fda34469f5cff36a2714079bba179c2f7d8f253a1cd3ff11616e604432130c8a645d',4,4,NULL,'[]',0,'2021-07-07 16:34:50','2021-07-07 16:34:50','2021-07-12 16:34:49'),
	('b950d716c7c618bd367e465a080d9f60811b1085e47bca0bd4903aaed5410aa5a9faec7898b8fce1',4,4,NULL,'[]',0,'2021-07-05 13:17:29','2021-07-05 13:17:29','2021-07-10 13:17:29'),
	('b95f795a23453a958860a3f07364dbb30a9b5c8cb9b3616c3bb6be21254bb84510c6d4c2a79fa611',4,4,NULL,'[]',0,'2021-06-12 12:42:24','2021-06-12 12:42:24','2021-06-17 12:42:24'),
	('b9884fe3f0fa36812863cf611aaf5b954176923d349d04252213a318a04669c46a1d2bd13c922412',54,3,NULL,'[]',0,'2021-07-05 15:14:29','2021-07-05 15:14:29','2021-07-10 15:14:29'),
	('baf7e07448cca23146433d7aeff85568f15084477ccea0e6ea935bda5ad056aaaa6025a54cacb4f9',4,2,NULL,'[]',0,'2021-06-29 12:17:56','2021-06-29 12:17:56','2021-07-04 12:17:56'),
	('bc31514cfa1230c8f422f7c73513df4c919b7aaadd48e87775e66de2b713eea7a073fab375513355',4,2,NULL,'[]',0,'2021-07-18 13:06:35','2021-07-18 13:06:35','2021-07-23 13:06:34'),
	('bcee0a9cabbb41cee0ac052e902e1d81d3990cd1e265310eb5f583960c299b6270ef9511e8512ca1',74,5,NULL,'[]',0,'2021-06-24 11:06:50','2021-06-24 11:06:50','2021-06-29 11:06:50'),
	('bdfc8af0198a19dc33941ff19035ed8ae4e17f495fa4730a5007ebab50fa610eeaa0b9d981c64887',14,5,NULL,'[]',0,'2021-06-03 13:06:18','2021-06-03 13:06:18','2021-06-08 13:06:18'),
	('be9d92ae9b9b67570ae65197f26d23e039b2aa51689a020a4b18d5771a7b2cd4f6fa6cb0acd02997',14,2,NULL,'[]',0,'2021-07-13 11:09:07','2021-07-13 11:09:07','2021-07-18 11:09:07'),
	('bee782a44afe5e80e49ee5dc11cb584c36657a338f74a94f670a65ba8cf18f36717313af3ae776c3',44,4,NULL,'[]',0,'2021-06-25 10:07:29','2021-06-25 10:07:29','2021-06-30 10:07:29'),
	('bf255950c63d5d06ab84dcb10e85c0b7a93f21a0d86f6f04ee15cbe55d773189314f6a2377455569',4,2,NULL,'[]',0,'2021-06-30 16:34:19','2021-06-30 16:34:19','2021-07-05 16:34:18'),
	('c19fb774363c6cc405ed43754ce7e210c3e98276fc3773f512298e67d327205768df2f46f57b0103',4,2,NULL,'[]',0,'2021-06-12 09:29:07','2021-06-12 09:29:07','2021-06-17 09:29:07'),
	('c286c4abb1c07a93116cd403c24f5bccf702e4c2e3f6932ad28cb7ec013d61d259ba5624cfb5a364',4,2,NULL,'[]',0,'2021-07-24 23:16:02','2021-07-24 23:16:02','2021-07-29 23:16:02'),
	('c2d87f8d09c3d45b4813edcfb9591d0c40d832556c6f8c00fad307a0e65edbfd5c6ec5586e89d3ef',4,2,NULL,'[]',0,'2021-06-17 12:43:42','2021-06-17 12:43:42','2021-06-22 12:43:42'),
	('c3e58f72413d04a47818e2a76a43948b2f1685c8ea8d833158193ef59aa0b9e370e393094f0cb2c0',4,4,NULL,'[]',0,'2021-07-19 16:13:23','2021-07-19 16:13:23','2021-07-24 16:13:23'),
	('c4a1787df153ce4f15d1588357ea7d0e500ed951a4937d4b04565e6ce7edc02671fc87bf09329938',44,4,NULL,'[]',0,'2021-07-06 08:35:59','2021-07-06 08:35:59','2021-07-11 08:35:59'),
	('c56bdfdc2fb1b466069267865b4753152bd14185a1156e107d1efb50af8aadd911b0cae06418611b',4,2,NULL,'[]',0,'2021-07-19 09:52:44','2021-07-19 09:52:44','2021-07-24 09:52:44'),
	('c889283836204223e144a58cdcab3fdba6cb244f568a502b6cda857d41d71f5af4847f065110fab0',4,2,NULL,'[]',0,'2021-06-21 11:12:56','2021-06-21 11:12:56','2021-06-26 11:12:56'),
	('c94df38ade5da526d80a99e9b0d760423d93d10973e4b7c1cb288b6efc47685f0c7a1d844c4081e9',4,2,NULL,'[]',0,'2021-07-23 21:27:01','2021-07-23 21:27:01','2021-07-28 21:27:01'),
	('ca6b3225d7712d5d2f050151e779f53792786d9f6da45fc292a419ff733bfd8a042171fd0176e019',4,2,NULL,'[]',0,'2021-06-13 20:23:06','2021-06-13 20:23:06','2021-06-18 20:23:06'),
	('cd6c546d78d7e0aaf4f0dea03562ab2f5cfa8b66cdd3dca3fed121952db416a0370e825ea4b3a08f',4,4,NULL,'[]',0,'2021-06-11 06:47:40','2021-06-11 06:47:40','2021-06-16 06:47:40'),
	('d032ee93cd4a9eb7988736d1442159bcb211ebe1cd115e10503a7bf30e350f736e35493ddf166c9d',4,4,NULL,'[]',0,'2021-07-05 09:48:39','2021-07-05 09:48:39','2021-07-10 09:48:39'),
	('d13d88df2302bded3efe440985162b90011aba909ed42756cd5e6090d170fe0d1efe7d7614104154',4,2,NULL,'[]',0,'2021-06-28 00:19:52','2021-06-28 00:19:52','2021-07-03 00:19:51'),
	('d341ac25e7a9d8e538e66a262c909686c033ada87d71f5022fa4eb2c1b989e51253ec87a292bf197',4,2,NULL,'[]',0,'2021-07-01 05:59:47','2021-07-01 05:59:47','2021-07-06 05:59:47'),
	('d3b05d98d6148b89b35f9cac115fe599d391a4779bd2cb261ef08c5cb028ba3dbb8057c06e5213a4',4,2,NULL,'[]',0,'2021-06-17 13:31:10','2021-06-17 13:31:10','2021-06-22 13:31:10'),
	('d3b4f626300c58b463e37b752a2296506b768401a4c767e9475545578a61015d0cdffb59363f8637',4,4,NULL,'[]',0,'2021-07-19 17:17:23','2021-07-19 17:17:23','2021-07-24 17:17:23'),
	('d3ba1dddaf3f368164d7c50cd2926747852b99ecfdf6e740df8dd023b42de2d95150d1200d2dc01a',4,2,NULL,'[]',0,'2021-06-29 07:07:54','2021-06-29 07:07:54','2021-07-04 07:07:53'),
	('d55592e51106d1cd901d7d688207821d8f21c5b9fb15aa52f93cb2034a50d6b71f4fef4eb61035bf',4,4,NULL,'[]',0,'2021-06-10 12:10:20','2021-06-10 12:10:20','2021-06-15 12:10:19'),
	('d91586c3d3d05773ae868d307d7257d96440c8e26062e79d607bee3d2456da4b755c314d2c313b03',24,3,NULL,'[]',0,'2021-06-07 10:52:54','2021-06-07 10:52:54','2021-06-12 10:52:54'),
	('d950400732eee9ec4c7d430e8825f32f39ec2f834ea464354ecc896f5020bf4a89888eb93d75dc49',4,4,NULL,'[]',0,'2021-07-23 14:07:56','2021-07-23 14:07:56','2021-07-28 14:07:55'),
	('d962c61b95b20805ba06d98c5e9d7827794754a04c9b1d577393e24544fa11e276c05f2b53978289',4,2,NULL,'[]',0,'2021-07-07 10:29:42','2021-07-07 10:29:42','2021-07-12 10:29:42'),
	('d9813d34123e29e76af27b9b04ce5a2a182bef150b06fba5ae191c1cc2a261701ff81598977826b7',54,3,NULL,'[]',0,'2021-06-29 12:14:06','2021-06-29 12:14:06','2021-07-04 12:14:06'),
	('da054fdd2cef081891420064c0f62546be73473afd5ff2fb8b8a44466f30a5c79721c062f14d7888',4,4,NULL,'[]',0,'2021-06-10 11:14:08','2021-06-10 11:14:08','2021-06-15 11:14:08'),
	('da729a0aec8d5d8adc71511e7baf022f4937a32c876c18f80972bd143e094999bdea179c52ee6f59',54,3,NULL,'[]',0,'2021-06-24 11:13:18','2021-06-24 11:13:18','2021-06-29 11:13:18'),
	('daeb5a14de81c845d974f9e8555668325f7453597639a0ca4fa47a6c576357f5144dad565a5a11ae',4,2,NULL,'[]',0,'2021-07-19 17:45:35','2021-07-19 17:45:35','2021-07-24 17:45:35'),
	('dc6d1c1c00f64e45b4537a99162ac8c274542396ead9d6af29b7957aa8b535d5c21a6ae8ddbc459c',4,2,NULL,'[]',0,'2021-06-08 21:51:52','2021-06-08 21:51:52','2021-06-13 21:51:52'),
	('dd7644f565d777ca36a8c9fc708cf63fce20046893a2da588cafc557380da94bb1d0c758520dbbaa',24,4,NULL,'[]',0,'2021-07-14 20:11:28','2021-07-14 20:11:28','2021-07-19 20:11:28'),
	('dd94e03876a6961a4e5fbbf4d331b7f51f93aefdd49d73f82dcfd12ab079e4ae0896d4aae3c3bbe9',4,4,NULL,'[]',0,'2021-06-07 20:13:00','2021-06-07 20:13:00','2021-06-12 20:13:00'),
	('dec2b00d8f3d2b4d8fb23730fc969683fb0117a45b5d97becfbd4787cea95e3879597ae685078618',4,2,NULL,'[]',0,'2021-06-04 11:36:25','2021-06-04 11:36:25','2021-06-09 11:36:25'),
	('e0dadcfe5b39bedcbce847421f4c8bc8bcb46d712bacb5e77a114528ce40426dd04748d3981c367a',4,4,NULL,'[]',0,'2021-06-09 08:10:32','2021-06-09 08:10:32','2021-06-14 08:10:32'),
	('e19dcde5e0936ab67256bfd5162aa2cb11f32d513211c6a6d5d0670cb5774417d7e508fb7db9b151',44,4,NULL,'[]',0,'2021-07-03 20:29:46','2021-07-03 20:29:46','2021-07-08 20:29:46'),
	('e1d93ceb41138e2db4aaf39855db10baf7c7d4ab6631d1c58db1271cbad504f795ed96e4158dfa81',44,4,NULL,'[]',0,'2021-07-18 16:48:41','2021-07-18 16:48:41','2021-07-23 16:48:41'),
	('e31a08701863336633e064d7b8a62c2faebf1954b0d34b72dd9fe0fee569a8956a28a437b54e50fd',4,4,NULL,'[]',0,'2021-07-05 15:18:41','2021-07-05 15:18:41','2021-07-10 15:18:41'),
	('e4951cfa8e1c00e5bdb6c8d92c10c69041a672296d22668388a145fac00f4c9b37c34b681d4ca83c',4,4,NULL,'[]',0,'2021-07-01 06:05:09','2021-07-01 06:05:09','2021-07-06 06:05:09'),
	('e6946c2eef0dacd902b71ca604ce63958de03798c72814db308175726fb33eeab72e48e84bc9b6fc',44,4,NULL,'[]',0,'2021-07-07 19:30:29','2021-07-07 19:30:29','2021-07-12 19:30:29'),
	('e86ea12b21085718f84d8501752cc39922952cd8d0feb6bb221b1df9d1fedf02035a65733a9bfe22',4,2,NULL,'[]',0,'2021-06-24 10:56:04','2021-06-24 10:56:04','2021-06-29 10:56:04'),
	('ea876851a1552d06f0131f01bde31fce3fe873f5ebe0f06df2094c25a26de721f4ef9798dbcc73a3',54,3,NULL,'[]',0,'2021-07-05 09:25:29','2021-07-05 09:25:29','2021-07-10 09:25:28'),
	('ea8e0a77d9146a51879422e6cfb19b9d4fca34ea395421c003971d870990c7f0cd02c1f5402da090',4,4,NULL,'[]',0,'2021-07-07 10:31:15','2021-07-07 10:31:15','2021-07-12 10:31:15'),
	('ebd10e71cd7a632d3dd92777b6e42100d519523d5a49ac6e094737245e9acb179f7c7f1e809e97d5',4,2,NULL,'[]',0,'2021-07-11 20:45:22','2021-07-11 20:45:22','2021-07-16 20:45:22'),
	('ede35f4bfbdbaf2f3f9ac87aa60e573adf1d7d0adc4ea6333c9cad5b1b75743a3bd9bca14d5779a4',54,3,NULL,'[]',0,'2021-07-02 12:12:17','2021-07-02 12:12:17','2021-07-07 12:12:17'),
	('ef09e9ad4bf3e05f2915f310c2c1e3a9fd3d63301da0a1e6f9604070fac2c09fe2da0fb89d2918f6',4,4,NULL,'[]',0,'2021-06-25 11:06:57','2021-06-25 11:06:57','2021-06-30 11:06:57'),
	('ef7d1a6d91d126179890c43c8bf2467b18e1b187a01b452b8a393643b7b6692929bee6cf60d7e8dc',4,2,NULL,'[]',0,'2021-06-22 00:06:53','2021-06-22 00:06:53','2021-06-27 00:06:53'),
	('ef943880d3fd9992fedfdb4ced8dc2e728ad08fb41c53b4f3bde630f81f639c4a397a68d4ff33ef2',14,5,NULL,'[]',0,'2021-06-21 05:48:31','2021-06-21 05:48:31','2021-06-26 05:48:31'),
	('f0e8b1af006ea6b1d0b0e6d32e50af0e9a74bf79249fd2112744afd6254d1796792fd222fa763a2b',4,2,NULL,'[]',0,'2021-07-24 23:13:11','2021-07-24 23:13:11','2021-07-29 23:13:11'),
	('f175570777cf4e2f87015056f8982b701603bb831b7e45ad52595117d24baa0dbed169bc108f68b4',24,3,NULL,'[]',0,'2021-06-25 10:12:52','2021-06-25 10:12:52','2021-06-30 10:12:52'),
	('f2a9e95fc4c7e4693e7857c80c0f2f9c0c5b31e192ba68b8b1265cf6ec68872fa442cc4a04167d5f',4,2,NULL,'[]',0,'2021-07-18 00:23:42','2021-07-18 00:23:42','2021-07-23 00:23:42'),
	('f4376c418a548fba355258f3d314895e0eb6a1b157d4f534ddbee4e7b36f87b402d5a94e8b2ef53c',44,4,NULL,'[]',0,'2021-07-23 14:18:56','2021-07-23 14:18:56','2021-07-28 14:18:56'),
	('f48ad5daa556bb34f5cb13da6e1499d033c07d187fec19a130933ac2d7d11a2c6da73aa2dc65c960',4,2,NULL,'[]',0,'2021-07-07 12:37:20','2021-07-07 12:37:20','2021-07-12 12:37:20'),
	('f58402c0305cc9ee4c09b2b8f2184e6c911e6929907391cad9a2509b3c321b98ebad88b594aef774',44,4,NULL,'[]',0,'2021-07-05 13:21:20','2021-07-05 13:21:20','2021-07-10 13:21:20'),
	('f639c29b9fd5c9558123e2e2f6e7cc01f021596db878d4bdf4a81f3acd2f69f1fe0639df6ea75425',44,4,NULL,'[]',0,'2021-07-01 21:51:31','2021-07-01 21:51:31','2021-07-06 21:51:30'),
	('fa33d637818ba8e90ff0be26fb0b0836187bb1494350ecb8e19727afe1fb7c05a020b8ee4d8e51f2',4,4,NULL,'[]',0,'2021-07-02 21:19:09','2021-07-02 21:19:09','2021-07-07 21:19:09'),
	('fab2f87b36a8a12b16c99a66d4bf9d0ab48dcbef606dcb96e004adb39984d51d8308250bc3601718',24,3,NULL,'[]',0,'2021-06-30 21:38:51','2021-06-30 21:38:51','2021-07-05 21:38:51'),
	('fb6c229b56687e062e78c263d52bc910d5de4648c5f9453c0b7c3946858f69d59ba00a8e39cc270e',44,4,NULL,'[]',0,'2021-06-24 11:11:57','2021-06-24 11:11:57','2021-06-29 11:11:57');

/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_auth_codes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_auth_codes`;

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table oauth_clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_clients`;

CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`)
VALUES
	(1,NULL,'Laravel Personal Access Client','NbxbmKqEv70jOcb2yIVXRQ78MYGTgSTHKPnTzHCU',NULL,'http://localhost',1,0,0,'2021-05-01 12:44:30','2021-05-01 12:44:30'),
	(2,NULL,'Laravel Password Grant Client','OAniIlKCpBOv2oMpKVoRLBau55xLKbz1Qo5YNuee','users','http://localhost',0,1,0,'2021-05-01 12:44:30','2021-05-01 12:44:30'),
	(3,NULL,'Laravel Password Grant Client','fjiWTis9MO1KfJhnR0uVG0UwVL6adxIpp4JbVXdT','admins','http://localhost',0,1,0,'2021-05-01 12:47:10','2021-05-01 12:47:10'),
	(4,NULL,'Laravel Password Grant Client','NVXAR1hE3wGF6cz5lZKdo2rsaafzZ73sGGsBPH7h','facilitators','http://localhost',0,1,0,'2021-05-01 12:47:26','2021-05-01 12:47:26'),
	(5,NULL,'Laravel Password Grant Client','vi8gsfMR9yl4XOJG7tz0AIWN1uF06FpJ1kkxpEvn','organizations','http://localhost',0,1,0,'2021-05-01 14:10:04','2021-05-01 14:10:04');

/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_personal_access_clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_personal_access_clients`;

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table oauth_refresh_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_refresh_tokens`;

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`)
VALUES
	('00fe119a4949c7c93084b3a4e78f5c361ebe2a5952df7ab9de0fb35995507d5c63f74d62bde8941e','b7d9beabff847e0d64e5347dbb2e0081074a61f1a230779230a9a7bcee599c773646af2b671248f7',0,'2022-06-24 10:46:28'),
	('0123dbc0ce1c7272edeed1344a92f9498d3edd0ed61834165efccb83872469b706fda1d1f39997ac','43dd30ed6cd2df4fdf2f53395241f92dbd46600604d0c67ef7697570e40ce0890cfb544415df9f49',0,'2022-07-01 09:38:03'),
	('01a6e6817c0de285e8db572815b526df0dae13243a067719e99fe120ecd8d5686cd83fe5e6d2aee3','097c6c378430a68ffbc041428b4cf494edcf6ccfdc1601513b7f1757e126cfce79b50c606fd98960',0,'2022-06-06 21:55:30'),
	('01e2abd9cf7758a2cf6710fa5d8c1b9c39b6a3ed2dd1faba6901b0e6153692c7ad48a072937b9dcc','778ce5bf19c970a88dad34adfbd56432532217abb8b2664d52cf29106ee294babe4c980f0b7dd33a',0,'2022-06-04 14:31:08'),
	('030bd917bf7577e5a12bd2d25c690c3871772eb3200265f77103759d8788ea4c72b81648068de1b8','93b7fd3ed9684e9dcb93f9282037d435b8eca330a3afde8fe0efc8167992da0010e1774185ce25b9',0,'2022-06-25 13:18:13'),
	('0464d3fadcb67a184b77fdaf8350c7b4ac222732b33b79a41ea42521f266364da9b18f2a213db02c','705965cecd7e938cf743af2e9d2150863dc2cefb17f741da672449c65dd3f008583a66281f13e454',0,'2022-07-12 06:45:58'),
	('06af03fd7d883c0c9da7dba3ce687a26626d370e65d4d44ffb28470644d1f52e595cca24bbf6676b','2f31727ef5d0dd6aca577b89f930abcef1a12269974e540edad801fabf7aa07c82fe93d56d9de165',0,'2022-07-14 22:38:32'),
	('06c494a63a2b1bcc23516401966a07dbcfaf154e13b651bd69379fee9be5e63f07b806d6b63ad9aa','ac326fca7451895f9995d0eb913f7799b5e38737a3fea74bae58675fe8abd2cef1ac7cc22c52f47d',0,'2022-07-11 21:21:24'),
	('07159785a69f20e214b94b3ffdb49a3ecfde45a926f3bd0ab4cc0da783d99ec91a787678dc4ff19b','13f4709d99694bcb375327756a83c54d957e02324281b95497c0754855f90dad8a4ecac4af28852a',0,'2022-06-05 13:50:09'),
	('074a97ecdc8562471df6098f2944168cb2db1b944e0bedbce6f8a46416bb52038a945703e74aab0d','50f51719749d21a3b386af56058fe4b95047ba70267e6fe8bf5b4881db3f7f4256e96f213ccc0184',0,'2022-07-05 15:14:09'),
	('084263bea8e5e506ee0577379f30f7d66639ff313c08bf6028ea1c3148035738d4ce70630ccd9fd7','ca6b3225d7712d5d2f050151e779f53792786d9f6da45fc292a419ff733bfd8a042171fd0176e019',0,'2022-06-13 20:23:06'),
	('0984fa9916e767214b2a566f3c523c3eb7fecc32d44cce4c77be212ac0b5eaeab172937daee87b41','154906026b8bf70ec82f1285b9d4fe42e07c1ab619b6fd4047fe61e2f251f4f8f113a344baa393b3',0,'2022-06-06 20:13:47'),
	('099800b12be8b44eb920c4fd70b0843413911785599654b6ff5ecb41964dddf72c2d74e861e99afe','61969d7d345221b5a815ff92da4cba1a79937f3baa7bffb9838f813b51825f980f435edafa4fdda2',0,'2022-06-11 13:01:14'),
	('09af922e937007aafb39dfc2f2c9a7db1780052b547ddad9044ccc0adcae8ff42d8ec67df8b24106','a409b940ee978e9455e539df202995e818faa840b90f3029f2401f14429790ecc1a5a4d30e012f15',0,'2022-06-07 11:34:23'),
	('0c30cf9196b7e712427499df78afad177546a69e40e4c9c0d0887e7ffdfb69be58cf58afdb0ef787','3f5ae372212e57f10420bc5d24d22fa488669a1672b6472b1cd1384966e308acfbdc39d553085669',0,'2022-07-13 11:21:11'),
	('0d0e4677bec958cfe3a587372f9a0896bb48d9aed30dd7c67070fad38953f325781512c3cabca06c','1d5eda231c87eb65febd3238e28aa83eb2e1f7eaf1a767b63f6cf37a42d79573a5ad460f90d96764',0,'2022-07-08 11:07:26'),
	('0e939b682424137e1f7a5de25db5ef8c68c6a73c779564ddd240047f292f3b44e2b1b7cc93d5e793','968cc23103fba594c2a42989f2e67208aadc2c3abf2cc7f3d1a356f24d9c3ab59221960cf8946cf6',0,'2022-06-11 10:28:54'),
	('0fda0acf15d2ad1f4e561ea6348b177e19a22769f384a8aa3f081c101a271f782bb70203c609b6d9','3234c906d414134b683a54662d3c062f0645f246b1fa8a090a344fad09fab9061f22d35d98374882',0,'2022-06-09 07:23:32'),
	('103b1519a8ca233236abdffea64b0efa42381d6a1175702649990804b1c2c5c2b57114dd6463a274','1e18005481660cccd02cf56db64dfb20eaab8e8091e5b911062021b228b22c0326f3c5b44476957e',0,'2022-07-19 16:05:15'),
	('115057030a2bca4e10ae6907068628073de38d5d62c8320ebb8dc533f96f646e7a554715bf308d1a','bee782a44afe5e80e49ee5dc11cb584c36657a338f74a94f670a65ba8cf18f36717313af3ae776c3',0,'2022-06-25 10:07:29'),
	('12b744d3792dd218870fcb9196326ef6ee685aeb6e1ed6c3b68905180dfd3be025bdeae21ba98a0d','4386e449c71dd137dad9d49ea7c1062269c98fa470c9156dfa135e394bf0ee84754442bc6d37d139',0,'2022-06-29 19:42:47'),
	('134ac9b4f9b7594a3b9b4a300c187c79150c75acd34fb8c54c599f685e4222b2b5f56547189066f7','da729a0aec8d5d8adc71511e7baf022f4937a32c876c18f80972bd143e094999bdea179c52ee6f59',0,'2022-06-24 11:13:18'),
	('142ae75ad9ba39af7f213ffb8e39b3179469916c7d4ba5d3e5d1a24fdbd2be04015d4f396e49c793','34ef16497bdc80de0e4845bc94c508dbf08c30946ce7ad8c8d47d37316a889240f45b7334bf63f67',0,'2022-06-16 20:37:22'),
	('1685d0862dbcea726e3f2156f507969971bcd037886101b258bd9c22761328e93fa6854c784ac240','6e84f098e320b1b0710e11e7f4e9c85d70962beca46b7bcfc176533d74179e36a6e98afebd83c735',0,'2022-07-09 11:07:30'),
	('1696d6b5372b89499f4f3ce7b29ca286dc2a29a62cf441e384ad36e25faff2f909179cccc7c83ca9','003c452bd0b175e72d24127a2ec19e64c87689e7febd191b049e7ed891de4f6cdc20937f86931c6a',0,'2022-06-14 17:22:36'),
	('16b84870f0bd3313e795f81854d008ce92c9950c039b4946c554867900044ef795575c8f7a32a344','384934c09f35926cefc9ac69530ab4cb4e4485878219de7945a3d39e74a203559eb9ceada6ec3c34',0,'2022-07-12 15:02:51'),
	('184b7d9d7aeaca439c1556b027ab210c01e0e5bcb849fc4e4f81b69c6765f41e9634438b3c4928e7','d3b05d98d6148b89b35f9cac115fe599d391a4779bd2cb261ef08c5cb028ba3dbb8057c06e5213a4',0,'2022-06-17 13:31:10'),
	('184dfb3bb09c4d1b05653d08bb5cab1b31c4fcf847ec6d63c8bfe46bd48b90f0ee47b4c1aa78473b','6bbfc14702d9fb5d16fedeaa940c0a5aca7c69b343e2b8e61560bb51be0c6f47dc0665a92febf12e',0,'2022-06-09 07:20:41'),
	('1895633538fab2187fa378882fb0268d03f46e31445ca805160d7eba785d6e5d59e0c7ad4282bb02','baf7e07448cca23146433d7aeff85568f15084477ccea0e6ea935bda5ad056aaaa6025a54cacb4f9',0,'2022-06-29 12:17:56'),
	('19ab07f4387c4077ca3526e08f8108283c12da5c74c6421b2c795fe4921df015c21bacf3e0b45281','5508265d9991690f5293ea02dd4db93d14328f099aed786fa45228e23e14c866986a6e642f721f5c',0,'2022-07-02 08:51:24'),
	('1b31a1e3c440cb0b3e81060e3d20993ce584369dcfce8d503a9d31adda68ca8e17c515e5ac2c9ed1','aa4d9f53bbed1f0b37733942214a9e25377da41b686b6122a3073a64d4631a034fe104a02cdffe7a',0,'2022-07-08 01:56:44'),
	('1bad30827d50dc647146a045deede154bab778341757c4f494d0ed63f8fc10f151ea87ef4bca028f','99690f37de7d67ae50773299dffcad7b111ab5475a089ff5fcc359a1edfa99cb0ca791fd36a7b4b6',0,'2022-07-21 00:11:13'),
	('1bd014832743b4eb4b1435a774396fe0108c7d957d35fd372bc8140c347f03406bcc631defc02729','69d13ce9058ae326be5891303ba9d8ec3a0cdca0f63b05012bdb96eca1ef9ea18811521dcbd9cb4f',0,'2022-06-04 12:19:34'),
	('1f5fa48156d366aa911e0394c1e568c1d4e31920eff3e73077f97bd918e37d320d364a34527ed7c4','4c788d8f157db71a2375c01fba99988f82b255fb453b2e06ffda18aa733790fefd54851655246b93',0,'2022-07-21 00:17:12'),
	('2052023e3c5c19b8f1d398ccec062e36380b4386a840df1809d8d05d15451d6e3bdb77f7f17c1b07','3a52486d037eac2f970dd2092778d952c2a265a367589c7ac6ccfdee9cac6521b693672f07e14e03',0,'2022-07-15 19:38:00'),
	('213c166389d70445789da038ff511bed6e361d0330ae4abfdf2d1938e7312c9f5139401cc4f73b16','1a7d2bfc9627ebc44594ee88d36aad5e467e94ee579e8162cf05d10631daa57664a8048c1a684e29',0,'2022-06-24 20:32:34'),
	('2147cf5f8505c85b3dd98a1a6ddb0cbcf2d9a430a5030519b85c1593960567fc3891c02e1b0467e1','6316db0d4cfab4c5aa3c988853614867225df76c29b558b025f9a65bd124952a2b1c54be65942c60',0,'2022-06-24 19:40:28'),
	('245c7b82c79f26f1830606aeecb1984235c9ec34ecc83852e0263c05faf7e5212e4cfd3e36affaa9','8d98e29a57fcfaaf76fef73969a2a6dd4d3916f0f909b8942919c8c7aa9314bc3371b17b598aaeb2',0,'2022-06-20 21:02:05'),
	('24a739f50c343a973600ff584152f5cd9e1e6a04be83d78bac4a114057d483326e9d4ef85f162111','06b0802850fb2fb2081d74a28c8efa6fff371fe020519803b802aec56e6804719d748a92914f0121',0,'2022-06-25 11:39:54'),
	('24ef4bb3422658c93005dddf7eb1279544520d6775e866da2125409a526d47007e0e076f893ffc99','061ce85fc2506e99d994bac7e6a16cbfaa9ea91b2d9b99d12577d236cc94cffb926f63f37a664a74',0,'2022-07-12 22:17:40'),
	('256aa9939874e55df9717cd57209f63f5131a23405f5ef3e53218e0ed87ff48c663843ae9fbb4181','ebd10e71cd7a632d3dd92777b6e42100d519523d5a49ac6e094737245e9acb179f7c7f1e809e97d5',0,'2022-07-11 20:45:22'),
	('261b87aa46d9e69e2c0b7b21e14c88495c57c96f8712f749d31bfed82c084ebdb41ea95895d9bdf5','32575328f12b5bc0f74744f3d32d926d13b1b77e44cf029d465fca6d9c7155348760f2f7e25eb096',0,'2022-06-30 00:26:58'),
	('26a106a2190ccdff86b29b08168f1decffef6208d0097ed2551e3a260e4afa67f4115be96f6522b7','54683abbc90155e6f96d1d57aeda88ca797d035de03be1fbf8c4493f7ff27b54f6bb130948e512e8',0,'2022-06-23 06:08:45'),
	('273f3131c6d8f5020b5457c45fe30192e7de3c7bbf7cd8faee08244259bb7e18e1d0b6517d557433','2154a1c47c473d6267ad9c5c207e9a95d11eac4f674759a1647504be8578338e3e7be5ba877c4341',0,'2022-06-24 10:33:45'),
	('275ae2b91d3c5e904894613d7d1fb05e71ec3c2f3b1363f486288cd2c6ffdf4dcbd8c462eac8afc1','206f451fb834ec96a08b1eebfb81ac84875795dba83642a34933bb9ad90416d49d9f580125a86d33',0,'2022-07-25 12:12:51'),
	('28ba0f46d89eb5523dc144540fc6e5402a7284b1778b459f171d1034afc681ce3bc1d1df2e33ea8d','799dbb0190ebcb8e963bf913387621d275fab8522b20b5a2fa19b222aa29c61b3394acb7003d2ae4',0,'2022-07-01 09:35:49'),
	('2c24d42f687513023de09891c467a66ae5357654a2f18e2873e5bc2785b56853dd7abfc0090aa531','611e29f031d98640507fd6c8b56944ca68ac835fb642528479d3989519c38209e5ea584e2868988e',0,'2022-07-01 09:37:48'),
	('2c3433d8d9e2e96294a0b046048b9d649b5f1028e6f436ca54cd901a931316221052b5eccd18913f','9ff10e7495c636a6fccc66a06f7ac5f16855f3c252da39ffda6fca3a401c5ff4c404edaa6eddaadb',0,'2022-06-30 17:01:44'),
	('2c54d89a473f51c3b1104ec5034a1a9dae64842942e931fca896026023caa3676b8ac4ccee10af97','cd6c546d78d7e0aaf4f0dea03562ab2f5cfa8b66cdd3dca3fed121952db416a0370e825ea4b3a08f',0,'2022-06-11 06:47:40'),
	('2cfeea6ad1f7fdea6c0ca152c23991b0cdcd268a087cdc20d0c4769e99c00ac292f72a370e7c6b76','662762a4d3a853d875102bec3cf7594f04bac5867ae4961776164c19787dede116428af1154cff0b',0,'2022-07-20 05:50:01'),
	('2ddcd25fb7903e0ff0c784b40e428f79ff1bc9fcb95adc04911194bb0628d1c36ec5e1ec42775d23','a5ed54c7ad9e9c802e043b2571e37555c1397ce785e7cd611e8cb207291483adbe133b099694e07a',0,'2022-06-07 12:34:26'),
	('2e4c3e5d408f1ac6b9d22d33692446df2e9f72ca54042578a40d946dd67fdbb5255759969fa38885','c2d87f8d09c3d45b4813edcfb9591d0c40d832556c6f8c00fad307a0e65edbfd5c6ec5586e89d3ef',0,'2022-06-17 12:43:42'),
	('2e7032250a2b8da9208e417b9fda73b39ff4c2cebe6c9465d2b7ddb9dbf5c8e7a924f313d907ca29','6f5f574cc2208d6c63c89cfdd43f99e66eecfb4a04ab46bae3b81dc157de2825dfefedd081eb23cb',0,'2022-07-02 08:49:13'),
	('2ec2d6cd8031bd558f833210a9cf5904168312f32f14fa9d392aa5310c757d6503b7c8b94eaa263e','b523db406f2bee73432112c47e91876887d1fde341b932def13bb80a3b3abbf41efb9f69a52d4445',0,'2022-07-07 16:55:41'),
	('2f7bf183d523a5e60048e0557674be994483b141213a7fd320b90e794b83775a02d95c6956d715e8','7bbd9ee987d6c7abdd5c17232a5b447fce18c751daa6cb92638d20e20908c326e8d612ff42777f85',0,'2022-07-26 09:23:33'),
	('309410ee4693f2459324e5712ff5051e7c0b8f82ab4807bf0ab81239cc2e472be26d113f504a8b06','7597e7e048969fcc7a61f8ca9257ffba1f31c9fdbe75542d24fbed606e5dfc5d72f74b28610df11b',0,'2022-06-22 10:44:41'),
	('30e73490906d3acbe0e72175c560ebe0e7bdab36b11bccdba5c057b6c647ed0a65f6025754822651','c56bdfdc2fb1b466069267865b4753152bd14185a1156e107d1efb50af8aadd911b0cae06418611b',0,'2022-07-19 09:52:44'),
	('337db81fdb95605b63cf3d613ca7ffd88a3fe3267a698a1f346244b71285866fac9a23ee746d9c69','9cb2c4d1953763c23aeac80dd347e31b9c6aefee03233d4983469409644553b28f1e72f0e34b147a',0,'2022-07-18 18:19:00'),
	('34eacfef54f94cdefffe4ae022e308b1afb58c4530952261bd0f89de7fa44ea4518339afc520a449','72e8abe90a53dca350a6a609f7d760b988c4db15ff16f5fe0b70a71c78d5e3f80568a1112eb4f5ba',0,'2022-07-07 11:43:38'),
	('354a3b8e8948122a687ecf078c09fa115b7823b8747eabc8ae37d3589794e836b90236e35ecabe0d','b02acb06b27e35e7b5fd5c8b3296055924b667116a40d6836d808a2d5dce73f29b3bcc237db5a97d',0,'2022-06-04 20:37:24'),
	('3764e34d26b373c89f8981e81c1c5e51fef17e6323632f51c1a74ad901637db3281de982445f6328','4719f40cbcf0808fed002caff257ea146276160fcf655f7771114d56a36015a9e8b8b6a67dd6ec8f',0,'2022-06-25 10:34:33'),
	('37cff1eab76a0dae2bd9f08ef6c4b0c0652ebed15f3af683ba3217bfd818ecc4affa6c4beb4dab55','4d65b2d22da9a715be1b8febc5be11865e57e67dddd06b58fb8448593b68e74d00843fcfde7734a1',0,'2022-06-11 06:37:04'),
	('38831e87229cf451c09849433d2af45f35335771095835e36b80f6fdf1991921999cca26e0002bcc','3560193e4839e0a2ffce52eb2e196c19731ab6d0c31439beaf983195ec236eb9e4ae656d91f5f8ed',0,'2022-06-20 21:03:40'),
	('3932a6db487c6357230f1246bd4891f4e45029840d6c8dc93de5066bc5fd65655d92bd4d0c4f1841','8580fdd8a33fdb5bdc9160daa75f288f0ebb27a59120ff803c5e8d9df21d03b9b95f2dcff81df815',0,'2022-06-25 09:51:48'),
	('394849e764f93e65d8c24f950a607b897e40988bb68facbc383622b587fe26df0b17c50a92b8ba79','dd7644f565d777ca36a8c9fc708cf63fce20046893a2da588cafc557380da94bb1d0c758520dbbaa',0,'2022-07-14 20:11:28'),
	('3a1f52da9b2a02708b487fb104cafc83fdcc23a15c1d7d053c8df39b932601325d6225033697e5db','913da867482783c3c5d5deb5fadc7b22ea4ff1b12d83c32b0b40800a5b2b110d41ebe592373b04f0',0,'2022-07-08 11:15:26'),
	('3a2a2bc94eeb81817253e36e91c246dc194cfc001332bc5ad871aca6617d3a334a718f333687429f','21e94ce1542a2a8ce3bccf64ec5eee6722c285ba75c0bbef98e606ab049329e5945a7db0a7bf4768',0,'2022-07-07 16:54:20'),
	('3b56cd082923852fdb95225ce52bdc87ae30ba97b13a68aeac94aa43f54d436db304974c10fd77eb','0399f39e03553a77e188197416edc4bd55d10bbc8ff3784a66cff06f0dda7ab794779d5cedf41808',0,'2022-07-07 11:40:08'),
	('3b6321298071a81cc740989a0c775146a42fccf7c769789e8cfd1cbd6db0cbedcade2fc429fa8528','805b986cfdf9ca22f1207d26adb9a3426bda0354bb7098b9d56d307010074012b36fa4a79ea1a720',0,'2022-07-07 16:52:30'),
	('3ce99f73f1448005d35fdec756577a932f0f1c1c2a894f63ff227e4fc36ec7bfbac7e8565f4d2ea0','a57847cce7a9640a5be6391f79b8719a298593182b186d3fa83553520e3d6975ca3f8760479fde84',0,'2022-06-23 19:28:58'),
	('3cec7dcd95847a7d32bef99d1977b7ccaf4ef91a983aad9eb1120f8660abaeac98dabc585317fbb2','41ff7e66b812d79bb132ce91ded86c65b007128bfe03c0dee38dbefd28430d0289fe1e5386a5fea9',0,'2022-07-19 01:47:44'),
	('3d10bd20cfa569da262ffa077afeba1de9b0895088f574a0479c4bcf3ece6eb6d51c3c92be43144d','0ae895978eb420d3846ee63fc84f8faa50cfde753d98057249dcc235c539f72271a4c97e21e82d34',0,'2022-06-21 11:14:27'),
	('3d72575b4f6b83ad21a9dd66eaa37f9bb27497b567570ade7dca10e77f6ec3ba9a46d2d9f09f485e','257578a971e900dcd115f37bbd22e06a57b79380e39369527e3574e037f8fb9be3c219d4c3405993',0,'2022-07-01 21:49:06'),
	('3e9720a372fe4be788cf7f4f0b5b7b79732df74a6abaf5d182825977d29d46c9a5c3c1b15a25c7a0','dd94e03876a6961a4e5fbbf4d331b7f51f93aefdd49d73f82dcfd12ab079e4ae0896d4aae3c3bbe9',0,'2022-06-07 20:13:00'),
	('3ea3434e47aa29d5855dbc0c57eee5088dba13beaceeec8f58322f03d8507099c6dc49ff99a10988','f2a9e95fc4c7e4693e7857c80c0f2f9c0c5b31e192ba68b8b1265cf6ec68872fa442cc4a04167d5f',0,'2022-07-18 00:23:42'),
	('3ec8a290e337d79352e13501eccdc8a5f5d40fcc4fde405a195e4207b5b3e97883f84a59a6d3e031','0acce50c8f35101dfb3d7f8c41e11a4e3da98acf70996316f03dbd5da699c6690fda401bd1c23abe',0,'2022-06-10 17:17:41'),
	('4042247e2c0be091d5b0057ec0b28ee1f396f926ab391d551c9d2de99e82977875183762f2a03084','fa33d637818ba8e90ff0be26fb0b0836187bb1494350ecb8e19727afe1fb7c05a020b8ee4d8e51f2',0,'2022-07-02 21:19:09'),
	('4078cd32cc252da3d7501cbd7029406001fa747033f5049af43087da7493fbd6db375ec25c74a1da','d3ba1dddaf3f368164d7c50cd2926747852b99ecfdf6e740df8dd023b42de2d95150d1200d2dc01a',0,'2022-06-29 07:07:54'),
	('41302c2fcf98f7cbb784db4e7ff86b69673860a7221e76d7831638a90d6013cac2f46855df2c0aba','bf255950c63d5d06ab84dcb10e85c0b7a93f21a0d86f6f04ee15cbe55d773189314f6a2377455569',0,'2022-06-30 16:34:19'),
	('424b7aac29befe4066f9c33fa60a9517a21521d14532d411c16237f0109131ff268318cc1a5faab9','c19fb774363c6cc405ed43754ce7e210c3e98276fc3773f512298e67d327205768df2f46f57b0103',0,'2022-06-12 09:29:07'),
	('4309177bd012c450aa398f924f1b6fa8e8d06a87aa9391c54367f36c1e27b3569b621fbc39468938','9873c8d7b539376a3798ed2d9e375ff995b975f1b0a7c21bca92d8e1e439491057ce539035ae9850',0,'2022-07-09 10:38:34'),
	('45facff0ddd2949183b6cec43309cd237d97f9db6973a28a10b60085fadb3ee100e02a95135a9754','2006f1144bfe3f1c1e489e2afdb218a5049675c455ecb837b5c9b30770d04bf7259b7406c3fcc981',0,'2022-06-12 14:41:22'),
	('47cb3444d858db634d36e589dd8f15e737e162410e4db46cb27da0d0040b4ee60c8f0078e1a2cad2','b26c3a9d5410cdcfc106d1e52a86a108bf4babee7a309e06978f43ce5efd7f25d359028e0cc7857c',0,'2022-07-07 11:42:48'),
	('481f2b72b33825e657fc33fc80edf7b2aec5bb6d8ef97114898dc0b2ff88b8ec618233c3c01bf7e2','443f142cd9b7009343f72067e273ba20e340da7eec728df6e87bc04cece29f91cdb97ac7713f3c34',0,'2022-07-07 19:28:25'),
	('49605bbb391bd9b7bc61b13033a4b3c9003aa207bfb56c20f17473a91def32b059afb6f9b3baa33a','fab2f87b36a8a12b16c99a66d4bf9d0ab48dcbef606dcb96e004adb39984d51d8308250bc3601718',0,'2022-06-30 21:38:51'),
	('4c3b13bb99b0095252d9dc1e761cbb3cd0f267ab99fb1bd006a07c196eb9cd4057f80d29eeb9da4c','8881d46884badb13c08599b6c8c5cd7cb8735da1e64ef49136ae57608e34ce74d36a846ac0bcc4c3',0,'2022-07-15 08:15:02'),
	('4c448787ecb235d4d36774b24c7333c0f7e17828fad1c4fdf67f3967fc570185a329de1eed2674a3','9db146cdd8b6554281211b7b8ed0e6c52bcc07b27773d4f98181cc7272ecd508f4b59e6c7f9abc36',0,'2022-07-26 09:29:32'),
	('4d38f2bd5d22a52fd8684e26a1bdae24e0c1f310313832aa2415afb4077e20e0c69617b4d4bf5be6','e6946c2eef0dacd902b71ca604ce63958de03798c72814db308175726fb33eeab72e48e84bc9b6fc',0,'2022-07-07 19:30:29'),
	('508a218b1a8e9c752da0b6292a1f0ebafa68eaffa36457357ffd61d2c3bce7e633ee5633c2ccde14','911103962b01fdcca9969cdc95e442e0fafb01ed53a94f5217af09ca953bdfe0ea2c8b68dcbd60e4',0,'2022-06-21 11:33:27'),
	('51dd4056167468aa3eb30c0df351f4b8ec9932295d7744342f07c028aa528a0b1bf5efcd55312c1b','ea876851a1552d06f0131f01bde31fce3fe873f5ebe0f06df2094c25a26de721f4ef9798dbcc73a3',0,'2022-07-05 09:25:30'),
	('52bce652d9ae85cebc454c3bb19e92cf2e7d54ae898ef13ea3f8fb159c1d10acfa3b18837ffee602','c3e58f72413d04a47818e2a76a43948b2f1685c8ea8d833158193ef59aa0b9e370e393094f0cb2c0',0,'2022-07-19 16:13:23'),
	('533d22c4c2eeb12f4b986cab4e06db98db005c840df70d0ac592540f6fa3b7e040cd5ea8ece307bc','3bf8f045076dda36548ac22e21836eb9ee883be6b3ce8c4b50d57ccbcb3b414351c48e6bdff7d50f',0,'2022-07-08 11:41:21'),
	('539625edc92d9401dccdb091261432b76f7d6655091c5241c75704a08908d96f3eb9abe4a792126a','b3589cd62e309157afacef4fb79fea8853d8ba400a10403062619dc099ac69e00847612885788f32',0,'2022-07-19 17:44:00'),
	('5396b8ac74e30bf547ed677c64261f8c75e421097fd70e91bd59e66d79210f963806393c138a83a5','e0dadcfe5b39bedcbce847421f4c8bc8bcb46d712bacb5e77a114528ce40426dd04748d3981c367a',0,'2022-06-09 08:10:32'),
	('546e3679211dab09c74ccd7b6710b59b3e81a1b790fd95b07291ca84bb9090f1b12489013b83175e','6ce8a2c8e88010611dc6c675030a88aa655f233fc9ab008fc6117e44a33b027303381223dd986c20',0,'2022-06-28 08:38:48'),
	('548476964c70ccd65d1e09ed51c74c94fd8e6e4e61525bfab5a1565216bcb2db7a4a66c71d6a3e74','fb6c229b56687e062e78c263d52bc910d5de4648c5f9453c0b7c3946858f69d59ba00a8e39cc270e',0,'2022-06-24 11:11:57'),
	('54ce971b00fc685d1498a4c195ebbc8ec66d537af52aab7feafb9928efae422b6ff5db615e45da00','872cc6640b3d17fcf2c379ebe45ca122ab2a0879cdeeeed03ad210a1948a4bd95028a416749973f9',0,'2022-07-15 08:11:23'),
	('55b026619a0cdac55cec9b745b2047e8b50cb21092eb61f1708cb198bbab7d5cd3dbdd02d7a78641','0953db963e358bb79746318e100105405a129ea5c221cda636c42e80797cf6227710701b0c9cf4b1',0,'2022-07-07 10:03:07'),
	('56b33619b430143d6b7a93d7f35c5777f979f4110df72732bf2c72af62150c61e7b0ba35b173eadb','c286c4abb1c07a93116cd403c24f5bccf702e4c2e3f6932ad28cb7ec013d61d259ba5624cfb5a364',0,'2022-07-24 23:16:03'),
	('56b84423b885ee1ae95a058433bfafd2ed3cfe8f2c80589c0d73f36b9b835d2f8340dec88dbac0ce','0066b33d3c4e2360e2286117b46ab6fba4efefddc279cc988c02004fa6ebf8b062e001ca3dadb84d',0,'2022-07-04 22:05:52'),
	('56e030343b95d994cf88871384ad36b554ae438e79716784745cd45b80fe7e57ee4a46f5864c940d','7bdf217e6a332add93817acdd6236979a2fa8e496b049bf009967f968e804dedb337065924630676',0,'2022-07-12 13:51:15'),
	('56ecf46e0507b2b2219988e198f39e1260e21180ba4ab6721fe7921f219242897eba485fc1f73931','12bff48a0a1ce930fac60a2a78cc61ed2c67bba584e3ff178e04f3624251a9b600022a6cbc7e0d23',0,'2022-07-18 11:30:57'),
	('59fd866178a449a8a07fd3468a511f38ea8fd884c1ae0ecae5f714f2751d9651391c8d35120d8be9','d13d88df2302bded3efe440985162b90011aba909ed42756cd5e6090d170fe0d1efe7d7614104154',0,'2022-06-28 00:19:52'),
	('5a98e73cab1d3621f7c3d75a9cd767cebbe8c6ae1bd0751b9abc66d58f3fbc0e8fad70a66401cfb6','332a3566b8eeccde2269f40eba3edd3d8b686e2d13ce256c739585a475fc4010ea65ba6e0ede6e01',0,'2022-06-22 10:27:01'),
	('5aee3800fa573417fd2d74bb8c7e3e5db1b65f792e6aeccf3953740f0990e1ce92fa958b39e3fb85','0a70ddeca389b7a723f684ab1fd411680f39bd41ef14aa44c91c6a8c7b4a55725e80471430d21c0c',0,'2022-07-01 09:36:48'),
	('5af64665c399727b5bb107aa99b1346ed06ddaae8756336f9fe593cf21672d60c103b1a520f5e945','b3ed2392e79584aadf1a0e4af8d0f53bb9aaa1abd38a29db1701d148a7ecf4855bc8b86a11c34892',0,'2022-07-15 08:33:34'),
	('5be72d1888297b0e979cb50d9c5213c2a07d4786ae6980838fac368861e0ac8a2defccc086c64b9f','3032b99279029d410ec3ebcf68382a8943da64fca83bdf028d7755860d60e06dedbc23159cb4199a',0,'2022-06-24 10:51:12'),
	('5c1ab554df550e1b83a9bf9f54f83c584f8483109ab198d486f3a40c3ca0669731568793e546dd37','b3c168787e60f25700ad0008773b4b8be7e3d8614d67cb263010b0ea85c2c829864c339dee89870b',0,'2022-07-20 12:19:03'),
	('5df00c078af473d1fe30cec0d65701ba8f6eaedb1e858de5c66ab547fe9a4bcca8ece8f0981470a5','5d79c638d17ad272c3b4a2f1f7197ab1185a7171b8a55c3c81217c277cf712b8cf4c648cf330ff4a',0,'2022-06-10 12:11:55'),
	('5fcf66cd9dac99e8f1dd800c3b5224bbe11691fb9d55a6664f11bbcba62a61cec4bba45e15abf679','dec2b00d8f3d2b4d8fb23730fc969683fb0117a45b5d97becfbd4787cea95e3879597ae685078618',0,'2022-06-04 11:36:25'),
	('610a2c0392ab42037dd90a0bde7ae4189e939d209917c17f8773c5285dc89848a91a7f0470de2c58','02e7e8847119e122401a445a247894a90965a9ec54fe0f09dcaf5cdf1a665b9ed3c9792c5b1defb8',0,'2022-06-25 09:59:45'),
	('6188e00039bb19ee5ffb7643b2b7e25eaee6789714e478c97519152805f2a9effc96f3c4058008c0','0775a83c47b4031680adf7a148cdc282f7bfe1ce5c473c09831f09eb7e337630f6c90b6048342dbf',0,'2022-07-23 14:13:33'),
	('624b22c4e52bbe751a2c67e3408b9d5b5556627e635076437e3db35648199bf909c663b9722534b9','941181c5fcf958e597b86c13b322c66670c32708f82ecc5653c67c8b7f19b9ceac211ed8c3f17539',0,'2022-06-24 10:58:28'),
	('631c3fff437b8e1a76762c9878f817c66069eaa05e9b977d6f11d77b0951ccc5d24759c9995491d8','dc6d1c1c00f64e45b4537a99162ac8c274542396ead9d6af29b7957aa8b535d5c21a6ae8ddbc459c',0,'2022-06-08 21:51:52'),
	('631c652d3be7cd6094441f64185f36e6c50099f7068ed57e7b4d9ec5828955761f1d79f6e3e6db3e','09aa53ef0ec644cf749571be9bd7d1560e6c6e164a8c095667699b11dc036be85e7a06419a3ba034',0,'2022-07-19 07:56:13'),
	('64b24bb5e9608d3d728d1814357d13ba97aec622c06d5e301d56e13d5f1b24533059bfe261e8b9c7','82f80ba821f03ff08eb07ba7c588642d8ac3f398cd9369a9ad0b6e1e913a05245dc9616fe9baafc1',0,'2022-07-20 12:57:51'),
	('65010d52195b2562d9e8026ea6ea1764763d0afbf07b1490249251971a90ca0677faaa0d9044eba8','011ed244ed96cd95f7662a9823cf1ffadd73505c47d889f76c9864bb34bd6ebdc046ca3564021cc4',0,'2022-07-07 12:34:51'),
	('6569cc87e3210f47d10e10d793243349c9517dc050b76c9f8fef1d5275aa5d7b09ef2fd616146f5d','120be6f8c2f1aba64b687374e74213d5b23ed07a0efe37aaf38e4acfb236d3c62a4c2fa4d0ced1c9',0,'2022-07-04 19:49:07'),
	('657664c4ab15b53011f7140931935b15a7de911b261bfcd9e7a91246a137de8d9f52949d651e7d39','34f15e4e6a514963b45eadcc7e1e7e64e45e3b1620fb4ba75c1b0ff247f1903f4cf9718d303fcf69',0,'2022-07-11 22:47:16'),
	('660eec311284a1e6b7fa689c0658769c2f02c20b401a159ac6bd7c3ec45dc4f3c7d312a7d7dd2f3f','7894718b95854f6b8dcd42aa08e49f1280af24ecd4de9e3df5b500bc0126c370dc97d8ccebe03ed3',0,'2022-06-10 17:16:29'),
	('66d5334ebe54e9b7044a9e859e3d6f9ecfcd12d0e4f573c5142f62181dba0ca5e94ad4f831f7bff2','b8eb80b079687439e4dc6fd538449871989fb3b65406211a6d3ff7fe49fbc99daf39af9215cf23bc',0,'2022-07-06 10:55:39'),
	('6803d67b091596d3a6216bcafcabdb468cc27aff7c4195502c101c678217344239182d2a4adad468','ef943880d3fd9992fedfdb4ced8dc2e728ad08fb41c53b4f3bde630f81f639c4a397a68d4ff33ef2',0,'2022-06-21 05:48:31'),
	('69632006da2455473f80e24f6cdc4890826194d6e2546bf8409a1c9f25a49dd80057695328d396b2','f639c29b9fd5c9558123e2e2f6e7cc01f021596db878d4bdf4a81f3acd2f69f1fe0639df6ea75425',0,'2022-07-01 21:51:31'),
	('69768120efa1ecb6e4f157e3fdf94773c046b1afb23283bb0bef6cec0fded6cacb3ae530a76575a9','6251f683f15c59b8632c6d0da9d69150d8c23e173c37e400f33b55c485b80d28e765fd40699d4897',0,'2022-06-29 11:05:16'),
	('697e406870d476b79bcd504b4a0e972a17b3f70e7c7d2d1d63dbbd0e07e6cf1c8c5fe0500a05f691','5bc0e2b998071d606f989e5aba2d45c66d3dd01dbd1e0bc1513960a7d5c18217bdd08a9feaaf0fa3',0,'2022-06-03 16:40:07'),
	('6b98b57c3a90401337434f5de72549fde957d6cf32b8f9eafaf5c750adf6c24ea9291781e21fe2a7','b950d716c7c618bd367e465a080d9f60811b1085e47bca0bd4903aaed5410aa5a9faec7898b8fce1',0,'2022-07-05 13:17:29'),
	('6bf744829b0936c348f0e4bc0ab029d3cab613f01a3e3638d147c90594b016b3485473f23b74b379','d962c61b95b20805ba06d98c5e9d7827794754a04c9b1d577393e24544fa11e276c05f2b53978289',0,'2022-07-07 10:29:42'),
	('6c82538f7cf3028479462d8c88adcf84e95eaa40bf3aa03c14275f37cc4c85167eed0ea11d3b6727','d91586c3d3d05773ae868d307d7257d96440c8e26062e79d607bee3d2456da4b755c314d2c313b03',0,'2022-06-07 10:52:54'),
	('6eb0b77c093eea927ba51fd551f5a3273a6b0fd49df897b037cad288700e8203f4b6303e5c65cb69','763a0df917b5dbee3c150c3092f54e3d024e050107c0808bf6a4b5a19e9fb04043607c0c6bd90690',0,'2022-07-09 22:59:44'),
	('6ee67362bab91b20337414faced30b93c3771814edafbdbf491980962e801ef1c01b4a7ded1b6862','67d2efa0cb649d7b44dec70cd7168526efd9e0a56e758bd59fec4ac8fb97c462a66e6e21825f60a7',0,'2022-06-15 07:03:12'),
	('71ce4ce04f1ac9795ea97478e4eb34decff4313cdd8d6fd97616d997850384c50088ad8779670fef','2f0d2dfaa602017a75b5c3ffe5b3fb05349b359175b45c35a35c93e7389ca82186e319686127dd58',0,'2022-06-25 11:17:27'),
	('73031e0a4427199a23a1ac9bca5f03fffb149379e491fb8f8b5d1f9bf23cffcd98f123ac35603575','89bfb10da5f64be950ae150a54a558cb142d3e43c039ad114df4eca083f00f1a95c1b586285b5cdc',0,'2022-07-01 10:06:43'),
	('73fa7cc530bb4c7d56fc167942b9f008e57a0a553a96c436461564d247c1b4dc01edaf91acd7139d','8021956f75d7091bf88a04ad557e30f48636fc1fe6ff17d229324210a37e7b9111e61ca952c8d3a6',0,'2022-07-19 01:47:57'),
	('75193fa15e19419343a63536c2672ebc5b206db230cbb4d665a41b17a655b137ca38da435b16ccd2','1688ea87020e4152a8b25a6274eb98dd86d92475ed171fc60a661a29a2cb8ba1b49e4d3f0b4aaaa5',0,'2022-06-07 12:41:56'),
	('75fcd9f91da73c2ebaae7d269c796d920934a2fd478974e035210dbd92fc20a37773d438cab749ff','724e520941464006b1aaa1340e1bb81a0a66b29c6f99e9101907aade5d750fea7f3ba01b5d117b5a',0,'2022-06-09 15:23:04'),
	('7624d51e8c5367e63ec1a08fc0ac657b22e7c443282a6b86c736f6671ed4d18103a5ebb69627bec9','22398eacd31869180ef98379ee5771c03b3e2593de277bd8f429db82e0874496993d392dced59e10',0,'2022-06-20 21:03:13'),
	('76f9aed3d46393afbe0d04aeec25d793380e27e810a7edb4f89f9fc3418fa04519a77cab6b880079','85afa983d2baf6514af7380bceebf95a89190f4234ea0a050e2cc5acaec30f7e27857e165a15c790',0,'2022-06-29 11:09:52'),
	('77cdf7749195282e753b71b09c296d92f893850474aa43ec16c956b433c39ddddca58543ca96092f','046c4da8dce6786ed9b755cfd1d11d882f12b10d252cd0c521d0b51d97bf8ec8473ed837aca08adb',0,'2022-07-01 09:32:08'),
	('7886fb34dea43c4a932a3888fd2ab44f6e690c3b4c55f1eff85996901045ca4efd6828bb5c0d72c5','30dfa971969dd1b522470d5ef21f855465a3cae3be313883224aeae63288e227416c25d6e7286aff',0,'2022-06-29 12:34:42'),
	('78b9144f68bd3e59e5865a85341acbc1289eddbba67d076c085a627b7a2b107015a02d7ebbde115b','16b86db19c07be92e99507361e8f54e1c813fdb961087b7cdd3ac06c3a93d2b7fceb325c9ba0f2b5',0,'2022-07-08 16:16:40'),
	('7bc3b3a042390ca6d463b8bdfe99379fa5ac9365332131b83ee31259d0908f6c2e1f9d210f6a3835','b431bfbbbaf84587255db6379e2b74feed2af6d33f65fb7bbadea3724fe2f50ce45b22938ed6c39c',0,'2022-07-08 16:35:52'),
	('7bfddb7ad75b25fe6f5c799c3da334ba263a9ec04eb146bc6815edaaa53d80b135f40ae941db5bc6','d341ac25e7a9d8e538e66a262c909686c033ada87d71f5022fa4eb2c1b989e51253ec87a292bf197',0,'2022-07-01 05:59:47'),
	('7cbc080213a9039d936cc2933f15d4fcde938960852b72787e0ef5a0b75765fd98913d13560706e8','ac863544b4bdad3e2fd2a95b08d1ed4e35afc4655068654f10a32bf75ef6144b5ea6ebe70cb5fa8b',0,'2022-07-25 19:51:18'),
	('812ab591601b172e85de583d50747fbef3aed2650d5e5f6e8cb8df3ebbe6762b2d5f3a519c3b4809','527819ee4f465391855a827ae1b42071b84a1a82845af181ee22864cc4dcc20e22d8bfcde215a43b',0,'2022-06-23 19:38:29'),
	('819004f904bee920aa8abfdc4797718a652b14316ffaf5a003bfa47f38b14b2048887d12011098aa','4730cce28b12cb6abb3275c312ca87e3481c3b402afde7dc7bc2977d57cb8ec094b9fc76cf8bd1a3',0,'2022-06-21 11:13:47'),
	('82c4780cdcafb1cd4f42aff34242b71361cdf2ab0fa545f44f202238a0edda01154db51bc4b0f339','74f1fb29e6656831f880c1d56d7a290792a25c4b7f0d532f7169a3b2e6ad2651eeba550d9b13aa58',0,'2022-06-06 20:12:39'),
	('82ee1d820e9529bd67d3a8553e822643461a275e48aa2d5b9ffae0717e69e32716389ce887946732','9996fecc7a71fd7875d7712ad4fd2b3cc7e6565c898e8739171226f820a2d687f182d42b3795b3b6',0,'2022-06-12 12:43:21'),
	('84d2c69887bb0ad74f0ac40ed4e752d83f636b515ede8abc5b44759f4e7129357d4516600c1dbd8e','4430be34c9faad61052010b90890109592dd858f66b44a58422d57c3720346f0f4e2ad994ba25b2b',0,'2022-07-08 12:01:52'),
	('85e50f57ef74abda88ca5325a4e6edabb5d159d95d3d59a7e9de232a37cb890779a02515916e7f12','68d8c1355f77d5430e6b63966cd3851f30f9c1358b09a20782b904397e513d03dde64098659efc0b',0,'2022-06-11 13:14:48'),
	('884259adf000c3f1039f917d1f47ea253046e35a498eaa2cd8c26df4e984a7b4261b330b91d2e95d','1b04fc5411fd96407e6d1bd77199f8cab8c64fe6e66bfdcd9fc76bcc38ea3e7ae3ef0b5f610edfc7',0,'2022-07-03 20:27:23'),
	('89fb12e472ddcf1a771f07f4ac56e66230aa45b1e03afe1ec4eeb60813e71ee4c354b85ad8b87e76','b95f795a23453a958860a3f07364dbb30a9b5c8cb9b3616c3bb6be21254bb84510c6d4c2a79fa611',0,'2022-06-12 12:42:24'),
	('8b21361fbe25b65d253ce72599aab55bbbb0ee5820db5af57ad07000d94b842fe042b90a641a3dc6','7afc62755d0dcdc3f44595ff2626e43a1e7434df55ac1a0bb45a6774ba918276e2c5e5caaa0a42a5',0,'2022-07-19 17:19:09'),
	('8b85664343634be9b0c575f190ae0c05ed1de1fc46b93b541ea55f76acb083532ef65eced40b153c','14fb27b57534416a06408b7d9bd7de0109dd9874b69b747dd1a964b347a0cf6b3f7aa11ae92f0730',0,'2022-07-06 10:36:28'),
	('8c99077f6cc170a24c5ebbb8c4ad505f9e390f37f5373edd82d161dde686b7a9c6aad47b08e3e3ac','1bdcd306e2cc1eefc6436a1047b9c59e7c06c443cc94082a1ac354d2b3ba47752793e8373c82f65b',0,'2022-07-23 11:30:17'),
	('8d04b969e4e39fa7c0dbc66f9c5a6d0f96db0458e3b39e84dd860863a5604e49c8b8ce541e6b73d6','bdfc8af0198a19dc33941ff19035ed8ae4e17f495fa4730a5007ebab50fa610eeaa0b9d981c64887',0,'2022-06-03 13:06:18'),
	('8d7d0ba0755b83f6269a7ae67a96dfb188be767599f5f6df3fb6b471660cabb603eaacde4864b8f1','17e084e8ca095eb8e771c0c24a09de8f96e0d15ac34ffd53fe93648988a0cabb1f6c2fce0229e3c1',0,'2022-06-06 21:42:47'),
	('8fc9baba4153e11533370f5661ebd2e8fa0e265522ead348cf87e1c6f40850e97678f8ac1dc689cb','0cc6daca024dc8d37c12db77bf6cbb89e0e5da6215b040f3ce40e6b97717a641edfc0bb79a307341',0,'2022-07-11 14:50:24'),
	('9067e5689089eb1845e51aab16a94a9b6d93620a69a470065db02ff4ccf94a101a87158af06a96a6','65d2caab21011506b70ddbdb905e90d7dcc7b674a736d0dcea420fd82564d425466cbf031d741f8c',0,'2022-06-20 20:51:27'),
	('9081c4f50358fda085ff5801eb4f4d8646afac74030b65fde29c23be2c1e9d22d978755912b9b9be','013521a21feb4c7600f754bfd738026366371f5c68494b58acc8a0f8653ebf51b276a7afdbab1f4c',0,'2022-06-10 11:10:37'),
	('91de64cf0acab9c259c2cf249271404cddc4879b2ce54683fb7e26ef60f795da808d7d2c3c1dfbc8','ad02d43ff40739bb5ff68dffce550223451ba82888f18d100e65af2b914973479c20926d6c5fb669',0,'2022-06-05 13:50:09'),
	('91eaa7ddb95bb20aa222625b562fd6106336531bc194441f6239a01fba07599b8ce44b7e7aff7163','1eb41ae689c4e66307d419b7afc3bceb11eed73005551ed9cdd79cde0c5aca98438bb6c42dc89453',0,'2022-06-11 20:05:26'),
	('93c85ba738855db08fd093c9ada4751be733e4e888823033cadc6c717939fec8a1a99bfaee55a406','f0e8b1af006ea6b1d0b0e6d32e50af0e9a74bf79249fd2112744afd6254d1796792fd222fa763a2b',0,'2022-07-24 23:13:11'),
	('97f1e61a68cccd7e34b0f0cf19a8072c082b8bbcc2627e2c195830dcb28e76311fb973b6558c8d64','6cb637e9f82ef0e8fe2a9a042047f94432cf4cfefccf3ccd84bb990154e7f411caa9915a5e06b22c',0,'2022-07-07 21:15:43'),
	('98b866c1336bc42b8ca884ccaacdb6d84a24949d0eab171eed7aab7a9b62f39de40b700c1ca3b52e','a3fbc74fdf14bd291ad646b9e7a49326c4625fd6fdcc3de20ef28e576b64ad446650c9826afec8a9',0,'2022-06-25 10:35:30'),
	('9b0b029c4614276ec6df8281cf2430bcab57380b9d4fa31486bc4b21800b45f0add29c400af9e100','351aee861cfed9264c319fd9121a12da2c31e101b3b377fec28ed4c05b56d73410837a8e6d663760',0,'2022-07-18 18:17:08'),
	('9d9aced0ff0fb4436bf6f2c4dd4b4ff2c895c27647b6072c2c40d7cd154a79fb3f44b13c77efa030','c94df38ade5da526d80a99e9b0d760423d93d10973e4b7c1cb288b6efc47685f0c7a1d844c4081e9',0,'2022-07-23 21:27:01'),
	('9db8fc0feb62c675bd6987f9e0646e626900f8438c63394ffc3ee105571a2ed3856553a897c77f74','1aca58cf09084ebfc2a481409fb6fffaaaa96d883aadae2b1ed6d076e61288f6f311b7a52d3f2a4a',0,'2022-06-25 12:24:11'),
	('a2607d5217bce903465093e70d4d5030abf514a31d721fc6f711d14c2c1ec5a722faf08154002cf9','d3b4f626300c58b463e37b752a2296506b768401a4c767e9475545578a61015d0cdffb59363f8637',0,'2022-07-19 17:17:23'),
	('a2a78ea5bfb457032626a04299390b5132143ec91680585bf693b52e23729cb8b4b82c59ce746f86','9e1608bd2b5c87694760447511ea1b8612baaa96da6977609f29f42b1e8e34b80ef2b75610eef536',0,'2022-07-18 16:45:02'),
	('a6eacdc1dec94d6190800174dd12766a6edab14da2398ea14fa3182220e9eac1e91ba7ed8ecee049','5b36f45418a0803cb461bae441fb5de9aeb5b7067c69102e20695c31274cf7141a29e6f9d6dc2eb2',0,'2022-07-03 20:23:38'),
	('aa36197f41c7d2d75f4d0dcd97db71daae7ab78da74370aa7c00607720c44e0f764aa02a5bad9155','be9d92ae9b9b67570ae65197f26d23e039b2aa51689a020a4b18d5771a7b2cd4f6fa6cb0acd02997',0,'2022-07-13 11:09:07'),
	('aa7c43debfccabf3d792f570bb03293999dbcf139be3f00120d435d0fd8c4c830beecae4d979ab70','43992e5c63cdb08e3b149f8b69e6ab42c83f6eab9a9ae646379798d18a1435e1f34fbef631ca8adb',0,'2022-06-06 20:16:38'),
	('ab76d79bdb4e9dcb7108bda71aa0d49982a474658d69f53ab7d0bb7c8adedeaeb23967a31afde5b5','42473975fcb60ae40a522104c9214d479e06aeb36a1c529de53478e8aa5708308d7a5b696810e2de',0,'2022-06-28 21:09:10'),
	('ac0925b4ee731344b564ebb2725afd33ecbb182b02929395eff33efc01f0166059df44006badca51','3762d082618f424c5072b9d50ae0853b18eb02e8d0348bbabebaecdfc6beaa4eae5cfe52eb2cf5b3',0,'2022-06-06 20:14:06'),
	('adacf5b534bdfec4839380bcbac534ebd15cbaca1ab809d2cb3743645f34e78b5781d438e35d3a89','f175570777cf4e2f87015056f8982b701603bb831b7e45ad52595117d24baa0dbed169bc108f68b4',0,'2022-06-25 10:12:52'),
	('ae428a4dfaff22a97bb5a5d6f63678bda409becc7405770a04a1061f20554fbabd285c75a0fd5e87','3c8eaa2f8d9be41e13e49c6668568f70df02541912e779370d70f98db14db5795708121616629c5b',0,'2022-07-12 15:01:06'),
	('ae4997cbbbff85b6bf349b894a07b2836a5edc7a3875194870e79046338b552c5d5f7499788b52eb','e86ea12b21085718f84d8501752cc39922952cd8d0feb6bb221b1df9d1fedf02035a65733a9bfe22',0,'2022-06-24 10:56:04'),
	('af059560b5e8ba320b5a40898bdd116dbd7e63a03add0f35f35e25f6b69f2fffdc6b49c273f4be9b','3eb15bba72334fa9052b7aacd7221762b10c6857ba3677ade0fbcf7cdbe957346f6c991654fd6219',0,'2022-06-06 21:57:17'),
	('b01e5c19cb1d8d873362a3a7bdc404c27a9775f261d10f3f7d2605e94d74d317c9cf8a8e866fa8ac','245ba15944b3ae061111ed4e8be432ad3b6a35795519f8d31dd20cfde7ca6cc0aabb5eaf478154aa',0,'2022-07-25 12:37:30'),
	('b1081522b1e60c04b5d972a8bb69bd481eb9c266839f8c69d8e6b5ef6aa1c00266369a86a99db47a','ea8e0a77d9146a51879422e6cfb19b9d4fca34ea395421c003971d870990c7f0cd02c1f5402da090',0,'2022-07-07 10:31:15'),
	('b22b55a111dc9f5a8056225d6d41255ca7841574f700c1eb88c5d1bd57c73f99f47f005bc8efdb2e','3387457b08189490acd3da11bdd5888da450c945816c2dac2f4862996c906c512d597f9435873e09',0,'2022-07-23 15:52:34'),
	('b244b7348cc5f6169bfe56fed2a32607e61a421a8b583297a29986986782fdbb988173f117435d73','50bc3227741732afd8475a2dacde96fa9dd16725ca8fe48f17cc966e45b25b4999ccef457a372891',0,'2022-07-19 17:17:16'),
	('b31809fa58b2dba5d6c097ae16414e864929607d821bf46481489c68e0098c3d51fbfe121aa12a29','ede35f4bfbdbaf2f3f9ac87aa60e573adf1d7d0adc4ea6333c9cad5b1b75743a3bd9bca14d5779a4',0,'2022-07-02 12:12:17'),
	('b42f1e1856ec9c9085b2df24892acfd5e2a9195e8c2180f5eb0c2755c21edf9c35851074ab90b888','4a2c0acd6f7dda75afe3f47c08adc209d75fa1e6a4b047c8b6bf7509ec15b865a034f9d9f7bf42a1',0,'2022-06-22 10:43:52'),
	('b44fdfa5c34dd2ae13f41967527ec6d0b18e3078cf7072bbc3c5f62b181d76421f21e370e2145098','2345323fc2b7aa7a02c6cd49ee2c76e53b964223eed017d35ccf5f837dd29e979e68ddbaeb465e8a',0,'2022-06-28 08:26:21'),
	('b46b5ddffe183d5f60b17b98ca6521dc6372f2cc405d13dd0f14166e1af2fd383031c8757e7dd64e','c4a1787df153ce4f15d1588357ea7d0e500ed951a4937d4b04565e6ce7edc02671fc87bf09329938',0,'2022-07-06 08:35:59'),
	('b4cbcc566560112822cb06e2096b7ac1b5be9b78ebcbf0146860ecdd2b9402b2bb24a4a41b436cc2','bcee0a9cabbb41cee0ac052e902e1d81d3990cd1e265310eb5f583960c299b6270ef9511e8512ca1',0,'2022-06-24 11:06:50'),
	('b78f38a73eb4ca24249b0d3d3fdfc4e8493f97d496d94e14b0ef15ffcff3ff34f2d634390262521d','519ccdddbd49c4b9a81606881eb074f5ecaba4956f31fbce90d02af3813db6f74417e88fffc462a6',0,'2022-06-30 21:35:15'),
	('b7e22343a54f4831834afa91756169437d4aea3751fcc6bbbec444c3522ee2f8be5822ad6ca9ac15','28cff49c534b8b8deaf3cf9b6c06b350c800c7bbd8d3d77bfea76b265b792f00a9e3bc147af7075a',0,'2022-06-08 08:34:42'),
	('b88d7cc91f76fec0f443286c75b740018853cdbdd0ea6b93c1a1bc55e94478d792f721f0cf0bc7e0','f48ad5daa556bb34f5cb13da6e1499d033c07d187fec19a130933ac2d7d11a2c6da73aa2dc65c960',0,'2022-07-07 12:37:20'),
	('b95fb1dbf36e490fa3da9c7fe27e6854e8201b02ceeb00adda29b39d8ed495ef36c8f26bca6ab664','bc31514cfa1230c8f422f7c73513df4c919b7aaadd48e87775e66de2b713eea7a073fab375513355',0,'2022-07-18 13:06:35'),
	('b9fc2f44cbdeed7efb3ecfb4c5342b110ec2eb8118a1b5a087911d9ae4794de06b073c4aeb3edc29','e19dcde5e0936ab67256bfd5162aa2cb11f32d513211c6a6d5d0670cb5774417d7e508fb7db9b151',0,'2022-07-03 20:29:46'),
	('ba5ac3a26b5feec2ce6c9eeebd76740824a7a0504d9c087123e1898b618f02fd619a2478513b2499','2df9068374c508b512ef05f90009d33a8dba4187058798ec3b20f4826e4130499cf0757bb0b59f7b',0,'2022-06-30 21:23:47'),
	('ba64aa4e688ad4c6e1f068959ab229d5305e147b11b22f8c1aaad0de76cfc13cfa029165a404cbe8','e4951cfa8e1c00e5bdb6c8d92c10c69041a672296d22668388a145fac00f4c9b37c34b681d4ca83c',0,'2022-07-01 06:05:09'),
	('ba9685b1b856479f5d1ad690ad222b666ff714cf55050edea7478e594c8a40c177deebfe25dedd50','4e672c6bd8a70f4ff9fced331b03f89fffbd836b26df89551c8ce96913a1d61897805546ae3c35d6',0,'2022-06-22 18:08:09'),
	('bbf18142ed7fc860335e0422646f9de0129dbd9563791907a670eabc0eb3f72b16ee4d3ec47071bd','a87431feedf1e4f2ff398037175ada92563db597afc144e22cabbe35663c6997b29c892f8b21685a',0,'2022-06-24 10:46:39'),
	('bbfc58e34a5a74eb4b370e2ab0fa4a85fe40456c82c85e65d4ef24386a9438f95590caa32c46b3f9','61979d7f81fb517ae71ebd5299de84c0243b322202bd4898d400785023ab6dcc1c0c117cf0c9c937',0,'2022-06-24 16:10:14'),
	('bd90fcb22613906e6c5826a179a9c72fa1c331fd695e931f8bc7d42699fa06909d60b89df7a2002a','727b3f533e1755d09638c1c7ee2c075581971d9fcc67245c3b55d91e6d7d190b2078e406c68d3156',0,'2022-07-16 11:36:57'),
	('bfa267dfacfba7d7d30dfdab3c90c4d56a0508807143a4ef18e25095bc6ca3b02693d9a9078446a9','28af138f441dfd72936df88af72ad6d8192c709c03356da83cc8d9fee3b34d203f73ad92ce94eff4',0,'2022-06-09 08:09:27'),
	('c118a2e973b93d5b516e299afffc177965797a5c0c263cf6fd85c98a2117d8d57238d89e4a348d73','63ff97e28a80266659b394d8d1813d20db46f9cc7eb64519322350144176513613f6b433677ff5a0',0,'2022-06-24 18:52:30'),
	('c124048c2cfafcc828295ed3f3eb31f85f91b73b435d4af8b8785eb43eebd7f4a5cb54b84f839d7d','4ac521ab8133f98865b81c3c657da55b958bf11150d9d6717634cf28ebc2217adc899dd30710543c',0,'2022-07-23 21:21:58'),
	('c167eb1bf3efeba8a0cc968b9963c8c1f63894f084f9b382cf3f2e80a858a3b3a70617f3a2e5d944','d9813d34123e29e76af27b9b04ce5a2a182bef150b06fba5ae191c1cc2a261701ff81598977826b7',0,'2022-06-29 12:14:06'),
	('c22b531a5f84d2d9a60e3e93dc3c51e7c571e4bc21605a905401e998f88df17da3deb71386e87ac6','0b001383468f4a231909c190dba3381d3c47f968fb56b4c030082af7d5b45bd8cb1eaf9459349ec1',0,'2022-06-11 06:45:59'),
	('c25f7f26d3da7f14cc47d2359c60329e84f1ed05d63ff7f4ce9eed34a97d2055d96238aa07bcaa7b','032c327775654689cde574a1c474b12d250ca210c00e6f75ffc522987f305925bda53b7771e2b2c5',0,'2022-07-05 15:34:34'),
	('c31d613fcdcea9e2d392c078ff1cd474d3beae293f5888abd56f26a629cf984610b1fa856bf4a080','3c389ef0969328e4d7993e42d33751daa0f46200a1bfc242bae01aef45822caa5f46545093bb4df4',0,'2022-07-07 10:46:12'),
	('c332ef300d9544ae7febcad8236888306e525f6cbeae14bd5932b0801a998f216a7f85d78313bdc4','10e619bac91db8aa9ac07eed646be8d8223474bc8a06113d8a9547bb1f159a0413efdf0f48e59613',0,'2022-07-01 10:03:33'),
	('c4547edea064b820bc60ff9066479da81ae08fb12cc06e1929821954856b6497dd278be909837406','da054fdd2cef081891420064c0f62546be73473afd5ff2fb8b8a44466f30a5c79721c062f14d7888',0,'2022-06-10 11:14:08'),
	('c55f2eaf5c37be9c76c3f8f2c06240120ae424e216f56345071e9ddbf4781e72b870c06cd1d4cc88','32d70723d662b7e69949247933ac25199a87db52905775d6fdf0b0a9255ef7d56144b3237e727161',0,'2022-06-11 18:00:19'),
	('c5a44624fb2c268bc7f0c630101f7895edde92986ee9ab10c40f23cca86c6967dc11a4864e6653ce','6bc3386679e428b44a393e00bc6739c6a2738b2008c9ced70fc35d0f4f7fe5b355c5f81cc237616b',0,'2022-07-12 22:19:03'),
	('c68a5f358aa53ecabb5e5f61770474de3cd88654433248c6a1c446f8c2a80a9708792405c6dec2ab','2d8742ee95203fdf53b712d95b510482041bf050291cebef7eb1f9f8c7591ab5fab38bae41939a1c',0,'2022-07-19 07:48:31'),
	('c6f43d1a290effcde397ad2462331c3cfc8dcac40f9fd3b500ad757608d829a84faa24834279439a','b9884fe3f0fa36812863cf611aaf5b954176923d349d04252213a318a04669c46a1d2bd13c922412',0,'2022-07-05 15:14:29'),
	('c83d7466d0508f2b3677cae1dca4a3fbf2a013feda8f19ffa1b095d8569a93c288ad1999148dbd43','60d554682fbe2703f6f928668098612aa405bcbe53bb694dae129699782aa62fb188daea33fa0355',0,'2022-06-04 20:37:22'),
	('c96b99f72ac09c3161e4d108e841fdee1509a23efcef1151852dd2bc27d29b87368906e833aebe2a','f58402c0305cc9ee4c09b2b8f2184e6c911e6929907391cad9a2509b3c321b98ebad88b594aef774',0,'2022-07-05 13:21:20'),
	('cbc6eb988825075072d39cdae7de7cd0286b44a827fdbf543224172ed51e0eef1470f699d9f7f64b','230bb254a5a7a833a87f92eab620818edce5b26b80d1c41c31855a92cf6a46fb3baff9a76b1f395d',0,'2022-06-04 11:36:26'),
	('cbd4427b82dda57e8591fa448d071760e27bb70c009bf6cfc729c12adaa51184435b7a0e1a47a256','16b3912375f441dab1a6b2f7fba9d053db855c930ec6869bfaaf7d0cc7ab91307728d524dedf6cd1',0,'2022-06-04 06:13:41'),
	('d07a280810ed5a361fdba6c96468d9ed0f824be035b04ea3c4764cefb5f1ded3a11560baa8e4d08e','7cfd8d9381e1845dcf8874e9c76efff697191797699e3e656e937cfab49aee8d8d23e6b75bdd3ae5',0,'2022-07-08 09:19:18'),
	('d1ec4656a85778994c34fb56357fb5f3587ce2b760b5affc15ac6874578ecac3520e6e0d54a32018','5d76ad5201110bb57a3493cfbb63f3d2a19f810ffeb8d8012783e006a9a88bb91f9bfbede9fd4bd5',0,'2022-07-07 19:27:18'),
	('d37cee764d43eaa349c306ef0bd4be6ff66fa483fc00b7974ece47e4982c0e2b34e4ce6a4a0d1fbd','395b05eae650f9b6d3016028ed26a61afc857f42df0ac4843bdfe498f07b1580261c20b7e95fc6fb',0,'2022-06-24 10:54:08'),
	('d4305bf6d069a8b0aa6c72757adc405e44bdf769e13a22cac49a12edb5cf30b90cede22117fcc5e1','b0c42d787d69fe376638945cc73a0d9e5ba567c08d2d8700f0c993f69e03029fde896587ab87d6a9',0,'2022-06-07 12:34:27'),
	('d69915a189a4a6081dc7d0633c45ca15ef95fc2cfccf9371e7d1df9f1d11394f6a85536211c6defd','c889283836204223e144a58cdcab3fdba6cb244f568a502b6cda857d41d71f5af4847f065110fab0',0,'2022-06-21 11:12:56'),
	('d6add511f18644f224ab0a0865e3518a8373d3a324e8cc6bb3b481a50a6d8916268d50eda2905ba6','06873ddbbd5551bf35cf4bf8874832deb3d988ce48a019a748114b571dc245424b2c98fce3c2bed2',0,'2022-07-09 22:59:21'),
	('d6d718184e6b4703b5a87e3b581c0eb5447c39a4193eafc36bda41fcfad40b9290ea07d86d130096','b50aa4778effd16e36db23d26ae177976b58e0f2c251d0c591bb78abda59f8cb0cf2a1543a070502',0,'2022-06-04 06:13:41'),
	('d76c20d948b6bb5d4f0918dbb98e7b2584806a031bd3bcc281a5d18a3368ae2f094f3b9ced7b0e1b','a6324e596a32447fb425813d6df2fa1246d086aa780893ea3622e34b196fd9b57839c756a5f3f28b',0,'2022-06-29 11:07:43'),
	('d9fe520ca34f5bb6d95da41c05a207675d78178f1b9b7e9242e6e66d69121123e6ab17c65574cfdf','e1d93ceb41138e2db4aaf39855db10baf7c7d4ab6631d1c58db1271cbad504f795ed96e4158dfa81',0,'2022-07-18 16:48:41'),
	('dbb7986e917de16bbab14d3173f2cf133a0a6e4de6c8b85ca4211129bf29918070701224a5251752','6dcc77212746c11f2c1a3d72fef9c247e138f79ab09b07c58f5979a4c3a24b67da4b88e45effac7a',0,'2022-06-21 11:19:19'),
	('dc3fac10567f4635614a4005346dd761a6a62ab3cd3c15fc6578f2ea58ca580ad9c4e270b2b54ff4','5e3f054556cc4536e10382acebdc721b812934854ae94adea0903e1e0098d00d4e9a503e73ca3dbe',0,'2022-07-19 01:46:52'),
	('dcc77d073760da6adb55cfded6e47a476970418b6577dd95e6cb914f83863928142db0def1ea34db','86048ef2cedd7db5f07d66f42fb92e7f4d3bcbe2a8c898784888091a8dec904156e4a390ac42b084',0,'2022-07-25 22:00:37'),
	('dd47f03c398bac8c1d36dab3706170d2a0c8aec76d04c6f091acead8b73e5223278d54a90f194e32','17e0d83572c16ce13cac7730b43548eeca2b45de8ffc3c35e60a9eda66c642ec142bfacc8a5689e7',0,'2022-06-08 22:31:21'),
	('dda08d65703b8782ad1d29083770ce8b34898d4e29dcbdbf1657438d27455b907b8ee3c488334628','daeb5a14de81c845d974f9e8555668325f7453597639a0ca4fa47a6c576357f5144dad565a5a11ae',0,'2022-07-19 17:45:35'),
	('de66bf80b586a6fb27e845fb7abaa7d26ccff913a058a72caa684a05781eded386f74ce3f2a68067','9823692c29f0cb4b94b84b674b4f1b6b2ceddaf875f18f542188acff11936a3259d6c39eb48461f9',0,'2022-07-11 15:21:08'),
	('dfa874b06f34fdf0b68390b91501c43e4516918c64c35398c133a76586ac93a762e6388d9b312b09','965ab13b50de030a4a2c356bf9763f7b5741f8888cfd36cb73549908104ada3d892e160165bb698a',0,'2022-06-12 14:49:53'),
	('e1204bd8bdea74b3d014bf4e3c51915d7d65d6c0eed8153f203d34ac4c302435f47d7c234219ffaa','3ad00de97d043279156204e804289327b9758cdfb178962525241a0c7693ee5153ad9654fa09db1a',0,'2022-06-24 10:51:00'),
	('e128a70e9021deeab89a210434aed2d638a85e11c32696d7aeb6530e9fdecf56c153c8675617305b','7e6ee47c72bf08e5c7014e9911945a22280e6ad6c8482fac04d0cfffd3468e718a55b0cb8818e8ac',0,'2022-06-25 11:19:04'),
	('e1b18215f39165bdc335519fb72553fc949310eb38e0b6bdf1987e8400a8ee33a54bd2030017e49d','3049a48d4b9e7554f5f7c6e6ae35ec4ee7cecf8006ceb05e5e5af96452c1bbe124f98c788523ebe8',0,'2022-07-01 09:36:39'),
	('e391f784453d6620fba3163cd183e691a7c1014622ef9c147e38e353a79966ab2d516f29ab1e2b80','3937ad168fa096b96a7a91b58f9fb3810625ccf6e2fe83ecd94e02fbf8ee653ec99f02a9aef80ff2',0,'2022-06-24 10:47:41'),
	('e4008b8e248befff72de8513c3cb43a4134fba78eb39f046adcbc58f9b37ba5a65f26104617a2d54','131fcecccb03cea80ba3ca75713e585f518ad491dd6ef76a440ce7787ad4b508335c37d967ad8acc',0,'2022-06-28 00:16:08'),
	('e4abb7d022b6f3a8392438a8780b9c0bd56126e9ca6a35b7524e0d6610fcb49922eec8369fb7ab85','2a35aa54e47fea0339c78145f1548c871c9485db11432465379d89a482e776735bfd1ecf66fc743e',0,'2022-07-05 10:01:25'),
	('e52dd718a6ad7cd9fea87a9b28215db8d285e6c46bb12fbf513c0af4ffdd96817d49f2b31341ad6c','b900a83adda4fda34469f5cff36a2714079bba179c2f7d8f253a1cd3ff11616e604432130c8a645d',0,'2022-07-07 16:34:50'),
	('e569d1f3043f9cd3dd581cd0d76fd9a1d5eebb317cff938c8158dbd21edb8da9c2412370b5c9456e','ef7d1a6d91d126179890c43c8bf2467b18e1b187a01b452b8a393643b7b6692929bee6cf60d7e8dc',0,'2022-06-22 00:06:53'),
	('e7412c99c82c3e19e1cb051f15124cd946024d718b018bf4771a39bac0d608a3a7f119233fd2636a','6be97037343d55a4a96296a04710c42dace9c4212b9abf81939cd0dd69cef7bdce1629fbd08942e9',0,'2022-07-21 17:28:56'),
	('e837a31d6badadfaa2237f22c085b79a39d803dbdd26f83d582d9dc9473d5dcedf1fa1213e4a513d','772cd472fc327ff5d631312fa987f5b28184097a64994d2264cf1b35a92f4b5b2ee4d2d391da33a1',0,'2022-07-18 00:13:05'),
	('e873b724b045a955c09416b18587287c1eae62cb855f6d03ccaff46ba51e2ad13e60813918e2bfcd','4f6ae6ca9c1c8a3a041923fc99cfedda60927c52788fdf3a8a61e5021c1eafeb564d354021325979',0,'2022-07-15 13:17:03'),
	('e9c9ba092cd0825bc7e5cb577ea6e8e3e503cf541bfa856a7bacc24abe233f0ae23a1c9f4eff0dcf','17306eb10bb11eafa56b02b45c00ea7d5564fac57b2bfb10846b5a50d86113eff080d508d0b8ade8',0,'2022-07-01 09:38:17'),
	('e9d3335175bf95bc24a561cb723c953bdf7bf01dab54166967a2d930d4f5c41b400bb51aa4871844','048b061aec68108ce8e2af83d10a39b25b52a92959912045218052a4a9a13aa6eb5f5ee9effe546f',0,'2022-07-08 16:25:53'),
	('eaafa4f4cc2bf6dcbd5ee906de76945385df1f5c972fa13b73b46ac71660a67829e112f824bef915','83c83be9f40f2dc123936785431392652caf87c686939fea6956ba5ba56c301bacc12a7732db189e',0,'2022-06-30 08:18:54'),
	('ebbd2dc157b0078494c6a152f06924fccea031bbedc442ecf05d896941affc89bd4c819a008c5fc3','d950400732eee9ec4c7d430e8825f32f39ec2f834ea464354ecc896f5020bf4a89888eb93d75dc49',0,'2022-07-23 14:07:56'),
	('ed10fbe0cbcb00918d8ff2c991d8ef7549bbacedf188da08c59bfc396b671460f7bcb83c0a729b5a','4023f7318f724a9eba4c7972b0f7470641003f209e064bbb755cb05f9cbb89c45730a8397328725d',0,'2022-06-03 16:23:29'),
	('ed24f010ea3a7a9503d11f49e1c0804a5663252853945a45a628703ea34e7690286ab5a08395f16d','3e8deef0ca6b60b656e2878c6d5334a26ef62a5834edd4597031ed9cb6bfa8fd529010918e419780',0,'2022-07-05 10:57:15'),
	('eeb48729a19e70880cb6718f5b46cdcc10b381c4ad3146a36e8480f2014d862c341b58154b847524','ef09e9ad4bf3e05f2915f310c2c1e3a9fd3d63301da0a1e6f9604070fac2c09fe2da0fb89d2918f6',0,'2022-06-25 11:06:57'),
	('ef6149a31981933093730be2168a198c8ab57aa621abadebe94ccb14ab1ec24c261212675dbd2be1','17478bbc97848f5d90f2142e6e55a908072f5f0e8ac9406320f17feecca49e8eccc8546feaa54b66',0,'2022-06-22 17:50:49'),
	('f15c06424c48f2abd6e3a8e678e452729795b1bec7de352cc795511afffe591628a9a1862b53af6a','e31a08701863336633e064d7b8a62c2faebf1954b0d34b72dd9fe0fee569a8956a28a437b54e50fd',0,'2022-07-05 15:18:41'),
	('f198360ac77ef1e93a0d9fa084301f48a6f1a8f0172af6ac37bd490c838aab28cf238f4d415af64c','0fc02ffa1e29a3cf6e095f5fd452c310ef082d32756a78c2e9f4eda64ef9cd8d8ef43d9ab2951bbc',0,'2022-06-29 11:00:14'),
	('f42654506f6829e08828179893296491e95185ac354511f3b44fa11ac22cf77316739159c05b0f6e','26308660452ca8ba12e782a5a146ed6a15bfd43d6e2376be5d7856e992444114ded8b6e2caac39da',0,'2022-07-14 23:10:27'),
	('f44a46ebb8bd4f6bf92f3cac5d9c241ab5e3cf2b38bdd841bb9469dd0d00f6c29a2dad7bea074fdc','34188b91e4401d14bfd4e675f3d6bc34eb8dd0f7d15e73efd5ac2af8d8e865885a996251c3cca0ff',0,'2022-07-23 12:32:34'),
	('f4918bba1bb7e42cd599a7bf5022f8da4bba665894588acb5bb1559e502db0c1bbbf6dee324e5987','945e0b0e5580cd44512862266062a428d566b6c8743bb878de65cf220feb40ea5ab3ee39870014ee',0,'2022-06-30 10:58:45'),
	('f7756c5c3e988037a4fe24dd463bf0e587808c339a7a35d6f702b70294c84d2433dbb9e3edf3b6a5','d032ee93cd4a9eb7988736d1442159bcb211ebe1cd115e10503a7bf30e350f736e35493ddf166c9d',0,'2022-07-05 09:48:39'),
	('f7cc8ca1ba77dadea24476087b436e3298b12e7dfb0906c84584baa3aa5ed71fb6eeb04d91d16632','f4376c418a548fba355258f3d314895e0eb6a1b157d4f534ddbee4e7b36f87b402d5a94e8b2ef53c',0,'2022-07-23 14:18:56'),
	('f7d0eb43e1498888e0e725c190e9c045d115e25eab49f56fd90a15be9ab58a98641dd64e953ec9c2','7d5f94252e90601a0a1c4caa716d0fad82c98ca779abe3559b5351d152abc02a83b6edff8ebdb922',0,'2022-07-07 10:38:34'),
	('f8f6c2cf90f18ed7920e1218eb087dca9010339541e7b665636272395e80350deae96c3e7842714f','66924712a82ea7ed8d4ce239e7c5c3d48cbfe2747038564091d5b3a083518a26208b735cf37a7275',0,'2022-07-05 09:56:54'),
	('f94b415f5ced23c43ceab0dd035b98d90d18e0b54d1b46946748eef48ffa0511015b39f996dc597d','135b9d05c06764781a2588c569aae8714e83c909e63530791545a0370c054057616acbb0a0109918',0,'2022-07-07 12:18:29'),
	('f9928de1cb9fe0a9a0ec821aab411111a05d09a9a7f37faac2868426fa814106a7ad93a8f7bc9a3f','9bbed24afbf7d6a6605aad4c72aa45c8d1076a869d85a4e78704dfe16b48a2a543c14235dbec90b5',0,'2022-06-24 18:47:52'),
	('fa1894a8e9bc0517bf77a5ebbb34e2e3bc9ba3a3c9d90438a837320278a61193f07464835c9f0b70','b486588b40c7f3747c964f373c31923046f1967ddcde7f582bc16558135b97e1cc009275b0f4d64b',0,'2022-06-03 13:51:27'),
	('fa7911a70223323d9971b79f9cbfbeca31c901daa3f116034a8334c0544827c21a56e0f179b536ef','d55592e51106d1cd901d7d688207821d8f21c5b9fb15aa52f93cb2034a50d6b71f4fef4eb61035bf',0,'2022-06-10 12:10:20'),
	('fb3a31e1652aa04857c41ac1a5ebd94b95b25a2c4b00a610d99b331b55301debcbbcee9920df11b1','a1cf96bd2aa39d39c56ae116294f87446d1145b24678ea074890ac7b5877ed82da37237dc2a18b4a',0,'2022-06-04 20:37:22'),
	('fede0e984e805727396f45781eaef197f46ae6cea4ff09ec30586810729f96c2acdce3b748eb4738','50ac01558812c111a9a47e93db6dc82356c6caf9c192d945528a0f01d9c0971bc19cd5ec39c22809',0,'2022-07-11 15:22:19'),
	('ffc8c5462261519c19d225f29a19d43546030ef9aedb49516c37cab96611cac3d8a63dbf605294e5','b67cd424227088d3ef055b4aa2a2e140bb696e2355088f976a4b8cb3e27ba1f318844717478c4255',0,'2022-06-23 06:09:42');

/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trans` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trxref` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirecturl` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_course_id_foreign` (`course_id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_facilitator_id_foreign` (`facilitator_id`),
  KEY `orders_admin_id_foreign` (`admin_id`),
  KEY `orders_organization_id_foreign` (`organization_id`),
  CONSTRAINT `orders_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;

INSERT INTO `orders` (`id`, `reference`, `message`, `status`, `trans`, `transaction`, `trxref`, `redirecturl`, `course_id`, `user_id`, `facilitator_id`, `admin_id`, `created_at`, `updated_at`, `organization_id`)
VALUES
	(34,'zHSyQlVLs0','Approved','success','1235583867','1235583867','zHSyQlVLs0','http://localhost:8080/transaction/?trxref=zHSyQlVLs0',184,NULL,NULL,NULL,'2021-07-26 01:11:49','2021-07-26 01:11:49',104);

/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table organizations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `organizations`;

CREATE TABLE `organizations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest` text COLLATE utf8mb4_unicode_ci,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organizations_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;

INSERT INTO `organizations` (`id`, `name`, `email`, `email_verified_at`, `password`, `address`, `phone`, `contact_name`, `contact_address`, `contact_phone`, `interest`, `bio`, `logo`, `referral_code`, `verification`, `created_at`, `updated_at`, `publicId`)
VALUES
	(14,'BizGuruh','bizguruh@gmail.com',NULL,'$2y$10$Kda68L16fo37xGim46oOPe1XKBtorKf07bQVC4nJu7I0zqHf2hms6',NULL,'08166741279',NULL,NULL,NULL,'null',NULL,NULL,'NF3712',NULL,'2021-06-03 13:03:51','2021-06-03 13:03:51',NULL),
	(24,'Edx','adagloryogbonna84@gmail.com',NULL,'$2y$10$MtRroF.X5DCFUkNrS9rjXelbSjigIz9zZqgqXzEfyKA0AxwuP9Tky',NULL,'09051313691',NULL,NULL,NULL,'null',NULL,'https://res.cloudinary.com/bizguruh-com/image/upload/v1624274001/fatal-error-4_qzk9ta.png','EdxZR6359',NULL,'2021-06-21 11:13:32','2021-06-21 11:13:32',NULL),
	(74,'BizGuruh','bizguruhmail@gmail.com',NULL,'$2y$10$Kda68L16fo37xGim46oOPe1XKBtorKf07bQVC4nJu7I0zqHf2hms6',NULL,'08138580831',NULL,NULL,NULL,'null',NULL,'https://res.cloudinary.com/bizguruh-com/image/upload/v1624532508/BizGuruh_Logo_No_Background_1_aikhzs.png','BizGuruhMO3554',NULL,'2021-06-24 11:02:02','2021-06-24 11:02:02',NULL),
	(84,'Patrick','gedegwum@yahoo.com',NULL,'$2y$10$ZR/M/k.Sqy8awvsbKQB/3.CBlXlEThuKmZ4sbNmlZWxfkgX0411h.',NULL,'08032031202',NULL,NULL,NULL,'null',NULL,NULL,'patrick_5818',NULL,'2021-07-07 10:40:38','2021-07-07 10:40:38',NULL),
	(104,'EnterMarket','successahon@gmail.com',NULL,'$2y$10$w5JmPS4wzlLfPdGkiRhMZecvrGpNQx/7n2EVvhocRmVf3mVv9OHrG',NULL,'08160723910',NULL,NULL,NULL,'null',NULL,'https://res.cloudinary.com/skillsguruh/image/upload/v1627215135/Illustration_mer837.png','entermarket_2738',NULL,'2021-07-25 12:12:35','2021-07-25 12:12:35',NULL);

/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table private_discussion_members
# ------------------------------------------------------------

DROP TABLE IF EXISTS `private_discussion_members`;

CREATE TABLE `private_discussion_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `discussion_id` bigint(20) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `private_discussion_members_user_id_foreign` (`user_id`),
  KEY `private_discussion_members_admin_id_foreign` (`admin_id`),
  KEY `private_discussion_members_facilitator_id_foreign` (`facilitator_id`),
  CONSTRAINT `private_discussion_members_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `private_discussion_members_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `private_discussion_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `private_discussion_members` WRITE;
/*!40000 ALTER TABLE `private_discussion_members` DISABLE KEYS */;

INSERT INTO `private_discussion_members` (`id`, `discussion_id`, `type`, `user_id`, `admin_id`, `facilitator_id`, `created_at`, `updated_at`)
VALUES
	(4,24,'user',4,NULL,NULL,'2021-07-08 12:01:15','2021-07-08 12:01:15'),
	(14,24,'user',44,NULL,NULL,'2021-07-08 12:01:15','2021-07-08 12:01:15');

/*!40000 ALTER TABLE `private_discussion_members` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table question_drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_drafts`;

CREATE TABLE `question_drafts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sections` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_drafts_user_id_foreign` (`user_id`),
  KEY `question_drafts_admin_id_foreign` (`admin_id`),
  KEY `question_drafts_facilitator_id_foreign` (`facilitator_id`),
  KEY `question_drafts_organization_id_foreign` (`organization_id`),
  CONSTRAINT `question_drafts_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_drafts_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_drafts_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_drafts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table question_responses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_responses`;

CREATE TABLE `question_responses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `your_score` int(11) NOT NULL,
  `total_score` int(11) NOT NULL,
  `response` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `question_template_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_responses_user_id_foreign` (`user_id`),
  KEY `question_responses_question_template_id_foreign` (`question_template_id`),
  CONSTRAINT `question_responses_question_template_id_foreign` FOREIGN KEY (`question_template_id`) REFERENCES `question_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_responses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table question_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_templates`;

CREATE TABLE `question_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sections` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `totalscore` int(11) DEFAULT '0',
  `options` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_templates_organization_id_foreign` (`organization_id`),
  KEY `question_templates_user_id_foreign` (`user_id`),
  KEY `question_templates_admin_id_foreign` (`admin_id`),
  KEY `question_templates_facilitator_id_foreign` (`facilitator_id`),
  CONSTRAINT `question_templates_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_templates_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_templates_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_templates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `question_templates` WRITE;
/*!40000 ALTER TABLE `question_templates` DISABLE KEYS */;

INSERT INTO `question_templates` (`id`, `sections`, `interest`, `title`, `organization_id`, `created_at`, `updated_at`, `type`, `status`, `user_id`, `admin_id`, `facilitator_id`, `totalscore`, `options`, `duration`)
VALUES
	(4,'[{\"title\":\"Section One\",\"description\":\"<p>This is my descripttion<\\/p>\",\"questions\":[{\"fixed\":false,\"question\":\"How are you\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'Question Example',14,'2021-06-11 13:11:43','2021-06-11 13:11:43','worksheet','',NULL,NULL,NULL,0,NULL,NULL),
	(14,'[{\"title\":\"Age group 1-10\",\"description\":null,\"questions\":[{\"fixed\":false,\"question\":\"From range 1 to 5, with 5 being the most likely how happy are you when you are with family\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"range\",\"limit\":1,\"options\":[{\"title\":\"1\"},{\"title\":\"2\"},{\"title\":\"3\"},{\"title\":\"4\"},{\"title\":\"5\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'Questionnaire about happiness',14,'2021-06-18 08:15:28','2021-06-18 08:15:28','worksheet','',NULL,NULL,NULL,0,NULL,NULL),
	(24,'[{\"title\":null,\"description\":null,\"questions\":[{\"fixed\":false,\"question\":\"how happy are you\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"boolean\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'happy',14,'2021-06-18 08:18:30','2021-06-18 08:18:30','worksheet','',NULL,NULL,NULL,0,NULL,NULL),
	(34,'[{\"title\":\"Section oNE\",\"description\":null,\"questions\":[{\"fixed\":false,\"question\":\"hOW ARE O?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'Test',14,'2021-06-22 18:01:47','2021-06-22 18:01:47','quiz','active',NULL,24,NULL,0,NULL,NULL),
	(54,'[{\"title\":\"Verbal Reasoning\",\"description\":\"<p>This is another<\\/p>\",\"questions\":[{\"fixed\":false,\"question\":\"How are you?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'Introduction',14,'2021-06-25 10:22:45','2021-06-25 10:22:45','quiz','active',NULL,24,NULL,NULL,NULL,NULL),
	(84,'[{\"title\":\"Getting to know me\",\"description\":\"<p class=\\\"p1\\\">Congratulations! You&rsquo;re mere weeks away from living the life of your dreams&mdash; purposeful, impactful and productive. We are so excited that the world is about to hear you loud and clear, through your business.</p>\\n<p class=\\\"p1\\\">Perhaps you have heard by now that running a business is more than a full-time job, and for it to thrive there needs to be a product-market fit, the right branding, strategy, distribution channels etc. but you may not have heard that running a successful business takes self-awareness and round-the-clock physical, emotional and spiritual commitment.</p>\\n<p class=\\\"p1\\\">Yes, sometimes all a business really needs to be successful is alignment with your inner man and commitment&mdash; lots of it, because when you own your own business you are not obligated to achieve your goals, heck, no one even knows them, so your motivation must come from within. Ultimately, it is easier to stay on course when those business goals are in alignment with who you really are.</p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\">We believe this, and that is why I start right here&mdash; discovering what is within.</p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\"><strong>So, how well do you really know yourself? </strong></p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\">We are all mostly aware of the things that society wants us to do, or the people our families want us to be. We hear it so much that sometimes, it&rsquo;s easy to get caught up in projections of who we are; never quite discovering or perhaps losing touch with our core values, needs, and desires.</p>\\n<p class=\\\"p1\\\">Well, I am here to tell you that if you don&rsquo;t know yourself very well, it&rsquo;s difficult to choose a life path that makes you feel happy and fulfilled, and while growing a business is awesome, do you know what&rsquo;s even better? Being at peace with who you really are while doing so.</p>\\n<p class=\\\"p1\\\">&nbsp;</p>\\n<p class=\\\"p1\\\">Therefore, I implore you to answer the questions in this exercise very sincerely and with openness to whatever you find. Give thoughtful answers but do not be consumed by trying to find the one that present you the way you want to be seen, because that just defeats the purpose of this. Be honest enough to allow yourself to be surprised by some aspects of who you are. That should be exciting!</p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\">Know this&mdash; whatever you find out about yourself today isn&rsquo;t a death sentence; life is dynamic, and you will always have the chance to re-write your story&mdash; especially here, just edit! lol.</p>\\n<p class=\\\"p1\\\">The aim of this phase of the program is to arm you with self-awareness through a journey of self-reflection. It is our hope that in doing this exercise, you learn to identify your own voice in a noisy world.</p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\">Above all, I hope that empowered with this self-awareness, you will be led to tell your own story through your entrepreneurial journey&mdash; the products and services that you develop to serve humanity. We cant wait to see it manifest, so let&rsquo;s get started!</p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\"><strong>Affirmation: </strong>\\\"<em>Instead of just coasting through life and being reactive to the behaviors and opinions of others, I will get to know myself.&rdquo;</em></p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p2\\\">&nbsp;</p>\\n<p class=\\\"p1\\\">&nbsp;</p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"These 3 words describe me perfectly:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Others would use these 5 words to describe me:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":true,\"question\":\"People often come to me to solve this kind of problem:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I am mostly inspired by:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":true,\"question\":\"The most unique thing about me, is:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Given the chance, I would take these two superpowers?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I want others to think this about me:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I value these five (5) things most:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"In other words, what matters to you most? Values play the biggest role in motivating our choices at work, at home, and in everyday life. Your values can be a combination of moral commitments such as honesty, compassion, integrity etc. or where you find the most joy in life, such as learning, fun, or having diverse experiences.\"},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I believe my purpose is to:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Think of your purpose as being defined by what makes you feel authentic, excited and passionate. Meanwhile, give some thought to how this purpose might help others, even on a small scale.\"},{\"fixed\":false,\"showQuestion\":true,\"question\":\"My top goal in the following areas:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business/Career\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null}],\"placeholder\":null,\"hint\":\"One for each category\",\"score\":0}]},{\"title\":\"The people in my life\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"The people in my Inner Circle:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business/Career\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null}],\"placeholder\":null,\"hint\":\"One for each category\",\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"These people hold me most accountable:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business/Career\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null}],\"placeholder\":null,\"hint\":\"One for each category\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"These people inspire me most:\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"Spirituality\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Family Life\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Love\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Career/Business\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Wellness\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Financial\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Where I am headed\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"I see myself here:\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"In 2 Years:\",\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Career/Business\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"In 5 Years:\",\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null},{\"placeholder\":\"Business/Career\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"In 10 Years:\",\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Career/Business\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null}],\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"“When the vision is clear, the results will appear. Keep your mindset positive as you work  your plan, flourish, and always remember why you started.\",\"score\":0}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What will be the possible impact of starting or growing my business in these areas of my life and how can I mitigate it?\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"My Spirituality:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Family Life\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Social Life:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Love Life:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Wellness:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"My Finances:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Affirmation\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Write a letter to your future self (10 Years from now).\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'DISCOVERING WHAT IS WITHIN',74,'2021-07-01 12:18:13','2021-07-07 19:39:57','worksheet','active',NULL,NULL,44,NULL,'null',NULL),
	(104,'[{\"title\":null,\"description\":\"<p class=\\\"p1\\\">At some point in their business lives, all entrepreneurs are inspired&mdash; by an idea, a person or an opportunity. That inspiration not only gets you started; it also keeps you going.</p>\\n<p class=\\\"p1\\\">What inspired this business idea? What excites you about your business idea? If you have two or three ideas, what do you like best about each one? Where did the idea come from? How has it evolved since you started the process of turning the idea into a business?</p>\\n<p class=\\\"p1\\\">By looking at how you initially got inspiration for your business, you can take the next step toward determining how you might get others excited about your business as well. You will find it useful to have a record of what initially inspired you, to which you can refer from time to time, especially as your business grows.</p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is my business idea?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"How did I come up with it?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What excites me about it?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"placeholder\":null,\"hint\":null}]}]',NULL,'My Bright Idea',74,'2021-07-01 12:39:18','2021-07-01 12:39:18','worksheet','draft',NULL,NULL,44,0,NULL,NULL),
	(114,'[{\"title\":\"My Business Vision\",\"description\":\"<div class=\\\"page\\\" title=\\\"Page 8\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p>Consider your business a house. If you were building a house you would first have a vision of what you&rsquo;d want the house to be: big or small, one story or two, in the heart of town or somewhere quiet etc.</p>\\n<p>The same is true for building a business: you need a vision of what you hope to achieve. You don&rsquo;t have to understand how to achieve it today, but it should help inform direction and help set priorities.</p>\\n<p>Your vision should not be one of those things you just write and leave to gather dust, it should be considered every time you need to make an important decision in your business.</p>\\n</div>\\n</div>\\n</div>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"question\":\"When I imagine my business I hope:\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":\"To work mostly alone but profitably\",\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"To make a lot of money\",\"value\":\"To make a lot of money\"},{\"title\":\"To use my creativity\",\"value\":\"To use my creativity\"},{\"title\":\"To have more flexibility in my life\",\"value\":\"To have more flexibility in my life\"},{\"title\":\"To work mostly alone but profitably\",\"value\":\"To work mostly alone but profitably\"},{\"title\":\"To build my company with partners and employees\",\"value\":\"To build my company with partners and employees\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Here’s my BHAV (Big, Hairy, Audacious Vision):\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":\"Even if it seems unattainable at first glance that’s perfectly all right. It is what you envision, after all.\"},{\"fixed\":false,\"question\":\"My achievement timeframe:\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":\"How long is the time period within which you expect to achieve the goal that you have envisioned?\"}]},{\"title\":\"Test your Vision\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"question\":\"Is it huge, incredible and bold?\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Yes\",\"value\":\"Yes\"},{\"title\":\"Not Quite\",\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Is it specific, clear and concise?\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Yes\",\"value\":\"Yes\"},{\"title\":\"Could be better\",\"value\":\"Not Quite\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":\"Will anyone who reads your BHAV be able to grasp it at first look without any need for questions or clarifications?\"},{\"fixed\":false,\"question\":\"Is it future-oriented?\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Yes\",\"value\":\"Yes\"},{\"title\":\"No\",\"value\":\"Not Quite\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":null}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"question\":\"Write a note to yourself, based on the just concluded exercise\",\"showQuestion\":true,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'My Business Vision',74,'2021-07-01 12:56:49','2021-07-07 19:46:01','worksheet','active',NULL,NULL,44,NULL,'null',NULL),
	(134,'[{\"title\":null,\"description\":\"<div class=\\\"page\\\" title=\\\"Page 9\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p>Your Mission Statement provides a short summary of your business&rsquo; purpose and focus. Choose your words wisely and use terms that are easily understood and relevant to your business. Buzzwords and jargon are generally ineffective in a mission statement, because when your mission is hard to remember, it&rsquo;s difficult for team members to align their daily activities with the goals outlined.</p>\\n</div>\\n</div>\\n</div>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"What do we do?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":\"Clearly outline the main purpose of your organisation, and what they do.\",\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"How do we do it?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":\"Mention how you plan on achieving the mission\"},{\"fixed\":false,\"question\":\"Who do we do it for?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":\"Clearly state the audience of your mission\"},{\"fixed\":false,\"question\":\"What value are we bringing?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":\"Outline the benefits and values of your mission\"},{\"fixed\":false,\"question\":\"Based on the above, here\'s my mission statement:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":null}]},{\"title\":\"Test your Mission Statement\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"Could my competitors use exactly the same statement?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Perhaps\"},{\"title\":\"Impossible!\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Does it distinguish us from all other businesses?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"In some way\"},{\"title\":\"No\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":null},{\"fixed\":false,\"question\":\"If I gave an employee or customer a blind screening test, asking her to read our mission statement and four others without identifying which is which, would she be able to tell which mission statement was ours?\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Yes\"},{\"title\":\"Not Quite\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":null}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"Share a passionate letter to your future self, clearly stating why you have embarked on this journey:\",\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'My Business Mission',74,'2021-07-01 13:25:00','2021-07-01 13:25:00','worksheet','draft',NULL,NULL,44,0,NULL,NULL),
	(144,'[{\"title\":null,\"showSection\":false,\"description\":\"<div class=\\\"page\\\" title=\\\"Page 11\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p>Your business values define how your business will interact with others and how audiences connect with your business. Ideally, your core values should help you make decisions, like hiring or letting people go, while also prioritizing goals and plans for the business.</p>\\n<p class=\\\"p1\\\">As we build our businesses, it is commonplace to focus on what our businesses will achieve for us. However, we should also consider how our businesses will impact others: our employees, customer, the environment and our communities. Typically, for most entrepreneurs, the business values they want their company to project are part of their inspiration for getting started in the first place.</p>\\n<p class=\\\"p1\\\">Incorporating your values into your business will help you build a company that gives you greater satisfaction int e first place, and quite possibly, a more successful company. Be cautious however, that as you build your business around your values, you do not impose your personal beliefs (especially religious or political beliefs) on others.</p>\\n</div>\\n</div>\\n</div>\",\"questions\":[{\"fixed\":false,\"question\":\"What parts of my business am I most proud of?\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"What is important to me/us?\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"What will help guide me/us when faced with a difficult business decision?\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"Test your Business Values\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"Is this something I’ll still believe in 5 years? 10 years?\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Yes\"},{\"title\":\"Maybe not\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Is this something that I’m willing to hire, fire or partner based on?\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Definitely!\"},{\"title\":\"Perhaps Not\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"Is this something I can apply to customer relations?\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Yes\"},{\"title\":\"No\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"Write your personal value statement and try to connect it with your business values\",\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'My Business Values',74,'2021-07-02 09:04:52','2021-07-02 09:05:40','worksheet','draft',NULL,NULL,44,NULL,NULL,NULL),
	(154,'[{\"title\":null,\"showSection\":false,\"description\":\"<div class=\\\"page\\\" title=\\\"Page 15\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p><em>&ldquo;Anything that won&rsquo;t sell, I don&rsquo;t want to invent.&rdquo; &ndash; Thomas Edison</em></p>\\n<p>It is easier to get a piece an existing market than to create a new one. The iPod wasn&rsquo;t the first digital music player; Google wasn&rsquo;t the first search engine; Facebook wasn&rsquo;t the first social media platform. There are lots of advantages to being a follower.</p>\\n<p>Please read the attached guide on <strong>Developing your Business Concept</strong> for detailed insight on how to identify your strategic position.</p>\\n<p>&nbsp;</p>\\n<p>Good luck!</p>\\n</div>\\n</div>\\n</div>\",\"questions\":[]},{\"title\":\"My Business Concept\",\"showSection\":false,\"description\":null,\"questions\":[{\"fixed\":false,\"question\":\"My primary business activity is:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Retail\"},{\"title\":\"Manufacturing\"},{\"title\":\"Services\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"My industry is:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"I sell my products/services:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Online\"},{\"title\":\"Offline\"},{\"title\":\"Both\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"My four (4) core products/services are:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"My Customer Segment\",\"showSection\":false,\"description\":\"<div class=\\\"page\\\" title=\\\"Page 15\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p><em>&ldquo;Want to know one sure way to fail in small business? Try to sell to everyone!&ldquo;</em>- Oluchi Igbojekwe</p>\\n<p>A key to small business success is carving out a niche, rather than competing for every customer; small businesses just don&rsquo;t have the resources of time or money to be generalist.</p>\\n</div>\\n</div>\\n</div>\",\"questions\":[{\"fixed\":false,\"question\":\"My ideal customer is:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Male\"},{\"title\":\"Female\"},{\"title\":\"Baby\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"My customer\'s age falls within:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"<5 Years\"},{\"title\":\"<11 Years\"},{\"title\":\"12-17 Years\"},{\"title\":\"18-34 Years\"},{\"title\":\"35-50 Years\"},{\"title\":\"50 - 70 Years\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"My customer is:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Married\"},{\"title\":\"Single\"},{\"title\":\"Both\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"My customer\'s monthly earning:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":\"e.g: N10,000\",\"hint\":null},{\"fixed\":false,\"question\":\"My customer works as:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":\"e.g. Engineer, Entrepreneur\",\"hint\":null},{\"fixed\":false,\"question\":\"My customer lives in:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":\"E.g. Lagos, Canada\",\"hint\":null},{\"fixed\":false,\"question\":\"My customer wants the following 3 benefits from my product/service\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"My customer will purchase my product/service at this frequency:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":\"e.g. daily, monthly\",\"hint\":null}]},{\"title\":\"My Unique Value Proposition (UVP)\",\"showSection\":false,\"description\":\"<div class=\\\"page\\\" title=\\\"Page 17\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p><em>&ldquo;The more you understand about your own company and how you differ from others, the better you are able to compete.&rdquo;</em></p>\\n<p>Understanding the needs, interests, habits, and preferences of your customers is the key to providing exceptional customer experiences.<br />Your UVP helps you connect with your target market by articulating your value to your customer and what makes you different.</p>\\n</div>\\n</div>\\n</div>\",\"questions\":[{\"fixed\":false,\"question\":\"Briefly summarize your customer’s pain point and how your product/service solves it:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"long\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'Conceptualizing your Business',74,'2021-07-02 09:16:16','2021-07-02 10:45:42','worksheet','draft',NULL,NULL,44,NULL,NULL,NULL),
	(164,'[{\"title\":null,\"description\":\"<p class=\\\"p1\\\">Developing a solid marketing plan requires a good understanding of the marketplace, and this understanding is dependent on your research abilities in finding critical business information, whether it be about your industry, target market, competitors, or other business information you will need to help you build your business and make decisions.</p>\\n<p class=\\\"p1\\\">The worksheet below adopts a number of frameworks to answer critical business questions about your customer profile, competitors, and external issues that could impact your business.</p>\\n<p class=\\\"p1\\\">&nbsp;</p>\\n<div class=\\\"page\\\" title=\\\"Page 18\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p>Please read our guide on <strong>Developing your Marketing Plan</strong> for detailed insight on how to align your resources and capabilities to the requirements of the environment in which you operate.</p>\\n</div>\\n</div>\\n</div>\",\"showSection\":false,\"questions\":[]},{\"title\":\"My Target Market\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"Briefly define your target market:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"Typically, your customers cut across different categories that grows as you get closer to the end user, give yourself a competitive edge by thinking of each of these customers and plan for their needs and motivation.\",\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Briefly describe your customer persona:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"While your target audience encompasses the elements that show what different groups of people have in common, the customer persona looks for differentiating factors .i.e what makes each person within a certain demographic unique? Simply put, your ideal customer is the one who benefits the most from what you’re selling.\"},{\"fixed\":false,\"question\":\"What is the estimated size of your market?\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":\"100\",\"hint\":\"This helps to determine if there are enough customers to serve\"},{\"fixed\":false,\"question\":\"My market is:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"single\",\"limit\":1,\"options\":[{\"title\":\"Declining\"},{\"title\":\"Increasing\"}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"At what rate?\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":\"e.g. 15%\",\"hint\":null}]},{\"title\":\"My Situational Analysis: SWOT\",\"description\":\"<div class=\\\"page\\\" title=\\\"Page 19\\\">\\n<div class=\\\"section\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p>SWOT Analysis is the most renowned tool for audit and analysis of the overall strategic position of the business and its environment. Its key purpose is to identify the strategies that will best align an organization&rsquo;s resources and capabilities to the requirements of the <span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">environment in which it operates.</span></p>\\n<p>&nbsp;</p>\\n<p><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">Let\'s get to it, shall we?</span></p>\\n</div>\\n</div>\\n</div>\\n</div>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"Top 5 strengths of my business:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"These are what you are well versed in or what you have expertise in\",\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Top 5 weaknesses of my business:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"Qualities that prevent your business from accomplishing its mission and achieving its full potential.\"},{\"fixed\":false,\"question\":\"Top 5 opportunities for my business:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"Presented by the environment within which your business operates\"},{\"fixed\":false,\"question\":\"Top 5 threats to my business:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"Conditions in external environment that jeopardize the reliability and profitability of your business.\"}]},{\"title\":\"My Industry Analysis: Competitor\",\"description\":\"<div class=\\\"page\\\" title=\\\"Page 20\\\">\\n<div class=\\\"section\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p class=\\\"p1\\\">The purpose of the competitive analysis is to determine the strengths and weaknesses of the competitors within your market, then based on that develop strategies that will provide you with a distinct advantage, and barriers that prevent potential competition from entering your market and any other <span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">weaknesses that can be exploited within the product development cycle.</span></p>\\n<p class=\\\"p1\\\">&nbsp;</p>\\n<p class=\\\"p1\\\"><em>A competitor\'s strengths and weaknesses are usually based on the presence and absence of key assets and skills needed to compete in the market</em>&mdash; Oluchi Igbojekwe</p>\\n</div>\\n</div>\\n</div>\\n</div>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"question\":\"My top 5 competitors\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":\"Note that competition comes in several forms: direct, online, the big guys, alternatives, potential competitors etc.\",\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Top 5 similarities:\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"What can I learn from them?\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"How can I differentiate from them?\",\"response\":null,\"responses\":[],\"showQuestion\":false,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":\"\",\"placeholder\":\"\",\"responses\":[],\"response_count\":\"\"}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":\"\",\"response\":\"\"}],\"result\":null,\"type\":\"multiple\",\"limit\":1,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"placeholder\":null,\"hint\":null}]}]',NULL,'MY MARKETING PLAN',74,'2021-07-02 10:48:43','2021-07-02 11:49:00','worksheet','draft',NULL,NULL,44,0,NULL,NULL),
	(184,'[{\"title\":\"Section one\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":null,\"addSubQuestion\":false,\"subQuestion\":[{\"question\":null,\"placeholder\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"asPlaceholders\":false,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]',NULL,'Template',14,'2021-07-05 15:24:34','2021-07-05 15:24:43','worksheet','draft',NULL,NULL,4,NULL,NULL,NULL),
	(204,'[{\"title\":\"Quiz Time\",\"description\":\"<p>Answer all questions as fast as possible<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 2 + 2 ?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"2\"},{\"value\":\"4\"},{\"value\":\"6\"},{\"value\":\"8\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"4\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 2 X 3?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"6\"},{\"value\":\"5\"},{\"value\":\"8\"},{\"value\":\"9\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"6\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 5 -3\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"2\"},{\"value\":\"6\"},{\"value\":\"4\"},{\"value\":\"1\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"2\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Solve all the equations below\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"3*3\",\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":\"4\"},{\"value\":\"5\"},{\"value\":\"8\"},{\"value\":\"99\"}],\"answer\":null,\"answers\":[{\"value\":\"9\"}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null},{\"show\":false,\"question\":\"5 + 6\",\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":\"11\"},{\"value\":\"12\"},{\"value\":\"14\"},{\"value\":\"15\"}],\"answer\":null,\"answers\":[{\"value\":\"11\"}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5}]},{\"title\":\"Section two\",\"description\":\"<p>This is a description of section two<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"How are you?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Briefly state\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Describe all these about you\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Health\",\"response\":null},{\"placeholder\":\"Mentality\",\"response\":null},{\"placeholder\":\"Passion\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":true,\"question\":\"List 3 examples\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"Health\",\"placeholders\":[{\"placeholder\":\"One\",\"response\":null},{\"placeholder\":\"Two\",\"response\":null},{\"placeholder\":\"Three\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null},{\"show\":true,\"question\":\"Mental\",\"placeholders\":[{\"placeholder\":\"One\",\"response\":null},{\"placeholder\":\"Two\",\"response\":null},{\"placeholder\":\"Three\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My Quiz',14,'2021-07-07 16:50:37','2021-07-08 01:34:43','quiz','active',NULL,NULL,4,30,'{\"grading\":true,\"correct_answer\":false,\"time\":false}',NULL),
	(214,'[{\"title\":\"Quiz Time\",\"description\":\"<p>Answer all questions as fast as possible<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 2 + 2 ?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"2\"},{\"value\":\"4\"},{\"value\":\"6\"},{\"value\":\"8\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"4\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 2 X 3?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"6\"},{\"value\":\"5\"},{\"value\":\"8\"},{\"value\":\"9\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"6\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is 5 -3\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"2\"},{\"value\":\"6\"},{\"value\":\"4\"},{\"value\":\"1\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":\"2\"}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Solve all the equations below\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"3*3\",\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":\"4\"},{\"value\":\"5\"},{\"value\":\"8\"},{\"value\":\"99\"}],\"answer\":null,\"answers\":[{\"value\":\"9\"}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null},{\"show\":false,\"question\":\"5 + 6\",\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":\"11\"},{\"value\":\"12\"},{\"value\":\"14\"},{\"value\":\"15\"}],\"answer\":null,\"answers\":[{\"value\":\"11\"}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5}]},{\"title\":\"Section two\",\"description\":\"<p>This is a description of section two<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"How are you?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Briefly state\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Describe all these about you\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":\"Health\",\"response\":null},{\"placeholder\":\"Mentality\",\"response\":null},{\"placeholder\":\"Passion\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":5},{\"fixed\":false,\"showQuestion\":true,\"question\":\"List 3 examples\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"Health\",\"placeholders\":[{\"placeholder\":\"One\",\"response\":null},{\"placeholder\":\"Two\",\"response\":null},{\"placeholder\":\"Three\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null},{\"show\":true,\"question\":\"Mental\",\"placeholders\":[{\"placeholder\":\"One\",\"response\":null},{\"placeholder\":\"Two\",\"response\":null},{\"placeholder\":\"Three\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[{\"value\":null}],\"response\":null,\"responses\":[{\"response\":null}],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"value\":null}],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My Assignment',14,'2021-07-07 16:50:37','2021-07-08 01:34:43','assignment','active',NULL,NULL,4,30,'{\"grading\":true,\"correct_answer\":false,\"time\":false}',NULL),
	(224,'[{\"title\":\"Getting to know me\",\"description\":\"<p class=\\\"p1\\\" style=\\\"text-align: center;\\\">\\\"Instead of just coasting through life and being reactive to the behaviors and opinions of others,<\\/p>\\n<p class=\\\"p1\\\" style=\\\"text-align: center;\\\">I will get to know myself.\\\"<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"These 3 words describe me perfectly\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Others would use these 5 words to describe me:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"People often come to me to solve this kind of problem:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I am mostly inspired by:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"The most unique thing about me, is:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Given the chance, I would take these two superpowers?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I want others to think this about me:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"I value these five (5) things most:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"In other words, what matters to you most? Values play the biggest role in motivating our choices at work, at home, and in everyday life. Your values can be a combination of moral commitments such as honesty, compassion, integrity etc. or where you find the most joy in life, such as learning, fun, or having diverse experiences.\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I believe my purpose is to:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Think of your purpose as being defined by what makes you feel authentic, excited and passionate. Meanwhile, give some thought to how this purpose might help others, even on a small scale.\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"These are my top goals in the following areas:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business\\/Career\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null}],\"placeholder\":null,\"hint\":\"One for each category\",\"score\":0}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Write an honest letter to your future self, highlighting your strengths and weaknesses. The idea it to demonstrate self-awareness.\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'Getting to know me',74,'2021-07-12 07:02:00','2021-07-18 18:09:03','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(234,'[{\"title\":\"Getting to know me\",\"description\":\"<div class=\\\"font-weight-bold mb-2 mt-2\\\" data-v-0a82314c=\\\"\\\"><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">Congratulations! You&rsquo;re mere weeks away from living the life of your dreams&mdash; purposeful, impactful and productive. We are so excited that the world is about to hear you loud and clear, through your business.<\\/span><\\/div>\\n<div data-v-0a82314c=\\\"\\\">\\n<p class=\\\"p1\\\">Perhaps you have heard by now that running a business is more than a full-time job, and for it to thrive there needs to be a product-market fit, the right branding, strategy, distribution channels etc. but you may not have heard that running a successful business takes self-awareness and round-the-clock physical, emotional and spiritual commitment.<\\/p>\\n<p class=\\\"p1\\\">Yes, sometimes all a business really needs to be successful is alignment with your inner man and commitment&mdash; lots of it, because when you own your own business you are not obligated to achieve your goals, heck, no one even knows them, so your motivation must come from within. Ultimately, it is easier to stay on course when those business goals are in alignment with who you really are.<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">We believe this, and that is why I start right here&mdash; discovering what is within.<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">So, how well do you really know yourself?<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">We are all mostly aware of the things that society wants us to do, or the people our families want us to be. We hear it so much that sometimes, it&rsquo;s easy to get caught up in projections of who we are; never quite discovering or perhaps losing touch with our core values, needs, and desires.<\\/p>\\n<p class=\\\"p1\\\">Well, I am here to tell you that if you don&rsquo;t know yourself very well, it&rsquo;s difficult to choose a life path that makes you feel happy and fulfilled, and while growing a business is awesome, do you know what&rsquo;s even better? Being at peace with who you really are while doing so.<\\/p>\\n<p class=\\\"p1\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">Therefore, I implore you to answer the questions in this exercise very sincerely and with openness to whatever you find. Give thoughtful answers but do not be consumed by trying to find the one that present you the way you want to be seen, because that just defeats the purpose of this. Be honest enough to allow yourself to be surprised by some aspects of who you are. That should be exciting!<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">Know this&mdash; whatever you find out about yourself today isn&rsquo;t a death sentence; life is dynamic, and you will always have the chance to re-write your story&mdash; especially here, just edit! lol.<\\/p>\\n<p class=\\\"p1\\\">The aim of this phase of the program is to arm you with self-awareness through a journey of self-reflection. It is our hope that in doing this exercise, you learn to identify your own voice in a noisy world.<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">Above all, I hope that empowered with this self-awareness, you will be led to tell your own story through your entrepreneurial journey&mdash; the products and services that you develop to serve humanity. We cant wait to see it manifest, so let&rsquo;s get started!<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">Affirmation:&nbsp;\\\"<em>Instead of just coasting through life and being reactive to the behaviors and opinions of others, I will get to know myself.&rdquo;<\\/em><\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<\\/div>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Are you excited to get to know yourself?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Couldn\'t be happier!\"},{\"value\":\"Proceeding with caution\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'A journey of self-reflection',74,'2021-07-12 07:05:53','2021-07-18 18:59:35','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(244,'[{\"title\":\"The people in my life\",\"description\":\"<p class=\\\"p1\\\" style=\\\"text-align: center;\\\"><em>&ldquo;Keep company with people who uplift you, whose presence call forth your best.&rdquo;<\\/em><\\/p>\\n<p class=\\\"p1\\\" style=\\\"text-align: center;\\\">Epictetus<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"The people in my inner circle:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business\\/Career\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null}],\"placeholder\":null,\"hint\":\"One for each category\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"These people hold me most accountable:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business\\/Career\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null}],\"placeholder\":null,\"hint\":\"One for each category\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"These people inspire me most:\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":true,\"question\":\"Spirituality\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Family Life\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Wellness\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Love\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"Business\\/Career\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"Financial\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"Social\",\"placeholders\":[{\"placeholder\":\"Name\",\"response\":null},{\"placeholder\":\"Trait I admire\",\"response\":null},{\"placeholder\":\"How I can apply it in my life\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Write an honest letter to yourself, highlighting the people have had the most influence in your life; positive or negative. Understand that nobody has the power to make you a specific way and acknowledge the role you played in getting here.\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'The people in my life',74,'2021-07-13 20:16:45','2021-07-18 18:18:13','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(254,'[{\"title\":\"The Road Ahead\",\"description\":\"<p><em>\\\"Direction is so much more important than speed; many are going nowhere, fast!\\\"<\\/em><\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"I see myself here:\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":true,\"question\":\"In 2 years:\",\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business\\/Career\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"In 5 years:\",\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business\\/Career\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"In 10 years\",\"placeholders\":[{\"placeholder\":\"Spirituality\",\"response\":null},{\"placeholder\":\"Family Life\",\"response\":null},{\"placeholder\":\"Wellness\",\"response\":null},{\"placeholder\":\"Love\",\"response\":null},{\"placeholder\":\"Business\\/Career\",\"response\":null},{\"placeholder\":\"Financial\",\"response\":null},{\"placeholder\":\"Social\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Reflection\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Write a letter from your future self highlighting your achievements and how you feel about the life you have.\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'The Road Ahead',74,'2021-07-13 20:23:56','2021-07-18 18:38:54','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(264,'[{\"title\":\"Self-affirmation\",\"description\":\"<p><span class=\\\"text-dark-green fs12\\\">When the vision is clear, the results will appear.<\\/span><\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Write a letter to your future self (10 Years from now).\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'Self-affirmation',74,'2021-07-15 07:16:03','2021-07-18 18:57:26','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(274,'[{\"title\":\"Reflection\",\"description\":\"<p>Time spent on self-reflection is never wasted, it is an intimate date with yourself.<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"What could be the impact of starting or growing my business in these areas of my life and how can I mitigate it?\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"My Spirituality:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Family Life:\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Love Life\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Social Life\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":false,\"question\":\"My Wellness\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"My Finances\",\"placeholders\":[{\"placeholder\":\"Impact\",\"response\":null},{\"placeholder\":\"Mitigation\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Self-Reflection\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Write a letter to yourself summarizing the trade-offs for your success. How bad do you want it and what are you willing to give up to get there?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'Self-reflection',74,'2021-07-15 07:35:27','2021-07-18 18:56:56','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(284,'[{\"title\":\"My Bright Idea\",\"description\":\"<p class=\\\"p1\\\">At some point in their business lives, all entrepreneurs are inspired&mdash; by an idea, a person or an opportunity. That inspiration not only gets you started; it also keeps you going. What inspired this business idea? What excites you about your business idea? If you have two or three ideas, what do you like best about each one? Where did the idea come from? How has it evolved since you started the process of turning the idea into a business?<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">By looking at how you initially got inspiration for your business, you can take the next step toward determining how you might get others excited about your business as well. You will find it useful to have a record of what initially inspired you, to which you can refer from time to time, especially as your business grows.<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is my business idea?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"How did I come up with it?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What excites me about it?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My Bright Idea',74,'2021-07-19 10:40:26','2021-07-19 12:53:48','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(294,'[{\"title\":\"Defining your business vision\",\"description\":\"<p class=\\\"p1\\\">If you had an idea to build a house, before you drew up the blueprints, laid the foundation, or even bought the land, you&rsquo;d first have a vision of what you&rsquo;d want the house to be: big or small, one story or two and the location. You&rsquo;d have a vision of your future home.<\\/p>\\n<p class=\\\"p1\\\">The same principle applies to building a business: you need a vision of what you hope to achieve.<\\/p>\\n<p class=\\\"p1\\\">When you imagine your business, what do you hope for? To make a lot of money? To use your creativity? Have more flexibility in your life? Do you see yourself working alone or building a company with employees? Do you hope your company grows very large or do you want it to stay small?<\\/p>\\n<p class=\\\"p1\\\">As you launch your new business, it is important to clarify and evaluate your business vision. What is your long term vision? What are your personal goals? What do you see as a business opportunity? Then from here you can begin to define your business specifics , such as what it does, whom it serves, how it differs from competition etc.&nbsp;<\\/p>\\n<p class=\\\"p1\\\">While some entrepreneurs are defined as &lsquo;visionaries&rsquo; who conceive grand schemes or bold new inventions, you must understand that a business vision does not have to be revolutionary. The most important part is that you identify what you see your business becoming: what it will do or make, how it will grow and compete, how big it will get.<\\/p>\\n<p class=\\\"p1\\\"><strong>&ldquo; Visioning is a process, not an output.&rdquo;<\\/strong><\\/p>\\n<p class=\\\"p1\\\">A vision should not be unchanging, over time, your business vision could change. As you gain experience and confidence, you may change the nature of your products or services, even your personal goals may evolve or if the world presents new opportunities, then the vision should be updated. Nevertheless, clarifying your current business vision and articulating your specific business concept gives you a stronger start as you begin building your business.<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">&nbsp;<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Ready to get started?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes!\"},{\"value\":\"Need more time\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"My Big Hairy Audacious Vision\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"When I imagine my business I hope:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"To make a lot of money\"},{\"value\":\"To use my creativity\"},{\"value\":\"To have more flexibility in my life\"},{\"value\":\"To work mostly alone but profitably\"},{\"value\":\"To build my company with partners and employees\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Here is my Big Hairy Audacious Vision:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Even if it seems unattainable at first glance that\\u2019s perfectly all right. It is what you envision, after all.\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"My achievement timeframe:\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"Duration:\",\"placeholders\":[{\"placeholder\":\"e.g. 6 Months\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"Set a date:\",\"placeholders\":[{\"placeholder\":\"e.g. 06\\/07\\/2022\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"How long is the time period within which you expect to achieve the goal that you have envisioned?\",\"score\":0}]},{\"title\":\"Test your vision\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"Is it huge, incredible and bold?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Is it specific, clear and concise?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Will anyone who reads your vision be able to grasp it at first look without any need for questions or clarifications?\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Is it future-oriented\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My Business Vision',74,'2021-07-19 10:55:03','2021-07-19 12:53:31','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(304,'[{\"title\":\"Defining your business mission\",\"description\":\"<p class=\\\"p1\\\">A mission is a statement of why an organization exists. It puts forth how the company, business, or organization intends to achieve a realization of their vision.&nbsp;Even big companies have mission and vision issues. Take The Walt Disney Company. Disney used to have a very clear mission statement: &ldquo;Make People Happy.&rdquo; It didn&rsquo;t say make people happy through animation, or theme parks, or interactive experiences. Those are details. Its mission was simply to make people happy. To me, clarity of mission doesn&rsquo;t get better than this.<\\/p>\\n<p class=\\\"p1\\\">Here&rsquo;s how to get started on defining your business mission:<\\/p>\\n<ol>\\n<li class=\\\"p1\\\"><strong>Define your purpose: <\\/strong>Ask yourself why your company exists.<\\/li>\\n<li class=\\\"p1\\\"><strong style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">Be specific: <\\/strong><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">Buzzwords and jargon are generally ineffective in a mission statement. If you tell people that you &ldquo;deliver business efficiencies using optimized software solutions,&rdquo; they&rsquo;re unlikely to commit this phrase to memory. In plain man terms, what exactly do you do?<\\/span><\\/li>\\n<li class=\\\"p1\\\"><strong style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">Inspire: <\\/strong><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">It can also be powerful to include an inspirational element. This element can encourage your team members and partners to work toward your vision. <\\/span><\\/li>\\n<li class=\\\"p1\\\"><strong style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">Keep it succinct: <\\/strong><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">try to be as concise as possible.<\\/span><\\/li>\\n<\\/ol>\\n<p class=\\\"p1\\\">Once you&rsquo;ve written a mission statement worthy of your business, your job is only half-finished. A mission statement is most effective when you impart its message to others, and when they align their actions with the mission&rsquo;s vision. An impactful statement can serve as a reminder of why you founded your business, and a mission statement worthy of memorization can guide you for years to come.<\\/p>\\n<p class=\\\"p3\\\">&nbsp;<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Ready to define your business mission?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yessur!\"},{\"value\":\"Need more time\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"My business mission\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What do we do?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Clearly outline the main purpose of your organization, and what they do.\",\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"How do we do it?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Mention how you plan on achieving the mission\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Whom do we do it for?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Clearly state the audience of your mission\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"What value are we bringing?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Outline the benefits and values of your mission\",\"score\":0}]},{\"title\":\"My mission statement\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Based on the foregoing, here is my mission statement:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Test your mission statement\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"Could my competitors use exactly the same statement?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Does it distinguish us from all other businesses?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"If I gave an employee or customer a blind screening test, asking her to read our mission statement and four others without identifying which is which, would she be able to tell which mission statement was ours?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My Business Mission',74,'2021-07-19 11:00:54','2021-07-19 12:54:44','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(314,'[{\"title\":\"Defining my business values\",\"description\":\"<p class=\\\"p1\\\">Values play the biggest role in motivating our choices at work, at home, and in everyday life. Your values can be a combination of moral commitments such as honesty, compassion,&nbsp;integrity etc. or where you find the most joy in life, such as learning, fun, or having diverse experiences.<\\/p>\\n<p class=\\\"p1\\\">As we build our businesses, it is commonplace to focus on what our businesses will achieve for us. However, we should also consider how our businesses will impact others: our employees, customer, the environment and our communities. Typically, for most entrepreneurs, the business values they want their company to project are part of their inspiration for getting started in the first place.<\\/p>\\n<p class=\\\"p1\\\">Incorporating your values into your business will help you build a company that gives you greater satisfaction in the first place, and quite possibly, a more successful company. Be cautious however, that as you build your business around your values, you do not impose your personal beliefs (especially religious or political beliefs) on others.<\\/p>\\n<p class=\\\"p1\\\">The worksheet below will help you clarify the values you would like to incorporate into your business.<\\/p>\",\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Are you pumped up for this?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Errr\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"My business values\",\"description\":null,\"showSection\":false,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What parts of my business am I most proud of?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is important to me\\/us?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"What will help guide me\\/us when faced with a difficult business decision?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]},{\"title\":\"Test your values\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"Is this something I\\u2019ll still believe in 5 years? 10 years?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Is this something that I\\u2019m willing to hire, fire or partner based on?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Is this something I can apply to customer relations?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yes\"},{\"value\":\"Not Quite\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My business values',74,'2021-07-19 12:21:26','2021-07-19 12:58:08','worksheet','active',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(324,'[{\"title\":null,\"description\":\"<p class=\\\"p1\\\">OK, so you have your inspiration, and you&rsquo;ve seen an opportunity in the market. . . now how do those translate into your particular business concept? Exactly what are you going to sell? To whom? How?<\\/p>\\n<p class=\\\"p1\\\"><span class=\\\"s1\\\">Meeting needs<\\/span> is the basis of all business. You can devise a wonderful new machine, but if it doesn&rsquo;t address some real and important need or desire, people won&rsquo;t buy it, and your business will fail. Even Thomas Edison recognized this fact when he said, &ldquo;Anything that won&rsquo;t sell, I don&rsquo;t want to invent.&rdquo;<\\/p>\\n<p class=\\\"p1\\\">People often think that to be successful in business, then they need to invent the next big thing. Granted, innovation scores us points, but did you know that innovation can also mean any of the following:<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<ul>\\n<li class=\\\"p1\\\">Determining how existing product\\/services can meet new needs in the marketplace, or how a new product can meet an existing need in the marketplace;<\\/li>\\n<\\/ul>\\n<p>&nbsp;<\\/p>\\n<ul>\\n<li class=\\\"p1\\\">An improvement on an existing product or service&mdash; it could be more features, lower price, greater reliability, faster speed, increased convenience or enhanced technology;<\\/li>\\n<\\/ul>\\n<p>&nbsp;<\\/p>\\n<ul>\\n<li class=\\\"p1\\\">Identified an underserved or new market<span class=\\\"Apple-converted-space\\\">&nbsp; <\\/span>i.e. one where there is greater demand than supply; or as a result of big companies neglecting smaller portions of their customer base.<\\/li>\\n<\\/ul>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\">Ultimately, your business concept should be founded on one or more of these, and if it isn&rsquo;t, then you should ask yourself how your company will be truly competitive.<\\/p>\\n<p class=\\\"p1\\\">Your business concept establishes a solid foundation for your business, even if you&rsquo;re a one man business, you will find it beneficial to develop a business concept. We&rsquo;re going to make sure you get off to the right start, so this week is devoted to establishing a strong foundation for your your business. You will be more successful if you have a clear concept of critical business aspects such as your target market, unique value proposition etc.<\\/p>\\n<p class=\\\"p1\\\">Don&rsquo;t worry if you&rsquo;re not entirely certain about the answers to your Business Concept Worksheet, fill in the answers anyway, they will guide you in developing strategies such as your marking sales and financial plan and any other research you will need to do. Consider this the blueprint phase of your building project.<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p1\\\"><strong>BizGuruh TIP:<\\/strong><\\/p>\\n<p class=\\\"p1\\\">It is easier to get a piece an existing market than to create a new one. Remember that creating a market for a brand new typeof product or service is difficult, time-consuming and expensive. The iPod wasn&rsquo;t the first digital music player; Google wasn&rsquo;t the fist search engine; Facebook wasn&rsquo;t the first social media platform. There are lots of advantages to being a follower.<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\\n<p class=\\\"p2\\\">&nbsp;<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"Are you ready to launch your business?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Yessur!\"},{\"value\":\"Let\'s Go!\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'A guide to developing your business concept',74,'2021-07-23 10:56:06','2021-07-23 12:34:24','worksheet','draft',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(334,'[{\"title\":\"About my business\",\"description\":null,\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"I am a\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Manufacturer\"},{\"value\":\"Retailer\"},{\"value\":\"Service Provider\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"I am in the following industry:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"e.g. Beauty, Food etc.\",\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"I sell my product\\/services\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Online\"},{\"value\":\"Offline\"},{\"value\":\"Both\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"My core products and services are:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My business overview',74,'2021-07-23 12:45:40','2021-07-26 09:01:44','worksheet','draft',NULL,NULL,44,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(344,'[{\"title\":\"Section One\",\"description\":\"<p>Just tell everything you know about Javascript<\\/p>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"What is javascript?\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Not long answer\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"Methods in Javscript\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":false,\"question\":\"What is a method?\",\"placeholders\":[{\"placeholder\":\"One answer\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null},{\"show\":true,\"question\":\"Types of methods?\",\"placeholders\":[{\"placeholder\":\"Type here\",\"response\":null},{\"placeholder\":\"Type here\",\"response\":null},{\"placeholder\":\"Type here\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"Explain what you understand by Arrays\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"Everything you know\",\"response\":null}],\"placeholder\":null,\"hint\":\"Arrays in javascript\",\"score\":0}]}]',NULL,'Javascript',104,'2021-07-25 20:32:40','2021-07-25 20:32:40','assignment','active',NULL,NULL,54,NULL,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(354,'[{\"title\":\"My ideal customer\",\"description\":\"<div class=\\\"page\\\" title=\\\"Page 15\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p>&ldquo;Want to know one sure way to fail in small business? Try to sell to everyone!&ldquo; A key to small business success is carving out a niche, rather than competing for every customer, small businesses just don&rsquo;t have the resources of time or money to be generalist.<\\/p>\\n<\\/div>\\n<\\/div>\\n<\\/div>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":true,\"question\":\"My ideal customers are:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Suggestions: Men, Women, Girls, Boys, Toddlers, Babies etc.\",\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"My customer falls within the following age range:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"dropdown\",\"limit\":2,\"options\":[{\"value\":\"< 5 Years\"},{\"value\":\"< 11 Years\"},{\"value\":\"12-17 Years\"},{\"value\":\"18-34 Years\"},{\"value\":\"35-50 Years\"},{\"value\":\"50-70 Years\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"Select one below\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"My customer\'s marital status:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"single\",\"limit\":2,\"options\":[{\"value\":\"Married\"},{\"value\":\"Single\"},{\"value\":\"Both\"}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"My customer\'s monthly earning:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":\"e.g. N10,000\",\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"My customer\'s profession:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"e.g. Senior manager, student, Dr etc.\",\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"My customer lives in the following location:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"e.g. Lagos, Ibadan, Onitsha, USA etc.\",\"score\":0},{\"fixed\":false,\"showQuestion\":false,\"question\":\"My customer is seeking these 3 benefits from my products\\/services:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null},{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"e.g. convenience, speed, quality etc.\",\"score\":0},{\"fixed\":false,\"showQuestion\":true,\"question\":\"My customer will purchase my product\\/service at this frequency:\",\"addSubQuestion\":false,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":\"e.g. Weekly, Monthly, Quarterly, Annually etc.\",\"score\":0}]}]',NULL,'My Customer Profile',74,'2021-07-26 09:00:48','2021-07-26 09:00:48','worksheet','draft',NULL,NULL,44,0,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL),
	(364,'[{\"title\":\"How I will compete to win\",\"description\":\"<div class=\\\"page\\\" title=\\\"Page 17\\\">\\n<div class=\\\"layoutArea\\\">\\n<div class=\\\"column\\\">\\n<p><em>&ldquo;The more you understand about your own company and how you differ from others, the better you are able to compete.&rdquo;<\\/em><\\/p>\\n<p>Understanding the needs, interests, habits, and preferences of your customers is the key to providing exceptional customer experiences. Your UVP helps you connect with your target market by articulating your value to your customer and what makes you different.<\\/p>\\n<\\/div>\\n<\\/div>\\n<\\/div>\",\"showSection\":true,\"questions\":[{\"fixed\":false,\"showQuestion\":false,\"question\":\"Briefly summarize your customer\\u2019s pain point and how your product solves it:\",\"addSubQuestion\":true,\"subQuestion\":[{\"show\":true,\"question\":null,\"placeholders\":[{\"placeholder\":\"My Customer\",\"response\":null},{\"placeholder\":\"Their problem\",\"response\":null},{\"placeholder\":\"How my product\\/service solves it\",\"response\":null}],\"limit\":2,\"options\":[{\"value\":null}],\"answer\":null,\"answers\":[],\"response\":null,\"responses\":[],\"response_count\":null}],\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"limit\":2,\"options\":[{\"value\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[],\"placeholders\":[{\"placeholder\":null,\"response\":null}],\"placeholder\":null,\"hint\":null,\"score\":0}]}]',NULL,'My Unique Value Proposition',74,'2021-07-26 09:08:19','2021-07-26 09:08:19','worksheet','draft',NULL,NULL,44,0,'{\"grading\":false,\"correct_answer\":false,\"time\":false}',NULL);

/*!40000 ALTER TABLE `question_templates` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table questionnaires
# ------------------------------------------------------------

DROP TABLE IF EXISTS `questionnaires`;

CREATE TABLE `questionnaires` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `module_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaires_course_id_foreign` (`course_id`),
  KEY `questionnaires_module_id_foreign` (`module_id`),
  KEY `questionnaires_organization_id_foreign` (`organization_id`),
  CONSTRAINT `questionnaires_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `questionnaires_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `questionnaires_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `questionnaires` WRITE;
/*!40000 ALTER TABLE `questionnaires` DISABLE KEYS */;

INSERT INTO `questionnaires` (`id`, `content`, `module`, `title`, `start`, `end`, `course_id`, `module_id`, `organization_id`, `created_at`, `updated_at`, `type`)
VALUES
	(24,'[{\"title\":\"MY MVPS\",\"questions\":[{\"fixed\":false,\"question\":\"My Business Mission\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"My Business Vision\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"My Business Values\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"MY SITUATIONAL ANALYSIS:AWOT\",\"questions\":[{\"fixed\":false,\"question\":\"Strengths\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Weakness\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"Opportunities\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"Threats\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"INDUSTRY ANALYSIS: COMPETITOR\",\"questions\":[{\"fixed\":false,\"question\":\"Who are your competitors?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"What are your similarities?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"What can you learn from them?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"How can you differentiate from them?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"MY MARKETING STRATEGY\",\"questions\":[{\"fixed\":false,\"question\":\"Short-term marketing goal\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Mid-term marketing goal\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null},{\"fixed\":false,\"question\":\"Long-term marketing goal\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null}]},{\"title\":\"IMPLEMENTATION AND CONTROL\",\"questions\":[{\"fixed\":false,\"question\":\"How will you put your plan into action and monitor results?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]','Business Finannce','Business Society',NULL,NULL,14,NULL,14,'2021-06-09 10:23:33','2021-06-09 10:23:33',NULL),
	(34,'[{\"title\":\"MY MVVs\",\"questions\":[{\"fixed\":false,\"question\":\"My Business Mission\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Why does your company exist and how does it intend to achieve its mission?\",\"hint\":null},{\"fixed\":false,\"question\":\"My Business Vision\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"When you imagine the future of your business what do you hope for?\",\"hint\":null},{\"fixed\":false,\"question\":\"My Business Values\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"How will your business impact others?\",\"hint\":null}]},{\"title\":\"MY SITUATIONAL ANALYSIS: SWOT\",\"questions\":[{\"fixed\":false,\"question\":\"Strengths\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"What distinct features give your organization an edge; basically what are you well versed at?\",\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Weakness\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"What qualities prevent your business from achieving its full potential?\",\"hint\":null},{\"fixed\":false,\"question\":\"Opportunities\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"What opportunities are presented by the environment within which your business operates?\",\"hint\":null},{\"fixed\":false,\"question\":\"Threats\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"What external conditions jeopardize the reliability and profitability of your business?\",\"hint\":null}]},{\"title\":\"INDUSTRY ANALYSIS: COMPETITOR\",\"questions\":[{\"fixed\":false,\"question\":\"Who are your competitors?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"This includes other ways the customer can spend their time and money\",\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"What are your similarities?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Observe their self-descriptions\",\"hint\":null},{\"fixed\":false,\"question\":\"What can you learn from them?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Check out their customer testimonials\\u2014 that\\u2019s where their competitive advantage lies\",\"hint\":null},{\"fixed\":false,\"question\":\"How can you differentiate from them?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Identify the areas where they are most vulnerable\",\"hint\":null}]},{\"title\":\"MY MARKETING STRATEGY\",\"questions\":[{\"fixed\":false,\"question\":\"Short-term marketing goal\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Goals, Timeline & Cost\",\"hint\":null,\"asScore\":false,\"score\":0},{\"fixed\":false,\"question\":\"Mid-term marketing goal\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Goals, Timeline & Cost\",\"hint\":null},{\"fixed\":false,\"question\":\"Long-term marketing goal\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"multiple\",\"options\":[{\"title\":null}],\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":\"Goals, Timeline & Cost\",\"hint\":null}]},{\"title\":\"IMPLEMENTATION AND CONTROL\",\"questions\":[{\"fixed\":false,\"question\":\"How will you put your plan into action and monitor results?\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"long\",\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]','Designing your Small Business Marketing Plan','MY MARKETING PLAN',NULL,NULL,44,NULL,14,'2021-06-09 10:23:33','2021-06-10 11:52:27',NULL),
	(44,'[{\"title\":\"Section One\",\"description\":\"<p>This is my descripttion<\\/p>\",\"questions\":[{\"fixed\":false,\"question\":\"How are you\",\"response\":null,\"responses\":[],\"result\":null,\"type\":\"short\",\"limit\":1,\"options\":[{\"title\":null}],\"showAnswer\":false,\"answer\":null,\"answers\":[{\"title\":null}],\"placeholder\":null,\"hint\":null,\"asScore\":false,\"score\":0}]}]','Introduction','Question Example',NULL,NULL,4,14,14,'2021-06-12 02:16:49','2021-06-12 02:16:49','questionnaire');

/*!40000 ALTER TABLE `questionnaires` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table referrals
# ------------------------------------------------------------

DROP TABLE IF EXISTS `referrals`;

CREATE TABLE `referrals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `referree_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referree_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `referrals_user_id_foreign` (`user_id`),
  KEY `referrals_facilitator_id_foreign` (`facilitator_id`),
  KEY `referrals_admin_id_foreign` (`admin_id`),
  CONSTRAINT `referrals_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `referrals_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `referrals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `referrals` WRITE;
/*!40000 ALTER TABLE `referrals` DISABLE KEYS */;

INSERT INTO `referrals` (`id`, `referree_type`, `referree_id`, `user_id`, `facilitator_id`, `admin_id`, `created_at`, `updated_at`)
VALUES
	(4,'learner',44,4,NULL,NULL,'2021-07-08 12:01:15','2021-07-08 12:01:15');

/*!40000 ALTER TABLE `referrals` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revenues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revenues`;

CREATE TABLE `revenues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `revenue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revenues_course_id_foreign` (`course_id`),
  KEY `revenues_user_id_foreign` (`user_id`),
  KEY `revenues_admin_id_foreign` (`admin_id`),
  KEY `revenues_facilitator_id_foreign` (`facilitator_id`),
  KEY `revenues_organization_id_foreign` (`organization_id`),
  CONSTRAINT `revenues_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revenues_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revenues_facilitator_id_foreign` FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revenues_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revenues_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `revenues` WRITE;
/*!40000 ALTER TABLE `revenues` DISABLE KEYS */;

INSERT INTO `revenues` (`id`, `revenue`, `course_id`, `user_id`, `admin_id`, `facilitator_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,'5000',184,NULL,NULL,NULL,104,'2021-07-26 01:11:49','2021-07-26 01:11:49');

/*!40000 ALTER TABLE `revenues` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table reviews
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reviews`;

CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL,
  `review` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_user_id_foreign` (`user_id`),
  KEY `reviews_course_id_foreign` (`course_id`),
  KEY `reviews_organization_id_foreign` (`organization_id`),
  CONSTRAINT `reviews_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;

INSERT INTO `reviews` (`id`, `score`, `review`, `user_id`, `course_id`, `organization_id`, `created_at`, `updated_at`)
VALUES
	(4,5,'Good course',4,4,14,'2021-06-30 11:13:58','2021-06-30 11:13:58');

/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_organization_id_foreign` (`organization_id`),
  CONSTRAINT `tags_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table todos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `todos`;

CREATE TABLE `todos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `todo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completion_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `facilitator_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `todos` WRITE;
/*!40000 ALTER TABLE `todos` DISABLE KEYS */;

INSERT INTO `todos` (`id`, `todo`, `completion_time`, `status`, `user_id`, `facilitator_id`, `admin_id`, `created_at`, `updated_at`)
VALUES
	(4,'Create Course',NULL,0,NULL,4,NULL,'2021-06-21 11:14:56','2021-06-21 11:14:56'),
	(14,'Complete Worksheet',NULL,1,4,NULL,NULL,'2021-06-30 00:27:33','2021-07-03 01:15:54');

/*!40000 ALTER TABLE `todos` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `profile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification` tinyint(1) DEFAULT '0',
  `referral_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  `interests` longtext COLLATE utf8mb4_unicode_ci,
  `age` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lga` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voice` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `publicId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_organization_id_foreign` (`organization_id`),
  CONSTRAINT `users_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `address`, `bio`, `profile`, `verification`, `referral_code`, `organization_id`, `interests`, `age`, `gender`, `lga`, `state`, `country`, `voice`, `publicId`)
VALUES
	(4,'Kerry Johnson','bizguruh@gmail.com',NULL,'$2y$10$Kda68L16fo37xGim46oOPe1XKBtorKf07bQVC4nJu7I0zqHf2hms6',NULL,'2021-06-03 13:41:28','2021-06-30 11:10:47','415601304',NULL,NULL,'https://res.cloudinary.com/bizguruh-com/image/upload/v1625051445/Uchiha_Itachi_Leandro_De_souza_qqiyl5.jpg',0,'FV2793',14,'[\"Global News\",\"SDGs\",\"Marketing\",\"Business Management\",\"Personal Development\",\"Tech\",\"Gaming\",\"Pop Culture\",\"Politics\",\"Racism\",\"Spirituality\",\"Crypto\",\"New Media\"]','24','male',NULL,'Lagos','NG','1',NULL),
	(14,'Success Ahon','succcy2010@gmail.com',NULL,'$2y$10$wIWvr/VWJP52ShDqII0qTO3QkL./npPm4TylrzcuCFOizfWNvX0Xm',NULL,'2021-06-03 13:41:41','2021-07-12 22:18:27','08102588399',NULL,NULL,NULL,1,'BN9007',14,NULL,NULL,NULL,NULL,'Lagos','NG','1',NULL),
	(34,'Glory Ogbonna','gloryo@gmail.com',NULL,'$2y$10$K3sdSGM8pN4N5iGMh8CMeegnDMXiYtoMUqodUXd/vbDgL3II3nZWO',NULL,'2021-06-21 11:17:47','2021-06-21 11:17:47','070 4031 5228',NULL,NULL,NULL,0,'Glory_Ogbonna_SZ4812',24,NULL,NULL,NULL,NULL,'Lagos','NG','1',NULL),
	(44,'Success Ahon','uccessahon@gmail.com',NULL,'$2y$10$DoCK7XeIDW8pr5mzAyLKh.jrCDGVJnJi2l51Lt.aHBz/T01VlQWRG',NULL,'2021-07-08 12:01:15','2021-07-08 19:53:57','08102588390',NULL,NULL,NULL,1,'success_ahon_8026',14,NULL,NULL,NULL,NULL,'Lagos','NG','1',NULL),
	(54,'Success Ahon','successahon@gmail.com',NULL,'$2y$10$R3t4xQKArwK1wUc7yFbSxeJP5tCgo1EwGQhpuhFr5k4rCC/s4/vX.',NULL,'2021-07-25 12:17:57','2021-07-26 02:15:45','08102588391',NULL,NULL,NULL,1,'success_ahon_9932',104,'[\"Global News\",\"Gaming\",\"Tech\",\"Football\",\"Productivity\",\"Marketing\",\"SDGs\",\"Entrepreneurship\",\"Business Management\",\"Mental health\",\"Global Trends\",\"Politics\",\"Racism\"]',NULL,NULL,NULL,'Lagos','NG','1',NULL),
	(64,'David Komonii','successahonn@gmail.com',NULL,'$2y$10$HCDBuBE.hrsIAjyYmZkVkeIaEuCuOC.XUv1cwIVrfyLthAYJg58Ne',NULL,'2021-07-25 12:59:44','2021-07-25 13:03:49','08166741279',NULL,NULL,NULL,0,'david_komoni4595',104,NULL,NULL,NULL,NULL,'Lagos','NG','1',NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
