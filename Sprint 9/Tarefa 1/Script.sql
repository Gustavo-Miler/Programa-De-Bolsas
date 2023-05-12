-- alterando nome de tb_locacao para tb_geral (melhor leitura)

ALTER TABLE tb_locacao 
RENAME TO tb_geral;

-- criação de tabelas

CREATE TABLE tb_carro (
	id            INT PRIMARY KEY,
	classi        VARCHAR(20),
	idModelo      INT,
	ano           INT,
	idCombustivel INT,
	FOREIGN KEY (idModelo) REFERENCES tb_modelo(id),
	FOREIGN KEY (idCombustivel) REFERENCES tb_combustivel(id)
);

CREATE TABLE tb_modelo (
	id      INTEGER PRIMARY KEY AUTOINCREMENT,
	modelo  VARCHAR(20),
	idMarca INT,
	FOREIGN KEY (idMarca) REFERENCES tb_marca(id)
);

CREATE TABLE tb_marca(
	id    INTEGER PRIMARY KEY AUTOINCREMENT,
	marca VARCHAR(20)
);

CREATE TABLE tb_combustivel (
	id   INT PRIMARY KEY,
	tipo VARCHAR(20)
);

CREATE TABLE tb_cliente (
	id       INT PRIMARY KEY,
	nome     VARCHAR(80),
	idCidade INT,
	FOREIGN KEY (idCidade) REFERENCES tb_cidade(id)
);

CREATE TABLE tb_vendedor (
	id       INT PRIMARY KEY,
	nome     VARCHAR(80),
	sexo     SMALLINT,
	idEstado INT,
	FOREIGN KEY (idEstado) REFERENCES tb_estado(id)
);

CREATE TABLE tb_cidade (
	id       INTEGER PRIMARY KEY AUTOINCREMENT,
	cidade   VARCHAR(40),
	idEstado INT,
	FOREIGN KEY (idEstado) REFERENCES tb_estado(id)
);

CREATE TABLE tb_estado (
	id     INTEGER PRIMARY KEY AUTOINCREMENT,
	estado VARCHAR(80),
	idPais INT,
	FOREIGN KEY (idPais) REFERENCES tb_pais(id)
);

CREATE TABLE tb_pais (
	id   INTEGER PRIMARY KEY AUTOINCREMENT,
	pais VARCHAR(80)
);

CREATE TABLE tb_locacao (
	id INT PRIMARY KEY,
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
	FOREIGN KEY (idCliente) REFERENCES tb_cliente(id),
	FOREIGN KEY (idCarro) REFERENCES tb_carro(id),
	FOREIGN KEY (idVendedor) REFERENCES tb_vendedor(id)
);

-- inserção de dados nas tabelas

INSERT INTO tb_locacao
SELECT
	idLocacao,
	idCliente,
	idCarro,
	kmCarro,
	dataLocacao,
	horaLocacao,
	qtdDiaria,
	vlrDiaria,
	dataEntrega,
	horaEntrega,
	idVendedor
FROM tb_geral;

INSERT INTO tb_pais (pais)
SELECT DISTINCT
	paisCliente
FROM tb_geral 
ORDER BY paisCliente;

INSERT INTO tb_estado (estado, idPais)
SELECT DISTINCT
	tg.estadoCliente,
	tp.id
FROM tb_geral tg JOIN tb_pais tp ON tg.paisCliente = tp.pais;

INSERT INTO tb_cidade (cidade, idEstado)
SELECT DISTINCT
	tg.cidadeCliente,
	te.id
FROM tb_geral tg JOIN tb_estado te ON tg.estadoCliente = te.estado;

INSERT INTO tb_cliente
SELECT DISTINCT
	tg.idCliente,
	tg.nomeCliente,
	tc.id
FROM tb_geral tg JOIN tb_cidade tc ON tg.cidadeCliente = tc.cidade
ORDER BY tg.idCliente;

INSERT INTO tb_vendedor
SELECT DISTINCT
	tg.idVendedor,
	tg.nomeVendedor,
	tg.sexoVendedor,
	te.id
FROM tb_geral tg JOIN tb_estado te ON tg.estadoVendedor = te.estado;

INSERT INTO tb_marca (marca)
SELECT DISTINCT
	marcaCarro
FROM tb_geral;

INSERT INTO tb_modelo (modelo, idMarca)
SELECT DISTINCT
	tg.modeloCarro,
	tm.id
FROM tb_geral tg JOIN tb_marca tm ON tg.marcaCarro = tm.marca
ORDER BY tm.id;

INSERT INTO tb_combustivel
SELECT DISTINCT
	idcombustivel,
	tipoCombustivel
FROM tb_geral;

INSERT INTO tb_carro 
SELECT DISTINCT
	tg.idCarro,
	tg.classiCarro,
	tm.id,
	tg.anoCarro,
	tg.idcombustivel
FROM tb_geral tg JOIN tb_modelo tm ON tg.modeloCarro = tm.modelo
ORDER BY tg.idCarro;

-- visualização das tabelas

SELECT * FROM tb_geral;

SELECT * FROM tb_locacao;

SELECT * FROM tb_cliente;

SELECT * FROM tb_vendedor;

SELECT * FROM tb_pais;

SELECT * FROM tb_estado;

SELECT * FROM tb_cidade;

SELECT * FROM tb_marca;

SELECT * FROM tb_modelo;

SELECT * FROM tb_combustivel;

SELECT * FROM tb_carro;