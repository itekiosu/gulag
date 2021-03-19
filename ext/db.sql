SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

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

--
-- Dumping data for table `server_stats`
--

INSERT INTO `server_stats` (`online`, `total`, `unsupver`, `banver`) VALUES
(0, 0, '', '');

CREATE TABLE `tourney_pool_maps` (
  `map_id` int(11) NOT NULL,
  `pool_id` int(11) NOT NULL,
  `mods` int(11) NOT NULL,
  `slot` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `tourney_pools`
--

CREATE TABLE `tourney_pools` (
  `id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

--
-- Dumping data for table `achievements`
--

INSERT INTO `achievements` (`id`, `file`, `name`, `desc`, `cond`, `mode`, `custom`) VALUES
(1, 'osu-skill-pass-1', 'Rising Star', 'Can\'t go forward without the first steps.', '2 >= score.sr > 1', 0, 0),
(2, 'osu-skill-pass-2', 'Constellation Prize', 'Definitely not a consolation prize. Now things start getting hard!', '3 >= score.sr > 2', 0, 0),
(3, 'osu-skill-pass-3', 'Building Confidence', 'Oh, you\'ve SO got this.', '(score.mods & 259 == 0) and 4 >= score.sr > 3', 0, 0),
(4, 'osu-skill-pass-4', 'Insanity Approaches', 'You\'re not twitching, you\'re just ready.', '5 >= score.sr > 4', 0, 0),
(5, 'osu-skill-pass-5', 'These Clarion Skies', 'Everything seems so clear now.', '6 >= score.sr > 5', 0, 0),
(6, 'osu-skill-pass-6', 'Above and Beyond', 'A cut above the rest.', '7 >= score.sr > 6', 0, 0),
(7, 'osu-skill-pass-7', 'Supremacy', 'All marvel before your prowess.', '8 >= score.sr > 7', 0, 0),
(8, 'osu-skill-pass-8', 'Absolution', 'My god, you\'re full of stars!', '9 >= score.sr > 8', 0, 0),
(9, 'osu-skill-pass-9', 'Event Horizon', 'No force dares to pull you under.', '10 >= score.sr > 9', 0, 0),
(10, 'osu-skill-pass-10', 'Phantasm', 'Fevered is your passion, extraordinary is your skill.', '11 >= score.sr > 10', 0, 0),
(11, 'osu-skill-fc-1', 'Totality', 'All the notes. Every single one.', 'score.perfect and 2 >= score.sr > 1', 0, 0),
(12, 'osu-skill-fc-2', 'Business As Usual', 'Two to go, please.', 'score.perfect and 3 >= score.sr > 2', 0, 0),
(13, 'osu-skill-fc-3', 'Building Steam', 'Hey, this isn\'t so bad.', 'score.perfect and 4 >= score.sr > 3', 0, 0),
(14, 'osu-skill-fc-4', 'Moving Forward', 'Bet you feel good about that.', 'score.perfect and 5 >= score.sr > 4', 0, 0),
(15, 'osu-skill-fc-5', 'Paradigm Shift', 'Surprisingly difficult.', 'score.perfect and 6 >= score.sr > 5', 0, 0),
(16, 'osu-skill-fc-6', 'Anguish Quelled', 'Don\'t choke.', 'score.perfect and 7 >= score.sr > 6', 0, 0),
(17, 'osu-skill-fc-7', 'Never Give Up', 'Excellence is its own reward.', 'score.perfect and 8 >= score.sr > 7', 0, 0),
(18, 'osu-skill-fc-8', 'Aberration', 'They said it couldn\'t be done. They were wrong.', 'score.perfect and 9 >= score.sr > 8', 0, 0),
(19, 'osu-skill-fc-9', 'Chosen', 'Reign among the Prometheans, where you belong.', 'score.perfect and 10 >= score.sr > 9', 0, 0),
(20, 'osu-skill-fc-10', 'Unfathomable', 'You have no equal.', 'score.perfect and 11 >= score.sr > 10', 0, 0),
(21, 'osu-combo-500', '500 Combo', '500 big ones! You\'re moving up in the world!', 'score.max_combo >= 500', 0, 0),
(22, 'osu-combo-750', '750 Combo', '750 notes back to back? Woah.', 'score.max_combo >= 750', 0, 0),
(23, 'osu-combo-1000', '1000 Combo', 'A thousand reasons why you rock at this game.', 'score.max_combo >= 1000', 0, 0),
(24, 'osu-combo-2000', '2000 Combo', 'Nothing can stop you now.', 'score.max_combo >= 2000', 0, 0),
(25, 'taiko-skill-pass-1', 'My First Don', 'Marching to the beat of your own drum. Literally.', '2 >= score.sr > 1', 1, 0),
(26, 'taiko-skill-pass-2', 'Katsu Katsu Katsu', 'Hora! Izuko!', '3 >= score.sr > 2', 1, 0),
(27, 'taiko-skill-pass-3', 'Not Even Trying', 'Muzukashii? Not even.', '4 >= score.sr > 3', 1, 0),
(28, 'taiko-skill-pass-4', 'Face Your Demons', 'The first trials are now behind you, but are you a match for the Oni?', '5 >= score.sr > 4', 1, 0),
(29, 'taiko-skill-pass-5', 'The Demon Within', 'No rest for the wicked.', '6 >= score.sr > 5', 1, 0),
(30, 'taiko-skill-pass-6', 'Drumbreaker', 'Too strong.', '7 >= score.sr > 6', 1, 0),
(31, 'taiko-skill-pass-7', 'The Godfather', 'You are the Don of Dons.', '8 >= score.sr > 7', 1, 0),
(32, 'taiko-skill-pass-8', 'Rhythm Incarnate', 'Feel the beat. Become the beat.', '9 >= score.sr > 8', 1, 0),
(33, 'taiko-skill-fc-1', 'Keeping Time', 'Don, then katsu. Don, then katsu..', 'score.perfect and 2 >= score.sr > 1', 1, 0),
(34, 'taiko-skill-fc-2', 'To Your Own Beat', 'Straight and steady.', 'score.perfect and 3 >= score.sr > 2', 1, 0),
(35, 'taiko-skill-fc-3', 'Big Drums', 'Bigger scores to match.', 'score.perfect and 4 >= score.sr > 3', 1, 0),
(36, 'taiko-skill-fc-4', 'Adversity Overcome', 'Difficult? Not for you.', 'score.perfect and 5 >= score.sr > 4', 1, 0),
(37, 'taiko-skill-fc-5', 'Demonslayer', 'An Oni felled forevermore.', 'score.perfect and 6 >= score.sr > 5', 1, 0),
(38, 'taiko-skill-fc-6', 'Rhythm\'s Call', 'Heralding true skill.', 'score.perfect and 7 >= score.sr > 6', 1, 0),
(39, 'taiko-skill-fc-7', 'Time Everlasting', 'Not a single beat escapes you.', 'score.perfect and 8 >= score.sr > 7', 1, 0),
(40, 'taiko-skill-fc-8', 'The Drummer\'s Throne', 'Percussive brilliance befitting royalty alone.', 'score.perfect and 9 >= score.sr > 8', 1, 0),
(41, 'fruits-skill-pass-1', 'A Slice Of Life', 'Hey, this fruit catching business isn\'t bad.', '2 >= score.sr > 1', 2, 0),
(42, 'fruits-skill-pass-2', 'Dashing Ever Forward', 'Fast is how you do it.', '3 >= score.sr > 2', 2, 0),
(43, 'fruits-skill-pass-3', 'Zesty Disposition', 'No scurvy for you, not with that much fruit.', '4 >= score.sr > 3', 2, 0),
(44, 'fruits-skill-pass-4', 'Hyperdash ON!', 'Time and distance is no obstacle to you.', '5 >= score.sr > 4', 2, 0),
(45, 'fruits-skill-pass-5', 'It\'s Raining Fruit', 'And you can catch them all.', '6 >= score.sr > 5', 2, 0),
(46, 'fruits-skill-pass-6', 'Fruit Ninja', 'Legendary techniques.', '7 >= score.sr > 6', 2, 0),
(47, 'fruits-skill-pass-7', 'Dreamcatcher', 'No fruit, only dreams now.', '8 >= score.sr > 7', 2, 0),
(48, 'fruits-skill-pass-8', 'Lord of the Catch', 'Your kingdom kneels before you.', '9 >= score.sr > 8', 2, 0),
(49, 'fruits-skill-fc-1', 'Sweet And Sour', 'Apples and oranges, literally.', 'score.perfect and 2 >= score.sr > 1', 2, 0),
(50, 'fruits-skill-fc-2', 'Reaching The Core', 'The seeds of future success.', 'score.perfect and 3 >= score.sr > 2', 2, 0),
(51, 'fruits-skill-fc-3', 'Clean Platter', 'Clean only of failure. It is completely full, otherwise.', 'score.perfect and 4 >= score.sr > 3', 2, 0),
(52, 'fruits-skill-fc-4', 'Between The Rain', 'No umbrella needed.', 'score.perfect and 5 >= score.sr > 4', 2, 0),
(53, 'fruits-skill-fc-5', 'Addicted', 'That was an overdose?', 'score.perfect and 6 >= score.sr > 5', 2, 0),
(54, 'fruits-skill-fc-6', 'Quickening', 'A dash above normal limits.', 'score.perfect and 7 >= score.sr > 6', 2, 0),
(55, 'fruits-skill-fc-7', 'Supersonic', 'Faster than is reasonably necessary.', 'score.perfect and 8 >= score.sr > 7', 2, 0),
(56, 'fruits-skill-fc-8', 'Dashing Scarlet', 'Speed beyond mortal reckoning.', 'score.perfect and 9 >= score.sr > 8', 2, 0),
(57, 'mania-skill-pass-1', 'First Steps', 'It isn\'t 9-to-5, but 1-to-9. Keys, that is.', '2 >= score.sr > 1', 3, 0),
(58, 'mania-skill-pass-2', 'No Normal Player', 'Not anymore, at least.', '3 >= score.sr > 2', 3, 0),
(59, 'mania-skill-pass-3', 'Impulse Drive', 'Not quite hyperspeed, but getting close.', '4 >= score.sr > 3', 3, 0),
(60, 'mania-skill-pass-4', 'Hyperspeed', 'Woah.', '5 >= score.sr > 4', 3, 0),
(61, 'mania-skill-pass-5', 'Ever Onwards', 'Another challenge is just around the corner.', '6 >= score.sr > 5', 3, 0),
(62, 'mania-skill-pass-6', 'Another Surpassed', 'Is there no limit to your skills?', '7 >= score.sr > 6', 3, 0),
(63, 'mania-skill-pass-7', 'Extra Credit', 'See me after class.', '8 >= score.sr > 7', 3, 0),
(64, 'mania-skill-pass-8', 'Maniac', 'There\'s just no stopping you.', '9 >= score.sr > 8', 3, 0),
(65, 'mania-skill-fc-1', 'Keystruck', 'The beginning of a new story', 'score.perfect and 2 >= score.sr > 1', 3, 0),
(66, 'mania-skill-fc-2', 'Keying In', 'Finding your groove.', 'score.perfect and 3 >= score.sr > 2', 3, 0),
(67, 'mania-skill-fc-3', 'Hyperflow', 'You can *feel* the rhythm.', 'score.perfect and 4 >= score.sr > 3', 3, 0),
(68, 'mania-skill-fc-4', 'Breakthrough', 'Many skills mastered, rolled into one.', 'score.perfect and 5 >= score.sr > 4', 3, 0),
(69, 'mania-skill-fc-5', 'Everything Extra', 'Giving your all is giving everything you have.', 'score.perfect and 6 >= score.sr > 5', 3, 0),
(70, 'mania-skill-fc-6', 'Level Breaker', 'Finesse beyond reason', 'score.perfect and 7 >= score.sr > 6', 3, 0),
(71, 'mania-skill-fc-7', 'Step Up', 'A precipice rarely seen.', 'score.perfect and 8 >= score.sr > 7', 3, 0),
(72, 'mania-skill-fc-8', 'Behind The Veil', 'Supernatural!', 'score.perfect and 9 >= score.sr > 8', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `beta_keys`
--

CREATE TABLE `beta_keys` (
  `beta_key` varchar(20) NOT NULL,
  `used` int(1) NOT NULL DEFAULT '0',
  `generated_by` varchar(200) NOT NULL,
  `user` varchar(200) DEFAULT NULL,
  `for_id` bigint(255) NOT NULL
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

--
-- Dumping data for table `channels`
--

INSERT INTO `channels` (`id`, `name`, `topic`, `read_priv`, `write_priv`, `auto_join`) VALUES
(1, '#osu', 'General discussion.', 1, 2, 1),
(2, '#announce', 'Exemplary performance and public announcements.', 1, 24576, 1),
(3, '#lobby', 'Multiplayer lobby discussion room.', 1, 2, 0),
(4, '#supporter', 'General discussion for supporters.', 48, 48, 0),
(5, '#staff', 'General discussion for staff members.', 28672, 28672, 1),
(6, '#admin', 'General discussion for administrators.', 24576, 24576, 1),
(7, '#dev', 'General discussion for developers.', 16384, 16384, 1);

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
  `ip` varchar(32) NOT NULL,
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
  `code` char(5) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `safe_name`, `email`, `priv`, `pw_bcrypt`, `country`, `silence_end`, `donor_end`, `creation_time`, `latest_activity`, `clan_id`, `clan_rank`, `keygen`, `frozen`, `freezetime`, `verified`, `usedchange`, `verif`, `code`) VALUES
(1, 'Ruji', 'ruji', 'contact@iteki.pw', 1, '_______________________my_cool_bcrypt_______________________', 'sl', 0, 0, 1611774412, 1611774412, 0, 0, 0, 0, 0, 0, 0, 1, '');

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
-- Indexes for table `beta_keys`
--
ALTER TABLE `beta_keys`
  ADD PRIMARY KEY (`beta_key`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
--
-- AUTO_INCREMENT for table `channels`
--
ALTER TABLE `channels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `clans`
--
ALTER TABLE `clans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mail`
--
ALTER TABLE `mail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `scores_ap`
--
ALTER TABLE `scores_ap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `scores_rx`
--
ALTER TABLE `scores_rx`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `scores_vn`
--
ALTER TABLE `scores_vn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `startups`
--
ALTER TABLE `startups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `stats`
--
ALTER TABLE `stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tourney_pools`
--
ALTER TABLE `tourney_pools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user_hashes`
--
ALTER TABLE `user_hashes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
