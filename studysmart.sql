-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2016 at 07:10 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `studysmart`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE IF NOT EXISTS `announcement` (
  `announcement_id` varchar(25) NOT NULL,
  `message` varchar(25) NOT NULL,
  `date_time` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE IF NOT EXISTS `assignment` (
  `name` varchar(250) NOT NULL,
  `class` int(11) NOT NULL,
  `subject` varchar(25) CHARACTER SET latin1 NOT NULL,
  `max` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`name`, `class`, `subject`, `max`) VALUES
('ass1', 5, '001', 34),
('assig1', 5, '001', 12);

-- --------------------------------------------------------

--
-- Table structure for table `assignmentmarks`
--

CREATE TABLE IF NOT EXISTS `assignmentmarks` (
  `id` int(11) NOT NULL,
  `assignment` varchar(250) NOT NULL,
  `student` varchar(8) CHARACTER SET latin1 NOT NULL,
  `mark` int(4) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `addedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `assignmentmarks`
--

INSERT INTO `assignmentmarks` (`id`, `assignment`, `student`, `mark`, `comment`, `addedby`) VALUES
(6, 'assig1', 'st1', 12, '2', 'teacher'),
(7, 'ass1', 'st1', 3, 'fd', 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE IF NOT EXISTS `attendance` (
  `username` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `attended` tinyint(1) DEFAULT NULL,
  `markedBy` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`username`, `date`, `attended`, `markedBy`) VALUES
('st1', '2016-08-23', 0, 'teacher'),
('st1', '2016-08-24', 1, 'teacher'),
('st1', '2016-08-25', 1, 'teacher'),
('st1', '2016-09-01', 0, 'teacher'),
('st1', '2016-09-04', 0, 'teacher'),
('st2', '2016-08-24', 1, 'teacher'),
('st2', '2016-09-01', 1, 'teacher'),
('st2', '2016-09-04', 0, 'teacher'),
('st3', '2016-09-04', 0, 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `attendanceclass`
--

CREATE TABLE IF NOT EXISTS `attendanceclass` (
  `class` int(11) NOT NULL,
  `date` date NOT NULL,
  `markedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `attendanceclass`
--

INSERT INTO `attendanceclass` (`class`, `date`, `markedby`) VALUES
(5, '2016-09-04', 'teacher'),
(6, '2016-09-04', 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `child_parent`
--

CREATE TABLE IF NOT EXISTS `child_parent` (
  `studentid` varchar(255) NOT NULL,
  `parentid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE IF NOT EXISTS `class` (
  `id` int(11) NOT NULL,
  `grade` int(2) NOT NULL,
  `subclass` varchar(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `grade`, `subclass`) VALUES
(5, 10, 'A'),
(6, 10, 'B'),
(7, 11, 'A'),
(8, 11, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `classnews`
--

CREATE TABLE IF NOT EXISTS `classnews` (
  `id` int(11) NOT NULL,
  `class` int(11) NOT NULL,
  `addedby` varchar(8) CHARACTER SET latin1 NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `addeddate` date DEFAULT NULL,
  `addedtime` time DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `classnews`
--

INSERT INTO `classnews` (`id`, `class`, `addedby`, `title`, `message`, `date`, `time`, `addeddate`, `addedtime`) VALUES
(1, 5, 'teacher', 'titl212', '1dfsd', NULL, NULL, NULL, NULL),
(2, 5, 'teacher', 'News 2', 'this is the message', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `filename` varchar(100) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `file_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_thead`
--

CREATE TABLE IF NOT EXISTS `forum_thead` (
  `forum_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

CREATE TABLE IF NOT EXISTS `marks` (
  `user_Id` varchar(25) NOT NULL,
  `subject_id` varchar(25) NOT NULL,
  `marks` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL,
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
  `grade` int(2) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `seen`, `title`, `content`, `url`, `targetdate`, `targettime`, `addeduser`, `addeddate`, `addedtime`, `type`, `targetuser`, `userlevel`, `class`, `grade`) VALUES
(1, 0, 'title test', 'sample message', NULL, '2016-09-28', NULL, 'teacher', '2016-09-04', '17:14:32', 4, NULL, NULL, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `parent`
--

CREATE TABLE IF NOT EXISTS `parent` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `user_Id` varchar(25) NOT NULL,
  `post_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `principal`
--

CREATE TABLE IF NOT EXISTS `principal` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `question_id` varchar(25) NOT NULL,
  `option1` varchar(25) NOT NULL,
  `option2` varchar(25) NOT NULL,
  `option3` varchar(25) NOT NULL,
  `option4` varchar(25) NOT NULL,
  `answer` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `idQuiz` int(11) NOT NULL,
  `question` varchar(500) NOT NULL,
  `option1` varchar(200) NOT NULL,
  `option2` varchar(200) NOT NULL,
  `option3` varchar(200) DEFAULT NULL,
  `option4` varchar(200) DEFAULT NULL,
  `answers` varchar(45) NOT NULL,
  `username` varchar(8) DEFAULT NULL,
  `idQuizset` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quize`
--

CREATE TABLE IF NOT EXISTS `quize` (
  `subject_id` varchar(25) NOT NULL,
  `quize_id` varchar(25) NOT NULL,
  `title` varchar(25) NOT NULL,
  `question_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quizset`
--

CREATE TABLE IF NOT EXISTS `quizset` (
  `quizsetId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `subject` varchar(25) DEFAULT NULL,
  `quizes` varchar(100) NOT NULL,
  `username` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sequence`
--

CREATE TABLE IF NOT EXISTS `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sequence`
--

INSERT INTO `sequence` (`SEQ_NAME`, `SEQ_COUNT`) VALUES
('SEQ_GEN', '0');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `user_Id` varchar(25) NOT NULL,
  `student_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `studentsubject`
--

CREATE TABLE IF NOT EXISTS `studentsubject` (
  `id` int(11) NOT NULL,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `studentsubject`
--

INSERT INTO `studentsubject` (`id`, `userId`, `subjectId`) VALUES
(1, 'st1', '001'),
(2, 'st1', '002'),
(3, 'st1', '003'),
(4, 'st2', '002'),
(5, 'st2', '004'),
(6, 'st3', '001'),
(7, 'st3', '002'),
(8, 'st3', '004');

-- --------------------------------------------------------

--
-- Table structure for table `student_parent`
--

CREATE TABLE IF NOT EXISTS `student_parent` (
  `_id` int(11) NOT NULL,
  `parentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  `studentid` varchar(8) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student_parent`
--

INSERT INTO `student_parent` (`_id`, `parentid`, `studentid`) VALUES
(2, 'par1', 'st2'),
(3, 'par1', 'st3'),
(1, 'parent', 'st1');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE IF NOT EXISTS `subject` (
  `idSubject` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `grade` int(2) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`idSubject`, `name`, `grade`) VALUES
('001', 'Maths', 10),
('002', 'Science', 10),
('003', 'English', 10),
('004', 'IT', 10);

-- --------------------------------------------------------

--
-- Table structure for table `system_addmin`
--

CREATE TABLE IF NOT EXISTS `system_addmin` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
  `user_id` varchar(25) NOT NULL,
  `subject_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teachersubject`
--

CREATE TABLE IF NOT EXISTS `teachersubject` (
  `id` int(11) NOT NULL,
  `subjectId` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `teacherteaches`
--

CREATE TABLE IF NOT EXISTS `teacherteaches` (
  `id` int(11) NOT NULL,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  `class` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teacherteaches`
--

INSERT INTO `teacherteaches` (`id`, `userId`, `subjectId`, `class`) VALUES
(1, 'teacher', '001', 5),
(2, 'teacher', '002', 6);

-- --------------------------------------------------------

--
-- Table structure for table `termmarks`
--

CREATE TABLE IF NOT EXISTS `termmarks` (
  `id` int(11) NOT NULL,
  `student` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subject` varchar(25) CHARACTER SET latin1 NOT NULL,
  `class` int(11) NOT NULL,
  `term` int(1) NOT NULL,
  `value` int(4) NOT NULL,
  `markedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `termmarks`
--

INSERT INTO `termmarks` (`id`, `student`, `subject`, `class`, `term`, `value`, `markedby`) VALUES
(1, 'st1', '001', 5, 1, 14, 'teacher'),
(5, 'st3', '001', 5, 1, 66, 'teacher'),
(12, 'st2', '002', 6, 1, 55, 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
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
  `qualifications` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `email`, `name`, `level`, `subject`, `class`, `gender`, `birthdate`, `nic`, `address`, `occupation`, `phone`, `qualifications`) VALUES
('2005001', '123', 'S.Mafras@gmail.com', 'Shamil Perera', 3, NULL, NULL, 'Male', '1999-05-04', NULL, '78, Dematagoda Road, Colombo 10', NULL, '0754500026', NULL),
('2005001P', '123', 'Kami@gmail.com', 'Kamila Perera', 0, NULL, NULL, 'Male', '1965-10-12', '659865321V', '78, Dematagoda Road, Colombo 10', 'Driver', '0754500026', NULL),
('2005002', '123', 'nimalthusantha@gmail.com ', 'Nimal Thusantha', 3, NULL, 5, 'Male', '2000-07-23', NULL, '425/c, Kayser Street, Colombo', NULL, '0771845523', NULL),
('2005002P', '123', 'Jan@gmail.com', 'Janith Thusantha', 0, NULL, NULL, 'Male', '1966-03-01', '662154873V', '425/c, Kayser Street, Colombo', 'Accontan', '0771845523', '\r\n\r\n'),
('2005003', '123', 'rp456@gmail.com', 'Ruwan Pathirena', 3, NULL, 5, 'Male', '1999-11-02', NULL, '184/5, Polgolla Road, Hinguloya', NULL, '0716321963', NULL),
('2005003P', '123', 'Mahpat@gmail.com', 'Mahindha Pathirena', 0, NULL, NULL, 'Male', '1967-05-09', '679864318V', '184/5, Polgolla Road, Hinguloya', 'Mannager', '0716321963', NULL),
('2005004', '123', 'Rudanemlp01@gmail.com', 'Rudane Thennakone', 3, NULL, 5, 'Male', '1999-05-29', NULL, '23, visaka mawatha, Pannipitiya', 'Security', '0772563417', '\r\n'),
('2005004P', '123', 'Kasun@gmail.com', 'Kasun Thennakone', 0, NULL, NULL, 'Male', '1968-11-16', '68028064V', '23, visaka mawatha, Pannipitiya', 'Teacher', '0772563417', NULL),
('2005005', '123', 'suraj@gmail.com', 'Mahendhira Suraj', 3, NULL, 5, 'Male', '1999-02-28', NULL, '12/A, jayasekera mawatha, kurunagala.', NULL, '0777865124', '\r\n\r\n\r\n'),
('2005005P', '123', 'Chadi12@gmail.com', 'Chandi Suraj', 0, NULL, NULL, 'Male', '1969-12-25', '697894561V', '12/A, jayasekera mawatha, kurunagala.', 'Principal', '0777865124', NULL),
('2005006', '123', 'jayasekera@gmail.com', 'Jayasekera Bavan', 3, NULL, 5, NULL, '1999-03-18', NULL, 'himalaya Road, Main street, Kandy', NULL, '0714859632', NULL),
('2005006P', '123', 'ab654@yahoo.com', 'Anandha Bavan', 0, NULL, NULL, 'Male', '1966-06-12', '669764312V', 'himalaya Road, Main street, Kandy', 'Doctor', '0714859632', NULL),
('2005007', '123', 'hilalbmw@yahoo.com', 'Chaneka Hilaleswaren', 3, NULL, 5, 'Male', '1999-12-03', NULL, '12/c, S.L. Lane, Battikalo Road, Paandiruppu - 10', NULL, '0729865321', NULL),
('2005007P', '123', 'sumhil@gmail.com', 'sumithira Hilaleswaren', 0, NULL, NULL, 'Male', '1965-10-14', '652581436V', '12/c, S.L. Lane, Battikalo Road, Paandiruppu - 10', 'Engineer', '0729865321', NULL),
('2005008', '123', 'mujeenasd@gmail.com', 'Mujeebur Rajapaksha', 3, NULL, 5, 'Male', '2000-08-10', NULL, '351/1C, lake house Road , Colombo', NULL, '0712354879', NULL),
('2005008P', '123', 'sr@gmail.com', 'Sooriyavansa Rajapaksha', 0, NULL, NULL, 'Male', '1970-01-20', '702032106V', '351/1C, lake house Road , Colombo', 'Carpentar', '0712354879', NULL),
('2005009', '123', 'maithiri@gmail.com', 'Maithiri Balakumra', 3, NULL, 5, 'Male', '1999-03-16', NULL, '21A/4, 1St Lane, Anuradhapura', NULL, '0758865454', '\r\n'),
('2005009P', '123', 'kb@gmail.com', 'Kanahambaram Balakumra', 0, NULL, NULL, 'Male', '1971-06-06', '710253641V', '21A/4, 1St Lane, Anuradhapura', 'Driver', '0758865454', NULL),
('2005010', '123', 'kavi2121@gmail.com', 'Kavirupala sandakan', 3, NULL, 5, 'Male', '1999-08-21', NULL, '456C, 2nd Cross Street, Colombo', NULL, '0772358170', '\r\n\r\n'),
('2005010P', '123', 'rs678@gmail.com', 'Ravi sandakan', 0, NULL, NULL, 'Male', '1973-09-30', '735808126V', '456C, 2nd Cross Street, Colombo', 'Electresion', '0772358170', NULL),
('dinush', '123', 'sisindaa@gmail.com', 'Sisinda Dinusha', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('par1', '123', 'wer@g.com', 'Smpl Parent 1', 4, NULL, NULL, 'Male', NULL, '0123456', 'afaff', 'werwef', '0123456789', NULL),
('parent', '123', 'parent@StudySmart', 'Parent', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('st1', '123', 'st@studysmart', 'Student 1', 3, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('st2', '123', 'st@studysmart', 'Student 2', 3, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('st3', '123', 'jas@aa.com', 'Smpl Student 3', 3, NULL, 5, 'Male', '2016-08-31', NULL, NULL, NULL, NULL, NULL),
('teacher', '123', 'teacher@studysmart', 'Teacher', 2, '004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('user', '123', 'user@email.com', 'Sample User', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`announcement_id`);

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`name`),
  ADD KEY `fk_class_assignment` (`class`),
  ADD KEY `fk_subject_assignment` (`subject`);

--
-- Indexes for table `assignmentmarks`
--
ALTER TABLE `assignmentmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assignment_assignmentmarks` (`assignment`) USING BTREE,
  ADD KEY `fk_user_assignmentmarks` (`student`),
  ADD KEY `fk_addedby_assignmentmarks` (`addedby`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`username`,`date`),
  ADD KEY `Attendance_ibfk_1` (`markedBy`);

--
-- Indexes for table `attendanceclass`
--
ALTER TABLE `attendanceclass`
  ADD PRIMARY KEY (`class`,`date`),
  ADD KEY `markedby` (`markedby`);

--
-- Indexes for table `child_parent`
--
ALTER TABLE `child_parent`
  ADD PRIMARY KEY (`studentid`,`parentid`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classnews`
--
ALTER TABLE `classnews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_addedby` (`addedby`),
  ADD KEY `fk_class` (`class`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`file_id`);

--
-- Indexes for table `forum_thead`
--
ALTER TABLE `forum_thead`
  ADD PRIMARY KEY (`forum_id`);

--
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_addeduser_message` (`addeduser`),
  ADD KEY `fk_targetuser_message` (`targetuser`),
  ADD KEY `fk_class_message` (`class`);

--
-- Indexes for table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`user_Id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `principal`
--
ALTER TABLE `principal`
  ADD PRIMARY KEY (`user_Id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`idQuiz`),
  ADD KEY `idQuizset` (`idQuizset`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `quize`
--
ALTER TABLE `quize`
  ADD PRIMARY KEY (`quize_id`);

--
-- Indexes for table `quizset`
--
ALTER TABLE `quizset`
  ADD PRIMARY KEY (`quizsetId`);

--
-- Indexes for table `sequence`
--
ALTER TABLE `sequence`
  ADD PRIMARY KEY (`SEQ_NAME`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`user_Id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `studentsubject`
--
ALTER TABLE `studentsubject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid_index` (`userId`),
  ADD KEY `subjectid_index` (`subjectId`);

--
-- Indexes for table `student_parent`
--
ALTER TABLE `student_parent`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `uniq_parent_child` (`parentid`,`studentid`),
  ADD KEY `fk_student_parent_2` (`studentid`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`idSubject`);

--
-- Indexes for table `system_addmin`
--
ALTER TABLE `system_addmin`
  ADD PRIMARY KEY (`user_Id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `teachersubject`
--
ALTER TABLE `teachersubject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacherteaches`
--
ALTER TABLE `teacherteaches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_index` (`userId`),
  ADD KEY `subject_index` (`subjectId`),
  ADD KEY `class_index` (`class`) USING BTREE;

--
-- Indexes for table `termmarks`
--
ALTER TABLE `termmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student` (`student`),
  ADD KEY `class` (`class`),
  ADD KEY `subject` (`subject`) USING BTREE,
  ADD KEY `markedby` (`markedby`) USING BTREE;

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`),
  ADD KEY `class_index` (`class`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignmentmarks`
--
ALTER TABLE `assignmentmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `classnews`
--
ALTER TABLE `classnews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `idQuiz` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `quizset`
--
ALTER TABLE `quizset`
  MODIFY `quizsetId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `studentsubject`
--
ALTER TABLE `studentsubject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `student_parent`
--
ALTER TABLE `student_parent`
  MODIFY `_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `teachersubject`
--
ALTER TABLE `teachersubject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `teacherteaches`
--
ALTER TABLE `teacherteaches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `termmarks`
--
ALTER TABLE `termmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `fk_class_assignment` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_assignment` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `assignmentmarks`
--
ALTER TABLE `assignmentmarks`
  ADD CONSTRAINT `fk_addedby2_assignmentmarks` FOREIGN KEY (`addedby`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assignment2_assignmentmarks` FOREIGN KEY (`assignment`) REFERENCES `assignment` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_assignmentmarks` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`markedBy`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendanceclass`
--
ALTER TABLE `attendanceclass`
  ADD CONSTRAINT `fk_class_attendanceclass` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_markkedby_attendanceclass` FOREIGN KEY (`markedby`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `classnews`
--
ALTER TABLE `classnews`
  ADD CONSTRAINT `fk_addedby` FOREIGN KEY (`addedby`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_class_news` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_addeduser_message` FOREIGN KEY (`addeduser`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_class_message` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_targetuser_message` FOREIGN KEY (`targetuser`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `Quiz_ibfk_1` FOREIGN KEY (`idQuizset`) REFERENCES `quizset` (`quizsetId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Quiz_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `studentsubject`
--
ALTER TABLE `studentsubject`
  ADD CONSTRAINT `fk_subject_id` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`userId`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_parent`
--
ALTER TABLE `student_parent`
  ADD CONSTRAINT `fk_student_parent_1` FOREIGN KEY (`parentid`) REFERENCES `user` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_parent_2` FOREIGN KEY (`studentid`) REFERENCES `user` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `teacherteaches`
--
ALTER TABLE `teacherteaches`
  ADD CONSTRAINT `TeacherTeaches_ibfk_1` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `termmarks`
--
ALTER TABLE `termmarks`
  ADD CONSTRAINT `fk_class_tm` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_markedby_tm` FOREIGN KEY (`markedby`) REFERENCES `user` (`username`),
  ADD CONSTRAINT `fk_student_tm` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_tm` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
