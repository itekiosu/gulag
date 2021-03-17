-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 17, 2021 at 07:45 PM
-- Server version: 5.7.32-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gulag`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `id` int(11) NOT NULL,
  `file` varchar(128) NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 NOT NULL,
  `desc` varchar(256) CHARACTER SET utf8 NOT NULL,
  `cond` varchar(256) NOT NULL,
  `mode` tinyint(1) NOT NULL,
  `custom` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `channels`
--

CREATE TABLE `channels` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `topic` varchar(256) NOT NULL,
  `read_priv` int(11) NOT NULL DEFAULT '1',
  `write_priv` int(11) NOT NULL DEFAULT '2',
  `auto_join` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clans`
--

CREATE TABLE `clans` (
  `id` int(11) NOT NULL,
  `name` varchar(16) CHARACTER SET utf8 NOT NULL,
  `tag` varchar(6) CHARACTER SET utf8 NOT NULL,
  `owner` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `client_hashes`
--

CREATE TABLE `client_hashes` (
  `userid` int(11) NOT NULL,
  `osuver` char(32) NOT NULL,
  `osupath` char(32) NOT NULL,
  `adapters` char(32) NOT NULL,
  `uninstall_id` char(32) NOT NULL,
  `disk_serial` char(32) NOT NULL,
  `latest_time` datetime NOT NULL,
  `occurrences` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `target_id` int(11) NOT NULL COMMENT 'replay, map, or set id',
  `target_type` enum('replay','map','song') NOT NULL,
  `userid` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `comment` varchar(80) CHARACTER SET utf8 NOT NULL,
  `colour` char(6) DEFAULT NULL COMMENT 'rgb hex string'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `discord`
--

CREATE TABLE `discord` (
  `tag` varchar(110) CHARACTER SET utf8 NOT NULL,
  `user` int(11) NOT NULL,
  `code` varchar(110) NOT NULL,
  `tag_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `userid` int(11) NOT NULL,
  `setid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `friendships`
--

CREATE TABLE `friendships` (
  `user1` int(11) NOT NULL,
  `user2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `from` int(11) NOT NULL COMMENT 'both from and to are playerids',
  `to` int(11) NOT NULL,
  `msg` varchar(2048) CHARACTER SET utf8 NOT NULL,
  `time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mail`
--

CREATE TABLE `mail` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `msg` text CHARACTER SET utf8 NOT NULL,
  `time` int(11) DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `maps`
--

CREATE TABLE `maps` (
  `server` enum('osu!','gulag') NOT NULL DEFAULT 'osu!',
  `id` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `md5` char(32) NOT NULL,
  `artist` varchar(128) CHARACTER SET utf8 NOT NULL,
  `title` varchar(128) CHARACTER SET utf8 NOT NULL,
  `version` varchar(128) CHARACTER SET utf8 NOT NULL,
  `creator` varchar(19) CHARACTER SET utf8 NOT NULL COMMENT 'not 100% certain on len',
  `last_update` datetime NOT NULL,
  `total_length` int(11) NOT NULL,
  `frozen` tinyint(1) NOT NULL DEFAULT '0',
  `plays` int(11) NOT NULL DEFAULT '0',
  `passes` int(11) NOT NULL DEFAULT '0',
  `mode` tinyint(1) NOT NULL DEFAULT '0',
  `bpm` float(12,2) NOT NULL DEFAULT '0.00',
  `cs` float(4,2) NOT NULL DEFAULT '0.00',
  `ar` float(4,2) NOT NULL DEFAULT '0.00',
  `od` float(4,2) NOT NULL DEFAULT '0.00',
  `hp` float(4,2) NOT NULL DEFAULT '0.00',
  `diff` float(6,3) NOT NULL DEFAULT '0.000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `performance_reports`
--

CREATE TABLE `performance_reports` (
  `scoreid` int(11) NOT NULL,
  `mod_mode` enum('vanilla','relax','autopilot') NOT NULL DEFAULT 'vanilla',
  `os` varchar(64) NOT NULL,
  `fullscreen` tinyint(1) NOT NULL,
  `fps_cap` varchar(16) NOT NULL,
  `compatibility` tinyint(1) NOT NULL,
  `version` varchar(16) NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `frame_count` int(11) NOT NULL,
  `spike_frames` int(11) NOT NULL,
  `aim_rate` int(11) NOT NULL,
  `completion` tinyint(1) NOT NULL,
  `identifier` varchar(128) DEFAULT NULL COMMENT 'really don''t know much about this yet',
  `average_frametime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pwreset`
--

CREATE TABLE `pwreset` (
  `uid` int(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `used` int(1) NOT NULL,
  `gentime` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `userid` int(11) NOT NULL,
  `map_md5` char(32) NOT NULL,
  `rating` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `requester` varchar(100) NOT NULL,
  `map` int(11) NOT NULL,
  `status` varchar(11) NOT NULL,
  `type` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `scores_ap`
--

CREATE TABLE `scores_ap` (
  `id` int(11) NOT NULL,
  `map_md5` char(32) NOT NULL,
  `score` int(11) NOT NULL,
  `pp` float(7,3) NOT NULL,
  `acc` float(6,3) NOT NULL,
  `max_combo` int(11) NOT NULL,
  `mods` int(11) NOT NULL,
  `n300` int(11) NOT NULL,
  `n100` int(11) NOT NULL,
  `n50` int(11) NOT NULL,
  `nmiss` int(11) NOT NULL,
  `ngeki` int(11) NOT NULL,
  `nkatu` int(11) NOT NULL,
  `grade` varchar(2) NOT NULL DEFAULT 'N',
  `status` tinyint(4) NOT NULL,
  `mode` tinyint(4) NOT NULL,
  `play_time` int(100) NOT NULL,
  `time_elapsed` int(11) NOT NULL,
  `client_flags` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `perfect` tinyint(1) NOT NULL,
  `mods_readable` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `scores_rx`
--

CREATE TABLE `scores_rx` (
  `id` int(11) NOT NULL,
  `map_md5` char(32) NOT NULL,
  `score` int(11) NOT NULL,
  `pp` float(7,3) NOT NULL,
  `acc` float(6,3) NOT NULL,
  `max_combo` int(11) NOT NULL,
  `mods` int(11) NOT NULL,
  `n300` int(11) NOT NULL,
  `n100` int(11) NOT NULL,
  `n50` int(11) NOT NULL,
  `nmiss` int(11) NOT NULL,
  `ngeki` int(11) NOT NULL,
  `nkatu` int(11) NOT NULL,
  `grade` varchar(2) NOT NULL DEFAULT 'N',
  `status` tinyint(4) NOT NULL,
  `mode` tinyint(4) NOT NULL,
  `play_time` int(100) NOT NULL,
  `time_elapsed` int(11) NOT NULL,
  `client_flags` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `perfect` tinyint(1) NOT NULL,
  `mods_readable` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `scores_vn`
--

CREATE TABLE `scores_vn` (
  `id` int(11) NOT NULL,
  `map_md5` char(32) NOT NULL,
  `score` int(11) NOT NULL,
  `pp` float(7,3) NOT NULL,
  `acc` float(6,3) NOT NULL,
  `max_combo` int(11) NOT NULL,
  `mods` int(11) NOT NULL,
  `n300` int(11) NOT NULL,
  `n100` int(11) NOT NULL,
  `n50` int(11) NOT NULL,
  `nmiss` int(11) NOT NULL,
  `ngeki` int(11) NOT NULL,
  `nkatu` int(11) NOT NULL,
  `grade` varchar(2) NOT NULL DEFAULT 'N',
  `status` tinyint(4) NOT NULL,
  `mode` tinyint(4) NOT NULL,
  `play_time` int(100) NOT NULL,
  `time_elapsed` int(11) NOT NULL,
  `client_flags` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `perfect` tinyint(1) NOT NULL,
  `mods_readable` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `server_stats`
--

CREATE TABLE `server_stats` (
  `online` int(100) NOT NULL DEFAULT '0',
  `total` int(100) NOT NULL DEFAULT '0',
  `unsupver` text NOT NULL,
  `banver` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `startups`
--

CREATE TABLE `startups` (
  `id` int(11) NOT NULL,
  `ver_major` tinyint(4) NOT NULL,
  `ver_minor` tinyint(4) NOT NULL,
  `ver_micro` tinyint(4) NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE `stats` (
  `id` int(11) NOT NULL,
  `tscore_vn_std` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_vn_taiko` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_vn_catch` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_vn_mania` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_rx_std` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_rx_taiko` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_rx_catch` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `tscore_ap_std` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_vn_std` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_vn_taiko` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_vn_catch` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_vn_mania` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_rx_std` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_rx_taiko` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_rx_catch` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `rscore_ap_std` bigint(21) UNSIGNED NOT NULL DEFAULT '0',
  `pp_vn_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_vn_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_vn_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_vn_mania` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_rx_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_rx_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_rx_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pp_ap_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_vn_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_vn_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_vn_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_vn_mania` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_rx_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_rx_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_rx_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `plays_ap_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_vn_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_vn_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_vn_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_vn_mania` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_rx_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_rx_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_rx_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playtime_ap_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `acc_vn_std` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_vn_taiko` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_vn_catch` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_vn_mania` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_rx_std` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_rx_taiko` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_rx_catch` float(6,3) NOT NULL DEFAULT '0.000',
  `acc_ap_std` float(6,3) NOT NULL DEFAULT '0.000',
  `maxcombo_vn_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_vn_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_vn_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_vn_mania` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_rx_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_rx_taiko` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_rx_catch` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxcombo_ap_std` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `rank_vn_std` int(11) DEFAULT '0',
  `rank_rx_std` int(11) DEFAULT '0',
  `rank_ap_std` int(11) DEFAULT '0',
  `rank_rx_taiko` int(11) DEFAULT '0',
  `rank_rx_catch` int(11) DEFAULT '0',
  `rank_vn_taiko` int(11) DEFAULT '0',
  `rank_vn_catch` int(11) DEFAULT '0',
  `rank_vn_mania` int(11) DEFAULT '0',
  `crank_vn_std` int(11) DEFAULT '0',
  `crank_rx_std` int(11) DEFAULT '0',
  `crank_ap_std` int(11) DEFAULT '0',
  `crank_vn_taiko` int(11) DEFAULT '0',
  `crank_vn_catch` int(11) DEFAULT '0',
  `crank_vn_mania` int(11) DEFAULT '0',
  `crank_rx_taiko` int(11) DEFAULT '0',
  `crank_rx_catch` int(11) DEFAULT '0',
  `lb_pp` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tourney_pools`
--

CREATE TABLE `tourney_pools` (
  `id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tourney_pool_maps`
--

CREATE TABLE `tourney_pool_maps` (
  `map_id` int(11) NOT NULL,
  `pool_id` int(11) NOT NULL,
  `mods` int(11) NOT NULL,
  `slot` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `safe_name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `email` varchar(254) NOT NULL,
  `priv` int(11) NOT NULL DEFAULT '1',
  `pw_bcrypt` char(60) NOT NULL,
  `country` char(2) NOT NULL DEFAULT 'xx',
  `silence_end` int(11) NOT NULL DEFAULT '0',
  `donor_end` int(11) NOT NULL DEFAULT '0',
  `creation_time` int(11) NOT NULL DEFAULT '0',
  `latest_activity` int(11) NOT NULL DEFAULT '0',
  `clan_id` int(11) NOT NULL DEFAULT '0',
  `clan_rank` tinyint(1) NOT NULL DEFAULT '0',
  `keygen` int(11) NOT NULL DEFAULT '0',
  `frozen` int(11) NOT NULL DEFAULT '0',
  `freezetime` int(11) NOT NULL DEFAULT '0',
  `verified` int(1) NOT NULL DEFAULT '0',
  `usedchange` int(11) NOT NULL DEFAULT '0',
  `verif` int(1) NOT NULL,
  `code` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_achievements`
--

CREATE TABLE `user_achievements` (
  `userid` int(11) NOT NULL,
  `achid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_hashes`
--

CREATE TABLE `user_hashes` (
  `id` int(11) NOT NULL,
  `osupath` char(32) NOT NULL,
  `adapters` char(32) NOT NULL,
  `uninstall_id` char(32) NOT NULL,
  `disk_serial` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `achievements_desc_uindex` (`desc`),
  ADD UNIQUE KEY `achievements_file_uindex` (`file`),
  ADD UNIQUE KEY `achievements_name_uindex` (`name`);

--
-- Indexes for table `channels`
--
ALTER TABLE `channels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `channels_name_uindex` (`name`);

--
-- Indexes for table `clans`
--
ALTER TABLE `clans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clans_name_uindex` (`name`),
  ADD UNIQUE KEY `clans_owner_uindex` (`owner`),
  ADD UNIQUE KEY `clans_tag_uindex` (`tag`);

--
-- Indexes for table `client_hashes`
--
ALTER TABLE `client_hashes`
  ADD PRIMARY KEY (`userid`,`osupath`,`adapters`,`uninstall_id`,`disk_serial`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discord`
--
ALTER TABLE `discord`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag` (`tag`),
  ADD UNIQUE KEY `tag_id` (`tag_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`userid`,`setid`);

--
-- Indexes for table `friendships`
--
ALTER TABLE `friendships`
  ADD PRIMARY KEY (`user1`,`user2`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `maps`
--
ALTER TABLE `maps`
  ADD PRIMARY KEY (`server`,`id`),
  ADD UNIQUE KEY `maps_id_uindex` (`id`),
  ADD UNIQUE KEY `maps_md5_uindex` (`md5`);

--
-- Indexes for table `performance_reports`
--
ALTER TABLE `performance_reports`
  ADD PRIMARY KEY (`scoreid`,`mod_mode`);

--
-- Indexes for table `pwreset`
--
ALTER TABLE `pwreset`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`userid`,`map_md5`),
  ADD UNIQUE KEY `ratings_map_md5_uindex` (`map_md5`),
  ADD UNIQUE KEY `ratings_userid_uindex` (`userid`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scores_ap`
--
ALTER TABLE `scores_ap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`,`map_md5`,`score`,`pp`,`acc`,`max_combo`,`mods`,`n300`,`n100`,`n50`,`nmiss`,`ngeki`,`nkatu`,`grade`,`status`,`mode`),
  ADD KEY `play_time` (`play_time`,`time_elapsed`,`client_flags`,`userid`,`perfect`,`mods_readable`);

--
-- Indexes for table `scores_rx`
--
ALTER TABLE `scores_rx`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`,`map_md5`,`score`,`pp`,`acc`,`max_combo`,`mods`,`n300`,`n100`,`n50`,`nmiss`,`ngeki`,`nkatu`,`grade`,`status`,`mode`),
  ADD KEY `play_time` (`play_time`,`time_elapsed`,`client_flags`,`userid`,`perfect`,`mods_readable`);

--
-- Indexes for table `scores_vn`
--
ALTER TABLE `scores_vn`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`,`map_md5`,`score`,`pp`,`acc`,`max_combo`,`mods`,`n300`,`n100`,`n50`,`nmiss`,`ngeki`,`nkatu`,`grade`,`status`,`mode`),
  ADD KEY `play_time` (`play_time`,`time_elapsed`,`client_flags`,`userid`,`perfect`,`mods_readable`);

--
-- Indexes for table `startups`
--
ALTER TABLE `startups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`,`tscore_vn_std`,`tscore_vn_taiko`,`tscore_vn_catch`,`tscore_vn_mania`,`tscore_rx_std`,`tscore_rx_taiko`,`tscore_rx_catch`,`tscore_ap_std`,`rscore_vn_std`,`rscore_vn_taiko`,`rscore_vn_catch`,`rscore_vn_mania`,`rscore_rx_std`,`rscore_rx_taiko`,`rscore_rx_catch`),
  ADD KEY `rscore_ap_std` (`rscore_ap_std`,`pp_vn_std`,`pp_vn_taiko`,`pp_vn_catch`,`pp_vn_mania`,`pp_rx_std`,`pp_rx_taiko`,`pp_rx_catch`,`pp_ap_std`,`plays_vn_std`,`plays_vn_taiko`,`plays_vn_catch`,`plays_vn_mania`,`plays_rx_std`,`plays_rx_taiko`,`plays_rx_catch`),
  ADD KEY `plays_ap_std` (`plays_ap_std`,`playtime_vn_std`,`playtime_vn_taiko`,`playtime_vn_catch`,`playtime_vn_mania`,`playtime_rx_std`,`playtime_rx_taiko`,`playtime_rx_catch`,`playtime_ap_std`,`acc_vn_std`,`acc_vn_taiko`,`acc_vn_catch`,`acc_vn_mania`,`acc_rx_std`),
  ADD KEY `acc_rx_taiko` (`acc_rx_taiko`,`acc_rx_catch`,`acc_ap_std`,`maxcombo_vn_std`,`maxcombo_vn_taiko`,`maxcombo_vn_catch`,`maxcombo_vn_mania`,`maxcombo_rx_std`,`maxcombo_rx_taiko`,`maxcombo_rx_catch`,`maxcombo_ap_std`,`rank_vn_std`,`rank_rx_std`,`rank_ap_std`,`rank_rx_taiko`),
  ADD KEY `rank_rx_catch` (`rank_rx_catch`,`rank_vn_taiko`,`rank_vn_catch`,`rank_vn_mania`,`crank_vn_std`,`crank_rx_std`,`crank_ap_std`,`crank_vn_taiko`,`crank_vn_catch`,`crank_vn_mania`,`crank_rx_taiko`,`crank_rx_catch`,`lb_pp`);

--
-- Indexes for table `tourney_pools`
--
ALTER TABLE `tourney_pools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tourney_pools_users_id_fk` (`created_by`);

--
-- Indexes for table `tourney_pool_maps`
--
ALTER TABLE `tourney_pool_maps`
  ADD PRIMARY KEY (`map_id`,`pool_id`),
  ADD KEY `tourney_pool_maps_tourney_pools_id_fk` (`pool_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_uindex` (`email`),
  ADD UNIQUE KEY `users_name_uindex` (`name`),
  ADD UNIQUE KEY `users_safe_name_uindex` (`safe_name`),
  ADD KEY `id` (`id`,`name`,`safe_name`,`email`,`priv`,`pw_bcrypt`,`country`,`silence_end`,`donor_end`,`creation_time`,`latest_activity`,`clan_id`,`clan_rank`,`keygen`,`frozen`,`freezetime`);

--
-- Indexes for table `user_achievements`
--
ALTER TABLE `user_achievements`
  ADD PRIMARY KEY (`userid`,`achid`);

--
-- Indexes for table `user_hashes`
--
ALTER TABLE `user_hashes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
--
-- AUTO_INCREMENT for table `channels`
--
ALTER TABLE `channels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `clans`
--
ALTER TABLE `clans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;
--
-- AUTO_INCREMENT for table `mail`
--
ALTER TABLE `mail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2777;
--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;
--
-- AUTO_INCREMENT for table `scores_ap`
--
ALTER TABLE `scores_ap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=451;
--
-- AUTO_INCREMENT for table `scores_rx`
--
ALTER TABLE `scores_rx`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14344;
--
-- AUTO_INCREMENT for table `scores_vn`
--
ALTER TABLE `scores_vn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17273;
--
-- AUTO_INCREMENT for table `startups`
--
ALTER TABLE `startups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=609;
--
-- AUTO_INCREMENT for table `stats`
--
ALTER TABLE `stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;
--
-- AUTO_INCREMENT for table `tourney_pools`
--
ALTER TABLE `tourney_pools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;
--
-- AUTO_INCREMENT for table `user_hashes`
--
ALTER TABLE `user_hashes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
