drop database safe_student;

create database safe_student;

use safe_student;

CREATE TABLE cadastro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    email VARCHAR(100),
    celular VARCHAR(20),
    telefone VARCHAR(20),
    data_nascimento DATE,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10)
);

CREATE TABLE Veiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chassi VARCHAR(50),
    ano INT,
    modelo VARCHAR(100),
    marca VARCHAR(100),
    placa VARCHAR(20),
    categoria VARCHAR(50), -- VAN OU ÔNIBUS DECIDIR SE MANTEM OU TIRA.(se decidirem tirar só tirar essa coluna) 
    FK_cadastro INT,
    FOREIGN KEY (FK_cadastro) REFERENCES cadastro(id)
);

CREATE TABLE Produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10, 2),
    FK_cadastro INT,
    FOREIGN KEY (FK_cadastro) REFERENCES cadastro(id)
);

CREATE TABLE Sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(100),
    tipo VARCHAR(50) CHECK (tipo IN ('bloqueio', 'temperatura')),
    FK_Produto INT,
    FOREIGN KEY (FK_Produto) REFERENCES Produto(id)
);

CREATE TABLE SensorBloqueio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(20), CHECK (status IN ('Ausente', 'Ocupado')),
    FK_sensor INT,
    FOREIGN KEY (FK_sensor) REFERENCES Sensores(id)
);

CREATE TABLE SensorTemperatura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    temperatura DECIMAL(5,2), -- Temperatura registrada pelo sensor
    FK_sensor INT,
    FOREIGN KEY (FK_sensor) REFERENCES Sensores(id)
);

CREATE TABLE Alertas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100), -- tipo ou indicar bloqueio ou temperatura
    descricao TEXT, -- descrever qual o problema exibido no alert
    data_hora DATETIME, -- data e hora do ocorrido
    FK_veiculo INT, -- FK para o veiculo que recebeu o alerta
    FK_sensores INT,
    FOREIGN KEY (FK_veiculo) REFERENCES Veiculo(id),
    constraint FK_sensores FOREIGN KEY (FK_sensores) REFERENCES Sensores(id) -- Fiquei confuso nessas foreign Keys se acharem que não faz sentido alguma das duas podem retirar
);

-- Inserts para a tabela cadastro
INSERT INTO cadastro (nome, cpf, email, celular, telefone, data_nascimento, endereco, cidade, estado, cep)
VALUES 
    ('João da Silva', '123.456.789-00', 'joao@example.com', '(99) 99999-9999', '(99) 8888-8888', '1990-05-15', 'Rua A, 123', 'São Paulo', 'SP', '12345-678'),
    ('Maria Souza', '987.654.321-00', 'maria@example.com', '(88) 88888-8888', '(88) 7777-7777', '1995-10-20', 'Av. B, 456', 'Rio de Janeiro', 'RJ', '54321-987'),
    ('Pedro Oliveira', '456.789.123-00', 'pedro@example.com', '(77) 77777-7777', '(77) 6666-6666', '1988-07-12', 'Rua C, 789', 'Salvador', 'BA', '98765-432');

-- Inserts para a tabela Veiculo
INSERT INTO Veiculo (chassi, ano, modelo, marca, placa, categoria, FK_cadastro)
VALUES 
    ('12345678901234567', 2020, 'Sprinter', 'Mercedes-Benz', 'ABC-1234', 'Van', 1),
    ('98765432109876543', 2018, 'Master', 'Renault', 'DEF-5678', 'Van', 2),
    ('65432109876543210', 2021, 'Daily', 'Iveco', 'GHI-9012', 'Van', 3),
    ('12309876543210987', 2019, 'City', 'Volks', 'JKL-3456', 'Ônibus', 1);

-- Inserts para a tabela Produto
INSERT INTO Produto (nome, descricao, preco, FK_cadastro)
VALUES 
    ('SensorBancoCentral', 'Sensor de bloqueio localizado no banco central da Van.', 150.00, 1),
    ('SensorTemperaturaFundo', 'Sensor de temperatura Localizado no fundo da Van.', 80.00, 1),
    ('SensorBancoTraseiro', 'Sensor de bloqueio localizado no banco traseiro da Van.', 250.00, 2);

-- Inserts para a tabela Sensores
INSERT INTO Sensores (nome, localizacao, tipo, FK_Produto)
VALUES 
    ('Sensor de Temperatura', 'Interior da van', 'temperatura', 2),
    ('Sensor de Bloqueio', 'banco traseiro', 'bloqueio', 3),
    ('Sensor de Bloqueio ', 'banco central', 'bloqueio', 1);
   
-- inserts para a tabela SensorBloqueio
INSERT INTO SensorBloqueio (status, FK_sensor)
VALUES ('Ocupado', 2),
       ('Ausente', 3);


-- Inserts para a tabela SensorTemperatura
INSERT INTO SensorTemperatura (temperatura, FK_sensor)
VALUES (25.5, 1);

-- Inserts para a tabela Alertas
INSERT INTO Alertas (tipo, descricao, data_hora, FK_veiculo, FK_sensores)
VALUES 
    ('Temperatura Alta', 'Temperatura interna da van está acima do normal.', '2024-04-02 10:30:00', 1 , 1),
    ('Criança Esquecida', 'Uma criança foi esquecida dentro da van.', '2024-04-01 14:00:00', 2 , 2 ),
    ('Temperatura Alta', 'Temperatura interna da van está acima do normal.', '2024-04-02 11:45:00', 3, 1),
    ('Criança Esquecida', 'Uma criança foi esquecida dentro da van.', '2024-04-02 15:30:00', 1 , 3 );

-- Selecionar todos os cadastros
SELECT * FROM cadastro;

-- Selecionar todos os veículos
SELECT * FROM Veiculo;

-- Selecionar todos os alertas
SELECT * FROM Alertas;

-- Selecionar todos os produtos
SELECT * FROM Produto;

-- Selecionar todos os sensores
SELECT * FROM Sensores;

-- Selecionar todas as leituras de temperatura
SELECT * FROM SensorTemperatura;
