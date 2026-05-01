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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etkinlik_turleri`
--

LOCK TABLES `etkinlik_turleri` WRITE;
/*!40000 ALTER TABLE `etkinlik_turleri` DISABLE KEYS */;
INSERT INTO `etkinlik_turleri` VALUES (7,'Calistay'),(8,'Egitim'),(5,'Forum'),(1,'Konferans'),(10,'Network Etkinligi'),(2,'Panel'),(4,'Seminer'),(6,'Sempozyum'),(9,'Sergi'),(3,'Workshop');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etkinlikler`
--

LOCK TABLES `etkinlikler` WRITE;
/*!40000 ALTER TABLE `etkinlikler` DISABLE KEYS */;
INSERT INTO `etkinlikler` VALUES (1,'Global Enerji Zirvesi','2026-06-01','2026-06-03',1),(2,'Tarim Teknolojileri Fuari','2026-06-05','2026-06-07',8),(3,'Finans ve Ekonomi Gunleri','2026-06-10','2026-06-12',2),(4,'Dijital Pazarlama Kongresi','2026-06-15','2026-06-17',1),(5,'Modern Mimari Calistayi','2026-06-20','2026-06-22',7),(6,'Saglikta Inovasyon Forumu','2026-06-25','2026-06-27',5),(7,'Lojistik Yonetimi Zirvesi','2026-07-01','2026-07-03',10),(8,'Gelecegin IK Trendleri','2026-07-05','2026-07-07',2),(9,'Hukuk ve Etik Sempozyumu','2026-07-10','2026-07-12',6),(10,'Psikoloji ve Insan Bilimi','2026-07-15','2026-07-17',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `katilimcilar`
--

LOCK TABLES `katilimcilar` WRITE;
/*!40000 ALTER TABLE `katilimcilar` DISABLE KEYS */;
INSERT INTO `katilimcilar` VALUES (1,'Caner Aras','caneraras@gmail.com','05321112233'),(2,'Merve Ozturk','merveozturk@gmail.com','05332223344'),(3,'Deniz Soylu','denizsoylu@gmail.com','05423334455'),(4,'Burak Yilmaz','burakyilmaz@gmail.com','05054445566'),(5,'Ece Serter','eceserter@gmail.com','05305556677'),(6,'Kaan Arda','kaanarda@gmail.com','05356667788'),(7,'Selin Cetin','selincetin@gmail.com','05447778899'),(8,'Derya Gunes','deryagunes@gmail.com','05319990011'),(9,'Umut Akman','umutakman@gmail.com','05390001122'),(10,'Ela Akbenli','elaakbenli@gmail.com','05459876566');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kayitlar`
--

LOCK TABLES `kayitlar` WRITE;
/*!40000 ALTER TABLE `kayitlar` DISABLE KEYS */;
INSERT INTO `kayitlar` VALUES (1,'2026-05-01 21:12:21',1,1),(2,'2026-05-01 21:12:21',2,2),(3,'2026-05-01 21:12:21',3,3),(4,'2026-05-01 21:12:21',4,4),(5,'2026-05-01 21:12:21',5,5),(6,'2026-05-01 21:12:21',6,6),(7,'2026-05-01 21:12:21',7,7),(8,'2026-05-01 21:12:21',8,8),(9,'2026-05-01 21:12:21',9,9),(10,'2026-05-01 21:12:21',10,10);
/*!40000 ALTER TABLE `kayitlar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `konusmacilar`
--

DROP TABLE IF EXISTS `konusmacilar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `konusmacilar` (
  `konusmaci_id` int NOT NULL AUTO_INCREMENT,
  `ad_soyad` varchar(100) NOT NULL,
  `uzmanlik_alani` varchar(100) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  PRIMARY KEY (`konusmaci_id`),
  UNIQUE KEY `eposta_UNIQUE` (`eposta`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `konusmacilar`
--

LOCK TABLES `konusmacilar` WRITE;
/*!40000 ALTER TABLE `konusmacilar` DISABLE KEYS */;
INSERT INTO `konusmacilar` VALUES (10,'Selcuk Erden','Enerji Sistemleri Muhendisi','selcuk.erden@gmail.com'),(11,'Ozlem Yildiz','Uluslararası Hukuk Danışmanı','ozlem.yildiz@gmail.com'),(12,'Gokhan Avci','Ziraat Yuksek Muhendisi','gokhan.avci@gmail.com'),(13,'Cigdem Aksoy','Siber Guvenlik Direktoru','cigdemaksoy@gmail.com'),(14,'Mert Kaan Soyer','Veri Bilimi Uzmani','mertsoyer@gmail.com'),(15,'Busra Demir','Sürdürülebilir Mimari Uzmanı','busrademir@gmail.com'),(16,'Ibrahim Celik','Dijital Pazarlama Stratejisti','ibrahimcelik@gmail.com'),(17,'Selin Gunes','Blockchain ve Fintech Uzmani','selingunes@gmail.com'),(18,'Ayse Nur Sahin','Klinik Psikolog','aysesahin@gmail.com'),(19,'Yigit Can','Lojistik ve Operasyon Muduru','yigitcan@gmail.com');
/*!40000 ALTER TABLE `konusmacilar` ENABLE KEYS */;
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
  CONSTRAINT `fk_oturumlar_konusmaci_id` FOREIGN KEY (`konusmaci_id`) REFERENCES `konusmacilar` (`konusmaci_id`),
  CONSTRAINT `fk_oturumlar_salon_id` FOREIGN KEY (`salon_id`) REFERENCES `salonlar` (`salon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oturumlar`
--

LOCK TABLES `oturumlar` WRITE;
/*!40000 ALTER TABLE `oturumlar` DISABLE KEYS */;
INSERT INTO `oturumlar` VALUES (1,'Yenilenebilir Enerji Kaynaklari','2026-06-01 10:00:00','2026-06-01 12:00:00',1,1,10),(2,'Akilli Tarim ve Verimlilik','2026-06-05 14:00:00','2026-06-05 16:00:00',5,2,11),(3,'Finansal Piyasalarda Guvenlik','2026-06-10 11:00:00','2026-06-10 13:00:00',3,3,12),(4,'Buyuk Veri ile Pazarlama','2026-06-15 09:30:00','2026-06-15 11:30:00',4,4,13),(5,'Blokzincir ve Gelecek','2026-06-20 15:00:00','2026-06-20 17:00:00',9,5,14),(6,'Dijital Donusum Stratejileri','2026-06-25 10:00:00','2026-06-25 12:00:00',2,6,15),(7,'Gelecegin Akilli Sehirleri','2026-07-01 13:00:00','2026-07-01 15:00:00',6,7,16),(8,'Modern Dunyada Kaygi Yonetimi','2026-07-05 11:00:00','2026-07-05 12:30:00',10,8,17),(9,'Dijital Dunyada Fikri Haklar','2026-07-10 14:00:00','2026-07-10 16:00:00',8,9,18),(10,'Global Tedarik Zinciri','2026-07-15 09:00:00','2026-07-15 11:00:00',7,10,19);
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

-- Dump completed on 2026-05-02  0:25:14
