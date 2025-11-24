-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbsamurai
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbsamurai
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbsamurai` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbsamurai` ;

-- -----------------------------------------------------
-- Table `dbsamurai`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsamurai`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellidos` VARCHAR(30) NOT NULL,
  `dni` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbsamurai`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsamurai`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `idCliente` INT NOT NULL,
  `total` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FkPedidosClientes_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `FkPedidosClientes`
    FOREIGN KEY (`idCliente`)
    REFERENCES `dbsamurai`.`clientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbsamurai`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsamurai`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(30) NOT NULL,
  `nombreProducto` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbsamurai`.`detallepedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsamurai`.`detallepedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idPedido` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FkdetallePedidoProducto_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fkdetallePedidoPedido_idx` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `fkdetallePedidoPedido`
    FOREIGN KEY (`idPedido`)
    REFERENCES `dbsamurai`.`pedidos` (`id`),
  CONSTRAINT `FkdetallePedidoProducto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `dbsamurai`.`productos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbsamurai`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsamurai`.`inventario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FkinventarioProductos_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `FkinventarioProductos`
    FOREIGN KEY (`idProducto`)
    REFERENCES `dbsamurai`.`productos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
