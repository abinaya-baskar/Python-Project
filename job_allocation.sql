-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2025 at 09:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `job_allocation`
--

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `issue` varchar(255) NOT NULL,
  `x1` int(11) DEFAULT NULL,
  `y1` int(11) DEFAULT NULL,
  `x2` int(11) DEFAULT NULL,
  `y2` int(11) DEFAULT NULL,
  `status` enum('Pending','Accepted','Rejected') DEFAULT 'Pending',
  `assigned_to` varchar(50) DEFAULT NULL,
  `assigned_user` varchar(100) DEFAULT NULL,
  `job_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `issue`, `x1`, `y1`, `x2`, `y2`, `status`, `assigned_to`, `assigned_user`, `job_type`) VALUES
(27, 'tree_fallen', 0, 0, 595, 435, 'Accepted', NULL, 'User1', 'Unknown'),
(28, 'road_pathole', 201, 43, 432, 252, 'Accepted', NULL, 'User1', 'Unknown'),
(29, 'road_pathole', 193, 0, 438, 259, '', NULL, 'user2', 'Unknown'),
(30, 'road_pathole', 189, 0, 416, 253, '', NULL, 'user1', 'Unknown'),
(31, 'road_pathole', 188, 0, 413, 230, 'Pending', NULL, 'user1', 'Unknown'),
(32, 'road_pathole', 183, 0, 405, 228, 'Pending', NULL, 'User1', 'Unknown'),
(33, 'road_pathole', 163, 0, 386, 225, '', NULL, NULL, 'Unknown'),
(34, 'road_pathole', 152, 0, 365, 219, 'Pending', NULL, NULL, 'Unknown'),
(35, 'road_pathole', 153, 0, 381, 211, 'Pending', NULL, NULL, 'Unknown'),
(36, 'road_pathole', 137, 0, 362, 228, 'Pending', NULL, NULL, 'Unknown'),
(37, 'road_pathole', 138, 0, 360, 215, 'Accepted', NULL, 'User4', 'Unknown'),
(38, 'road_pathole', 138, 0, 361, 224, 'Pending', NULL, 'user4', 'Unknown'),
(39, 'road_pathole', 138, 0, 361, 224, 'Pending', NULL, NULL, 'Unknown'),
(40, 'road_pathole', 136, 0, 361, 230, 'Pending', NULL, NULL, 'Unknown'),
(41, 'road_pathole', 138, 0, 360, 228, 'Pending', NULL, NULL, 'Unknown'),
(42, 'road_pathole', 137, 0, 362, 219, 'Pending', NULL, NULL, 'Unknown'),
(43, 'road_pathole', 136, 0, 359, 199, 'Pending', NULL, NULL, 'Unknown'),
(44, 'road_pathole', 136, 0, 360, 225, 'Pending', NULL, NULL, 'Unknown'),
(45, 'road_pathole', 133, 0, 359, 226, 'Pending', NULL, NULL, 'Unknown'),
(46, 'road_pathole', 135, 0, 354, 230, 'Pending', NULL, NULL, 'Unknown'),
(47, 'road_pathole', 135, 3, 356, 230, '', NULL, 'User1', 'Unknown'),
(48, 'road_pathole', 132, 4, 355, 231, 'Pending', NULL, NULL, 'Unknown'),
(49, 'road_pathole', 137, 2, 357, 231, 'Pending', NULL, NULL, 'Unknown'),
(50, 'road_pathole', 136, 0, 360, 227, 'Pending', NULL, NULL, 'Unknown'),
(51, 'road_pathole', 137, 1, 360, 233, 'Pending', NULL, NULL, 'Unknown'),
(52, 'road_pathole', 134, 0, 359, 258, 'Pending', NULL, NULL, 'Unknown'),
(53, 'road_pathole', 135, 0, 365, 255, 'Pending', NULL, NULL, 'Unknown'),
(54, 'road_pathole', 135, 0, 357, 222, 'Pending', NULL, NULL, 'Unknown'),
(55, 'road_pathole', 136, 1, 361, 238, 'Pending', NULL, NULL, 'Unknown'),
(56, 'road_pathole', 136, 0, 359, 257, 'Pending', NULL, NULL, 'Unknown'),
(57, 'road_pathole', 135, 0, 362, 244, 'Pending', NULL, NULL, 'Unknown'),
(58, 'road_pathole', 135, 0, 363, 254, 'Pending', NULL, NULL, 'Unknown'),
(59, 'road_pathole', 133, 1, 348, 234, 'Pending', NULL, NULL, 'Unknown'),
(60, 'road_pathole', 110, 3, 311, 227, 'Pending', NULL, NULL, 'Unknown'),
(61, 'road_pathole', 90, 0, 310, 230, 'Pending', NULL, NULL, 'Unknown'),
(62, 'road_pathole', 86, 0, 306, 224, 'Pending', NULL, NULL, 'Unknown'),
(63, 'road_pathole', 86, 0, 310, 229, 'Pending', NULL, NULL, 'Unknown'),
(64, 'road_pathole', 87, 0, 312, 225, 'Pending', NULL, NULL, 'Unknown'),
(65, 'road_pathole', 83, 0, 311, 231, 'Pending', NULL, NULL, 'Unknown'),
(66, 'road_pathole', 86, 0, 310, 231, 'Pending', NULL, NULL, 'Unknown'),
(67, 'tree_fallen', 0, 18, 609, 480, 'Pending', NULL, NULL, 'Unknown'),
(68, 'tree_fallen', 0, 10, 569, 478, 'Pending', NULL, NULL, 'Unknown'),
(69, 'tree_fallen', 2, 0, 616, 480, 'Pending', NULL, NULL, 'Unknown'),
(70, 'tree_fallen', 0, 0, 603, 457, 'Pending', NULL, NULL, 'Unknown'),
(71, 'tree_fallen', 0, 0, 536, 480, 'Pending', NULL, NULL, 'Unknown');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'user1', 'password1'),
(2, 'user2', 'password2'),
(3, 'user3', 'password3'),
(4, 'user4', 'password4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
