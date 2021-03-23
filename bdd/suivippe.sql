-- MySQL dump 10.16  Distrib 10.1.48-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: suivippe
-- ------------------------------------------------------
-- Server version	10.1.48-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activite`
--

DROP TABLE IF EXISTS `activite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idDomaine` int(11) NOT NULL,
  `nomenclature` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `lngutile` int(11) NOT NULL,
  `libelle` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idDomaine` (`idDomaine`),
  CONSTRAINT `activite_ibfk_1` FOREIGN KEY (`idDomaine`) REFERENCES `domaine` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activite`
--

LOCK TABLES `activite` WRITE;
/*!40000 ALTER TABLE `activite` DISABLE KEYS */;
INSERT INTO `activite` VALUES (1,1,'A1.1.1',54,'Analyse du cahier des charges d\'un service à produire'),(2,1,'A1.1.2',47,'Étude de l\'impact de l\'intégration d\'un service sur le système informatique'),(3,1,'A1.1.3',47,'Étude des exigences liées à la qualité attendue d\'un service'),(4,2,'A1.2.1',49,'Élaboration et présentation d\'un dossier de choix de solution technique'),(5,2,'A1.2.2',54,'Rédaction des spécifications techniques de la solution retenue (adaptation d\'une solution existante ou réalisation d\'une nouvelle solution'),(6,2,'A1.2.3',57,'Évaluation des risques liés à l\'utilisation d\'un service'),(7,2,'A1.2.4',51,'Détermination des tests nécessaires à la validation d\'un service'),(8,2,'A1.2.5',37,'Définition des niveaux d\'habilitation associés à un service'),(9,3,'A1.3.1',49,'Test d\'intégration et d\'acceptation d\'un service'),(10,3,'A1.3.2',51,'Définition des éléments nécessaires à la continuité d\'un service'),(11,3,'A1.3.3',56,'Accompagnement de la mise en place d\'un nouveau service'),(12,3,'A1.3.4',25,'Déploiement d\'un service'),(13,4,'A1.4.1',25,'Participation à un projet'),(14,4,'A1.4.2',47,'Évaluation des indicateurs de suivi d\'un projet et justification des écarts'),(15,4,'A1.4.3',22,'Gestion des ressources'),(16,5,'A2.1.1',53,'Accompagnement des utilisateurs dans la prise en main d\'un service'),(17,5,'A2.1.2',50,'Évaluation et maintien de la qualité d\'un service'),(18,6,'A2.2.1',32,'Suivi et résolution d\'incidents'),(19,6,'A2.2.2',45,'Suivi et réponse à des demandes d\'assistance'),(20,6,'A2.2.3',37,'Réponse à une interruption de service'),(21,7,'A2.3.1',58,'Identification, qualification et évaluation d\'un problème'),(22,7,'A2.3.2',41,'Proposition d\'amélioration d\'un service'),(23,8,'A3.1.1',45,'Proposition d\'une solution d\'infrastructure'),(24,8,'A3.1.2',58,'Maquettage et prototypage d\'une solution d\'infrastructure'),(25,8,'A3.1.3',48,'Prise en compte du niveau de sécurité nécessaire à une infrastructure'),(26,9,'A3.2.1',57,'Installation et configuration d\'éléments d\'infrastructure'),(27,9,'A3.2.2',49,'Remplacement ou mise à jour d\'éléments défectueux ou obsolètes'),(28,9,'A3.2.3',41,'Mise à jour de la documentation technique d\'une solution d\'infrastructure'),(29,10,'A3.3.1',50,'Administration sur site ou à distance des éléments d\'un réseau, de serveurs, de services et d\'équipements terminaux'),(30,10,'A3.3.2',59,'Planification des sauvegardes et gestion des restaurations'),(31,10,'A3.3.3',42,'Gestion des identités et des habilitations'),(32,10,'A3.3.4',43,'Automatisation des tâches d\'administratio'),(33,10,'A3.3.5',51,'Gestion des indicateurs et des fichiers d\'activité'),(34,11,'A4.1.1',39,'Proposition d\'une solution applicative'),(35,11,'A4.1.2',51,'Conception ou adaptation de l\'interface utilisateur d\'une solution applicative'),(36,11,'A4.1.3',47,'Conception ou adaptation d\'une base de données'),(37,11,'A4.1.4',59,'Définition des caractéristiques d\'une solution applicative'),(38,11,'A4.1.5',35,'Prototypage de composants logiciels'),(39,11,'A4.1.6',53,'Gestion d\'environnements de développement et de test'),(40,11,'A4.1.7',54,'Développement, utilisation ou adaptation de composants logiciels'),(41,11,'A4.1.8',49,'Réalisation des tests nécessaires à la validation d\'éléments adaptés ou développés'),(42,11,'A4.1.9',40,'Rédaction d\'une documentation technique'),(43,11,'A4.1.1',45,'Rédaction d\'une documentation d\'utilisatio'),(44,12,'A4.2.1',44,'Analyse et correction d\'un dysfonctionnement, d\'un problème de qualité de service ou de sécurité'),(45,12,'A4.2.2',52,'Adaptation d\'une solution applicative aux évolutions de ses composants'),(46,12,'A4.2.3',57,'Réalisation des tests nécessaires à la mise en production d\'éléments mis à jour'),(47,12,'A4.2.4',42,'Mise à jour d\'une documentation technique'),(48,13,'A5.1.1',45,'Mise en place d\'une gestion de configuratio'),(49,13,'A5.1.2',44,'Recueil d\'informations sur une configuration et ses éléments'),(50,13,'A5.1.3',45,'Suivi d\'une configuration et de ses éléments'),(51,13,'A5.1.4',43,'Étude de propositions de contrat de service (client, fournisseur);'),(52,13,'A5.1.5',40,'Évaluation d\'un élément de configuration ou d\'une configuratio'),(53,13,'A5.1.6',44,'Évaluation d\'un investissement informatique'),(54,14,'A5.2.1',50,'Exploitation des référentiels, normes et standards adoptés par le prestataire informatique'),(55,14,'A5.2.2',20,'Veille technologique'),(56,14,'A5.2.3',37,'Repérage des compléments de formation ou d\'auto-formation utiles à l\'acquisition de nouvelles compétences'),(57,14,'A5.2.4',51,'Étude d‘une technologie, d\'un composant, d\'un outil ou d\'une méthode');
/*!40000 ALTER TABLE `activite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activitecitee`
--

DROP TABLE IF EXISTS `activitecitee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activitecitee` (
  `idActivite` int(11) NOT NULL,
  `refSituation` int(11) NOT NULL,
  PRIMARY KEY (`idActivite`,`refSituation`),
  KEY `IDX_2C1E1D9EBD67F4E` (`idActivite`),
  KEY `IDX_2C1E1D9C60B9B8E` (`refSituation`),
  CONSTRAINT `FK_2C1E1D9C60B9B8E` FOREIGN KEY (`refSituation`) REFERENCES `situation` (`reference`),
  CONSTRAINT `FK_2C1E1D9EBD67F4E` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activitecitee`
--

LOCK TABLES `activitecitee` WRITE;
/*!40000 ALTER TABLE `activitecitee` DISABLE KEYS */;
INSERT INTO `activitecitee` VALUES (1,1),(1,3),(1,7),(1,12),(1,15),(1,17),(1,18),(1,24),(1,25),(2,18),(3,17),(3,18),(4,3),(4,7),(5,1),(5,3),(5,10),(6,17),(6,18),(6,20),(7,17),(7,18),(9,3),(9,18),(9,20),(10,18),(10,20),(11,18),(12,5),(12,7),(12,10),(12,11),(12,18),(12,20),(12,22),(12,24),(13,3),(13,4),(13,5),(13,10),(13,11),(13,12),(13,15),(13,16),(13,17),(13,18),(13,24),(13,25),(14,17),(14,18),(15,17),(15,18),(16,18),(16,20),(17,18),(17,20),(18,5),(18,18),(18,20),(19,18),(19,20),(20,18),(20,20),(21,5),(21,17),(21,18),(21,20),(22,17),(22,18),(22,20),(23,22),(24,3),(24,22),(25,3),(25,22),(26,3),(26,22),(29,20),(29,22),(30,20),(32,20),(32,22),(34,4),(34,5),(34,7),(34,10),(34,11),(34,12),(34,16),(34,17),(34,18),(35,4),(35,5),(35,7),(35,11),(35,12),(35,16),(35,17),(35,18),(36,5),(36,7),(36,10),(36,11),(36,12),(36,17),(36,18),(36,24),(36,25),(37,4),(37,11),(37,16),(37,18),(38,15),(38,18),(39,18),(40,11),(40,15),(40,17),(40,18),(40,24),(40,25),(41,17),(41,18),(42,15),(42,17),(43,7),(43,15),(43,16),(44,18),(45,18),(46,18),(48,3),(48,10),(48,17),(48,18),(48,22),(49,3),(50,22),(51,7),(52,18),(55,3),(55,22),(56,18),(56,22),(56,25),(57,3),(57,18),(57,22);
/*!40000 ALTER TABLE `activitecitee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cadre`
--

DROP TABLE IF EXISTS `cadre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadre` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cadre`
--

LOCK TABLES `cadre` WRITE;
/*!40000 ALTER TABLE `cadre` DISABLE KEYS */;
INSERT INTO `cadre` VALUES (1,'En équipe'),(2,'Seul');
/*!40000 ALTER TABLE `cadre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentaire`
--

DROP TABLE IF EXISTS `commentaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commentaire` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `loginProfesseur` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `commentaire` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `datecommentaire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `refSituation` int(11) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `FK_Commentaire_Situation` (`refSituation`),
  KEY `loginProfesseur` (`loginProfesseur`),
  CONSTRAINT `FK_D865B1C2C60B9B8E` FOREIGN KEY (`refSituation`) REFERENCES `situation` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentaire`
--

LOCK TABLES `commentaire` WRITE;
/*!40000 ALTER TABLE `commentaire` DISABLE KEYS */;
/*!40000 ALTER TABLE `commentaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competence`
--

DROP TABLE IF EXISTS `competence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomenclature` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `idActivite` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Competence_Activite` (`idActivite`),
  CONSTRAINT `FK_DAFB06C8EBD67F4E` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competence`
--

LOCK TABLES `competence` WRITE;
/*!40000 ALTER TABLE `competence` DISABLE KEYS */;
INSERT INTO `competence` VALUES (1,'C1.1.1.1','Recenser et caractériser les contextes d\'utilisation, les processus et les acteurs sur lesquels le service à produire aura un impact',1),(2,'C1.1.1.2','Identifier les fonctionnalités attendues du service à produire',1),(3,'C1.1.1.3','Préparer sa participation à une réunio',1),(4,'C1.1.1.4','Rédiger un compte-rendu d\'entretien, de réunio',1),(5,'C1.1.2.1','Analyser les interactions entre services',2),(6,'C1.1.2.2','Recenser les composants de l\'architecture technique sur lesquels le service à produire aura un impact',2),(7,'C1.1.3.1','Recenser et caractériser les exigences liées à la qualité attendue du service à produire',3),(8,'C1.1.3.2','Recenser et caractériser les exigences de sécurité pour le service à produire',3),(9,'C1.2.1.1','Recenser et caractériser des solutions répondant au cahier des charges (adaptation d\'une solution existante ou réalisation d\'une nouvelle);',4),(10,'C1.2.1.2','Estimer le coût d\'une solutio',4),(11,'C1.2.1.3','Rédiger un dossier de choix et un argumentaire technique',4),(12,'C1.2.2.1','Recenser les composants nécessaires à la réalisation de la solution retenue',5),(13,'C1.2.2.2','Décrire l\'implantation des différents composants de la solution et les échanges entre eux',5),(14,'C1.2.2.3','Rédiger les spécifications fonctionnelles et techniques de la solution retenue dans le formalisme exigé par l\'organisatio',5),(15,'C1.2.3.1','Recenser les risques liés à une mauvaise utilisation ou à une utilisation malveillante du service',6),(16,'C1.2.3.2','Recenser les risques liés à un dysfonctionnement du service',6),(17,'C1.2.3.3','Prévoir les conséquences techniques de la non prise en compte d\'un risque',6),(18,'C1.2.4.1','Recenser les tests d\'acceptation nécessaires à la validation du service et les résultats attendus',7),(19,'C1.2.4.2','Préparer les jeux d\'essai et les procédures pour la réalisation des tests',7),(20,'C1.2.5.1','Recenser les utilisateurs du service, leurs rôles et leur niveau de responsabilité',8),(21,'C1.2.5.2','Recenser les ressources liées à l\'utilisation du service',8),(22,'C1.2.5.3','Proposer les niveaux d\'habilitation associés au service',8),(23,'C1.3.1.1','Mettre en place l\'environnement de test du service',9),(24,'C1.3.1.2','Tester le service',9),(25,'C1.3.1.3','Rédiger le rapport de test',9),(26,'C1.3.2.1','Identifier les éléments à sauvegarder et à journaliser pour assurer la continuité du service et la traçabilité des transactions',10),(27,'C1.3.2.2','Spécifier les procédures d\'alerte associées au service',10),(28,'C1.3.2.3','Décrire les solutions de fonctionnement en mode dégradé et les procédures de reprise du service',10),(29,'C1.3.3.1','Mettre en place l\'environnement de formation au nouveau service',11),(30,'C1.3.3.2','Informer et former les utilisateurs',11),(31,'C1.3.4.1','Mettre au point une procédure d\'installation de la solutio',12),(32,'C1.3.4.2','Automatiser l\'installation de la solutio',12),(33,'C1.3.4.3','Mettre en exploitation le service',12),(34,'C1.4.1.1','Établir son planning personnel en fonction des exigences et du déroulement du projet',13),(35,'C1.4.1.2','Rendre compte de son activité',13),(36,'C1.4.2.1','Suivre l\'exécution du projet',14),(37,'C1.4.2.2','Analyser les écarts entre temps prévu et temps consommé',14),(38,'C1.4.2.3','Contribuer à l\'évaluation du projet',14),(39,'C1.4.3.1','Recenser les ressources humaines, matérielles, logicielles et budgétaires nécessaires à l\'exécution du projet et de ses tâches personnelles',15),(40,'C1.4.3.2','Adapter son planning personnel en fonction des ressources disponibles',15),(41,'C2.1.1.1','Aider les utilisateurs dans l\'appropriation du nouveau service',16),(42,'C2.1.1.2','Identifier des besoins de formation complémentaires',16),(43,'C2.1.1.3','Rendre compte de la satisfaction des utilisateurs',16),(44,'C2.1.2.1','Analyser les indicateurs de qualité du service',17),(45,'C2.1.2.2','Appliquer les procédures d\'alerte destinées à rétablir la qualité du service',17),(46,'C2.1.2.3','Vérifier périodiquement le fonctionnement du service en mode dégradé et la disponibilité des éléments permettant une reprise du service',17),(47,'C2.1.2.4','Superviser les services et leur utilisatio',17),(48,'C2.1.2.5','Contrôler la confidentialité et l\'intégrité des données',17),(49,'C2.1.2.6','Exploiter les indicateurs et les fichiers d\'audit',17),(50,'C2.1.2.7','Produire les rapports d\'activité demandés par les différents acteurs',17),(51,'C2.2.1.1','Résoudre l\'incident en s\'appuyant sur une base de connaissances et la documentation associée ou solliciter l\'entité compétente',18),(52,'C2.2.1.2','Prendre le contrôle d\'un système à distance',18),(53,'C2.2.1.3','Rédiger un rapport d\'incident et mémoriser l\'incident et sa résolution dans une base de connaissances',18),(54,'C2.2.1.4','Faire évoluer une procédure de résolution d\'incident',18),(55,'C2.2.2.1','Identifier le niveau d\'assistance souhaité et proposer une réponse adaptée en s\'appuyant sur une base de connaissances et sur la documentation associée ou solliciter l\'entité compétente',19),(56,'C2.2.2.2','Informer l\'utilisateur de la situation de sa demande',19),(57,'C2.2.2.3','Prendre le contrôle d\'un poste utilisateur à distance',19),(58,'C2.2.2.4','Mémoriser la demande d\'assistance et sa réponse dans une base de connaissances',19),(59,'C2.2.3.1','Appliquer la procédure de continuité du service en mode dégradé',20),(60,'C2.2.3.2','Appliquer la procédure de reprise du service',20),(61,'C2.3.1.1','Repérer une suite de dysfonctionnements récurrents d\'un service',21),(62,'C2.3.1.2','Identifier les causes de ce dysfonctionnement',21),(63,'C2.3.1.3','Qualifier le problème (contexte et environnement);',21),(64,'C2.3.1.4','Définir le degré d\'urgence du problème',21),(65,'C2.3.1.5','Évaluer les conséquences techniques du problème',21),(66,'C2.3.2.1','Décrire les incidences d\'un changement proposé sur le service',22),(67,'C2.3.2.2','Évaluer le délai et le coût de réalisation du changement proposé',22),(68,'C2.3.2.3','Recenser les risques techniques, humains, financiers et juridiques associés au changement proposé',22),(69,'C3.1.1.1','Lister les composants matériels et logiciels nécessaires à la prise en charge des processus, des flux d\'information et de leur rôle',23),(70,'C3.1.1.2','Caractériser les éléments d\'interconnexion, les services, les serveurs et les équipements terminaux nécessaires',23),(71,'C3.1.1.3','Caractériser les éléments permettant d\'assurer la qualité et la sécurité des services',23),(72,'C3.1.1.4','Recenser les modifications et/ou les acquisitions nécessaires à la mise en place d\'une solution d\'infrastructure compatible avec le budget et le planning prévisionnels',23),(73,'C3.1.1.5','Caractériser les solutions d\'interconnexion utilisées entre un réseau et d\'autres réseaux internes ou externes à l\'organisatio',23),(74,'C3.1.2.1','Concevoir une maquette de la solutio',24),(75,'C3.1.2.2','Construire un prototype de la solutio',24),(76,'C3.1.2.3','Préparer l\'intégration d\'un composant d\'infrastructure',24),(77,'C3.1.3.1','Caractériser des solutions de sécurité et en évaluer le coût',25),(78,'C3.1.3.2','Proposer une solution de sécurité compatible avec les contraintes techniques, financières, juridiques et organisationnelles',25),(79,'C3.1.3.3','Décrire une solution de sécurité et les risques couverts',25),(80,'C3.2.1.1','Installer et configurer un élément d\'interconnexion, un service, un serveur, un équipement terminal utilisateur',26),(81,'C3.2.1.2','Installer et configurer un élément d\'infrastructure permettant d\'assurer la continuité de service, un système de régulation des éléments d\'infrastructure, un outil de métrologie, un dispositif d\'alerte',26),(82,'C3.2.1.3','Installer et configurer des éléments de sécurité permettant d\'assurer la protection du système informatique',26),(83,'C3.2.2.1','Élaborer une procédure de remplacement ou de migration respectant la continuité d\'un service',27),(84,'C3.2.2.2','Mettre en œuvre une procédure de remplacement ou de migratio',27),(85,'C3.2.3.1','Repérer les éléments de la documentation à mettre à jour',28),(86,'C3.2.3.2','Mettre à jour la documentatio',28),(87,'C3.3.1.1','Installer et configurer des éléments d\'administration sur site ou à distance',29),(88,'C3.3.1.2','Administrer des éléments d\'infrastructure sur site ou à distance',29),(89,'C3.3.2.1','Installer et configurer des outils de sauvegarde et de restauratio',30),(90,'C3.3.2.2','Définir des procédures de sauvegarde et de restauratio',30),(91,'C3.3.2.3','Appliquer des procédures de sauvegarde et de restauratio',30),(92,'C3.3.3.1','Identifier les besoins en gestion d\'identité permettant de protéger les éléments d\'une infrastructure',31),(93,'C3.3.3.2','Gérer des utilisateurs et une structure organisationnelle',31),(94,'C3.3.3.3','Affecter des droits aux utilisateurs sur les éléments d\'une solution d\'infrastructure',31),(95,'C3.3.4.1','Repérer les tâches d\'administration à automatiser',32),(96,'C3.3.4.2','Concevoir, réaliser et mettre en place une procédure d\'automatisatio',32),(97,'C3.3.5.1','Installer et configurer les outils nécessaires à la production d\'indicateurs d\'activité et à l\'exploitation de fichiers d\'activité',33),(98,'C3.3.5.2','Assurer la confidentialité des informations collectées et traitées',33),(99,'C4.1.1.1','Identifier les composants logiciels nécessaires à la conception de la solutio',34),(100,'C4.1.1.2','Estimer les éléments de coût et le délai de mise en œuvre de la solutio',34),(101,'C4.1.2.1','Définir les spécifications de l\'interface utilisateur de la solution applicative',35),(102,'C4.1.2.2','Maquetter un élément de la solution applicative',35),(103,'C4.1.2.3','Concevoir et valider la maquette en collaboration avec des utilisateurs',35),(104,'C4.1.3.1','Modéliser le schéma de données nécessaire à la mise en place de la solution applicative',36),(105,'C4.1.3.2','Implémenter le schéma de données dans un SGBD',36),(106,'C4.1.3.3','Programmer des éléments de la solution applicative dans le langage d\'un SGBD',36),(107,'C4.1.3.4','Manipuler les données liées à la solution applicative à travers un langage de requête',36),(108,'C4.1.4.1','Recenser et caractériser les composants existants ou à développer utiles à la réalisation de la solution applicative dans le respect des budgets et planning prévisionnels',37),(109,'C4.1.5.1','Choisir les éléments de la solution à prototyper',38),(110,'C4.1.5.2','Développer un prototype',38),(111,'C4.1.5.3','Valider un prototype',38),(112,'C4.1.6.1','Mettre en place et exploiter un environnement de développement',39),(113,'C4.1.6.2','Mettre en place et exploiter un environnement de test',39),(114,'C4.1.7.1','Développer les éléments d\'une solutio',40),(115,'C4.1.7.2','Créer un composant logiciel',40),(116,'C4.1.7.3','Analyser et modifier le code d\'un composant logiciel',40),(117,'C4.1.7.4','Utiliser des composants d\'accès aux données',40),(118,'C4.1.7.5','Mettre en place des éléments de sécurité liés à l\'utilisation d\'un composant logiciel',40),(119,'C4.1.8.1','Élaborer et réaliser des tests unitaires',41),(120,'C4.1.8.2','Mettre en évidence et corriger les écarts',41),(121,'C4.1.9.1','Produire ou mettre à jour la documentation technique d\'une solution applicative et de ses composants logiciels',42),(122,'C4.1.10.1','Rédiger la documentation d\'utilisation, une aide en ligne, une FAQ',43),(123,'C4.1.10.2','Adapter la documentation d\'utilisation à chaque contexte d\'utilisatio',43),(124,'C4.2.1.1','Élaborer un jeu d\'essai permettant de reproduire le dysfonctionnement',44),(125,'C4.2.1.2','Repérer les composants à l\'origine du dysfonctionnement',44),(126,'C4.2.1.3','Concevoir les mises à jour à effectuer',44),(127,'C4.2.1.4','Réaliser les mises à jour',44),(128,'C4.2.2.1','Repérer les évolutions des composants utilisés et leurs conséquences',45),(129,'C4.2.2.2','Concevoir les mises à jour à effectuer',45),(130,'C4.2.2.3','Élaborer et réaliser les tests unitaires des composants mis à jour',45),(131,'C4.2.3.1','Élaborer et réaliser des tests d\'intégration et de non régression de la solution mise à jour',46),(132,'C4.2.3.2','Concevoir une procédure de migration et l\'appliquer dans le respect de la continuité de service',46),(133,'C4.2.4.1','Repérer les éléments de la documentation à mettre à jour',47),(134,'C4.2.4.2','Mettre à jour une documentatio',47),(135,'C5.1.1.1','Recenser les caractéristiques techniques nécessaires à la gestion des éléments de la configuration d\'une organisatio',48),(136,'C5.1.1.2','Paramétrer une solution de gestion des éléments d\'une configuratio',48),(137,'C5.1.2.1','Renseigner les événements relatifs au cycle de vie d\'un élément de la configuratio',49),(138,'C5.1.2.2','Actualiser les caractéristiques des éléments de la configuratio',49),(139,'C5.1.3.1','Contrôler et auditer les éléments de la configuratio',50),(140,'C5.1.3.2','Reconstituer un historique des modifications effectuées sur les éléments de la configuratio',50),(141,'C5.1.3.3','Identifier les éléments de la configuration à modifier ou à remplacer',50),(142,'C5.1.3.4','Repérer les équipements obsolètes et en proposer le traitement dans le respect de la réglementation en vigueur',50),(143,'C5.1.4.1','Assister la maîtrise d\'ouvrage dans l\'analyse technique de la proposition de contrat',51),(144,'C5.1.4.2','Interpréter des indicateurs de suivi de la prestation associée à la proposition de contrat',51),(145,'C5.1.4.3','Renseigner les éléments permettant d\'estimer la valeur du service',51),(146,'C5.1.5.1','Vérifier un plan d\'amortissement',52),(147,'C5.1.5.2','Apprécier la valeur actuelle d\'un élément de configuratio',52),(148,'C5.1.6.1','Renseigner les variables d\'une étude de rentabilité d\'un investissement',53),(149,'C5.1.6.2','Caractériser et prévoir les investissements matériels et logiciels',53),(150,'C5.2.1.1','Évaluer le degré de conformité des pratiques à un référentiel, à une norme ou à un standard adopté par le prestataire informatique',54),(151,'C5.2.1.2','Identifier et partager les bonnes pratiques à intégrer',54),(152,'C5.2.2.1','Définir une stratégie de recherche d\'informations',55),(153,'C5.2.2.2','Tenir à jour une liste de sources d\'informatio',55),(154,'C5.2.2.3','Évaluer la qualité d\'une source d\'information en fonction d\'un besoi',55),(155,'C5.2.2.4','Synthétiser et diffuser les résultats d\'une veille',55),(156,'C5.2.3.1','Identifier les besoins de formation pour mettre en œuvre une technologie, un composant, un outil ou une méthode',56),(157,'C5.2.3.2','Repérer l\'offre et les dispositifs de formatio',56),(158,'C5.2.4.1','Se documenter à propos d‘une technologie, d\'un composant, d\'un outil ou d\'une méthode',57),(159,'C5.2.4.2','Identifier le potentiel et les limites d\'une technologie, d\'un composant, d\'un outil ou d\'une méthode par rapport à un service à produire',57);
/*!40000 ALTER TABLE `competence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domaine`
--

DROP TABLE IF EXISTS `domaine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domaine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomenclature` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `idProcessus` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Domaine_Processus` (`idProcessus`),
  CONSTRAINT `domaine_ibfk_1` FOREIGN KEY (`idProcessus`) REFERENCES `processus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domaine`
--

LOCK TABLES `domaine` WRITE;
/*!40000 ALTER TABLE `domaine` DISABLE KEYS */;
INSERT INTO `domaine` VALUES (1,'D1.1  ','Analyse de la demande',1),(2,'D1.2  ','Choix d\'une solutio',1),(3,'D1.3  ','Mise en production d\'un service',1),(4,'D1.4  ','Travail en mode projet',1),(5,'D2.1  ','Exploitation des services',2),(6,'D2.2  ','Gestion des incidents et des demandes d\'assistance',2),(7,'D2.3  ','Gestion des problèmes et des changements',2),(8,'D3.1  ','Conception d\'une solution d\'infrastructure',3),(9,'D3.2  ','Installation d\'une solution d\'infrastructure',3),(10,'D3.3  ','Administration et supervision d\'une infrastructure',3),(11,'D4.1  ','Conception et réalisation d\'une solution applicative',4),(12,'D4.2  ','Maintenance d\'une solution applicative',4),(13,'D5.1  ','Gestion des configurations',5),(14,'D5.2  ','Gestion des compétences',5);
/*!40000 ALTER TABLE `domaine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epreuve`
--

DROP TABLE IF EXISTS `epreuve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epreuve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomenclature` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epreuve`
--

LOCK TABLES `epreuve` WRITE;
/*!40000 ALTER TABLE `epreuve` DISABLE KEYS */;
INSERT INTO `epreuve` VALUES (1,'U4'),(2,'U5'),(3,'U6');
/*!40000 ALTER TABLE `epreuve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evalue`
--

DROP TABLE IF EXISTS `evalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evalue` (
  `idParcours` int(11) NOT NULL DEFAULT '0',
  `idEpreuve` int(11) NOT NULL DEFAULT '0',
  `idActivite` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idParcours`,`idEpreuve`,`idActivite`),
  KEY `idEpreuve` (`idEpreuve`),
  KEY `idActivite` (`idActivite`),
  CONSTRAINT `evalue_ibfk_1` FOREIGN KEY (`idParcours`) REFERENCES `parcours` (`id`),
  CONSTRAINT `evalue_ibfk_2` FOREIGN KEY (`idEpreuve`) REFERENCES `epreuve` (`id`),
  CONSTRAINT `evalue_ibfk_3` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evalue`
--

LOCK TABLES `evalue` WRITE;
/*!40000 ALTER TABLE `evalue` DISABLE KEYS */;
INSERT INTO `evalue` VALUES (1,1,5),(1,1,7),(1,1,9),(1,1,12),(1,1,18),(1,1,19),(1,1,20),(1,1,24),(1,1,26),(1,1,27),(1,1,28),(1,1,29),(1,1,32),(1,1,33),(1,2,1),(1,2,2),(1,2,3),(1,2,4),(1,2,6),(1,2,8),(1,2,10),(1,2,21),(1,2,22),(1,2,23),(1,2,25),(1,2,30),(1,2,31),(1,2,52),(1,2,53),(1,3,11),(1,3,13),(1,3,14),(1,3,15),(1,3,16),(1,3,17),(1,3,48),(1,3,49),(1,3,50),(1,3,51),(1,3,54),(1,3,55),(1,3,56),(1,3,57),(2,1,5),(2,1,7),(2,1,9),(2,1,12),(2,1,18),(2,1,19),(2,1,20),(2,1,35),(2,1,36),(2,1,38),(2,1,39),(2,1,40),(2,1,41),(2,1,42),(2,1,43),(2,1,44),(2,1,45),(2,1,46),(2,1,47),(2,2,1),(2,2,2),(2,2,3),(2,2,4),(2,2,6),(2,2,8),(2,2,10),(2,2,21),(2,2,22),(2,2,34),(2,2,37),(2,2,52),(2,2,53),(2,3,11),(2,3,13),(2,3,14),(2,3,15),(2,3,16),(2,3,17),(2,3,48),(2,3,49),(2,3,50),(2,3,51),(2,3,54),(2,3,55),(2,3,56),(2,3,57),(3,1,5),(3,1,7),(3,1,9),(3,1,12),(3,1,18),(3,1,19),(3,1,20),(3,1,24),(3,1,26),(3,1,27),(3,1,28),(3,1,29),(3,1,32),(3,1,33),(3,1,35),(3,1,36),(3,1,38),(3,1,39),(3,1,40),(3,1,41),(3,1,42),(3,1,43),(3,1,44),(3,1,45),(3,1,46),(3,1,47),(3,2,1),(3,2,2),(3,2,3),(3,2,4),(3,2,6),(3,2,8),(3,2,10),(3,2,21),(3,2,22),(3,2,23),(3,2,25),(3,2,30),(3,2,31),(3,2,34),(3,2,37),(3,2,52),(3,2,53),(3,3,11),(3,3,13),(3,3,14),(3,3,15),(3,3,16),(3,3,17),(3,3,48),(3,3,49),(3,3,50),(3,3,51),(3,3,54),(3,3,55),(3,3,56),(3,3,57);
/*!40000 ALTER TABLE `evalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exploite`
--

DROP TABLE IF EXISTS `exploite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exploite` (
  `idParcours` int(11) NOT NULL,
  `idProcessus` int(11) NOT NULL,
  PRIMARY KEY (`idParcours`,`idProcessus`),
  KEY `IDX_278646A8CA12F4B8` (`idParcours`),
  KEY `IDX_278646A81200A74B` (`idProcessus`),
  CONSTRAINT `FK_278646A81200A74B` FOREIGN KEY (`idProcessus`) REFERENCES `processus` (`id`),
  CONSTRAINT `FK_278646A8CA12F4B8` FOREIGN KEY (`idParcours`) REFERENCES `parcours` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exploite`
--

LOCK TABLES `exploite` WRITE;
/*!40000 ALTER TABLE `exploite` DISABLE KEYS */;
INSERT INTO `exploite` VALUES (1,1),(1,2),(1,3),(1,5),(2,1),(2,2),(2,4),(2,5);
/*!40000 ALTER TABLE `exploite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `framework`
--

DROP TABLE IF EXISTS `framework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `framework` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `framework`
--

LOCK TABLES `framework` WRITE;
/*!40000 ALTER TABLE `framework` DISABLE KEYS */;
INSERT INTO `framework` VALUES (1,'Aucun'),(2,'.Net Framework'),(3,'PHP Framework'),(4,'Symfony'),(5,'Android'),(6,'Angular'),(7,'J2SE'),(8,'JEE'),(9,'Python'),(10,'VusJS');
/*!40000 ALTER TABLE `framework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `langage`
--

DROP TABLE IF EXISTS `langage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `langage`
--

LOCK TABLES `langage` WRITE;
/*!40000 ALTER TABLE `langage` DISABLE KEYS */;
INSERT INTO `langage` VALUES (1,'Aucun'),(2,'C#'),(3,'PHP'),(4,'Java'),(5,'Javascript'),(6,'Python'),(7,'Dart');
/*!40000 ALTER TABLE `langage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `langageframework`
--

DROP TABLE IF EXISTS `langageframework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langageframework` (
  `idlangage` int(11) NOT NULL,
  `idframework` int(11) NOT NULL,
  PRIMARY KEY (`idlangage`,`idframework`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `langageframework`
--

LOCK TABLES `langageframework` WRITE;
/*!40000 ALTER TABLE `langageframework` DISABLE KEYS */;
INSERT INTO `langageframework` VALUES (1,1),(2,2),(3,3),(3,4),(4,5),(4,7),(4,8),(5,3),(5,4),(5,6),(5,10),(6,9),(7,5),(7,6);
/*!40000 ALTER TABLE `langageframework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatingsystem`
--

DROP TABLE IF EXISTS `operatingsystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operatingsystem` (
  `id` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatingsystem`
--

LOCK TABLES `operatingsystem` WRITE;
/*!40000 ALTER TABLE `operatingsystem` DISABLE KEYS */;
INSERT INTO `operatingsystem` VALUES (1,'Windows'),(2,'Linux');
/*!40000 ALTER TABLE `operatingsystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcours`
--

DROP TABLE IF EXISTS `parcours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parcours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomenclature` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcours`
--

LOCK TABLES `parcours` WRITE;
/*!40000 ALTER TABLE `parcours` DISABLE KEYS */;
INSERT INTO `parcours` VALUES (1,'SISR  ','Solutions d’infrastructure, systèmes et réseaux'),(2,'SLAM  ','solutions logicielles et applications métiers'),(3,'','Indifférencié');
/*!40000 ALTER TABLE `parcours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processus`
--

DROP TABLE IF EXISTS `processus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomenclature` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processus`
--

LOCK TABLES `processus` WRITE;
/*!40000 ALTER TABLE `processus` DISABLE KEYS */;
INSERT INTO `processus` VALUES (1,'P1','Production de services'),(2,'P2','Fourniture de services'),(3,'P3','Conception et maintenance de solutions d’infrastructure'),(4,'P4','Conception et maintenance de solutions applicatives'),(5,'P5','Gestion du patrimoine informatique');
/*!40000 ALTER TABLE `processus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `libelle` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'DNS'),(2,'DHCP'),(3,'Annuaire LDAP'),(4,'Parefeu');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situation`
--

DROP TABLE IF EXISTS `situation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situation` (
  `reference` int(11) NOT NULL AUTO_INCREMENT,
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
  `refe4` int(11) DEFAULT NULL,
  `port_ref` int(11) DEFAULT NULL,
  `typeos` int(11) NOT NULL,
  `services` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`reference`),
  KEY `FK_Situation_Cadre` (`codeCadre`),
  KEY `FK_Situation_Localisation` (`codeLocalisation`),
  KEY `FK_Situation_Source` (`codeLangage`),
  KEY `FK_Situation_TypeSituation` (`codeFramework`),
  KEY `FK_Situation_Utilisateur` (`login`),
  KEY `codeOS` (`codeOS`,`codeService`),
  KEY `codeService` (`codeService`),
  KEY `refe4` (`refe4`),
  CONSTRAINT `situation_ibfk_2` FOREIGN KEY (`codeCadre`) REFERENCES `cadre` (`code`),
  CONSTRAINT `situation_ibfk_3` FOREIGN KEY (`codeLangage`) REFERENCES `langage` (`id`),
  CONSTRAINT `situation_ibfk_4` FOREIGN KEY (`codeFramework`) REFERENCES `framework` (`id`),
  CONSTRAINT `situation_ibfk_5` FOREIGN KEY (`codeOS`) REFERENCES `operatingsystem` (`id`),
  CONSTRAINT `situation_ibfk_6` FOREIGN KEY (`codeService`) REFERENCES `services` (`id`),
  CONSTRAINT `situation_ibfk_7` FOREIGN KEY (`refe4`) REFERENCES `situatione4` (`referencee4`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situation`
--

LOCK TABLES `situation` WRITE;
/*!40000 ALTER TABLE `situation` DISABLE KEYS */;
INSERT INTO `situation` VALUES (1,'test.v2','test1','eee','2020-10-15 00:00:00','2020-11-15 00:00:00',NULL,2,NULL,2,2,NULL,NULL,NULL,NULL,-1,NULL),(3,'thomas.clerc1','Projet réseau','Projet réseau école.\r\nRéalisation d\'un système réseau (LAN et DMZ) contrôler par deux pares-feux (pfsense master et backup)','2020-11-07 00:00:00','2020-12-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'-Serveur DNS\r\n-Serveur DHCP \r\n-GLPPI + Agent GLPI\r\n-Proxy applicatif\r\n-Portail Captif\r\n-Cluster \r\n-Règles pare-feu'),(4,'gaelle.derambure','Développement d\'un jeu TETRIS','Jeu en 1v1 avec des twists (malus, etc)','2019-09-23 00:00:00','2019-09-27 00:00:00',NULL,2,NULL,6,9,NULL,NULL,NULL,NULL,-1,NULL),(5,'mehdi.barchi','Application mobile innovante Eco-Check','Création d\'une application mobile sous Ionic et Angular qui permet aux utilisateurs de consulter leur consommation d\'énergie en fonction des différentes activités qu\'ils réalisent. Une page de classement entre amis est aussi présente pour sensibiliser les','2020-09-07 00:00:00','2021-04-01 00:00:00',NULL,2,NULL,5,3,NULL,NULL,5,NULL,-1,NULL),(7,'gaelle.derambure','Développement d\'un site web','PPE2 - Utilisation de PHP, HTML/CSS, JMerise, phpMyAdmin pour développer un site de gestion de stock d\'une librairie','2019-09-30 00:00:00','2020-05-22 00:00:00',NULL,2,NULL,3,3,NULL,NULL,NULL,NULL,-1,NULL),(8,'maxime.bourrier','inconnu','inconnu','2020-12-03 00:00:00','2020-12-03 00:00:00',NULL,2,NULL,2,2,NULL,NULL,NULL,NULL,-1,NULL),(9,'quentin.alessandra','Application C#','Application Windows Form exécutant des scripts PowerShell pour la configuration ainsi que pour le déploiement de clients sur Windows Server','2020-05-11 00:00:00','2020-06-19 00:00:00',NULL,2,NULL,2,2,NULL,NULL,NULL,NULL,-1,NULL),(10,'rodrigue.cimas','Développement Site Web pour une association','Ce site internet est pour une association qui font des cours en gratuitement en Espagnol','2020-05-15 00:00:00','2020-12-10 00:00:00',NULL,2,NULL,3,3,NULL,NULL,NULL,NULL,-1,NULL),(11,'gaelle.derambure','Développement d\'un site web pour aider à consommer moins d\'énergie','Chef de groupe,\r\nUn site web pour aider l\'utilisateur à garder une température optimale dans son logement, sans pour autant consommer plus.\r\nAprès s\'être inscrit, l\'utilisateur entre toutes les fenêtres présentent dans son logement, ainsi que sa ville de ','2020-12-03 00:00:00','2020-12-03 00:00:00',NULL,2,NULL,3,3,NULL,NULL,NULL,NULL,-1,NULL),(12,'gaelle.derambure','Développement d\'un site web','Création d\'un site pour un hôtel à partir d\'un modèle conceptuel de données','2019-09-30 00:00:00','2019-12-13 00:00:00',NULL,2,NULL,3,3,NULL,NULL,NULL,NULL,-1,NULL),(13,'maxime.chaussende','Application web','L\'application permet de recevoir des codes pour se connecter sur un site internet. Dans un premier temps il faut s\'authentifier avec son numéro de téléphone et un IPP, par la suite l\'utilisateur peut choisir comment recevoir ses codes, il peut choisir de ','2020-05-25 00:00:00','2020-07-10 00:00:00',NULL,2,NULL,2,2,NULL,NULL,NULL,NULL,-1,NULL),(14,'rodrigue.cimas','Application Mobile intéractif','//pas d\'idée pour l\'instant//','2020-12-03 00:00:00','2020-12-03 00:00:00',NULL,2,NULL,4,5,NULL,NULL,NULL,NULL,-1,NULL),(15,'gaelle.derambure','Création d\'un prototype de retourneur de saucisses','Chef de groupe\r\nUn retourneur de saucisses automatique. Le prototype se branche sur un barbecue électrique et l\'allume ou l\'éteint selon la température, tout en faisant tourner les saucisses en continue\r\nUtilisation de SolidWorks (modélisation 3D) + ISIS ','2018-09-11 00:00:00','2019-05-16 00:00:00',NULL,2,NULL,1,1,NULL,NULL,NULL,NULL,-1,NULL),(16,'gaelle.derambure','Création d\'un logiciel de modification d\'image','Chef de groupe, \r\nUtilisation de python pour créer un logiciel de modifications d\'images grâce à plusieurs fonctions différentes (faire pivoter, rendre bleu / rouge / vert, pixeliser, postériser...)','2018-09-11 00:00:00','2019-05-16 00:00:00',NULL,2,NULL,6,9,NULL,NULL,NULL,NULL,-1,NULL),(17,'j.desaintgilles','Site d\'un hotêl','Site de réservation de chambre pour un hôtel','2020-01-10 00:00:00','2020-03-09 00:00:00',NULL,2,NULL,3,3,NULL,NULL,NULL,NULL,-1,NULL),(18,'j.desaintgilles','Site de pêche','Site de réservation de pêche (NET. Core)','2018-12-01 00:00:00','2018-12-31 00:00:00',NULL,2,NULL,2,2,NULL,NULL,NULL,NULL,-1,NULL),(19,'victor.baptiste','Création formulaire Vue.js','Création d\'une wishlist single page applications pour le site d\'Aersyn','2020-05-18 00:00:00','2020-06-26 00:00:00',NULL,2,NULL,5,10,NULL,NULL,NULL,NULL,-1,NULL),(20,'thomas.andres','Utilisation régulière de VPS','Ayant été dirigeant d\'une communauté Gaming, j\'ai donc administrer et gérer un VPS contenant divers services pendant plusieurs années : Ces services comprenaient du Web, des serveurs de jeux, ou encore de serveurs vocaux. Le tout ayant un besoin crucial d','2014-07-01 00:00:00','2019-08-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(21,'test.v2','test2','eee','2020-11-03 00:00:00','2020-12-03 00:00:00',NULL,2,NULL,5,3,NULL,NULL,21,NULL,-1,NULL),(22,'thomas.andres','Projet Réseau','Projet réseau école. Réalisation d\'un système réseau (LAN & DMZ), séparés par un Pare feu (Iptables).','2020-12-03 00:00:00','2020-12-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'-Serveur DHCP (Même machine que pare feu)\r\n//-Serveur DNS\r\n-Serveur GLPI.\r\n-Serveur Web.\r\n-Serveur Base de donnée (pour GLPI)\r\n-'),(23,'nathan.ovide','Formulaire Interactif en Vue.JS','Formulaire Interactif monopage développé en Vue.JS lors de mon stage en première année.','2020-05-18 00:00:00','2020-06-26 00:00:00',NULL,2,NULL,5,10,NULL,NULL,NULL,NULL,-1,NULL),(24,'remi.arnaud','Gestion de stock d\'une pharmacie','Gestion de stock en c# en .NET Framework avec EntityFramework et MySQL pour la BDD','2020-09-04 00:00:00','2021-06-01 00:00:00',NULL,2,NULL,2,2,NULL,NULL,24,NULL,-1,NULL),(25,'remi.arnaud','Un reseau social','Un reseau social simple. Application mobile qui permet de se connecter, s\'enregistrer avec un growth hacking, d\'accéder à la galerie photo, de faire des photos, et de tchater. Base de donnée firebase avec un cloud firestore.','2020-09-04 00:00:00','2021-06-01 00:00:00',NULL,2,NULL,1,1,NULL,NULL,25,NULL,-1,NULL);
/*!40000 ALTER TABLE `situation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situatione4`
--

DROP TABLE IF EXISTS `situatione4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situatione4` (
  `referencee4` int(11) NOT NULL,
  `competenceApplication` int(11) NOT NULL DEFAULT '0',
  `competenceSGBD` int(11) NOT NULL DEFAULT '0',
  `contexte` varchar(250) NOT NULL,
  `intitule` varchar(250) NOT NULL,
  `equipe` int(11) NOT NULL DEFAULT '0',
  `realisation` varchar(250) NOT NULL,
  PRIMARY KEY (`referencee4`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situatione4`
--

LOCK TABLES `situatione4` WRITE;
/*!40000 ALTER TABLE `situatione4` DISABLE KEYS */;
INSERT INTO `situatione4` VALUES (5,3,0,'Après le Workshop de 2020, j\'ai décidé de continuer le projet et de l\'améliorer','Application mobile innovante Eco-Check',0,'Développement sur le long terme de l\'application, elle a débuté en groupe le 07/09/2020 lors du workshop de deuxième année et j\'ai ensuite finalisé le développement de mon côté.'),(21,2,0,'e','test2',0,'e'),(24,1,1,'Employé dans une association un client veut une gestion de stock.','Gestion de stock d\'une pharmacie',0,''),(25,3,1,'Employé dans une association un client veut un calendrier.','Un reseau social',0,'');
/*!40000 ALTER TABLE `situatione4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situationtypo`
--

DROP TABLE IF EXISTS `situationtypo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situationtypo` (
  `reference` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  PRIMARY KEY (`reference`,`code`),
  KEY `reference` (`reference`),
  KEY `code` (`code`),
  CONSTRAINT `situationtypo_ibfk_1` FOREIGN KEY (`code`) REFERENCES `typologie` (`code`),
  CONSTRAINT `situationtypo_ibfk_2` FOREIGN KEY (`reference`) REFERENCES `situation` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situationtypo`
--

LOCK TABLES `situationtypo` WRITE;
/*!40000 ALTER TABLE `situationtypo` DISABLE KEYS */;
INSERT INTO `situationtypo` VALUES (1,2),(1,4),(3,1),(3,2),(3,4),(4,1),(4,3),(5,1),(7,1),(7,3),(9,1),(9,3),(10,1),(11,1),(12,1),(13,1),(13,4),(14,1),(15,1),(15,3),(16,1),(17,1),(17,3),(18,1),(18,2),(18,3),(19,1),(20,1),(20,2),(22,1),(23,1),(24,1),(24,3),(25,1),(25,3);
/*!40000 ALTER TABLE `situationtypo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage`
--

DROP TABLE IF EXISTS `stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `dateModif` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage`
--

LOCK TABLES `stage` WRITE;
/*!40000 ALTER TABLE `stage` DISABLE KEYS */;
INSERT INTO `stage` VALUES (8,'rodrigue.cimas',1,'Création de site Internet','Création d\'un site de type vitrine avec un système d\'adhérents où ils peuvent rajouter des documents sur l\'actualité de la CFTC de l\'Hérault','CFTC-FPT 34','474 Allée Henri II de Montmorency, 34000 Montpellier','04 67 15 14 47\r\n\r\nsyndicat.cftc.territoriaux.34@gmail.com',NULL,0,'2020-05-11','2020-07-11','2020-10-15 10:33:42'),(9,'test.v2',1,'test1',NULL,'e','e','e',NULL,0,'2020-09-28','2020-10-31','2020-10-15 10:36:17'),(10,'thomas.clerc1',1,'Stage Alionax Administrateur Système B1','Stage Alionax Administrateur Système B1','Alionax','60 Rue Etienne Lenoir, 30900 Nîmes','04 66 04 76 50',NULL,0,'2020-06-03','2020-07-10','2020-10-15 11:14:21'),(11,'quentin.alessandra',1,'Développeur chez ALX Technologies','Développement et modification d\'application (C# + PowerShell)','ALX TECHNOLOGIES','302 Rue de Thor, 34000 Montpellier','04 67 02 06 11',NULL,700,'2020-05-11','2020-06-22','2020-10-15 11:20:55'),(12,'mehdi.barchi',1,'Concepteur/Développeur d\'application','Participation au sein d\'une équipe, au développement d\'une application dans la santé sous Angular et Firebase.','Stella Surgical','235 rue de la garriguette, Saint-Aunès 34130','04 11 93 73 09',NULL,2358.44,'2020-05-11','2020-08-31','2020-10-15 11:22:53'),(13,'nathan.olive',1,'Stage en PHP',NULL,'Emity','3 Avenue de l\'Europe, 34830 Clapiers','contact@emity.io',NULL,0,'2020-05-11','2020-06-26','2020-10-15 11:24:00'),(14,'gaelle.derambure',1,'Stage CDC Habitat',NULL,'CDC Habitat','125 Avenue de Lodeve, 34000 Montpellier','04 67 75 96 40',NULL,1524.9,'2020-06-08','2020-08-28','2020-10-15 11:24:04'),(15,'remi.arnaud',1,'Développeur','Réalisation d\'application web avec référencement SEO.','Proximity Web Pro','24 Rue les Jardins de Mélanie, 34990 Juvignac','0668038035, laurent@proximitywebpro.info',NULL,80,'2020-05-11','2020-07-10','2020-10-15 11:30:08'),(16,'maxime.bourrier',1,'Clowz Debian Symfony','Renseignement, production et rédaction d\'une solution Symfony sur une machine virtuelle Debian','Clowz','2 B AV DE LA FONTVIN 34970 LATTES','08 92 97 62 37',NULL,0,'2020-05-11','2020-06-26','2020-10-15 11:51:46'),(17,'arnaud.bouix',1,'Interface conseil','Solution pour conseil de classe.','EPSI','437 Avenue des Apothicaires, 34090 Montpellier','04 67 04 20 01',NULL,0,'2020-06-08','2020-08-08','2020-12-01 16:22:07'),(18,'thomas.andres',1,'Stage B1C3 ETIC-Management',NULL,'ETIC Management','669 Rue André Marquès','https://etic-management.fr/',NULL,0,'2020-05-11','2020-07-03','2020-12-03 08:44:31'),(19,'maxime.chaussende',1,'Stage CHU Caremeau dans le service informatique hospitalier. Création d\'une application web en C#','Développement d\'une application web en C#. J\'ai eu à développer une application web destinée pour une borne tactile permettant de récupérer des identifiants pour se connecter au portail patient afin de prendre des rendez-vous en ligne et de consulter','CHU Caremeau','Rue du Professeur Robert Debré, 30900 Nîmes','Tél: 04 66 68 68 68',NULL,0,'2020-05-25','2020-07-10','2020-12-03 08:45:10'),(20,'j.desaintgilles',1,'Stage Weda',NULL,'Weda','8 Rue Alexis Alquie, 34000 Montpellier','anael@weda.fr',NULL,2400,'2020-05-11','2020-08-28','2020-12-03 08:46:02'),(21,'victor.baptiste',1,'Stage développement web première année','Stage de développement web. Création d\'un formulaire (wishlist) avec le framework JS Vue.JS, permettant d\'anticiper la demande des clients et de leurs besoins.','Aersyn','Rond Point Benjamin Franklin Cap Omega','a.chadburn@earsyn.com',NULL,0,'2020-05-18','2020-06-26','2020-12-03 08:48:22'),(22,'nathan.ovide',1,'Stage développement Web Vue.JS première année','Stage de développement Web. Création d\'un formulaire interactif en Vue.JS afin d\'anticiper la demande et les besoins des clients.','AERSYN','Cap Omega, Rond-Point Benjamin Franklin, 34000 Montpellier','a.chadburn@aersyn.com',NULL,0,'2020-05-18','2020-06-26','2020-12-03 08:48:42'),(23,'maxime.bourrier',2,'Inconnu',NULL,'inconnu','inconnu','inconnu',NULL,0,'2020-05-11','2020-07-03','2020-12-03 09:04:35'),(24,'gaelle.derambure',2,'Stage Genapi','Mise en place d\'une offre \"Docaposte\" (envoi des bulletins de salaire sur un coffre fort numérique), correction de bugs / modification et ajouts d\'éléments sur la solution Talent','Genapi','194 Av. de la Gare Sud de France, Lattes','mathieu.gury@genapi.fr',NULL,1092,'2021-01-04','2021-02-26','2021-01-20 17:10:26'),(25,'rodrigue.cimas',2,'Création d\'une application mobile',NULL,'CFTC-FPT 34','474 Allée Henri II de Montmorency, 34000 Montpellier','04 67 15 14 47, syndicat.cftc.territoriaux.34@gmail.com',NULL,0,'2021-01-04','2021-02-27','2021-02-04 14:47:08'),(26,'nicolas.bouvier5',2,'Optimisation SEO , Wordpress , Base de donnée','Apprentissage Wordpresse , Optimisation du SEO , Création d\'une nouvelle base de donnée , Autoentrepreneuriat','EIO','170 rue Thomas Edison Atelier 5','06.59.40.73.32   quentin.passet@eio.eco',NULL,0,'2021-01-19','2021-03-05','2021-02-09 13:08:01'),(27,'nicolas.bouvier5',1,'Création d\'un Système de paiement virtuelle pour association',NULL,'LABSud','120 allée John Napier 34000 Montpellier','contact@labsud.org  09 84 31 82 08',NULL,0,'2020-06-08','2020-07-31','2021-02-09 13:33:23'),(28,'j.desaintgilles',2,'Devops',NULL,'Softway Medical','Bâtiment C Arteparc \r\nRoute de la Côte d\'Azur, \r\nRue de la Belle du, 13590 Meyreuil','+33 06.07.11.68.99',NULL,0,'2021-01-04','2021-02-26','2021-02-25 10:44:08'),(29,'mehdi.barchi',2,'Application Web MyDIL','Stage de deuxième année, réalisée au MyDIL, création d\'une application Web en trois parties, front en VueJs, back en PHP et paramétrage d\'un serveur.\r\nL\'application sert à réserver des produits présents au MyDIL. Le serveur ainsi que le back permettr','MyDIL','437 Avenue des Apothicaires, 34090 Montpellier','06.51.86.76.95',NULL,0,'2021-01-12','2021-02-26','2021-02-26 17:56:07'),(30,'thomas.clerc1',2,'Stage Wild Sheep Studio Administrateur Système B2',NULL,'WILD SHEEP STUDIO','310 AVENUE SAINT MAUR\r\n34000 MONTPELLIER','info@wildsheepstudio.com',NULL,550,'2021-01-04','2021-03-05','2021-03-01 19:33:14'),(31,'nathan.ovide',2,'Stage développement Web PHP deuxième année','Projet ayant pour finalité de simplifier des démarches récurrentes pour des auditeurs professionnels (simplification des échanges mail et de fichiers).','OPENS','Boulevard Charles Warnery, 34000 Montpellier, France.','0633982854',NULL,0,'2021-01-04','2021-02-19','2021-03-01 21:48:04'),(32,'victor.baptiste',2,'Stage developpement web PHP,HTML,CSS','Stage ayant pour objectif de fournir au client une solution permettant de générer des audits, tout en offrant un gain de temps.','OpenS','157 Boulevard Charles Warnery, 34000 Montpellier','06 33 98 28 54',NULL,0,'2021-01-04','2021-02-19','2021-03-01 21:48:04'),(33,'remi.arnaud',2,'Développeur Junior eSanté',NULL,'CompuGroup Medical','43 Rue Théroigne de Méricourt, Montpellier','olivier.denoyelle@cgm.com',NULL,858.13,'2021-01-04','2021-03-05','2021-03-02 10:15:34');
/*!40000 ALTER TABLE `stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stageintitule`
--

DROP TABLE IF EXISTS `stageintitule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stageintitule` (
  `idIntitule` int(11) NOT NULL,
  `intitule` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `idStage` int(11) NOT NULL,
  PRIMARY KEY (`idIntitule`,`idStage`),
  KEY `IDX_C9D88496D5B8D074` (`idStage`),
  CONSTRAINT `FK_C9D88496D5B8D074` FOREIGN KEY (`idStage`) REFERENCES `stage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stageintitule`
--

LOCK TABLES `stageintitule` WRITE;
/*!40000 ALTER TABLE `stageintitule` DISABLE KEYS */;
INSERT INTO `stageintitule` VALUES (1,'Analyse de l\'objectif',8),(1,'i1',9),(1,'Analyse du cahier des charges',10),(1,'Création d\'une application',11),(1,'Rédaction cahier des charges et documentation',12),(1,'Développement Web',13),(1,'PostgreSQL (mise à jour de bases de données)',14),(1,'Développement d\'application',15),(1,'Rédaction du planning',16),(1,'PHP',17),(1,'Installation Cloud, ERP, CRM',18),(1,'Reprise de donnée',20),(1,'Définition du projet ',21),(1,'Définition du projet',22),(1,'inconnu',23),(1,'Wordpresse',26),(1,'Base de donnée',27),(1,'Développement',28),(1,'Back',29),(1,'Backup Serveur',30),(1,'Définition du projet',31),(1,'Définition du projet',32),(1,'Développement d\'application',33),(2,'Développement Logiciel',8),(2,'Proposition d’une solution à un problème',10),(2,'Modification d\'application',11),(2,'Tests de solutions',12),(2,'Extensions PyQGis',14),(2,'Documents relatifs à la production de l\'application',15),(2,'Installation et configuration d\'une machine virtuelle.',16),(2,'BBD',17),(2,'Untilisation d\'une nouvelle technologie : Hyperviseur',18),(2,'Création du projet',19),(2,'Support Technique',20),(2,'Programmation web (Vue.js/HTML/SCSS)',21),(2,'Programmation WEB (Vue.js/HTML/SCSS)',22),(2,'Paramétrage paquets HTTP pour la communication avec l\'API Place Numérique',24),(2,'Optimisation SEO',26),(2,'Node-RED',27),(2,'Tests',28),(2,'Front',29),(2,'Veille technologique',30),(2,'Développement Web (PHP/JS/HTML/CSS)	',31),(3,'Support Technique',8),(3,'Réalisation des tests',10),(3,'maintenance et gestion de l\'application',11),(3,'Développement d\'application',12),(3,'Veille données INSEE',14),(3,'Mise en place d\'une veille technologique',15),(3,'Création de documentation pour garder une trace',16),(3,'SITE',17),(3,'Utilisation SSH pour travailler a distance',18),(3,'Développement du projet',19),(3,'Développement logiciel',20),(3,'Formation et continuité ',21),(3,'Formation et Continuité',22),(3,'Modification / Ajout de fonctionnalités / Correction de bug sur Talent (vueJS + typescript)',24),(3,'Base de donnée',26),(3,'Système de payment',27),(3,'Déploiement',28),(3,'Serveur',29),(3,'Supervision',30),(3,'Mise en place de l\'application',31),(4,'Identification d’un problème',10),(4,'Veille technologique',12),(4,'HTML / CSS (mise en forme de fichiers)',14),(4,'Proposition de solution pour l\'application',15),(4,'Organisation du travail et des sauvegardes',16),(4,'Utilisation du Chron.d et scripts .sh pour automatiser des tâches',18),(4,'Développement personnel',19),(4,'Formation',28),(4,'Formation et Continuité',31),(4,'Developpement Web ',32),(5,'Suggestion pour améliorer différents services',10),(5,'Reinstallation et correction d\'une securisation SSL',18),(5,'Formation et continuité ',32),(6,'Résolution de diffèrents problèmes',10),(7,'Veille technologique',10),(8,'Mise à jour d\'un éléments défectueux',10);
/*!40000 ALTER TABLE `stageintitule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stageintituleactivite`
--

DROP TABLE IF EXISTS `stageintituleactivite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stageintituleactivite` (
  `idStage` int(11) NOT NULL,
  `idIntitule` int(11) NOT NULL,
  `idActivite` int(11) NOT NULL,
  PRIMARY KEY (`idStage`,`idIntitule`,`idActivite`),
  KEY `IDX_37AB326AD5B8D07464CA0FFD` (`idStage`,`idIntitule`),
  KEY `IDX_37AB326AEBD67F4E` (`idActivite`),
  CONSTRAINT `FK_37AB326AD5B8D07464CA0FFD` FOREIGN KEY (`idStage`, `idIntitule`) REFERENCES `stageintitule` (`idStage`, `idIntitule`),
  CONSTRAINT `FK_37AB326AEBD67F4E` FOREIGN KEY (`idActivite`) REFERENCES `activite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stageintituleactivite`
--

LOCK TABLES `stageintituleactivite` WRITE;
/*!40000 ALTER TABLE `stageintituleactivite` DISABLE KEYS */;
INSERT INTO `stageintituleactivite` VALUES (8,1,1),(8,1,3),(8,1,4),(8,1,5),(8,2,11),(8,2,13),(8,2,16),(8,2,19),(8,2,20),(8,2,34),(8,2,35),(8,2,40),(8,3,11),(8,3,16),(8,3,21),(8,3,22),(9,1,2),(9,1,7),(9,1,12),(10,1,1),(10,2,18),(10,2,19),(10,2,20),(10,3,7),(10,3,9),(10,4,21),(10,5,22),(10,6,18),(10,6,19),(10,7,55),(10,7,57),(10,8,27),(11,1,1),(11,1,2),(11,1,3),(11,1,5),(11,1,6),(11,1,7),(11,1,8),(11,1,9),(11,1,10),(11,1,12),(11,1,13),(11,1,17),(11,1,18),(11,1,19),(11,1,21),(11,1,22),(11,1,34),(11,1,35),(11,1,37),(11,1,39),(11,1,41),(11,1,42),(11,1,43),(11,2,1),(11,2,2),(11,2,3),(11,2,6),(11,2,7),(11,2,9),(11,2,10),(11,2,12),(11,2,13),(11,2,17),(11,2,18),(11,2,19),(11,2,34),(11,2,35),(11,2,42),(11,2,43),(11,2,46),(11,2,47),(11,3,44),(11,3,45),(11,3,46),(11,3,47),(11,3,50),(11,3,55),(11,3,56),(11,3,57),(12,1,42),(12,1,43),(12,2,46),(12,2,47),(12,3,13),(12,3,35),(12,3,36),(12,3,38),(12,3,41),(12,4,55),(12,4,56),(13,1,1),(13,1,3),(13,1,12),(13,1,13),(13,1,18),(14,1,21),(14,1,36),(14,2,12),(14,2,16),(14,2,40),(14,2,43),(14,2,57),(14,3,36),(14,3,55),(14,4,13),(15,1,16),(15,1,40),(15,1,41),(15,1,44),(15,2,4),(15,2,5),(15,2,13),(15,2,34),(15,2,47),(15,3,55),(15,3,57),(15,4,37),(15,4,38),(15,4,39),(16,1,1),(16,1,3),(16,2,4),(16,2,5),(16,2,34),(16,2,39),(16,3,9),(16,3,12),(16,3,34),(16,3,41),(16,3,45),(16,3,50),(16,4,14),(16,4,15),(17,1,1),(17,1,12),(17,1,34),(17,2,13),(17,2,36),(17,3,1),(17,3,41),(17,3,42),(18,1,10),(18,1,12),(18,2,55),(18,2,56),(18,2,57),(18,3,26),(18,3,29),(18,4,29),(18,4,30),(18,4,32),(18,5,22),(18,5,25),(18,5,27),(19,2,3),(19,2,13),(19,3,34),(19,3,35),(19,3,41),(19,3,42),(19,3,44),(19,3,46),(19,4,55),(19,4,56),(19,4,57),(20,1,16),(20,1,17),(20,1,18),(20,1,19),(20,1,41),(20,2,16),(20,2,17),(20,2,18),(20,2,19),(20,3,13),(20,3,15),(20,3,21),(20,3,22),(20,3,34),(20,3,35),(20,3,39),(20,3,40),(20,3,41),(21,1,3),(21,1,6),(21,2,13),(21,2,15),(21,2,21),(21,2,22),(21,2,34),(21,2,35),(21,2,36),(21,2,37),(21,2,38),(21,2,39),(21,2,40),(21,2,41),(21,3,45),(21,3,49),(21,3,50),(21,3,56),(21,3,57),(22,1,3),(22,1,6),(22,2,13),(22,2,15),(22,2,21),(22,2,22),(22,2,34),(22,2,35),(22,2,36),(22,2,37),(22,2,38),(22,2,39),(22,2,40),(22,2,41),(22,3,45),(22,3,49),(22,3,50),(22,3,56),(22,3,57),(24,2,3),(24,2,4),(24,2,7),(24,2,9),(24,2,13),(24,2,14),(24,2,37),(24,2,39),(24,2,40),(24,2,41),(24,2,42),(24,2,45),(24,2,46),(24,2,47),(24,2,57),(24,3,1),(24,3,13),(24,3,14),(24,3,18),(24,3,21),(24,3,34),(24,3,35),(24,3,36),(24,3,44),(24,3,45),(26,1,4),(26,1,5),(26,1,6),(26,1,7),(26,1,9),(26,1,11),(26,1,12),(26,1,13),(26,1,16),(26,1,17),(26,1,18),(26,1,22),(26,1,42),(26,1,47),(26,1,48),(26,1,49),(26,1,50),(26,1,56),(26,1,57),(26,2,6),(26,2,11),(26,2,21),(26,2,22),(26,2,42),(26,2,47),(26,2,50),(26,2,52),(26,2,53),(26,2,55),(26,2,56),(26,2,57),(26,3,1),(26,3,4),(26,3,6),(26,3,9),(26,3,11),(26,3,12),(26,3,13),(26,3,16),(26,3,21),(26,3,22),(26,3,36),(26,3,42),(26,3,56),(26,3,57),(27,1,22),(27,1,36),(27,1,52),(27,1,57),(27,2,2),(27,2,12),(27,2,13),(27,2,56),(27,2,57),(27,3,1),(27,3,2),(27,3,4),(27,3,5),(27,3,7),(27,3,8),(27,3,9),(27,3,10),(27,3,11),(27,3,12),(27,3,13),(27,3,20),(27,3,21),(27,3,22),(27,3,34),(27,3,42),(27,3,43),(28,1,1),(28,1,2),(28,1,3),(28,1,8),(28,1,13),(28,1,14),(28,1,15),(28,1,21),(28,1,35),(28,1,36),(28,1,39),(28,1,40),(28,1,42),(28,1,47),(28,1,48),(28,1,49),(28,2,7),(28,2,9),(28,2,41),(28,2,44),(28,2,46),(28,3,12),(28,3,39),(28,4,56),(28,4,57),(29,1,1),(29,1,5),(29,1,7),(29,1,12),(29,1,13),(29,1,36),(29,1,43),(29,1,57),(29,2,1),(29,2,12),(29,2,34),(29,2,35),(29,2,57),(29,3,13),(29,3,57),(30,1,12),(30,1,18),(30,1,26),(30,1,27),(30,1,28),(30,1,30),(30,1,32),(30,2,55),(30,2,56),(30,2,57),(30,3,4),(30,3,12),(30,3,29),(30,3,48),(30,3,50),(31,1,1),(31,1,3),(31,1,6),(31,2,13),(31,2,14),(31,2,21),(31,2,34),(31,2,35),(31,2,36),(31,2,37),(31,2,38),(31,2,39),(31,2,41),(31,2,42),(31,2,49),(31,2,51),(31,3,10),(31,3,12),(31,4,54),(31,4,56),(31,4,57),(32,1,1),(32,1,3),(32,1,6),(32,4,13),(32,4,14),(32,4,21),(32,4,34),(32,4,35),(32,4,36),(32,4,37),(32,4,38),(32,4,39),(32,4,41),(32,4,42),(32,4,49),(32,4,51),(32,5,54),(32,5,56),(32,5,57);
/*!40000 ALTER TABLE `stageintituleactivite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stagetypo`
--

DROP TABLE IF EXISTS `stagetypo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stagetypo` (
  `idstage` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  PRIMARY KEY (`idstage`,`code`),
  KEY `reference` (`idstage`),
  KEY `code` (`code`),
  CONSTRAINT `stagetypo_ibfk_1` FOREIGN KEY (`idstage`) REFERENCES `stage` (`id`),
  CONSTRAINT `stagetypo_ibfk_2` FOREIGN KEY (`code`) REFERENCES `typologie` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stagetypo`
--

LOCK TABLES `stagetypo` WRITE;
/*!40000 ALTER TABLE `stagetypo` DISABLE KEYS */;
INSERT INTO `stagetypo` VALUES (8,1),(9,1),(9,3),(10,4),(11,1),(11,4),(12,1),(12,3),(13,1),(14,1),(14,4),(15,1),(15,3),(15,4),(16,1),(16,3),(17,1),(17,3),(18,1),(18,4),(19,1),(19,2),(19,4),(20,1),(20,2),(20,3),(21,1),(21,4),(22,1),(24,1),(24,2),(25,1),(26,3),(26,4),(27,1),(28,1),(28,3),(28,4),(29,1),(29,3),(30,2),(30,3),(30,4),(31,1),(32,1),(33,1),(33,3),(33,4);
/*!40000 ALTER TABLE `stagetypo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typologie`
--

DROP TABLE IF EXISTS `typologie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `typologie` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `lngutile` int(11) NOT NULL,
  `libelle` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typologie`
--

LOCK TABLES `typologie` WRITE;
/*!40000 ALTER TABLE `typologie` DISABLE KEYS */;
INSERT INTO `typologie` VALUES (1,56,'Production d’une solution logicielle et d’infrastructure'),(2,55,'Prise en charge d’incidents et de demandes d’assistance'),(3,49,'Élaboration de documents relatifs à la production et à la fourniture de services'),(4,53,'Mise en place d’un dispositif de veille technologique');
/*!40000 ALTER TABLE `typologie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-02 12:08:47
