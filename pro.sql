
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `CPF` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Idade` INT NOT NULL,
  `Gênero` VARCHAR(45) NULL,
  PRIMARY KEY (`CPF`));


-- -----------------------------------------------------
-- Table `mydb`.`Médico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Médico` (
  `idMédico` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `Horários disponíveis` VARCHAR(45) NULL,
  PRIMARY KEY (`idMédico`));


-- -----------------------------------------------------
-- Table `mydb`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consulta` (
  `idConsulta` INT NOT NULL AUTO_INCREMENT,
  `Data consulta` VARCHAR(45) NOT NULL,
  `Diagnóstico básico` VARCHAR(45) NOT NULL,
  `Observações` VARCHAR(45) NULL,
  `Médico_idMédico` INT NOT NULL,
  `Paciente_CPF` INT NOT NULL,
  PRIMARY KEY (`idConsulta`),
  CONSTRAINT `fk_Consulta_Médico`
    FOREIGN KEY (`Médico_idMédico`)
    REFERENCES `mydb`.`Médico` (`idMédico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Paciente1`
    FOREIGN KEY (`Paciente_CPF`)
    REFERENCES `mydb`.`Paciente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hospital` (
  `idHospital` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idHospital`));


-- -----------------------------------------------------
-- Table `mydb`.`Trabalha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trabalha` (
  `Médico_idMédico` INT NOT NULL,
  `Hospital_idHospital` INT NOT NULL,
  PRIMARY KEY (`Médico_idMédico`, `Hospital_idHospital`),
  CONSTRAINT `fk_Médico_has_Hospital_Médico1`
    FOREIGN KEY (`Médico_idMédico`)
    REFERENCES `mydb`.`Médico` (`idMédico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Médico_has_Hospital_Hospital1`
    FOREIGN KEY (`Hospital_idHospital`)
    REFERENCES `mydb`.`Hospital` (`idHospital`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Prescrição`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prescrição` (
  `idPrescrição` INT NOT NULL AUTO_INCREMENT,
  `Medicamentos` VARCHAR(45) NULL,
  `Dosagem` VARCHAR(45) NULL,
  `Duração de uso` VARCHAR(45) NULL,
  `Consulta_idConsulta` INT NOT NULL,
  PRIMARY KEY (`idPrescrição`),
  CONSTRAINT `fk_Prescrição_Consulta1`
    FOREIGN KEY (`Consulta_idConsulta`)
    REFERENCES `mydb`.`Consulta` (`idConsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

