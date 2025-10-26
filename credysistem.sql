-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: credysistem
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `bloqueo_cuenta`
--

DROP TABLE IF EXISTS `bloqueo_cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bloqueo_cuenta` (
  `id_bloqueo` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT current_timestamp(),
  `fecha_fin` datetime DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_bloqueo`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `bloqueo_cuenta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bloqueo_cuenta`
--

LOCK TABLES `bloqueo_cuenta` WRITE;
/*!40000 ALTER TABLE `bloqueo_cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `bloqueo_cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credito`
--

DROP TABLE IF EXISTS `credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credito` (
  `id_credito` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `monto_original` decimal(12,2) NOT NULL,
  `saldo_pendiente` decimal(12,2) DEFAULT NULL,
  `tasa_interes_anual` decimal(5,2) DEFAULT NULL,
  `plazo_meses` int(11) DEFAULT NULL,
  `fecha_otorgamiento` date DEFAULT NULL,
  `primer_vencimiento` date DEFAULT NULL,
  `estado` enum('vigente','cancelado','en_mora') DEFAULT 'vigente',
  PRIMARY KEY (`id_credito`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `credito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credito`
--

LOCK TABLES `credito` WRITE;
/*!40000 ALTER TABLE `credito` DISABLE KEYS */;
INSERT INTO `credito` VALUES (1,18,20000.00,20000.00,45.00,12,'2025-10-25','2025-10-28','vigente');
/*!40000 ALTER TABLE `credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `intento_acceso`
--

DROP TABLE IF EXISTS `intento_acceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intento_acceso` (
  `id_intento` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_intento` datetime DEFAULT current_timestamp(),
  `exito` tinyint(1) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `motivo_fallo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_intento`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `intento_acceso_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `intento_acceso`
--

LOCK TABLES `intento_acceso` WRITE;
/*!40000 ALTER TABLE `intento_acceso` DISABLE KEYS */;
/*!40000 ALTER TABLE `intento_acceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `tipo` enum('sistema','pago','alerta','info') DEFAULT NULL,
  `mensaje` varchar(255) DEFAULT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp(),
  `leida` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_notificacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `notificacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacion`
--

LOCK TABLES `notificacion` WRITE;
/*!40000 ALTER TABLE `notificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL AUTO_INCREMENT,
  `id_credito` int(11) DEFAULT NULL,
  `fecha_pago` datetime DEFAULT NULL,
  `monto_pagado` decimal(12,2) DEFAULT NULL,
  `medio_pago` enum('efectivo','transferencia','tarjeta','debito') NOT NULL,
  `comprobante_url` varchar(255) DEFAULT NULL,
  `resultado` enum('exitoso','fallido','pendiente') DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_credito` (`id_credito`),
  CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_credito`) REFERENCES `credito` (`id_credito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago`
--

LOCK TABLES `pago` WRITE;
/*!40000 ALTER TABLE `pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simulacion`
--

DROP TABLE IF EXISTS `simulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `simulacion` (
  `id_simulacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `monto` decimal(12,2) DEFAULT NULL,
  `plazo_meses` int(11) DEFAULT NULL,
  `tasa_anual` decimal(5,2) DEFAULT NULL,
  `cuota_estim` decimal(12,2) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_simulacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `simulacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simulacion`
--

LOCK TABLES `simulacion` WRITE;
/*!40000 ALTER TABLE `simulacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `simulacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitud_credito`
--

DROP TABLE IF EXISTS `solicitud_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitud_credito` (
  `id_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `monto_solicitado` decimal(12,2) NOT NULL,
  `ingresos_mensuales` decimal(12,2) DEFAULT NULL,
  `plazo_meses` int(11) DEFAULT NULL,
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  `fecha_solicitud` datetime DEFAULT current_timestamp(),
  `motivo_rechazo` varchar(255) DEFAULT NULL,
  `comprobantes_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `solicitud_credito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitud_credito`
--

LOCK TABLES `solicitud_credito` WRITE;
/*!40000 ALTER TABLE `solicitud_credito` DISABLE KEYS */;
/*!40000 ALTER TABLE `solicitud_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccion` (
  `id_transaccion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `tipo` enum('alta_credito','pago','ajuste','otros') DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `descripcion` varchar(255) DEFAULT NULL,
  `importe` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id_transaccion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `transaccion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccion`
--

LOCK TABLES `transaccion` WRITE;
/*!40000 ALTER TABLE `transaccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `codigo_postal` varchar(10) DEFAULT NULL,
  `hash_password` varchar(255) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `documento` (`documento`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (2,'Emmanuel','Nardone','34820341@terciariourquiza.edu.ar','4653933','34820541','Dorrego 6169','Argentina','Rosario','2000','$2y$10$OxOsH/Gn7aL3PQmyQdnNFetqdW2pbS0OWa0eqlR/GMlzkJkZT/d72','2025-10-23 22:45:28'),(3,'Roberto Jose ','Perez','Robert@hotmail.com','3148557963','18254789','Dorrego 6169','Argentina','Rosario','2000','$2y$10$L80iMNe.mkVVpy8HvD9GnePdz8XHMyiDF2rO7FidLa2tlyEuuU7Bm','2025-10-24 19:32:54'),(5,'Emmanuel','Nardone','34820347771@terciariourquiza.edu.ar','3415664','34824441','Dorrego 6169','Argentina','Rosario','2000','$2y$10$MEoKpRml7LG5nSfR01wC5.GmpWtdNGokKuvpPoDDKQJQVPKWseWEC','2025-10-24 21:10:51'),(7,'Emmanuel','Nardone','3482034777771@terciariourquiza.edu.ar','34156647','348244741','Dorrego 6169','Argentina','Rosario','2000','$2y$10$volWTBLz8fm1LcMClsCP6.uQfg6O/UtWzde1wiR10eSzR4PsQ0Pv.','2025-10-24 21:12:55'),(8,'Emmanuel','Nardone','348207771@terciariourquiza.edu.ar','341647','348241','Dorrego 6169','Argentina','Rosario','2000','$2y$10$LkoFtjQ.TPL9/g/hp0QvE.IMwDlFLDdGV043k0Dkc.NON2ffHqwMa','2025-10-24 21:15:04'),(9,'Emmanuel','Nardone','3482707771@terciariourquiza.edu.ar','34771647','3748241','Dorrego 61769','Argentina','Rosario','2000','$2y$10$yb1p0D/DeOO85OGqVD7O7Os0/a6Gn2dvH2JpJn079IUAItNraOpcy','2025-10-24 21:17:04'),(10,'Emmanuel','Nardone','emmanuel_dna@hotm1ail.com','46531933','34820341','Dorrego 6169','Argentina','Rosario','2000','$2y$10$XMrQTvqLh/pbXHj5OVAZb.wSQbIIft49z4DlyxZErws.LhnmVcdsa','2025-10-24 21:18:49'),(11,'Emmanuel','Nardone','em8manuel_dna@hotm1ail.com','4653141933','3485520341','Dorrego 61695','Argentina','Rosario','2000','$2y$10$NltM8YBxmIDKipwoRplpHu0niwu0Ppdimpgq52UiODwLhpyeHNtV2','2025-10-24 21:23:04'),(13,'Emmanuel','Nardone','348203413@terciariourquiza.edu.ar','341341566','348204767','Dorrego 616','Argentina','Rosario','2000','$2y$10$BHGELJZt7yjZIMJeLt4HTedbc./jWfYaGgynVwajDB5OlO4oQ2Q.6','2025-10-24 21:35:10'),(14,'Emmanuel','Nardone','emi@hotmail.com','11111','314820341','Dorrego 6169','Argentina','Rosario','2000','$2y$10$ggUePljhcSkJlgt5XiShxuErhULp9I/DYBxIAKNkcAE3BKG2vUKZS','2025-10-24 21:44:23'),(15,'Emmanuel','Nardone','emmi@hotmail.com','111111111111','348210341','Dorrego 6169','Argentina','Rosario','2000','$2y$10$COSzImhSIDbWfVaWVnlAoendu2izYM6BPMwTavxnxc7WgNzBaSuZu','2025-10-24 22:00:07'),(16,'Emmanuel','Nardone','ema@hotmail.com','3458889999','3482035','Dorrego 6169','Argentina','Rosario','2000','$2y$10$ZTtZXv6PCrS8bQgvgjgs.e8CSLBrD0.JFVnVxrT4cemw7r.j/xImm','2025-10-24 22:13:25'),(17,'Emmanuel','Nardone','emi1@hotmail.com','46539343','3482034178','Dorrego 6169','Argentina','Rosario','2000','$2y$10$vV.EUvJQNYvZUtFx7JxTLOsxkvBk1p7cWsuaaMf5PIPNf68jInlAi','2025-10-24 22:42:16'),(18,'Emmanuel','Nardone','emmanuel_dna@hotmail.com','34156','3482','Dorrego 61','Argentina','Rosario','2000','$2y$10$ucOk1XWoYx9CRoGOnD8dnu042eRr7Polrw70bSfiRdAmeO1qjeUAa','2025-10-24 22:48:27');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-24 23:12:19
