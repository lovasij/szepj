-- Schema
USE `112e.betegnyilvantartas`;

-- -----------------------------
-- PACIENS
-- -----------------------------
CREATE TABLE IF NOT EXISTS `PACIENS` (
  `pID` INT NOT NULL,
  `pname` VARCHAR(45) NULL,
  `padress` VARCHAR(45) NOT NULL,
  `pphone` VARCHAR(45) NULL,
  PRIMARY KEY (`pID`)
) ENGINE=InnoDB;

-- -----------------------------
-- VIZSGALAT
-- -----------------------------
CREATE TABLE IF NOT EXISTS `VIZSGALAT` (
  `vID` INT NOT NULL AUTO_INCREMENT,
  `pID` INT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`vID`),
  INDEX `idx_vizsgalat_pid` (`pID`),
  CONSTRAINT `fk_vizsgalat_paciens`
    FOREIGN KEY (`pID`)
    REFERENCES `PACIENS` (`pID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- -----------------------------
-- BETEGSEG
-- -----------------------------
CREATE TABLE IF NOT EXISTS `BETEGSEG` (
  `bID` INT NOT NULL AUTO_INCREMENT,
  `bname` VARCHAR(45) NULL,
  PRIMARY KEY (`bID`)
) ENGINE=InnoDB;

-- -----------------------------
-- GYOGYSZER
-- -----------------------------
CREATE TABLE IF NOT EXISTS `GYOGYSZER` (
  `gyID` INT NOT NULL AUTO_INCREMENT,
  `gyname` VARCHAR(45) NULL,
  PRIMARY KEY (`gyID`)
) ENGINE=InnoDB;

-- -----------------------------
-- MIT_KAP
-- -----------------------------
CREATE TABLE IF NOT EXISTS `MIT_KAP` (
  `bID` INT NOT NULL,
  `gyID` INT NOT NULL,
  PRIMARY KEY (`bID`, `gyID`),

  INDEX `idx_mitkap_gyid` (`gyID`),

  CONSTRAINT `fk_mitkap_betegseg`
    FOREIGN KEY (`bID`)
    REFERENCES `BETEGSEG` (`bID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_mitkap_gyogyszer`
    FOREIGN KEY (`gyID`)
    REFERENCES `GYOGYSZER` (`gyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- -----------------------------
-- MIRE_ERZEKENY
-- -----------------------------
CREATE TABLE IF NOT EXISTS `MIRE_ERZEKENY` (
  `pID` INT NOT NULL,
  `gyID` INT NOT NULL,

  PRIMARY KEY (`pID`, `gyID`),

  INDEX `idx_mire_gyid` (`gyID`),

  CONSTRAINT `fk_mire_paciens`
    FOREIGN KEY (`pID`)
    REFERENCES `PACIENS` (`pID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_mire_gyogyszer`
    FOREIGN KEY (`gyID`)
    REFERENCES `GYOGYSZER` (`gyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- -----------------------------
-- DIAGNOZIS
-- -----------------------------
CREATE TABLE IF NOT EXISTS `DIAGNOZIS` (
  `vID` INT NOT NULL,
  `datum` DATE NULL,
  `bID` INT NOT NULL,

  PRIMARY KEY (`vID`, `bID`),

  INDEX `idx_diag_bID` (`bID`),

  CONSTRAINT `fk_diag_vizsgalat`
    FOREIGN KEY (`vID`)
    REFERENCES `VIZSGALAT` (`vID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_diag_betegseg`
    FOREIGN KEY (`bID`)
    REFERENCES `BETEGSEG` (`bID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;