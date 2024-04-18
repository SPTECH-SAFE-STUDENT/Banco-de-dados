drop database safe_student;

create database safe_student;

use safe_student;

CREATE TABLE cadastro (
   IdCadastro  INT AUTO_INCREMENT PRIMARY KEY,
   crm CHAR (5) not null,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    email VARCHAR(100),
    celular VARCHAR(20),
    data_nascimento DATE,
    rua VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10)
);

CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    chassi VARCHAR(50),
    ano INT,
    modelo VARCHAR(100),
    marca VARCHAR(100),
    placa VARCHAR(20),
    categoria VARCHAR(50), -- VAN OU ÔNIBUS DECIDIR SE MANTEM OU TIRA.(se decidirem tirar só tirar essa coluna) 
    FK_cadastro INT,
    FOREIGN KEY (FK_cadastro) REFERENCES cadastro(idCadastro)
);

CREATE TABLE Sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(100),
    tipo VARCHAR(50) CHECK (tipo IN ('bloqueio', 'temperatura')),
    fkveiculo INT,
    FOREIGN KEY (fkveiculo) REFERENCES Veiculo(idVeiculo)
);


CREATE TABLE LeituraSensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status INT, CHECK (status IN (0, 1)),
    FK_sensor INT,
    temperatura DECIMAL (5,2),
    FOREIGN KEY (FK_sensor) REFERENCES Sensores(id) 
);


CREATE TABLE Alertas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100), -- tipo ou indicar bloqueio ou temperatura
    descricao TEXT, -- descrever qual o problema exibido no alert
    data_hora DATETIME, -- data e hora do ocorrido
    FK_veiculo INT, -- FK para o veiculo que recebeu o alerta
    FK_sensores INT,
    FOREIGN KEY (FK_veiculo) REFERENCES Veiculo(idVeiculo),
    constraint FK_sensores FOREIGN KEY (FK_sensores) REFERENCES Sensores(id) -- Fiquei confuso nessas foreign Keys se acharem que não faz sentido alguma das duas podem retirar
);


-- Selecionar todos os cadastros
SELECT * FROM cadastro;

-- Selecionar todos os veículos
SELECT * FROM Veiculo;

-- Selecionar todos os alertas
SELECT * FROM Alertas;

-- Selecionar todos os sensores
SELECT * FROM Sensores;

-- Selecionar todas as leituras de temperatura
SELECT * FROM SensorTemperatura;