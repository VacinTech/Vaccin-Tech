CREATE DATABASE VaccinTech;
USE VaccinTech;



CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100),
    cnpj CHAR(14) UNIQUE,
    telefone VARCHAR(15)
);


CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(100),
    email VARCHAR(80) UNIQUE,
    senha VARCHAR(50),
    perfil VARCHAR(20),
    dtCadastro datetime default current_timestamp,
    fkEmpresa INT not null,
    CONSTRAINT chkPerfil CHECK (perfil IN ('Admin', 'Gerente', 'Operário')),
    CONSTRAINT fkUserEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

select * from Usuario;





CREATE TABLE Transporte (
    idTransporte INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) UNIQUE not null,
    modelo VARCHAR(50) not null,
    tipoRefrigeramento VARCHAR(50),
    fkEmpresa INT not null,
    CONSTRAINT fkTranspEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Vacina (
    idVacina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    fabricante VARCHAR(100),
    lote VARCHAR(50),
    temperaturaMin DECIMAL(4,2) DEFAULT 2.00, 
    temperaturaMax DECIMAL(4,2) DEFAULT 8.00
);

create table Viagem (
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
	references Vacina(idVacina),
constraint fkTransporteViagem foreign key (fkTransporte)
	references Transporte(idTransporte),
    CONSTRAINT chkStatus CHECK (statusViagem IN ('Trânsito', 'Concluída', 'Cancelada'))
);


CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(50) DEFAULT 'LM35',
    dataInstalacao DATE,
    fkTransporte INT UNIQUE not null,
    CONSTRAINT fkSensorTransp FOREIGN KEY (fkTransporte) REFERENCES Transporte(idTransporte)
);

create table Monitoramento (
    idMonitoramento int primary key auto_increment,
    temperatura decimal(5,2),
    dataHora datetime default current_timestamp,
    fkSensor int not null,
    constraint fkSensorCon
        foreign key (fkSensor)
        references Sensor(idSensor)
);

select DATE_FORMAT(dataHora,'%H:%i:%s') from Monitoramento where idMonitoramento = 1;
select dataHora from monitoramento where idMonitoramento = 1;


SELECT 
                        temperatura,
                        dataHora,
                        date_format(dataHora,'%H:%i:%s') as hora
                    FROM Monitoramento
                    WHERE fkSensor = 2
                    ORDER BY idMonitoramento DESC LIMIT 2;
                    
CREATE TABLE Alerta (
    idAlerta INT,
    fkMonitoramento INT NOT NULL UNIQUE,
    tipoAlerta VARCHAR(50),
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    constraint pkAlerta primary key (idAlerta, fkMonitoramento),
    CONSTRAINT fkAlertaMonitor FOREIGN KEY (fkMonitoramento) 
        REFERENCES Monitoramento(idMonitoramento)
);

insert into Empresa (razaoSocial, cnpj, telefone) values
('Pfizer Brasil Ltda', '12345678000101', '1130011001'),
('BioNTech Logistica S.A.', '12345678000102', '1130011002'),
('Vacina Express Transportes', '12345678000103', '1130011003'),
('HealthCargo Distribuicao', '12345678000104', '1130011004'),
('ImunoTech Solutions', '12345678000105', '1130011005');

insert into Usuario values
(default, 'Tito', 'tito@gmail.com', '12345678', 'Admin', '12212212212', 1);


    
    

create view vwGeralRotas as 
	select
    s.idSensor,
    tr.fkEmpresa,
    vi.idViagem, vi.origem, vi.destino,
	tr.placa,
    v.temperaturaMin,
    v.temperaturaMax,
	(
    select m.temperatura 
	from Monitoramento m 
    join Sensor s on m.fkSensor = s.idSensor
    where s.fkTransporte = tr.idTransporte
	order by m.idMonitoramento desc
	limit 1
    ) as temperaturaAtual
		from Viagem vi
        join Transporte tr on vi.fkTransporte = tr.idTransporte
        join Vacina v on vi.fkVacina = v.idVacina
        join Sensor s on s.fkTransporte = tr.idTransporte
        where vi.statusViagem = 'Trânsito';
            


select * from vwGeralRotas
	 where fkEmpresa = 1; -- aqui coloca ${idEmpresa};
     

create view vwTudoDashIndividual as
	select 
		vi.idViagem, vi.origem, vi.destino,
		tr.placa,
		v.temperaturaMin,
		v.temperaturaMax,
		ss.minAtingido,
		ss.maxAtingido,
		(
			select m.temperatura 
			from Monitoramento m 
			join Sensor s on m.fkSensor = s.idSensor
			where s.fkTransporte = tr.idTransporte
			order by m.idMonitoramento desc
			limit 1
		) as temperaturaAtual
			from Viagem vi
			join Transporte tr on vi.fkTransporte = tr.idTransporte
			join Vacina v on vi.fkVacina = v.idVacina
            left join (
            select 
				s.fkTransporte,
                min(m.temperatura) as minAtingido,
                max(m.temperatura) as maxAtingido
                from Sensor s 
                join Monitoramento m on m.fkSensor = s.idSensor
                group by s.fkTransporte
            ) as ss on ss.fkTransporte = tr.idTransporte
			where vi.statusViagem = 'Trânsito';

select * from vwTudoDashIndividual
	 where idViagem = 1; -- aqui coloca ${idEmpresa};


select temperatura	
	from Monitoramento where fkSensor = 1;
    
-- VACINAS
INSERT INTO Vacina (nome, fabricante, lote) VALUES
('Comirnaty', 'Pfizer', 'PF2026001'),
('Spikevax', 'Moderna', 'MD2026001'),
('Vaxzevria', 'AstraZeneca', 'AZ2026001'),
('CoronaVac', 'Sinovac', 'SV2026001');

-- TRANSPORTES DA EMPRESA 1
INSERT INTO Transporte
(placa, modelo, tipoRefrigeramento, fkEmpresa)
VALUES
('ABC1A11', 'Mercedes Accelo', 'Baú Refrigerado', 1),
('DEF2B22', 'Volkswagen Delivery', 'Baú Refrigerado', 1),
('GHI3C33', 'Iveco Daily', 'Baú Refrigerado', 1),
('JKL4D44', 'Mercedes Sprinter', 'Baú Refrigerado', 1);

-- SENSORES (1 SENSOR POR TRANSPORTE)
INSERT INTO Sensor
(modelo, dataInstalacao, fkTransporte)
VALUES
('LM35', '2026-05-01', 1),
('LM35', '2026-05-02', 2),
('LM35', '2026-05-03', 3),
('LM35', '2026-05-04', 4);

-- VIAGENS EM TRÂNSITO
INSERT INTO Viagem
(
    fkVacina,
    fkTransporte,
    origem,
    destino,
    qtdVacina,
    statusViagem
)
VALUES
(1, 1, 'São Paulo', 'Rio de Janeiro', 5000, 'Trânsito'),
(2, 2, 'Campinas', 'Belo Horizonte', 3200, 'Trânsito'),
(3, 3, 'Curitiba', 'Florianópolis', 4100, 'Trânsito'),
(4, 4, 'São Paulo', 'Brasília', 2800, 'Trânsito');


-- HISTÓRICO DE MONITORAMENTO
INSERT INTO Monitoramento (temperatura, fkSensor) VALUES
(5.1, 1),
(5.3, 1),
(5.4, 1),
(6.0, 2),
(6.1, 2),
(6.2, 2),
(4.6, 3),
(4.7, 3),
(4.8, 3),
(6.8, 4),
(6.9, 4),
(7.1, 4);

insert into Monitoramento (temperatura, fkSensor) values
(8.1, 1);

insert into Monitoramento (temperatura, fkSensor) values
(8.0, 4);

insert into Monitoramento (temperatura, fkSensor) values
(4.5, 3);
insert into Monitoramento (temperatura, fkSensor) values
(4.6, 3);


-- ALERTAS DE EXEMPLO
INSERT INTO Alerta
(idAlerta, fkMonitoramento, tipoAlerta)
VALUES
(1, 3, 'Temperatura Alta'),
(2, 6, 'Temperatura Alta');

select * from Usuario;
select * from Viagem;
select * from Monitoramento;
insert into Monitoramento (temperatura, fkSensor) values
(8.0, 1);

 SELECT idUsuario, nomeCompleto, email, perfil, fkEmpresa FROM usuario WHERE email = 'tito@gmail.com' AND senha = '12345678';
