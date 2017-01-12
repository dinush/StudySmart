-- MySQL dump 10.14  Distrib 5.5.52-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: StudySmart
-- ------------------------------------------------------
-- Server version	5.5.52-MariaDB

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
INSERT INTO `assignment` VALUES ('ass1',5,'001',34,NULL),('assig1',5,'001',12,NULL),('Litreture',5,'003',100,NULL);
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
  `comment` varchar(1000) NOT NULL,
  `addedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assignment_assignmentmarks` (`assignment`) USING BTREE,
  KEY `fk_user_assignmentmarks` (`student`),
  KEY `fk_addedby_assignmentmarks` (`addedby`),
  CONSTRAINT `fk_addedby2_assignmentmarks` FOREIGN KEY (`addedby`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_assignment2_assignmentmarks` FOREIGN KEY (`assignment`) REFERENCES `assignment` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assignmentmarks` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignmentmarks`
--

LOCK TABLES `assignmentmarks` WRITE;
/*!40000 ALTER TABLE `assignmentmarks` DISABLE KEYS */;
INSERT INTO `assignmentmarks` VALUES (6,'assig1','st1',12,'2','teacher'),(7,'ass1','st1',3,'fd','teacher');
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
INSERT INTO `attendance` VALUES ('2006001','2016-09-16',1,'tch002'),('2006001','2016-09-19',1,'tch002'),('2006001','2016-09-20',1,'tch002'),('2006002','2016-09-16',0,'tch002'),('2006002','2016-09-19',1,'tch002'),('2006002','2016-09-20',0,'tch002'),('2006003','2016-09-16',1,'tch002'),('2006003','2016-09-19',1,'tch002'),('2006003','2016-09-20',1,'tch002'),('2006004','2016-09-16',1,'tch002'),('2006004','2016-09-19',1,'tch002'),('2006004','2016-09-20',1,'tch002'),('2006005','2016-09-16',1,'tch002'),('2006005','2016-09-19',0,'tch002'),('2006005','2016-09-20',0,'tch002'),('2006006','2016-09-16',1,'tch002'),('2006006','2016-09-19',1,'tch002'),('2006006','2016-09-20',1,'tch002'),('2006007','2016-09-16',1,'tch002'),('2006007','2016-09-19',0,'tch002'),('2006007','2016-09-20',0,'tch002'),('2006008','2016-09-16',0,'tch002'),('2006008','2016-09-19',1,'tch002'),('2006008','2016-09-20',1,'tch002'),('2006009','2016-09-16',1,'tch002'),('2006009','2016-09-19',1,'tch002'),('2006009','2016-09-20',1,'tch002'),('2006010','2016-09-16',1,'tch002'),('2006010','2016-09-19',0,'tch002'),('2006010','2016-09-20',0,'tch002'),('st005','2016-09-20',1,'tch002'),('st1','2016-08-23',0,'teacher'),('st1','2016-08-24',1,'teacher'),('st1','2016-08-25',1,'teacher'),('st1','2016-09-01',0,'teacher'),('st1','2016-09-04',0,'teacher'),('st1','2016-09-20',1,'tch002'),('st2','2016-08-24',1,'teacher'),('st2','2016-09-01',1,'teacher'),('st2','2016-09-04',0,'teacher'),('st3','2016-09-04',0,'teacher'),('st3','2016-09-20',1,'tch002'),('st6','2016-09-20',1,'tch002'),('st8','2016-09-20',1,'tch002');
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
INSERT INTO `attendanceclass` VALUES (5,'2016-09-20','tch002'),(5,'2016-09-04','teacher'),(6,'2016-09-04','teacher');
/*!40000 ALTER TABLE `attendanceclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `cat_id` int(8) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL,
  `cat_description` varchar(255) NOT NULL,
  `cat_by` varchar(8) NOT NULL,
  `class` varchar(5) NOT NULL DEFAULT '',
  `subject` varchar(25) NOT NULL DEFAULT '',
  `cat_date` date DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_name_unique` (`cat_name`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (48,'Lesson 3','Trigonometry','teacher','5','001','2016-11-10'),(55,'Lesson 2','Chemical Reactions','teacher','6','002','2016-11-10'),(59,'Organic Chemistry','Organic Conversions','teacher','6','002','2016-11-17'),(87,'lalalal','z/./,','teacher','6','002','2017-01-11'),(88,'ccc','hdkjhzdfj','teacher','6','002','2017-01-11'),(93,'kshf','sfkdj','teacher','5','001','2017-01-11');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `child_parent`
--

DROP TABLE IF EXISTS `child_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `child_parent` (
  `studentid` varchar(255) NOT NULL,
  `parentid` varchar(255) NOT NULL,
  PRIMARY KEY (`studentid`,`parentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `child_parent`
--

LOCK TABLES `child_parent` WRITE;
/*!40000 ALTER TABLE `child_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `child_parent` ENABLE KEYS */;
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
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `filename` varchar(100) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `file_id` varchar(25) NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forumposts`
--

DROP TABLE IF EXISTS `forumposts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forumposts` (
  `class` varchar(5) NOT NULL DEFAULT '',
  `subject` varchar(25) NOT NULL DEFAULT '',
  `cat_name` varchar(25) NOT NULL DEFAULT '',
  `added_by` varchar(50) DEFAULT NULL,
  `post` varchar(5000) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(50) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `catid` (`catid`),
  CONSTRAINT `forumposts_ibfk_1` FOREIGN KEY (`catid`) REFERENCES `categories` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forumposts`
--

LOCK TABLES `forumposts` WRITE;
/*!40000 ALTER TABLE `forumposts` DISABLE KEYS */;
INSERT INTO `forumposts` VALUES ('5','001','Lesson 3','st1','Why is integration taught first in numerical methods?','2017-01-10','20:40:15',48,48),('6','002','Lesson 2','teacher','Start the discussion','2017-01-11','10:00:09',52,55),('5','001','Lesson 3','st1','Good Question','2017-01-11','11:23:17',53,48);
/*!40000 ALTER TABLE `forumposts` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (3,0,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:07:38',1,'st3',NULL,NULL,NULL),(4,0,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:07:38',1,'st6',NULL,NULL,NULL),(5,0,'Term 1 marks added','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:07:38',1,'st8',NULL,NULL,NULL),(7,1,'Term 1 marks','Term 1 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-11','11:27:27',1,'parent',NULL,NULL,NULL),(8,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:27:27',1,'st3',NULL,NULL,NULL),(9,0,'Term 1 marks','Term 1 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-11','11:27:28',1,'par1',NULL,NULL,NULL),(10,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:27:28',1,'st6',NULL,NULL,NULL),(11,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-11','11:27:28',1,'st8',NULL,NULL,NULL),(12,0,'Science','Please be assignment ','fdgdpkpdfq3wtr','2016-09-14',NULL,'teacher','2016-09-19','14:41:40',4,NULL,NULL,5,NULL),(13,0,NULL,'All students are required to be present at the School Auditorium on 10.02.20.16 by 8.30 am to attend the School General Meeting.',NULL,NULL,NULL,'dinush','2016-09-20','10:13:19',5,NULL,NULL,NULL,NULL),(14,0,NULL,'The Annual Prize Giving Ceremony will be held on the 25.10.2016.\r\nPrize winners should collect their invitations form the corresponding Sectional Head.',NULL,NULL,NULL,'dinush','2016-09-20','10:15:18',5,NULL,NULL,NULL,NULL),(16,1,'Term 1 marks','Term 1 marks added for English',NULL,NULL,NULL,'tch002','2016-09-20','11:09:56',1,'2006001',NULL,NULL,NULL),(17,0,'Term 1 marks','Term 1 marks added for English',NULL,NULL,NULL,'tch002','2016-09-20','11:09:56',1,'2006002',NULL,NULL,NULL),(18,0,'Term 1 marks','Term 1 marks added for English',NULL,NULL,NULL,'tch002','2016-09-20','11:09:56',1,'2006003',NULL,NULL,NULL),(19,0,'Term 1 marks','Term 1 marks added for English',NULL,NULL,NULL,'tch002','2016-09-20','11:09:56',1,'2006004',NULL,NULL,NULL),(20,0,'Term 1 marks','Term 1 marks added for English',NULL,NULL,NULL,'tch002','2016-09-20','11:09:56',1,'2006005',NULL,NULL,NULL),(21,0,'Term 1 marks','Term 1 marks added for English',NULL,NULL,NULL,'tch002','2016-09-20','11:09:56',1,'2006006',NULL,NULL,NULL),(23,1,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:08',1,'st1',NULL,NULL,NULL),(24,1,'Term 1 marks','Term 1 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-20','11:58:08',1,'parent',NULL,NULL,NULL),(25,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:08',1,'st3',NULL,NULL,NULL),(26,0,'Term 1 marks','Term 1 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-20','11:58:08',1,'par1',NULL,NULL,NULL),(27,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:08',1,'st6',NULL,NULL,NULL),(28,0,'Term 1 marks','Term 1 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:08',1,'st8',NULL,NULL,NULL),(29,1,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:22',1,'st1',NULL,NULL,NULL),(30,1,'Term 2 marks','Term 2 marks added for Maths (student: Student 1 [st1])',NULL,NULL,NULL,'teacher','2016-09-20','11:58:22',1,'parent',NULL,NULL,NULL),(31,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:22',1,'st3',NULL,NULL,NULL),(32,0,'Term 2 marks','Term 2 marks added for Maths (student: Smpl Student 3 [st3])',NULL,NULL,NULL,'teacher','2016-09-20','11:58:23',1,'par1',NULL,NULL,NULL),(33,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:23',1,'st6',NULL,NULL,NULL),(34,0,'Term 2 marks','Term 2 marks added for Maths',NULL,NULL,NULL,'teacher','2016-09-20','11:58:23',1,'st8',NULL,NULL,NULL),(36,0,NULL,'Sports meet held on 14/10/2016 @ Sugathadasa Stadium.',NULL,NULL,NULL,'dinush','2016-09-20','12:37:59',5,NULL,NULL,NULL,NULL),(37,0,'spl title','smpl content','has','2016-09-29',NULL,'tch002','2016-09-20','12:40:54',4,NULL,NULL,5,NULL);
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
-- Table structure for table `principal`
--

DROP TABLE IF EXISTS `principal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `principal` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `principal`
--

LOCK TABLES `principal` WRITE;
/*!40000 ALTER TABLE `principal` DISABLE KEYS */;
/*!40000 ALTER TABLE `principal` ENABLE KEYS */;
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
-- Table structure for table `quize`
--

DROP TABLE IF EXISTS `quize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quize` (
  `subject_id` varchar(25) NOT NULL,
  `quize_id` varchar(25) NOT NULL,
  `title` varchar(25) NOT NULL,
  `question_id` varchar(25) NOT NULL,
  PRIMARY KEY (`quize_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quize`
--

LOCK TABLES `quize` WRITE;
/*!40000 ALTER TABLE `quize` DISABLE KEYS */;
/*!40000 ALTER TABLE `quize` ENABLE KEYS */;
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
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `user_Id` varchar(25) NOT NULL,
  `student_id` varchar(25) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
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
INSERT INTO `student_parent` VALUES (4,'kdfh','st3'),(2,'par1','st2'),(3,'par1','st3'),(5,'par10','st10'),(1,'parent','st1');
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentsubject`
--

LOCK TABLES `studentsubject` WRITE;
/*!40000 ALTER TABLE `studentsubject` DISABLE KEYS */;
INSERT INTO `studentsubject` VALUES (1,'st1','001'),(2,'st1','002'),(4,'st2','002'),(5,'st2','004'),(6,'st3','001'),(7,'st3','002'),(8,'st3','004'),(9,'st5','001'),(10,'st5','003'),(11,'st6','001'),(12,'st6','002'),(13,'st8','001'),(14,'st8','002'),(16,'st8','004'),(17,'2005001','002'),(18,'2005002','002'),(19,'2005001','001'),(20,'2005002','001'),(21,'2006006','003'),(22,'2006004','003'),(23,'2006001','003'),(24,'2006002','003'),(25,'2006003','003'),(26,'2006005','003'),(27,'st005','001'),(28,'st005','002'),(29,'st005','003'),(30,'st005','004'),(31,'st10','001'),(32,'st10','002'),(33,'st10','003'),(34,'st10','004');
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
INSERT INTO `subject` VALUES ('001','Maths',10),('002','Science',10),('003','English',10),('004','IT',10),('005','Maths',11),('006','Physics',11);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_addmin`
--

DROP TABLE IF EXISTS `system_addmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_addmin` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_addmin`
--

LOCK TABLES `system_addmin` WRITE;
/*!40000 ALTER TABLE `system_addmin` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_addmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `user_id` varchar(25) NOT NULL,
  `subject_id` varchar(25) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
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
  CONSTRAINT `fk_subject` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TeacherTeaches_ibfk_1` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacherteaches`
--

LOCK TABLES `teacherteaches` WRITE;
/*!40000 ALTER TABLE `teacherteaches` DISABLE KEYS */;
INSERT INTO `teacherteaches` VALUES (1,'teacher','001',5),(2,'teacher','002',6),(15,'tch002','003',5),(16,'tch002','003',6),(17,'tch002','004',5),(18,'tch002','004',6);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `termmarks`
--

LOCK TABLES `termmarks` WRITE;
/*!40000 ALTER TABLE `termmarks` DISABLE KEYS */;
INSERT INTO `termmarks` VALUES (1,'st1','001',5,1,86,'teacher'),(5,'st3','001',5,1,66,'teacher'),(12,'st2','002',6,1,55,'teacher'),(13,'st6','001',5,1,88,'teacher'),(14,'st8','001',5,1,78,'teacher'),(15,'2006001','003',5,1,80,'tch002'),(16,'2006002','003',5,1,70,'tch002'),(17,'2006003','003',5,1,88,'tch002'),(18,'2006004','003',5,1,77,'tch002'),(19,'2006005','003',5,1,86,'tch002'),(20,'2006006','003',5,1,87,'tch002'),(21,'st1','001',5,2,75,'teacher'),(22,'st3','001',5,2,84,'teacher'),(23,'st6','001',5,2,78,'teacher'),(24,'st8','001',5,2,90,'teacher');
/*!40000 ALTER TABLE `termmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test1`
--

DROP TABLE IF EXISTS `test1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test1` (
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test1`
--

LOCK TABLES `test1` WRITE;
/*!40000 ALTER TABLE `test1` DISABLE KEYS */;
/*!40000 ALTER TABLE `test1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `topic_id` int(8) NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(50) NOT NULL,
  `topic_date` datetime NOT NULL,
  `topic_cat` int(8) NOT NULL,
  `topic_by` varchar(8) NOT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `topic_cat` (`topic_cat`),
  KEY `topic_by` (`topic_by`),
  CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`topic_cat`) REFERENCES `categories` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `topics_ibfk_2` FOREIGN KEY (`topic_by`) REFERENCES `user` (`username`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
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
INSERT INTO `user` VALUES ('2005001','123','S.Mafras@gmail.com','Shamil Perera',3,NULL,'Male','1999-05-04',NULL,'78, Dematagoda Road, Colombo 10',NULL,'0754500026',NULL),('2005001P','123','Kami@gmail.com','Kamila Perera',0,NULL,'Male','1965-10-12','659865321V','78, Dematagoda Road, Colombo 10','Driver','0754500026',NULL),('2005002','123','nimalthusantha@gmail.com ','Nimal Thusantha',3,6,'Male','2000-07-23',NULL,'425/c, Kayser Street, Colombo',NULL,'0771845523',NULL),('2005002P','123','Jan@gmail.com','Janith Thusantha',0,NULL,'Male','1966-03-01','662154873V','425/c, Kayser Street, Colombo','Accontan','0771845523','\r\n\r\n'),('2005003','123','rp456@gmail.com','Ruwan Pathirena',3,6,'Male','1999-11-02',NULL,'184/5, Polgolla Road, Hinguloya',NULL,'0716321963',NULL),('2005003P','123','Mahpat@gmail.com','Mahindha Pathirena',0,NULL,'Male','1967-05-09','679864318V','184/5, Polgolla Road, Hinguloya','Mannager','0716321963',NULL),('2005004','123','Rudanemlp01@gmail.com','Rudane Thennakone',3,6,'Male','1999-05-29',NULL,'23, visaka mawatha, Pannipitiya','Security','0772563417','\r\n'),('2005004P','123','Kasun@gmail.com','Kasun Thennakone',0,NULL,'Male','1968-11-16','68028064V','23, visaka mawatha, Pannipitiya','Teacher','0772563417',NULL),('2005005','123','suraj@gmail.com','Mahendhira Suraj',3,6,'Male','1999-02-28',NULL,'12/A, jayasekera mawatha, kurunagala.',NULL,'0777865124','\r\n\r\n\r\n'),('2005005P','123','Chadi12@gmail.com','Chandi Suraj',0,NULL,'Male','1969-12-25','697894561V','12/A, jayasekera mawatha, kurunagala.','Principal','0777865124',NULL),('2005006','123','jayasekera@gmail.com','Jayasekera Bavan',3,6,NULL,'1999-03-18',NULL,'himalaya Road, Main street, Kandy',NULL,'0714859632',NULL),('2005006P','123','ab654@yahoo.com','Anandha Bavan',0,NULL,'Male','1966-06-12','669764312V','himalaya Road, Main street, Kandy','Doctor','0714859632',NULL),('2005007','123','hilalbmw@yahoo.com','Chaneka Hilaleswaren',3,6,'Male','1999-12-03',NULL,'12/c, S.L. Lane, Battikalo Road, Paandiruppu - 10',NULL,'0729865321',NULL),('2005007P','123','sumhil@gmail.com','sumithira Hilaleswaren',0,NULL,'Male','1965-10-14','652581436V','12/c, S.L. Lane, Battikalo Road, Paandiruppu - 10','Engineer','0729865321',NULL),('2005008','123','mujeenasd@gmail.com','Mujeebur Rajapaksha',3,6,'Male','2000-08-10',NULL,'351/1C, lake house Road , Colombo',NULL,'0712354879',NULL),('2005008P','123','sr@gmail.com','Sooriyavansa Rajapaksha',0,NULL,'Male','1970-01-20','702032106V','351/1C, lake house Road , Colombo','Carpentar','0712354879',NULL),('2005009','123','maithiri@gmail.com','Maithiri Balakumra',3,6,'Male','1999-03-16',NULL,'21A/4, 1St Lane, Anuradhapura',NULL,'0758865454','\r\n'),('2005009P','123','kb@gmail.com','Kanahambaram Balakumra',0,NULL,'Male','1971-06-06','710253641V','21A/4, 1St Lane, Anuradhapura','Driver','0758865454',NULL),('2005010','123','kavi2121@gmail.com','Kavirupala sandakan',3,6,'Male','1999-08-21',NULL,'456C, 2nd Cross Street, Colombo',NULL,'0772358170','\r\n\r\n'),('2005010P','123','rs678@gmail.com','Ravi sandakan',0,NULL,'Male','1973-09-30','735808126V','456C, 2nd Cross Street, Colombo','Electresion','0772358170',NULL),('2006001','123','dudith2000@gmail.com','Udith Dilshan',3,5,'Male','2000-08-28',NULL,NULL,NULL,NULL,NULL),('2006002','123','tnuwan@gmail.com','Thikshana Nuwan',3,5,'Male','2000-05-03',NULL,NULL,NULL,NULL,NULL),('2006003','123','udhima@gmail.com','Udani Himansa',3,5,'Female','2000-11-23',NULL,NULL,NULL,NULL,NULL),('2006004','123','kamali@gmail.com','Amali Kalpana',3,5,'Female','2000-09-11',NULL,NULL,NULL,NULL,NULL),('2006005','123','nethup@gmail.com','Nethu Perera',3,5,'Female','2000-07-01',NULL,NULL,NULL,NULL,NULL),('2006006','123','vishwako@gmail.com','vishwa Kodikara',3,5,'Male','2000-05-30',NULL,NULL,NULL,NULL,NULL),('2006007','123','kalanas@gmail.com','Kalana Sandeepa',3,5,'Male','2016-09-19',NULL,NULL,NULL,NULL,NULL),('2006008','123','nipunin@gmail.com','Nipuni Nayanathara',3,5,'Female','2000-10-20',NULL,NULL,NULL,NULL,NULL),('2006009','123','gmahima@gmail.com','Mahima Gamage',3,5,'Male','2000-07-15',NULL,NULL,NULL,NULL,NULL),('2006010','123','tharakam@gmail.com','Tharaka Mendis',3,5,'Male','2000-05-30',NULL,NULL,NULL,NULL,NULL),('dinush','123','sisindaa@gmail.com','Sisinda Dinusha',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('kdfh','123','sdfwf@gm.co','sdfhj',4,NULL,'Male',NULL,'dfdfwe','dsgsdg','fgdfg','234234',NULL),('p2006001','123','saraths@gmail.com','Sarath Silva',4,NULL,'Male',NULL,'651234565V','26/3 Temple Road,wijeerama','Electrical engineer','0714538712',NULL),('p2006002','123','nimal@gmail.com','Nimal Jayasooriya',4,NULL,'Male',NULL,'672341234V','59/3, Kalubovila South','Medical doctor ','0774566543',NULL),('p2006003','123','kusuma@gmail.com','Kusuma Kariyawasam',4,NULL,'Male',NULL,'765432465V','\"Siriniwasa\",Pamankada South','Pharmacist ','0775647812',NULL),('p2006004','123','amila@gmail.com','Amila Wimalasiri',4,NULL,'Male',NULL,'741654343V','76/6 wimalasooriya Road','Civil engineer','0786545612',NULL),('p2006005','123','kamal@gmail.com','Kamal Perera',4,NULL,'Male',NULL,'652486542V','123/4 Horana Road,piliyandala','Stock clerk','0714345615',NULL),('p2006006','123','suni@gmail.com','Sunil Kodikara',4,NULL,'Male',NULL,'780454312V','Gamini Mawatha,Kirulapana','Civil engineer','780454312V',NULL),('p2006007','123','lelaa@gmail.com','Lelaa Gamage',4,NULL,'Female',NULL,'666547618V','321/9,Sujatha Road,Kirulapana','clerk','0712345673',NULL),('p2006008','123','nalin@gmail.com','Nalin Bandara',4,NULL,'Male',NULL,'712307654V','Jayawardhana Lane,Colombo 5','Jayawardhana Lane,Colombo 5,Lawyer','0776543761',NULL),('p2006009','123','sumith@gmail.com','Sumith Gamage',4,NULL,'Male',NULL,'811143123V','School Lane,Pannipitiya','Medical doctor','078654783',NULL),('p2006010','123','rangana@gmail.com','Rangana Mendis',4,NULL,'Male',NULL,'802347641V','673/2,Colombo 10','Electrical engineer','0774561211',NULL),('par1','123','wer@g.com','Smpl Parent 1',4,NULL,'Male',NULL,'0123456','afaff','werwef','0123456789',NULL),('par10','123','par10@email.com','Parent 10',4,NULL,'Female',NULL,'900000000v','Havelock','manager','000-0000000',NULL),('parent','123','parent@StudySmart','Parent',4,NULL,'Female','2016-08-09','946150363V',NULL,'Banking Manageress',NULL,NULL),('st005','123','sti@gmail.com','Student 5',3,5,'Male','2000-06-20',NULL,NULL,NULL,NULL,NULL),('st1','123','st@studysmart','Student 1',3,5,'male','2000-02-08',NULL,'123, xyz, abc',NULL,NULL,NULL),('st10','123','','Sample student 10',3,6,'Male','2004-07-14',NULL,NULL,NULL,NULL,NULL),('st2','123','st@studysmart','Student 2',3,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('st3','123','jas@aa.com','Smpl Student 3',3,5,'Male','2016-08-31',NULL,NULL,NULL,NULL,NULL),('st5','123','a@a.co','student 5',3,6,'Male','2004-06-08',NULL,NULL,NULL,NULL,NULL),('st6','123','kljfd@lgds.com','Smpl Student 6',3,5,'Male','2016-07-13',NULL,NULL,NULL,NULL,NULL),('st8','123','k@gk.lk','sama',3,5,'Male','2016-09-05',NULL,NULL,NULL,NULL,NULL),('tch002','12345678','nayomi@gmail.com','Nayomi Nanayakkara',2,NULL,'2',NULL,'681476947v','abc street, sl',NULL,'0716677339','BSC(IT)'),('teacher','123','teacher@studysmart','Teacher',2,NULL,'Female','1965-02-02','946150363V','No. 26, PetersonLane, Col 06',NULL,'0112970400','Bsc from University of Colombo'),('user','123','user@email.com','Sample User',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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

-- Dump completed on 2017-01-11 22:00:39
