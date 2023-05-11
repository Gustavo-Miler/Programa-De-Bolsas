-- alterando nome de tb_locacao para tb_geral (melhor leitura)

ALTER TABLE tb_locacao 
RENAME TO tb_geral;

-- criando tabela cliente

CREATE TABLE tb_cliente (
	id     INT,
	nome   VARCHAR(15),
	cidade VARCHAR(40),
	estado VARCHAR(40),
	pais   VARCHAR(40)
)

INSERT INTO tb_cliente
SELECT DISTINCT
	idCliente,
	nomeCliente,
	cidadeCliente,
	estadoCliente,
	paisCliente
FROM tb_geral
ORDER BY idCliente

-- criando tabela vendedor

CREATE TABLE tb_vendedor (
	id     INT,
	nome   VARCHAR(15),
	sexo   SMALLINT,
	estado VARCHAR(40)
)

INSERT INTO tb_vendedor
SELECT DISTINCT
	idVendedor,
	nomeVendedor,
	sexoVendedor,
	estadoVendedor
FROM tb_geral
ORDER BY idVendedor

-- criando tabela combustivel

CREATE TABLE tb_combustivel (
	id   INT,
	tipo VARCHAR(20)
)

INSERT INTO tb_combustivel
SELECT DISTINCT
	idcombustivel,
	tipoCombustivel
FROM tb_geral
ORDER BY idcombustivel

-- criando tabela carro

CREATE TABLE tb_carro (
	id            INT,
	kmAtual       INT,
	classi        VARCHAR(50),
	marca         VARCHAR(80),
	modelo        VARCHAR(80),
	ano           INT,
	idCombustivel INT,
	FOREIGN KEY (idCombustivel) REFERENCES tb_combustivel(id)
)

INSERT INTO tb_carro
SELECT DISTINCT
	idCarro,
	max(kmCarro),
	classiCarro,
	marcaCarro,
	modeloCarro,
	anoCarro,
	idcombustivel
FROM tb_geral
GROUP BY idCarro
ORDER BY idCarro

-- criando tabela locacao

CREATE TABLE tb_locacao (
	id          INT,
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
	FOREIGN KEY (idCliente)  REFERENCES tb_cliente(id),
	FOREIGN KEY (idCarro)    REFERENCES tb_carro(id),
	FOREIGN KEY (idVendedor) REFERENCES tb_vendedor(id)
)

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
FROM tb_geral

-- Visualização das tabelas

SELECT * FROM tb_geral;

SELECT * FROM tb_locacao;

SELECT * FROM tb_cliente;

SELECT * FROM tb_vendedor;

SELECT * FROM tb_carro;

SELECT * FROM tb_combustivel;