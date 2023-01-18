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
-- Table `astride`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`users` ;

CREATE TABLE IF NOT EXISTS `astride`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `token_mail` VARCHAR(255) NOT NULL,
  `verified` ENUM('ACTIVE', 'PENDING') NOT NULL DEFAULT 'PENDING',
  `gender` ENUM('MALE', 'FEMALE', 'OTHER') NOT NULL,
  `profile_picture` VARCHAR(45) NULL,
  `trainer_id` INT NULL,
  `ADMIN` INT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`athletes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`athletes` ;

CREATE TABLE IF NOT EXISTS `astride`.`athletes` (
  `users_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`),
  CONSTRAINT `fk_athletes_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `astride`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`trainers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`trainers` ;

CREATE TABLE IF NOT EXISTS `astride`.`trainers` (
  `users_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`),
  CONSTRAINT `fk_trainers_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `astride`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `astride`.`trainings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`trainings` ;

CREATE TABLE IF NOT EXISTS `astride`.`trainings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM('RUNNING', 'CYCLING', 'SWIMMING', 'WORKOUT', 'OTHER') NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` LONGTEXT NULL,
  `time` TIME NOT NULL,
  `feeling` ENUM('VSTRONG', 'STRONG', 'NORMAL', 'WEAK', 'VWEAK') NULL,
  `exertion` ENUM('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') NULL,
  `status` ENUM('PLANNED', 'NOT_DONE', 'DONE') NOT NULL,
  `post_activity` MEDIUMTEXT NULL,
  `athletes_users_id` INT UNSIGNED NOT NULL,
  `trainers_users_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_trainings_athletes1_idx` (`athletes_users_id` ASC) VISIBLE,
  INDEX `fk_trainings_trainers1_idx` (`trainers_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_trainings_athletes1`
    FOREIGN KEY (`athletes_users_id`)
    REFERENCES `astride`.`athletes` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trainings_trainers1`
    FOREIGN KEY (`trainers_users_id`)
    REFERENCES `astride`.`trainers` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `astride` ;

-- -----------------------------------------------------
-- Placeholder table for view `astride`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `astride`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `astride`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `astride`.`view1`;
DROP VIEW IF EXISTS `astride`.`view1` ;
USE `astride`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `astride`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `astride`;
INSERT INTO `astride`.`users` (`id`, `firstname`, `lastname`, `mail`, `password`, `token_mail`, `verified`, `gender`, `profile_picture`, `trainer_id`, `ADMIN`) VALUES (1, 'Loran', 'Maes', 'loran.maes@gmail.com', '$2y$10$Qs8.AKv8yR4frA3sdGnR0uRzcnjoZV9RdDG.0bLfjLFF9aPYU/VyK', 'abcd123', 'ACTIVE', 'MALE', NULL, 1, 1);
INSERT INTO `astride`.`users` (`id`, `firstname`, `lastname`, `mail`, `password`, `token_mail`, `verified`, `gender`, `profile_picture`, `trainer_id`, `ADMIN`) VALUES (2, 'Stijn', 'Van Raemdonck', 'stijn.vr@gmail.com', '$2y$10$5JLxWwXADLIr27fWufDndebVW.iDYPcYHl5AKGOP.2wEeoexM04c6', 'abcd123', 'ACTIVE', 'MALE', NULL, 0, 0);
INSERT INTO `astride`.`users` (`id`, `firstname`, `lastname`, `mail`, `password`, `token_mail`, `verified`, `gender`, `profile_picture`, `trainer_id`, `ADMIN`) VALUES (3, 'Rune', 'Leemans', 'rune.leemans@gmail.com', '$2y$10$rfE3LiX2b4H3CZDKNKKHdu5FXNJvQBk5GkfWyGyJb05PLgsZSH9Oa', 'abcd123', 'ACTIVE', 'MALE', 'jpg', 0, 0);
INSERT INTO `astride`.`users` (`id`, `firstname`, `lastname`, `mail`, `password`, `token_mail`, `verified`, `gender`, `profile_picture`, `trainer_id`, `ADMIN`) VALUES (4, 'Jente', 'De Camps', 'jente.decamps@gmail.com', '$2y$10$YryRWu7SNlqyIEVbrFLeM./brh8sEqbbBEaYqy6dSFfbHbqQh/dR.', 'abcd123', 'ACTIVE', 'MALE', 'png', NULL, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `astride`.`athletes`
-- -----------------------------------------------------
START TRANSACTION;
USE `astride`;
INSERT INTO `astride`.`athletes` (`users_id`) VALUES (2);
INSERT INTO `astride`.`athletes` (`users_id`) VALUES (3);
INSERT INTO `astride`.`athletes` (`users_id`) VALUES (4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `astride`.`trainers`
-- -----------------------------------------------------
START TRANSACTION;
USE `astride`;
INSERT INTO `astride`.`trainers` (`users_id`) VALUES (1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `astride`.`trainings`
-- -----------------------------------------------------
START TRANSACTION;
USE `astride`;
INSERT INTO `astride`.`trainings` (`id`, `type`, `name`, `description`, `time`, `feeling`, `exertion`, `status`, `post_activity`, `athletes_users_id`, `trainers_users_id`) VALUES (1, 'CYCLING', 'Long Ride', 'On this ride you will do a long ride with every 30 minutes an all out sprint of 30 seconds.', '4:30:00', NULL, NULL, 'PLANNED', NULL, 2, 1);
INSERT INTO `astride`.`trainings` (`id`, `type`, `name`, `description`, `time`, `feeling`, `exertion`, `status`, `post_activity`, `athletes_users_id`, `trainers_users_id`) VALUES (2, 'CYCLING', 'Tempo intervals', '30min WU, 3x10min Z3, 20min CD', '02:15:00', NULL, NULL, 'PLANNED', NULL, 3, 1);
INSERT INTO `astride`.`trainings` (`id`, `type`, `name`, `description`, `time`, `feeling`, `exertion`, `status`, `post_activity`, `athletes_users_id`, `trainers_users_id`) VALUES (3, 'CYCLING', 'VO2 Intervals', '20min WU, 2x10min 30-30 intervals, 20\' CD ', '01:05:00', 'STRONG', '8', 'DONE', 'Felt great during the training', 2, 1);
INSERT INTO `astride`.`trainings` (`id`, `type`, `name`, `description`, `time`, `feeling`, `exertion`, `status`, `post_activity`, `athletes_users_id`, `trainers_users_id`) VALUES (4, 'CYCLING', 'Recovery Ride', '1u recovery', '01:00:00', NULL, NULL, 'NOT_DONE', 'Was niet thuis', 4, NULL);
INSERT INTO `astride`.`trainings` (`id`, `type`, `name`, `description`, `time`, `feeling`, `exertion`, `status`, `post_activity`, `athletes_users_id`, `trainers_users_id`) VALUES (5, 'RUNNING', 'Long Run', 'Rustige Duurloop', '01:15:00', NULL, NULL, 'PLANNED', NULL, 4, NULL);

COMMIT;

