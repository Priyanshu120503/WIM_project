-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema railwayDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema railwayDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `railwayDB` DEFAULT CHARACTER SET utf8 ;
USE `railwayDB` ;

-- -----------------------------------------------------
-- Table `railwayDB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railwayDB`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `fullName` VARCHAR(100) NULL,
  `gender` VARCHAR(6) NULL,
  `emailID` VARCHAR(45) NULL,
  `contact` VARCHAR(10) NULL,
  `dob` DATE NULL,
  `address` VARCHAR(150) NULL,
  `pinCode` VARCHAR(6) NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `emailID_UNIQUE` (`emailID` ASC) VISIBLE,
  UNIQUE INDEX `contact_UNIQUE` (`contact` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `railwayDB`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railwayDB`.`Student` (
  `UserID` INT NOT NULL,
  `rollNumber` VARCHAR(10) NULL,
  `academicYear` VARCHAR(20) NULL,
  `branch` VARCHAR(45) NULL,
  `semester` VARCHAR(1) NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `rollNumber_UNIQUE` (`rollNumber` ASC) VISIBLE,
  CONSTRAINT `studentUserId`
    FOREIGN KEY (`UserID`)
    REFERENCES `railwayDB`.`User` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `railwayDB`.`Concession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railwayDB`.`Concession` (
  `idConcession` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `sourceStation` VARCHAR(45) NULL,
  `destinationStation` VARCHAR(45) NULL,
  `prevPassNumber` VARCHAR(45) NULL,
  `oldPassExpiryDate` DATE NULL,
  `appliedDate` DATE NULL,
  `passDuration` VARCHAR(45) NULL,
  `travelClass` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `remarks` VARCHAR(200) NULL,
  PRIMARY KEY (`idConcession`),
  INDEX `user_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `concUserId`
    FOREIGN KEY (`UserID`)
    REFERENCES `railwayDB`.`Student` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
