CREATE DATABASE  IF NOT EXISTS `bookstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bookstore`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstore
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authorpublisher`
--

DROP TABLE IF EXISTS `authorpublisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorpublisher` (
  `AuthorID` bigint unsigned NOT NULL,
  `PublisherID` bigint unsigned NOT NULL,
  PRIMARY KEY (`AuthorID`,`PublisherID`),
  KEY `fk_authorpublisher_publishers` (`PublisherID`),
  CONSTRAINT `fk_authorpublisher_authors` FOREIGN KEY (`AuthorID`) REFERENCES `authors` (`AuthorID`),
  CONSTRAINT `fk_authorpublisher_publishers` FOREIGN KEY (`PublisherID`) REFERENCES `publishers` (`PublisherID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorpublisher`
--

LOCK TABLES `authorpublisher` WRITE;
/*!40000 ALTER TABLE `authorpublisher` DISABLE KEYS */;
INSERT INTO `authorpublisher` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15);
/*!40000 ALTER TABLE `authorpublisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `AuthorID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Biography` text,
  PRIMARY KEY (`AuthorID`),
  UNIQUE KEY `AuthorID` (`AuthorID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Mark','Twain',NULL),(2,'Marcel','Proust',NULL),(3,'Charles','Darwin',NULL),(4,'Dante','Alighieri',NULL),(5,'Plato','NA',NULL),(6,'Miguel','de Cervantes',NULL),(7,'James','Joyce',NULL),(8,'Karl','Marx',NULL),(9,'Augustine','of Hippo',NULL),(10,'Niccolas','Machiavelli',NULL),(11,'F. Scott','Fitzgerald',NULL),(12,'George','Eliot',NULL),(13,'Adam','Smith',NULL),(14,'Sigmund','Freud',NULL),(15,'Jonathan','Swift',NULL);
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookcomments`
--

DROP TABLE IF EXISTS `bookcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookcomments` (
  `CommentID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `BookID` bigint unsigned DEFAULT NULL,
  `UserID` bigint unsigned DEFAULT NULL,
  `Comments` text,
  `DateStamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`CommentID`),
  UNIQUE KEY `CommentID` (`CommentID`),
  KEY `fk_bookcomments_books` (`BookID`),
  KEY `fk_bookcomments_users` (`UserID`),
  CONSTRAINT `fk_bookcomments_books` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`),
  CONSTRAINT `fk_bookcomments_users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookcomments`
--

LOCK TABLES `bookcomments` WRITE;
/*!40000 ALTER TABLE `bookcomments` DISABLE KEYS */;
INSERT INTO `bookcomments` VALUES (1,1,1001,'This book was absolutely captivating! I couldn\'t put it down until I finished.','2023-08-25 18:27:00'),(2,2,1002,'The characters were so well-developed, it felt like they jumped off the page.','2023-12-10 14:53:00'),(3,3,1003,'I found myself lost in the vivid descriptions and intricate plot twists.','2023-11-05 23:40:00'),(4,4,1004,'The author\'s writing style is so engaging, it drew me in from the very first page.','2023-09-18 11:12:00'),(5,5,1005,'A truly thought-provoking read that left me contemplating life for days.','2023-10-30 20:05:00'),(6,6,1006,'I laughed, I cried, and I was completely immersed in the story.','2023-07-20 15:37:00'),(7,7,1007,'The emotional depth of this book took me by surprise. It\'s a rollercoaster of feelings!','2023-06-16 00:20:00'),(8,8,1008,'I loved how the themes were explored in such a relatable and meaningful way.','2023-04-02 12:08:00'),(9,9,1009,'An absolute masterpiece! This is a book that will stay with me forever.','2023-05-28 21:42:00'),(10,10,1010,'I couldn\'t stop thinking about the characters long after I finished reading.','2023-02-12 18:59:00'),(11,11,1011,'This book challenged my perspective and left me pondering life\'s big questions.','2023-01-09 03:30:00'),(12,12,1012,'A beautiful and lyrical prose that swept me away to another world.','2023-03-03 11:18:00'),(13,13,1013,'The suspense kept me on the edge of my seat until the very end.','2023-08-09 19:10:00'),(14,14,1014,'I found myself re-reading passages just to savor the beauty of the language.','2023-11-22 15:47:00'),(15,15,1015,'Each page was a delight to read, and I couldn\'t wait to see what happened next.','2023-10-02 23:33:00'),(16,16,1001,'The narrative was so gripping, I couldn\'t turn the pages fast enough!','2023-06-27 08:55:00'),(17,17,1002,'This book transported me to another time and place, and I didn\'t want to leave.','2023-04-20 01:21:00'),(18,18,1003,'The twists and turns in the plot kept me guessing until the very end.','2023-12-05 17:04:00'),(19,19,1004,'I finished this book in one sitting - it was that good!','2023-09-13 12:36:00'),(20,1,1001,'This book was absolutely captivating! I couldn\'t put it down until I finished.','2023-08-25 18:27:00'),(21,2,1002,'The characters were so well-developed, it felt like they jumped off the page.','2023-12-10 14:53:00'),(22,3,1003,'I found myself lost in the vivid descriptions and intricate plot twists.','2023-11-05 23:40:00'),(23,4,1004,'The author\'s writing style is so engaging, it drew me in from the very first page.','2023-09-18 11:12:00'),(24,5,1005,'A truly thought-provoking read that left me contemplating life for days.','2023-10-30 20:05:00'),(25,6,1006,'I laughed, I cried, and I was completely immersed in the story.','2023-07-20 15:37:00'),(26,7,1007,'The emotional depth of this book took me by surprise. It\'s a rollercoaster of feelings!','2023-06-16 00:20:00'),(27,8,1008,'I loved how the themes were explored in such a relatable and meaningful way.','2023-04-02 12:08:00'),(28,9,1009,'An absolute masterpiece! This is a book that will stay with me forever.','2023-05-28 21:42:00'),(29,10,1010,'I couldn\'t stop thinking about the characters long after I finished reading.','2023-02-12 18:59:00'),(30,11,1011,'This book challenged my perspective and left me pondering life\'s big questions.','2023-01-09 03:30:00'),(31,12,1012,'A beautiful and lyrical prose that swept me away to another world.','2023-03-03 11:18:00'),(32,13,1013,'The suspense kept me on the edge of my seat until the very end.','2023-08-09 19:10:00'),(33,14,1014,'I found myself re-reading passages just to savor the beauty of the language.','2023-11-22 15:47:00'),(34,15,1015,'Each page was a delight to read, and I couldn\'t wait to see what happened next.','2023-10-02 23:33:00'),(35,16,1001,'The narrative was so gripping, I couldn\'t turn the pages fast enough!','2023-06-27 08:55:00'),(36,17,1002,'This book transported me to another time and place, and I didn\'t want to leave.','2023-04-20 01:21:00'),(37,18,1003,'The twists and turns in the plot kept me guessing until the very end.','2023-12-05 17:04:00'),(38,19,1004,'I finished this book in one sitting - it was that good!','2023-09-13 12:36:00');
/*!40000 ALTER TABLE `bookcomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookratings`
--

DROP TABLE IF EXISTS `bookratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookratings` (
  `RatingID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `BookID` bigint unsigned DEFAULT NULL,
  `UserID` bigint unsigned DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `DateStamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`RatingID`),
  UNIQUE KEY `RatingID` (`RatingID`),
  KEY `fk_bookratings_books` (`BookID`),
  KEY `fk_bookratings_users` (`UserID`),
  CONSTRAINT `fk_bookratings_books` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`),
  CONSTRAINT `fk_bookratings_users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookratings`
--

LOCK TABLES `bookratings` WRITE;
/*!40000 ALTER TABLE `bookratings` DISABLE KEYS */;
INSERT INTO `bookratings` VALUES (1,1,1001,2,'2024-01-20 01:02:00'),(2,1,1002,1,'2024-01-26 01:02:00'),(3,1,1003,1,'2024-02-08 01:02:00'),(4,1,1004,1,'2024-02-12 01:02:00'),(5,1,1005,5,'2024-01-24 01:02:00'),(6,1,1006,1,'2024-02-13 01:02:00'),(7,1,1007,5,'2024-02-14 01:02:00'),(8,1,1008,5,'2024-01-23 01:02:00'),(9,1,1009,5,'2024-01-25 01:02:00'),(10,1,1010,5,'2024-01-16 01:02:00'),(11,1,1011,2,'2024-02-12 01:02:00'),(12,1,1012,1,'2024-02-10 01:02:00'),(13,1,1013,4,'2024-02-12 01:02:00'),(14,1,1014,1,'2024-02-07 01:02:00'),(15,1,1015,5,'2024-02-03 01:02:00'),(16,2,1001,1,'2024-01-16 01:02:00'),(17,2,1002,2,'2024-01-19 01:02:00'),(18,2,1003,4,'2024-01-19 01:02:00'),(19,2,1004,3,'2024-01-29 01:02:00'),(20,2,1005,1,'2024-01-20 01:02:00'),(21,2,1006,4,'2024-01-21 01:02:00'),(22,2,1007,4,'2024-01-19 01:02:00'),(23,2,1008,4,'2024-02-15 01:02:00'),(24,2,1009,5,'2024-02-02 01:02:00'),(25,2,1010,2,'2024-01-18 01:02:00'),(26,2,1011,4,'2024-01-31 01:02:00'),(27,2,1012,5,'2024-01-19 01:02:00'),(28,2,1013,4,'2024-02-06 01:02:00'),(29,2,1014,4,'2024-01-18 01:02:00'),(30,2,1015,5,'2024-01-31 01:02:00'),(31,3,1001,1,'2024-02-13 01:02:00'),(32,3,1002,1,'2024-02-01 01:02:00'),(33,3,1003,2,'2024-02-07 01:02:00'),(34,3,1004,2,'2024-01-20 01:02:00'),(35,3,1005,4,'2024-02-02 01:02:00'),(36,3,1006,3,'2024-01-23 01:02:00'),(37,3,1007,2,'2024-02-10 01:02:00'),(38,3,1008,1,'2024-02-13 01:02:00'),(39,3,1009,2,'2024-02-01 01:02:00'),(40,3,1010,4,'2024-02-02 01:02:00'),(41,3,1011,3,'2024-01-24 01:02:00'),(42,3,1012,2,'2024-01-17 01:02:00'),(43,3,1013,3,'2024-02-05 01:02:00'),(44,3,1014,5,'2024-02-12 01:02:00'),(45,3,1015,4,'2024-01-25 01:02:00'),(46,4,1001,1,'2024-02-10 01:02:00'),(47,4,1002,2,'2024-02-06 01:02:00'),(48,4,1003,1,'2024-01-25 01:02:00'),(49,4,1004,5,'2024-02-15 01:02:00'),(50,4,1005,3,'2024-02-14 01:02:00'),(51,4,1006,5,'2024-02-10 01:02:00'),(52,4,1007,4,'2024-01-31 01:02:00'),(53,4,1008,3,'2024-01-24 01:02:00'),(54,4,1009,3,'2024-02-08 01:02:00'),(55,4,1010,3,'2024-01-20 01:02:00'),(56,4,1011,1,'2024-02-10 01:02:00'),(57,4,1012,5,'2024-02-11 01:02:00'),(58,4,1013,1,'2024-02-09 01:02:00'),(59,4,1014,3,'2024-01-23 01:02:00'),(60,4,1015,3,'2024-02-13 01:02:00'),(61,5,1001,5,'2024-02-11 01:02:00'),(62,5,1002,2,'2024-02-09 01:02:00'),(63,5,1003,1,'2024-02-04 01:02:00'),(64,5,1004,2,'2024-01-25 01:02:00'),(65,5,1005,5,'2024-02-06 01:02:00'),(66,5,1006,1,'2024-02-04 01:02:00'),(67,5,1007,3,'2024-02-12 01:02:00'),(68,5,1008,3,'2024-02-15 01:02:00'),(69,5,1009,5,'2024-01-16 01:02:00'),(70,5,1010,3,'2024-01-23 01:02:00'),(71,5,1011,1,'2024-01-26 01:02:00'),(72,5,1012,1,'2024-02-07 01:02:00'),(73,5,1013,2,'2024-01-18 01:02:00'),(74,5,1014,5,'2024-02-02 01:02:00'),(75,5,1015,5,'2024-02-10 01:02:00'),(76,6,1001,2,'2024-02-01 01:02:00'),(77,6,1002,5,'2024-01-30 01:02:00'),(78,6,1003,3,'2024-01-23 01:02:00'),(79,6,1004,3,'2024-02-15 01:02:00'),(80,6,1005,3,'2024-01-18 01:02:00'),(81,6,1006,1,'2024-01-23 01:02:00'),(82,6,1007,2,'2024-01-21 01:02:00'),(83,6,1008,4,'2024-01-31 01:02:00'),(84,6,1009,5,'2024-01-25 01:02:00'),(85,6,1010,2,'2024-02-02 01:02:00'),(86,6,1011,2,'2024-02-03 01:02:00'),(87,6,1012,3,'2024-02-06 01:02:00'),(88,6,1013,3,'2024-01-30 01:02:00'),(89,6,1014,1,'2024-02-12 01:02:00'),(90,6,1015,4,'2024-01-28 01:02:00'),(91,7,1001,3,'2024-02-15 01:02:00'),(92,7,1002,2,'2024-02-02 01:02:00'),(93,7,1003,2,'2024-01-20 01:02:00'),(94,7,1004,1,'2024-01-17 01:02:00'),(95,7,1005,5,'2024-02-14 01:02:00'),(96,7,1006,3,'2024-01-22 01:02:00'),(97,7,1007,2,'2024-01-26 01:02:00'),(98,7,1008,1,'2024-02-02 01:02:00'),(99,7,1009,2,'2024-01-18 01:02:00'),(100,7,1010,3,'2024-01-25 01:02:00'),(101,7,1011,4,'2024-01-23 01:02:00'),(102,7,1012,1,'2024-02-05 01:02:00'),(103,7,1013,3,'2024-01-30 01:02:00'),(104,7,1014,2,'2024-01-18 01:02:00'),(105,7,1015,4,'2024-02-01 01:02:00'),(106,8,1001,2,'2024-01-16 01:02:00'),(107,8,1002,1,'2024-01-18 01:02:00'),(108,8,1003,3,'2024-01-30 01:02:00'),(109,8,1004,1,'2024-02-01 01:02:00'),(110,8,1005,5,'2024-02-01 01:02:00'),(111,8,1006,1,'2024-01-31 01:02:00'),(112,8,1007,2,'2024-02-05 01:02:00'),(113,8,1008,4,'2024-01-22 01:02:00'),(114,8,1009,5,'2024-02-05 01:02:00'),(115,8,1010,4,'2024-01-19 01:02:00'),(116,8,1011,1,'2024-02-15 01:02:00'),(117,8,1012,2,'2024-02-02 01:02:00'),(118,8,1013,3,'2024-02-04 01:02:00'),(119,8,1014,5,'2024-01-18 01:02:00'),(120,8,1015,5,'2024-01-23 01:02:00'),(121,9,1001,3,'2024-01-22 01:02:00'),(122,9,1002,1,'2024-02-15 01:02:00'),(123,9,1003,5,'2024-01-31 01:02:00'),(124,9,1004,3,'2024-01-24 01:02:00'),(125,9,1005,4,'2024-01-21 01:02:00'),(126,9,1006,1,'2024-02-15 01:02:00'),(127,9,1007,1,'2024-02-11 01:02:00'),(128,9,1008,2,'2024-01-19 01:02:00'),(129,9,1009,4,'2024-01-23 01:02:00'),(130,9,1010,1,'2024-02-04 01:02:00'),(131,9,1011,4,'2024-02-05 01:02:00'),(132,9,1012,5,'2024-01-27 01:02:00'),(133,9,1013,3,'2024-02-04 01:02:00'),(134,9,1014,5,'2024-02-08 01:02:00'),(135,9,1015,4,'2024-02-08 01:02:00'),(136,10,1001,2,'2024-02-05 01:02:00'),(137,10,1002,1,'2024-01-21 01:02:00'),(138,10,1003,5,'2024-02-03 01:02:00'),(139,10,1004,2,'2024-02-13 01:02:00'),(140,10,1005,3,'2024-02-08 01:02:00'),(141,10,1006,3,'2024-01-29 01:02:00'),(142,10,1007,1,'2024-02-15 01:02:00'),(143,10,1008,2,'2024-02-10 01:02:00'),(144,10,1009,2,'2024-01-22 01:02:00'),(145,10,1010,3,'2024-01-30 01:02:00'),(146,10,1011,2,'2024-02-14 01:02:00'),(147,10,1012,2,'2024-01-17 01:02:00'),(148,10,1013,4,'2024-01-20 01:02:00'),(149,10,1014,4,'2024-02-13 01:02:00'),(150,10,1015,3,'2024-01-29 01:02:00'),(151,11,1001,2,'2024-01-20 01:02:00'),(152,11,1002,1,'2024-02-05 01:02:00'),(153,11,1003,3,'2024-02-05 01:02:00'),(154,11,1004,1,'2024-02-08 01:02:00'),(155,11,1005,4,'2024-02-09 01:02:00'),(156,11,1006,1,'2024-02-01 01:02:00'),(157,11,1007,2,'2024-01-24 01:02:00'),(158,11,1008,3,'2024-02-13 01:02:00'),(159,11,1009,1,'2024-01-31 01:02:00'),(160,11,1010,4,'2024-01-29 01:02:00'),(161,11,1011,4,'2024-01-29 01:02:00'),(162,11,1012,5,'2024-01-26 01:02:00'),(163,11,1013,4,'2024-01-19 01:02:00'),(164,11,1014,3,'2024-02-12 01:02:00'),(165,11,1015,4,'2024-01-16 01:02:00'),(166,12,1001,5,'2024-01-19 01:02:00'),(167,12,1002,2,'2024-01-26 01:02:00'),(168,12,1003,3,'2024-01-29 01:02:00'),(169,12,1004,1,'2024-01-31 01:02:00'),(170,12,1005,5,'2024-02-12 01:02:00'),(171,12,1006,3,'2024-01-18 01:02:00'),(172,12,1007,1,'2024-02-11 01:02:00'),(173,12,1008,1,'2024-02-09 01:02:00'),(174,12,1009,5,'2024-01-17 01:02:00'),(175,12,1010,5,'2024-01-31 01:02:00'),(176,12,1011,5,'2024-01-20 01:02:00'),(177,12,1012,1,'2024-02-14 01:02:00'),(178,12,1013,1,'2024-02-15 01:02:00'),(179,12,1014,2,'2024-02-14 01:02:00'),(180,12,1015,4,'2024-02-10 01:02:00'),(181,13,1001,1,'2024-01-24 01:02:00'),(182,13,1002,4,'2024-01-30 01:02:00'),(183,13,1003,3,'2024-02-04 01:02:00'),(184,13,1004,4,'2024-02-03 01:02:00'),(185,13,1005,5,'2024-02-15 01:02:00'),(186,13,1006,4,'2024-02-15 01:02:00'),(187,13,1007,4,'2024-02-12 01:02:00'),(188,13,1008,3,'2024-01-20 01:02:00'),(189,13,1009,2,'2024-02-10 01:02:00'),(190,13,1010,1,'2024-02-14 01:02:00'),(191,13,1011,4,'2024-02-03 01:02:00'),(192,13,1012,2,'2024-02-06 01:02:00'),(193,13,1013,4,'2024-01-31 01:02:00'),(194,13,1014,2,'2024-02-09 01:02:00'),(195,13,1015,4,'2024-01-23 01:02:00'),(196,14,1001,1,'2024-02-04 01:02:00'),(197,14,1002,1,'2024-02-06 01:02:00'),(198,14,1003,3,'2024-02-14 01:02:00'),(199,14,1004,3,'2024-01-25 01:02:00'),(200,14,1005,4,'2024-02-01 01:02:00'),(201,14,1006,4,'2024-02-03 01:02:00'),(202,14,1007,1,'2024-01-20 01:02:00'),(203,14,1008,3,'2024-01-23 01:02:00'),(204,14,1009,5,'2024-02-14 01:02:00'),(205,14,1010,3,'2024-02-05 01:02:00'),(206,14,1011,5,'2024-01-22 01:02:00'),(207,14,1012,3,'2024-01-30 01:02:00'),(208,14,1013,1,'2024-02-01 01:02:00'),(209,14,1014,1,'2024-01-25 01:02:00'),(210,14,1015,3,'2024-01-30 01:02:00'),(211,15,1001,2,'2024-01-30 01:02:00'),(212,15,1002,3,'2024-01-22 01:02:00'),(213,15,1003,5,'2024-02-08 01:02:00'),(214,15,1004,3,'2024-01-24 01:02:00'),(215,15,1005,1,'2024-01-31 01:02:00'),(216,15,1006,3,'2024-01-18 01:02:00'),(217,15,1007,1,'2024-01-18 01:02:00'),(218,15,1008,5,'2024-01-26 01:02:00'),(219,15,1009,3,'2024-02-05 01:02:00'),(220,15,1010,5,'2024-02-05 01:02:00'),(221,15,1011,2,'2024-01-23 01:02:00'),(222,15,1012,4,'2024-01-31 01:02:00'),(223,15,1013,2,'2024-02-10 01:02:00'),(224,15,1014,2,'2024-01-28 01:02:00'),(225,15,1015,1,'2024-02-08 01:02:00');
/*!40000 ALTER TABLE `bookratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `BookID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ISBN` bigint DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` text,
  `Price` decimal(10,2) DEFAULT NULL,
  `Genre` varchar(255) DEFAULT NULL,
  `AuthorID` bigint unsigned DEFAULT NULL,
  `PublisherID` bigint unsigned DEFAULT NULL,
  `YearPublished` int DEFAULT NULL,
  `CopiesSold` int DEFAULT NULL,
  PRIMARY KEY (`BookID`),
  UNIQUE KEY `BookID` (`BookID`),
  KEY `fk_books_authors` (`AuthorID`),
  KEY `fk_books_publishers` (`PublisherID`),
  KEY `idx_books_genre` (`Genre`),
  CONSTRAINT `fk_books_authors` FOREIGN KEY (`AuthorID`) REFERENCES `authors` (`AuthorID`),
  CONSTRAINT `fk_books_publishers` FOREIGN KEY (`PublisherID`) REFERENCES `publishers` (`PublisherID`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,9784032705988,'The Adventures of Huckleberry Finn','Huck Finn\'s journey with Jim explores themes of friendship, freedom, and societal hypocrisy.',19.13,'Adventure',3,3,1997,34850),(2,9786933376186,'In Search of Lost Time','A deep exploration of memory and time through the narrator\'s life in aristocratic France.',20.50,'Fiction',10,10,1996,4057),(3,9786269738708,'On the Origin of Species','Darwin\'s theory of natural selection explaining the evolution of species.',9.38,'Science',15,15,2004,42315),(4,9784032705988,'The Divine Comedy','An allegorical journey through Hell, Purgatory, and Paradise reflecting on sin, redemption, and divine justice.',28.77,'Epic Poetry',9,9,2015,29544),(5,9789964205637,'The Adventures of Huckleberry Finn','Plato\'s dialogue on justice, governance, and the ideal state ruled by philosopher-kings.',10.39,'Philosophy',2,2,2020,4897),(6,9784503008750,'In Search of Lost Time','The comedic adventures of a self-declared knight errant tilting at windmills in a critique of chivalric romances.',29.93,'Satire',1,1,2007,29625),(7,9788281331332,'On the Origin of Species','A day in the life of Leopold Bloom in Dublin, paralleling the Odyssey with modern themes and stream-of-consciousness narrative.',16.31,'Modernist Literature',5,5,1996,33552),(8,9785054345584,'The Divine Comedy','Marx\'s critique of capitalism, detailing the labor theory of value and the dynamics of capitalist economies.',19.79,'Economics',11,11,1991,24138),(9,9780883285188,'The Republic','Augustine\'s introspective journey into his conversion to Christianity, blending autobiography and theology.',22.05,'Autobiography/Theology',6,6,1999,9960),(10,9785583487959,'Don Quixote','Machiavelli\'s guide to political power and leadership, emphasizing realpolitik and pragmatic governance.',23.84,'Political Philosophy',13,13,1990,30288),(11,9786807893962,'Ulysses','Fitzgerald\'s critique of the American Dream through the tragic story of Jay Gatsby\'s obsession and decadence.',27.96,'Tragedy',7,7,2018,16869),(12,9788668834263,'Das Kapital','An intricate look at life in a small English town, exploring marriage, ambition, and societal change.',14.02,'Fiction',12,12,2011,35131),(13,9786598348889,'Confessions','Adam Smith\'s foundational work on economics, advocating for free markets and the invisible hand theory.',25.00,'Sociology/Economics',8,8,2006,35850),(14,9785215960671,'The Prince','Freud\'s psychoanalytic exploration of dreams as windows to the unconscious mind.',14.45,'Psychology',4,4,1993,32925),(15,9786472555319,'The Great Gatsby','Swift\'s satirical voyages to fantastical lands critique human nature and society\'s flaws.',19.87,'Satire',14,14,2020,45814),(16,9785761476156,'Middlemarch','The epic saga of the Buendía family blends magical realism with the cyclical nature of history.',19.18,'Magical Realism',1,1,2007,17716),(17,9788576196575,'The Wealth of Nations','Shakespeare\'s tragedy of a king\'s descent into madness, betrayal, and the quest for redemption.',6.98,'Tragedy',2,2,2009,3484),(18,9789454710955,'The Interpretation of Dreams','Kant\'s examination of the limits and faculties of human reason and knowledge.',8.27,'Philosophy',3,3,2020,30413),(19,9786598778010,'Gulliver\'s Travels','Austen\'s witty exploration of marriage, class, and societal expectations in Georgian England.',10.13,'Romance',4,4,2005,7883),(20,9783814249663,'One Hundred Years of Solitude','Homer\'s epic on the Trojan War, focusing on heroism, honor, and the wrath of Achilles.',7.16,'Epic Poetry',5,5,2001,22682),(21,9785003719875,'King Lear','The adventurous return of Odysseus to Ithaca post-Trojan War, facing mythical challenges.',6.31,'Epic Poetry',6,6,2012,37487),(22,9780324266528,'Critique of Pure Reason','Dostoevsky\'s exploration of faith, doubt, and morality through the lives of the Karamazov family.',17.37,'Philosophy/Fiction',7,7,2002,29555),(23,9786441808347,'Pride and Prejudice','Eliot\'s influential poems delve into modern disillusionment and spiritual emptiness.',11.15,'Poetry',8,8,2000,33626),(24,9780325275484,'The Iliad','Nabokov\'s controversial narrative of obsession and manipulation through Humbert Humbert\'s perspective.',23.98,'Fiction',9,9,2016,23255),(25,9782099297277,'The Odyssey','The central religious text of Islam, offering guidance on life, morality, and worship.',28.35,'Religious Text',10,10,2009,22721),(26,9788020421881,'The Brothers Karamazov','Dickens\' critique of Victorian society and greed, centered around a mysterious inheritance.',26.96,'Fiction',11,11,2011,18161),(27,9783627657134,'Collected Poems of T.S. Eliot','The foundational history of the Greco-Persian Wars, blending fact with cultural insights.',23.57,'History',12,12,1997,7407),(28,9789339783719,'Lolita','Melville\'s epic of Captain Ahab\'s obsessive hunt for the elusive white whale symbolizes man\'s struggle against nature.',26.50,'Adventure/Fiction',13,13,2009,20487),(29,9789050054346,'The Quran','Flaubert\'s portrayal of Emma Bovary\'s tragic search for passion beyond her provincial life.',27.75,'Fiction',14,14,1994,16826),(30,9780374885065,'Our Mutual Friend','Kafka\'s surreal tales reflect the existential angst and absurdities of modern life.',17.01,'Surrealism/Fiction',15,15,2003,34132),(31,9789779468824,'The Histories of Herodotus','The sacred text of Christianity, chronicling the spiritual history from creation to Christ\'s teachings.',12.58,'Religious Text',1,1,1992,35286),(32,9785576661520,'Moby Dick','Newton\'s groundbreaking work on the laws of motion and universal gravitation foundational to classical physics.',12.98,'Science',2,2,2007,47988),(33,9786846502320,'Madame Bovary','Yeats\' poetry spans romantic to mature themes, deeply rooted in Irish mythology and history.',10.97,'Poetry',3,3,1997,6509),(34,9786716332710,'Franz Kafka: The Complete Stories','Galileo\'s defense of heliocentrism through a conversational critique of geocentrism.',21.98,'Philosophy',4,4,2015,41749),(35,9783870984085,'The Bible','Sophocles\' tragedy of fate, where Oedipus unknowingly fulfills a prophecy of patricide and incest.',13.70,'Tragedy',5,5,2014,35639),(36,9789294179208,'Principia Mathematica','The conflict between state law and family loyalty, leading to tragedy in Sophocles\' ancient drama.',13.81,'Tragedy',6,6,2002,5787),(37,9787401028002,'Collected Poems of W. B. Yeats','An epic narrative of war, duty, and destiny in ancient India, embedding the philosophical Bhagavad Gita.',11.84,'Epic Poetry',7,7,2022,18622),(38,9781497369398,'Dialogue Concerning the Two Chief World Systems','Carroll\'s whimsical tale of Alice\'s fantastical encounters in a mysterious world.',15.86,'Fantasy',8,8,2013,20122),(39,9784433640406,'Oedipus the King','Rousseau\'s philosophical treatise on collective sovereignty and the legitimacy of political authority.',8.37,'Philosophy',9,9,1994,45806),(40,9784724273948,'Antigone','Goethe\'s dramatic tale of a man\'s deal with the devil in pursuit of knowledge and pleasure.',11.72,'Drama',10,10,2018,42615),(41,9783892885020,'Mahabharata','Carson\'s environmental classic warning of the dangers of pesticide overuse on nature\'s harmony.',7.69,'Environmentalism',11,11,2016,22153),(42,9780026646524,'Alice\'s Adventures in Wonderland','Hume\'s skeptical inquiry into the origins and nature of human knowledge.',10.75,'Philosophy',12,12,1990,21988),(43,9782861755803,'The Social Contract','Tolstoy\'s masterpiece intertwining the lives of families during the Napoleonic wars with philosophical musings.',8.49,'Historical Fiction/Philosophy',13,13,2000,25096),(44,9783786406212,'Faust','Wollstonecraft\'s pioneering feminist argument for women\'s education and equality.',24.68,'Feminism',14,14,2010,44094),(45,9786280213273,'Silent Spring','Boccaccio\'s collection of tales told by young Florentines isolating themselves during the Black Death.',15.91,'Fiction',15,15,2015,37062),(46,9786730345764,'An Enquiry Concerning Human Understanding','Beckett\'s existentialist play where two characters wait for someone named Godot who never arrives.',15.22,'Absurdist Drama',1,1,1993,29472),(47,9786439122406,'War and Peace','The world\'s first novel, chronicling the romantic life of Genji and the Heian court in Japan.',9.57,'Fiction',2,2,2008,4217),(48,9784414205090,'A Vindication of the Rights of Woman','James\' novel of a young American woman\'s confrontation with destiny and choice in Europe.',28.35,'Fiction',3,3,1999,25441),(49,9786864309615,'Decameron','Diderot\'s Enlightenment-era work aiming to compile all human knowledge and promote critical thinking.',18.13,'Philosophy',4,4,1998,44554),(50,9788575294168,'Waiting for Godot','Chekhov\'s short stories capture the complexity of human condition.',18.93,'Fiction',5,5,1996,27678),(51,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(59,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(62,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(72,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(75,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(76,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(77,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(78,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(79,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(80,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(81,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(82,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(83,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(84,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(85,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(86,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(87,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(88,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(89,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(90,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(91,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(92,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(93,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(94,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(95,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(96,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(97,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(98,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(99,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartitems`
--

DROP TABLE IF EXISTS `cartitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartitems` (
  `CartItemID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `CartID` bigint unsigned DEFAULT NULL,
  `BookID` bigint unsigned DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`CartItemID`),
  UNIQUE KEY `CartItemID` (`CartItemID`),
  KEY `fk_cartitems_cart` (`CartID`),
  KEY `fk_cartitems_books` (`BookID`),
  CONSTRAINT `fk_cartitems_books` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`),
  CONSTRAINT `fk_cartitems_cart` FOREIGN KEY (`CartID`) REFERENCES `shoppingcart` (`CartID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartitems`
--

LOCK TABLES `cartitems` WRITE;
/*!40000 ALTER TABLE `cartitems` DISABLE KEYS */;
INSERT INTO `cartitems` VALUES (17,1,1,1),(18,2,2,2),(19,3,3,1),(20,1,4,1),(21,4,5,3),(22,5,6,2),(23,6,7,1),(24,7,8,2),(25,8,9,1),(26,9,10,1),(27,10,11,2),(28,11,12,1),(29,12,13,3),(30,13,14,2),(31,14,15,1),(32,15,2,2);
/*!40000 ALTER TABLE `cartitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `PublisherID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PublisherID`),
  UNIQUE KEY `PublisherID` (`PublisherID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (1,'Penguin Random House'),(2,'HarperCollins'),(3,'Simon & Schuster'),(4,'Hachette Book Group'),(5,'Macmillan Publishers'),(6,'Scholastic Corporation'),(7,'Pearson Education'),(8,'Oxford University Press'),(9,'Cambridge University Press'),(10,'Bloomsbury Publishing'),(11,'Wiley'),(12,'Penguin Classics'),(13,'Vintage Books'),(14,'Faber & Faber'),(15,'Doubleday');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcart`
--

DROP TABLE IF EXISTS `shoppingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoppingcart` (
  `CartID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `UserID` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`CartID`),
  UNIQUE KEY `CartID` (`CartID`),
  KEY `fk_shoppingcart_users` (`UserID`),
  CONSTRAINT `fk_shoppingcart_users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcart`
--

LOCK TABLES `shoppingcart` WRITE;
/*!40000 ALTER TABLE `shoppingcart` DISABLE KEYS */;
INSERT INTO `shoppingcart` VALUES (1,1001),(2,1002),(3,1003),(4,1004),(5,1005),(6,1006),(7,1007),(8,1008),(9,1009),(10,1010),(11,1011),(12,1012),(13,1013),(14,1014),(15,1015);
/*!40000 ALTER TABLE `shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usercreditcards`
--

DROP TABLE IF EXISTS `usercreditcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usercreditcards` (
  `CardID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `UserID` bigint unsigned DEFAULT NULL,
  `CardNumber` varchar(255) DEFAULT NULL,
  `CardHolderName` varchar(255) DEFAULT NULL,
  `ExpirationDate` date DEFAULT NULL,
  `CVV` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`CardID`),
  UNIQUE KEY `CardID` (`CardID`),
  KEY `fk_creditcards_users` (`UserID`),
  CONSTRAINT `fk_creditcards_users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercreditcards`
--

LOCK TABLES `usercreditcards` WRITE;
/*!40000 ALTER TABLE `usercreditcards` DISABLE KEYS */;
INSERT INTO `usercreditcards` VALUES (1,1001,'1234 5678 9012 3456',NULL,'2025-10-25','123'),(2,1002,'2345 6789 0123 4567',NULL,'2024-05-24','456'),(3,1003,'3456 7890 1234 5678',NULL,'2026-08-26','789'),(4,1004,'4567 8901 2345 6789',NULL,'2023-12-23','234'),(5,1005,'5678 9012 3456 7890',NULL,'2027-09-27','567'),(6,1006,'6789 0123 4567 8901',NULL,'2025-11-25','890'),(7,1007,'7890 1234 5678 9012',NULL,'2022-07-22','901'),(8,1008,'8901 2345 6789 0123',NULL,'2028-03-28','234'),(9,1009,'9012 3456 7890 1234',NULL,'2029-06-29','567'),(10,1010,'0123 4567 8901 2345',NULL,'2030-04-30','890'),(11,1011,'1357 2468 9753 8642',NULL,'2026-02-26','123'),(12,1012,'2468 1357 8642 9753',NULL,'2027-11-27','456'),(13,1013,'8642 9753 2468 1357',NULL,'2025-05-25','789'),(14,1014,'9753 8642 1357 2468',NULL,'2024-08-24','234'),(15,1015,'2468 9753 8642 1357',NULL,'2023-01-23','567');
/*!40000 ALTER TABLE `usercreditcards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `EmailAddress` varchar(255) DEFAULT NULL,
  `HomeAddress` text,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserID` (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `idx_users_username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=1031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1001,'John_Smith','John','Smith','P@ssw0rd1','john.smith@example.com','123 Main St, Anytown, USA'),(1002,'Emily_Johnson','Emily','Johnson','SecretPa$$','emily.johnson@example.com','456 Elm St, Somewhereville, USA'),(1003,'Michael_Davis','Michael','Davis','Pass123!','michael.davis@example.com','789 Oak St, Nowhere City, USA'),(1004,'Sarah_Brown','Sarah','Brown','Pa$$w0rdSecure','sarah.brown@example.com','1011 Pine St, Anyplace, USA'),(1005,'Christopher_Lee','Christopher','Lee','SecureP@ss1','christopher.lee@example.com','1213 Maple St, Nowheretown, USA'),(1006,'Jennifer_Taylor','Jennifer','Taylor','P@ssw0rd123','jennifer.taylor@example.com','1415 Oakwood Ave, Anytown, USA'),(1007,'David_Martinez','David','Martinez','P@ss1234','david.martinez@example.com','1617 Cedar Dr, Nowhereville, USA'),(1008,'Jessica_Wilson','Jessica','Wilson','MyP@ssw0rd','jessica.wilson@example.com','1819 Birch Ln, Anyplace, USA'),(1009,'Daniel_Anderson','Daniel','Anderson','SecurePa$$123','daniel.anderson@example.com','2021 Elmwood Rd, Somewhereville, USA'),(1010,'Ashley_Brown','Ashley','Brown','P@ssw0rd!','ashley.brown@example.com','2223 Maplewood Ave, Nowheretown, USA'),(1011,'Matthew_Wilson','Matthew','Wilson','Password123','matthew.wilson@example.com','2425 Oakhill Dr, Anytown, USA'),(1012,'Amanda_Garcia','Amanda','Garcia','P@ssw0rd456','amanda.garcia@example.com','2627 Pinehurst Ct, Nowhereville, USA'),(1013,'James_Lopez','James','Lopez','Secret123','james.lopez@example.com','2829 Cedarwood Dr, Anyplace, USA'),(1014,'Brittany_Taylor','Brittany','Taylor','Pa$$w0rdSecure!','brittany.taylor@example.com','3031 Birchwood Ave, Somewhereville, USA'),(1015,'Kevin_Adams','Kevin','Adams','SecureP@ssword','kevin.adams@example.com','3233 Elm St, Nowheretown, USA');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlistitems`
--

DROP TABLE IF EXISTS `wishlistitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlistitems` (
  `WishListItemID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `WishListID` bigint unsigned DEFAULT NULL,
  `BookID` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`WishListItemID`),
  UNIQUE KEY `WishListItemID` (`WishListItemID`),
  KEY `fk_wishlistitems_wishlists` (`WishListID`),
  KEY `fk_wishlistitems_books` (`BookID`),
  CONSTRAINT `fk_wishlistitems_books` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`),
  CONSTRAINT `fk_wishlistitems_wishlists` FOREIGN KEY (`WishListID`) REFERENCES `wishlists` (`WishListID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlistitems`
--

LOCK TABLES `wishlistitems` WRITE;
/*!40000 ALTER TABLE `wishlistitems` DISABLE KEYS */;
INSERT INTO `wishlistitems` VALUES (1,1,1),(2,1,3),(3,1,5),(4,2,2),(5,2,4),(6,2,6),(7,3,7),(8,3,9),(9,3,11),(10,4,8),(11,4,10),(12,4,12),(13,5,13),(14,5,15),(15,5,17),(16,6,14),(17,6,16),(18,6,18),(19,7,19),(20,8,20),(21,1,1),(22,1,3),(23,1,5),(24,2,2),(25,2,4),(26,2,6),(27,3,7),(28,3,9),(29,3,11),(30,4,8),(31,4,10),(32,4,12),(33,5,13),(34,5,15),(35,5,17),(36,6,14),(37,6,16),(38,6,18),(39,7,19),(40,8,20),(41,1,1),(42,1,3),(43,1,5),(44,2,2),(45,2,4),(46,2,6),(47,3,7),(48,3,9),(49,3,11),(50,4,8),(51,4,10),(52,4,12),(53,5,13),(54,5,15),(55,5,17),(56,6,14),(57,6,16),(58,6,18),(59,7,19),(60,8,20);
/*!40000 ALTER TABLE `wishlistitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlists` (
  `WishListID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `UserID` bigint unsigned DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`WishListID`),
  UNIQUE KEY `WishListID` (`WishListID`),
  KEY `fk_wishlists_users` (`UserID`),
  CONSTRAINT `fk_wishlists_users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
INSERT INTO `wishlists` VALUES (1,1001,'Fiction Favorites'),(2,1002,'Classic Novels'),(3,1003,'Sci-Fi and Fantasy Picks'),(4,1004,'Must-Read Non-Fiction'),(5,1005,'Mystery and Thrillers'),(6,1006,'Romantic Reads'),(7,1007,'Historical Fiction Gems'),(8,1008,'Biographies and Memoirs'),(9,1009,'Self-Help and Personal Development'),(10,1010,'Young Adult Must-Haves'),(11,1001,'Fiction Favorites'),(12,1002,'Classic Novels'),(13,1003,'Sci-Fi and Fantasy Picks'),(14,1004,'Must-Read Non-Fiction'),(15,1005,'Mystery and Thrillers'),(16,1006,'Romantic Reads'),(17,1007,'Historical Fiction Gems'),(18,1008,'Biographies and Memoirs'),(19,1009,'Self-Help and Personal Development'),(20,1010,'Young Adult Must-Haves');
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-17 16:36:11
