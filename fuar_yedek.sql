CREATE DATABASE  IF NOT EXISTS `fuar_otomasyon` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fuar_otomasyon`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: fuar_otomasyon
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `etkinlik_turleri`
--

DROP TABLE IF EXISTS `etkinlik_turleri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etkinlik_turleri` (
  `idetkinlik_turleri` int NOT NULL AUTO_INCREMENT,
  `tur_adi` varchar(45) NOT NULL,
  PRIMARY KEY (`idetkinlik_turleri`),
  UNIQUE KEY `tur_adi_UNIQUE` (`tur_adi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etkinlik_turleri`
--

LOCK TABLES `etkinlik_turleri` WRITE;
/*!40000 ALTER TABLE `etkinlik_turleri` DISABLE KEYS */;
/*!40000 ALTER TABLE `etkinlik_turleri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etkinlikler`
--

DROP TABLE IF EXISTS `etkinlikler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etkinlikler` (
  `idetkinlikler` int NOT NULL AUTO_INCREMENT,
  `etkinlik_adi` varchar(45) NOT NULL,
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date NOT NULL,
  `tur_id` int DEFAULT NULL,
  PRIMARY KEY (`idetkinlikler`),
  KEY `fk_etkinlikler_tur_id_idx` (`tur_id`),
  CONSTRAINT `fk_etkinlikler_tur_id` FOREIGN KEY (`tur_id`) REFERENCES `etkinlik_turleri` (`idetkinlik_turleri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etkinlikler`
--

LOCK TABLES `etkinlikler` WRITE;
/*!40000 ALTER TABLE `etkinlikler` DISABLE KEYS */;
/*!40000 ALTER TABLE `etkinlikler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `katilimcilar`
--

DROP TABLE IF EXISTS `katilimcilar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `katilimcilar` (
  `katilimci_id` int NOT NULL AUTO_INCREMENT,
  `ad_soyad` varchar(100) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  `telefon` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`katilimci_id`),
  UNIQUE KEY `eposta_UNIQUE` (`eposta`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `katilimcilar`
--

LOCK TABLES `katilimcilar` WRITE;
/*!40000 ALTER TABLE `katilimcilar` DISABLE KEYS */;
INSERT INTO `katilimcilar` VALUES (1,'Caner Aras','caneraras@gmail.com','05321112233'),(2,'Merve Ozturk','merveozturk@gmail.com','05332223344'),(3,'Deniz Soylu','denizsoylu@gmail.com','05423334455'),(4,'Burak Yilmaz','burakyilmaz@gmail.com','05054445566'),(5,'Ece Serter','eceserter@gmail.com','05305556677'),(6,'Kaan Arda','kaanarda@gmail.com','05356667788'),(7,'Selin Cetin','selincetin@gmail.com','05447778899'),(8,'Derya Gunes','deryagunes@gmail.com','05319990011'),(9,'Umut Akman','umutakman@gmail.com','05390001122');
/*!40000 ALTER TABLE `katilimcilar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kayitlar`
--

DROP TABLE IF EXISTS `kayitlar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kayitlar` (
  `idkayitlar` int NOT NULL AUTO_INCREMENT,
  `kayit_tarihi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `katilimci_id` int NOT NULL,
  `oturum_id` int NOT NULL,
  PRIMARY KEY (`idkayitlar`),
  KEY `fk_kayitlar_katilimci_id_idx` (`katilimci_id`),
  KEY `fk_kayitlar_oturum_id_idx` (`oturum_id`),
  CONSTRAINT `fk_kayitlar_katilimci_id` FOREIGN KEY (`katilimci_id`) REFERENCES `katilimcilar` (`katilimci_id`),
  CONSTRAINT `fk_kayitlar_oturum_id` FOREIGN KEY (`oturum_id`) REFERENCES `oturumlar` (`idoturumlar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kayitlar`
--

LOCK TABLES `kayitlar` WRITE;
/*!40000 ALTER TABLE `kayitlar` DISABLE KEYS */;
/*!40000 ALTER TABLE `kayitlar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `konusmacılar`
--

DROP TABLE IF EXISTS `konusmacılar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `konusmacılar` (
  `konusmaci_id` int NOT NULL AUTO_INCREMENT,
  `ad_soyad` varchar(100) NOT NULL,
  `uzmanlık_alanı` varchar(100) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  PRIMARY KEY (`konusmaci_id`),
  UNIQUE KEY `eposta_UNIQUE` (`eposta`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `konusmacılar`
--

LOCK TABLES `konusmacılar` WRITE;
/*!40000 ALTER TABLE `konusmacılar` DISABLE KEYS */;
INSERT INTO `konusmacılar` VALUES (10,'Selcuk Erden','Yapay Zeka ve Robotik','selcuk.erden@gmail.com'),(11,'Ozlem Yildiz','Siber Guvenlik Uzmani','ozlem.yildiz@gmail.com'),(12,'Gokhan Avci','Bulut Bilisim Mimari','gokhan.avci@gmail.com'),(13,'Cigdem Aksoy','Dijital Pazarlama','cigdemaksoy@gmail.com'),(14,'Mert Kaan Soyer','Endustriyel Tasarim','mertsoyer@gmail.com'),(15,'Busra Demir','Modern Tip ve Biyoteknoloji','busrademir@gmail.com'),(16,'Ibrahim Celik','Lojistik ve Tedarik Zinciri','ibrahimcelik@gmail.com'),(17,'Selin Gunes','Insan Kaynaklari Yonetimi','selingunes@gmail.com'),(18,'Ayse Nur Sahin','Psikoloji ve Davranis','aysesahin@gmail.com'),(19,'Yigit Can','Uluslararasi Hukuk','yigitcan@gmail.com');
/*!40000 ALTER TABLE `konusmacılar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oturumlar`
--

DROP TABLE IF EXISTS `oturumlar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oturumlar` (
  `idoturumlar` int NOT NULL AUTO_INCREMENT,
  `konu` varchar(200) NOT NULL,
  `baslangic_saati` datetime NOT NULL,
  `bitis_saati` datetime NOT NULL,
  `salon_id` int DEFAULT NULL,
  `etkinlik_id` int NOT NULL,
  `konusmaci_id` int DEFAULT NULL,
  PRIMARY KEY (`idoturumlar`),
  KEY `fk_oturumlar_etkinlik_id_idx` (`etkinlik_id`),
  KEY `fk_oturumlar_salon_id_idx` (`salon_id`),
  KEY `fk_oturumlar_konusmaci_id_idx` (`konusmaci_id`),
  CONSTRAINT `fk_oturumlar_etkinlik_id` FOREIGN KEY (`etkinlik_id`) REFERENCES `etkinlikler` (`idetkinlikler`),
  CONSTRAINT `fk_oturumlar_konusmaci_id` FOREIGN KEY (`konusmaci_id`) REFERENCES `konusmacılar` (`konusmaci_id`),
  CONSTRAINT `fk_oturumlar_salon_id` FOREIGN KEY (`salon_id`) REFERENCES `salonlar` (`salon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oturumlar`
--

LOCK TABLES `oturumlar` WRITE;
/*!40000 ALTER TABLE `oturumlar` DISABLE KEYS */;
/*!40000 ALTER TABLE `oturumlar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salonlar`
--

DROP TABLE IF EXISTS `salonlar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salonlar` (
  `salon_id` int NOT NULL AUTO_INCREMENT,
  `salon_adi` varchar(50) NOT NULL,
  `kapasite` int NOT NULL,
  PRIMARY KEY (`salon_id`),
  UNIQUE KEY `salon_adi_UNIQUE` (`salon_adi`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salonlar`
--

LOCK TABLES `salonlar` WRITE;
/*!40000 ALTER TABLE `salonlar` DISABLE KEYS */;
INSERT INTO `salonlar` VALUES (1,'Ataturk Konferans Salonu ',400),(2,'Cumhuriyet Salonu',200),(3,'Farabi Konferans Salonu',120),(4,'Girisimcilik  Odası ',90),(5,'Teknolji Sınıfı ',50),(6,'Baki Komsuoğlu',500),(7,'Bulusma Noktasi A',60),(8,'Bulusma Noktasi B',90),(9,'Kongre Merkezi',200),(10,'Kariyer Ofisi',30);
/*!40000 ALTER TABLE `salonlar` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-30 16:01:30
