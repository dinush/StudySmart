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
  PRIMARY KEY (`cat_id`,`cat_name`,`class`,`subject`),
  UNIQUE KEY `cat_name_unique` (`cat_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `cat_description`, `cat_by`, `class`, `subject`, `cat_date`) VALUES
(41, 'Lesson 1', 'Series and Limits', 'teacher', '5', '001', '2016-11-10'),
(48, 'Lesson 3', 'Trigonometry', 'teacher', '5', '001', '2016-11-10'),
(55, 'Lesson 2', 'Chemical Reactions', 'teacher', '6', '002', '2016-11-10'),
(58, 'mnmn', 'mmmmmmm', 'teacher', '6', '002', '2016-11-12'),
(59, 'Organic Chemistry', 'Organic Conversions', 'teacher', '6', '002', '2016-11-17'),
(60, 'testing', 'Let it be right!', 'teacher', '5', '001', '2016-11-26');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
