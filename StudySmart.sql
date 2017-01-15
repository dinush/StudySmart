-- phpMyAdmin SQL Dump
-- version 4.0.10.18
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 15, 2017 at 11:36 AM
-- Server version: 5.5.52-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `StudySmart`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievement`
--

CREATE TABLE IF NOT EXISTS `achievement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `student` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_achievement_student` (`student`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE IF NOT EXISTS `announcement` (
  `announcement_id` varchar(25) NOT NULL,
  `message` varchar(25) NOT NULL,
  `date_time` varchar(6) NOT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE IF NOT EXISTS `assignment` (
  `name` varchar(250) NOT NULL,
  `class` int(11) NOT NULL,
  `subject` varchar(25) CHARACTER SET latin1 NOT NULL,
  `max` int(4) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_class_assignment` (`class`),
  KEY `fk_subject_assignment` (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`name`, `class`, `subject`, `max`, `date`) VALUES
('Atomic Models', 8, '006', 79, '2017-01-15'),
('Biochemistry', 6, '002', 100, '2017-01-15'),
('Essay Writing', 5, '003', 91, '2017-01-15'),
('Geometry 1', 5, '001', 100, '2016-10-18'),
('Grammar & Composition', 5, '003', 97, '2017-01-15'),
('Graph', 5, '001', 100, '2017-01-15'),
('Heat and Temperature', 5, '002', 87, '2017-01-15'),
('Heat, Kinetic Theory, and Thermodynamics', 7, '006', 100, '2017-01-15'),
('Mechanics', 7, '006', 98, '2017-01-15'),
('Neuroscience', 6, '002', 94, '2017-01-15'),
('Psychology', 6, '002', 98, '2017-01-15'),
('Quantum Physics', 8, '006', 93, '2017-01-15'),
('statistics', 7, '005', 95, '2017-01-13'),
('Topic3', 5, '003', 88, '2017-01-13'),
('Vectors', 5, '001', 98, '2017-01-15'),
('Vectors 2', 7, '005', 91, '2017-01-15'),
('Work, Energy, and Power', 5, '002', 90, '2017-01-15');

-- --------------------------------------------------------

--
-- Table structure for table `assignmentmarks`
--

CREATE TABLE IF NOT EXISTS `assignmentmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment` varchar(250) NOT NULL,
  `student` varchar(8) CHARACTER SET latin1 NOT NULL,
  `mark` int(4) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `addedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assignment_assignmentmarks` (`assignment`) USING BTREE,
  KEY `fk_user_assignmentmarks` (`student`),
  KEY `fk_addedby_assignmentmarks` (`addedby`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=92 ;

--
-- Dumping data for table `assignmentmarks`
--

INSERT INTO `assignmentmarks` (`id`, `assignment`, `student`, `mark`, `comment`, `addedby`) VALUES
(8, 'Geometry 1', '2006002', 75, '', 'tch2005'),
(9, 'Geometry 1', '2006003', 63, 'Try to improve', 'tch2005'),
(10, 'Geometry 1', '2006004', 78, '', 'tch2005'),
(11, 'Geometry 1', '2006005', 80, '', 'tch2005'),
(14, 'Geometry 1', '2006001', 88, '', 'tch2005'),
(15, 'statistics', '2106001', 95, 'V.G', 'tch2004'),
(16, 'statistics', '2106002', 64, 'G', 'tch2004'),
(17, 'statistics', '2106004', 34, 'W', 'tch2004'),
(18, 'statistics', '2106005', 80, 'G', 'tch2004'),
(19, 'statistics', '2106003', 76, 'G', 'tch2004'),
(20, 'Topic3', '2006002', 78, '', 'tch2002'),
(21, 'Topic3', '2006005', 88, '', 'tch2002'),
(22, 'Topic3', '2006001', 54, '', 'tch2002'),
(23, 'Essay Writing', '2006002', 91, 'V.G', 'tch2002'),
(24, 'Essay Writing', '2006005', 87, 'V.G', 'tch2002'),
(25, 'Essay Writing', '2006001', 77, 'G', 'tch2002'),
(26, 'Grammar & Composition', '2006002', 97, 'V.G', 'tch2002'),
(27, 'Grammar & Composition', '2006005', 91, 'V.G', 'tch2002'),
(28, 'Grammar & Composition', '2006001', 80, 'G', 'tch2002'),
(29, 'Biochemistry', 'st2', 34, 'W', 'tch2003 '),
(30, 'Biochemistry', '2007001', 100, 'V.G', 'tch2003 '),
(31, 'Biochemistry', '2007002', 67, 'G', 'tch2003 '),
(32, 'Biochemistry', '2007003', 78, 'G', 'tch2003 '),
(33, 'Biochemistry', '2007004', 54, 'W', 'tch2003 '),
(34, 'Biochemistry', '2007005', 34, 'W', 'tch2003 '),
(35, 'Neuroscience', 'st2', 43, 'W', 'tch2003 '),
(36, 'Neuroscience', '2007001', 94, 'V.G', 'tch2003 '),
(37, 'Neuroscience', '2007002', 67, 'G', 'tch2003 '),
(38, 'Neuroscience', '2007003', 34, 'W', 'tch2003 '),
(39, 'Neuroscience', '2007004', 75, 'G', 'tch2003 '),
(40, 'Neuroscience', '2007005', 34, 'W', 'tch2003 '),
(41, 'Psychology', 'st2', 54, 'W', 'tch2003 '),
(42, 'Psychology', '2007001', 98, 'V.G', 'tch2003 '),
(43, 'Psychology', '2007002', 78, 'G', 'tch2003 '),
(44, 'Psychology', '2007003', 89, 'V.G', 'tch2003 '),
(45, 'Psychology', '2007004', 43, 'W', 'tch2003 '),
(46, 'Psychology', '2007005', 34, 'W', 'tch2003 '),
(47, 'Mechanics', '2106001', 88, 'V.G', 'tch2003 '),
(48, 'Mechanics', '2106002', 98, 'V.G', 'tch2003 '),
(49, 'Mechanics', '2106004', 65, 'G', 'tch2003 '),
(50, 'Mechanics', '2106005', 43, 'W', 'tch2003 '),
(51, 'Mechanics', '2106003', 34, 'W', 'tch2003 '),
(52, 'Heat, Kinetic Theory, and Thermodynamics', '2106001', 100, 'V.G', 'tch2003 '),
(53, 'Heat, Kinetic Theory, and Thermodynamics', '2106002', 100, 'V.G', 'tch2003 '),
(54, 'Heat, Kinetic Theory, and Thermodynamics', '2106004', 43, 'W', 'tch2003 '),
(55, 'Heat, Kinetic Theory, and Thermodynamics', '2106005', 56, 'W', 'tch2003 '),
(56, 'Heat, Kinetic Theory, and Thermodynamics', '2106003', 43, 'W', 'tch2003 '),
(57, 'Vectors', '2006002', 45, 'W', 'tch2005'),
(58, 'Vectors', '2006003', 67, 'G', 'tch2005'),
(59, 'Vectors', '2006004', 98, 'V.G', 'tch2005'),
(60, 'Vectors', '2006005', 90, 'V.G', 'tch2005'),
(61, 'Vectors', '2006001', 69, 'G', 'tch2005'),
(62, 'Graph', '2006002', 90, 'V.G', 'tch2005'),
(63, 'Graph', '2006003', 100, 'V.G', 'tch2005'),
(64, 'Graph', '2006004', 56, 'W', 'tch2005'),
(65, 'Graph', '2006005', 43, 'W', 'tch2005'),
(66, 'Graph', '2006001', 90, 'V.G', 'tch2005'),
(67, 'Work, Energy, and Power', '2006002', 90, 'V.G', 'tch2005'),
(68, 'Work, Energy, and Power', '2006003', 56, 'W', 'tch2005'),
(69, 'Work, Energy, and Power', '2006004', 87, 'V.G', 'tch2005'),
(70, 'Work, Energy, and Power', '2006005', 70, 'G', 'tch2005'),
(71, 'Work, Energy, and Power', '2006001', 45, 'W', 'tch2005'),
(72, 'Heat and Temperature', '2006002', 87, 'V.G', 'tch2005'),
(73, 'Heat and Temperature', '2006003', 87, 'V.G', 'tch2005'),
(74, 'Heat and Temperature', '2006004', 43, 'W', 'tch2005'),
(75, 'Heat and Temperature', '2006005', 65, 'G', 'tch2005'),
(76, 'Heat and Temperature', '2006001', 80, 'V.G', 'tch2005'),
(77, 'Vectors 2', '2106001', 67, 'G', 'tch2004'),
(78, 'Vectors 2', '2106002', 76, 'G', 'tch2004'),
(79, 'Vectors 2', '2106004', 91, 'V.G', 'tch2004'),
(80, 'Vectors 2', '2106005', 34, 'W', 'tch2004'),
(81, 'Vectors 2', '2106003', 51, 'W', 'tch2004'),
(82, 'Quantum Physics', '2107001', 56, 'W', 'tch2004'),
(83, 'Quantum Physics', '2107002', 43, 'W', 'tch2004'),
(84, 'Quantum Physics', '2107003', 87, 'V.G', 'tch2004'),
(85, 'Quantum Physics', '2107004', 93, 'V.G', 'tch2004'),
(86, 'Quantum Physics', '2107005', 67, 'G', 'tch2004'),
(87, 'Atomic Models', '2107001', 54, 'G', 'tch2004'),
(88, 'Atomic Models', '2107002', 79, 'V.G', 'tch2004'),
(89, 'Atomic Models', '2107003', 74, 'V.G', 'tch2004'),
(90, 'Atomic Models', '2107004', 60, 'G', 'tch2004'),
(91, 'Atomic Models', '2107005', 43, 'W', 'tch2004');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE IF NOT EXISTS `attendance` (
  `username` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `attended` tinyint(1) DEFAULT NULL,
  `markedBy` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`username`,`date`),
  KEY `Attendance_ibfk_1` (`markedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`username`, `date`, `attended`, `markedBy`) VALUES
('2006001', '2016-09-16', 1, NULL),
('2006001', '2016-09-19', 1, NULL),
('2006001', '2016-09-20', 1, NULL),
('2006001', '2016-11-01', 0, 'tch2004'),
('2006001', '2016-11-02', 1, 'tch2005'),
('2006001', '2016-11-03', 1, 'tch2005'),
('2006001', '2016-11-04', 0, 'tch2004'),
('2006001', '2016-11-07', 1, 'tch2005'),
('2006001', '2016-11-08', 1, 'tch2005'),
('2006001', '2016-11-09', 1, 'tch2005'),
('2006001', '2016-11-10', 1, 'tch2003'),
('2006001', '2016-11-11', 0, 'tch2005'),
('2006001', '2016-11-14', 1, 'tch2005'),
('2006001', '2016-11-15', 1, 'tch2005'),
('2006001', '2016-11-16', 1, 'tch2005'),
('2006001', '2016-11-17', 1, 'tch2005'),
('2006001', '2016-11-18', 1, 'tch2002'),
('2006001', '2016-11-21', 1, 'tch2005'),
('2006001', '2016-11-22', 1, 'tch2005'),
('2006001', '2016-11-23', 1, 'tch2005'),
('2006001', '2016-11-24', 1, 'tch2005'),
('2006001', '2016-11-25', 1, 'tch2005'),
('2006001', '2016-11-28', 1, 'tch2005'),
('2006001', '2016-11-29', 1, 'tch2005'),
('2006001', '2016-11-30', 1, 'tch2005'),
('2006002', '2016-09-16', 0, NULL),
('2006002', '2016-09-19', 1, NULL),
('2006002', '2016-09-20', 0, NULL),
('2006002', '2016-11-01', 1, 'tch2004'),
('2006002', '2016-11-02', 1, 'tch2005'),
('2006002', '2016-11-03', 0, 'tch2005'),
('2006002', '2016-11-04', 1, 'tch2004'),
('2006002', '2016-11-07', 1, 'tch2005'),
('2006002', '2016-11-08', 0, 'tch2005'),
('2006002', '2016-11-09', 1, 'tch2005'),
('2006002', '2016-11-10', 1, 'tch2003'),
('2006002', '2016-11-11', 0, 'tch2005'),
('2006002', '2016-11-14', 1, 'tch2005'),
('2006002', '2016-11-15', 0, 'tch2005'),
('2006002', '2016-11-16', 1, 'tch2005'),
('2006002', '2016-11-17', 0, 'tch2005'),
('2006002', '2016-11-18', 1, 'tch2002'),
('2006002', '2016-11-21', 1, 'tch2005'),
('2006002', '2016-11-22', 1, 'tch2005'),
('2006002', '2016-11-23', 1, 'tch2005'),
('2006002', '2016-11-24', 0, 'tch2005'),
('2006002', '2016-11-25', 1, 'tch2005'),
('2006002', '2016-11-28', 0, 'tch2005'),
('2006002', '2016-11-29', 1, 'tch2005'),
('2006002', '2016-11-30', 1, 'tch2005'),
('2006003', '2016-09-16', 1, NULL),
('2006003', '2016-09-19', 1, NULL),
('2006003', '2016-09-20', 1, NULL),
('2006003', '2016-11-01', 0, 'tch2004'),
('2006003', '2016-11-02', 1, 'tch2005'),
('2006003', '2016-11-03', 1, 'tch2005'),
('2006003', '2016-11-04', 0, 'tch2004'),
('2006003', '2016-11-07', 1, 'tch2005'),
('2006003', '2016-11-08', 1, 'tch2005'),
('2006003', '2016-11-09', 1, 'tch2005'),
('2006003', '2016-11-10', 0, 'tch2003'),
('2006003', '2016-11-11', 1, 'tch2005'),
('2006003', '2016-11-14', 1, 'tch2005'),
('2006003', '2016-11-15', 1, 'tch2005'),
('2006003', '2016-11-16', 1, 'tch2005'),
('2006003', '2016-11-17', 1, 'tch2005'),
('2006003', '2016-11-18', 1, 'tch2002'),
('2006003', '2016-11-21', 1, 'tch2005'),
('2006003', '2016-11-22', 1, 'tch2005'),
('2006003', '2016-11-23', 1, 'tch2005'),
('2006003', '2016-11-24', 1, 'tch2005'),
('2006003', '2016-11-25', 1, 'tch2005'),
('2006003', '2016-11-28', 1, 'tch2005'),
('2006003', '2016-11-29', 1, 'tch2005'),
('2006003', '2016-11-30', 1, 'tch2005'),
('2006004', '2016-09-16', 1, NULL),
('2006004', '2016-09-19', 1, NULL),
('2006004', '2016-09-20', 1, NULL),
('2006004', '2016-11-01', 0, 'tch2004'),
('2006004', '2016-11-02', 1, 'tch2005'),
('2006004', '2016-11-03', 1, 'tch2005'),
('2006004', '2016-11-04', 0, 'tch2004'),
('2006004', '2016-11-07', 1, 'tch2005'),
('2006004', '2016-11-08', 1, 'tch2005'),
('2006004', '2016-11-09', 1, 'tch2005'),
('2006004', '2016-11-10', 1, 'tch2003'),
('2006004', '2016-11-11', 0, 'tch2005'),
('2006004', '2016-11-14', 1, 'tch2005'),
('2006004', '2016-11-15', 1, 'tch2005'),
('2006004', '2016-11-16', 1, 'tch2005'),
('2006004', '2016-11-17', 1, 'tch2005'),
('2006004', '2016-11-18', 1, 'tch2002'),
('2006004', '2016-11-21', 1, 'tch2005'),
('2006004', '2016-11-22', 1, 'tch2005'),
('2006004', '2016-11-23', 1, 'tch2005'),
('2006004', '2016-11-24', 1, 'tch2005'),
('2006004', '2016-11-25', 1, 'tch2005'),
('2006004', '2016-11-28', 1, 'tch2005'),
('2006004', '2016-11-29', 1, 'tch2005'),
('2006004', '2016-11-30', 1, 'tch2005'),
('2006005', '2016-09-16', 1, NULL),
('2006005', '2016-09-19', 0, NULL),
('2006005', '2016-09-20', 0, NULL),
('2006005', '2016-11-01', 1, 'tch2004'),
('2006005', '2016-11-02', 0, 'tch2005'),
('2006005', '2016-11-03', 1, 'tch2005'),
('2006005', '2016-11-04', 1, 'tch2004'),
('2006005', '2016-11-07', 0, 'tch2005'),
('2006005', '2016-11-08', 1, 'tch2005'),
('2006005', '2016-11-09', 1, 'tch2005'),
('2006005', '2016-11-10', 1, 'tch2003'),
('2006005', '2016-11-11', 0, 'tch2005'),
('2006005', '2016-11-14', 1, 'tch2005'),
('2006005', '2016-11-15', 1, 'tch2005'),
('2006005', '2016-11-16', 1, 'tch2005'),
('2006005', '2016-11-17', 1, 'tch2005'),
('2006005', '2016-11-18', 0, 'tch2002'),
('2006005', '2016-11-21', 1, 'tch2005'),
('2006005', '2016-11-22', 1, 'tch2005'),
('2006005', '2016-11-23', 1, 'tch2005'),
('2006005', '2016-11-24', 1, 'tch2005'),
('2006005', '2016-11-25', 1, 'tch2005'),
('2006005', '2016-11-28', 1, 'tch2005'),
('2006005', '2016-11-29', 1, 'tch2005'),
('2006005', '2016-11-30', 0, 'tch2005'),
('2006006', '2016-09-16', 1, NULL),
('2006006', '2016-09-19', 1, NULL),
('2006006', '2016-09-20', 1, NULL),
('2006007', '2016-09-16', 1, NULL),
('2006007', '2016-09-19', 0, NULL),
('2006007', '2016-09-20', 0, NULL),
('2006008', '2016-09-16', 0, NULL),
('2006008', '2016-09-19', 1, NULL),
('2006008', '2016-09-20', 1, NULL),
('2006009', '2016-09-16', 1, NULL),
('2006009', '2016-09-19', 1, NULL),
('2006009', '2016-09-20', 1, NULL),
('2006010', '2016-09-16', 1, NULL),
('2006010', '2016-09-19', 0, NULL),
('2006010', '2016-09-20', 0, NULL),
('st005', '2016-09-20', 1, NULL),
('st1', '2016-08-23', 0, NULL),
('st1', '2016-08-24', 1, NULL),
('st1', '2016-08-25', 1, NULL),
('st1', '2016-09-01', 0, NULL),
('st1', '2016-09-04', 0, NULL),
('st1', '2016-09-20', 1, NULL),
('st2', '2016-08-24', 1, NULL),
('st2', '2016-09-01', 1, NULL),
('st2', '2016-09-04', 0, NULL),
('st3', '2016-09-04', 0, NULL),
('st3', '2016-09-20', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `attendanceclass`
--

CREATE TABLE IF NOT EXISTS `attendanceclass` (
  `class` int(11) NOT NULL,
  `date` date NOT NULL,
  `markedby` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`class`,`date`),
  KEY `markedby` (`markedby`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `attendanceclass`
--

INSERT INTO `attendanceclass` (`class`, `date`, `markedby`) VALUES
(5, '2016-09-04', NULL),
(5, '2016-09-20', NULL),
(6, '2016-09-04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `cat_id` int(8) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL,
  `cat_description` varchar(255) NOT NULL,
  `cat_by` varchar(8) NOT NULL,
  `class` varchar(5) NOT NULL DEFAULT '',
  `subject` varchar(25) NOT NULL DEFAULT '',
  `cat_date` date DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_name_unique` (`cat_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=95 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `cat_description`, `cat_by`, `class`, `subject`, `cat_date`) VALUES
(48, 'Lesson 3', 'Trigonometry', 'teacher', '5', '001', '2016-11-10'),
(55, 'Lesson 2', 'Chemical Reactions', 'teacher', '6', '002', '2016-11-10'),
(59, 'Organic Chemistry', 'Organic Conversions', 'teacher', '6', '002', '2016-11-17'),
(87, 'lalalal', 'z/./,', 'teacher', '6', '002', '2017-01-11'),
(88, 'ccc', 'hdkjhzdfj', 'teacher', '6', '002', '2017-01-11'),
(93, 'kshf', 'sfkdj', 'teacher', '5', '001', '2017-01-11'),
(94, 'dfsd', 'sdfsdf', 'teacher', '5', '001', '2017-01-15');

-- --------------------------------------------------------

--
-- Table structure for table `child_parent`
--

CREATE TABLE IF NOT EXISTS `child_parent` (
  `studentid` varchar(255) NOT NULL,
  `parentid` varchar(255) NOT NULL,
  PRIMARY KEY (`studentid`,`parentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE IF NOT EXISTS `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` int(2) NOT NULL,
  `subclass` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

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
  KEY `fk_class` (`class`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `filename` varchar(100) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `file_id` varchar(25) NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `file_upload`
--

CREATE TABLE IF NOT EXISTS `file_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(8) NOT NULL,
  `file_name` varchar(20) DEFAULT NULL,
  `file` mediumblob,
  PRIMARY KEY (`id`),
  KEY `user_index` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `forumposts`
--

CREATE TABLE IF NOT EXISTS `forumposts` (
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
  KEY `catid` (`catid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=55 ;

--
-- Dumping data for table `forumposts`
--

INSERT INTO `forumposts` (`class`, `subject`, `cat_name`, `added_by`, `post`, `date`, `time`, `id`, `catid`) VALUES
('5', '001', 'Lesson 3', 'st1', 'Why is integration taught first in numerical methods?', '2017-01-10', '20:40:15', 48, 48),
('6', '002', 'Lesson 2', 'teacher', 'Start the discussion', '2017-01-11', '10:00:09', 52, 55),
('5', '001', 'Lesson 3', 'st1', 'Good Question', '2017-01-11', '11:23:17', 53, 48),
('5', '001', 'Lesson 3', 'teacher', 'fdsfwe', '2017-01-13', '21:01:46', 54, 48);

-- --------------------------------------------------------

--
-- Table structure for table `internalresources`
--

CREATE TABLE IF NOT EXISTS `internalresources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(8) NOT NULL,
  `subject` varchar(25) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `filecontent` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_index` (`user`),
  KEY `subject_index` (`subject`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE IF NOT EXISTS `membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `discription` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `student` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `membership_user` (`student`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `membership`
--

INSERT INTO `membership` (`id`, `date`, `discription`, `title`, `student`) VALUES
(6, '2017-01-16', 'rzyrur', '5uteut', '2006002'),
(7, '2017-01-11', 'fdhfmyh', 'tnntn', '2006002');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
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
  KEY `fk_class_message` (`class`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `seen`, `title`, `content`, `url`, `targetdate`, `targettime`, `addeduser`, `addeddate`, `addedtime`, `type`, `targetuser`, `userlevel`, `class`, `grade`) VALUES
(13, 0, NULL, 'All students are required to be present at the School Auditorium on 10.02.20.16 by 8.30 am to attend the School General Meeting.', NULL, NULL, NULL, 'dinush', '2016-09-20', '10:13:19', 5, NULL, NULL, NULL, NULL),
(14, 0, NULL, 'The Annual Prize Giving Ceremony will be held on the 25.10.2016.\r\nPrize winners should collect their invitations form the corresponding Sectional Head.', NULL, NULL, NULL, 'dinush', '2016-09-20', '10:15:18', 5, NULL, NULL, NULL, NULL),
(36, 0, NULL, 'Sports meet held on 14/10/2016 @ Sugathadasa Stadium.', NULL, NULL, NULL, 'dinush', '2016-09-20', '12:37:59', 5, NULL, NULL, NULL, NULL),
(57, 0, NULL, 'There will be a meeting at 3 pm on ERQUE lab for every grade 11 students', NULL, NULL, NULL, 'dinush', '2017-01-13', '14:40:48', 5, NULL, NULL, NULL, NULL),
(60, 1, NULL, 'gg', NULL, NULL, NULL, 'dinush', '2017-01-15', '00:12:55', 1, 'dinush', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `user_Id` varchar(25) NOT NULL,
  `post_id` varchar(25) NOT NULL,
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `principal`
--

CREATE TABLE IF NOT EXISTS `principal` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`user_Id`)
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
  `answer` varchar(25) NOT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `Subject` varchar(25) NOT NULL,
  `idQuiz` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(500) NOT NULL,
  `option1` varchar(200) NOT NULL,
  `option2` varchar(200) NOT NULL,
  `option3` varchar(200) DEFAULT NULL,
  `option4` varchar(200) DEFAULT NULL,
  `answers` varchar(45) NOT NULL,
  `username` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`idQuiz`),
  KEY `username` (`username`),
  KEY `subject_index` (`Subject`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`Subject`, `idQuiz`, `question`, `option1`, `option2`, `option3`, `option4`, `answers`, `username`) VALUES
('002', 1, '1', '11', '12', '13', '14', '12', NULL),
('002', 2, '2', '21', '22', '23', '24', '22', NULL),
('002', 3, '3', '31', '32', '33', '34', '34', NULL),
('002', 4, '4', '41', '42', '43', '43', '42', NULL),
('002', 5, '5', '51', '52', '53', '54', '51', NULL),
('002', 6, '1', '11', '12', '13', '14', '12', NULL),
('002', 7, '2', '21', '22', '23', '24', '22', NULL),
('002', 8, '3', '31', '32', '33', '34', '33', NULL),
('002', 9, '4', '41', '42', '43', '44', '42', NULL),
('002', 10, '5', '51', '52', '53', '54', '51', NULL),
('001', 11, 'quizzzzzz', 'opt1', 'opt2', 'opt3', 'opt4', '2', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quize`
--

CREATE TABLE IF NOT EXISTS `quize` (
  `subject_id` varchar(25) NOT NULL,
  `quize_id` varchar(25) NOT NULL,
  `title` varchar(25) NOT NULL,
  `question_id` varchar(25) NOT NULL,
  PRIMARY KEY (`quize_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quizset`
--

CREATE TABLE IF NOT EXISTS `quizset` (
  `quizsetId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `subject` varchar(25) DEFAULT NULL,
  `quizes` varchar(100) NOT NULL,
  `username` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`quizsetId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sequence`
--

CREATE TABLE IF NOT EXISTS `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sequence`
--

INSERT INTO `sequence` (`SEQ_NAME`, `SEQ_COUNT`) VALUES
('SEQ_GEN', 0);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `user_Id` varchar(25) NOT NULL,
  `student_id` varchar(25) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `studentsubject`
--

CREATE TABLE IF NOT EXISTS `studentsubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid_index` (`userId`),
  KEY `subjectid_index` (`subjectId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `studentsubject`
--

INSERT INTO `studentsubject` (`id`, `userId`, `subjectId`) VALUES
(1, 'st1', '001'),
(2, 'st1', '002'),
(4, 'st2', '002'),
(5, 'st2', '004'),
(6, 'st3', '001'),
(7, 'st3', '002'),
(8, 'st3', '004'),
(17, '2005001', '002'),
(18, '2005002', '002'),
(19, '2005001', '001'),
(20, '2005002', '001'),
(21, '2006006', '003'),
(22, '2006004', '003'),
(23, '2006001', '003'),
(24, '2006002', '003'),
(25, '2006003', '003'),
(26, '2006005', '003'),
(27, 'st005', '001'),
(28, 'st005', '002'),
(29, 'st005', '003'),
(30, 'st005', '004'),
(31, 'st10', '001'),
(32, 'st10', '002'),
(33, 'st10', '003'),
(34, 'st10', '004');

-- --------------------------------------------------------

--
-- Table structure for table `student_parent`
--

CREATE TABLE IF NOT EXISTS `student_parent` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  `studentid` varchar(8) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `uniq_parent_child` (`parentid`,`studentid`),
  KEY `fk_student_parent_2` (`studentid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `student_parent`
--

INSERT INTO `student_parent` (`_id`, `parentid`, `studentid`) VALUES
(4, 'kdfh', 'st3'),
(2, 'par1', 'st2'),
(3, 'par1', 'st3'),
(5, 'par10', 'st10'),
(1, 'parent', 'st1');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE IF NOT EXISTS `subject` (
  `idSubject` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `grade` int(2) NOT NULL DEFAULT '10',
  PRIMARY KEY (`idSubject`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`idSubject`, `name`, `grade`) VALUES
('001', 'Maths', 10),
('002', 'Science', 10),
('003', 'English', 10),
('004', 'IT', 10),
('005', 'Maths', 11),
('006', 'Physics', 11),
('007', 'History', 10),
('008', 'Geography', 10);

-- --------------------------------------------------------

--
-- Table structure for table `system_addmin`
--

CREATE TABLE IF NOT EXISTS `system_addmin` (
  `user_Id` varchar(25) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
  `user_id` varchar(25) NOT NULL,
  `subject_id` varchar(25) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teachersubject`
--

CREATE TABLE IF NOT EXISTS `teachersubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectId` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `teacherteaches`
--

CREATE TABLE IF NOT EXISTS `teacherteaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(8) CHARACTER SET latin1 NOT NULL,
  `subjectId` varchar(25) CHARACTER SET latin1 NOT NULL,
  `class` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_index` (`userId`),
  KEY `subject_index` (`subjectId`),
  KEY `class_index` (`class`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

-- --------------------------------------------------------

--
-- Table structure for table `termmarks`
--

CREATE TABLE IF NOT EXISTS `termmarks` (
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
  KEY `markedby` (`markedby`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=119 ;

--
-- Dumping data for table `termmarks`
--

INSERT INTO `termmarks` (`id`, `student`, `subject`, `class`, `term`, `value`, `markedby`) VALUES
(5, '2006003', '001', 5, 1, 66, 'tch2005'),
(12, 'st2', '002', 6, 1, 55, 'tch2003 '),
(13, '2006004', '001', 5, 1, 88, 'tch2005'),
(14, '2006005', '001', 5, 1, 78, 'tch2005'),
(17, '2006001', '001', 5, 1, 77, 'tch2005'),
(20, '2006001', '001', 5, 2, 77, 'tch2005'),
(21, '2006002', '001', 5, 2, 58, 'tch2005'),
(22, '2006003', '001', 5, 2, 58, 'tch2005'),
(23, '2006004', '001', 5, 2, 89, 'tch2005'),
(24, '2006005', '001', 5, 2, 78, 'tch2005'),
(25, '2006002', '001', 5, 1, 87, 'tch2005'),
(28, '2006001', '002', 5, 1, 77, 'tch002'),
(29, '2006002', '002', 5, 1, 88, 'tch002'),
(30, '2006003', '002', 5, 1, 94, 'tch002'),
(31, '2006004', '002', 5, 1, 78, 'tch002'),
(32, '2006005', '002', 5, 1, 85, 'tch002'),
(33, '2007001', '002', 6, 1, 65, 'tch2003 '),
(34, '2007002', '002', 6, 1, 70, 'tch2003 '),
(35, '2007003', '002', 6, 1, 96, 'tch2003 '),
(36, '2007004', '002', 6, 1, 34, 'tch2003 '),
(37, '2007005', '002', 6, 1, 91, 'tch2003 '),
(38, '2106001', '006', 7, 1, 91, 'tch2003 '),
(39, '2106002', '006', 7, 1, 45, 'tch2003 '),
(40, '2106003', '006', 7, 1, 42, 'tch2003 '),
(41, '2106004', '006', 7, 1, 65, 'tch2003 '),
(42, '2106005', '006', 7, 1, 81, 'tch2003 '),
(43, '2106001', '005', 7, 1, 67, 'tch2004'),
(44, '2106002', '005', 7, 1, 89, 'tch2004'),
(45, '2106003', '005', 7, 1, 34, 'tch2004'),
(46, '2106004', '005', 7, 1, 56, 'tch2004'),
(47, '2106005', '005', 7, 1, 70, 'tch2004'),
(48, '2107001', '006', 8, 1, 43, 'tch2004'),
(49, '2107002', '006', 8, 1, 78, 'tch2004'),
(50, '2107003', '006', 8, 1, 67, 'tch2004'),
(51, '2107004', '006', 8, 1, 34, 'tch2004'),
(52, '2107005', '006', 8, 1, 60, 'tch2004'),
(53, '2106001', '005', 7, 2, 60, 'tch2004'),
(54, '2106002', '005', 7, 2, 90, 'tch2004'),
(55, '2106003', '005', 7, 2, 54, 'tch2004'),
(56, '2106004', '005', 7, 2, 54, 'tch2004'),
(57, '2106005', '005', 7, 2, 81, 'tch2004'),
(58, '2006001', '001', 5, 3, 80, 'tch2005'),
(59, '2006002', '001', 5, 3, 65, 'tch2005'),
(60, '2006003', '001', 5, 3, 47, 'tch2005'),
(61, '2006004', '001', 5, 3, 89, 'tch2005'),
(62, '2006005', '001', 5, 3, 78, 'tch2005'),
(63, '2006001', '002', 5, 2, 80, 'tch2005'),
(64, '2006002', '002', 5, 2, 65, 'tch2005'),
(65, '2006003', '002', 5, 2, 87, 'tch2005'),
(66, '2006004', '002', 5, 2, 76, 'tch2005'),
(67, '2006005', '002', 5, 2, 59, 'tch2005'),
(68, '2006001', '002', 5, 3, 76, 'tch2005'),
(69, '2006002', '002', 5, 3, 65, 'tch2005'),
(70, '2006003', '002', 5, 3, 98, 'tch2005'),
(71, '2006004', '002', 5, 3, 34, 'tch2005'),
(72, '2006005', '002', 5, 3, 67, 'tch2005'),
(73, '2007001', '002', 6, 2, 56, 'tch2005'),
(74, '2007002', '002', 6, 2, 67, 'tch2005'),
(75, '2007003', '002', 6, 2, 89, 'tch2005'),
(76, '2007004', '002', 6, 2, 34, 'tch2005'),
(77, '2007005', '002', 6, 2, 87, 'tch2005'),
(78, 'st2', '002', 6, 2, 54, 'tch2005'),
(79, '2007001', '002', 6, 3, 67, 'tch2005'),
(80, '2007002', '002', 6, 3, 76, 'tch2005'),
(81, '2007003', '002', 6, 3, 45, 'tch2005'),
(82, '2007004', '002', 6, 3, 89, 'tch2005'),
(83, '2007005', '002', 6, 3, 90, 'tch2005'),
(84, 'st2', '002', 6, 3, 48, 'tch2005'),
(85, '2006001', '003', 5, 1, 76, 'tch2002'),
(86, '2006002', '003', 5, 1, 89, 'tch2002'),
(87, '2006005', '003', 5, 1, 90, 'tch2002'),
(88, '2006001', '003', 5, 2, 98, 'tch2002'),
(89, '2006002', '003', 5, 2, 78, 'tch2002'),
(90, '2006005', '003', 5, 2, 87, 'tch2002'),
(91, '2006001', '003', 5, 3, 87, 'tch2002'),
(92, '2006002', '003', 5, 3, 76, 'tch2002'),
(93, '2006005', '003', 5, 3, 90, 'tch2002'),
(94, '2106001', '006', 7, 2, 80, 'tch2003 '),
(95, '2106002', '006', 7, 2, 45, 'tch2003 '),
(96, '2106003', '006', 7, 2, 34, 'tch2003 '),
(97, '2106004', '006', 7, 2, 64, 'tch2003 '),
(98, '2106005', '006', 7, 2, 76, 'tch2003 '),
(99, '2106001', '006', 7, 3, 85, 'tch2003 '),
(100, '2106002', '006', 7, 3, 55, 'tch2003 '),
(101, '2106003', '006', 7, 3, 43, 'tch2003 '),
(102, '2106004', '006', 7, 3, 65, 'tch2003 '),
(103, '2106005', '006', 7, 3, 90, 'tch2003 '),
(104, '2106001', '005', 7, 3, 67, 'tch2004'),
(105, '2106002', '005', 7, 3, 98, 'tch2004'),
(106, '2106003', '005', 7, 3, 45, 'tch2004'),
(107, '2106004', '005', 7, 3, 34, 'tch2004'),
(108, '2106005', '005', 7, 3, 78, 'tch2004'),
(109, '2107001', '006', 8, 2, 43, 'tch2004'),
(110, '2107002', '006', 8, 2, 87, 'tch2004'),
(111, '2107003', '006', 8, 2, 90, 'tch2004'),
(112, '2107004', '006', 8, 2, 54, 'tch2004'),
(113, '2107005', '006', 8, 2, 87, 'tch2004'),
(114, '2107001', '006', 8, 3, 34, 'tch2004'),
(115, '2107002', '006', 8, 3, 80, 'tch2004'),
(116, '2107003', '006', 8, 3, 82, 'tch2004'),
(117, '2107004', '006', 8, 3, 45, 'tch2004'),
(118, '2107005', '006', 8, 3, 83, 'tch2004');

-- --------------------------------------------------------

--
-- Table structure for table `test1`
--

CREATE TABLE IF NOT EXISTS `test1` (
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE IF NOT EXISTS `topics` (
  `topic_id` int(8) NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(50) NOT NULL,
  `topic_date` datetime NOT NULL,
  `topic_cat` int(8) NOT NULL,
  `topic_by` varchar(8) NOT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `topic_cat` (`topic_cat`),
  KEY `topic_by` (`topic_by`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `upload`
--

CREATE TABLE IF NOT EXISTS `upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(8) NOT NULL,
  `subject` varchar(25) DEFAULT NULL,
  `filename` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_index` (`user`),
  KEY `subject_index` (`subject`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `upload`
--

INSERT INTO `upload` (`id`, `user`, `subject`, `filename`) VALUES
(1, 'st1', '005', 'aaaaaaa');

-- --------------------------------------------------------

--
-- Table structure for table `url`
--

CREATE TABLE IF NOT EXISTS `url` (
  `idURL` int(11) NOT NULL AUTO_INCREMENT,
  `grade` int(11) DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idURL`),
  KEY `url_subject` (`subject`),
  KEY `url_user` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

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
  `class` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `nic` varchar(11) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `occupation` varchar(500) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `qualifications` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `class_index` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `email`, `name`, `level`, `class`, `gender`, `birthdate`, `nic`, `address`, `occupation`, `phone`, `qualifications`) VALUES
('2005001', '123', 'S.Mafras@gmail.com', 'Shamil Perera', 3, NULL, 'Male', '1999-05-04', NULL, '78, Dematagoda Road, Colombo 10', NULL, '0754500026', NULL),
('2005001P', '123', 'Kami@gmail.com', 'Kamila Perera', 0, NULL, 'Male', '1965-10-12', '659865321V', '78, Dematagoda Road, Colombo 10', 'Driver', '0754500026', NULL),
('2005002', '123', 'nimalthusantha@gmail.com ', 'Nimal Thusantha', 3, 6, 'Male', '2000-07-23', NULL, '425/c, Kayser Street, Colombo', NULL, '0771845523', NULL),
('2005002P', '123', 'Jan@gmail.com', 'Janith Thusantha', 0, NULL, 'Male', '1966-03-01', '662154873V', '425/c, Kayser Street, Colombo', 'Accontan', '0771845523', '\r\n\r\n'),
('2005003', '123', 'rp456@gmail.com', 'Ruwan Pathirena', 3, 6, 'Male', '1999-11-02', NULL, '184/5, Polgolla Road, Hinguloya', NULL, '0716321963', NULL),
('2005003P', '123', 'Mahpat@gmail.com', 'Mahindha Pathirena', 0, NULL, 'Male', '1967-05-09', '679864318V', '184/5, Polgolla Road, Hinguloya', 'Mannager', '0716321963', NULL),
('2005004', '123', 'Rudanemlp01@gmail.com', 'Rudane Thennakone', 3, 6, 'Male', '1999-05-29', NULL, '23, visaka mawatha, Pannipitiya', 'Security', '0772563417', '\r\n'),
('2005004P', '123', 'Kasun@gmail.com', 'Kasun Thennakone', 0, NULL, 'Male', '1968-11-16', '68028064V', '23, visaka mawatha, Pannipitiya', 'Teacher', '0772563417', NULL),
('2005005', '123', 'suraj@gmail.com', 'Mahendhira Suraj', 3, 6, 'Male', '1999-02-28', NULL, '12/A, jayasekera mawatha, kurunagala.', NULL, '0777865124', '\r\n\r\n\r\n'),
('2005005P', '123', 'Chadi12@gmail.com', 'Chandi Suraj', 0, NULL, 'Male', '1969-12-25', '697894561V', '12/A, jayasekera mawatha, kurunagala.', 'Principal', '0777865124', NULL),
('2005006', '123', 'jayasekera@gmail.com', 'Jayasekera Bavan', 3, 6, NULL, '1999-03-18', NULL, 'himalaya Road, Main street, Kandy', NULL, '0714859632', NULL),
('2005006P', '123', 'ab654@yahoo.com', 'Anandha Bavan', 0, NULL, 'Male', '1966-06-12', '669764312V', 'himalaya Road, Main street, Kandy', 'Doctor', '0714859632', NULL),
('2005007', '123', 'hilalbmw@yahoo.com', 'Chaneka Hilaleswaren', 3, 6, 'Male', '1999-12-03', NULL, '12/c, S.L. Lane, Battikalo Road, Paandiruppu - 10', NULL, '0729865321', NULL),
('2005007P', '123', 'sumhil@gmail.com', 'sumithira Hilaleswaren', 0, NULL, 'Male', '1965-10-14', '652581436V', '12/c, S.L. Lane, Battikalo Road, Paandiruppu - 10', 'Engineer', '0729865321', NULL),
('2005008', '123', 'mujeenasd@gmail.com', 'Mujeebur Rajapaksha', 3, 6, 'Male', '2000-08-10', NULL, '351/1C, lake house Road , Colombo', NULL, '0712354879', NULL),
('2005008P', '123', 'sr@gmail.com', 'Sooriyavansa Rajapaksha', 0, NULL, 'Male', '1970-01-20', '702032106V', '351/1C, lake house Road , Colombo', 'Carpentar', '0712354879', NULL),
('2005009', '123', 'maithiri@gmail.com', 'Maithiri Balakumra', 3, 6, 'Male', '1999-03-16', NULL, '21A/4, 1St Lane, Anuradhapura', NULL, '0758865454', '\r\n'),
('2005009P', '123', 'kb@gmail.com', 'Kanahambaram Balakumra', 0, NULL, 'Male', '1971-06-06', '710253641V', '21A/4, 1St Lane, Anuradhapura', 'Driver', '0758865454', NULL),
('2005010', '123', 'kavi2121@gmail.com', 'Kavirupala sandakan', 3, 6, 'Male', '1999-08-21', NULL, '456C, 2nd Cross Street, Colombo', NULL, '0772358170', '\r\n\r\n'),
('2005010P', '123', 'rs678@gmail.com', 'Ravi sandakan', 0, NULL, 'Male', '1973-09-30', '735808126V', '456C, 2nd Cross Street, Colombo', 'Electresion', '0772358170', NULL),
('2006001', '123', 'dudith2000@gmail.com', 'Udith Dilshan', 3, 5, 'Male', '2000-08-28', NULL, NULL, NULL, NULL, NULL),
('2006002', '123', 'tnuwan@gmail.com', 'Thikshana Nuwan', 3, 5, 'Male', '2000-05-03', NULL, NULL, NULL, NULL, NULL),
('2006003', '123', 'udhima@gmail.com', 'Udani Himansa', 3, 5, 'Female', '2000-11-23', NULL, NULL, NULL, NULL, NULL),
('2006004', '123', 'kamali@gmail.com', 'Amali Kalpana', 3, 5, 'Female', '2000-09-11', NULL, NULL, NULL, NULL, NULL),
('2006005', '123', 'nethup@gmail.com', 'Nethu Perera', 3, 5, 'Female', '2000-07-01', NULL, NULL, NULL, NULL, NULL),
('2006006', '123', 'vishwako@gmail.com', 'vishwa Kodikara', 3, 5, 'Male', '2000-05-30', NULL, NULL, NULL, NULL, NULL),
('2006007', '123', 'kalanas@gmail.com', 'Kalana Sandeepa', 3, 5, 'Male', '2016-09-19', NULL, NULL, NULL, NULL, NULL),
('2006008', '123', 'nipunin@gmail.com', 'Nipuni Nayanathara', 3, 5, 'Female', '2000-10-20', NULL, NULL, NULL, NULL, NULL),
('2006009', '123', 'gmahima@gmail.com', 'Mahima Gamage', 3, 5, 'Male', '2000-07-15', NULL, NULL, NULL, NULL, NULL),
('2006010', '123', 'tharakam@gmail.com', 'Tharaka Mendis', 3, 5, 'Male', '2000-05-30', NULL, NULL, NULL, NULL, NULL),
('2007001', '123', 'eranga@gmail.com', 'Eranga Akash', 3, 6, 'Male', '2000-04-16', NULL, NULL, NULL, NULL, NULL),
('2007002', '123', 'ridmi@gmail.com', 'Ridmi maleesha', 3, 6, 'Female', '2000-03-30', NULL, NULL, NULL, NULL, NULL),
('2007003', '123', 'isuka123@gmail.com', 'Isuka Randima', 3, 6, 'Male', '2001-01-24', NULL, NULL, NULL, NULL, NULL),
('2007004', '123', 'nisalch@gmail.com', 'Nisal Chamuditha', 3, 6, 'Male', '2000-03-04', NULL, NULL, NULL, NULL, NULL),
('2007005', '123', 'sanuliuth@gmail.com', 'Sanuli Uththara', 3, 6, 'Female', '2000-05-30', NULL, NULL, NULL, NULL, NULL),
('2106001', '123', 'visurako@gmail.com', 'visura Koliya', 3, 7, 'Male', '1999-05-28', NULL, NULL, NULL, NULL, NULL),
('2106002', '123', 'kalpanas@gmail.com', 'Kalpana Sandeepa', 3, 7, 'Male', '1999-12-17', NULL, NULL, NULL, NULL, NULL),
('2106003', '123', 'nilupulin@gmail.com', 'Nilupuli Nuwanthi', 3, 7, 'Male', '1999-10-20', NULL, NULL, NULL, NULL, NULL),
('2106004', '123', 'mahelag@gmail.com', 'Mahela Gambira', 3, 7, 'Male', '1999-07-13', NULL, NULL, NULL, NULL, NULL),
('2106005', '123', 'tharikam@gmail.com', 'Tharika Mathisha', 3, 7, 'Female', '1999-05-29', NULL, NULL, NULL, NULL, NULL),
('2107001', '123', 'viranga@gmail.com', 'Viranga Sankalpa', 3, 8, 'Male', '1999-04-24', NULL, NULL, NULL, NULL, NULL),
('2107002', '123', 'rameesha@gmail.com', 'Rameesha saduni', 3, 8, 'Female', '1999-03-16', NULL, NULL, NULL, NULL, NULL),
('2107003', '123', 'isuru123@gmail.com', 'Isuru Upeksha', 3, 8, 'Male', '1999-05-04', NULL, NULL, NULL, NULL, NULL),
('2107004', '123', 'nisalach@gmail.com', 'Nisala Chamodha', 3, 8, 'Male', '1999-03-09', NULL, NULL, NULL, NULL, NULL),
('2107005', '123', 'samaliama@gmail.com', 'Samali Amaya', 3, 8, 'Female', '1999-07-30', NULL, NULL, NULL, NULL, NULL),
('389955p', '123', 'sdf@gma.com', 'c baddage', 4, NULL, 'Male', NULL, '123456789v', 'maha para', 'MSc', '012345697', NULL),
('admin', '123', NULL, 'Administrator', 0, NULL, 'Male', NULL, '890000000V', 'Nugegoda', NULL, '0222222222', NULL),
('dinush', '123', 'sisindaa@gmail.com', 'Sisinda Dinusha', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('kdfh', '123', 'sdfwf@gm.co', 'sdfhj', 4, NULL, 'Male', NULL, 'dfdfwe', 'dsgsdg', 'fgdfg', '234234', NULL),
('p2006001', '123', 'saraths@gmail.com', 'Sarath Silva', 4, NULL, 'Male', NULL, '651234565V', '26/3 Temple Road,wijeerama', 'Electrical engineer', '0714538712', NULL),
('p2006002', '123', 'nimal@gmail.com', 'Nimal Jayasooriya', 4, NULL, 'Male', NULL, '672341234V', '59/3, Kalubovila South', 'Medical doctor ', '0774566543', NULL),
('p2006003', '123', 'kusuma@gmail.com', 'Kusuma Kariyawasam', 4, NULL, 'Male', NULL, '765432465V', '"Siriniwasa",Pamankada South', 'Pharmacist ', '0775647812', NULL),
('p2006004', '123', 'amila@gmail.com', 'Amila Wimalasiri', 4, NULL, 'Male', NULL, '741654343V', '76/6 wimalasooriya Road', 'Civil engineer', '0786545612', NULL),
('p2006005', '123', 'kamal@gmail.com', 'Kamal Perera', 4, NULL, 'Male', NULL, '652486542V', '123/4 Horana Road,piliyandala', 'Stock clerk', '0714345615', NULL),
('p2006006', '123', 'suni@gmail.com', 'Sunil Kodikara', 4, NULL, 'Male', NULL, '780454312V', 'Gamini Mawatha,Kirulapana', 'Civil engineer', '780454312V', NULL),
('p2006007', '123', 'lelaa@gmail.com', 'Lelaa Gamage', 4, NULL, 'Female', NULL, '666547618V', '321/9,Sujatha Road,Kirulapana', 'clerk', '0712345673', NULL),
('p2006008', '123', 'nalin@gmail.com', 'Nalin Bandara', 4, NULL, 'Male', NULL, '712307654V', 'Jayawardhana Lane,Colombo 5', 'Jayawardhana Lane,Colombo 5,Lawyer', '0776543761', NULL),
('p2006009', '123', 'sumith@gmail.com', 'Sumith Gamage', 4, NULL, 'Male', NULL, '811143123V', 'School Lane,Pannipitiya', 'Medical doctor', '078654783', NULL),
('p2006010', '123', 'rangana@gmail.com', 'Rangana Mendis', 4, NULL, 'Male', NULL, '802347641V', '673/2,Colombo 10', 'Electrical engineer', '0774561211', NULL),
('p2007001', '123', 'nimalkaru@gmail.com', 'Nimal Karunarathna', 4, NULL, 'Male', NULL, '640013445V', '"Siriwardhana mawatha"kalubowila', 'clerk', '0713456123', NULL),
('p2007002', '123', 'nayanakulaa@gmail.com', 'Nayana Kulathunga', 4, NULL, 'Female', NULL, '585432314V', '23b/321",kirulapana', 'Pharmacist', '0774354123', NULL),
('p2007003', '123', 'sunilsena@gmail.com', 'Sunil Senanayaka', 4, NULL, 'Male', NULL, '682334564V', '"352a/12",mawatta mawatha,kohuwala', 'Medical doctor', '0773243128', NULL),
('p2007004', '123', 'neellboth@gmail.com', 'Neel Botheju', 4, NULL, 'Male', NULL, '571394567V', '200a/21,perera mawatha,wijerama', 'Civil engineer', '0714353215', NULL),
('p2007005', '123', 'kanchanap@gmail.com', 'Kanchana Piris', 4, NULL, 'Female', NULL, '606540043V', '321b/456,gangodawila,nugegoda', 'Lawyer', '0716540123', NULL),
('p2106001', '123', 'sanath@gmail.com', 'Sanath Kodikara', 4, NULL, 'Male', NULL, '782454312V', 'Sujatha Mawatha,Kirulapana', 'Civil engineer', '0779567817', NULL),
('p2106002', '123', 'lamali@gmail.com', 'Lamali Gamage', 4, NULL, 'Female', NULL, '666687613V', '321/9,Perera Road,Kirulapana', 'clerk', '0712456873', NULL),
('p2106003', '123', 'nalinda@gmail.com', 'Nalinda Basnayaka', 4, NULL, 'Male', NULL, '711597654V', 'Jayathunga Lane,Colombo 5', 'Lawyer', '0776565421', NULL),
('p2106004', '123', 'sarath@gmail.com', 'Sarath Gamage', 4, NULL, 'Male', NULL, '683454125V', 'Temple Lane,Pannipitiya', 'Medical doctor', '0783257834', NULL),
('p2106005', '123', 'ramya@gmail.com', 'Ramya Mendis', 4, NULL, 'Female', NULL, '806547641V', '43B/2,Colombo 05', 'Electrical engineer', '0774579811', NULL),
('p2107001', '123', 'lalithkaru@gmail.com', 'Lalith Karunadeera', 4, NULL, 'Male', NULL, '661563445V', '342B/32,kalubowila', 'clerk', '0713456123', NULL),
('p2107002', '123', 'nayomikulaa@gmail.com', 'Nayomi Kulathunga', 4, NULL, 'Female', NULL, '586542314V', '"23b/321",pamankada', 'Electrical engineer', '0712345654', NULL),
('p2107003', '123', 'kumaraena@gmail.com', 'Kumara Dharmadasa', 4, NULL, 'Male', NULL, '652454564V', '"377a/12",malwatta mawatha,kohuwala', 'Medical doctor', '0773243128', NULL),
('p2107004', '123', 'namalbb@gmail.com', 'Namal Balasuriya', 4, NULL, 'Male', NULL, '572134567V', '200b/21,vijaya mawatha,wijerama', 'Civil engineer', '0714353215', NULL),
('p2107005', '123', 'kamalsiri@gmail.com', 'Kamala Siriwardhana', 4, NULL, 'Female', NULL, '606120043V', 'gangodawila,delkanda', 'Civil engineer', '0716540123', NULL),
('par1', '123', 'wer@g.com', 'Smpl Parent 1', 4, NULL, 'Male', NULL, '0123456', 'afaff', 'werwef', '0123456789', NULL),
('par10', '123', 'par10@email.com', 'Parent 10', 4, NULL, 'Female', NULL, '900000000v', 'Havelock', 'manager', '000-0000000', NULL),
('parent', '123', 'parent@StudySmart', 'Parent', 4, NULL, 'Female', '2016-08-09', '946150363V', NULL, 'Banking Manageress', NULL, NULL),
('principl', '123', 'principl@email.com', 'Principal', 1, NULL, 'Male', NULL, '900000000v', 'Havelock', NULL, '0111111111', 'msc'),
('st005', '123', 'sti@gmail.com', 'Student 5', 3, 5, 'Male', '2000-06-20', NULL, NULL, NULL, NULL, NULL),
('st1', '123', 'st@studysmart', 'Student 1', 3, 5, 'male', '2000-02-08', NULL, '123, xyz, abc', NULL, NULL, NULL),
('st10', '123', '', 'Sample student 10', 3, 6, 'Male', '2004-07-14', NULL, NULL, NULL, NULL, NULL),
('st2', '123', 'st@studysmart', 'Student 2', 3, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('st3', '123', 'jas@aa.com', 'Smpl Student 3', 3, 5, 'Male', '2016-08-31', NULL, NULL, NULL, NULL, NULL),
('tch002', '123', 'nanda@gmail.com', 'A.B.C.Prasad', 2, NULL, '1', NULL, '0000000v', '123, xyz, abc', NULL, '0761234567', 'bsc'),
('tch2002', '123', 'samanrath@gmail.com', 'Saman Rathnayaka', 2, NULL, '1', NULL, '795434521V ', '234B/23 karapitiya,galle', NULL, '0712345678', ' Bachelor of Arts'),
('tch2003 ', '123', 'kumaribala@gmail.com', 'Kumari Balasooriya ', 2, NULL, '2', NULL, '745693321V ', '23B/33 Wawarawma,Kurunagala', NULL, '0714567332', ' Bachelor of Science'),
('tch2004', '123', 'chandanikuma@gmail.com', 'Chandani Kumarathunga', 2, NULL, '2', NULL, '804567456V', '342B/785 hakmana, mathara', NULL, '0714328732', ' Bachelor of Applied Science'),
('tch2005', '123', 'teacher@studysmart', 'Dayasiri Rajapaksha ', 2, NULL, 'Male', '1987-01-02', '672434523V', NULL, NULL, NULL, 'Bsc'),
('user', '123', 'user@email.com', 'Sample User', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `achievement`
--
ALTER TABLE `achievement`
  ADD CONSTRAINT `FK_achievement_student` FOREIGN KEY (`student`) REFERENCES `user` (`username`);

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
-- Constraints for table `file_upload`
--
ALTER TABLE `file_upload`
  ADD CONSTRAINT `file_upload_user` FOREIGN KEY (`uid`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forumposts`
--
ALTER TABLE `forumposts`
  ADD CONSTRAINT `forumposts_ibfk_1` FOREIGN KEY (`catid`) REFERENCES `categories` (`cat_id`) ON DELETE CASCADE;

--
-- Constraints for table `internalresources`
--
ALTER TABLE `internalresources`
  ADD CONSTRAINT `resource_subject` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resource_user` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `membership`
--
ALTER TABLE `membership`
  ADD CONSTRAINT `membership_user` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_membership_student` FOREIGN KEY (`student`) REFERENCES `user` (`username`);

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
  ADD CONSTRAINT `Quiz_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `quiz_subject` FOREIGN KEY (`Subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `fk_subject` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TeacherTeaches_ibfk_1` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `termmarks`
--
ALTER TABLE `termmarks`
  ADD CONSTRAINT `fk_markedby_tm` FOREIGN KEY (`markedby`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_class_tm` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_tm` FOREIGN KEY (`student`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_tm` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`topic_cat`) REFERENCES `categories` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `topics_ibfk_2` FOREIGN KEY (`topic_by`) REFERENCES `user` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `upload`
--
ALTER TABLE `upload`
  ADD CONSTRAINT `subject_upload` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_upload` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `url`
--
ALTER TABLE `url`
  ADD CONSTRAINT `FK_url_subject` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`),
  ADD CONSTRAINT `FK_url_username` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  ADD CONSTRAINT `url_subject` FOREIGN KEY (`subject`) REFERENCES `subject` (`idSubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `url_user` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`class`) REFERENCES `class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
