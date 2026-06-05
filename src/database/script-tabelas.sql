CREATE DATABASE VaccinTech;
USE VaccinTech;


CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100),
    cnpj CHAR(14) UNIQUE,
    telefone VARCHAR(15)
);


CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(100),
    email VARCHAR(80) UNIQUE,
    senha VARCHAR(50),
    perfil VARCHAR(20),
    cpf CHAR(11) UNIQUE,
    dtCadastro datetime default current_timestamp,
    fkEmpresa INT not null,
    CONSTRAINT chkPerfil CHECK (perfil IN ('Admin', 'Gerente', 'Operário')),
    CONSTRAINT fkUserEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);



CREATE TABLE transporte (
    idTransporte INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) UNIQUE not null,
    modelo VARCHAR(50) not null,
    tipoRefrigeramento VARCHAR(50),
    fkEmpresa INT not null,
    CONSTRAINT fkTranspEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE vacina (
    idVacina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    fabricante VARCHAR(100),
    lote VARCHAR(50),
    dtValidade date not null,
    dtFabricacao date not null,
    temperaturaMin DECIMAL(4,2) DEFAULT 2.00, 
    temperaturaMax DECIMAL(4,2) DEFAULT 8.00,
    dtCadastro datetime default current_timestamp
);

create table viagem (
idViagem int auto_increment,
fkVacina int not null,
fkTransporte int not null,
dataViagem datetime default current_timestamp,
origem varchar(45),
destino varchar(45),
qtdVacina int,
statusViagem VARCHAR(30) DEFAULT 'Trânsito',
constraint pkViagem primary key (idViagem, fkVacina, fkTransporte),
constraint fkVacinaViagem foreign key (fkVacina) 
	references vacina(idVacina),
constraint fkTransporteViagem foreign key (fkTransporte)
	references transporte(idTransporte),
    CONSTRAINT chkStatus CHECK (statusViagem IN ('Trânsito', 'Concluída', 'Cancelada'))
); 



CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(50) DEFAULT 'LM35',
    dataInstalacao DATE,
    fkTransporte INT UNIQUE not null,
    CONSTRAINT fkSensorTransp FOREIGN KEY (fkTransporte) REFERENCES Transporte(idTransporte)
);

CREATE TABLE monitoramento (
    idMonitoramento INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(5,2),
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT NOT NULL,
    CONSTRAINT fkDadoSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);


CREATE TABLE alerta (
    idAlerta INT,
    fkMonitoramento INT NOT NULL UNIQUE,
    tipoAlerta VARCHAR(50),
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    constraint pkAlerta primary key (idAlerta, fkMonitoramento),
    CONSTRAINT fkAlertaMonitor FOREIGN KEY (fkMonitoramento) 
        REFERENCES Monitoramento(idMonitoramento)
);

INSERT INTO empresa (razaoSocial, cnpj, telefone) VALUES
('BioVac Transportes Farmacêuticos LTDA', '12345678000101', '1134567890'),
('ImunoLog Logística de Vacinas S.A.', '23456789000102', '1145678901'),
('ColdChain Saúde LTDA', '34567890000103', '1156789012'),
('VacinaSeg Transporte Especializado LTDA', '45678901000104', '1167890123'),
('PharmaFrio Distribuição de Imunobiológicos LTDA', '56789012000105', '1178901234');

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
    
    
select * from usuario;