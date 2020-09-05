-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2020 at 09:27 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nest-bot`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telegram_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `team_leader_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nik` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `full_name`, `telegram_user_id`, `team_leader_id`, `nik`, `created_at`, `updated_at`) VALUES
(2, 'BAGUS DWI HERMAWAN', 507549293, NULL, 15373736, '2020-09-04 19:10:34', '2020-09-04 19:10:34'),
(3, 'ADE RISDIAN ANWAR', NULL, NULL, NULL, '2020-09-04 19:10:34', '2020-09-04 19:10:34'),
(4, 'MAULANA GHOFFARUL KAHFI', NULL, NULL, NULL, '2020-09-04 19:10:34', '2020-09-04 19:10:34'),
(5, 'RIFKI JUDO WARDOYO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(6, 'FIRMAN AMIN MASONI', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(7, 'MUHAMMAD IKHYAK GALI OKTANDA', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(8, 'SUHARJO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(9, 'ILHAM', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(10, 'MUCHAMAD DIDIK SUWARDOYO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(11, 'YUSTIANZAH RACHMANTO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(12, 'DANDI DWI HERMAWAN', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(13, 'BIMA BAHRIL ILMI', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(14, 'MUKHAMMAD MUDASIR SUTRISNO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(15, 'ANGGRIAWAN ATMY PUTRA', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(16, 'GILANG RAMADHAN AGUNG GUMELAR', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(17, 'ANWAR AZIS ROSYIDI', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(18, 'MUHAMMAD HUSEN ZAINUDIN', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(19, 'EGA NANDA ICHNUARI', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(20, 'TIGO DWI ANGGA', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(21, 'AKHMAD YUSUF', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(22, 'ANDIKA ADI SAKA FATMA', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(23, 'MOCHAMAD LUTFI', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(24, 'AHMAD ZAINUL IRFAN', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(25, 'BRIYAN PRASETYO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(26, 'YONA SEPTIANTO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(27, 'MOH. ABDILLAH', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(28, 'MUKLAS ANDIKA WIJAYA', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(29, 'WAHYU UTOMO', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(30, 'MUHAMMAD AGUS WAHYUDHI', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(31, 'LUHUNG JIWA SAPUTRA', NULL, NULL, NULL, '2020-09-04 19:10:35', '2020-09-04 19:10:35'),
(32, 'JIHAD AMIRUL HAQ', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(33, 'IVAN DWI OKTAFIAN', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(34, 'CHARIS', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(35, 'DIO IHZA RAMADANY', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(36, 'WAHYU INDRA CHRISTIAN', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(37, 'GALI SETIYAWAN', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(38, 'RASIO EKA PRAYUDHA', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(39, 'AHMAD DZULFIKAR', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(40, 'IZUDDIN AMRULLOH', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(41, 'ZULFI PURWOKO HARDIYANTO', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(42, 'ROSI INDRASARI', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(43, 'YULIAN SUKMA PRADANA', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(44, 'RUSTAMI HERDI TRIAWAN', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(45, 'PRAYOGA DWI WIDODO', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(46, 'ROBAKHUL ARIFIN', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(47, 'MUKHAMAD ASRORI', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(48, 'ALDIAN AKBAR NAUFAL', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(49, 'SODIK', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(50, 'WAHYU IQSAN BANGUN NUSANTORO', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(51, 'MOH RANDY ARDIKA', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(52, 'MOH. MAULANA KHOIRI', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(53, 'M BISRI ARIANTO', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(54, 'RINDARTO WIBISONO', NULL, NULL, NULL, '2020-09-04 19:10:36', '2020-09-04 19:10:36'),
(55, 'EKO WIDIANTO', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(56, 'RIO SAPUTRA ARGANATA', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(57, 'MOCHAMMAD ZAINURROZIQIN', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(58, 'MOCH. AKBAR MUSTIKA MUSTHOFA', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(59, 'AKHMAD URIFAN', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(60, 'IQBAL AFGHANI ARIGGI', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(61, 'ANDY SISWANTO', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(62, 'ARIF RACHMADHONI', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(63, 'AJIE RAMADHIANTO', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(64, 'SALMAN AL FARISYI', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37'),
(65, 'SOFYAN NAURI', NULL, NULL, NULL, '2020-09-04 19:10:37', '2020-09-04 19:10:37');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_products`
--

CREATE TABLE `jenis_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `jenis_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminder` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_products`
--

INSERT INTO `jenis_products` (`id`, `jenis_name`, `reminder`, `created_at`, `updated_at`) VALUES
(1, 'OPTICAL POWER METER', 7, '2020-09-04 19:07:38', '2020-09-04 19:07:38'),
(2, 'OPTICAL LIGHT SOURCE', 7, '2020-09-04 19:07:38', '2020-09-04 19:07:38');

-- --------------------------------------------------------

--
-- Table structure for table `merk_products`
--

CREATE TABLE `merk_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `merk_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `merk_products`
--

INSERT INTO `merk_products` (`id`, `merk_name`, `created_at`, `updated_at`) VALUES
(1, 'JOINWIT FROM SANFIX', '2020-09-04 19:00:43', '2020-09-04 19:00:43'),
(2, 'B&D TECHNOLOGY', '2020-09-04 19:00:43', '2020-09-04 19:00:43'),
(3, 'SENTER', '2020-09-04 19:00:43', '2020-09-04 19:00:43'),
(4, 'STINTRUMENT', '2020-09-04 19:00:43', '2020-09-04 19:00:43');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2020_09_04_075045_create_merk_products_table', 1),
(2, '2020_09_04_075618_create_jenis_products_table', 1),
(3, '2020_09_04_075620_create_employees_table', 1),
(4, '2020_09_04_075625_create_products_table', 1),
(5, '2020_09_04_075629_create_position_products_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `position_products`
--

CREATE TABLE `position_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `new_update` tinyint(1) NOT NULL,
  `picture_loc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `approve_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `approve_state` enum('approved','disagree','waiting') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_state` enum('baik','dikembalikan','hilang','belum_melaporkan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `position_products`
--

INSERT INTO `position_products` (`id`, `new_update`, `picture_loc`, `employee_id`, `approve_id`, `product_id`, `approve_state`, `product_state`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 2, NULL, 4, 'approved', 'hilang', '2020-09-04 19:30:03', '2020-09-04 19:30:03'),
(2, 0, NULL, 2, NULL, 25, 'approved', 'belum_melaporkan', '2020-09-04 19:30:59', '2020-09-04 19:30:59'),
(3, 1, NULL, 2, NULL, 28, 'approved', 'baik', '2020-09-04 19:31:18', '2020-04-21 19:31:18'),
(5, 0, 'C:Usersforderationkerja\nest-bot/res/img/2020-09-05/507549293/AgACAgUAAxkBAAO_X1OQjseOKNeTTQM8QmDE171XFMgAAq2qMRvGxphWXs4mNFosshBbt2ZrdAADAQADAgADeAADiF8GAAEbBA.jpg', 2, NULL, 25, NULL, 'baik', '2020-09-05 13:20:14', '2020-09-05 13:20:14'),
(6, 0, 'C:Usersforderationkerja\r\nest-bot\r\nesimg2020-09-05507549293/AgACAgUAAxkBAAPFX1ORe1d8aKqfzyNTsYnS7LQTUvIAAq2qMRvGxphWXs4mNFosshBbt2ZrdAADAQADAgADeAADiF8GAAEbBA.jpg', 2, NULL, 25, NULL, 'baik', '2020-09-05 13:24:11', '2020-09-05 13:24:11'),
(7, 0, 'C:Usersforderationkerja\nest-bot\resimg2020-09-05507549293/AgACAgUAAxkBAAPLX1OSHaaFlvev7W0mCugVMY6TsrcAArCqMRvGxphWY2zTBeZwMyto5ANsdAADAQADAgADeQAD1G8CAAEbBA.jpg', 2, NULL, 25, NULL, 'baik', '2020-09-05 13:26:54', '2020-09-05 13:26:54'),
(8, 0, 'C:////Users////forderation////kerja////nest-bot////res////img////2020-09-05////507549293//AgACAgUAAxkBAAPRX1OTLyzeSjMDh33lFGyEoDmhSh8AAq2qMRvGxphWXs4mNFosshBbt2ZrdAADAQADAgADeAADiF8GAAEbBA.jpg', 2, NULL, 25, NULL, 'baik', '2020-09-05 13:31:27', '2020-09-05 13:31:27'),
(9, 1, 'C:/Users/forderation/kerja/nest-bot/res/img/2020-09-05/507549293/AgACAgUAAxkBAAPXX1OTypvzJ9u4XZ0zaDNNQu2D7X4AAraqMRvGxphWcPHnBohrY2GNfmJsdAADAQADAgADeAADelsBAAEbBA.jpg', 2, NULL, 25, NULL, 'belum_melaporkan', '2020-09-05 13:34:03', '2020-07-15 13:34:03');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `serial_number` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `merk_id` bigint(20) UNSIGNED NOT NULL,
  `jenis_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `serial_number`, `product_name`, `merk_id`, `jenis_id`, `created_at`, `updated_at`) VALUES
(2, '161011188', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:03', '2020-09-04 19:25:03'),
(3, '161011248', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:03', '2020-09-04 19:25:03'),
(4, '170525270', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(5, '170525288', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(6, '170525300', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(7, '170525317', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(8, '170525320', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(9, '170525572', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(10, '170525574', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(11, '170525651', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(12, '170525723', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(13, '170525724', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(14, '170525737', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(15, '170525908', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(16, '170525933', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(17, '170526422', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(18, 'OLS160211231', 'OPTICAL LIGHT SOURCE JOINWIT STANDARD', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(19, 'OLS150811429', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(20, 'OLS150811444', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(21, 'OLS150811456', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(22, 'OLS150811494', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(23, 'OLS150811498', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(24, 'OLS150811583', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(25, 'OLS150811615', 'OPTICAL LIGHT SOURCE JOINWIT FROM SANFIX', 1, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(26, 'GAK0861034', 'OPTICAL LIGHT SOURCE SENTER STANDARD', 3, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(27, 'GAK0861040', 'OPTICAL LIGHT SOURCE SENTER STANDARD', 3, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(28, 'GAK0861047', 'OPTICAL LIGHT SOURCE SENTER STANDARD', 3, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(29, 'GAK0861108', 'OPTICAL LIGHT SOURCE SENTER STANDARD', 3, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(30, 'LS-0317', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:04', '2020-09-04 19:25:04'),
(31, 'LS-0326', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(32, 'LS-0337', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(33, 'LS-0343', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(34, 'LS-0406', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(35, 'LS-0407', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(36, 'LS-0408', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(37, 'LS-0412', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(38, 'LS-0420', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(39, 'LS-0522', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(40, 'LS-0684', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(41, 'LS-0687', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(42, 'LS-0690', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(43, 'LS-0705', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(44, 'LS-1012', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(45, 'LS-1024', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(46, 'LS-1025', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(47, 'LS-1027', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(48, 'LS-1045', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(49, 'LS-1075', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(50, 'LS-4699', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(51, 'LS-4725', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(52, 'LS-7005', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(53, 'LS-7308', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(54, 'LS-7374', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(55, 'LS-7413', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(56, 'LS-7611', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(57, 'LS-7614', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:05', '2020-09-04 19:25:05'),
(58, 'LS-7961', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06'),
(59, 'LS-7991', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06'),
(60, 'LS-8352', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06'),
(61, 'LS-8468', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06'),
(62, 'LS-975', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06'),
(63, 'LS-988', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06'),
(64, 'LS-990', 'OLS STINTRUMENT [STANDARD]', 4, 2, '2020-09-04 19:25:06', '2020-09-04 19:25:06');

-- --------------------------------------------------------

--
-- Table structure for table `reminder_groups`
--

CREATE TABLE `reminder_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `last_known_group_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `reminder_groups`
--

INSERT INTO `reminder_groups` (`id`, `group_id`, `last_known_group_name`) VALUES
(13, -492110182, 'Nest Bot Dev'),
(17, 507549293, 'muzaki_gh');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_nik_unique` (`nik`),
  ADD KEY `employees_team_leader_id_foreign` (`team_leader_id`);

--
-- Indexes for table `jenis_products`
--
ALTER TABLE `jenis_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merk_products`
--
ALTER TABLE `merk_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `position_products`
--
ALTER TABLE `position_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `position_products_employee_id_foreign` (`employee_id`),
  ADD KEY `position_products_approve_id_foreign` (`approve_id`),
  ADD KEY `position_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_serial_number_unique` (`serial_number`) USING HASH,
  ADD KEY `products_merk_id_foreign` (`merk_id`),
  ADD KEY `products_jenis_id_foreign` (`jenis_id`);

--
-- Indexes for table `reminder_groups`
--
ALTER TABLE `reminder_groups`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `jenis_products`
--
ALTER TABLE `jenis_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `merk_products`
--
ALTER TABLE `merk_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `position_products`
--
ALTER TABLE `position_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `reminder_groups`
--
ALTER TABLE `reminder_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_team_leader_id_foreign` FOREIGN KEY (`team_leader_id`) REFERENCES `employees` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `position_products`
--
ALTER TABLE `position_products`
  ADD CONSTRAINT `position_products_approve_id_foreign` FOREIGN KEY (`approve_id`) REFERENCES `employees` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `position_products_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `position_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_jenis_id_foreign` FOREIGN KEY (`jenis_id`) REFERENCES `jenis_products` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `products_merk_id_foreign` FOREIGN KEY (`merk_id`) REFERENCES `merk_products` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
