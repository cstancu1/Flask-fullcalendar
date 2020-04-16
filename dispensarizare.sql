-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Gazdă: 127.0.0.1:3306
-- Timp de generare: iul. 30, 2019 la 06:40 AM
-- Versiune server: 5.7.24
-- Versiune PHP: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Bază de date: `dispensarizare`
--

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `med_id` int(10) NOT NULL,
  `date` varchar(100) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(100) NOT NULL,
  `investigation` varchar(100) NOT NULL,
  `added_by` int(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `obs` text NOT NULL,
  `canceled` int(2) NOT NULL DEFAULT '0',
  `start_time` varchar(50) NOT NULL,
  `end` varchar(50) NOT NULL,
  `all_day` int(1) NOT NULL,
  `cnp` int(14) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Eliminarea datelor din tabel `bookings`
--

INSERT INTO `bookings` (`id`, `med_id`, `date`, `created_at`, `name`, `investigation`, `added_by`, `phone`, `email`, `obs`, `canceled`, `start_time`, `end`, `all_day`, `cnp`) VALUES
(1, 1, '2019-07-02', '2019-07-15 21:00:00.000000', 'Cutarescu Ionut', 'DISPENSARIZARE', 1, '0762758074', 'doitfreestyle@gmail.com', 'rtasdgasdga', 0, '\"2019-07-02T09:45:00+03:00', '2019-07-02T10:45:00+03:00', 0, 0),
(2, 1, '2019-06-18', '2019-07-15 21:00:00.000000', 'Cutarescu Ionut', 'DISPENSARIZARE', 1, '0762758074', 'doitfreestyle@gmail.com', 'rtasdgasdga', 0, '14:10:00', '00:15', 0, 0),
(3, 1, '2019-06-18', '2019-07-15 21:00:00.000000', 'Cutarescu Ionut', 'DISPENSARIZARE', 1, '0762758074', 'doitfreestyle@gmail.com', 'rtasdgasdga', 0, '13:00:00', '00:15', 0, 0),
(4, 1, '2019-06-18', '2019-07-15 21:00:00.000000', 'Cutarescu Ionut', 'DISPENSARIZARE', 1, '0762758074', 'doitfreestyle@gmail.com', 'rtasdgasdga', 0, '12:10:00', '00:15', 0, 0),
(5, 1, '2019-06-18', '2019-07-15 21:00:00.000000', 'Cutarescu Ionut', 'DISPENSARIZARE', 1, '0762758074', 'doitfreestyle@gmail.com', 'rtasdgasdga', 0, '2019-07-02T09:45:00+03:00', '00:15', 0, 0),
(6, 1, '2019-07-02', '2019-07-15 21:00:00.000000', 'Cutarescu Ionut', 'DISPENSARIZARE', 1, '0762758074', 'doitfreestyle@gmail.com', 'rtasdgasdga', 0, '2019-07-02T09:45:00+03:00', '2019-07-02T10:45:00+03:00', 0, 0),
(7, 1, '2019-07-02', '2019-07-18 17:59:19.018798', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'avc', 0, '2019-07-02T09:00:00', '2019-07-02T09:12:00', 0, 0),
(8, 1, '2019-07-02', '2019-07-18 18:02:00.671120', 'test', 'Recoltare', 1, '0000000000', 'no_email', 'afasf', 0, '2019-07-02T08:15:00', '2019-07-02T08:45:00', 0, 0),
(9, 1, '2019-07-03', '2019-07-18 18:03:47.784615', 'Ilie Marius Daniel', 'Tratament', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-03T11:15:00', '2019-07-03T11:26:00', 0, 0),
(10, 1, '2019-07-03', '2019-07-18 18:04:45.614348', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-03T09:45:00', '2019-07-03T09:56:00', 0, 0),
(11, 1, '2019-07-04', '2019-07-18 18:07:28.026427', 'asdas', 'Recoltare', 1, 'asdasd', 'no_email', '12312', 0, '2019-07-04T10:30:00', '2019-07-04T11:03:00', 0, 0),
(12, 1, '2019-07-04', '2019-07-18 18:09:01.914182', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'afasf', 0, '2019-07-04T12:15:00', '2019-07-04T12:35:00', 0, 0),
(13, 1, '2019-07-04', '2019-07-18 18:09:36.242210', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-04T11:30:00', '2019-07-04T12:30:00', 0, 0),
(14, 1, '2019-07-05', '2019-07-18 18:10:53.355521', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-05T10:15:00', '2019-07-05T10:35:00', 0, 0),
(15, 1, '2019-07-05', '2019-07-18 18:13:14.603393', 'olghljkbgljk', 'Recoltare', 1, '0762758074', 'no_email', 'afasf', 0, '2019-07-05T10:45:00', '2019-07-05T10:55:00', 0, 0),
(16, 1, '2019-07-16', '2019-07-18 18:15:36.431044', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'asf', 0, '2019-07-16T11:15:00', '2019-07-16T11:27:00', 0, 0),
(17, 1, '2019-07-16', '2019-07-18 18:16:42.704526', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'asf', 0, '2019-07-16T11:45:00', '2019-07-16T11:57:00', 0, 0),
(18, 1, '2019-07-10', '2019-07-18 18:18:39.632444', 'Ilie Marius Daniel', 'Recoltare', 1, '', 'no_email', '', 0, '2019-07-10T11:30:00', '2019-07-10T11:40:00', 0, 0),
(19, 1, '2019-07-09', '2019-07-18 18:19:13.711558', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'afasf', 0, '2019-07-09T10:30:00', '2019-07-09T10:40:00', 0, 0),
(20, 1, '2019-07-17', '2019-07-18 18:21:25.738339', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-17T11:00:00', '2019-07-17T11:20:00', 0, 0),
(21, 1, '2019-07-17', '2019-07-18 18:22:22.251243', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-17T08:45:00', '2019-07-17T09:05:00', 0, 0),
(22, 1, '2019-07-11', '2019-07-18 18:22:33.509925', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-11T11:00:00', '2019-07-11T11:20:00', 0, 0),
(23, 1, '2019-07-12', '2019-07-18 18:23:49.769054', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'afasf', 0, '2019-07-12T10:45:00', '2019-07-12T10:55:00', 0, 0),
(24, 1, '2019-07-19', '2019-07-18 18:25:05.648175', 'Ilie Cristian', 'Recoltare', 1, '0762758074', 'no_email', 'afasf', 0, '2019-07-19T10:30:00', '2019-07-19T11:00:00', 0, 0),
(25, 1, '2019-07-18', '2019-07-18 18:27:04.189659', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'saf', 0, '2019-07-18T11:30:00', '2019-07-18T12:00:00', 0, 0),
(26, 1, '2019-07-24', '2019-07-18 18:27:42.498597', 'Ilie Marius Daniel', 'Recoltare', 1, '0762758074', 'no_email', 'avc', 0, '2019-07-24T11:30:00', '2019-07-24T12:15:00', 0, 0),
(27, 1, '2019-07-09', '2019-07-22 14:01:08.107799', 'fasfasdf', 'Recoltare', 1, 'fasasfas', 'no_email', 'asfasfasf', 0, '2019-07-09T10:45:00', '2019-07-09T10:57:00', 0, 0),
(28, 1, '2019-07-18', '2019-07-22 19:41:03.001627', 'test', 'Consultatie', 1, '0000000000', 'no_email', 'asc', 0, '2019-07-18T09:00:00', '2019-07-18T09:10:00', 0, 0),
(29, 2, '2019-07-10', '2019-07-22 21:02:25.039044', 'veja test', 'Consultatie', 1, '14241241234', 'no_email', 'fasgfas', 0, '2019-07-10T10:30:00', '2019-07-10T10:41:00', 0, 0),
(30, 1, '2019-07-08', '2019-07-22 21:36:21.195879', 'Printer', 'Recoltare', 1, '0000000', 'no_email', 'test', 0, '2019-07-08T10:00:00', '2019-07-08T10:22:00', 0, 0),
(31, 1, '2019-07-22', '2019-07-22 21:37:37.712916', 'Printer', 'Recoltare', 1, '0000000', 'no_email', 'test', 0, '2019-07-22T13:15:00', '2019-07-22T13:37:00', 0, 0),
(32, 1, '2019-07-22', '2019-07-22 21:38:07.041728', 'Printer', 'Recoltare', 1, '0000000', 'no_email', 'test', 0, '2019-07-22T09:15:00', '2019-07-22T09:37:00', 0, 0),
(33, 1, '2019-07-22', '2019-07-22 21:38:13.083825', 'Printer', 'Recoltare', 1, '0000000', 'no_email', 'test', 0, '2019-07-22T10:15:00', '2019-07-22T10:37:00', 0, 0),
(34, 1, '2019-07-15', '2019-07-22 21:40:08.392005', 'Printer', 'Recoltare', 1, '0000000', 'no_email', 'test', 0, '2019-07-15T12:30:00', '2019-07-15T12:52:00', 0, 0),
(35, 1, '2019-07-03', '2019-07-22 21:43:19.386636', 'Cutare Marinescu', 'Consultatie', 1, '0000000', 'no_email', '', 0, '2019-07-03T13:15:00', '2019-07-03T13:25:00', 0, 0),
(36, 1, '2019-07-03', '2019-07-22 21:43:49.749147', 'tdjgfdj', 'Recoltare', 1, '45345345', 'no_email', '', 0, '2019-07-03T10:00:00', '2019-07-03T10:23:00', 0, 0),
(37, 1, '2019-07-25', '2019-07-22 21:44:15.258232', 'zbgzdhbdhnzxnh', 'Recoltare', 1, '454563453', 'no_email', '', 0, '2019-07-25T09:45:00', '2019-07-25T09:58:00', 0, 0),
(38, 1, '2019-07-09', '2019-07-23 16:01:59.993695', 'test', 'Consultatie', 1, '0000000000', 'no_email', 'asgfas', 0, '2019-07-09T08:45:00+03:00', '2019-07-09T09:00:00', 0, 0),
(39, 1, '2019-07-08', '2019-07-23 16:25:19.875970', 'ategtasdgadsg', 'Recoltare', 1, '1564691561', 'no_email', 'adgasdgasd', 0, '2019-07-08T12:00:00+03:00', '2019-07-08T12:15:00', 0, 0),
(46, 1, '2019-07-31', '2019-07-29 17:30:33.378725', 'BLOCAT', 'XXXX', 1, '0000000000', '0', '-', 0, '2019-07-31T00:01:00', '2019-08-07T00:00:00', 1, 0),
(45, 1, '2019-07-17', '2019-07-29 17:27:17.015661', 'BLOCAT', 'XXXX', 1, '0000000000', '0', '-', 0, '2019-07-17T00:01:00', '2019-07-25T00:00:00', 1, 0),
(44, 1, '2019-02-07', '2019-07-29 17:22:43.323072', 'BLOCAT', 'XXXX', 1, '0000000000', '0', '-', 0, '2019-07-17T00:01:00', '2019-07-25T00:00:00', 1, 0);

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `hours`
--

DROP TABLE IF EXISTS `hours`;
CREATE TABLE IF NOT EXISTS `hours` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `hour` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `medic`
--

DROP TABLE IF EXISTS `medic`;
CREATE TABLE IF NOT EXISTS `medic` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `start` varchar(100) DEFAULT NULL,
  `end` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Eliminarea datelor din tabel `medic`
--

INSERT INTO `medic` (`id`, `name`, `start`, `end`) VALUES
(1, 'Dr. Popescu', '08:00', '13:45'),
(2, 'Dr. Veja Ana Maria', '11:00', '15:00');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medics` varchar(200) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Eliminarea datelor din tabel `users`
--

INSERT INTO `users` (`id`, `medics`, `username`, `password`, `type`) VALUES
(1, '1,2,3,4', 'claudiu', 'c4d1ab5128cb2ab7f36bee9e245ad158', 9);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
