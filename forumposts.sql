-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 28, 2016 at 05:05 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `studysmart`
--

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `forumposts`
--

INSERT INTO `forumposts` (`class`, `subject`, `cat_name`, `added_by`, `post`, `date`, `time`, `id`) VALUES
('5', '001', 'Lesson 1', 'teacher', 'Start DIsucussing', '2016-11-27', '07:13', 1),
('5', '001', 'Lesson 1', 'st1', 'My first reply!', '2016-11-27', '', 3),
('5', 'Lesson 1', 'Lesson 1', 'teacher', '', '2016-11-28', '08:44:14', 5);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
