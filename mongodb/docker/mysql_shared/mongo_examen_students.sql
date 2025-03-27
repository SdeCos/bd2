-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:13306
-- Tiempo de generación: 27-03-2025 a las 10:09:08
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mongo_examen_students`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `classroom`
--

DROP TABLE IF EXISTS `classroom`;
CREATE TABLE IF NOT EXISTS `classroom` (
  `building` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_number` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`building`,`room_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `classroom`
--

INSERT INTO `classroom` (`building`, `room_number`, `capacity`) VALUES
('Packard', '101', '500'),
('Painter', '514', '10'),
('Taylor', '3128', '70'),
('Watson', '100', '30'),
('Watson', '120', '50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `course`
--

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `course_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dept_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `course`
--

INSERT INTO `course` (`course_id`, `title`, `dept_name`, `credits`) VALUES
('BIO-101', 'Intro. to Biology', 'Biology', '4'),
('BIO-301', 'Genetics', 'Biology', '4'),
('BIO-399', 'Computational Biology', 'Biology', '3'),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4'),
('CS-190', 'Game Design', 'Comp. Sci.', '4'),
('CS-315', 'Robotics', 'Comp. Sci.', '3'),
('CS-319', 'Image Processing', 'Comp. Sci.', '3'),
('CS-347', 'Database System Concepts', 'Comp. Sci.', '3'),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3'),
('FIN-201', 'Investment Banking', 'Finance', '3'),
('HIS-351', 'World History', 'History', '3'),
('MU-199', 'Music Video Production', 'Music', '3'),
('PHY-101', 'Physical Principles', 'Physics', '4');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `dept_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `building` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `department`
--

INSERT INTO `department` (`dept_name`, `building`, `budget`) VALUES
('Biology', 'Watson', '90000.00'),
('Comp. Sci.', 'Taylor', '100000.00'),
('Elec. Eng.', 'Taylor', '85000.00'),
('Finance', 'Painter', '120000.00'),
('History', 'Painter', '50000.00'),
('Music', 'Packard', '80000.00'),
('Physics', 'Watson', '70000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructor`
--

DROP TABLE IF EXISTS `instructor`;
CREATE TABLE IF NOT EXISTS `instructor` (
  `ID` varchar(5) NOT NULL,
  `name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `instructor`
--

INSERT INTO `instructor` (`ID`, `name`, `dept_name`, `salary`) VALUES
('63395', 'McKinnon', 'Cybernetics', '94333.99'),
('78699', 'Pingr', 'Statistics', '59303.62'),
('96895', 'Mird', 'Marketing', '119921.41'),
('4233', 'Luo', 'English', '88791.45'),
('4034', 'Murata', 'Athletics', '61387.56'),
('50885', 'Konstantinides', 'Languages', '32570.50'),
('79653', 'Levine', 'Elec. Eng.', '89805.83'),
('50330', 'Shuming', 'Physics', '108011.81'),
('80759', 'Queiroz', 'Biology', '45538.32'),
('73623', 'Sullivan', 'Elec. Eng.', '90038.09'),
('97302', 'Bertolino', 'Mech. Eng.', '51647.57'),
('57180', 'Hau', 'Accounting', '43966.29'),
('74420', 'Voronina', 'Physics', '121141.99'),
('35579', 'Soisalon-Soininen', 'Psychology', '62579.61'),
('31955', 'Moreira', 'Accounting', '71351.42'),
('37687', 'Arias', 'Statistics', '104563.38'),
('6569', 'Mingoz', 'Finance', '105311.38'),
('16807', 'Yazdi', 'Athletics', '98333.65'),
('14365', 'Lembr', 'Accounting', '32241.56'),
('90643', 'Choll', 'Statistics', '57807.09'),
('81991', 'Valtchev', 'Biology', '77036.18'),
('95030', 'Arinb', 'Statistics', '54805.11'),
('15347', 'Bawa', 'Athletics', '72140.88'),
('74426', 'Kenje', 'Marketing', '106554.73'),
('42782', 'Vicentino', 'Elec. Eng.', '34272.67'),
('58558', 'Dusserre', 'Marketing', '66143.25'),
('63287', 'Jaekel', 'Athletics', '103146.87'),
('59795', 'Desyl', 'Languages', '48803.38'),
('22591', 'DAgostino', 'Psychology', '59706.49'),
('48570', 'Sarkar', 'Pol. Sci.', '87549.80'),
('79081', 'Ullman ', 'Accounting', '47307.10'),
('52647', 'Bancilhon', 'Pol. Sci.', '87958.01'),
('25946', 'Liley', 'Languages', '90891.69'),
('36897', 'Morris', 'Marketing', '43770.36'),
('72553', 'Yin', 'English', '46397.59'),
('3199', 'Gustafsson', 'Elec. Eng.', '82534.37'),
('34175', 'Bondi', 'Comp. Sci.', '115469.11'),
('48507', 'Lent', 'Mech. Eng.', '107978.47'),
('65931', 'Pimenta', 'Cybernetics', '79866.95'),
('3335', 'Bourrier', 'Comp. Sci.', '80797.83'),
('64871', 'Gutierrez', 'Statistics', '45310.53'),
('95709', 'Sakurai', 'English', '118143.98'),
('43779', 'Romero', 'Astronomy', '79070.08'),
('77346', 'Mahmoud', 'Geology', '99382.59'),
('28097', 'Kean', 'English', '35023.18'),
('90376', 'Bietzk', 'Cybernetics', '117836.50'),
('28400', 'Atanassov', 'Statistics', '84982.92'),
('41930', 'Tung', 'Athletics', '50482.03'),
('19368', 'Wieland', 'Pol. Sci.', '124651.41'),
('99052', 'Dale', 'Cybernetics', '93348.83'),
('98763', 'Lázaro', 'INFORMATICA', '200.00'),
('10101', 'Srinivasan', 'Comp. Sci.', '65000.00'),
('12121', 'Wu', 'Finance', '90000.00'),
('15151', 'Mozart', 'Music', '40000.00'),
('22222', 'Einstein', 'Physics', '95000.00'),
('32343', 'El Said', 'History', '60000.00'),
('33456', 'Gold', 'Physics', '87000.00'),
('45565', 'Katz', 'Comp. Sci.', '75000.00'),
('58583', 'Califieri', 'History', '62000.00'),
('76543', 'Singh', 'Finance', '80000.00'),
('76766', 'Crick', 'Biology', '72000.00'),
('83821', 'Brandt', 'Comp. Sci.', '92000.00'),
('98345', 'Kim', 'Elec. Eng.', '80000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `json_all`
--

DROP TABLE IF EXISTS `json_all`;
CREATE TABLE IF NOT EXISTS `json_all` (
  `id` int NOT NULL AUTO_INCREMENT,
  `json_register` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `json_all`
--

INSERT INTO `json_all` (`id`, `json_register`) VALUES
(1, '[{\"budget\": 90000.0, \"building\": \"Watson\", \"classroom\": \"[{\\\"building\\\": \\\"Watson\\\", \\\"capacity\\\": 30, \\\"room_number\\\": \\\"100\\\"}, {\\\"building\\\": \\\"Watson\\\", \\\"capacity\\\": 50, \\\"room_number\\\": \\\"120\\\"}]\", \"dept_name\": \"Biology\"}, {\"budget\": 100000.0, \"building\": \"Taylor\", \"classroom\": \"[{\\\"building\\\": \\\"Taylor\\\", \\\"capacity\\\": 70, \\\"room_number\\\": \\\"3128\\\"}]\", \"dept_name\": \"Comp. Sci.\"}, {\"budget\": 85000.0, \"building\": \"Taylor\", \"classroom\": \"[{\\\"building\\\": \\\"Taylor\\\", \\\"capacity\\\": 70, \\\"room_number\\\": \\\"3128\\\"}]\", \"dept_name\": \"Elec. Eng.\"}, {\"budget\": 120000.0, \"building\": \"Painter\", \"classroom\": \"[{\\\"building\\\": \\\"Painter\\\", \\\"capacity\\\": 10, \\\"room_number\\\": \\\"514\\\"}]\", \"dept_name\": \"Finance\"}, {\"budget\": 50000.0, \"building\": \"Painter\", \"classroom\": \"[{\\\"building\\\": \\\"Painter\\\", \\\"capacity\\\": 10, \\\"room_number\\\": \\\"514\\\"}]\", \"dept_name\": \"History\"}, {\"budget\": 80000.0, \"building\": \"Packard\", \"classroom\": \"[{\\\"building\\\": \\\"Packard\\\", \\\"capacity\\\": 500, \\\"room_number\\\": \\\"101\\\"}]\", \"dept_name\": \"Music\"}, {\"budget\": 70000.0, \"building\": \"Watson\", \"classroom\": \"[{\\\"building\\\": \\\"Watson\\\", \\\"capacity\\\": 30, \\\"room_number\\\": \\\"100\\\"}, {\\\"building\\\": \\\"Watson\\\", \\\"capacity\\\": 50, \\\"room_number\\\": \\\"120\\\"}]\", \"dept_name\": \"Physics\"}]'),
(3, '[{\"ID\": \"00128\", \"name\": \"Zhang\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-347\\\"}]\", \"dept_name\": \"Comp. Sci.\"}, {\"ID\": \"12345\", \"name\": \"Shankar\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2017, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-190\\\"}, {\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-315\\\"}, {\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-347\\\"}]\", \"dept_name\": \"Comp. Sci.\"}, {\"ID\": \"19991\", \"name\": \"Brandt\", \"takes\": \"[{\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"HIS-351\\\"}]\", \"dept_name\": \"History\"}, {\"ID\": \"23121\", \"name\": \"Chavez\", \"takes\": \"[{\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"FIN-201\\\"}]\", \"dept_name\": \"Finance\"}, {\"ID\": \"44553\", \"name\": \"Peltier\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"PHY-101\\\"}]\", \"dept_name\": \"Physics\"}, {\"ID\": \"45678\", \"name\": \"Levy\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-319\\\"}]\", \"dept_name\": \"Physics\"}, {\"ID\": \"54321\", \"name\": \"Williams\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2017, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-190\\\"}]\", \"dept_name\": \"Comp. Sci.\"}, {\"ID\": \"55739\", \"name\": \"Sanchez\", \"takes\": \"[{\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"MU-199\\\"}]\", \"dept_name\": \"Music\"}, {\"ID\": \"70557\", \"name\": \"Snow\", \"takes\": \"[]\", \"dept_name\": \"Physics\"}, {\"ID\": \"76543\", \"name\": \"Brown\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-319\\\"}]\", \"dept_name\": \"Comp. Sci.\"}, {\"ID\": \"76653\", \"name\": \"Aoi\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"EE-181\\\"}]\", \"dept_name\": \"Elec. Eng.\"}, {\"ID\": \"98765\", \"name\": \"Bourikas\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Fall\\\", \\\"course_id\\\": \\\"CS-101\\\"}, {\\\"year\\\": 2018, \\\"semester\\\": \\\"Spring\\\", \\\"course_id\\\": \\\"CS-315\\\"}]\", \"dept_name\": \"Elec. Eng.\"}, {\"ID\": \"98988\", \"name\": \"Tanaka\", \"takes\": \"[{\\\"year\\\": 2017, \\\"semester\\\": \\\"Summer\\\", \\\"course_id\\\": \\\"BIO-101\\\"}, {\\\"year\\\": 2018, \\\"semester\\\": \\\"Summer\\\", \\\"course_id\\\": \\\"BIO-301\\\"}]\", \"dept_name\": \"Biology\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `course_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sec_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `building` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_number` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`course_id`,`sec_id`,`semester`,`year`),
  KEY `building` (`building`,`room_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `section`
--

INSERT INTO `section` (`course_id`, `sec_id`, `semester`, `year`, `building`, `room_number`) VALUES
('BIO-101', '1', 'Summer', '2017', 'Painter', '514'),
('BIO-301', '1', 'Summer', '2018', 'Painter', '514'),
('CS-101', '1', 'Fall', '2017', 'Packard', '101'),
('CS-101', '1', 'Spring', '2018', 'Packard', '101'),
('CS-190', '1', 'Spring', '2017', 'Taylor', '3128'),
('CS-190', '2', 'Spring', '2017', 'Taylor', '3128'),
('CS-315', '1', 'Spring', '2018', 'Watson', '120'),
('CS-319', '1', 'Spring', '2018', 'Watson', '100'),
('CS-319', '2', 'Spring', '2018', 'Taylor', '3128'),
('CS-347', '1', 'Fall', '2017', 'Taylor', '3128'),
('EE-181', '1', 'Spring', '2017', 'Taylor', '3128'),
('FIN-201', '1', 'Spring', '2018', 'Packard', '101'),
('HIS-351', '1', 'Spring', '2018', 'Painter', '514'),
('MU-199', '1', 'Spring', '2018', 'Packard', '101'),
('PHY-101', '1', 'Fall', '2017', 'Watson', '100'),
('BIO-101', '1', 'Summer', '2019', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tot_cred` decimal(3,0) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `student`
--

INSERT INTO `student` (`ID`, `name`, `dept_name`, `tot_cred`) VALUES
('00128', 'Zhang', 'Comp. Sci.', '102'),
('12345', 'Shankar', 'Comp. Sci.', '32'),
('19991', 'Brandt', 'History', '80'),
('23121', 'Chavez', 'Finance', '110'),
('44553', 'Peltier', 'Physics', '56'),
('45678', 'Levy', 'Physics', '46'),
('54321', 'Williams', 'Comp. Sci.', '54'),
('55739', 'Sanchez', 'Music', '38'),
('70557', 'Snow', 'Physics', '0'),
('76543', 'Brown', 'Comp. Sci.', '58'),
('76653', 'Aoi', 'Elec. Eng.', '60'),
('98765', 'Bourikas', 'Elec. Eng.', '98'),
('98988', 'Tanaka', 'Biology', '120');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `takes`
--

DROP TABLE IF EXISTS `takes`;
CREATE TABLE IF NOT EXISTS `takes` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sec_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` decimal(4,0) NOT NULL,
  PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `takes`
--

INSERT INTO `takes` (`ID`, `course_id`, `sec_id`, `semester`, `year`) VALUES
('00128', 'CS-101', '1', 'Fall', '2017'),
('00128', 'CS-347', '1', 'Fall', '2017'),
('12345', 'CS-101', '1', 'Fall', '2017'),
('12345', 'CS-190', '2', 'Spring', '2017'),
('12345', 'CS-315', '1', 'Spring', '2018'),
('12345', 'CS-347', '1', 'Fall', '2017'),
('19991', 'HIS-351', '1', 'Spring', '2018'),
('23121', 'FIN-201', '1', 'Spring', '2018'),
('44553', 'PHY-101', '1', 'Fall', '2017'),
('45678', 'CS-101', '1', 'Fall', '2017'),
('45678', 'CS-101', '1', 'Spring', '2018'),
('45678', 'CS-319', '1', 'Spring', '2018'),
('54321', 'CS-101', '1', 'Fall', '2017'),
('54321', 'CS-190', '2', 'Spring', '2017'),
('55739', 'MU-199', '1', 'Spring', '2018'),
('76543', 'CS-101', '1', 'Fall', '2017'),
('76543', 'CS-319', '2', 'Spring', '2018'),
('76653', 'EE-181', '1', 'Spring', '2017'),
('98765', 'CS-101', '1', 'Fall', '2017'),
('98765', 'CS-315', '1', 'Spring', '2018'),
('98988', 'BIO-101', '1', 'Summer', '2017'),
('98988', 'BIO-301', '1', 'Summer', '2018');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `teaches`
--

DROP TABLE IF EXISTS `teaches`;
CREATE TABLE IF NOT EXISTS `teaches` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sec_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` decimal(4,0) NOT NULL,
  PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `teaches`
--

INSERT INTO `teaches` (`ID`, `course_id`, `sec_id`, `semester`, `year`) VALUES
('10101', 'CS_101', '1', 'Fall', '2017'),
('10101', 'CS-315', '1', 'Spring', '2018'),
('10101', 'CS-347', '1', 'Fall', '2017'),
('12121', 'FIN-201', '1', 'Spring', '2018'),
('15151', 'MU-199', '1', 'Spring', '2018'),
('22222', 'PHY-101', '1', 'Fall', '2017'),
('32343', 'HIS-351', '1', 'Spring', '2018'),
('45565', 'CS-101', '1', 'Spring', '2018'),
('45565', 'CS-319', '1', 'Spring', '2018'),
('76766', 'BIO-101', '1', 'Summer', '2017'),
('76766', 'BIO-301', '1', 'Summer', '2018'),
('83821', 'CS-190', '1', 'Spring', '2017'),
('83821', 'CS-190', '2', 'Spring', '2017'),
('83821', 'CS-319', '2', 'Spring', '2018'),
('98345', 'EE-181', '1', 'Spring', '2017');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
