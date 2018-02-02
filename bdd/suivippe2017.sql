-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Ven 02 Février 2018 à 15:33
-- Version du serveur :  5.7.21-0ubuntu0.16.04.1
-- Version de PHP :  7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `suivippe2017`
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
-- Contenu de la table `activite`
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
(32, 10, 'A3.3.4', 43, 'Automatisation des tâches d\'administratio'),
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
(43, 11, 'A4.1.1', 45, 'Rédaction d\'une documentation d\'utilisatio'),
(44, 12, 'A4.2.1', 44, 'Analyse et correction d\'un dysfonctionnement, d\'un problème de qualité de service ou de sécurité'),
(45, 12, 'A4.2.2', 52, 'Adaptation d\'une solution applicative aux évolutions de ses composants'),
(46, 12, 'A4.2.3', 57, 'Réalisation des tests nécessaires à la mise en production d\'éléments mis à jour'),
(47, 12, 'A4.2.4', 42, 'Mise à jour d\'une documentation technique'),
(48, 13, 'A5.1.1', 45, 'Mise en place d\'une gestion de configuratio'),
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
-- Contenu de la table `activitecitee`
--

INSERT INTO `activitecitee` (`idActivite`, `refSituation`) VALUES
(2, 3),
(4, 3),
(34, 3),
(36, 3),
(40, 3);

-- --------------------------------------------------------

--
-- Structure de la table `cadre`
--

CREATE TABLE `cadre` (
  `code` int(11) NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `cadre`
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
  `loginProfesseur` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `commentaire` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datecommentaire` datetime DEFAULT NULL,
  `refSituation` int(11) DEFAULT NULL
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
-- Contenu de la table `competence`
--

INSERT INTO `competence` (`id`, `nomenclature`, `libelle`, `idActivite`) VALUES
(1, 'C1.1.1.1', 'Recenser et caractériser les contextes d\'utilisation, les processus et les acteurs sur lesquels le service à produire aura un impact', 1),
(2, 'C1.1.1.2', 'Identifier les fonctionnalités attendues du service à produire', 1),
(3, 'C1.1.1.3', 'Préparer sa participation à une réunio', 1),
(4, 'C1.1.1.4', 'Rédiger un compte-rendu d\'entretien, de réunio', 1),
(5, 'C1.1.2.1', 'Analyser les interactions entre services', 2),
(6, 'C1.1.2.2', 'Recenser les composants de l\'architecture technique sur lesquels le service à produire aura un impact', 2),
(7, 'C1.1.3.1', 'Recenser et caractériser les exigences liées à la qualité attendue du service à produire', 3),
(8, 'C1.1.3.2', 'Recenser et caractériser les exigences de sécurité pour le service à produire', 3),
(9, 'C1.2.1.1', 'Recenser et caractériser des solutions répondant au cahier des charges (adaptation d\'une solution existante ou réalisation d\'une nouvelle);', 4),
(10, 'C1.2.1.2', 'Estimer le coût d\'une solutio', 4),
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
(32, 'C1.3.4.2', 'Automatiser l\'installation de la solutio', 12),
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
(47, 'C2.1.2.4', 'Superviser les services et leur utilisatio', 17),
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
(74, 'C3.1.2.1', 'Concevoir une maquette de la solutio', 24),
(75, 'C3.1.2.2', 'Construire un prototype de la solutio', 24),
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
(86, 'C3.2.3.2', 'Mettre à jour la documentatio', 28),
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
(114, 'C4.1.7.1', 'Développer les éléments d\'une solutio', 40),
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
(134, 'C4.2.4.2', 'Mettre à jour une documentatio', 47),
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
(153, 'C5.2.2.2', 'Tenir à jour une liste de sources d\'informatio', 55),
(154, 'C5.2.2.3', 'Évaluer la qualité d\'une source d\'information en fonction d\'un besoi', 55),
(155, 'C5.2.2.4', 'Synthétiser et diffuser les résultats d\'une veille', 55),
(156, 'C5.2.3.1', 'Identifier les besoins de formation pour mettre en œuvre une technologie, un composant, un outil ou une méthode', 56),
(157, 'C5.2.3.2', 'Repérer l\'offre et les dispositifs de formatio', 56),
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
-- Contenu de la table `domaine`
--

INSERT INTO `domaine` (`id`, `nomenclature`, `libelle`, `idProcessus`) VALUES
(1, 'D1.1  ', 'Analyse de la demande', 1),
(2, 'D1.2  ', 'Choix d\'une solutio', 1),
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
-- Contenu de la table `epreuve`
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
-- Contenu de la table `evalue`
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
-- Contenu de la table `exploite`
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
-- Contenu de la table `framework`
--

INSERT INTO `framework` (`id`, `libelle`) VALUES
(1, 'Aucun'),
(2, '.Net Framework'),
(3, 'PHP Framework'),
(4, 'Symfony'),
(5, 'Android'),
(6, 'Angular');

-- --------------------------------------------------------

--
-- Structure de la table `langage`
--

CREATE TABLE `langage` (
  `id` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `langage`
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
-- Structure de la table `operatingsystem`
--

CREATE TABLE `operatingsystem` (
  `id` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `operatingsystem`
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
-- Contenu de la table `parcours`
--

INSERT INTO `parcours` (`id`, `nomenclature`, `libelle`) VALUES
(1, 'SISR  ', 'Solutions d’infrastructure, systèmes et réseaux'),
(2, 'SLAM  ', 'solutions logicielles et applications métiers'),
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
-- Contenu de la table `processus`
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
-- Contenu de la table `services`
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
  `descriptif` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `datedebut` datetime DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `codeCadre` int(11) DEFAULT NULL,
  `codeLocalisation` int(11) DEFAULT NULL,
  `codeLangage` int(11) DEFAULT NULL,
  `codeFramework` int(11) DEFAULT NULL,
  `codeOS` int(11) DEFAULT NULL,
  `codeService` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `situation`
--

INSERT INTO `situation` (`reference`, `login`, `libelle`, `descriptif`, `datedebut`, `datefin`, `codeCadre`, `codeLocalisation`, `codeLangage`, `codeFramework`, `codeOS`, `codeService`) VALUES
(1, 'test.v2', 'test', 'test', '2018-01-02 00:00:00', '2018-01-08 00:00:00', NULL, NULL, 4, 6, NULL, NULL),
(2, 'test.v2', 'SuiviPPE', 'Site de gestion du PPE', '2018-01-01 00:00:00', '2018-01-08 00:00:00', NULL, NULL, 3, 4, NULL, NULL),
(3, 'test.v2', 'Voiture', 'TP Voiture C#', NULL, NULL, NULL, NULL, 2, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `situationtypo`
--

CREATE TABLE `situationtypo` (
  `reference` int(11) NOT NULL,
  `code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `situationtypo`
--

INSERT INTO `situationtypo` (`reference`, `code`) VALUES
(2, 2),
(2, 4),
(3, 2),
(3, 4);

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
-- Contenu de la table `stage`
--

INSERT INTO `stage` (`id`, `login`, `annee`, `libelleCourt`, `descriptif`, `entrepriseNom`, `entrepriseAdresse`, `entrepriseContact`, `entrepriseLogo`, `montant`, `dateDebut`, `dateFin`, `dateModif`) VALUES
(1, 'test.v2', 1, 'test', 'Descriptif', 'entreprisetest', 'Adresse de l\'entreprise', 'Contact de l\'entreprise', NULL, 0, '2018-01-01', '2018-02-24', '2018-01-24 09:39:33'),
(2, 'test.v2', 2, 'eee', 'Descriptif', 'Entreprise', 'Adresse', 'Contact', NULL, 0, '2018-01-02', '2018-01-26', '2018-01-24 09:44:55'),
(3, 'test.v2', 2, 'test 2', 'e', 'Entreprise', 'e', 'e', NULL, 0, '2018-04-02', '2018-06-01', '2018-01-24 09:47:09');

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
-- Contenu de la table `stageintitule`
--

INSERT INTO `stageintitule` (`idIntitule`, `intitule`, `idStage`) VALUES
(1, 'eeee', 3);

-- --------------------------------------------------------

--
-- Structure de la table `stageintituleactivite`
--

CREATE TABLE `stageintituleactivite` (
  `idStage` int(11) NOT NULL,
  `idIntitule` int(11) NOT NULL,
  `idActivite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `stagetypo`
--

CREATE TABLE `stagetypo` (
  `idstage` int(11) NOT NULL,
  `code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `stagetypo`
--

INSERT INTO `stagetypo` (`idstage`, `code`) VALUES
(2, 2),
(2, 4),
(3, 1),
(3, 2),
(3, 3),
(3, 4);

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
-- Contenu de la table `typologie`
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
  `adresse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`login`, `password`, `type`, `classe`, `nom`, `prenom`, `mail`, `salt`, `roles`, `numParcours`, `sexe`, `dateNaissance`, `numExamen`, `adresse`) VALUES
('test.v2', '123ABC', 1, 'B2', 'DUPONT', 'Marc', 'jlb.epsi@gmail.com', '', 'ROLE_USER', 2, '1', '1995-06-23 00:00:00', NULL, NULL);

--
-- Index pour les tables exportées
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
  ADD KEY `codeService` (`codeService`);

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
-- AUTO_INCREMENT pour les tables exportées
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
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
  MODIFY `reference` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `stage`
--
ALTER TABLE `stage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `typologie`
--
ALTER TABLE `typologie`
  MODIFY `code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Contraintes pour les tables exportées
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
  ADD CONSTRAINT `situation_ibfk_6` FOREIGN KEY (`codeService`) REFERENCES `services` (`id`);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
