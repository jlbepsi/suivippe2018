-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 192.168.100.19
-- Généré le :  ven. 18 jan. 2019 à 10:13
-- Version du serveur :  10.1.26-MariaDB-0+deb9u1
-- Version de PHP :  7.2.10-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `suivippe`
--

DELIMITER $$
--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `addStageIntitule` (`pIdStage` INT, `pIntitule` VARCHAR(150)) RETURNS INT(11) BEGIN

SET @newid = 0;

SELECT IFNULL(MAX(idIntitule), 0) INTO @newid
FROM stageintitule
WHERE idStage = pIdStage;
set @newid = @newid +1;

INSERT INTO stageintitule(idStage, idIntitule, intitule)
VALUES (pIdStage, @newid, pIntitule);

RETURN @newid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `activite`
--

CREATE TABLE `activite` (
  `id` int(11) NOT NULL,
  `idDomaine` int(11) NOT NULL,
  `nomenclature` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `lngutile` int(11) NOT NULL,
  `libelle` varchar(250) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `activite`
--

INSERT INTO `activite` (`id`, `idDomaine`, `nomenclature`, `lngutile`, `libelle`) VALUES
(1, 1, 'A1.1.1', 54, 'Analyse du cahier des charges d\'un service à produire'),
(2, 1, 'A1.1.2', 47, 'Étude de l\'impact de l\'intégration d\'un service sur le système informatique'),
(3, 1, 'A1.1.3', 47, 'Étude des exigences liées à la qualité attendue d\'un service'),
(4, 2, 'A1.2.1', 49, 'Élaboration et présentation d\'un dossier de choix de solution technique'),
(5, 2, 'A1.2.2', 54, 'Rédaction des spécifications techniques de la solution retenue (adaptation d\'une solution existante ou réalisation d\'une nouvelle solution'),
(6, 2, 'A1.2.3', 57, 'Évaluation des risques liés à l\'utilisation d\'un service'),
(7, 2, 'A1.2.4', 51, 'Détermination des tests nécessaires à la validation d\'un service'),
(8, 2, 'A1.2.5', 37, 'Définition des niveaux d\'habilitation associés à un service'),
(9, 3, 'A1.3.1', 49, 'Test d\'intégration et d\'acceptation d\'un service'),
(10, 3, 'A1.3.2', 51, 'Définition des éléments nécessaires à la continuité d\'un service'),
(11, 3, 'A1.3.3', 56, 'Accompagnement de la mise en place d\'un nouveau service'),
(12, 3, 'A1.3.4', 25, 'Déploiement d\'un service'),
(13, 4, 'A1.4.1', 25, 'Participation à un projet'),
(14, 4, 'A1.4.2', 47, 'Évaluation des indicateurs de suivi d\'un projet et justification des écarts'),
(15, 4, 'A1.4.3', 22, 'Gestion des ressources'),
(16, 5, 'A2.1.1', 53, 'Accompagnement des utilisateurs dans la prise en main d\'un service'),
(17, 5, 'A2.1.2', 50, 'Évaluation et maintien de la qualité d\'un service'),
(18, 6, 'A2.2.1', 32, 'Suivi et résolution d\'incidents'),
(19, 6, 'A2.2.2', 45, 'Suivi et réponse à des demandes d\'assistance'),
(20, 6, 'A2.2.3', 37, 'Réponse à une interruption de service'),
(21, 7, 'A2.3.1', 58, 'Identification, qualification et évaluation d\'un problème'),
(22, 7, 'A2.3.2', 41, 'Proposition d\'amélioration d\'un service'),
(23, 8, 'A3.1.1', 45, 'Proposition d\'une solution d\'infrastructure'),
(24, 8, 'A3.1.2', 58, 'Maquettage et prototypage d\'une solution d\'infrastructure'),
(25, 8, 'A3.1.3', 48, 'Prise en compte du niveau de sécurité nécessaire à une infrastructure'),
(26, 9, 'A3.2.1', 57, 'Installation et configuration d\'éléments d\'infrastructure'),
(27, 9, 'A3.2.2', 49, 'Remplacement ou mise à jour d\'éléments défectueux ou obsolètes'),
(28, 9, 'A3.2.3', 41, 'Mise à jour de la documentation technique d\'une solution d\'infrastructure'),
(29, 10, 'A3.3.1', 50, 'Administration sur site ou à distance des éléments d\'un réseau, de serveurs, de services et d\'équipements terminaux'),
(30, 10, 'A3.3.2', 59, 'Planification des sauvegardes et gestion des restaurations'),
(31, 10, 'A3.3.3', 42, 'Gestion des identités et des habilitations'),
(32, 10, 'A3.3.4', 43, 'Automatisation des tâches d\'administration'),
(33, 10, 'A3.3.5', 51, 'Gestion des indicateurs et des fichiers d\'activité'),
(34, 11, 'A4.1.1', 39, 'Proposition d\'une solution applicative'),
(35, 11, 'A4.1.2', 51, 'Conception ou adaptation de l\'interface utilisateur d\'une solution applicative'),
(36, 11, 'A4.1.3', 47, 'Conception ou adaptation d\'une base de données'),
(37, 11, 'A4.1.4', 59, 'Définition des caractéristiques d\'une solution applicative'),
(38, 11, 'A4.1.5', 35, 'Prototypage de composants logiciels'),
(39, 11, 'A4.1.6', 53, 'Gestion d\'environnements de développement et de test'),
(40, 11, 'A4.1.7', 54, 'Développement, utilisation ou adaptation de composants logiciels'),
(41, 11, 'A4.1.8', 49, 'Réalisation des tests nécessaires à la validation d\'éléments adaptés ou développés'),
(42, 11, 'A4.1.9', 40, 'Rédaction d\'une documentation technique'),
(43, 11, 'A4.1.1', 45, 'Rédaction d\'une documentation d\'utilisation'),
(44, 12, 'A4.2.1', 44, 'Analyse et correction d\'un dysfonctionnement, d\'un problème de qualité de service ou de sécurité'),
(45, 12, 'A4.2.2', 52, 'Adaptation d\'une solution applicative aux évolutions de ses composants'),
(46, 12, 'A4.2.3', 57, 'Réalisation des tests nécessaires à la mise en production d\'éléments mis à jour'),
(47, 12, 'A4.2.4', 42, 'Mise à jour d\'une documentation technique'),
(48, 13, 'A5.1.1', 45, 'Mise en place d\'une gestion de configuration'),
(49, 13, 'A5.1.2', 44, 'Recueil d\'informations sur une configuration et ses éléments'),
(50, 13, 'A5.1.3', 45, 'Suivi d\'une configuration et de ses éléments'),
(51, 13, 'A5.1.4', 43, 'Étude de propositions de contrat de service (client, fournisseur);'),
(52, 13, 'A5.1.5', 40, 'Évaluation d\'un élément de configuration ou d\'une configuratio'),
(53, 13, 'A5.1.6', 44, 'Évaluation d\'un investissement informatique'),
(54, 14, 'A5.2.1', 50, 'Exploitation des référentiels, normes et standards adoptés par le prestataire informatique'),
(55, 14, 'A5.2.2', 20, 'Veille technologique'),
(56, 14, 'A5.2.3', 37, 'Repérage des compléments de formation ou d\'auto-formation utiles à l\'acquisition de nouvelles compétences'),
(57, 14, 'A5.2.4', 51, 'Étude d‘une technologie, d\'un composant, d\'un outil ou d\'une méthode');

-- --------------------------------------------------------

--
-- Structure de la table `activitecitee`
--

CREATE TABLE `activitecitee` (
  `idActivite` int(11) NOT NULL,
  `refSituation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `activitecitee`
--

INSERT INTO `activitecitee` (`idActivite`, `refSituation`) VALUES
(1, 884),
(1, 887),
(1, 888),
(1, 889),
(1, 890),
(1, 892),
(1, 895),
(1, 896),
(1, 897),
(1, 898),
(1, 899),
(1, 900),
(1, 904),
(1, 905),
(1, 906),
(1, 912),
(1, 913),
(1, 914),
(1, 918),
(1, 919),
(1, 920),
(1, 921),
(1, 922),
(1, 923),
(1, 924),
(1, 925),
(1, 926),
(1, 928),
(1, 929),
(1, 930),
(1, 932),
(1, 935),
(1, 937),
(1, 938),
(1, 939),
(1, 940),
(1, 941),
(1, 942),
(1, 943),
(1, 944),
(1, 945),
(1, 946),
(1, 948),
(1, 949),
(1, 950),
(1, 951),
(1, 952),
(1, 953),
(1, 954),
(1, 955),
(1, 956),
(1, 957),
(1, 958),
(1, 960),
(1, 961),
(1, 962),
(1, 963),
(1, 968),
(1, 969),
(1, 970),
(1, 974),
(1, 977),
(1, 978),
(1, 979),
(1, 980),
(1, 981),
(1, 983),
(1, 986),
(1, 989),
(1, 990),
(1, 991),
(1, 992),
(1, 993),
(1, 994),
(1, 996),
(1, 998),
(1, 999),
(1, 1000),
(1, 1001),
(1, 1003),
(1, 1004),
(2, 888),
(2, 889),
(2, 890),
(2, 891),
(2, 896),
(2, 900),
(2, 906),
(2, 907),
(2, 914),
(2, 918),
(2, 921),
(2, 922),
(2, 924),
(2, 929),
(2, 934),
(2, 946),
(2, 950),
(2, 953),
(2, 955),
(2, 956),
(2, 957),
(2, 958),
(2, 965),
(2, 966),
(2, 967),
(2, 968),
(2, 969),
(2, 989),
(2, 994),
(2, 996),
(2, 998),
(3, 885),
(3, 889),
(3, 890),
(3, 895),
(3, 896),
(3, 897),
(3, 898),
(3, 899),
(3, 900),
(3, 904),
(3, 905),
(3, 906),
(3, 907),
(3, 912),
(3, 913),
(3, 914),
(3, 918),
(3, 919),
(3, 920),
(3, 921),
(3, 922),
(3, 923),
(3, 924),
(3, 925),
(3, 927),
(3, 928),
(3, 931),
(3, 932),
(3, 933),
(3, 938),
(3, 939),
(3, 940),
(3, 941),
(3, 942),
(3, 943),
(3, 944),
(3, 945),
(3, 946),
(3, 949),
(3, 950),
(3, 951),
(3, 952),
(3, 953),
(3, 954),
(3, 955),
(3, 956),
(3, 957),
(3, 958),
(3, 965),
(3, 966),
(3, 967),
(3, 968),
(3, 969),
(3, 989),
(3, 991),
(3, 992),
(3, 994),
(3, 996),
(3, 998),
(3, 1003),
(3, 1004),
(4, 885),
(4, 886),
(4, 890),
(4, 896),
(4, 906),
(4, 921),
(4, 925),
(4, 929),
(4, 938),
(4, 955),
(4, 956),
(4, 957),
(4, 958),
(4, 967),
(4, 968),
(4, 969),
(4, 991),
(4, 992),
(4, 994),
(4, 996),
(4, 998),
(4, 1003),
(4, 1004),
(5, 884),
(5, 886),
(5, 895),
(5, 896),
(5, 897),
(5, 904),
(5, 905),
(5, 906),
(5, 919),
(5, 920),
(5, 921),
(5, 929),
(5, 938),
(5, 944),
(5, 948),
(5, 951),
(5, 954),
(5, 955),
(5, 956),
(5, 957),
(5, 958),
(5, 965),
(5, 966),
(5, 967),
(5, 968),
(5, 969),
(5, 991),
(5, 992),
(5, 999),
(5, 1000),
(5, 1003),
(5, 1004),
(6, 884),
(6, 886),
(6, 889),
(6, 890),
(6, 891),
(6, 896),
(6, 899),
(6, 900),
(6, 901),
(6, 902),
(6, 904),
(6, 906),
(6, 912),
(6, 914),
(6, 915),
(6, 916),
(6, 918),
(6, 919),
(6, 921),
(6, 923),
(6, 927),
(6, 931),
(6, 932),
(6, 938),
(6, 940),
(6, 941),
(6, 942),
(6, 955),
(6, 956),
(6, 957),
(6, 958),
(6, 965),
(6, 966),
(6, 967),
(6, 968),
(6, 969),
(6, 991),
(6, 994),
(6, 996),
(6, 998),
(7, 884),
(7, 885),
(7, 886),
(7, 889),
(7, 890),
(7, 891),
(7, 896),
(7, 897),
(7, 899),
(7, 900),
(7, 901),
(7, 902),
(7, 904),
(7, 906),
(7, 907),
(7, 912),
(7, 914),
(7, 915),
(7, 916),
(7, 918),
(7, 919),
(7, 921),
(7, 922),
(7, 924),
(7, 925),
(7, 929),
(7, 930),
(7, 931),
(7, 932),
(7, 934),
(7, 937),
(7, 938),
(7, 939),
(7, 940),
(7, 941),
(7, 942),
(7, 943),
(7, 945),
(7, 946),
(7, 950),
(7, 953),
(7, 956),
(7, 957),
(7, 958),
(7, 965),
(7, 967),
(7, 968),
(7, 969),
(7, 977),
(7, 993),
(7, 998),
(7, 1000),
(7, 1003),
(7, 1004),
(8, 891),
(8, 899),
(8, 901),
(8, 902),
(8, 904),
(8, 906),
(8, 907),
(8, 912),
(8, 915),
(8, 916),
(8, 919),
(8, 921),
(8, 922),
(8, 923),
(8, 926),
(8, 927),
(8, 929),
(8, 932),
(8, 933),
(8, 935),
(8, 938),
(8, 945),
(8, 948),
(8, 955),
(8, 956),
(8, 957),
(8, 958),
(8, 965),
(8, 968),
(8, 969),
(8, 991),
(8, 992),
(8, 999),
(9, 890),
(9, 899),
(9, 900),
(9, 901),
(9, 902),
(9, 903),
(9, 904),
(9, 905),
(9, 906),
(9, 907),
(9, 912),
(9, 914),
(9, 915),
(9, 916),
(9, 917),
(9, 918),
(9, 919),
(9, 920),
(9, 921),
(9, 922),
(9, 929),
(9, 951),
(9, 953),
(9, 956),
(9, 957),
(9, 958),
(9, 965),
(9, 966),
(9, 967),
(9, 968),
(9, 969),
(9, 999),
(9, 1000),
(9, 1003),
(10, 885),
(10, 886),
(10, 899),
(10, 902),
(10, 903),
(10, 904),
(10, 905),
(10, 906),
(10, 907),
(10, 912),
(10, 916),
(10, 917),
(10, 919),
(10, 920),
(10, 921),
(10, 922),
(10, 925),
(10, 926),
(10, 956),
(10, 957),
(10, 958),
(10, 965),
(10, 968),
(10, 969),
(10, 992),
(11, 885),
(11, 889),
(11, 890),
(11, 899),
(11, 903),
(11, 904),
(11, 905),
(11, 906),
(11, 907),
(11, 912),
(11, 917),
(11, 919),
(11, 920),
(11, 921),
(11, 922),
(11, 925),
(11, 956),
(11, 957),
(11, 958),
(11, 965),
(11, 968),
(11, 969),
(12, 885),
(12, 886),
(12, 889),
(12, 890),
(12, 896),
(12, 899),
(12, 901),
(12, 902),
(12, 903),
(12, 904),
(12, 905),
(12, 906),
(12, 907),
(12, 912),
(12, 915),
(12, 916),
(12, 917),
(12, 919),
(12, 920),
(12, 921),
(12, 922),
(12, 924),
(12, 925),
(12, 951),
(12, 955),
(12, 956),
(12, 957),
(12, 958),
(12, 963),
(12, 965),
(12, 966),
(12, 967),
(12, 968),
(12, 969),
(12, 977),
(12, 999),
(13, 884),
(13, 885),
(13, 886),
(13, 889),
(13, 890),
(13, 892),
(13, 893),
(13, 894),
(13, 895),
(13, 896),
(13, 897),
(13, 899),
(13, 900),
(13, 901),
(13, 903),
(13, 904),
(13, 905),
(13, 906),
(13, 907),
(13, 912),
(13, 914),
(13, 915),
(13, 917),
(13, 918),
(13, 919),
(13, 920),
(13, 921),
(13, 922),
(13, 923),
(13, 924),
(13, 925),
(13, 926),
(13, 928),
(13, 930),
(13, 931),
(13, 932),
(13, 933),
(13, 934),
(13, 935),
(13, 938),
(13, 939),
(13, 940),
(13, 941),
(13, 942),
(13, 943),
(13, 944),
(13, 945),
(13, 946),
(13, 948),
(13, 949),
(13, 951),
(13, 952),
(13, 953),
(13, 954),
(13, 955),
(13, 956),
(13, 957),
(13, 958),
(13, 960),
(13, 961),
(13, 962),
(13, 963),
(13, 965),
(13, 966),
(13, 967),
(13, 968),
(13, 969),
(13, 970),
(13, 974),
(13, 980),
(13, 981),
(13, 986),
(13, 989),
(13, 990),
(13, 991),
(13, 992),
(13, 993),
(13, 996),
(13, 998),
(13, 999),
(13, 1000),
(13, 1003),
(13, 1004),
(14, 885),
(14, 886),
(14, 888),
(14, 896),
(14, 899),
(14, 904),
(14, 905),
(14, 906),
(14, 907),
(14, 912),
(14, 919),
(14, 920),
(14, 921),
(14, 922),
(14, 928),
(14, 930),
(14, 937),
(14, 939),
(14, 941),
(14, 942),
(14, 955),
(14, 956),
(14, 957),
(14, 958),
(14, 965),
(14, 968),
(14, 969),
(14, 990),
(14, 991),
(14, 992),
(14, 996),
(14, 998),
(14, 1003),
(14, 1004),
(15, 884),
(15, 885),
(15, 886),
(15, 889),
(15, 890),
(15, 897),
(15, 898),
(15, 899),
(15, 903),
(15, 904),
(15, 905),
(15, 906),
(15, 907),
(15, 912),
(15, 917),
(15, 919),
(15, 920),
(15, 921),
(15, 922),
(15, 925),
(15, 926),
(15, 927),
(15, 929),
(15, 930),
(15, 931),
(15, 934),
(15, 935),
(15, 937),
(15, 938),
(15, 939),
(15, 940),
(15, 941),
(15, 942),
(15, 943),
(15, 946),
(15, 952),
(15, 955),
(15, 956),
(15, 957),
(15, 958),
(15, 965),
(15, 966),
(15, 967),
(15, 968),
(15, 969),
(15, 991),
(15, 992),
(15, 996),
(15, 998),
(15, 999),
(15, 1003),
(15, 1004),
(16, 884),
(16, 889),
(16, 897),
(16, 899),
(16, 900),
(16, 904),
(16, 906),
(16, 912),
(16, 914),
(16, 918),
(16, 919),
(16, 921),
(16, 930),
(16, 939),
(16, 945),
(16, 949),
(16, 957),
(16, 958),
(16, 964),
(16, 965),
(16, 968),
(16, 989),
(16, 1003),
(16, 1004),
(17, 884),
(17, 886),
(17, 890),
(17, 897),
(17, 899),
(17, 900),
(17, 904),
(17, 906),
(17, 912),
(17, 914),
(17, 918),
(17, 919),
(17, 921),
(17, 925),
(17, 931),
(17, 957),
(17, 958),
(17, 964),
(17, 965),
(17, 968),
(17, 991),
(17, 999),
(18, 884),
(18, 886),
(18, 889),
(18, 890),
(18, 891),
(18, 897),
(18, 899),
(18, 904),
(18, 906),
(18, 912),
(18, 919),
(18, 921),
(18, 925),
(18, 929),
(18, 930),
(18, 938),
(18, 939),
(18, 940),
(18, 941),
(18, 942),
(18, 957),
(18, 958),
(18, 964),
(18, 965),
(18, 968),
(18, 974),
(18, 990),
(18, 991),
(19, 889),
(19, 890),
(19, 904),
(19, 919),
(19, 929),
(19, 957),
(19, 958),
(19, 964),
(19, 965),
(19, 966),
(19, 968),
(19, 999),
(20, 891),
(20, 904),
(20, 919),
(20, 949),
(20, 957),
(20, 958),
(20, 964),
(20, 965),
(20, 966),
(20, 968),
(21, 886),
(21, 889),
(21, 890),
(21, 891),
(21, 897),
(21, 904),
(21, 928),
(21, 930),
(21, 937),
(21, 938),
(21, 939),
(21, 940),
(21, 941),
(21, 942),
(21, 956),
(21, 957),
(21, 958),
(21, 964),
(21, 965),
(21, 968),
(21, 969),
(21, 989),
(21, 990),
(21, 992),
(21, 996),
(21, 998),
(21, 1003),
(21, 1004),
(22, 885),
(22, 889),
(22, 890),
(22, 897),
(22, 899),
(22, 904),
(22, 912),
(22, 925),
(22, 929),
(22, 930),
(22, 931),
(22, 932),
(22, 953),
(22, 956),
(22, 957),
(22, 958),
(22, 964),
(22, 965),
(22, 966),
(22, 968),
(22, 969),
(22, 974),
(22, 989),
(22, 996),
(22, 998),
(22, 999),
(23, 884),
(23, 887),
(23, 888),
(23, 889),
(23, 899),
(23, 904),
(23, 906),
(23, 912),
(23, 919),
(23, 921),
(23, 923),
(23, 927),
(23, 930),
(23, 943),
(23, 946),
(23, 951),
(23, 953),
(23, 956),
(23, 957),
(23, 964),
(23, 965),
(23, 966),
(23, 967),
(23, 968),
(23, 969),
(23, 999),
(23, 1000),
(24, 884),
(24, 885),
(24, 887),
(24, 888),
(24, 889),
(24, 891),
(24, 896),
(24, 899),
(24, 906),
(24, 912),
(24, 921),
(24, 933),
(24, 956),
(24, 958),
(24, 967),
(24, 969),
(25, 887),
(25, 891),
(25, 896),
(25, 900),
(25, 906),
(25, 914),
(25, 918),
(25, 921),
(25, 924),
(25, 933),
(25, 943),
(25, 956),
(25, 964),
(25, 965),
(25, 969),
(26, 884),
(26, 885),
(26, 887),
(26, 896),
(26, 900),
(26, 906),
(26, 914),
(26, 918),
(26, 921),
(26, 933),
(26, 955),
(26, 957),
(26, 964),
(26, 965),
(26, 968),
(26, 999),
(26, 1000),
(27, 887),
(27, 925),
(27, 930),
(27, 957),
(27, 958),
(27, 964),
(27, 965),
(27, 968),
(28, 887),
(28, 888),
(28, 889),
(28, 891),
(28, 892),
(28, 958),
(29, 884),
(29, 891),
(29, 924),
(29, 925),
(29, 930),
(29, 931),
(29, 933),
(29, 934),
(29, 957),
(29, 965),
(29, 968),
(29, 999),
(30, 891),
(30, 924),
(30, 925),
(30, 933),
(30, 943),
(30, 956),
(30, 958),
(30, 964),
(30, 965),
(30, 967),
(30, 969),
(31, 884),
(31, 885),
(31, 891),
(31, 906),
(31, 921),
(31, 923),
(31, 926),
(31, 927),
(31, 931),
(31, 933),
(31, 956),
(31, 958),
(31, 965),
(31, 969),
(31, 999),
(32, 885),
(32, 891),
(32, 906),
(32, 921),
(32, 923),
(32, 924),
(32, 933),
(32, 956),
(32, 958),
(32, 965),
(32, 969),
(33, 889),
(33, 891),
(33, 904),
(33, 906),
(33, 919),
(33, 921),
(33, 958),
(33, 965),
(34, 886),
(34, 887),
(34, 888),
(34, 890),
(34, 895),
(34, 897),
(34, 906),
(34, 921),
(34, 925),
(34, 926),
(34, 938),
(34, 939),
(34, 940),
(34, 941),
(34, 942),
(34, 954),
(34, 956),
(34, 957),
(34, 958),
(34, 964),
(34, 965),
(34, 966),
(34, 967),
(34, 968),
(34, 969),
(34, 970),
(34, 971),
(34, 980),
(34, 981),
(34, 991),
(34, 992),
(34, 1003),
(34, 1004),
(35, 885),
(35, 886),
(35, 887),
(35, 890),
(35, 897),
(35, 906),
(35, 921),
(35, 925),
(35, 926),
(35, 927),
(35, 938),
(35, 942),
(35, 946),
(35, 950),
(35, 953),
(35, 954),
(35, 956),
(35, 958),
(35, 960),
(35, 965),
(35, 967),
(35, 969),
(35, 971),
(35, 977),
(35, 986),
(35, 1003),
(35, 1004),
(36, 892),
(36, 895),
(36, 897),
(36, 906),
(36, 913),
(36, 921),
(36, 923),
(36, 926),
(36, 929),
(36, 932),
(36, 938),
(36, 944),
(36, 948),
(36, 951),
(36, 954),
(36, 956),
(36, 960),
(36, 965),
(36, 969),
(36, 970),
(36, 973),
(36, 977),
(36, 980),
(36, 981),
(36, 986),
(36, 990),
(36, 991),
(36, 992),
(36, 996),
(36, 998),
(36, 1003),
(36, 1004),
(37, 886),
(37, 890),
(37, 895),
(37, 906),
(37, 921),
(37, 925),
(37, 938),
(37, 939),
(37, 940),
(37, 941),
(37, 942),
(37, 954),
(37, 956),
(37, 957),
(37, 958),
(37, 969),
(37, 971),
(37, 991),
(37, 992),
(37, 1003),
(37, 1004),
(38, 887),
(38, 890),
(38, 926),
(38, 956),
(38, 958),
(38, 965),
(38, 969),
(38, 970),
(38, 971),
(38, 986),
(39, 895),
(39, 906),
(39, 921),
(39, 929),
(39, 930),
(39, 932),
(39, 934),
(39, 935),
(39, 938),
(39, 939),
(39, 940),
(39, 941),
(39, 942),
(39, 946),
(39, 950),
(39, 951),
(39, 954),
(39, 956),
(39, 957),
(39, 958),
(39, 964),
(39, 965),
(39, 968),
(39, 969),
(39, 977),
(39, 980),
(39, 981),
(39, 1003),
(39, 1004),
(40, 895),
(40, 906),
(40, 921),
(40, 929),
(40, 954),
(40, 956),
(40, 957),
(40, 958),
(40, 964),
(40, 965),
(40, 967),
(40, 968),
(40, 969),
(40, 970),
(40, 971),
(40, 973),
(40, 986),
(40, 991),
(41, 890),
(41, 897),
(41, 898),
(41, 906),
(41, 913),
(41, 921),
(41, 926),
(41, 932),
(41, 935),
(41, 938),
(41, 939),
(41, 940),
(41, 941),
(41, 942),
(41, 945),
(41, 946),
(41, 949),
(41, 950),
(41, 956),
(41, 957),
(41, 958),
(41, 964),
(41, 965),
(41, 968),
(41, 969),
(41, 990),
(41, 991),
(41, 996),
(41, 998),
(41, 1003),
(41, 1004),
(42, 884),
(42, 885),
(42, 886),
(42, 888),
(42, 889),
(42, 890),
(42, 897),
(43, 884),
(43, 889),
(43, 890),
(43, 897),
(43, 906),
(43, 921),
(43, 938),
(43, 956),
(43, 958),
(43, 965),
(43, 973),
(44, 929),
(44, 930),
(44, 932),
(44, 938),
(44, 940),
(44, 941),
(44, 942),
(44, 953),
(44, 956),
(44, 957),
(44, 958),
(44, 964),
(44, 965),
(44, 967),
(44, 968),
(44, 969),
(44, 977),
(44, 991),
(45, 886),
(45, 958),
(45, 965),
(46, 888),
(46, 890),
(46, 897),
(46, 906),
(46, 921),
(46, 957),
(46, 958),
(46, 965),
(46, 968),
(47, 888),
(47, 890),
(47, 897),
(48, 884),
(48, 889),
(48, 890),
(48, 897),
(48, 965),
(48, 989),
(48, 999),
(48, 1003),
(48, 1004),
(49, 890),
(49, 891),
(49, 897),
(49, 958),
(49, 964),
(49, 965),
(49, 966),
(49, 967),
(49, 989),
(49, 1003),
(49, 1004),
(50, 891),
(50, 893),
(50, 897),
(50, 958),
(50, 965),
(50, 989),
(50, 999),
(51, 891),
(51, 892),
(51, 908),
(51, 925),
(51, 936),
(51, 938),
(51, 965),
(52, 888),
(52, 908),
(52, 909),
(52, 965),
(52, 967),
(53, 888),
(53, 889),
(53, 908),
(53, 909),
(53, 964),
(53, 965),
(53, 966),
(53, 967),
(54, 891),
(54, 908),
(54, 909),
(54, 958),
(55, 889),
(55, 908),
(55, 909),
(55, 936),
(55, 958),
(55, 965),
(55, 966),
(55, 967),
(55, 971),
(56, 886),
(56, 887),
(56, 897),
(56, 908),
(56, 909),
(56, 928),
(56, 932),
(56, 933),
(56, 935),
(56, 956),
(56, 957),
(56, 958),
(56, 964),
(56, 965),
(56, 966),
(56, 967),
(56, 968),
(56, 969),
(56, 1003),
(56, 1004),
(57, 887),
(57, 890),
(57, 897),
(57, 908),
(57, 909),
(57, 928),
(57, 933),
(57, 939),
(57, 940),
(57, 943),
(57, 956),
(57, 957),
(57, 958),
(57, 964),
(57, 965),
(57, 966),
(57, 967),
(57, 968),
(57, 969),
(57, 971),
(57, 990),
(57, 991),
(57, 992),
(57, 999),
(57, 1003),
(57, 1004);

-- --------------------------------------------------------

--
-- Structure de la table `cadre`
--

CREATE TABLE `cadre` (
  `code` int(11) NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `cadre`
--

INSERT INTO `cadre` (`code`, `libelle`) VALUES
(1, 'En équipe'),
(2, 'Seul');

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `numero` int(11) NOT NULL,
  `loginProfesseur` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `commentaire` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `datecommentaire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `refSituation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `competence`
--

CREATE TABLE `competence` (
  `id` int(11) NOT NULL,
  `nomenclature` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `idActivite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `competence`
--

INSERT INTO `competence` (`id`, `nomenclature`, `libelle`, `idActivite`) VALUES
(1, 'C1.1.1.1', 'Recenser et caractériser les contextes d\'utilisation, les processus et les acteurs sur lesquels le service à produire aura un impact', 1),
(2, 'C1.1.1.2', 'Identifier les fonctionnalités attendues du service à produire', 1),
(3, 'C1.1.1.3', 'Préparer sa participation à une réunion', 1),
(4, 'C1.1.1.4', 'Rédiger un compte-rendu d\'entretien, de réunion', 1),
(5, 'C1.1.2.1', 'Analyser les interactions entre services', 2),
(6, 'C1.1.2.2', 'Recenser les composants de l\'architecture technique sur lesquels le service à produire aura un impact', 2),
(7, 'C1.1.3.1', 'Recenser et caractériser les exigences liées à la qualité attendue du service à produire', 3),
(8, 'C1.1.3.2', 'Recenser et caractériser les exigences de sécurité pour le service à produire', 3),
(9, 'C1.2.1.1', 'Recenser et caractériser des solutions répondant au cahier des charges (adaptation d\'une solution existante ou réalisation d\'une nouvelle);', 4),
(10, 'C1.2.1.2', 'Estimer le coût d\'une solution', 4),
(11, 'C1.2.1.3', 'Rédiger un dossier de choix et un argumentaire technique', 4),
(12, 'C1.2.2.1', 'Recenser les composants nécessaires à la réalisation de la solution retenue', 5),
(13, 'C1.2.2.2', 'Décrire l\'implantation des différents composants de la solution et les échanges entre eux', 5),
(14, 'C1.2.2.3', 'Rédiger les spécifications fonctionnelles et techniques de la solution retenue dans le formalisme exigé par l\'organisatio', 5),
(15, 'C1.2.3.1', 'Recenser les risques liés à une mauvaise utilisation ou à une utilisation malveillante du service', 6),
(16, 'C1.2.3.2', 'Recenser les risques liés à un dysfonctionnement du service', 6),
(17, 'C1.2.3.3', 'Prévoir les conséquences techniques de la non prise en compte d\'un risque', 6),
(18, 'C1.2.4.1', 'Recenser les tests d\'acceptation nécessaires à la validation du service et les résultats attendus', 7),
(19, 'C1.2.4.2', 'Préparer les jeux d\'essai et les procédures pour la réalisation des tests', 7),
(20, 'C1.2.5.1', 'Recenser les utilisateurs du service, leurs rôles et leur niveau de responsabilité', 8),
(21, 'C1.2.5.2', 'Recenser les ressources liées à l\'utilisation du service', 8),
(22, 'C1.2.5.3', 'Proposer les niveaux d\'habilitation associés au service', 8),
(23, 'C1.3.1.1', 'Mettre en place l\'environnement de test du service', 9),
(24, 'C1.3.1.2', 'Tester le service', 9),
(25, 'C1.3.1.3', 'Rédiger le rapport de test', 9),
(26, 'C1.3.2.1', 'Identifier les éléments à sauvegarder et à journaliser pour assurer la continuité du service et la traçabilité des transactions', 10),
(27, 'C1.3.2.2', 'Spécifier les procédures d\'alerte associées au service', 10),
(28, 'C1.3.2.3', 'Décrire les solutions de fonctionnement en mode dégradé et les procédures de reprise du service', 10),
(29, 'C1.3.3.1', 'Mettre en place l\'environnement de formation au nouveau service', 11),
(30, 'C1.3.3.2', 'Informer et former les utilisateurs', 11),
(31, 'C1.3.4.1', 'Mettre au point une procédure d\'installation de la solutio', 12),
(32, 'C1.3.4.2', 'Automatiser l\'installation de la solution', 12),
(33, 'C1.3.4.3', 'Mettre en exploitation le service', 12),
(34, 'C1.4.1.1', 'Établir son planning personnel en fonction des exigences et du déroulement du projet', 13),
(35, 'C1.4.1.2', 'Rendre compte de son activité', 13),
(36, 'C1.4.2.1', 'Suivre l\'exécution du projet', 14),
(37, 'C1.4.2.2', 'Analyser les écarts entre temps prévu et temps consommé', 14),
(38, 'C1.4.2.3', 'Contribuer à l\'évaluation du projet', 14),
(39, 'C1.4.3.1', 'Recenser les ressources humaines, matérielles, logicielles et budgétaires nécessaires à l\'exécution du projet et de ses tâches personnelles', 15),
(40, 'C1.4.3.2', 'Adapter son planning personnel en fonction des ressources disponibles', 15),
(41, 'C2.1.1.1', 'Aider les utilisateurs dans l\'appropriation du nouveau service', 16),
(42, 'C2.1.1.2', 'Identifier des besoins de formation complémentaires', 16),
(43, 'C2.1.1.3', 'Rendre compte de la satisfaction des utilisateurs', 16),
(44, 'C2.1.2.1', 'Analyser les indicateurs de qualité du service', 17),
(45, 'C2.1.2.2', 'Appliquer les procédures d\'alerte destinées à rétablir la qualité du service', 17),
(46, 'C2.1.2.3', 'Vérifier périodiquement le fonctionnement du service en mode dégradé et la disponibilité des éléments permettant une reprise du service', 17),
(47, 'C2.1.2.4', 'Superviser les services et leur utilisation', 17),
(48, 'C2.1.2.5', 'Contrôler la confidentialité et l\'intégrité des données', 17),
(49, 'C2.1.2.6', 'Exploiter les indicateurs et les fichiers d\'audit', 17),
(50, 'C2.1.2.7', 'Produire les rapports d\'activité demandés par les différents acteurs', 17),
(51, 'C2.2.1.1', 'Résoudre l\'incident en s\'appuyant sur une base de connaissances et la documentation associée ou solliciter l\'entité compétente', 18),
(52, 'C2.2.1.2', 'Prendre le contrôle d\'un système à distance', 18),
(53, 'C2.2.1.3', 'Rédiger un rapport d\'incident et mémoriser l\'incident et sa résolution dans une base de connaissances', 18),
(54, 'C2.2.1.4', 'Faire évoluer une procédure de résolution d\'incident', 18),
(55, 'C2.2.2.1', 'Identifier le niveau d\'assistance souhaité et proposer une réponse adaptée en s\'appuyant sur une base de connaissances et sur la documentation associée ou solliciter l\'entité compétente', 19),
(56, 'C2.2.2.2', 'Informer l\'utilisateur de la situation de sa demande', 19),
(57, 'C2.2.2.3', 'Prendre le contrôle d\'un poste utilisateur à distance', 19),
(58, 'C2.2.2.4', 'Mémoriser la demande d\'assistance et sa réponse dans une base de connaissances', 19),
(59, 'C2.2.3.1', 'Appliquer la procédure de continuité du service en mode dégradé', 20),
(60, 'C2.2.3.2', 'Appliquer la procédure de reprise du service', 20),
(61, 'C2.3.1.1', 'Repérer une suite de dysfonctionnements récurrents d\'un service', 21),
(62, 'C2.3.1.2', 'Identifier les causes de ce dysfonctionnement', 21),
(63, 'C2.3.1.3', 'Qualifier le problème (contexte et environnement);', 21),
(64, 'C2.3.1.4', 'Définir le degré d\'urgence du problème', 21),
(65, 'C2.3.1.5', 'Évaluer les conséquences techniques du problème', 21),
(66, 'C2.3.2.1', 'Décrire les incidences d\'un changement proposé sur le service', 22),
(67, 'C2.3.2.2', 'Évaluer le délai et le coût de réalisation du changement proposé', 22),
(68, 'C2.3.2.3', 'Recenser les risques techniques, humains, financiers et juridiques associés au changement proposé', 22),
(69, 'C3.1.1.1', 'Lister les composants matériels et logiciels nécessaires à la prise en charge des processus, des flux d\'information et de leur rôle', 23),
(70, 'C3.1.1.2', 'Caractériser les éléments d\'interconnexion, les services, les serveurs et les équipements terminaux nécessaires', 23),
(71, 'C3.1.1.3', 'Caractériser les éléments permettant d\'assurer la qualité et la sécurité des services', 23),
(72, 'C3.1.1.4', 'Recenser les modifications et/ou les acquisitions nécessaires à la mise en place d\'une solution d\'infrastructure compatible avec le budget et le planning prévisionnels', 23),
(73, 'C3.1.1.5', 'Caractériser les solutions d\'interconnexion utilisées entre un réseau et d\'autres réseaux internes ou externes à l\'organisatio', 23),
(74, 'C3.1.2.1', 'Concevoir une maquette de la solution', 24),
(75, 'C3.1.2.2', 'Construire un prototype de la solution', 24),
(76, 'C3.1.2.3', 'Préparer l\'intégration d\'un composant d\'infrastructure', 24),
(77, 'C3.1.3.1', 'Caractériser des solutions de sécurité et en évaluer le coût', 25),
(78, 'C3.1.3.2', 'Proposer une solution de sécurité compatible avec les contraintes techniques, financières, juridiques et organisationnelles', 25),
(79, 'C3.1.3.3', 'Décrire une solution de sécurité et les risques couverts', 25),
(80, 'C3.2.1.1', 'Installer et configurer un élément d\'interconnexion, un service, un serveur, un équipement terminal utilisateur', 26),
(81, 'C3.2.1.2', 'Installer et configurer un élément d\'infrastructure permettant d\'assurer la continuité de service, un système de régulation des éléments d\'infrastructure, un outil de métrologie, un dispositif d\'alerte', 26),
(82, 'C3.2.1.3', 'Installer et configurer des éléments de sécurité permettant d\'assurer la protection du système informatique', 26),
(83, 'C3.2.2.1', 'Élaborer une procédure de remplacement ou de migration respectant la continuité d\'un service', 27),
(84, 'C3.2.2.2', 'Mettre en œuvre une procédure de remplacement ou de migratio', 27),
(85, 'C3.2.3.1', 'Repérer les éléments de la documentation à mettre à jour', 28),
(86, 'C3.2.3.2', 'Mettre à jour la documentation', 28),
(87, 'C3.3.1.1', 'Installer et configurer des éléments d\'administration sur site ou à distance', 29),
(88, 'C3.3.1.2', 'Administrer des éléments d\'infrastructure sur site ou à distance', 29),
(89, 'C3.3.2.1', 'Installer et configurer des outils de sauvegarde et de restauratio', 30),
(90, 'C3.3.2.2', 'Définir des procédures de sauvegarde et de restauratio', 30),
(91, 'C3.3.2.3', 'Appliquer des procédures de sauvegarde et de restauratio', 30),
(92, 'C3.3.3.1', 'Identifier les besoins en gestion d\'identité permettant de protéger les éléments d\'une infrastructure', 31),
(93, 'C3.3.3.2', 'Gérer des utilisateurs et une structure organisationnelle', 31),
(94, 'C3.3.3.3', 'Affecter des droits aux utilisateurs sur les éléments d\'une solution d\'infrastructure', 31),
(95, 'C3.3.4.1', 'Repérer les tâches d\'administration à automatiser', 32),
(96, 'C3.3.4.2', 'Concevoir, réaliser et mettre en place une procédure d\'automatisatio', 32),
(97, 'C3.3.5.1', 'Installer et configurer les outils nécessaires à la production d\'indicateurs d\'activité et à l\'exploitation de fichiers d\'activité', 33),
(98, 'C3.3.5.2', 'Assurer la confidentialité des informations collectées et traitées', 33),
(99, 'C4.1.1.1', 'Identifier les composants logiciels nécessaires à la conception de la solutio', 34),
(100, 'C4.1.1.2', 'Estimer les éléments de coût et le délai de mise en œuvre de la solutio', 34),
(101, 'C4.1.2.1', 'Définir les spécifications de l\'interface utilisateur de la solution applicative', 35),
(102, 'C4.1.2.2', 'Maquetter un élément de la solution applicative', 35),
(103, 'C4.1.2.3', 'Concevoir et valider la maquette en collaboration avec des utilisateurs', 35),
(104, 'C4.1.3.1', 'Modéliser le schéma de données nécessaire à la mise en place de la solution applicative', 36),
(105, 'C4.1.3.2', 'Implémenter le schéma de données dans un SGBD', 36),
(106, 'C4.1.3.3', 'Programmer des éléments de la solution applicative dans le langage d\'un SGBD', 36),
(107, 'C4.1.3.4', 'Manipuler les données liées à la solution applicative à travers un langage de requête', 36),
(108, 'C4.1.4.1', 'Recenser et caractériser les composants existants ou à développer utiles à la réalisation de la solution applicative dans le respect des budgets et planning prévisionnels', 37),
(109, 'C4.1.5.1', 'Choisir les éléments de la solution à prototyper', 38),
(110, 'C4.1.5.2', 'Développer un prototype', 38),
(111, 'C4.1.5.3', 'Valider un prototype', 38),
(112, 'C4.1.6.1', 'Mettre en place et exploiter un environnement de développement', 39),
(113, 'C4.1.6.2', 'Mettre en place et exploiter un environnement de test', 39),
(114, 'C4.1.7.1', 'Développer les éléments d\'une solution', 40),
(115, 'C4.1.7.2', 'Créer un composant logiciel', 40),
(116, 'C4.1.7.3', 'Analyser et modifier le code d\'un composant logiciel', 40),
(117, 'C4.1.7.4', 'Utiliser des composants d\'accès aux données', 40),
(118, 'C4.1.7.5', 'Mettre en place des éléments de sécurité liés à l\'utilisation d\'un composant logiciel', 40),
(119, 'C4.1.8.1', 'Élaborer et réaliser des tests unitaires', 41),
(120, 'C4.1.8.2', 'Mettre en évidence et corriger les écarts', 41),
(121, 'C4.1.9.1', 'Produire ou mettre à jour la documentation technique d\'une solution applicative et de ses composants logiciels', 42),
(122, 'C4.1.10.1', 'Rédiger la documentation d\'utilisation, une aide en ligne, une FAQ', 43),
(123, 'C4.1.10.2', 'Adapter la documentation d\'utilisation à chaque contexte d\'utilisatio', 43),
(124, 'C4.2.1.1', 'Élaborer un jeu d\'essai permettant de reproduire le dysfonctionnement', 44),
(125, 'C4.2.1.2', 'Repérer les composants à l\'origine du dysfonctionnement', 44),
(126, 'C4.2.1.3', 'Concevoir les mises à jour à effectuer', 44),
(127, 'C4.2.1.4', 'Réaliser les mises à jour', 44),
(128, 'C4.2.2.1', 'Repérer les évolutions des composants utilisés et leurs conséquences', 45),
(129, 'C4.2.2.2', 'Concevoir les mises à jour à effectuer', 45),
(130, 'C4.2.2.3', 'Élaborer et réaliser les tests unitaires des composants mis à jour', 45),
(131, 'C4.2.3.1', 'Élaborer et réaliser des tests d\'intégration et de non régression de la solution mise à jour', 46),
(132, 'C4.2.3.2', 'Concevoir une procédure de migration et l\'appliquer dans le respect de la continuité de service', 46),
(133, 'C4.2.4.1', 'Repérer les éléments de la documentation à mettre à jour', 47),
(134, 'C4.2.4.2', 'Mettre à jour une documentation', 47),
(135, 'C5.1.1.1', 'Recenser les caractéristiques techniques nécessaires à la gestion des éléments de la configuration d\'une organisatio', 48),
(136, 'C5.1.1.2', 'Paramétrer une solution de gestion des éléments d\'une configuratio', 48),
(137, 'C5.1.2.1', 'Renseigner les événements relatifs au cycle de vie d\'un élément de la configuratio', 49),
(138, 'C5.1.2.2', 'Actualiser les caractéristiques des éléments de la configuratio', 49),
(139, 'C5.1.3.1', 'Contrôler et auditer les éléments de la configuratio', 50),
(140, 'C5.1.3.2', 'Reconstituer un historique des modifications effectuées sur les éléments de la configuratio', 50),
(141, 'C5.1.3.3', 'Identifier les éléments de la configuration à modifier ou à remplacer', 50),
(142, 'C5.1.3.4', 'Repérer les équipements obsolètes et en proposer le traitement dans le respect de la réglementation en vigueur', 50),
(143, 'C5.1.4.1', 'Assister la maîtrise d\'ouvrage dans l\'analyse technique de la proposition de contrat', 51),
(144, 'C5.1.4.2', 'Interpréter des indicateurs de suivi de la prestation associée à la proposition de contrat', 51),
(145, 'C5.1.4.3', 'Renseigner les éléments permettant d\'estimer la valeur du service', 51),
(146, 'C5.1.5.1', 'Vérifier un plan d\'amortissement', 52),
(147, 'C5.1.5.2', 'Apprécier la valeur actuelle d\'un élément de configuratio', 52),
(148, 'C5.1.6.1', 'Renseigner les variables d\'une étude de rentabilité d\'un investissement', 53),
(149, 'C5.1.6.2', 'Caractériser et prévoir les investissements matériels et logiciels', 53),
(150, 'C5.2.1.1', 'Évaluer le degré de conformité des pratiques à un référentiel, à une norme ou à un standard adopté par le prestataire informatique', 54),
(151, 'C5.2.1.2', 'Identifier et partager les bonnes pratiques à intégrer', 54),
(152, 'C5.2.2.1', 'Définir une stratégie de recherche d\'informations', 55),
(153, 'C5.2.2.2', 'Tenir à jour une liste de sources d\'information', 55),
(154, 'C5.2.2.3', 'Évaluer la qualité d\'une source d\'information en fonction d\'un besoi', 55),
(155, 'C5.2.2.4', 'Synthétiser et diffuser les résultats d\'une veille', 55),
(156, 'C5.2.3.1', 'Identifier les besoins de formation pour mettre en œuvre une technologie, un composant, un outil ou une méthode', 56),
(157, 'C5.2.3.2', 'Repérer l\'offre et les dispositifs de formation', 56),
(158, 'C5.2.4.1', 'Se documenter à propos d‘une technologie, d\'un composant, d\'un outil ou d\'une méthode', 57),
(159, 'C5.2.4.2', 'Identifier le potentiel et les limites d\'une technologie, d\'un composant, d\'un outil ou d\'une méthode par rapport à un service à produire', 57);

-- --------------------------------------------------------

--
-- Structure de la table `domaine`
--

CREATE TABLE `domaine` (
  `id` int(11) NOT NULL,
  `nomenclature` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `idProcessus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `domaine`
--

INSERT INTO `domaine` (`id`, `nomenclature`, `libelle`, `idProcessus`) VALUES
(1, 'D1.1  ', 'Analyse de la demande', 1),
(2, 'D1.2  ', 'Choix d\'une solution', 1),
(3, 'D1.3  ', 'Mise en production d\'un service', 1),
(4, 'D1.4  ', 'Travail en mode projet', 1),
(5, 'D2.1  ', 'Exploitation des services', 2),
(6, 'D2.2  ', 'Gestion des incidents et des demandes d\'assistance', 2),
(7, 'D2.3  ', 'Gestion des problèmes et des changements', 2),
(8, 'D3.1  ', 'Conception d\'une solution d\'infrastructure', 3),
(9, 'D3.2  ', 'Installation d\'une solution d\'infrastructure', 3),
(10, 'D3.3  ', 'Administration et supervision d\'une infrastructure', 3),
(11, 'D4.1  ', 'Conception et réalisation d\'une solution applicative', 4),
(12, 'D4.2  ', 'Maintenance d\'une solution applicative', 4),
(13, 'D5.1  ', 'Gestion des configurations', 5),
(14, 'D5.2  ', 'Gestion des compétences', 5);

-- --------------------------------------------------------

--
-- Structure de la table `epreuve`
--

CREATE TABLE `epreuve` (
  `id` int(11) NOT NULL,
  `nomenclature` varchar(12) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `epreuve`
--

INSERT INTO `epreuve` (`id`, `nomenclature`) VALUES
(1, 'U4'),
(2, 'U5'),
(3, 'U6');

-- --------------------------------------------------------

--
-- Structure de la table `evalue`
--

CREATE TABLE `evalue` (
  `idParcours` int(11) NOT NULL DEFAULT '0',
  `idEpreuve` int(11) NOT NULL DEFAULT '0',
  `idActivite` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `evalue`
--

INSERT INTO `evalue` (`idParcours`, `idEpreuve`, `idActivite`) VALUES
(1, 1, 5),
(1, 1, 7),
(1, 1, 9),
(1, 1, 12),
(1, 1, 18),
(1, 1, 19),
(1, 1, 20),
(1, 1, 24),
(1, 1, 26),
(1, 1, 27),
(1, 1, 28),
(1, 1, 29),
(1, 1, 32),
(1, 1, 33),
(1, 2, 1),
(1, 2, 2),
(1, 2, 3),
(1, 2, 4),
(1, 2, 6),
(1, 2, 8),
(1, 2, 10),
(1, 2, 21),
(1, 2, 22),
(1, 2, 23),
(1, 2, 25),
(1, 2, 30),
(1, 2, 31),
(1, 2, 52),
(1, 2, 53),
(1, 3, 11),
(1, 3, 13),
(1, 3, 14),
(1, 3, 15),
(1, 3, 16),
(1, 3, 17),
(1, 3, 48),
(1, 3, 49),
(1, 3, 50),
(1, 3, 51),
(1, 3, 54),
(1, 3, 55),
(1, 3, 56),
(1, 3, 57),
(2, 1, 5),
(2, 1, 7),
(2, 1, 9),
(2, 1, 12),
(2, 1, 18),
(2, 1, 19),
(2, 1, 20),
(2, 1, 35),
(2, 1, 36),
(2, 1, 38),
(2, 1, 39),
(2, 1, 40),
(2, 1, 41),
(2, 1, 42),
(2, 1, 43),
(2, 1, 44),
(2, 1, 45),
(2, 1, 46),
(2, 1, 47),
(2, 2, 1),
(2, 2, 2),
(2, 2, 3),
(2, 2, 4),
(2, 2, 6),
(2, 2, 8),
(2, 2, 10),
(2, 2, 21),
(2, 2, 22),
(2, 2, 34),
(2, 2, 37),
(2, 2, 52),
(2, 2, 53),
(2, 3, 11),
(2, 3, 13),
(2, 3, 14),
(2, 3, 15),
(2, 3, 16),
(2, 3, 17),
(2, 3, 48),
(2, 3, 49),
(2, 3, 50),
(2, 3, 51),
(2, 3, 54),
(2, 3, 55),
(2, 3, 56),
(2, 3, 57),
(3, 1, 5),
(3, 1, 7),
(3, 1, 9),
(3, 1, 12),
(3, 1, 18),
(3, 1, 19),
(3, 1, 20),
(3, 1, 24),
(3, 1, 26),
(3, 1, 27),
(3, 1, 28),
(3, 1, 29),
(3, 1, 32),
(3, 1, 33),
(3, 1, 35),
(3, 1, 36),
(3, 1, 38),
(3, 1, 39),
(3, 1, 40),
(3, 1, 41),
(3, 1, 42),
(3, 1, 43),
(3, 1, 44),
(3, 1, 45),
(3, 1, 46),
(3, 1, 47),
(3, 2, 1),
(3, 2, 2),
(3, 2, 3),
(3, 2, 4),
(3, 2, 6),
(3, 2, 8),
(3, 2, 10),
(3, 2, 21),
(3, 2, 22),
(3, 2, 23),
(3, 2, 25),
(3, 2, 30),
(3, 2, 31),
(3, 2, 34),
(3, 2, 37),
(3, 2, 52),
(3, 2, 53),
(3, 3, 11),
(3, 3, 13),
(3, 3, 14),
(3, 3, 15),
(3, 3, 16),
(3, 3, 17),
(3, 3, 48),
(3, 3, 49),
(3, 3, 50),
(3, 3, 51),
(3, 3, 54),
(3, 3, 55),
(3, 3, 56),
(3, 3, 57);

-- --------------------------------------------------------

--
-- Structure de la table `exploite`
--

CREATE TABLE `exploite` (
  `idParcours` int(11) NOT NULL,
  `idProcessus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `exploite`
--

INSERT INTO `exploite` (`idParcours`, `idProcessus`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 5),
(2, 1),
(2, 2),
(2, 4),
(2, 5);

-- --------------------------------------------------------

--
-- Structure de la table `framework`
--

CREATE TABLE `framework` (
  `id` int(11) NOT NULL,
  `libelle` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `framework`
--

INSERT INTO `framework` (`id`, `libelle`) VALUES
(1, 'Aucun'),
(2, '.Net Framework'),
(3, 'PHP Framework'),
(4, 'Symfony'),
(5, 'Android'),
(6, 'Angular'),
(7, 'J2SE'),
(8, 'JEE'),
(9, 'Python'),
(10, 'React JS');

-- --------------------------------------------------------

--
-- Structure de la table `langage`
--

CREATE TABLE `langage` (
  `id` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `langage`
--

INSERT INTO `langage` (`id`, `libelle`) VALUES
(1, 'Aucun'),
(2, 'C#'),
(3, 'PHP'),
(4, 'Java'),
(5, 'Javascript'),
(6, 'Python');

-- --------------------------------------------------------

--
-- Structure de la table `langageframework`
--

CREATE TABLE `langageframework` (
  `idlangage` int(11) NOT NULL,
  `idframework` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `langageframework`
--

INSERT INTO `langageframework` (`idlangage`, `idframework`) VALUES
(1, 1),
(2, 2),
(3, 3),
(3, 4),
(4, 5),
(4, 7),
(4, 8),
(5, 3),
(5, 4),
(5, 6),
(5, 10),
(6, 9);

-- --------------------------------------------------------

--
-- Structure de la table `operatingsystem`
--

CREATE TABLE `operatingsystem` (
  `id` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `operatingsystem`
--

INSERT INTO `operatingsystem` (`id`, `libelle`) VALUES
(1, 'Windows'),
(2, 'Linux');

-- --------------------------------------------------------

--
-- Structure de la table `parcours`
--

CREATE TABLE `parcours` (
  `id` int(11) NOT NULL,
  `nomenclature` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `parcours`
--

INSERT INTO `parcours` (`id`, `nomenclature`, `libelle`) VALUES
(1, 'SISR  ', 'Solutions d’Infrastructure, Systèmes et Réseaux'),
(2, 'SLAM  ', 'Solutions Logicielles et Applications Métiers'),
(3, '', 'Indifférencié');

-- --------------------------------------------------------

--
-- Structure de la table `processus`
--

CREATE TABLE `processus` (
  `id` int(11) NOT NULL,
  `nomenclature` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `processus`
--

INSERT INTO `processus` (`id`, `nomenclature`, `libelle`) VALUES
(1, 'P1', 'Production de services'),
(2, 'P2', 'Fourniture de services'),
(3, 'P3', 'Conception et maintenance de solutions d’infrastructure'),
(4, 'P4', 'Conception et maintenance de solutions applicatives'),
(5, 'P5', 'Gestion du patrimoine informatique');

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `libelle` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `libelle`) VALUES
(1, 'DNS'),
(2, 'DHCP'),
(3, 'Annuaire LDAP'),
(4, 'Parefeu');

-- --------------------------------------------------------

--
-- Structure de la table `situation`
--

CREATE TABLE `situation` (
  `reference` int(11) NOT NULL,
  `login` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `descriptif` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `datedebut` datetime DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `codeCadre` int(11) DEFAULT NULL,
  `typesituation` int(11) NOT NULL,
  `codeLocalisation` int(11) DEFAULT NULL,
  `codeLangage` int(11) DEFAULT NULL,
  `codeFramework` int(11) DEFAULT NULL,
  `codeOS` int(11) DEFAULT NULL,
  `codeService` int(11) DEFAULT NULL,
  `typeos` int(11) NOT NULL DEFAULT '-1',
  `services` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refe4` int(11) DEFAULT NULL,
  `port_ref` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `situation`
--

INSERT INTO `situation` (`reference`, `login`, `libelle`, `descriptif`, `datedebut`, `datefin`, `codeCadre`, `typesituation`, `codeLocalisation`, `codeLangage`, `codeFramework`, `codeOS`, `codeService`, `typeos`, `services`, `refe4`, `port_ref`) VALUES
(884, 'francoismarie.lauze', 'Projet de creation application web', 'C est un projet de groupe ou nous avons du coder en HTML CSS et PHP afin de le rendre le plus fonctionnel possible\r\nC est un site internet fonctionnel cree dans le but d aider la bibliotheque d orange a proposer ses services de location en ligne', '2016-09-29 00:00:00', '2016-12-16 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 169),
(885, 'francoismarie.lauze', 'Projet de creation de site Web', 'C est un projet de groupe ou nous avons du coder en HTML CSS et PHP afin de le rendre le plus fonctionnel possible\r\nNous avons donc crÃ©Ã© un site web entiÃ¨rement fonctionnel pour un hÃ´tel, ou un client peut voir les chambres disponibles et en rÃ©server', '2017-01-03 00:00:00', '2017-05-03 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 418),
(886, 'francoismarie.lauze', 'Serious game (Workshop) PHP/Logiciel', 'blabla', '2017-02-14 00:00:00', '2017-03-11 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 463),
(887, 'francoismarie.lauze', 'Projet reseau (CentOS)', 'blabla', '2017-04-01 00:00:00', '2017-05-01 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 464),
(888, 'francoismarie.lauze', 'Projet application fonctionelle C#', 'Nous avons du realiser une application en c sharp permettant la gestion d\'une course de bateaux.', '2017-09-20 00:00:00', '2017-12-15 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 596),
(889, 'francoismarie.lauze', 'Stage : participation au dÃ©ploiement d\'un intranet collaboratif', 'Dans le cadre du bts j\'ai Ã©tÃ© amenÃ© Ã  faire un premier stage, que j\'ai effectuÃ© au rectorat de Montpellier. J\'ai Ã©tÃ© amenÃ© a participer Ã  un dÃ©ploiement, et Ã  faire des test pour essayer de trouver si des bugs Ã©taient prÃ©sents aprÃ¨s les diff', '2017-05-15 00:00:00', '2017-06-30 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 638),
(890, 'francoismarie.lauze', 'Stage : creation d\'une application de modification de donnÃ©es', 'Dans le cadre de ce stage, j\'ai Ã©tÃ© amenÃ© Ã  coder une application  en C# dans le but de rendre des informations sur des vÃ©hicules et conducteurs confidentielles, afin d\'Ãªtre aux normes imposÃ©es par la loi de protection des donnÃ©es. ', '2018-03-22 00:00:00', '2018-03-22 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 639),
(891, 'francoismarie.lauze', 'Projet reseau', 'Multiples projets effectuÃ©s en cours de rÃ©seau', '2018-04-05 00:00:00', '2018-04-05 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 670),
(892, 'yohan.angelini', 'Projet bibliotheque Orange', 'Creation d un site qui gere avec un formulaire et un d abonnement avec une connection deconnection pour utilisateur et admis recherche de livre par titre auteur genre recherche des information sur les adherents si on est connecte en admis ', '2017-10-23 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 524),
(893, 'yohan.angelini', 'Projet reseaux chat', 'realisation d un serveur chat entre deux putty a l aide de centos et VMware  permettant de communiquer entre eux avec filtre insulte', '2017-11-15 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 525),
(894, 'yohan.angelini', 'projet reseau firewall', 'conception d\'un firewall sous centos avec VMvare', '2017-10-09 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 526),
(895, 'quentin.bernard2', 'Projet developpement site web php', 'Developpement d un site web avec gestion de pret de livre', '2017-10-25 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 508),
(896, 'quentin.bernard2', 'Installation Serveur WEB et Parefeu sous Linux', 'Mise en place d une architecture reseau avec des services DHCP DNS http et un pare-feu pour offrir un accÃ¨s Ã  Internet On veut une architecture fiable  qui distribue des adresses IP integre un systÃ¨me de nom  un serveur Web ainsi qu un pare feu\r\npour d', '2017-10-02 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 514),
(897, 'quentin.bernard2', 'Projet Portfolio', 'Creation du Porfolio pour l\'Ã©preuve E6 du BTS SIO option SLAM. Mise en place de projet et veille technologique', '2018-02-03 00:00:00', '2018-03-05 00:00:00', 2, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 551),
(898, 'paul.colombier', 'Sweet App', 'Projet individuel dont le but Ã©tait de crÃ©er une landing page pour une application de type \'rÃ©seau social\' Ã  l\'aide d\'une maquette imposÃ©e avec toute la documentation fournie.', '2017-10-20 00:00:00', '2017-11-06 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 674),
(899, 'paul.colombier', 'Workshop 1 B1', 'CrÃ©ation en Ã©quipe d\'un jeu vidÃ©o ressemblant au style du jeu Mario Bros. AvancÃ© d\'un personnage sur une plateforme dÃ©filante avec une difficultÃ© gÃ©nÃ©rÃ©e alÃ©atoirement.', '2017-09-25 00:00:00', '2017-09-29 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 678),
(900, 'paul.colombier', 'Librairie Orange', 'Projet composÃ© d\'une Ã©quipe de 4 camarades dont l\'objectif a Ã©tÃ© de rÃ©aliser une application de gestion des livres et des adhÃ©rents pour la bibliothÃ¨que de la ville d\'Orange. La gestion des contraintes a dÃ» Ãªtre mise en place.', '2017-11-23 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 700),
(901, 'paul.colombier', 'Chat', 'Ã‰laboration d\'un chat en duo via une machine virtuelle de CentOS. ', '2017-11-20 00:00:00', '2017-12-06 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 702),
(902, 'paul.colombier', 'Pare-feu', 'Mise ne place en duo d\'un firewall sous machine virtuelle CentOS.', '2017-11-20 00:00:00', '2017-12-06 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 704),
(903, 'paul.colombier', 'Parser', 'Mise en place en duo d\'un filtre de recherche sur un site web existant sous machine virtuelle CentOS.', '2018-01-28 00:00:00', '2018-02-16 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 705),
(904, 'paul.colombier', 'Workshop 2 B1', 'Projet en Ã©quipe de 5 sur la crÃ©ation d\'un site accueillant des cours proposÃ©s gratuitement par des Ã©tudiants en Ã©change d\'autres cours.', '2018-03-26 00:00:00', '2018-03-30 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 706),
(905, 'paul.colombier', 'Mini Banque Neptune', 'CrÃ©ation en duo d\'un logiciel pour une banque gÃ©rant les comptes bancaires et les clients.', '2018-03-01 00:00:00', '2018-04-13 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 710),
(906, 'paul.colombier', 'PPE Platcom', 'CrÃ©ation d\'une plateforme de communication professionnelle permettant une facilitÃ© de communication optimisÃ©e au sein de grandes entreprises.', '2018-03-05 00:00:00', '2018-05-03 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 712),
(907, 'paul.colombier', 'NAS', 'Projet en duo pour une mise en place d\'un serveur de sauvegarde Windows sous CentOS.', '2018-03-10 00:00:00', '2018-04-12 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 716),
(908, 'paul.colombier', 'Veille juridique ', 'Veille juridique contrats', '2018-04-09 00:00:00', '2018-04-09 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 718),
(909, 'paul.colombier', 'Veille technologique', 'veille technologique', '2018-04-09 00:00:00', '2018-04-09 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 719),
(910, 'paul.colombier', 'CamÃ©ra Raspberry PI', 'crÃ©ation d\'une camÃ©ra Ã  distance Ã  l\'aide d\'un Raspberry PI 3', '2018-01-01 00:00:00', '2018-07-31 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 720),
(911, 'paul.colombier', 'CV / Portfolio en ligne', 'CrÃ©ation d\'un site web', '2017-12-23 00:00:00', '2018-06-30 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 722),
(912, 'alexandre.cros1', 'Workshop B1 1', 'CrÃ©ation en Ã©quipe d\'un jeu vidÃ©o de type plat-former, permettant d\'amÃ©liorer ses rÃ©flexes et possÃ©dant diffÃ©rents niveaux de difficultÃ©s.', '2017-09-25 00:00:00', '2017-09-29 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 698),
(913, 'alexandre.cros1', 'Projet Sweet', 'Projet individuel consistant Ã  reproduire la page vitrine d\'un site (Sweet-app.fr) en utilisant uniquement du HTML et du CSS', '2017-10-20 00:00:00', '2017-11-06 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 699),
(914, 'alexandre.cros1', 'Librairie Orange', 'Projet rÃ©alisÃ© en Ã©quipe consistant Ã  rÃ©aliser un systÃ¨me de gestion avec une base de donnÃ©es pour une bibliothÃ¨que', '2017-11-23 00:00:00', '2018-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 701),
(915, 'alexandre.cros1', 'Projet Chat', 'Ce projet consiste Ã  rÃ©aliser un chat entre deux machines Ã  travers un pare-feu sous l\'environnement Linux', '2017-11-20 00:00:00', '2017-12-06 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 703),
(916, 'alexandre.cros1', 'Projet Pare-feu', 'Ce projet consiste Ã  rÃ©aliser un pare-feu permettant de sÃ©curiser la connexion entre deux machines sous l\'environnement Linux', '2017-11-20 00:00:00', '2017-12-06 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 707),
(917, 'alexandre.cros1', 'Projet Parser', 'Ce projet consistait Ã  rÃ©aliser un parser pour filtrer des recherches sur un site web', '2018-04-09 00:00:00', '2018-04-09 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 708),
(918, 'alexandre.cros1', 'Projet Personnel CV/Portfolio', 'Ce projet est hors cursus. J\'ai rÃ©alisÃ© mon CV/Portfolio disponible en ligne.', '2018-02-09 00:00:00', '2018-04-13 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 709),
(919, 'alexandre.cros1', 'Workshop B1 2', 'Ce projet consistait Ã  rÃ©aliser en Ã©quipe un systÃ¨me de gestion de base de donnÃ©es, ainsi que le site supportant ce systÃ¨me', '2018-03-26 00:00:00', '2018-03-30 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 711),
(920, 'alexandre.cros1', 'Projet Mini-Banque Neptune', 'Ce projet consistait Ã  rÃ©aliser un systÃ¨me de gestion de banque en C#', '2018-03-01 00:00:00', '2018-04-13 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 713),
(921, 'alexandre.cros1', 'Projet PPE2 Platcom', 'Ce projet consistait Ã  rÃ©aliser un systÃ¨me de gestion avec base de donnÃ©es pour un site qui permet aux employÃ©s d\'une sociÃ©tÃ© de communiquer entre eux en direct grÃ¢ce Ã  un systÃ¨me de salons privÃ©s ou publics', '2018-03-05 00:00:00', '2018-05-03 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 714),
(922, 'alexandre.cros1', 'Projet NAS', 'Ce projet consistait Ã  rÃ©aliser sous l\'environnement Linux une grappe de disque afin de faire des sauvegardes', '2018-03-12 00:00:00', '2018-04-12 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 715),
(923, 'adrien.figueiredo', 'Site Web et Gestion de Bibliotheque ', 'Nous avons cree en groupe un site web pour une bibliotheque avec une infrastructure de gestion d\'administration et de modification Avec une base de donnee complete \r\nNous avons utilise du HTML CSS et PHP', '2017-11-10 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 523),
(924, 'adrien.figueiredo', 'Mise en place d\'un serveur de sauvegarde', 'Serveur de sauvegarde RAID 5 avec webmin, mise en place d\'une synchronisation de l\'envoie desdonnÃ©es avec CRON et Rsync. Utilisation de CloneZila et de script en bash.', '2018-02-10 00:00:00', '2018-04-04 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 659),
(925, 'adrien.figueiredo', 'Création d\'une application mobile et web', 'Crétion d\'une application mobile et web dans le cadre professionnel via un CMS. Mise en place de publicité en ligne, suivi de la concurrence, gestion en ligne, ajout de contenu, relation client.', '2018-03-01 00:00:00', '2018-06-01 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 660),
(926, 'robin.legras', 'Site de gestion de reservation de livre', 'Site de gestion de reservation de livre develloppe en html, css, php et mysql', '2017-10-27 00:00:00', '2017-12-21 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 528),
(927, 'robin.legras', 'Serveur de discussion', 'Serveur de discussion entre utilisateur codÃ© en php objet', '2017-11-14 00:00:00', '2017-12-20 00:00:00', 2, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 533),
(928, 'vincent.marignier', 'Projet Sweet', 'Nous avons du dÃ©velopper un site vitrine pour une entreprise. Cela a Ã©tÃ© notre Ã©valuation pour une matiÃ¨re scolaire.', '2017-10-23 00:00:00', '2017-11-13 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 548),
(929, 'vincent.marignier', 'BibliothÃ¨que Orange', 'En groupe de 4 nous avons du dÃ©velopper un site web pour une mÃ©diathÃ¨que. Cette derniÃ¨re nous a demandÃ© de gÃ©rer les flux de livres qui entraient et sortaient de leur Ã©tablissement.', '2017-11-06 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 549),
(930, 'vincent.marignier', 'Chat ecrit', 'Mise en place d\'un chat ecrit avec un filtre Ã  insulte qui remplace automatiquement les insultes par des mots non insultants.', '2017-11-13 00:00:00', '2017-12-15 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 550),
(931, 'vincent.marignier', 'Pare-feu / serveur web', 'Mise en place d\'un pare-feu sous Linux (CentOs6) ainsi qu\'un serveur web Ã©galement dÃ©veloppÃ© sous Linux. Tout le php a Ã©tÃ© dÃ©veloppÃ© avec eclipse, le tout fonctionnant sur des machines virtuelles.', '2017-11-13 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 647),
(932, 'vincent.marignier', 'Workshop S2 B1', 'L\'objectif Ã©tait le dÃ©veloppement d\'une plateforme de partage de compÃ©tences et de mise en place de cours de soutien.', '2018-03-19 00:00:00', '2018-03-23 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 653),
(933, 'vincent.marignier', 'Serveur samba (NAS)', 'Mise en place d\'un serveur NAS pour une sauvegarde et l\'envoie automatique de ce fichier sur un serveur de partage.', '2018-02-05 00:00:00', '2018-04-12 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 654),
(934, 'vincent.marignier', 'Parser', 'Nous avons dÃ©veloppÃ© un parser en php pour extraire des informations (nÂ° de la carte, note, page de la carte) d\'une page d\'un site web listant les cartes d\'un jeu vidÃ©o.', '2018-01-22 00:00:00', '2018-02-09 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 655),
(935, 'vincent.marignier', 'Banque', 'DÃ©veloppement d\'une banque en C# sans interface graphique.', '2018-01-29 00:00:00', '2018-04-30 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 658),
(936, 'gabriel.martin2', 'Projet reseau', 'Cest du reseau (sans accent)', '2018-01-10 00:00:00', '2018-01-10 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 520),
(937, 'gabriel.martin2', 'Creation d\'un site vitrine ', 'Le but du projet etait de creer un site vitrine en HTML/CSS en s\'inspirant d\'un site dÃ©jÃ  existant.', '2017-10-20 00:00:00', '2017-11-06 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 675),
(938, 'gabriel.martin2', 'Creation de l\'interface web d\'administration d\'une librairie ', 'Le but etait de creer l\'interface web d\'administration d\'une librairie qui permettait d\'ajouter, d\'editer et de supprimer des membres et des livres presents dans une base de donnees. Il fallait donc gerer l\'acces au site par une page de connexion.', '2017-11-23 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 681),
(939, 'gabriel.martin2', 'Creation d\'une interface de communication entre utilisateurs', 'Le but de ce projet etait de creer un chat qui puisse permettre a plusieurs personnes de communiquer ensemble par Ã©crit.', '2017-11-20 00:00:00', '2017-12-06 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 682),
(940, 'gabriel.martin2', 'Projet pare-feu', 'Le but Ã©tait de mettre un serveur web derriÃ¨re un pare-feu afin de le protÃ©ger de toute intrusion.', '2017-11-20 00:00:00', '2017-12-06 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 753),
(941, 'gabriel.martin2', 'Projet Parser Web', 'Le but Ã©tait de permettre la rÃ©cupÃ©ration de donnÃ©es visibles sur un site afin de les lister.', '2018-01-29 00:00:00', '2018-02-16 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 754),
(942, 'gabriel.martin2', 'Projet Mini-banque Neptune', 'Le but etait de creer une interface de gestion de comptes client pour une banque avec l\'affichage du solde, le virement, l\'ajout au solde, etc...', '2018-03-01 00:00:00', '2018-04-13 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 755),
(943, 'gabriel.martin2', 'Projet NAS', 'Le but etait de mettre en place un RAID sur une Machine Virtuel et ce afin de rÃ©aliser des sauvegardes rÃ©guliÃ¨res.', '2018-03-09 00:00:00', '2018-04-12 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 756),
(944, 'pierre.noble', 'Site web', 'Site pour une bibliotheque', '2017-10-16 00:00:00', '2017-12-21 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 492),
(945, 'pierre.noble', 'Application', 'Chat', '2017-12-11 00:00:00', '2017-12-21 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 510),
(946, 'pierre.noble', 'Server Web et Firewall', 'Mise en place d\'un Firewall\r\nCrÃ©ation d\'un server web', '2017-12-11 00:00:00', '2017-12-21 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 513),
(947, 'anthony.perrin2', 'site web', 'site web pour une bibliotheque et interface admin', '2017-10-16 00:00:00', '2017-12-21 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 491),
(948, 'antoine.plagnol', 'Site internet  Php', 'Bibliotheque orange en html css php avec base de donnees\r\n', '2017-10-16 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 494),
(949, 'antoine.plagnol', 'MiniChat php', 'Creation d un mini chat en php en local\r\nUtilisation des sockets\r\nManipulation de centos', '2017-12-11 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 499),
(950, 'antoine.plagnol', 'Server Web et firewall', 'Mise en place d un firewall\r\ncreation d un server web\r\n', '2017-12-11 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 501),
(951, 'jeanbaptiste.poul', 'Site Web Ville Orange', 'Site internet pour la bibliotheque de la ville d Orange avec la possibilite de consulter des livres, de les emprunter et d avoir des informations sur la ville d Orange\r\nAinsi que la possibilite cote administateur de modifier,supprimer ou ajouter des livre', '2017-10-09 00:00:00', '2017-12-21 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 504),
(952, 'jeanbaptiste.poul', 'Page Web Sweet', 'Page web cree pour l\'application Sweet', '2017-10-02 00:00:00', '2017-11-21 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 516),
(953, 'jeanbaptiste.poul', 'Mini Chat', 'Mise en place d\'un chat en php', '2017-12-04 00:00:00', '2017-12-20 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 519),
(954, 'quentin.tarodo', 'Projet dÃ©veloppement web ', 'Site de gestion, pour une bibliothÃ¨que', '2017-10-15 00:00:00', '2017-12-22 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 490),
(955, 'quentin.tarodo', 'Installation serveur web et pare-feu', 'Configuration d\'un serveur web et pare-feu sous linux (centOs)', '2017-10-02 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 544),
(956, 'delphine.tran', 'Site pour mediatheque (bdd et web - PHP, SQL, Bootstrap, Merise)', 'Pour la mediatheque d Orange (Maison du Livre).\r\nMission : permettre la dematerialisation du systeme de gestion des livres. \r\nFonctionnalites : moteur de recherche filtre, connexion, pre-inscription\r\nGestion (livres, emprunts, membres et contentieux)', '2017-11-01 00:00:00', '2017-12-20 00:00:00', 2, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 539),
(957, 'delphine.tran', 'Serveur tchat php', 'Conception et realisation d\'un tchat php avec sockets\r\nConnexion entre different ordinateurs (Linux, Mac, Windows) et mobile via tunnel ssh (port : 22)', '2017-11-01 00:00:00', '2017-12-20 00:00:00', 2, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 540),
(958, 'delphine.tran', 'Realisation, maintenance et suivi sites (concessionnaires auto)', 'Dans le cadre de mon travail, j\'ai rÃ©alise de nombreux sites pour concessionnaires automobiles en collaboration avec des Ã©quipes internationales.', '2014-11-03 00:00:00', '2016-12-31 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 543),
(959, 'vincent.vialla', 'Bibliotheque orange', 'Site de gestion de livre ', '2017-10-25 00:00:00', '2017-12-20 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 497),
(960, 'nathan.milhe', 'Bibliotheque d\'Orange', 'Realiser une librairie en ligne pour la ville d\'orange permettant de consulter et de reserver un livre.', '2017-10-16 00:00:00', '2017-12-21 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 527),
(961, 'nathan.milhe', 'Realisation d\'une interface de discussion', 'Realisation d\'une interface de discussion en temps reel.', '2017-11-08 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 529),
(962, 'nathan.milhe', 'Sweet', 'Creation d\'un site web dit vitrine presentant une entreprise.', '2017-10-02 00:00:00', '2017-11-24 00:00:00', 2, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 530),
(963, 'nathan.milhe', 'Creation d\'un serveur', 'Creation d\'un serveur.', '2017-10-09 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 531),
(964, 'tristan.bouchier', 'Serveur Prive 2010', '2010 (16ans) Administrateur. Creation d un Serveur multijoueur WOW en 2.7.3 hebergÃ© sous serveur dÃ©diÃ© local WAMP. Gestion de bases de donnÃ©es MySQL, premiÃ¨re rencontre avec les consoles, commandes et controls administrateur. Mise en place dâ€™un..', '2010-01-01 00:00:00', '2010-07-01 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 534),
(965, 'tristan.bouchier', 'Serveur Prive 2013', '2013 (19 ans) Administrateur chef de projet. Nouvelle tentative dans la creation d un des premiers serveurs modes sur MINECRAFT grÃ¢ce au plugin MCPC+. Grande reussite. Entre 25 et 100 joueurs permanents. Mise en place de maintenances hebdomadaires...', '2013-01-01 00:00:00', '2013-12-31 00:00:00', 1, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 535),
(966, 'tristan.bouchier', 'Chaine Youtube', 'Mise en place d une chaine youtube. Initiation aux MONTAGES VIDEOS. PUBLICITE  initiation Ã  PHOTOSHOP et maitrise du logiciel de montage CAMTASIA.', '2016-01-02 00:00:00', '2018-01-22 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 536),
(967, 'tristan.bouchier', 'Unity3D Developpement videoludique', 'Utilisation de BLENDER pour les textures  veille sur la REALITE VIRTUELLE ainsi que sur les models 3D. Initiation sur l animation et le game design. Achat d un casque OCCULUS RIFT en developpement kit. Realisation d une maquette de RPG compatible en VR. ', '2018-01-22 00:00:00', '2018-01-22 00:00:00', 2, 2, 1, 1, 1, 1, 1, -1, NULL, NULL, 537),
(968, 'tristan.bouchier', 'Serveur Chat PHP', 'Conception et realisation d un serveur chat PHP avec socket et connection entre ordinateurs (IOS, Linux, Windows) et mobiles Android via tunnel SSH (port 22)', '2017-11-01 00:00:00', '2017-12-20 00:00:00', 1, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 541),
(969, 'tristan.bouchier', 'Site pour mediatheque (BDD Merise et PHP web)', 'Faire un site web pour une mediatheque basee a Orange avec sa base de donnee en Jmerise et MySQL et un site web fonctionnel en HTML5/CSS/PHP', '2017-11-01 00:00:00', '2017-12-20 00:00:00', 2, 2, 2, 1, 1, 1, 1, -1, NULL, NULL, 542),
(970, 'test.v2', 'test', 'un petit test', '2019-01-07 00:00:00', '2019-03-01 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, 970, NULL),
(971, 'test.v2', 'autre test', 'test d\'après E4', '2018-09-03 00:00:00', '2019-05-03 00:00:00', NULL, 2, NULL, 5, 6, NULL, NULL, -1, NULL, NULL, NULL),
(973, 'theo.simoes', 'Bibliothèque Orange', 'Conception d\'une base de données et d\'un site web pour la bibliothèque d\'Orange', '2018-10-11 00:00:00', '2018-12-20 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(974, 'vivien.thiebaut', 'bibliothèque Orange', 'Création d\'un site avec interface de connexion et d\'inscription', '2019-01-08 00:00:00', '2019-01-08 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(976, 't.ferauddentinger', 'Bibliothèque Orange', 'Crée un site web pour une bibliothèque', '2019-01-08 00:00:00', '2019-01-08 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(977, 'remi.assidi', 'Bibliothéque orange', 'Site pour la bibliothéque d\'orange', '2019-01-08 00:00:00', '2019-01-16 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(978, 'youssef.zriouh', 'Bibliothéque Orange', 'Test', '2018-10-20 00:00:00', '2018-12-18 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(979, 'gaspar.tissier', 'Bibliotheque orange', 'Projet php site premier semestre b1', '2018-10-10 00:00:00', '2019-12-10 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(980, 'alessandro.lescole', 'Bibliothèque orange', 'création d\'un site web représentant une bibliothèque, sa base de donnée et le site dynamique', '2018-10-04 00:00:00', '2018-12-13 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(981, 'thomas.salvignol', 'Bibliothèque Orange', 'Création d\'un site internet pour la bibliothèque d\'Orange avec base de donnée', '2018-10-09 00:00:00', '2018-12-13 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(983, 'ndeyekhady.ndoye', 'Bibliotèque Orange', 'Bibliotèque de la ville Orange', '2018-12-20 00:00:00', '2019-01-08 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(984, 'ronan.quenechdu', 'Bibliotheque Orange', 'juju', '2019-01-08 00:00:00', '2019-01-08 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(986, 'test.v2', 'Bibliothèque Orange', 'desc', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(989, 'bastien.bonnel', 'Bibliothèque Orange', 'Le site permet de louer un livre sur un site. il permet aussi la gestion des membres et des livres', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(990, 'marin.leonard', 'bibliothèque orange', 'enregistrement des livre, affichage,gestion livre et client', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(991, 'nathan.peraldi', 'Bibliothèque Orange', 'Site web en HTML / PHP, relié à une base de donnée. Recense les livres, auteurs, utilisateurs... Possibilité d\'emprunter / rendre des livres, de souscrire à un abonnement.', '2018-10-01 00:00:00', '2018-12-18 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(992, 'jeancharles.cano', 'Bibliothèque orange', 'site web permettant d\'emprunter et rendre des livre automatiquement, une gestions des membres', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(993, 'guilhem.batifol', 'Bibliothèque orange', 'ressance des livres, auteur et permet de prendre en charge les clients', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(994, 'lilian.michaux', 'Bibliothèque orange', 'Gestions des livres et des membres', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(996, 'mateo.thiebault', 'Bibliothéque d\'orange', 'Site qui permet d\'ajouté des livres à une base de données et de les recherché puis une partit de connextion de compte.', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(998, 'fabien.dufes', 'Bibliothéque d\'orange', 'Site qui permet d\'ajouté des livres à une base de données et de les recherché puis une partit de connextion de compte.', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(999, 'idrissa.ndiaye', 'projet infra reseau avec Mr Forton', 'projet 1', '2018-10-05 00:00:00', '2019-01-08 00:00:00', NULL, 1, NULL, NULL, NULL, 1, 1, 2, 'DNS', NULL, NULL),
(1000, 'guilhem.batifol', 'projet réseau instalation', 'instalation d\'un centos 7 puis création d\'un réseau local.', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 1, NULL, NULL, NULL, 2, 2, 1, 'DHCP', NULL, NULL),
(1001, 'clement.knoderer', 'Bibliothèque Orange', 'Création d\'une gestion de livres et d\'éditeurs pour une bibliothèque.', '2018-10-01 00:00:00', '2018-12-21 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(1002, 'alexis.turon', 'Questionnaire', 'Questionnaire en python pour la spé ISN en terminale.', '2018-03-23 00:00:00', '2018-06-01 00:00:00', NULL, 2, NULL, 6, 9, NULL, NULL, -1, NULL, NULL, NULL),
(1003, 'alexis.turon', 'Bibliothèque Orange', 'Premier projet PHP, première année EPSI', '2018-10-01 00:00:00', '2018-12-20 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(1004, 'ghislain.damou', 'Bibliothèque Orange', 'Projet de création en groupe d\'un site de gestion de livres/adhérents d\'une bibliothèque.', '2018-10-01 00:00:00', '2018-12-20 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(1005, 'valentin.moulin', 'Bibliothèque Orange', 'Faire un site web de bibliothèque fonctionnel relier a une base de donnés projet en php/html', '2018-10-01 00:00:00', '2018-12-18 00:00:00', NULL, 2, NULL, 3, 3, NULL, NULL, -1, NULL, NULL, NULL),
(1006, 'test.v2sisr', 'gggggggg', 'gqg', '2019-01-14 00:00:00', '2019-05-24 00:00:00', NULL, 1, NULL, NULL, NULL, NULL, NULL, 2, 'Active Directory, DNS, DHCP', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `situatione4`
--

CREATE TABLE `situatione4` (
  `referencee4` int(11) NOT NULL,
  `competenceApplication` int(11) NOT NULL DEFAULT '0',
  `competenceSGBD` int(11) NOT NULL DEFAULT '0',
  `contexte` varchar(250) NOT NULL,
  `intitule` varchar(250) NOT NULL,
  `equipe` int(11) NOT NULL DEFAULT '0',
  `realisation` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `situatione4`
--

INSERT INTO `situatione4` (`referencee4`, `competenceApplication`, `competenceSGBD`, `contexte`, `intitule`, `equipe`, `realisation`) VALUES
(970, 2, 1, 'un contexte', 'test', 0, 'test');

-- --------------------------------------------------------

--
-- Structure de la table `situationtypo`
--

CREATE TABLE `situationtypo` (
  `reference` int(11) NOT NULL,
  `code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `situationtypo`
--

INSERT INTO `situationtypo` (`reference`, `code`) VALUES
(884, 3),
(885, 1),
(885, 3),
(889, 3),
(889, 4),
(890, 1),
(890, 2),
(890, 4),
(892, 1),
(893, 1),
(894, 1),
(898, 3),
(899, 1),
(900, 1),
(901, 1),
(902, 1),
(903, 1),
(904, 1),
(905, 1),
(906, 1),
(907, 1),
(908, 4),
(912, 1),
(913, 1),
(914, 1),
(915, 1),
(916, 1),
(917, 1),
(918, 1),
(919, 1),
(920, 1),
(921, 1),
(922, 1),
(923, 1),
(924, 1),
(926, 1),
(927, 1),
(936, 1),
(944, 1),
(945, 1),
(946, 1),
(947, 1),
(948, 1),
(949, 1),
(950, 1),
(951, 1),
(952, 1),
(953, 1),
(956, 1),
(957, 1),
(958, 1),
(958, 2),
(958, 3),
(958, 4),
(960, 1),
(961, 1),
(962, 1),
(963, 1),
(964, 1),
(965, 1),
(965, 2),
(965, 3),
(965, 4),
(966, 1),
(966, 4),
(967, 1),
(967, 3),
(967, 4),
(968, 1),
(969, 1),
(970, 1),
(971, 1),
(971, 4),
(974, 1),
(974, 3),
(976, 1),
(976, 3),
(977, 1),
(977, 3),
(978, 1),
(978, 3),
(979, 3),
(980, 1),
(981, 1),
(983, 1),
(984, 1),
(984, 3),
(986, 1),
(989, 1),
(989, 2),
(989, 3),
(990, 1),
(990, 2),
(990, 3),
(991, 1),
(991, 3),
(992, 1),
(992, 3),
(993, 1),
(993, 3),
(993, 4),
(994, 1),
(994, 2),
(994, 3),
(996, 1),
(998, 1),
(999, 1),
(999, 2),
(999, 3),
(999, 4),
(1000, 1),
(1000, 3),
(1000, 4),
(1001, 1),
(1002, 1),
(1003, 1),
(1003, 3),
(1004, 1),
(1004, 3),
(1005, 1),
(1005, 3);

-- --------------------------------------------------------

--
-- Structure de la table `stage`
--

CREATE TABLE `stage` (
  `id` int(11) NOT NULL,
  `login` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `annee` int(11) NOT NULL,
  `libelleCourt` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `descriptif` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entrepriseNom` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entrepriseAdresse` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entrepriseContact` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entrepriseLogo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `montant` double NOT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `dateModif` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `stage`
--

INSERT INTO `stage` (`id`, `login`, `annee`, `libelleCourt`, `descriptif`, `entrepriseNom`, `entrepriseAdresse`, `entrepriseContact`, `entrepriseLogo`, `montant`, `dateDebut`, `dateFin`, `dateModif`) VALUES
(1, 'test.v2', 1, 'test 1', 'bla bla', 'ent 1', 'adresse 1', 'Aucun', NULL, 0, '2018-04-30', '2018-07-05', '2019-01-08 11:28:43'),
(2, 'test.v2', 1, 'stage', NULL, 'yt', 'etrey', 'Pas', NULL, 10, '2019-05-02', '2019-07-05', '2019-01-10 17:01:21');

-- --------------------------------------------------------

--
-- Structure de la table `stageintitule`
--

CREATE TABLE `stageintitule` (
  `idIntitule` int(11) NOT NULL,
  `intitule` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `idStage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `stageintitule`
--

INSERT INTO `stageintitule` (`idIntitule`, `intitule`, `idStage`) VALUES
(1, 'intitulé 1', 1),
(1, 'base de données', 2),
(2, 'intitulé 2', 1),
(3, 'Base de données', 1);

-- --------------------------------------------------------

--
-- Structure de la table `stageintituleactivite`
--

CREATE TABLE `stageintituleactivite` (
  `idStage` int(11) NOT NULL,
  `idIntitule` int(11) NOT NULL,
  `idActivite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `stageintituleactivite`
--

INSERT INTO `stageintituleactivite` (`idStage`, `idIntitule`, `idActivite`) VALUES
(1, 1, 1),
(1, 1, 5),
(1, 2, 4),
(1, 3, 36),
(1, 3, 40),
(1, 3, 42),
(2, 1, 36);

-- --------------------------------------------------------

--
-- Structure de la table `stagetypo`
--

CREATE TABLE `stagetypo` (
  `idstage` int(11) NOT NULL,
  `code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `stagetypo`
--

INSERT INTO `stagetypo` (`idstage`, `code`) VALUES
(1, 4),
(2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `typologie`
--

CREATE TABLE `typologie` (
  `code` int(11) NOT NULL,
  `lngutile` int(11) NOT NULL,
  `libelle` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `typologie`
--

INSERT INTO `typologie` (`code`, `lngutile`, `libelle`) VALUES
(1, 56, 'Production d’une solution logicielle et d’infrastructure'),
(2, 55, 'Prise en charge d’incidents et de demandes d’assistance'),
(3, 49, 'Élaboration de documents relatifs à la production et à la fourniture de services'),
(4, 53, 'Mise en place d’un dispositif de veille technologique');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `login` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `classe` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `nom` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prenom` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mail` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `roles` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `numParcours` int(11) DEFAULT NULL,
  `sexe` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateNaissance` datetime DEFAULT NULL,
  `numExamen` int(11) DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pwdEnClair` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`login`, `password`, `type`, `classe`, `nom`, `prenom`, `mail`, `salt`, `roles`, `numParcours`, `sexe`, `dateNaissance`, `numExamen`, `adresse`, `pwdEnClair`) VALUES
('a.tarbouriech', 'd455713577fb0a3c4a8baa8761e9fd2a41b066d899b1c35d277811df381517791c52b61ef7602a89277f92d51e96eac9603a5980c896bcc6ff587e168ce58764', 1, 'B1', 'TARBOURIECH', 'Anthoine', 'a.tarbouriech@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('adrien.figueiredo', 'a8a6bd62a6611a65d93121736901d4534e0264c9b48e832e905ca758c6e4fe7056d098f03700bd48e1f05727eecddd63190bec2e057687c0e7e2a3d3cd1281a4', 1, 'B2', 'FIGUEIREDO', 'Adrien', 'adrien.figueiredo@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('adrien.meynard', '30dc994dfb5f1514dc96fb91452eda2c81609fdbc1724f1328074af2c74f6967f667e79b4eaf019d1d210105c37e1dbcbde00a943eedfb146c4fae45196b2f13', 1, 'B1', 'MEYNARD', 'Adrien', 'adrien.meynard@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('adrien.noel', 'b8284b341df9575f9007933b866a297b0eff798fec5197aba8b19c2f9710e78083ce9e112f4fe5feb002a20501e7dffbe781aaf316bb74255bbd393232647856', 1, 'B1', 'NOEL', 'Adrien', 'adrien.noel@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('alessandro.lescole', 'db771560f9c3d5e40865bc823f7eb577166465148c9e408781738bb8e74922597285d9fe29e90e6e3722e722b53c5e3ad72e93d832dd6808c104ed5727ae267c', 1, 'B1', 'LESCOLE', 'Alessandro', 'alessandro.lescole@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('alexandre.bonnet1', 'ad1e05bcf5b4c5cd4cd7d7ca430ead4b431d772e548cc55909139790a9d8899e50bc7dd0facb1f65e5fcfbb09d64a78beed78e5f0be1a9d79e0675a31b865531', 1, 'B1', 'BONNET', 'Alexandre', 'alexandre.bonnet1@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('alexandre.cros1', '5862b875db61841c6dbe652160e74c2fe942a3fc14b3534f406f9ef3e4ac76fc3b1e61238325667bcb2eb2135be6bead04f1a967bcb02e86ae286acb1de7873f', 1, 'B2', 'CROS', 'Alexandre', 'alexandre.cros1@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('alexandre.duval2', 'c24271a3abc821043cc2b727de0bbc8717ce03f261bf699785adecd95356a9b046a5a43fb7943f395ba5ea846216d234a3ed36df0751bd60a4cd03cd8f3b3238', 1, 'B1', 'DUVAL', 'Alexandre', 'alexandre.duval2@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('alexis.turon', '56a765031f8709153d1e5dd37c78c592723026047b254818c03ee6e17dfe5392701c167f4b3eeaa8041c8aa8a52ff67a9cc9491f3dcd1c7450c0cdd1cd736f4b', 1, 'B1', 'TURON', 'Alexis', 'alexis.turon@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('allan.lhomme', 'ca52321a7bdb18a39b21bd65a7a8d3d5fc9378e754e9f70a88d18670d4691acbc1365cb5452d735d23a54b132bca5614fffa4a2a49bbc32345c46686834aed70', 1, 'B1', 'LHOMME', 'Allan', 'allan.lhomme@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('amandine.thon', '8f65132c4077ce15a5d825be9fe515d368c0d511c46d1e8e2f402c0769c16c39a508b19c3769c6db7f026b835cc6c5b385da73125fac84e4f1aaa869794bd01b', 1, 'B1', 'THON', 'Amandine', 'amandine.thon@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('anthony.perrin2', 'b06a91a76c8ce395c85905e9389fbb39a98c7f93391d67b6e53a4bf66b9c4989dbfd4bce6f710b6bb42ff1da4320702b092b4ec8271dfa87f0867c45845aa53d', 1, 'B2', 'PERRIN', 'Anthony', 'anthony.perrin2@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('antoine.droillard', 'dd7fcd60072961ca3c47c1f54766130a2649fb1a01caa8a5ce393928a7e39c6523cb4e801ce6c84df6c51a9aa694ed4d7175b53f963eda3264a389ccc9307963', 1, 'B1', 'DROILLARD', 'Antoine', 'antoine.droillard@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('antoine.gimenez', '66a85dc38c44de74fb425c8466190ebfd1446b7395f860548a33e3c9d7ddc570b9e5c83ab423f70eb6838b4dacaabd5675549802b58ef92aad73902ec118253c', 1, 'B2', 'GIMENEZ', 'Antoine', 'antoine.gimenez@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('antoine.plagnol', 'b16572facc3eb6a5743a54e4fd80eeddc08751f1d720fb43072bbfb9c9d48803e2de94df814fd76c87a7d5d94cb2827e1c11fbfa673eb592805e8d5c27027beb', 1, 'B2', 'PLAGNOL', 'Antoine', 'antoine.plagnol@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('arnaud.royo', '74231c8af9a7e6934bd875e48f5a89eb18c170cf3b03261146941ef170f4aff58d84eac4656d6acb8a010ec173632ffe1476d5e1b63f7fb736c26b1b6a0960f8', 1, 'B1', 'ROYO', 'Arnaud', 'arnaud.royo@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('arthur.audenaert', '82aa4cb4b097de99191f877c2cf80b70f6882ac6f6523bb571f3faa8f74435ec7f08107393984da0805b485a6c51a889a62666afa3cf104f012bf5b456b51c14', 1, 'B1', 'AUDENAERT', 'Arthur', 'arthur.audenaert@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('aurelien.loyer', '0beb16e5d58b66d79fb27d100b80c2e8d2d47e69d6abc5579a9a56d226b84697432ffbf13c782304e71335fbc7db54ae5cbc0d04de7a2d5200e59027372caff6', 1, 'B1', 'LOYER', 'Aurelien', 'aurelien.loyer@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('axel.laisney', '884147b05dcb9dd2ffab4757a613974c14d7ce5808ee533f99a5a69dcf5223651de52ff5ff7f55459d6ddd973c5f3895a77b4b90cb746a1f544d96ed4478132e', 1, 'B1', 'LAISNEY', 'Axel', 'axel.laisney@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('ayman.zerouali', '0242ffbc86a0e3b37e4917c847760b63e0d55b7363da370ac793c214a8756f0d7f184a995b33de2474d41418690f5d6b2dd0ef787df880cebb138425e0c69ed9', 1, 'B1', 'ZEROUALI', 'Ayman', 'ayman.zerouali@epsi.fr', '', 'ROLE_USER 	', 2, '2', NULL, NULL, NULL, ''),
('bastien.bonnel', '3a6fd17396456c75bed8c9a6d85c155c5261048c8d3e55189cff9c3e13c6a6adcddaa8597f03c57e64f2eae719c69bd31b0615cd0b4ba19674a6ab868978ca7d', 1, 'B1', 'BONNEL', 'Bastien', 'bastien.bonnel@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('brayan.oudard', '13203ac9731c5b34bbbb8eb919773c22d6ccac91d1cfc9e74803b09da7e67131f89b08798ebcb8552210d3bc0583c01540fa55d0719b3f79467278311bb6cd15', 1, 'B1', 'OUDARD', 'Brayan', 'brayan.oudard@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('c.tarododelafuente', '90f972ce8f283a3ee75674302bca41f1b04f054c7e41b9ab0e23e7de9969f8abd15acbd895fe7e232b061de9b316f54645e5a632f89f66ecef5105a34569decb', 1, 'B1', 'TARODO DE LA FUENTE', 'Clément', 'c.tarododelafuente@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('cedric.rouichi', '5a2775f6dbaa3f56f4a92ed592c019478c7425e0bbf1e5b3ae8599b5bafd76ac6ce5ec445cb3291468436d4ba97288e5ca63c66cc5ab7acf9469c48259a547ce', 1, 'B1', 'ROUICHI', 'Cédric', 'cedric.rouichi@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('clement.blanchard', 'b3c87c05e2ba44d5d8dd14e9b22ab18edfa1c36386b20be3a5c2fbda37e1676068fdf389c00a16c765b85edf1cdaedef1c30d16128f1115247fcf20a3244d359', 1, 'B1', 'BLANCHARD', 'Clément', 'clement.blanchard@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('clement.knoderer', '049e932e72b571ce9889366bdf44b7e2c424bd00192ac405b44925dc0bb0160af88ad9dcae9df89820823e07dfd5ae68c1937c72200d2dbcf7a7c3f18ad4f6af', 1, 'B1', 'KNODERER', 'Clément', 'clement.knoderer@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('clement.mignon', 'f14fbbfb2cf3cdb5c97047b208a0cfeea609d9550e7522c6044a78f88631f133c090d860bc901895e54178aaaf1bdfb4254b9f4dd604714f75a028d12eaeb32d', 1, 'B1', 'MIGNON', 'Clément', 'clement.mignon@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('david.moreau2', 'cbf8501db88e2e2a85f034539d3e07bcf9046f46382188cc0b667391ae82a80e5305c91f7872c7a959d8f2f077191aef82f49db251a027873b2a0ebc4b7dad7d', 1, 'B1', 'MOREAU', 'David', 'david.moreau2@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('delphine.tran', 'd8a2791d115ab8d26252e544288b239bf92ae797712d6b9cb44d0003fb91ed9db4726b6f4cea82dd90491b902169e4a73bf48edf7b5c9d87a9078d8ec722a772', 1, 'B2', 'TRAN', 'Delphine', 'delphine.tran@epsi.fr', '', 'ROLE_USER', 2, '1', NULL, NULL, NULL, ''),
('e.plouinalbinola', '2f3a5878786365d26c107afe1f8c2f5b4413e13efcd54103c3944d24c3cc86623f6e2bcedcce691ac40d299a233a472a81f829a91ee07a376db183593a28ac43', 1, 'B1', 'PLOUIN-ALBINOLA', 'Edgard', 'e.plouinalbinola@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('emirkan.cakir', 'b7678b85f836dce49976e8025114632022a8d8e9f4de27a468b00985de230bdf525ebce0958a84f1d563edb8caf45f06c0c1a04fc72d095ee0414e43fa7817bd', 1, 'B1', 'CAKIR', 'Emirkan', 'emirkan.cakir@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('fabien.dufes', '71ec85d179e7ca12e0adaf6ee5a150a0b29c03813b296c25e48dd0ed8d70c28cc1f46ff79dbf0fe48703577d3574e701ec69d5edab67aeae8989e26653912443', 1, 'B1', 'DUFES', 'Fabien', 'fabien.dufes@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('florent.oddo', '43f05c2302bb2704bd48943afe69adc215530c3d66a86e09e8c782cb9458a81b0778d468669c45802d2b2456d24b3f8a0f2885da06f6a724898ce707fd67118a', 1, 'B1', 'ODDO', 'Florent', 'florent.oddo@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('francoismarie.lauze', '544589f4094e63127bf2ddcdb39b12afaef54380247db24afcac67cd1cf2d2ed2f29d174a2dc7c2b3d69370e2dc33b5a10644bdaa71133ff5c9d7f371d985100', 1, 'B1', 'LAUZE', 'Francois-Marie', 'francoismarie.lauze@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('gabriel.martin2', 'bdad17278fa6d95d531c144d62f2357e7bed35c0555b0a5f08a2eabe827b3e0ab7fd4c2f89c49248054257b52cbf7223f478b6d53051276a7737a1a9469cf5a7', 1, 'B2', 'MARTIN', 'Gabriel', 'gabriel.martin2@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('gaspar.tissier', '6fcd7b3264f72c93439583037549d0667fe1135a6f44e12ea5094e1d26265aa58cc9556b79d049ab0be2024a420e51e929fed3bcbf246b88c4ffed0cd82375e8', 1, 'B1', 'TISSIER', 'Gaspar', 'gaspar.tissier@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('gauthier.fages', '8c8bf1bf969e0eec76439b4cbadfa3e1b4117a6916a2c94def124922a5fa78c4842559a99760ea068e36429569f2f918051b16b0e3d09006b63a3913e29901aa', 1, 'B1', 'FAGES', 'Gauthier', 'gauthier.fages@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('gautier.privat', 'b5c405bcde9094d28547912705d3c4dfb012e7bae00ead509e41d02d88906175baf3f51cae7be02a8b2a2dfc3e1ebfd6d1fe807fc1e57bb5ad99934993a8259b', 1, 'B1', 'PRIVAT', 'Gautier', 'gautier.privat@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('ghislain.damou', '2d7e9421cb69a6d9a51da65cb122400ea96f3ba2d2fcc355266945f44be074b83ef789013b5ddab4f39978f88e9edc9578197aebb72e4aa8c4960abf56a97d2c', 1, 'B1', 'DAMOU', 'Ghislain', 'ghislain.damou@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('greg.doursin', '75edca71a2396e3d8d3e2e379e2a5eb65e04b94aa194cf7c53effb2564ee183c858e31b5db8df02b7ea710c192cd7302cd997d38d8a3e0fc6c7ddeec29a0c692', 1, 'B1', 'DOURSIN', 'Greg', 'greg.doursin@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('guilhem.batifol', '545a07ff3276cbe1b75bed31654f7bdd62811abafe5be1284f53a5e8ada59dc5b31dfcb4cd02b1558394c19b2b05bf95d7c6654dd81dead54a10af6cc3069c0a', 1, 'B1', 'BATIFOL', 'Guilhem', 'guilhem.batifol@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('hugo.ruff', 'bbe9d753188178aac0b7c5051e11e552ca99ff4ebbfcd30ab008e6c7c93f9ecf1bb0887b8fff5210700de9a9dcef9111f81df6eae651ae27c7fe30c115fde8eb', 1, 'B2', 'RUFF', 'Hugo', 'hugo.ruff@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('idrissa.ndiaye', 'e1bc3878912fcc98721f7d5ff3a5cd25b7cc7d1fb5ac26e48b4fd4ae65cf004962e89a290097c06b8ccfc9316923e5551b6fe167eaf5748e13d201d6457c2066', 1, 'B1', 'NDIAYE', 'Idrissa', 'idrissa.ndiaye@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('j.quetchevallier', '25e4a615009a59be63582d4418c03ac1fb5a501180f5a22668c162b66cfc64d0c7898aa0989f961e8c5f83784c640eb5301811c7f1f429666beffdb80efa1980', 1, 'B1', 'QUET-CHEVALLIER', 'Jonathan', 'j.quetchevallier@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('jeanbaptiste.poul', '39f37e7ac71c09e410159a63083230939c5646591b280d3c96599e49e1c08f1283400d3c5ba9ad4b08c8da2920891da201f74efd216ee3856c5746eca4e8b067', 1, 'B2', 'POUL', 'Jean-Baptiste', 'jeanbaptiste.poul@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('jeancharles.cano', 'd632e35d8abc0171fd6e7070dbe6bf82bf8999e8932c60ed764633773927234a1de694a334bd4f1a9fc024b8ba2cf4d993f8929878c7b2656a973ff427cd5363', 1, 'B1', 'CANO', 'Jean-Charles', 'jeancharles.cano@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('leonard.mondet', '26e7577fb623a55904b0a4957aec2f30dbf2e1960a18e1c2ca5bf0f6bea66aeea259b72bec52c18b33b8c21c2cbed1de7eb13f18580f05c7f402e2fecdcb824b', 1, 'B1', 'MONDET', 'Léonard', 'leonard.mondet@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('lilian.michaux', 'accbb76996adc4ef188862bf6846be901b901b213a053549fb4263b4c3b0b879064944f7fd308f62d5c8d2a3742a1c216f78a5aed61344d9f37eaf2bbfa8837d', 1, 'B1', 'MICHAUX', 'Lilian', 'lilian.michaux@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('lucas.delpierre', 'af869b8b3efcbc42ae9abfdbfe9bbca617e58d5000dcb3f5a2e62be4a57a7ae8093cf4dacee2c834fd3e8cd9eca29596c0ff396fa6e780111cdd7d93486822b2', 1, 'B1', 'DELPIERRE', 'Lucas', 'lucas.delpierre@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('lucas.joubert', 'da0d2ad63d1708fa8ce99e23fd93da2adc7f4803eda4fd3c74f6146e2b9c9275f86308e6b54777e9557381b11750168bc4664b198b37c4634fe577cb6f3dd37a', 1, 'B1', 'JOUBERT', 'Lucas', 'lucas.joubert@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('lucas.magnien', '24f48740c8b847b11cf06056ce44af98e2e4b3d34456bad326781a0fb43e98216922966a3235b8429ca855a5b43058636e54a5072abba08f1ad3e4e899895980', 1, 'B1', 'MAGNIEN', 'Lucas', 'lucas.magnien@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('ludovic.tournier', 'b4d3ba26d155c7c50433bc31ba03a05fc24e2041bc7b3f4189479eb9e8798d8a03ac1f4b50095187a6c8cf9ed62feb57df1ae6e7095062d23c9f33d3ec961d75', 1, 'B1', 'TOURNIER', 'Ludovic', 'ludovic.tournier@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('marin.leonard', '245eed715fc6140e2d8d194e971f00660cf4e8ab177ead8f2312d654650925f1439d5484de856ce9e126c551016a31771dd144b09dd744de4edadae5d8de8ca5', 1, 'B1', 'LEONARD', 'Marin', 'marin.leonard@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('martin.azam', 'a4a2c7acbcf367e87a4704037dd12958d5e3cefa5e4dd3a6beaae8924e1c0ebe9047fe23a6cb8b014327ca2154d6491e6eb05990ec155572ed680ad77ae02ea5', 1, 'B1', 'AZAM', 'Martin', 'martin.azam@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('mateo.thiebault', '90e33791e274994c84b391a0158bf1781de207f512eeb990804709e3c3776390ab492f54a334d30f6fade582ef4a55004376e634de21d5ef1424164aef2a5aff', 1, 'B1', 'THIEBAULT', 'Mateo', 'mateo.thiebault@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('mathieu.regis', '818c242b1d38216fb3049e2807f75542df6f2e23a7b8050aa9b25489c48756e7a59f891c98bc5306a389b77db1fd34912096e41d9c2588ebea942a14749dbbd4', 1, 'B1', 'REGIS', 'Mathieu', 'mathieu.regis@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('mathis.flinois', '5bb7426f7d7086830943ee80ffee1cfe177a2682a4f30f6738118cb3e069a339f42143df43a5e1d80e3446b4585631e7573f3ee30398df01748bd6761c6a66dc', 1, 'B1', 'FLINOIS', 'Mathis', 'mathis.flinois@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('nathan.milhe', 'e314cdf1e7fd5b173312a4d77f1950a99d74f5dd18e800bee2b4869e4087f4781eeec363f99b2360b49c122d998a03d0e299175411f956c17e55c09cf3d1c658', 1, 'B2', 'MILHE', 'Nathan', 'nathan.milhe@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('nathan.peraldi', 'fd2d5e9afcb53ef14a378f9d6f54a8601200118152e42825d12a7710be011b3ec8232737b585b74e017a41df3477b1a96d12b6f6ec3e8b6dfc0688a54e54f90f', 1, 'B1', 'PERALDI', 'Nathan', 'nathan.peraldi@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('ndeyekhady.ndoye', '8f7d69af0d376eab220d8fe2383ec28989c3f3237d4cffc9fb28854e90b74cb832bbe706a5a6bac137a19febb844256e73267005852d127b407c6458fdaf986d', 1, 'B1', 'NDOYE', 'Ndeye Khady', 'ndeyekhady.ndoye@epsi.fr', '', 'ROLE_USER', 1, '1', NULL, NULL, NULL, ''),
('nicolas.carayon', 'edd3d44c44c6ac23163b37df869b9b6d6284b3af7c9e939e3276b95bc6c6a5f64397a6e0a59848aa4b7a92f39130329f410566f0485f764a27ceb3573743ecc5', 1, 'B1', 'CARAYON', 'Nicolas', 'nicolas.carayon@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('paul.colombier', '7f543b3ef1f87d35f1860624fa0750cdd2bb5301bd652f70a4254a06cdecbdc9933e0003dccb3cb01c067eee3fb988e2e6b648dfc31710a84ca9f4369dcfd043', 1, 'B2', 'COLOMBIER', 'Paul', 'paul.colombier@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('pierre.noble', '430fd9b950d4680829fbe0dbb319bb0e672c579a28246751a7f9e43f535c2dc4aaf438599f1fc09236da291179eb8056b0c408edf6e6201dbd26b7e3e056da2d', 1, 'B2', 'NOBLE', 'Pierre', 'pierre.noble@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('quentin.bernard2', '3955edd91d8ebbc6b087fa0eb03fb77d1a6e8d0ba9663d8a8e99cb7b76a829df3adc16a29db154beaffb400835a12df5a79c8b55495925634098e43b823c77ce', 1, 'B2', 'BERNARD', 'Quentin', 'quentin.bernard2@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('quentin.tarodo', 'c99e33f431df2c6b107257abc08849d0b096f45f7cbe8dba7302e366aa958f880f0bea71bf3d1bd432ab778942c564e7e7278e5a1a957e1086f89fafbe08bcaa', 1, 'B2', 'TARODO', 'Quentin', 'quentin.tarodo@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('remi.assidi', 'b0d1e048bce96de8c77e894c2501e1a70bc299b00a8ffa5e82d15a7f81d5b0cfe0d3f37138bd140a47149ee5430ad78a4cf40a445f2512ea479ee17af8cedfab', 1, 'B1', 'ASSIDI', 'Remi', 'remi.assidi@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('robin.legras', '2a654d1872476e77d47f4b5a719706082ddb81a5127d7ce1fa72da974d113c528757ad513f9ec7818bb07d462bcb649bea745f97d0ecc82dce18611ade661bab', 1, 'B2', 'LEGRAS', 'Robin', 'robin.legras@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('romain.bonnes', '11265fcc34b4066afee246040089e8dbed5c2eefd432eee70a388f920dcc1f7bc858ed7a180ff96f3e3b2a4b85b376645d3b9ecebbde7b323b45829b301142a5', 1, 'B1', 'BONNES', 'Romain', 'romain.bonnes@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('romain.ortiz', '4284bf1ef626471ac81bdd96631bdb460fa8ca8327d5f3cf0a1dcbaecc685e21e1aeb752d76935d833b6e3b3a916f48ca0be9ed6086ad54a94726a3289539d52', 1, 'B1', 'ORTIZ', 'Romain', 'romain.ortiz@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('romain.prangere', '6729aa3d1d6bf2d7a5e9aea36cb93e8482e96f8163b84e4c37c9686dd192e4990d03cb16006e30f855b97fafe721bd946cc22ef7cafdb5c5424889e8a1d91587', 1, 'B2', 'PRANGERE', 'Romain', 'romain.prangere@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('ronan.quenechdu', 'a562aa875dd7b3ff879492df3ddaa9cc411bf091d18100de986d1df173b9093b150d9605a5149fa2ed198b58f7c610b507b18ce68bffef70a44eaf2b788aafb2', 1, 'B1', 'QUENECHDU', 'Ronan', 'ronan.quenechdu@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('steine.mbina', 'e57cde82590414b8a0b80b43c61b7adc6da3aa24e570adef45127c219ea9d9d2fba1b0af048a46e8af1b83edb7e5960a0d326ec3265974bc5f3ddef9dfd6420e', 1, 'B1', 'MBINA MOMBO', 'Steine', 'steine.mbina@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('t.ferauddentinger', '458ab0abcd6ad1538a3a73628a3cc68809a6aa44f11ac8745378fb10a76a81534311ab7b9e785d03066cad4cafcb98bfd3606435f6c27c2bfdf4d0650ba0f119', 1, 'B1', 'FERAUD DENTINGER', 'Tino', 't.ferauddentinger@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('test.prof', '00c9e8bf30e5c8980d5a70bb336f892c7c23a47f316a6054c9041e677d35e66aab72cabb9eb2a858a7a6f4cc55cb2cff0de1387968ea09528759e017f0ab5ce3', 1, 'B2', 'PROF', 'Henry', 'jlb.epsi@gmail.com', '', 'ROLE_PROF', NULL, '2', '1995-06-23 00:00:00', NULL, NULL, ''),
('test.prof2', '00c9e8bf30e5c8980d5a70bb336f892c7c23a47f316a6054c9041e677d35e66aab72cabb9eb2a858a7a6f4cc55cb2cff0de1387968ea09528759e017f0ab5ce3', 1, 'B2', 'PROF2', 'Marcel', 'jlb.epsi@gmail.com', '', 'ROLE_PROF', NULL, '2', '1995-06-23 00:00:00', NULL, NULL, ''),
('test.v2', '00c9e8bf30e5c8980d5a70bb336f892c7c23a47f316a6054c9041e677d35e66aab72cabb9eb2a858a7a6f4cc55cb2cff0de1387968ea09528759e017f0ab5ce3', 1, 'B2', 'TEST', 'v2', 'test.v2@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('test.v2sisr', '00c9e8bf30e5c8980d5a70bb336f892c7c23a47f316a6054c9041e677d35e66aab72cabb9eb2a858a7a6f4cc55cb2cff0de1387968ea09528759e017f0ab5ce3', 1, 'B2', 'TESTR', 'v2Sisr', 'test.v2sisr@epsi.fr', '', 'ROLE_USER', 1, '2', NULL, NULL, NULL, ''),
('testa.v21', '00c9e8bf30e5c8980d5a70bb336f892c7c23a47f316a6054c9041e677d35e66aab72cabb9eb2a858a7a6f4cc55cb2cff0de1387968ea09528759e017f0ab5ce3', 1, 'B2', 'TEST', 'v2', 'testa.v21@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('theo.simoes', 'dfba438e535c7d1a4109dd0d4980f9c441255e9bbbbf9243743c6971c65f226f2f90e1101b65205f2fa9071e6e151960ab47ce1422a2e62b132f04970edf0aa5', 1, 'B1', 'SIMOES', 'Théo', 'theo.simoes@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('thibault.demay', '44cd85ea2329de528af576cdb598cd4cb4ef5a763bac223184408b3f062075caa137dded7506c8fc01ac4a807e8ed26e2b2cb51d01f8f1941aadadd39de6ca9a', 1, 'B1', 'DEMAY', 'Thibault', 'thibault.demay@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('thomas.salvignol', '3d8d385be641295e71c8ea8ac8b50670a83c40f366f9db727d08801a2436c46e1829525b3e36dde257c308669a91b220d3c379628238f4fcc46e45b106e2ec46', 1, 'B1', 'SALVIGNOL', 'Thomas', 'thomas.salvignol@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('tom.gaillard', '950c45c1f593c9633b9e8fbb6c993550f1a56998a66c344248ce3aba205822513799f73be88f6472021ee1b45014d0c3ae2493f32565a81d38d53c5c13660c48', 1, 'B1', 'GAILLARD', 'Tom', 'tom.gaillard@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, '921DQE'),
('tristan.bouchier', 'de7e495645e8447369f14b05bcc2d4e1b0dfc30926f86fd44d3e2230ab4af85056998e8149d3e160733cb7c89a3ed9281949fc3dbacc35aa2ab50cf78754b2f2', 1, 'B2', 'BOUCHIER', 'Tristan', 'tristan.bouchier@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('valentin.llavero', 'a241091257000b28319a07e88e396d54d77983270df5d5f42a53954faff8d7b646ba703d59cdcf1b52f3874a50277fa70505e46b54d3600c71b71dc0a736bf26', 1, 'B1', 'LLAVERO', 'Valentin', 'valentin.llavero@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('valentin.moulin', 'c17c0626c7cbe786b6e0257c78c545422363353aa63d1d184c5a6c2a0a27ded950bf16738b3f77c395c7d20ba046834c7a22c8970a08625c773be662e6ea5364', 1, 'B1', 'MOULIN', 'Valentin', 'valentin.moulin@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('valentin.wynands', '3553c99d9cdb9f0747c59806ffdc870e96a4e146249d2203aa8f84a5ac677b7d6c389d6402e1a69f7b5ae917bf31925211291be8192e1c1a3d77a3076b9c3bee', 1, 'B1', 'WYNANDS', 'Valentin', 'valentin.wynands@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('victor.duval', '58316f1bc406ae1ac62a55430b3bd3c0f8b0107c77e4f1151939f974b74a2abbc5ecc45ef217768fe11ed998d6b2c3db4f3a2b568160844a2075893a7a496d1a', 1, 'B1', 'DUVAL', 'Victor', 'victor.duval@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('vincent.marignier', 'bb91111166b0d79c2e1e9ad22b004be10e1e26ac0bf60df09cae771e4317521b3c2a082c18b07af603afc379e39fdd08af0c80676beba39b7e8627e3815ed114', 1, 'B2', 'MARIGNIER', 'Vincent', 'vincent.marignier@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('vincent.platet', '4452d3bea3d843d166f912bf44cf5371b001198126b18dd9f79642f1df5434fe1cf51c658884d2ddf36e8ffaca58619a7d0e1c98242306c328d40b78c3571ff1', 1, 'B1', 'PLATET', 'Vincent', 'vincent.platet@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('vincent.vialla', '8b42a23a9651fc5a5827053eeda0bcf50403d2e17872fcd590b2cf41fa7dee4415a4e4f799168867d9c09a66fb7f5823988b316b25e2e468970f71a49a546aa7', 1, 'B2', 'VIALLA', 'Vincent', 'vincent.vialla@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('vivien.thiebaut', 'ea26487980c2c98ad28fce2aab52448f65698b5d6a9c4d6e171c04c75ea63138fef3b668f492107da4077756af3dcb23083dfd3061b6251c2cb93a467ad63fc5', 1, 'B1', 'THIEBAUT', 'Vivien', 'vivien.thiebaut@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('willy.inzelrac', '27c0b3d1f072d501d3b8d35cc522abb75719f52ca7800f38055a3f5dbbf46d7117331f6ac25f7bcccc2b42b1f7766bca8f92c22d67b6e32834d24fb9b5c583d0', 1, 'B1', 'INZELRAC', 'Willy', 'willy.inzelrac@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('yohan.angelini', 'c96aaa4e379bdadb6e37a4e20c8bab1db7d339d02e04a8c9720835046b0c7e3fb436fa629d4eb70620fa9c9c6196cd6cd68213e6c53fc7e6c3ffa2dad3d6cc54', 1, 'B2', 'ANGELINI', 'Yohan', 'yohan.angelini@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, ''),
('youssef.zriouh', 'b7c08e18a7f5d98e0c0223342820e17b1f179dd9095181b34bf7c64d2483afae669d37bf5e394fd8b8c140cd8df4e7a79cc0d763cd11edd71333395622d2960f', 1, 'B1', 'ZRIOUH', 'Youssef', 'youssef.zriouh@epsi.fr', '', 'ROLE_USER', 2, '2', NULL, NULL, NULL, '');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `activite`
--
ALTER TABLE `activite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idDomaine` (`idDomaine`);

--
-- Index pour la table `activitecitee`
--
ALTER TABLE `activitecitee`
  ADD PRIMARY KEY (`idActivite`,`refSituation`),
  ADD KEY `IDX_2C1E1D9EBD67F4E` (`idActivite`),
  ADD KEY `IDX_2C1E1D9C60B9B8E` (`refSituation`);

--
-- Index pour la table `cadre`
--
ALTER TABLE `cadre`
  ADD PRIMARY KEY (`code`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `FK_Commentaire_Situation` (`refSituation`),
  ADD KEY `loginProfesseur` (`loginProfesseur`);

--
-- Index pour la table `competence`
--
ALTER TABLE `competence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Competence_Activite` (`idActivite`);

--
-- Index pour la table `domaine`
--
ALTER TABLE `domaine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Domaine_Processus` (`idProcessus`);

--
-- Index pour la table `epreuve`
--
ALTER TABLE `epreuve`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `evalue`
--
ALTER TABLE `evalue`
  ADD PRIMARY KEY (`idParcours`,`idEpreuve`,`idActivite`),
  ADD KEY `idEpreuve` (`idEpreuve`),
  ADD KEY `idActivite` (`idActivite`);

--
-- Index pour la table `exploite`
--
ALTER TABLE `exploite`
  ADD PRIMARY KEY (`idParcours`,`idProcessus`),
  ADD KEY `IDX_278646A8CA12F4B8` (`idParcours`),
  ADD KEY `IDX_278646A81200A74B` (`idProcessus`);

--
-- Index pour la table `framework`
--
ALTER TABLE `framework`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `langage`
--
ALTER TABLE `langage`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `langageframework`
--
ALTER TABLE `langageframework`
  ADD PRIMARY KEY (`idlangage`,`idframework`);

--
-- Index pour la table `operatingsystem`
--
ALTER TABLE `operatingsystem`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `parcours`
--
ALTER TABLE `parcours`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `processus`
--
ALTER TABLE `processus`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `situation`
--
ALTER TABLE `situation`
  ADD PRIMARY KEY (`reference`),
  ADD KEY `FK_Situation_Cadre` (`codeCadre`),
  ADD KEY `FK_Situation_Localisation` (`codeLocalisation`),
  ADD KEY `FK_Situation_Source` (`codeLangage`),
  ADD KEY `FK_Situation_TypeSituation` (`codeFramework`),
  ADD KEY `FK_Situation_Utilisateur` (`login`),
  ADD KEY `codeOS` (`codeOS`,`codeService`),
  ADD KEY `codeService` (`codeService`),
  ADD KEY `refe4` (`refe4`);

--
-- Index pour la table `situatione4`
--
ALTER TABLE `situatione4`
  ADD PRIMARY KEY (`referencee4`);

--
-- Index pour la table `situationtypo`
--
ALTER TABLE `situationtypo`
  ADD PRIMARY KEY (`reference`,`code`),
  ADD KEY `reference` (`reference`),
  ADD KEY `code` (`code`);

--
-- Index pour la table `stage`
--
ALTER TABLE `stage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login` (`login`);

--
-- Index pour la table `stageintitule`
--
ALTER TABLE `stageintitule`
  ADD PRIMARY KEY (`idIntitule`,`idStage`),
  ADD KEY `IDX_C9D88496D5B8D074` (`idStage`);

--
-- Index pour la table `stageintituleactivite`
--
ALTER TABLE `stageintituleactivite`
  ADD PRIMARY KEY (`idStage`,`idIntitule`,`idActivite`),
  ADD KEY `IDX_37AB326AD5B8D07464CA0FFD` (`idStage`,`idIntitule`),
  ADD KEY `IDX_37AB326AEBD67F4E` (`idActivite`);

--
-- Index pour la table `stagetypo`
--
ALTER TABLE `stagetypo`
  ADD PRIMARY KEY (`idstage`,`code`),
  ADD KEY `reference` (`idstage`),
  ADD KEY `code` (`code`);

--
-- Index pour la table `typologie`
--
ALTER TABLE `typologie`
  ADD PRIMARY KEY (`code`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`login`),
  ADD KEY `FK_Utilisateur_Groupe` (`numParcours`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `activite`
--
ALTER TABLE `activite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT pour la table `cadre`
--
ALTER TABLE `cadre`
  MODIFY `code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `commentaire`
--
ALTER TABLE `commentaire`
  MODIFY `numero` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `competence`
--
ALTER TABLE `competence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT pour la table `domaine`
--
ALTER TABLE `domaine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `epreuve`
--
ALTER TABLE `epreuve`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `framework`
--
ALTER TABLE `framework`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `langage`
--
ALTER TABLE `langage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `parcours`
--
ALTER TABLE `parcours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `processus`
--
ALTER TABLE `processus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `situation`
--
ALTER TABLE `situation`
  MODIFY `reference` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1007;

--
-- AUTO_INCREMENT pour la table `stage`
--
ALTER TABLE `stage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `typologie`
--
ALTER TABLE `typologie`
  MODIFY `code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `activite`
--
ALTER TABLE `activite`
  ADD CONSTRAINT `activite_ibfk_1` FOREIGN KEY (`idDomaine`) REFERENCES `domaine` (`id`);

--
-- Contraintes pour la table `activitecitee`
--
ALTER TABLE `activitecitee`
  ADD CONSTRAINT `FK_2C1E1D9C60B9B8E` FOREIGN KEY (`refSituation`) REFERENCES `situation` (`reference`),
  ADD CONSTRAINT `FK_2C1E1D9EBD67F4E` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`);

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_D865B1C2C60B9B8E` FOREIGN KEY (`refSituation`) REFERENCES `situation` (`reference`),
  ADD CONSTRAINT `commentaire_ibfk_1` FOREIGN KEY (`loginProfesseur`) REFERENCES `utilisateur` (`login`);

--
-- Contraintes pour la table `competence`
--
ALTER TABLE `competence`
  ADD CONSTRAINT `FK_DAFB06C8EBD67F4E` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`);

--
-- Contraintes pour la table `domaine`
--
ALTER TABLE `domaine`
  ADD CONSTRAINT `domaine_ibfk_1` FOREIGN KEY (`idProcessus`) REFERENCES `processus` (`id`);

--
-- Contraintes pour la table `evalue`
--
ALTER TABLE `evalue`
  ADD CONSTRAINT `evalue_ibfk_1` FOREIGN KEY (`idParcours`) REFERENCES `parcours` (`id`),
  ADD CONSTRAINT `evalue_ibfk_2` FOREIGN KEY (`idEpreuve`) REFERENCES `epreuve` (`id`),
  ADD CONSTRAINT `evalue_ibfk_3` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`);

--
-- Contraintes pour la table `exploite`
--
ALTER TABLE `exploite`
  ADD CONSTRAINT `FK_278646A81200A74B` FOREIGN KEY (`idProcessus`) REFERENCES `processus` (`id`),
  ADD CONSTRAINT `FK_278646A8CA12F4B8` FOREIGN KEY (`idParcours`) REFERENCES `parcours` (`id`);

--
-- Contraintes pour la table `situation`
--
ALTER TABLE `situation`
  ADD CONSTRAINT `situation_ibfk_1` FOREIGN KEY (`login`) REFERENCES `utilisateur` (`login`),
  ADD CONSTRAINT `situation_ibfk_2` FOREIGN KEY (`codeCadre`) REFERENCES `cadre` (`code`),
  ADD CONSTRAINT `situation_ibfk_3` FOREIGN KEY (`codeLangage`) REFERENCES `langage` (`id`),
  ADD CONSTRAINT `situation_ibfk_4` FOREIGN KEY (`codeFramework`) REFERENCES `framework` (`id`),
  ADD CONSTRAINT `situation_ibfk_5` FOREIGN KEY (`codeOS`) REFERENCES `operatingsystem` (`id`),
  ADD CONSTRAINT `situation_ibfk_6` FOREIGN KEY (`codeService`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `situation_ibfk_7` FOREIGN KEY (`refe4`) REFERENCES `situatione4` (`referencee4`);

--
-- Contraintes pour la table `situationtypo`
--
ALTER TABLE `situationtypo`
  ADD CONSTRAINT `situationtypo_ibfk_1` FOREIGN KEY (`code`) REFERENCES `typologie` (`code`),
  ADD CONSTRAINT `situationtypo_ibfk_2` FOREIGN KEY (`reference`) REFERENCES `situation` (`reference`);

--
-- Contraintes pour la table `stage`
--
ALTER TABLE `stage`
  ADD CONSTRAINT `stage_ibfk_1` FOREIGN KEY (`login`) REFERENCES `utilisateur` (`login`);

--
-- Contraintes pour la table `stageintitule`
--
ALTER TABLE `stageintitule`
  ADD CONSTRAINT `FK_C9D88496D5B8D074` FOREIGN KEY (`idStage`) REFERENCES `stage` (`id`);

--
-- Contraintes pour la table `stageintituleactivite`
--
ALTER TABLE `stageintituleactivite`
  ADD CONSTRAINT `FK_37AB326AD5B8D07464CA0FFD` FOREIGN KEY (`idStage`,`idIntitule`) REFERENCES `stageintitule` (`idStage`, `idIntitule`),
  ADD CONSTRAINT `FK_37AB326AEBD67F4E` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`);

--
-- Contraintes pour la table `stagetypo`
--
ALTER TABLE `stagetypo`
  ADD CONSTRAINT `stagetypo_ibfk_1` FOREIGN KEY (`idstage`) REFERENCES `stage` (`id`),
  ADD CONSTRAINT `stagetypo_ibfk_2` FOREIGN KEY (`code`) REFERENCES `typologie` (`code`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`numParcours`) REFERENCES `parcours` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
