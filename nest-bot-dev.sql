-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2020 at 01:57 PM
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
-- Database: `nest-bot-dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `telegram_user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `team_leader_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nik` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `telegram_user_name`, `full_name`, `telegram_user_id`, `team_leader_id`, `nik`, `created_at`, `updated_at`) VALUES
(1, 'muzaki_gh', 'ABDUL ROKHMAN', 507549293, NULL, 20961102, '2020-09-06 11:52:08', '2020-09-06 11:52:08'),
(2, '', 'RACHMAT HENDRA SAPUTRA', NULL, NULL, 18950823, NULL, NULL),
(3, '', 'RIZALDI ILHAM PRATAMA', NULL, NULL, 18980377, NULL, NULL),
(4, '', 'NINKA DEARANI', NULL, NULL, 20961126, NULL, NULL),
(5, '', 'AJIE RAMADHIANTO', NULL, NULL, 91160082, NULL, NULL),
(6, '', 'CHARIS', NULL, NULL, 18910017, NULL, NULL),
(7, '', 'KHARIS NAGARA', NULL, NULL, 18880071, NULL, NULL),
(8, '', 'AKHMAD URIFAN', NULL, NULL, 18930234, NULL, NULL),
(9, '', 'ALDIAN AKBAR NAUFAL', NULL, NULL, 91160066, NULL, NULL),
(10, '', 'MUKHAMMAD MUDASIR SUTRISNO', NULL, NULL, 18950014, NULL, NULL),
(11, '', 'AIDZIN RIZKI BACHRONY', NULL, NULL, 20930046, NULL, NULL),
(12, '', 'NOVAL ZUKIS PRIHANDOYO', NULL, NULL, 19880101, NULL, NULL),
(13, '', 'DANANG TISMA AMIJAYA', NULL, NULL, 20961274, NULL, NULL),
(14, '', 'ACHMAD YASSAR A', NULL, NULL, 18960568, NULL, NULL),
(15, '', 'DANI ACHMAD SAIFUL', NULL, NULL, 20950927, NULL, NULL),
(16, '', 'RIFKI JUDO WARDOYO', NULL, NULL, 20970957, NULL, NULL),
(17, '', 'MOCH. AKBAR MUSTIKA MUSTHOFA', NULL, NULL, 20980906, NULL, NULL),
(18, '', 'KRISTIANTO ALDIANSA', NULL, NULL, 18980420, NULL, NULL),
(19, '', 'MUHAMMAD HUSEN ZAINUDIN', NULL, NULL, 90160033, NULL, NULL),
(20, '', 'ALEXANDER LEMAN PRATAMA', NULL, NULL, 20960819, NULL, NULL),
(21, '', 'AFIN ANGGARA', NULL, NULL, 93160122, NULL, NULL),
(22, '', 'DIO IHZA RAMADANY', NULL, NULL, 18970328, NULL, NULL),
(23, '', 'TIGO DWI ANGGA', NULL, NULL, 18980105, NULL, NULL),
(24, '', 'MUHAMMAD ARIF WIBISONO', NULL, NULL, 93160123, NULL, NULL),
(25, '', 'RIZKY DWI INDRIYANTO', NULL, NULL, 20950895, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_products`
--

CREATE TABLE `jenis_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `jenis_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminder` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_products`
--

INSERT INTO `jenis_products` (`id`, `jenis_name`, `reminder`, `created_at`, `updated_at`) VALUES
(1, 'OPTICAL POWER METER', 6, '2020-09-06 10:31:15', '2020-09-06 10:31:15');

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
(1, 'B&D TECHNOLOGY', '2020-09-06 10:30:23', '2020-09-06 10:30:23'),
(2, 'JOINWIT FROM SANFIX', '2020-09-06 10:30:34', '2020-09-06 10:30:34');

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
(5, '2020_09_04_075629_create_position_products_table', 1),
(6, '2020_09_06_100646_create_reminder_groups_table', 1);

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
  `approve_state` enum('approved','disagree','waiting') COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_state` enum('baik','dikembalikan','rusak','belum_melaporkan','hilang') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `position_products`
--

INSERT INTO `position_products` (`id`, `new_update`, `picture_loc`, `employee_id`, `approve_id`, `product_id`, `approve_state`, `product_state`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, NULL, 1, 'approved', 'baik', '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(2, 1, NULL, 2, NULL, 2, 'approved', 'baik', '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(3, 1, NULL, 3, NULL, 3, 'approved', 'baik', '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(4, 1, NULL, 4, NULL, 4, 'approved', 'baik', '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(5, 1, NULL, 5, NULL, 5, 'approved', 'baik', '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(6, 1, NULL, 6, NULL, 6, 'approved', 'baik', '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(7, 1, NULL, 7, NULL, 7, 'approved', 'hilang', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(8, 1, NULL, 8, NULL, 8, 'approved', 'baik', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(9, 1, NULL, 9, NULL, 9, 'approved', 'hilang', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(10, 1, NULL, 10, NULL, 10, 'approved', 'hilang', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(11, 1, NULL, 11, NULL, 11, 'approved', 'hilang', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(12, 1, NULL, 12, NULL, 12, 'approved', 'rusak', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(13, 1, NULL, 13, NULL, 13, 'approved', 'rusak', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(14, 1, NULL, 14, NULL, 14, 'approved', 'baik', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(15, 1, NULL, 15, NULL, 15, 'approved', 'rusak', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(16, 1, NULL, 16, NULL, 16, 'approved', 'baik', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(17, 1, NULL, 17, NULL, 17, 'approved', 'dikembalikan', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(18, 1, NULL, 18, NULL, 18, 'approved', 'dikembalikan', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(19, 1, NULL, 19, NULL, 19, 'approved', 'dikembalikan', '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(20, 1, NULL, 20, NULL, 20, 'approved', 'baik', '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(21, 1, NULL, 21, NULL, 21, 'approved', 'baik', '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(22, 1, NULL, 22, NULL, 22, 'approved', 'baik', '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(23, 1, NULL, 23, NULL, 23, 'approved', 'baik', '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(24, 1, NULL, 24, NULL, 24, 'approved', 'baik', '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(25, 1, NULL, 25, NULL, 25, 'approved', 'baik', '2020-09-06 11:36:16', '2020-09-06 11:36:16');

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
(1, '1503201128', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(2, '1503201133', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(3, '1503201153', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(4, '1503201156', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(5, '1503301375', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(6, '1503301376', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:14', '2020-09-06 11:36:14'),
(7, '1503301492', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(8, '1503301497', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(9, 'GAF0390577', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(10, 'GSF0390594', 'OPTICAL POWER METER B&D TECHNOLOGY BD-503', 1, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(11, '0011/OPPM/5/45/2019', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(12, '16105288', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(13, '16105357', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(14, '16105392', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(15, '170522619', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(16, '170522637', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(17, '170522766', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(18, '170522900', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(19, '170523158', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(20, '170523408', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:15', '2020-09-06 11:36:15'),
(21, '170523802', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(22, '170523832', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(23, '170523901', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(24, '170523941', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:16', '2020-09-06 11:36:16'),
(25, '170523953', 'OPTICAL POWER METER JOINWIT STANDARD', 2, 1, '2020-09-06 11:36:16', '2020-09-06 11:36:16');

-- --------------------------------------------------------

--
-- Table structure for table `reminder_groups`
--

CREATE TABLE `reminder_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `last_known_group_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `jenis_products`
--
ALTER TABLE `jenis_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `merk_products`
--
ALTER TABLE `merk_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `position_products`
--
ALTER TABLE `position_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `reminder_groups`
--
ALTER TABLE `reminder_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_team_leader_id_foreign` FOREIGN KEY (`team_leader_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `position_products`
--
ALTER TABLE `position_products`
  ADD CONSTRAINT `position_products_approve_id_foreign` FOREIGN KEY (`approve_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `position_products_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `position_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_jenis_id_foreign` FOREIGN KEY (`jenis_id`) REFERENCES `jenis_products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_merk_id_foreign` FOREIGN KEY (`merk_id`) REFERENCES `merk_products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
