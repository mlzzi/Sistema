-- Criação do esquema do banco de dados "Oficina"

CREATE DATABASE Oficina;
USE Oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    pNome VARCHAR(45) NOT NULL,
    mNome CHAR(1) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    RG CHAR(9) NOT NULL UNIQUE,
    Telefone VARCHAR(11),
    Endereco VARCHAR(45)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Tipo ENUM('Hatch', 'Sedan', 'PickUp', 'SUV', 'Cupe', 'Outros'),
    Marca VARCHAR(20),
    Modelo VARCHAR(20),
    Placa VARCHAR(7) NOT NULL UNIQUE,
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    NomeEquipe ENUM('Suspensao', 'Eletrica', 'Injecao Eletronica', 'Motor', 'Outros'),
    Membros INT
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    pNome VARCHAR(45) NOT NULL,
    mNome CHAR(1) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    Endereco VARCHAR(45),
    Especialidade ENUM('Motores', 'Freios', 'Transmissao', 'Eletrica', 'Suspensao', 'Pintura', 'Ar-condicionado', 'Diagnostico', 'Carroceria', 'Outros'),
    Equipe_idEquipe INT,
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemDeServico (
    idOrdemDeServico INT AUTO_INCREMENT PRIMARY KEY,
    Data_da_Emissao DATE,
    Valor_Mao_de_Obra DOUBLE,
    Valor_Pecas DOUBLE,
    Status ENUM('Em Andamento', 'Concluído', 'Aguardando Peças', 'Cancelado'),
    Data_Estimada_Entrega DATE,
    Cliente_Autorizou TINYINT,
    Veiculo_idVeiculo INT,
    Equipe_idEquipe INT,
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela Valores Mão de Obra
CREATE TABLE ValoresMaoDeObra (
    idValoresMaoDeObra INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45),
    Descricao VARCHAR(45),
    Valor DOUBLE,
    OrdemDeServico_idOrdemDeServico INT,
    FOREIGN KEY (OrdemDeServico_idOrdemDeServico) REFERENCES OrdemDeServico(idOrdemDeServico)
);

-- Tabela Peça
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45),
    Descricao VARCHAR(45),
    Preco DOUBLE,
    Estoque INT,
    ValoresMaoDeObra_idValoresMaoDeObra INT,
    FOREIGN KEY (ValoresMaoDeObra_idValoresMaoDeObra) REFERENCES ValoresMaoDeObra(idValoresMaoDeObra)
);

-- Descrição das tabelas
DESC Cliente;
DESC Veiculo;
DESC Equipe;
DESC Mecanico;
DESC OrdemDeServico;
DESC ValoresMaoDeObra;
DESC Peca;

-- Inserções de dados

-- Clientes
INSERT INTO Cliente (pNome, mNome, sobrenome, CPF, RG, Telefone, Endereco) VALUES
('João', 'A', 'Silva', '12345678901', '123456789', '11987654321', 'Rua A, 123'),
('Maria', 'B', 'Oliveira', '98765432100', '987654321', '21987654321', 'Rua B, 456'),
('Carlos', 'C', 'Souza', '11122233344', '111333222', '31987654321', 'Rua C, 789'),
('Ana', 'D', 'Costa', '55566677788', '555777666', '41987654321', 'Rua D, 101'),
('Lucas', 'E', 'Lima', '99988877766', '999666888', '51987654321', 'Rua E, 202'),
('Mariana', 'F', 'Santos', '33344455566', '333555444', '61987654321', 'Rua F, 303'),
('Pedro', 'G', 'Alves', '77788899900', '777999888', '71987654321', 'Rua G, 404'),
('Juliana', 'H', 'Pereira', '22233344455', '222444333', '81987654321', 'Rua H, 505'),
('Roberto', 'I', 'Nunes', '88899900011', '888111999', '91987654321', 'Rua I, 606'),
('Fernanda', 'J', 'Ribeiro', '66677788899', '666999777', '10198765432', 'Rua J, 707');

-- Veículos
INSERT INTO Veiculo (Tipo, Marca, Modelo, Placa, Cliente_idCliente) VALUES
('Sedan', 'Toyota', 'Corolla', 'ABC1234', 1),
('Hatch', 'Honda', 'Fit', 'DEF5678', 2),
('PickUp', 'Ford', 'Ranger', 'GHI9012', 3),
('SUV', 'Hyunday', 'Creta', 'JKL3456', 4),
('Cupe', 'Chevrolet', 'Camaro', 'MNO7890', 5),
('Outros', 'Yamaha', 'YZF-R3', 'PQR2345', 6),
('Hatch', 'Volkswagen', 'Golf', 'STU6789', 7),
('Hatch', 'Hyundai', 'HB20', 'VWX1235', 8),
('PickUp', 'Jeep', 'Compass', 'YZA4567', 9),
('SUV', 'Renault', 'Duster', 'BCD8901', 10);

-- Equipes
INSERT INTO Equipe (NomeEquipe, Membros) VALUES
('Suspensao', 5),
('Eletrica', 3),
('Injecao Eletronica', 4),
('Motor', 6),
('Outros', 2),
('Eletrica', 7),
('Motor', 8),
('Suspensao', 3),
('Injecao Eletronica', 5),
('Outros', 4);

-- Mecânicos
INSERT INTO Mecanico (pNome, mNome, sobrenome, Endereco, Especialidade, Equipe_idEquipe) VALUES
('Carlos', 'A', 'Mecânico', 'Rua C, 789', 'Motores', 1),
('Ana', 'B', 'Mecânica', 'Rua D, 101', 'Freios', 2),
('Roberto', 'C', 'Almeida', 'Rua K, 808', 'Transmissao', 3),
('Juliana', 'D', 'Ferreira', 'Rua L, 909', 'Eletrica', 4),
('Fernanda', 'E', 'Silva', 'Rua M, 1001', 'Suspensao', 5),
('Pedro', 'F', 'Lima', 'Rua N, 1102', 'Pintura', 6),
('Lucas', 'G', 'Alves', 'Rua O, 1203', 'Ar-condicionado', 7),
('Mariana', 'H', 'Costa', 'Rua P, 1304', 'Diagnostico', 8),
('João', 'I', 'Santos', 'Rua Q, 1405', 'Carroceria', 9),
('Julio', 'J', 'Cesar', 'Rua R, 1506', 'Freios', 10);

-- Ordens de Serviço
INSERT INTO OrdemDeServico (Data_da_Emissao, Valor_Mao_de_Obra, Valor_Pecas, Status, Data_Estimada_Entrega, Cliente_Autorizou, Veiculo_idVeiculo, Equipe_idEquipe) VALUES
('2025-01-01', 150.00, 200.00, 'Em Andamento', '2025-01-10', 1, 1, 1),
('2025-01-05', 100.00, 50.00, 'Concluído', '2025-01-07', 1, 2, 2),
('2025-01-10', 200.00, 300.00, 'Em Andamento', '2025-01-20', 1, 3, 3),
('2025-01-15', 50.00, 100.00, 'Concluído', '2025-01-18', 1, 4, 4),
('2025-01-20', 120.00, 150.00, 'Aguardando Peças', '2025-01-30', 1, 5, 5),
('2025-01-25', 80.00, 90.00, 'Em Andamento', '2025-02-01', 1, 6, 6),
('2025-02-01', 60.00, 40.00, 'Concluído', '2025-02-05', 1, 7, 7),
('2025-02-10', 110.00, 130.00, 'Cancelado', '2025-02-15', 0, 8, 8),
('2025-02-15', 300.00, 400.00, 'Em Andamento', '2025-03-01', 1, 9, 9),
('2025-03-01', 500.00, 600.00, 'Concluído', '2025-03-10', 1, 10, 10);

-- Valores Mão de Obra
INSERT INTO ValoresMaoDeObra (Nome, Descricao, Valor, OrdemDeServico_idOrdemDeServico) VALUES
('Troca de Óleo', 'Substituição do óleo do motor', 100.00, 1),
('Alinhamento', 'Alinhamento de rodas', 80.00, 2),
('Troca de Filtros', 'Substituição de todos os filtros', 150.00, 3),
('Revisão Completa', 'Inspeção geral do veículo', 300.00, 4),
('Pintura', 'Retoque na pintura', 250.00, 5),
('Troca de Pastilhas', 'Substituição de pastilhas de freio', 120.00, 6),
('Balanceamento', 'Balanceamento das rodas', 70.00, 7),
('Troca de Correia', 'Substituição da correia dentada', 200.00, 8),
('Reparo Elétrico', 'Conserto do sistema elétrico', 180.00, 9),
('Diagnóstico', 'Análise de falhas', 90.00, 10);

-- Peças
INSERT INTO Peca (Nome, Descricao, Preco, Estoque, ValoresMaoDeObra_idValoresMaoDeObra) VALUES
('Filtro de Óleo', 'Filtro para motor', 30.00, 20, 1),
('Pneu', 'Pneu aro 16', 200.00, 10, 2),
('Velas de Ignição', 'Velas para motor', 50.00, 30, 3),
('Farol', 'Farol dianteiro', 300.00, 5, 4),
('Para-choque', 'Para-choque traseiro', 400.00, 8, 5),
('Amortecedor', 'Amortecedor traseiro', 150.00, 12, 6),
('Filtro de Ar', 'Filtro para sistema de ar', 40.00, 25, 7),
('Bateria', 'Bateria 12V', 500.00, 7, 8),
('Radiador', 'Radiador de alumínio', 600.00, 3, 9),
('Escapamento', 'Sistema de escapamento', 700.00, 4, 10);


-- Consultas

-- Consultas SELECT * FROM para cada tabela
SELECT * FROM Cliente;
SELECT * FROM Veiculo;
SELECT * FROM Equipe;
SELECT * FROM Mecanico;
SELECT * FROM OrdemDeServico;
SELECT * FROM ValoresMaoDeObra;
SELECT * FROM Peca;

-- 1. Recuperações simples com SELECT Statement:
SELECT * FROM Cliente;

-- 2. Filtros com WHERE Statement:
SELECT * FROM Veiculo WHERE Tipo = 'SUV';

-- 3. Crie expressões para gerar atributos derivados:
SELECT pNome, sobrenome, 
       CONCAT(pNome, ' ', mNome, '. ', sobrenome) AS NomeCompleto 
FROM Cliente;

-- 4. Defina ordenações dos dados com ORDER BY:
SELECT * FROM Mecanico ORDER BY sobrenome ASC;

-- 5. Condições de filtros aos grupos – HAVING Statement:
SELECT Especialidade, COUNT(*) AS Qtde_Mecanicos 
FROM Mecanico 
GROUP BY Especialidade 
HAVING COUNT(*) > 1;

-- 6. Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados:
SELECT Cliente.pNome, Cliente.sobrenome, Veiculo.Marca, Veiculo.Modelo 
FROM Cliente
JOIN Veiculo ON Cliente.idCliente = Veiculo.Cliente_idCliente;

-- 7. Recuperação de informações com filtro e ordenação:
SELECT * FROM OrdemDeServico 
WHERE Status = 'Concluído' 
ORDER BY Data_da_Emissao DESC;

-- 8. Gerar atributo derivado com cálculos:
SELECT idOrdemDeServico, 
       Valor_Mao_de_Obra + Valor_Pecas AS Valor_Total 
FROM OrdemDeServico;

-- 9. Junção entre múltiplas tabelas para consolidar informações:
SELECT OrdemDeServico.idOrdemDeServico, Cliente.pNome, Cliente.sobrenome, 
       Veiculo.Marca, Veiculo.Modelo, OrdemDeServico.Status 
FROM OrdemDeServico
JOIN Cliente ON OrdemDeServico.Veiculo_idVeiculo = Cliente.idCliente
JOIN Veiculo ON OrdemDeServico.Veiculo_idVeiculo = Veiculo.idVeiculo;

-- 10. Filtro avançado com junção e expressões:
SELECT Mecanico.pNome, Mecanico.sobrenome, Equipe.NomeEquipe 
FROM Mecanico
JOIN Equipe ON Mecanico.Equipe_idEquipe = Equipe.idEquipe 
WHERE Equipe.NomeEquipe;

-- 11. Recuperar clientes com veículos do tipo "Hatch" e ordens de serviço em andamento:
SELECT Cliente.pNome, Cliente.sobrenome, Veiculo.Marca, Veiculo.Modelo, OrdemDeServico.Status
FROM Cliente
JOIN Veiculo ON Cliente.idCliente = Veiculo.Cliente_idCliente
JOIN OrdemDeServico ON Veiculo.idVeiculo = OrdemDeServico.Veiculo_idVeiculo
WHERE Veiculo.Tipo = 'Hatch' AND OrdemDeServico.Status = 'Em Andamento';

-- 12. Calcular o total gasto por cada cliente em ordens de serviço concluídas:
SELECT Cliente.pNome, Cliente.sobrenome, SUM(OrdemDeServico.Valor_Mao_de_Obra + OrdemDeServico.Valor_Pecas) AS TotalGasto
FROM Cliente
JOIN Veiculo ON Cliente.idCliente = Veiculo.Cliente_idCliente
JOIN OrdemDeServico ON Veiculo.idVeiculo = OrdemDeServico.Veiculo_idVeiculo
WHERE OrdemDeServico.Status = 'Concluído'
GROUP BY Cliente.idCliente;

-- 13. Listar mecânicos e o número de ordens de serviço em que trabalharam:
SELECT Mecanico.pNome, Mecanico.sobrenome, COUNT(OrdemDeServico.idOrdemDeServico) AS Qtde_Ordens
FROM Mecanico
JOIN Equipe ON Mecanico.Equipe_idEquipe = Equipe.idEquipe
JOIN OrdemDeServico ON Equipe.idEquipe = OrdemDeServico.Equipe_idEquipe
GROUP BY Mecanico.idMecanico;

-- 14. Consultar a peça mais cara e o serviço de mão de obra relacionado:
SELECT Peca.Nome AS PecaNome, Peca.Preco, ValoresMaoDeObra.Nome AS ServicoNome, ValoresMaoDeObra.Valor
FROM Peca
JOIN ValoresMaoDeObra ON Peca.ValoresMaoDeObra_idValoresMaoDeObra = ValoresMaoDeObra.idValoresMaoDeObra
ORDER BY Peca.Preco DESC
LIMIT 1;

-- 15. Recuperar ordens de serviço onde o cliente autorizou o trabalho e o custo total:
SELECT OrdemDeServico.idOrdemDeServico, Cliente.pNome, Cliente.sobrenome, (OrdemDeServico.Valor_Mao_de_Obra + OrdemDeServico.Valor_Pecas) AS CustoTotal
FROM OrdemDeServico
JOIN Cliente ON OrdemDeServico.Veiculo_idVeiculo = Cliente.idCliente
WHERE OrdemDeServico.Cliente_Autorizou = 1;
