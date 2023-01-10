-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema astride
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `astride` ;

-- -----------------------------------------------------
-- Schema astride
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `astride` DEFAULT CHARACTER SET utf8 ;
USE `astride` ;

-- -----------------------------------------------------
-- Table `astride`.`trainings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`trainings` ;

CREATE TABLE IF NOT EXISTS `astride`.`trainings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` LONGTEXT NULL,
  `time` TIME NOT NULL,
  `feeling` ENUM('VSTRONG', 'STRONG', 'NORMAL', 'WEAK', 'VWEAK') NULL,
  `exertion` ENUM('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') NULL,
  `status` ENUM('PLANNED', 'NOT_DONE', 'DONE') NULL,
  `trainingscol` VARCHAR(45) NULL,
  `post_activity` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`users` ;

CREATE TABLE IF NOT EXISTS `astride`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `token_mail` VARCHAR(45) NOT NULL,
  `verified` ENUM('ACTIVE', 'PENDING') NOT NULL DEFAULT 'PENDING',
  `gender` ENUM('MALE', 'FEMALE', 'OTHER') NOT NULL,
  `profile_picture` VARCHAR(45) NULL,
  `trainer_id` INT NULL,
  `roles_id` INT UNSIGNED NOT NULL,
  `trainings_id` INT UNSIGNED NOT NULL,
  `ADMIN` INT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_users_trainings1_idx` (`trainings_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_trainings1`
    FOREIGN KEY (`trainings_id`)
    REFERENCES `astride`.`trainings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`trainers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`trainers` ;

CREATE TABLE IF NOT EXISTS `astride`.`trainers` (
  `idtrainers` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idtrainers`),
  UNIQUE INDEX `idtrainers_UNIQUE` (`idtrainers` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`trainers_has_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`trainers_has_users` ;

CREATE TABLE IF NOT EXISTS `astride`.`trainers_has_users` (
  `trainers_idtrainers` INT UNSIGNED NOT NULL,
  `users_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`trainers_idtrainers`, `users_id`),
  INDEX `fk_trainers_has_users_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_trainers_has_users_trainers1_idx` (`trainers_idtrainers` ASC) VISIBLE,
  CONSTRAINT `fk_trainers_has_users_trainers1`
    FOREIGN KEY (`trainers_idtrainers`)
    REFERENCES `astride`.`trainers` (`idtrainers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trainers_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `astride`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`athletes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`athletes` ;

CREATE TABLE IF NOT EXISTS `astride`.`athletes` (
  `idathletes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idathletes`),
  UNIQUE INDEX `idathletes_UNIQUE` (`idathletes` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`users_has_athletes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`users_has_athletes` ;

CREATE TABLE IF NOT EXISTS `astride`.`users_has_athletes` (
  `users_id` INT UNSIGNED NOT NULL,
  `athletes_idathletes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`, `athletes_idathletes`),
  INDEX `fk_users_has_athletes_athletes1_idx` (`athletes_idathletes` ASC) VISIBLE,
  INDEX `fk_users_has_athletes_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_athletes_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `astride`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_athletes_athletes1`
    FOREIGN KEY (`athletes_idathletes`)
    REFERENCES `astride`.`athletes` (`idathletes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
