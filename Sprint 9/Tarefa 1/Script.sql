ALTER TABLE tb_locacao RENAME TO tb_geral;

CREATE TABLE tb_locacao (
	idLocacao   INTEGER PRIMARY KEY,
	idCliente   INT,
	idCarro     INT,
	kmCarro     INT,
	dataLocacao DATE,
	horaLocacao TIME,
	qtdDiaria   INT,
	vlrDiaria   DECIMAL(18,2),
	dataEntrega DATE,
	horaEntrega TIME,
	idVendedor  INT,
	FOREIGN KEY (idCliente)  REFERENCES tb_cliente(idCliente),
	FOREIGN KEY (idCarro)    REFERENCES tb_carro(idCarro),
	FOREIGN KEY (idVendedor) REFERENCES tb_vendedor(idVendedor)
);

INSERT INTO tb_locacao 
SELECT
	idLocacao,
	idCliente,
	idCarro,
	kmCarro,
	SUBSTRING(dataLocacao, 1, 4) || '-' ||
	SUBSTRING(dataLocacao, 5, 2) || '-' || 
	SUBSTRING(dataLocacao, 7, 2),
	horaLocacao,
	qtdDiaria,
	vlrDiaria,
	SUBSTRING(dataEntrega, 1, 4) || '-' ||
	SUBSTRING(dataEntrega, 5, 2) || '-' || 
	SUBSTRING(dataEntrega, 7, 2),
	horaEntrega,
	idVendedor
FROM tb_geral
ORDER BY idLocacao;

CREATE TABLE tb_cliente (
	idCliente     INTEGER PRIMARY KEY,
	nomeCliente   VARCHAR(100),
	cidadeCliente VARCHAR(40),
	FOREIGN KEY (cidadeCliente) REFERENCES tb_cidade(cidade)
);

INSERT INTO tb_cliente 
SELECT DISTINCT
	idCliente,
	nomeCliente,
	cidadeCliente
FROM tb_geral
ORDER BY idCliente;

CREATE TABLE tb_cidade (
	cidade VARCHAR(40) PRIMARY KEY,
	estado VARCHAR(40),
	FOREIGN KEY (estado) REFERENCES tb_estado(estado)
);

INSERT INTO tb_cidade 
SELECT DISTINCT 
	cidadeCliente,
	estadoCliente
FROM tb_geral
ORDER BY cidadeCliente;

CREATE TABLE tb_estado (
	estado VARCHAR(40) PRIMARY KEY,
	pais   VARCHAR(40),
	FOREIGN KEY (pais) REFERENCES tb_pais(pais)
);

INSERT INTO tb_estado
SELECT DISTINCT 
	estadoCliente,
	paisCliente
FROM tb_geral 
ORDER BY estadoCliente;

CREATE TABLE tb_pais (
	pais VARCHAR(40) PRIMARY KEY
);

INSERT INTO tb_pais
SELECT DISTINCT 
	paisCliente
FROM tb_geral 
ORDER BY paisCliente;

CREATE TABLE tb_carro (
	idCarro       INTEGER PRIMARY KEY,
	classiCarro   VARCHAR(50),
	modeloCarro   VARCHAR(80),
	anoCarro      INT,
	idCombustivel INT,
	FOREIGN KEY (modeloCarro)   REFERENCES tb_modelo(modelo),
	FOREIGN KEY (idCombustivel) REFERENCES tb_combustivel(idCombustivel)
);

INSERT INTO tb_carro 
SELECT DISTINCT 
	idCarro,
	classiCarro,
	modeloCarro,
	anoCarro,
	idcombustivel
FROM tb_geral 
ORDER BY idCarro;

CREATE TABLE tb_modelo (
	modelo VARCHAR(80) PRIMARY KEY,
	marca  VARCHAR(80),
	FOREIGN KEY (marca) REFERENCES tb_marca(marca)
);

INSERT INTO tb_modelo 
SELECT DISTINCT
	modeloCarro,
	marcaCarro
FROM tb_geral 
ORDER BY modeloCarro;

CREATE TABLE tb_marca (
	marca VARCHAR(80) PRIMARY KEY
);

INSERT INTO tb_marca
SELECT DISTINCT
	marcaCarro
FROM tb_geral 
ORDER BY marcaCarro;

CREATE TABLE tb_combustivel (
	idCombustivel   INTEGER PRIMARY KEY,
	tipoCombustivel VARCHAR(20)
);

INSERT INTO tb_combustivel 
SELECT DISTINCT 
	idcombustivel,
	tipoCombustivel
FROM tb_geral 
ORDER BY idCombustivel;

CREATE TABLE tb_vendedor (
	idVendedor     INTEGER PRIMARY KEY,
	nomeVendedor   VARCHAR(15),
	sexoVendedor   SMALLINT,
	estadoVendedor VARCHAR(40),
	FOREIGN KEY (estadoVendedor) REFERENCES tb_estado(estado)
);

INSERT INTO tb_vendedor 
SELECT DISTINCT 
	idVendedor,
	nomeVendedor,
	sexoVendedor,
	estadoVendedor
FROM tb_geral 
ORDER BY idVendedor;

DROP TABLE tb_carro;

SELECT * FROM tb_geral;

SELECT * FROM tb_locacao;

SELECT * FROM tb_cliente;

SELECT * FROM tb_cidade;

SELECT * FROM tb_estado;

SELECT * FROM tb_pais;

SELECT * FROM tb_carro;

SELECT * FROM tb_modelo;

SELECT * FROM tb_marca;

SELECT * FROM tb_combustivel;

SELECT * FROM tb_vendedor;