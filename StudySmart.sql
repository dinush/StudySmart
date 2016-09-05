-- MySQL dump 10.15  Distrib 10.0.25-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: StudySmart
-- ------------------------------------------------------
-- Server version	10.0.25-MariaDB

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
-- Table structure for table `Assignment`
--

DROP TABLE IF EXISTS `Assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assignment` (
  `name` varchar(250) NOT NULL,
  `class` int(11) NOT NULL,
  `subject` varchar(25) CHARACTER SET latin1 NOT NULL,
  `max` int(4) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_class_assignment` (`class`),
  KEY `fk_subject_assignment` (`subject`),
  CONSTRAINT `fk_class_assignment` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subject_assignment` FOREIGN KEY (`subject`) REFERENCES `Subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignment`
--

LOCK TABLES `Assignment` WRITE;
/*!40000 ALTER TABLE `Assignment` DISABLE KEYS */;
INSERT INTO `Assignment` VALUES ('ass1',5,'001',34),('assig1',5,'001',12);
/*!40000 ALTER TABLE `Assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssignmentMarks`
--

DROP TABLE IF EXISTS `AssignmentMarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssignmentMarks` (
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
  CONSTRAINT `fk_addedby2_assignmentmarks` FOREIGN KEY (`addedby`) REFERENCES `User` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_assignment2_assignmentmarks` FOREIGN KEY (`assignment`) REFERENCES `Assignment` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assignmentmarks` FOREIGN KEY (`student`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssignmentMarks`
--

LOCK TABLES `AssignmentMarks` WRITE;
/*!40000 ALTER TABLE `AssignmentMarks` DISABLE KEYS */;
INSERT INTO `AssignmentMarks` VALUES (6,'assig1','st1',12,'2','teacher'),(7,'ass1','st1',3,'fd','teacher');
/*!40000 ALTER TABLE `AssignmentMarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attendance`
--

DROP TABLE IF EXISTS `Attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attendance` (
  `username` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `attended` tinyint(1) DEFAULT NULL,
  `markedBy` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`username`,`date`),
  KEY `Attendance_ibfk_1` (`markedBy`),
  CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`markedBy`) REFERENCES `User` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attendance`
--

LOCK TABLES `Attendance` WRITE;
/*!40000 ALTER TABLE `Attendance` DISABLE KEYS */;
INSERT INTO `Attendance` VALUES ('st1','2016-08-23',0,'teacher'),('st1','2016-08-24',1,'teacher'),('st1','2016-08-25',1,'teacher'),('st1','2016-09-01',0,'teacher'),('st1','2016-09-04',0,'teacher'),('st2','2016-08-24',1,'teacher'),('st2','2016-09-01',1,'teacher'),('st2','2016-09-04',0,'teacher'),('st3','2016-09-04',0,'teacher');
/*!40000 ALTER TABLE `Attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AttendanceClass`
--

DROP TABLE IF EXISTS `AttendanceClass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AttendanceClass` (
  `class` int(11) NOT NULL,
  `date` date NOT NULL,
  `markedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`class`,`date`),
  KEY `markedby` (`markedby`),
  CONSTRAINT `fk_class_attendanceclass` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_markkedby_attendanceclass` FOREIGN KEY (`markedby`) REFERENCES `User` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AttendanceClass`
--

LOCK TABLES `AttendanceClass` WRITE;
/*!40000 ALTER TABLE `AttendanceClass` DISABLE KEYS */;
INSERT INTO `AttendanceClass` VALUES (5,'2016-09-04','teacher'),(6,'2016-09-04','teacher');
/*!40000 ALTER TABLE `AttendanceClass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` int(2) NOT NULL,
  `subclass` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class`
--

LOCK TABLES `Class` WRITE;
/*!40000 ALTER TABLE `Class` DISABLE KEYS */;
INSERT INTO `Class` VALUES (5,10,'A'),(6,10,'B'),(7,11,'A'),(8,11,'B');
/*!40000 ALTER TABLE `Class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClassNews`
--

DROP TABLE IF EXISTS `ClassNews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClassNews` (
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
  CONSTRAINT `fk_addedby` FOREIGN KEY (`addedby`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_class_news` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClassNews`
--

LOCK TABLES `ClassNews` WRITE;
/*!40000 ALTER TABLE `ClassNews` DISABLE KEYS */;
INSERT INTO `ClassNews` VALUES (1,5,'teacher','titl212','1dfsd',NULL,NULL,NULL,NULL),(2,5,'teacher','News 2','this is the message',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ClassNews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message`
--

DROP TABLE IF EXISTS `Message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message` (
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
  CONSTRAINT `fk_addeduser_message` FOREIGN KEY (`addeduser`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_class_message` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_targetuser_message` FOREIGN KEY (`targetuser`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message`
--

LOCK TABLES `Message` WRITE;
/*!40000 ALTER TABLE `Message` DISABLE KEYS */;
INSERT INTO `Message` VALUES (1,0,'title test','sample message',NULL,'2016-09-28',NULL,'teacher','2016-09-04','17:14:32',4,NULL,NULL,5,NULL);
/*!40000 ALTER TABLE `Message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quiz`
--

DROP TABLE IF EXISTS `Quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Quiz` (
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
  CONSTRAINT `Quiz_ibfk_1` FOREIGN KEY (`idQuizset`) REFERENCES `Quizset` (`quizsetId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Quiz_ibfk_2` FOREIGN KEY (`username`) REFERENCES `User` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quiz`
--

LOCK TABLES `Quiz` WRITE;
/*!40000 ALTER TABLE `Quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `Quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quizset`
--

DROP TABLE IF EXISTS `Quizset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Quizset` (
  `quizsetId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `subject` varchar(25) DEFAULT NULL,
  `quizes` varchar(100) NOT NULL,
  `username` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`quizsetId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quizset`
--

LOCK TABLES `Quizset` WRITE;
/*!40000 ALTER TABLE `Quizset` DISABLE KEYS */;
/*!40000 ALTER TABLE `Quizset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SEQUENCE`
--

DROP TABLE IF EXISTS `SEQUENCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SEQUENCE` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SEQUENCE`
--

LOCK TABLES `SEQUENCE` WRITE;
/*!40000 ALTER TABLE `SEQUENCE` DISABLE KEYS */;
INSERT INTO `SEQUENCE` VALUES ('SEQ_GEN',0);
/*!40000 ALTER TABLE `SEQUENCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StudentSubject`
--

DROP TABLE IF EXISTS `StudentSubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StudentSubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid_index` (`userId`),
  KEY `subjectid_index` (`subjectId`),
  CONSTRAINT `fk_subject_id` FOREIGN KEY (`subjectId`) REFERENCES `Subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`userId`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StudentSubject`
--

LOCK TABLES `StudentSubject` WRITE;
/*!40000 ALTER TABLE `StudentSubject` DISABLE KEYS */;
INSERT INTO `StudentSubject` VALUES (1,'st1','001'),(2,'st1','002'),(3,'st1','003'),(4,'st2','002'),(5,'st2','004'),(6,'st3','001'),(7,'st3','002'),(8,'st3','004');
/*!40000 ALTER TABLE `StudentSubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student_Parent`
--

DROP TABLE IF EXISTS `Student_Parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student_Parent` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  `studentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `uniq_parent_child` (`parentid`,`studentid`),
  KEY `fk_student_parent_2` (`studentid`),
  CONSTRAINT `fk_student_parent_1` FOREIGN KEY (`parentid`) REFERENCES `User` (`username`) ON UPDATE CASCADE,
  CONSTRAINT `fk_student_parent_2` FOREIGN KEY (`studentid`) REFERENCES `User` (`username`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student_Parent`
--

LOCK TABLES `Student_Parent` WRITE;
/*!40000 ALTER TABLE `Student_Parent` DISABLE KEYS */;
INSERT INTO `Student_Parent` VALUES (2,'par1','st2'),(3,'par1','st3'),(1,'parent','st1');
/*!40000 ALTER TABLE `Student_Parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subject`
--

DROP TABLE IF EXISTS `Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Subject` (
  `idSubject` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `grade` int(2) NOT NULL DEFAULT '10',
  PRIMARY KEY (`idSubject`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subject`
--

LOCK TABLES `Subject` WRITE;
/*!40000 ALTER TABLE `Subject` DISABLE KEYS */;
INSERT INTO `Subject` VALUES ('001','Maths',10),('002','Science',10),('003','English',10),('004','IT',10);
/*!40000 ALTER TABLE `Subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TeacherSubject`
--

DROP TABLE IF EXISTS `TeacherSubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TeacherSubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectId` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TeacherSubject`
--

LOCK TABLES `TeacherSubject` WRITE;
/*!40000 ALTER TABLE `TeacherSubject` DISABLE KEYS */;
/*!40000 ALTER TABLE `TeacherSubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TeacherTeaches`
--

DROP TABLE IF EXISTS `TeacherTeaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TeacherTeaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  `class` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_index` (`userId`),
  KEY `subject_index` (`subjectId`),
  KEY `class_index` (`class`) USING BTREE,
  CONSTRAINT `TeacherTeaches_ibfk_1` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subject` FOREIGN KEY (`subjectId`) REFERENCES `Subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TeacherTeaches`
--

LOCK TABLES `TeacherTeaches` WRITE;
/*!40000 ALTER TABLE `TeacherTeaches` DISABLE KEYS */;
INSERT INTO `TeacherTeaches` VALUES (1,'teacher','001',5),(2,'teacher','002',6);
/*!40000 ALTER TABLE `TeacherTeaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TermMarks`
--

DROP TABLE IF EXISTS `TermMarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TermMarks` (
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
  CONSTRAINT `fk_class_tm` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_markedby_tm` FOREIGN KEY (`markedby`) REFERENCES `User` (`username`),
  CONSTRAINT `fk_student_tm` FOREIGN KEY (`student`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subject_tm` FOREIGN KEY (`subject`) REFERENCES `Subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TermMarks`
--

LOCK TABLES `TermMarks` WRITE;
/*!40000 ALTER TABLE `TermMarks` DISABLE KEYS */;
INSERT INTO `TermMarks` VALUES (1,'st1','001',5,1,14,'teacher'),(5,'st3','001',5,1,66,'teacher'),(12,'st2','002',6,1,55,'teacher');
/*!40000 ALTER TABLE `TermMarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `username` varchar(8) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT '123',
  `email` varchar(40) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `level` int(11) NOT NULL,
  `subject` varchar(25) DEFAULT NULL,
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
  CONSTRAINT `fk_class` FOREIGN KEY (`class`) REFERENCES `Class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('dinush','123','sisindaa@gmail.com','Sisinda Dinusha',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('par1','123','wer@g.com','Smpl Parent 1',4,NULL,NULL,'Male',NULL,'0123456','afaff','werwef','0123456789',NULL),('parent','123','parent@StudySmart','Parent',4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('st1','123','st@studysmart','Student 1',3,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('st2','123','st@studysmart','Student 2',3,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('st3','123','jas@aa.com','Smpl Student 3',3,NULL,5,'Male','2016-08-31',NULL,NULL,NULL,NULL,NULL),('teacher','123','teacher@studysmart','Teacher',2,'004',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user','123','user@email.com','Sample User',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-05 10:30:08
