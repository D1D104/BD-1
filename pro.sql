DROP DATABASE IF EXISTS `mydb`;
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
    
-- Inserindo Valores
insert into hospital values(default, 'Delfim Moreira','Rua Antonio Fagundes','3471-2878');
insert into médico values(default,'Fernando','Cardiologista', '10:00 - 15:00');
insert into paciente values(1234, 'Jorge', 68, 'M');
insert into trabalha values(1,1);
insert into consulta values(default, '19/05/24', 'Muita tosse', 'Baixa pressão', 1,1234);
insert into prescrição values(default, 'Novalgina','2-8hrs','15 dias',1);

insert into hospital values(default, 'Madre Teresa','Rua Gonçalves Mendonça','3471-9811');
insert into médico values(default,'Tulio','Ortopedista', '11:00 - 18:00');
insert into paciente values(666678, 'José',70, 'M');
insert into trabalha values(2,2);
insert into consulta values(default, '19/05/24', 'Muita tosse', 'Baixa pressão', 1,1234);
insert into prescrição values(default, 'Novalgina','2-8hrs','15 dias',1);

-- CRUD

-- Create
INSERT INTO Paciente (CPF, Nome, Idade, Gênero) VALUES (123456789, 'João Silva', 30, 'Masculino');

-- Read
SELECT * FROM Paciente WHERE CPF = 123456789;

-- Update
UPDATE Paciente SET Nome = 'João Pedro Silva', Idade = 31 WHERE CPF = 123456789;

-- Delete
DELETE FROM Paciente WHERE CPF = 123456789;

DELIMITER //
CREATE PROCEDURE AddConsulta(
    IN p_DataConsulta VARCHAR(45),
    IN p_DiagnosticoBasico VARCHAR(45),
    IN p_Observacoes VARCHAR(45),
    IN p_MedicoId INT,
    IN p_PacienteCPF INT
)
BEGIN
    INSERT INTO Consulta (`Data consulta`, `Diagnóstico básico`, `Observações`, Médico_idMédico, Paciente_CPF)
    VALUES (p_DataConsulta, p_DiagnosticoBasico, p_Observacoes, p_MedicoId, p_PacienteCPF);
END //

DELIMITER ;

CALL AddConsulta('2023-06-22', 'Hipertensão', 'Paciente deve evitar sal', 1, 123456789);
select * from consulta;
