-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2019 at 11:23 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_atm`
--

-- --------------------------------------------------------

--
-- Table structure for table `log_transaksi`
--

CREATE TABLE `log_transaksi` (
  `tanggal` datetime NOT NULL,
  `norek` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `nominal` int(11) NOT NULL,
  `saldo_awal` int(11) NOT NULL,
  `saldo_akhir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `log_transaksi`
--

INSERT INTO `log_transaksi` (`tanggal`, `norek`, `nominal`, `saldo_awal`, `saldo_akhir`) VALUES
('2019-05-19 21:26:06', '1', 100000, 7599995, 7499995),
('2019-05-19 21:28:22', '1', 1000000, 7499995, 6499995),
('2019-05-19 21:29:34', '1', -3500005, 6499995, 10000000),
('2019-06-16 23:53:15', '2', -50000, 1000000, 1050000),
('2019-06-16 23:53:16', '1', 50000, 10000000, 9950000),
('2019-06-16 23:55:23', '2', -50000, 1050000, 1100000),
('2019-06-16 23:55:23', '1', 50000, 9950000, 9900000),
('2019-06-17 00:16:40', '1', 50000, 9900000, 9850000);

-- --------------------------------------------------------

--
-- Table structure for table `saldo`
--

CREATE TABLE `saldo` (
  `norek` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `saldo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `saldo`
--

INSERT INTO `saldo` (`norek`, `saldo`) VALUES
('1', 9850000),
('2', 1100000),
('3', 1000000);

--
-- Triggers `saldo`
--
DELIMITER $$
CREATE TRIGGER `log_trx` BEFORE UPDATE ON `saldo` FOR EACH ROW BEGIN
	INSERT INTO log_transaksi VALUES(NOW(), OLD.norek, OLD.saldo-NEW.saldo, OLD.saldo, NEW.saldo);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transfer`
--

CREATE TABLE `transfer` (
  `id` int(11) NOT NULL,
  `norek_pengirim` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `norek_tujuan` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nominal` int(11) NOT NULL,
  `keterangan` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `transfer`
--

INSERT INTO `transfer` (`id`, `norek_pengirim`, `norek_tujuan`, `nominal`, `keterangan`) VALUES
(1, '1', '2', 50000, 'Sedekah'),
(2, '1', '0011', 50000, 'Sedekah');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `norek` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` enum('pegawai','nasabah') COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `norek`, `nama`, `password`, `role`) VALUES
(1, '1', 'Fakhri Rizha Ananda', '1', 'nasabah'),
(2, '2', 'Muhammad Rafif Rasyidi', '2', 'nasabah'),
(3, '3', 'Ibnu Maulana', '3', 'nasabah');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `saldo`
--
ALTER TABLE `saldo`
  ADD PRIMARY KEY (`norek`);

--
-- Indexes for table `transfer`
--
ALTER TABLE `transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `norek` (`norek`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transfer`
--
ALTER TABLE `transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `saldo`
--
ALTER TABLE `saldo`
  ADD CONSTRAINT `FK_UserSaldo` FOREIGN KEY (`norek`) REFERENCES `user` (`norek`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
