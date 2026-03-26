-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           9.2.0 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.16.0.7229
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para db_unifacisa_locadora
DROP DATABASE IF EXISTS `db_unifacisa_locadora`;
CREATE DATABASE IF NOT EXISTS `db_unifacisa_locadora` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_unifacisa_locadora`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_categorias
DROP TABLE IF EXISTS `tb_categorias`;
CREATE TABLE IF NOT EXISTS `tb_categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de categorias de Filmes e Jogos';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_categorias: ~0 rows (aproximadamente)
DELETE FROM `tb_categorias`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_clientes
DROP TABLE IF EXISTS `tb_clientes`;
CREATE TABLE IF NOT EXISTS `tb_clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `telefone` (`telefone`),
  UNIQUE KEY `email` (`email`),
  KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de clientes da Locadora';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_clientes: ~0 rows (aproximadamente)
DELETE FROM `tb_clientes`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_devolucao
DROP TABLE IF EXISTS `tb_devolucao`;
CREATE TABLE IF NOT EXISTS `tb_devolucao` (
  `id_devolucao` int NOT NULL AUTO_INCREMENT,
  `id_locacao` int NOT NULL,
  `data_devolucao` date NOT NULL DEFAULT (curdate()),
  `multa` decimal(10,2) NOT NULL DEFAULT (0),
  PRIMARY KEY (`id_devolucao`),
  KEY `fk_id_devolucao_locacao` (`id_locacao`),
  KEY `data_devolucao` (`data_devolucao`),
  CONSTRAINT `fk_id_devolucao_locacao` FOREIGN KEY (`id_locacao`) REFERENCES `tb_locacao` (`id_locacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de devolução de locação';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_devolucao: ~0 rows (aproximadamente)
DELETE FROM `tb_devolucao`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_itens_locacao
DROP TABLE IF EXISTS `tb_itens_locacao`;
CREATE TABLE IF NOT EXISTS `tb_itens_locacao` (
  `id_item_locacao` int NOT NULL AUTO_INCREMENT,
  `id_locacao` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id_item_locacao`),
  KEY `fk_id_locaocao_itens` (`id_locacao`),
  KEY `fk_id_produto_locacao` (`id_produto`),
  CONSTRAINT `fk_id_locaocao_itens` FOREIGN KEY (`id_locacao`) REFERENCES `tb_locacao` (`id_locacao`),
  CONSTRAINT `fk_id_produto_locacao` FOREIGN KEY (`id_produto`) REFERENCES `tb_produtos` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de Itens de Locação';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_itens_locacao: ~0 rows (aproximadamente)
DELETE FROM `tb_itens_locacao`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_locacao
DROP TABLE IF EXISTS `tb_locacao`;
CREATE TABLE IF NOT EXISTS `tb_locacao` (
  `id_locacao` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `data_locacao` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id_locacao`),
  KEY `fk_id_cliente` (`id_cliente`),
  CONSTRAINT `fk_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_clientes` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de Locação de Filmes ou Jogos - Apenas o cabeçalho';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_locacao: ~0 rows (aproximadamente)
DELETE FROM `tb_locacao`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_multa
DROP TABLE IF EXISTS `tb_multa`;
CREATE TABLE IF NOT EXISTS `tb_multa` (
  `id_multa` int NOT NULL AUTO_INCREMENT,
  `id_devolucao` int NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT (0),
  `data_registro` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id_multa`),
  KEY `fk_multa_devolucao` (`id_devolucao`),
  CONSTRAINT `fk_multa_devolucao` FOREIGN KEY (`id_devolucao`) REFERENCES `tb_devolucao` (`id_devolucao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de Multa de atraso na devolução';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_multa: ~0 rows (aproximadamente)
DELETE FROM `tb_multa`;

-- Copiando estrutura para tabela db_unifacisa_locadora.tb_produtos
DROP TABLE IF EXISTS `tb_produtos`;
CREATE TABLE IF NOT EXISTS `tb_produtos` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `tipo` enum('Filme','Jogo') NOT NULL DEFAULT 'Filme',
  `id_categoria` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id_produto`),
  UNIQUE KEY `nome` (`nome`),
  KEY `fk_id_categoria` (`id_categoria`),
  KEY `tipo` (`tipo`),
  CONSTRAINT `fk_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de Filmes ou Jogos';

-- Copiando dados para a tabela db_unifacisa_locadora.tb_produtos: ~0 rows (aproximadamente)
DELETE FROM `tb_produtos`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
