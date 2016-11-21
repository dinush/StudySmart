-- MySQL dump 10.13  Distrib 5.7.16, for Win64 (x86_64)
--
-- Host: localhost    Database: studysmart
-- ------------------------------------------------------
-- Server version	5.7.16-log

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
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement` (
  `announcement_id` varchar(25) NOT NULL,
  `message` varchar(25) NOT NULL,
  `date_time` varchar(6) NOT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement`
--

LOCK TABLES `announcement` WRITE;
/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment` (
  `name` varchar(250) NOT NULL,
  `class` int(11) NOT NULL,
  `subject` varchar(25) CHARACTER SET latin1 NOT NULL,
  `max` int(4) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_class_assignment` (`class`),
  KEY `fk_subject_assignment` (`subject`),
  CONSTRAINT `fk_class_assignment` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subject_assignment` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES ('2',6,'002',100,'2016-10-02'),('ass1',5,'001',34,'2016-09-14'),('assig1',5,'001',12,'2016-10-03'),('Geometry 1',5,'001',100,'2016-10-18');
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignmentmarks`
--

DROP TABLE IF EXISTS `assignmentmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignmentmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment` varchar(250) NOT NULL,
  `student` varchar(8) CHARACTER SET latin1 NOT NULL,
  `mark` int(4) NOT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `addedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assignment_assignmentmarks` (`assignment`) USING BTREE,
  KEY `fk_user_assignmentmarks` (`student`),
  KEY `fk_addedby_assignmentmarks` (`addedby`),
  CONSTRAINT `fk_addedby2_assignmentmarks` FOREIGN KEY (`addedby`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_assignment2_assignmentmarks` FOREIGN KEY (`assignment`) REFERENCES `assignment` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assignmentmarks` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignmentmarks`
--

LOCK TABLES `assignmentmarks` WRITE;
/*!40000 ALTER TABLE `assignmentmarks` DISABLE KEYS */;
INSERT INTO `assignmentmarks` VALUES (6,'assig1','st1',12,'2','teacher'),(7,'ass1','st1',3,'fd','teacher'),(8,'Geometry 1','st1',75,'','teacher'),(9,'Geometry 1','st3',63,'Try to improve','teacher'),(10,'Geometry 1','st6',78,'','teacher'),(11,'Geometry 1','st8',80,'','teacher'),(12,'Geometry 1','2014',92,'','teacher'),(13,'Geometry 1','38995',79,'','teacher'),(14,'Geometry 1','389955',88,'','teacher');
/*!40000 ALTER TABLE `assignmentmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `username` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `attended` tinyint(1) DEFAULT NULL,
  `markedBy` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`username`,`date`),
  KEY `Attendance_ibfk_1` (`markedBy`),
  CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`markedBy`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES ('2014','2016-09-19',1,'teacher'),('38995','2016-09-19',1,'teacher'),('389955','2016-09-19',1,'teacher'),('st1','2016-08-23',0,'teacher'),('st1','2016-08-24',1,'teacher'),('st1','2016-08-25',1,'teacher'),('st1','2016-09-01',0,'teacher'),('st1','2016-09-04',0,'teacher'),('st1','2016-09-19',1,'teacher'),('st2','2016-08-24',1,'teacher'),('st2','2016-09-01',1,'teacher'),('st2','2016-09-04',0,'teacher'),('st3','2016-09-04',0,'teacher'),('st3','2016-09-19',1,'teacher'),('st6','2016-09-19',1,'teacher'),('st8','2016-09-19',1,'teacher');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendanceclass`
--

DROP TABLE IF EXISTS `attendanceclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendanceclass` (
  `class` int(11) NOT NULL,
  `date` date NOT NULL,
  `markedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`class`,`date`),
  KEY `markedby` (`markedby`),
  CONSTRAINT `fk_class_attendanceclass` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_markkedby_attendanceclass` FOREIGN KEY (`markedby`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendanceclass`
--

LOCK TABLES `attendanceclass` WRITE;
/*!40000 ALTER TABLE `attendanceclass` DISABLE KEYS */;
INSERT INTO `attendanceclass` VALUES (5,'2016-09-04','teacher'),(5,'2016-09-19','teacher'),(6,'2016-09-04','teacher');
/*!40000 ALTER TABLE `attendanceclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_by` varchar(255) DEFAULT NULL,
  `cat_description` varchar(255) DEFAULT NULL,
  `cat_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` int(2) NOT NULL,
  `subclass` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (5,10,'A'),(6,10,'B'),(7,11,'A'),(8,11,'B');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classnews`
--

DROP TABLE IF EXISTS `classnews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classnews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` int(11) NOT NULL,
  `addedby` varchar(8) CHARACTER SET latin1 NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `addeddate` date DEFAULT NULL,
  `addedtime` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_addedby` (`addedby`),
  KEY `fk_class` (`class`),
  CONSTRAINT `fk_addedby` FOREIGN KEY (`addedby`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_class_news` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classnews`
--

LOCK TABLES `classnews` WRITE;
/*!40000 ALTER TABLE `classnews` DISABLE KEYS */;
INSERT INTO `classnews` VALUES (1,5,'teacher','titl212','1dfsd',NULL,NULL,NULL,NULL),(2,5,'teacher','News 2','this is the message',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `classnews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_thead`
--

DROP TABLE IF EXISTS `forum_thead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_thead` (
  `forum_id` varchar(25) NOT NULL,
  PRIMARY KEY (`forum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_thead`
--

LOCK TABLES `forum_thead` WRITE;
/*!40000 ALTER TABLE `forum_thead` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_thead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(512) DEFAULT NULL,
  `content` varchar(5000) NOT NULL,
  `url` varchar(5000) DEFAULT NULL,
  `targetdate` date DEFAULT NULL,
  `targettime` varchar(50) DEFAULT NULL,
  `addeduser` varchar(8) CHARACTER SET latin1 NOT NULL,
  `addeddate` date NOT NULL,
  `addedtime` varchar(50) NOT NULL,
  `type` int(1) NOT NULL,
  `targetuser` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  `userlevel` int(1) DEFAULT NULL,
  `class` int(11) DEFAULT NULL,
  `grade` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_addeduser_message` (`addeduser`),
  KEY `fk_targetuser_message` (`targetuser`),
  KEY `fk_class_message` (`class`),
  CONSTRAINT `fk_addeduser_message` FOREIGN KEY (`addeduser`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_class_message` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_targetuser_message` FOREIGN KEY (`targetuser`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,0,'title test','sample message',NULL,'2016-09-28',NULL,'teacher','2016-09-04','17:14:32',4,NULL,NULL,5,NULL),(3,0,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:07:38',1,'st3',NULL,NULL,NULL),(4,0,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:07:38',1,'st6',NULL,NULL,NULL),(5,0,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:07:38',1,'st8',NULL,NULL,NULL),(7,0,'Term 1 marks','Term 1 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-11','11:27:27',1,'parent',NULL,NULL,NULL),(8,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:27:27',1,'st3',NULL,NULL,NULL),(9,0,'Term 1 marks','Term 1 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-11','11:27:28',1,'par1',NULL,NULL,NULL),(10,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:27:28',1,'st6',NULL,NULL,NULL),(11,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:27:28',1,'st8',NULL,NULL,NULL),(12,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','16:34:04',1,'2014',NULL,NULL,NULL),(13,1,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'38995',NULL,NULL,NULL),(14,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'389955',NULL,NULL,NULL),(15,0,'Term 1 marks','Term 1 marks added for Maths (student: kaveesh thamal [389955])',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'389955p',NULL,NULL,NULL),(17,0,'Term 1 marks','Term 1 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'parent',NULL,NULL,NULL),(18,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'st3',NULL,NULL,NULL),(19,0,'Term 1 marks','Term 1 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'par1',NULL,NULL,NULL),(20,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'st6',NULL,NULL,NULL),(21,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','16:34:05',1,'st8',NULL,NULL,NULL),(24,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','23:48:24',1,'2014',NULL,NULL,NULL),(25,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','23:48:24',1,'38995',NULL,NULL,NULL),(26,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','23:48:24',1,'389955',NULL,NULL,NULL),(27,0,'Term 2 marks','Term 2 marks added for Maths (student: kaveesh thamal [389955])',NULL,NULL,NULL,'teacher','2016-09-19','23:48:24',1,'389955p',NULL,NULL,NULL),(29,0,'Term 2 marks','Term 2 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-19','23:48:24',1,'parent',NULL,NULL,NULL),(30,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','23:48:24',1,'st3',NULL,NULL,NULL),(31,0,'Term 2 marks','Term 2 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-19','23:48:25',1,'par1',NULL,NULL,NULL),(32,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','23:48:25',1,'st6',NULL,NULL,NULL),(33,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-19','23:48:25',1,'st8',NULL,NULL,NULL),(34,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:35',1,'2014',NULL,NULL,NULL),(35,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'38995',NULL,NULL,NULL),(36,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'389955',NULL,NULL,NULL),(37,0,'Term 1 marks','Term 1 marks added for Maths (student: kaveesh thamal [389955])',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'389955p',NULL,NULL,NULL),(38,1,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'st1',NULL,NULL,NULL),(39,0,'Term 1 marks','Term 1 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'parent',NULL,NULL,NULL),(40,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'st3',NULL,NULL,NULL),(41,0,'Term 1 marks','Term 1 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'par1',NULL,NULL,NULL),(42,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'st6',NULL,NULL,NULL),(43,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','07:34:36',1,'st8',NULL,NULL,NULL),(44,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:44:51',1,'2014',NULL,NULL,NULL),(45,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'38995',NULL,NULL,NULL),(46,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'389955',NULL,NULL,NULL),(47,0,'Term 1 marks','Term 1 marks added for Science (student: kaveesh thamal [389955])',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'389955p',NULL,NULL,NULL),(49,0,'Term 1 marks','Term 1 marks added for Science (student: Student 1 [st1])',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'parent',NULL,NULL,NULL),(50,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'st3',NULL,NULL,NULL),(51,0,'Term 1 marks','Term 1 marks added for Science (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'par1',NULL,NULL,NULL),(52,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'st6',NULL,NULL,NULL),(53,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:44:52',1,'st8',NULL,NULL,NULL),(54,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:11',1,'2014',NULL,NULL,NULL),(55,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:11',1,'38995',NULL,NULL,NULL),(56,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'389955',NULL,NULL,NULL),(57,0,'Term 1 marks','Term 1 marks added for Science (student: kaveesh thamal [389955])',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'389955p',NULL,NULL,NULL),(58,1,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'st1',NULL,NULL,NULL),(59,0,'Term 1 marks','Term 1 marks added for Science (student: Student 1 [st1])',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'parent',NULL,NULL,NULL),(60,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'st3',NULL,NULL,NULL),(61,0,'Term 1 marks','Term 1 marks added for Science (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'par1',NULL,NULL,NULL),(62,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'st6',NULL,NULL,NULL),(63,0,'Term 1 marks','Term 1 marks added for Science',NULL,NULL,NULL,'tch002','2016-09-20','07:45:12',1,'st8',NULL,NULL,NULL),(64,0,NULL,'All students are required to be present at the School Auditorium by 8.30 am on 10.02.2016 for the School General Meeting.',NULL,NULL,NULL,'dinush','2016-09-20','10:03:53',5,NULL,NULL,NULL,NULL),(67,0,NULL,'12345673333',NULL,NULL,NULL,'st1','2016-11-07','12:18:56',1,'dinush',NULL,NULL,NULL),(70,0,NULL,'multicast msg',NULL,NULL,NULL,'st1','2016-11-07','22:14:06',1,'2014',NULL,NULL,NULL),(71,0,NULL,'multicast msg',NULL,NULL,NULL,'st1','2016-11-07','22:14:06',1,'parent',NULL,NULL,NULL),(72,0,NULL,'unicast msg',NULL,NULL,NULL,'st1','2016-11-07','22:14:45',1,'2014',NULL,NULL,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `user_Id` varchar(25) NOT NULL,
  `post_id` varchar(25) NOT NULL,
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `question_id` varchar(25) NOT NULL,
  `option1` varchar(25) NOT NULL,
  `option2` varchar(25) NOT NULL,
  `option3` varchar(25) NOT NULL,
  `option4` varchar(25) NOT NULL,
  `answer` varchar(25) NOT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
  `idQuiz` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(500) NOT NULL,
  `option1` varchar(200) NOT NULL,
  `option2` varchar(200) NOT NULL,
  `option3` varchar(200) DEFAULT NULL,
  `option4` varchar(200) DEFAULT NULL,
  `answers` varchar(45) NOT NULL,
  `username` varchar(8) DEFAULT NULL,
  `idQuizset` int(11) DEFAULT NULL,
  PRIMARY KEY (`idQuiz`),
  KEY `idQuizset` (`idQuizset`),
  KEY `username` (`username`),
  CONSTRAINT `Quiz_ibfk_1` FOREIGN KEY (`idQuizset`) REFERENCES `quizset` (`quizsetId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Quiz_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizset`
--

DROP TABLE IF EXISTS `quizset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizset` (
  `quizsetId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `subject` varchar(25) DEFAULT NULL,
  `quizes` varchar(100) NOT NULL,
  `username` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`quizsetId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizset`
--

LOCK TABLES `quizset` WRITE;
/*!40000 ALTER TABLE `quizset` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequence`
--

LOCK TABLES `sequence` WRITE;
/*!40000 ALTER TABLE `sequence` DISABLE KEYS */;
INSERT INTO `sequence` VALUES ('SEQ_GEN',0);
/*!40000 ALTER TABLE `sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_parent`
--

DROP TABLE IF EXISTS `student_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_parent` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  `studentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `uniq_parent_child` (`parentid`,`studentid`),
  KEY `fk_student_parent_2` (`studentid`),
  CONSTRAINT `fk_student_parent_1` FOREIGN KEY (`parentid`) REFERENCES `user` (`username`) ON UPDATE CASCADE,
  CONSTRAINT `fk_student_parent_2` FOREIGN KEY (`studentid`) REFERENCES `user` (`username`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_parent`
--

LOCK TABLES `student_parent` WRITE;
/*!40000 ALTER TABLE `student_parent` DISABLE KEYS */;
INSERT INTO `student_parent` VALUES (5,'389955p','389955'),(4,'kdfh','st3'),(2,'par1','st2'),(3,'par1','st3'),(1,'parent','st1');
/*!40000 ALTER TABLE `student_parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentsubject`
--

DROP TABLE IF EXISTS `studentsubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentsubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid_index` (`userId`),
  KEY `subjectid_index` (`subjectId`),
  CONSTRAINT `fk_subject_id` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`userId`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentsubject`
--

LOCK TABLES `studentsubject` WRITE;
/*!40000 ALTER TABLE `studentsubject` DISABLE KEYS */;
INSERT INTO `studentsubject` VALUES (1,'st1','001'),(2,'st1','002'),(3,'st1','003'),(4,'st2','002'),(5,'st2','004'),(6,'st3','001'),(7,'st3','002'),(8,'st3','004'),(9,'st5','001'),(10,'st5','003'),(11,'st6','001'),(12,'st6','002'),(13,'st8','001'),(14,'st8','002'),(15,'st8','003'),(16,'st8','004'),(17,'2014','001'),(18,'2014','002'),(19,'2014','003'),(20,'2014','004'),(21,'38995','001'),(22,'38995','002'),(23,'38995','003'),(24,'389955','001'),(25,'389955','002'),(26,'389955','003');
/*!40000 ALTER TABLE `studentsubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject` (
  `idSubject` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `grade` int(2) NOT NULL DEFAULT '10',
  PRIMARY KEY (`idSubject`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES ('001','Maths',10),('002','Science',10),('003','English',10),('004','IT',10);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachersubject`
--

DROP TABLE IF EXISTS `teachersubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachersubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectId` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachersubject`
--

LOCK TABLES `teachersubject` WRITE;
/*!40000 ALTER TABLE `teachersubject` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachersubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacherteaches`
--

DROP TABLE IF EXISTS `teacherteaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacherteaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  `class` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_index` (`userId`),
  KEY `subject_index` (`subjectId`),
  KEY `class_index` (`class`) USING BTREE,
  CONSTRAINT `TeacherTeaches_ibfk_1` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subject` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacherteaches`
--

LOCK TABLES `teacherteaches` WRITE;
/*!40000 ALTER TABLE `teacherteaches` DISABLE KEYS */;
INSERT INTO `teacherteaches` VALUES (1,'teacher','001',5),(2,'teacher','002',6),(8,'tch001','003',5),(9,'tch001','003',6),(10,'tch001','004',5),(11,'2016t','001',5),(12,'2016t','002',6),(13,'tch002','001',5),(14,'tch002','001',6),(15,'tch002','002',5),(16,'tch002','002',6);
/*!40000 ALTER TABLE `teacherteaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `termmarks`
--

DROP TABLE IF EXISTS `termmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `termmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subject` varchar(25) CHARACTER SET latin1 NOT NULL,
  `class` int(11) NOT NULL,
  `term` int(1) NOT NULL,
  `value` int(4) NOT NULL,
  `markedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student` (`student`),
  KEY `class` (`class`),
  KEY `subject` (`subject`) USING BTREE,
  KEY `markedby` (`markedby`) USING BTREE,
  CONSTRAINT `fk_class_tm` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_markedby_tm` FOREIGN KEY (`markedby`) REFERENCES `user` (`username`),
  CONSTRAINT `fk_student_tm` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subject_tm` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `termmarks`
--

LOCK TABLES `termmarks` WRITE;
/*!40000 ALTER TABLE `termmarks` DISABLE KEYS */;
INSERT INTO `termmarks` VALUES (5,'st3','001',5,1,66,'teacher'),(12,'st2','002',6,1,55,'teacher'),(13,'st6','001',5,1,88,'teacher'),(14,'st8','001',5,1,78,'teacher'),(15,'2014','001',5,1,99,'teacher'),(16,'38995','001',5,1,55,'teacher'),(17,'389955','001',5,1,77,'teacher'),(18,'2014','001',5,2,78,'teacher'),(19,'38995','001',5,2,96,'teacher'),(20,'389955','001',5,2,77,'teacher'),(21,'st1','001',5,2,58,'teacher'),(22,'st3','001',5,2,58,'teacher'),(23,'st6','001',5,2,89,'teacher'),(24,'st8','001',5,2,78,'teacher'),(25,'st1','001',5,1,87,'teacher'),(26,'2014','002',5,1,88,'tch002'),(27,'38995','002',5,1,99,'tch002'),(28,'389955','002',5,1,77,'tch002'),(29,'st1','002',5,1,88,'tch002'),(30,'st3','002',5,1,94,'tch002'),(31,'st6','002',5,1,78,'tch002'),(32,'st8','002',5,1,85,'tch002');
/*!40000 ALTER TABLE `termmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(8) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT '123',
  `email` varchar(40) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `level` int(11) NOT NULL,
  `class` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `nic` varchar(11) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `occupation` varchar(500) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `qualifications` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `class_index` (`class`),
  CONSTRAINT `fk_class` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('2014','123','sa@kj.kj','kav',3,5,'Male','1997-06-11',NULL,NULL,NULL,NULL,NULL),('2016t','123','hg@gail.com','namal',2,NULL,'1',NULL,'0123456786','loku para',NULL,'2315646577','d'),('38995','123','sa@a.xvc','kaveesh',3,5,'Male','1992-09-08',NULL,NULL,NULL,NULL,NULL),('389955','123','asd@gmail.com','kaveesh thamal',3,5,'Male','2001-02-04',NULL,NULL,NULL,NULL,NULL),('389955p','123','sdf@gma.com','c baddage',4,NULL,'Male',NULL,'123456789v','maha para','MSc','012345697',NULL),('dinush','123','sisindaa@gmail.com','Sisinda Dinusha',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('kdfh','123','sdfwf@gm.co','sdfhj',4,NULL,'Male',NULL,'dfdfwe','dsgsdg','fgdfg','234234',NULL),('par1','123','wer@g.com','Smpl Parent 1',4,NULL,'Male',NULL,'0123456','afaff','werwef','0123456789',NULL),('parent','123','parent@StudySmart','Parent',4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('principl','123',NULL,'The Principal',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('st1','123','st@studysmart','Student 1',3,5,'male','2000-02-08',NULL,'123, xyz, abc',NULL,NULL,NULL),('st2','123','st@studysmart','Student 2',3,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('st3','123','jas@aa.com','Smpl Student 3',3,5,'Male','2016-08-31',NULL,NULL,NULL,NULL,NULL),('st5','123','a@a.co','student 5',3,6,'Male','2004-06-08',NULL,NULL,NULL,NULL,NULL),('st6','123','kljfd@lgds.com','Smpl Student 6',3,5,'Male','2016-07-13',NULL,NULL,NULL,NULL,NULL),('st8','123','k@gk.lk','sama',3,5,'Male','2016-09-05',NULL,NULL,NULL,NULL,NULL),('tch001','123','jj@gmail.com','A.B.JJ',3,NULL,'1',NULL,'900121212V','48, NN, Frew',NULL,'0771234567','BSC'),('tch002','123','nanda@gmail.com','A.B.C.Prasad',2,NULL,'1',NULL,'0000000v','123, xyz, abc',NULL,'0761234567','bsc'),('teacher','123','teacher@studysmart','Teacher',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user','123','user@email.com','Sample User',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-17 10:47:46
