-- MySQL Script generated by MySQL Workbench
-- Fri Aug 18 12:08:05 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hr_assistance_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hr_assistance_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hr_assistance_db` DEFAULT CHARACTER SET utf8 ;
USE `hr_assistance_db` ;

-- -----------------------------------------------------
-- Table `hr_assistance_db`.`USER_ROLES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`USER_ROLES` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`USER_ROLES` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CODE` VARCHAR(45) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `CODE_UNIQUE` (`CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`USERS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`USERS` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`USERS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `USERNAME` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(45) NOT NULL,
  `PASSWORD` VARCHAR(45) NOT NULL,
  `USER_ROLE_ID` INT NOT NULL,
  `LAST_LOGIN` DATETIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC),
  UNIQUE INDEX `USERNAME_UNIQUE` (`USERNAME` ASC),
  INDEX `USER_ROLE_idx` (`USER_ROLE_ID` ASC),
  CONSTRAINT `USER_ROLE`
    FOREIGN KEY (`USER_ROLE_ID`)
    REFERENCES `hr_assistance_db`.`USER_ROLES` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`PERSONAL_INFO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`PERSONAL_INFO` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`PERSONAL_INFO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `USER_ID` INT NOT NULL,
  `FIRST_NAME` VARCHAR(45) NULL,
  `LAST_NAME` VARCHAR(45) NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `USER_PERSONAL_INFO_idx` (`USER_ID` ASC),
  CONSTRAINT `USER_PERSONAL_INFO`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `hr_assistance_db`.`USERS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`USER_EDUCATIONS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`USER_EDUCATIONS` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`USER_EDUCATIONS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PERSONAL_INFO_ID` INT NOT NULL,
  `SCHOOL_NAME` VARCHAR(45) NULL,
  `GRADUATED_YEAR` INT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `USER_EDUCATION_idx` (`PERSONAL_INFO_ID` ASC),
  CONSTRAINT `USER_EDUCATIONS`
    FOREIGN KEY (`PERSONAL_INFO_ID`)
    REFERENCES `hr_assistance_db`.`PERSONAL_INFO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`SKILLS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`SKILLS` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`SKILLS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `NAME_UNIQUE` (`NAME` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`USER_SKILLS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`USER_SKILLS` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`USER_SKILLS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PERSONAL_INFO_ID` INT NOT NULL,
  `SKILL_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `USER_SKILLS_idx` (`PERSONAL_INFO_ID` ASC),
  INDEX `SKILLS_idx` (`SKILL_ID` ASC),
  CONSTRAINT `USER_SKILLS`
    FOREIGN KEY (`PERSONAL_INFO_ID`)
    REFERENCES `hr_assistance_db`.`PERSONAL_INFO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SKILLS`
    FOREIGN KEY (`SKILL_ID`)
    REFERENCES `hr_assistance_db`.`SKILLS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`USER_WORK_EXPERIENCES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`USER_WORK_EXPERIENCES` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`USER_WORK_EXPERIENCES` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PERSONAL_INFO_ID` INT NOT NULL,
  `COMPANY_NAME` VARCHAR(45) NULL,
  `POSITION` VARCHAR(45) NULL,
  `START_DATE` DATE NULL,
  `END_DATE` DATE NULL,
  PRIMARY KEY (`ID`),
  INDEX `USER_WORK_EXPERIENCES_idx` (`PERSONAL_INFO_ID` ASC),
  CONSTRAINT `USER_WORK_EXPERIENCES`
    FOREIGN KEY (`PERSONAL_INFO_ID`)
    REFERENCES `hr_assistance_db`.`PERSONAL_INFO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`JOBS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`JOBS` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`JOBS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `BENEFITS` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_assistance_db`.`JOB_REQUIREMENTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hr_assistance_db`.`JOB_REQUIREMENTS` ;

CREATE TABLE IF NOT EXISTS `hr_assistance_db`.`JOB_REQUIREMENTS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `JOB_ID` INT NOT NULL,
  `SKILL_ID` INT NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `JOB_REQUIRMENTS_idx` (`JOB_ID` ASC),
  INDEX `SKILL_REQUIRMENTS_idx` (`SKILL_ID` ASC),
  CONSTRAINT `JOB_REQUIREMENTS`
    FOREIGN KEY (`JOB_ID`)
    REFERENCES `hr_assistance_db`.`JOBS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SKILL_REQUIREMENTS`
    FOREIGN KEY (`SKILL_ID`)
    REFERENCES `hr_assistance_db`.`SKILLS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;