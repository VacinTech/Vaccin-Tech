CREATE DATABASE VaccinTech;
USE VaccinTech;


CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100),
    cnpj CHAR(14) UNIQUE,
    telefone VARCHAR(15)
);


CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT auto_increment,
    nomeCompleto VARCHAR(100),
    email VARCHAR(80) UNIQUE,
    senha VARCHAR(50),
    perfil VARCHAR(20),
    cpf CHAR(11) UNIQUE,
    fkEmpresa INT,
    CONSTRAINT chkPerfil CHECK (perfil IN ('Admin', 'Gerente', 'Operário')),
    CONSTRAINT fkUserEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);



CREATE TABLE Transporte (
    idTransporte INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) UNIQUE,
    modelo VARCHAR(50),
    tipoRefrigeramento VARCHAR(50),
    statusViagem VARCHAR(30) DEFAULT 'Trânsito',
    fkEmpresa INT,
    CONSTRAINT chkStatus CHECK (statusViagem IN ('Trânsito', 'Concluída', 'Cancelada')),
    CONSTRAINT fkTranspEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Vacina (
    idVacina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    fabricante VARCHAR(100),
    lote VARCHAR(50),
    temperaturaMin DECIMAL(4,2) DEFAULT 2.00, 
    temperaturaMax DECIMAL(4,2) DEFAULT 8.00,
    fkTransporte INT,
    CONSTRAINT fkVacinaTransp FOREIGN KEY (fkTransporte) REFERENCES Transporte(idTransporte)
);


CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(50) DEFAULT 'LM35',
    dataInstalacao DATE,
    fkTransporte INT UNIQUE,
    CONSTRAINT fkSensorTransp FOREIGN KEY (fkTransporte) REFERENCES Transporte(idTransporte)
);

CREATE TABLE Monitoramento (
    idMonitoramento INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(5,2),
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT NOT NULL,
    CONSTRAINT fkDadoSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);


CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY,
    fkMonitoramento INT NOT NULL UNIQUE,
    tipoAlerta VARCHAR(50),
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    confirmacaoLeitura BOOLEAN DEFAULT FALSE,
    CONSTRAINT fkAlertaMonitor FOREIGN KEY (fkMonitoramento) 
        REFERENCES Monitoramento(idMonitoramento)
);

-- select da ultima temperatura
-- É o mesmo para a KPI de faixa atual
select temperatura 
	from monitoramento
    where fkSensor = '${fkSensor}'
    order by idMonitoramento desc;
    
-- view de min e max
create view vwMinEMaxSensor as
select fkSensor, min(temperatura) as tempMin, max(temperatura) as tempMax
	from monitoramento
		group by fkSensor;
    
select * from vwMinEMaxSensor 
	where fkSensor = '${fkSensor}';


-- VIEW que traz tudo 
create view vwMonitoramentoCompleto as
select
    e.razaoSocial,
    t.placa,
    s.idSensor,
    m.temperatura,
    m.dataHora
from Monitoramento m
join Sensor s on m.fkSensor = s.idSensor
join Transporte t on s.fkTransporte = t.idTransporte
join Empresa e on t.fkEmpresa = e.idEmpresa;

-- Tem que usar a VIEW assim para puxar o relatorio completo de apenas um sensor
select * 
	from vwMonitoramentoCompleto
	where idSensor = '${idSensor}';
    
    
