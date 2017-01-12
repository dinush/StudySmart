-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2017 at 11:30 AM
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
  `grade` int(2) NOT NULL,
  PRIMARY KEY (`idQuiz`),
  KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`Subject`, `idQuiz`, `question`, `option1`, `option2`, `option3`, `option4`, `answers`, `username`, `grade`) VALUES
('002', 1, '1', '11', '12', '13', '14', '12', 'teacher', 10),
('002', 2, '2', '21', '22', '23', '24', '22', 'teacher', 10),
('002', 3, '3', '31', '32', '33', '34', '34', 'teacher', 10),
('002', 4, '4', '41', '42', '43', '43', '42', 'teacher', 10),
('002', 5, '5', '51', '52', '53', '54', '51', 'teacher', 10),
('002', 6, '1', '11', '12', '13', '14', '12', 'teacher', 10),
('002', 7, '2', '21', '22', '23', '24', '22', 'teacher', 10),
('002', 8, '3', '31', '32', '33', '34', '33', 'teacher', 10),
('002', 9, '4', '41', '42', '43', '44', '42', 'teacher', 10),
('002', 10, '5', '51', '52', '53', '54', '51', 'teacher', 10);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `Quiz_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
