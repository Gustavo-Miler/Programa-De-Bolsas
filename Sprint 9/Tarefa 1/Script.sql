ALTER TABLE tb_locacao RENAME TO tb_geral

CREATE TABLE tb_cliente AS
SELECT DISTINCT
	idCliente     AS id,
	nomeCliente   AS nome,
	cidadeCliente AS cidade,
	estadoCliente AS estado,
	paisCliente   AS pais
FROM tb_geral
ORDER BY id

CREATE TABLE tb_carro AS
SELECT DISTINCT 
	idCarro       AS id,
	classiCarro   AS classi,
	marcaCarro    AS marca,
	modeloCarro   AS modelo,
	anoCarro      AS ano,
	idcombustivel AS idCombustivel
FROM tb_geral
ORDER BY id

CREATE TABLE tb_combustivel AS
SELECT DISTINCT
	idcombustivel   AS id,
	tipoCombustivel AS tipo
FROM tb_geral 
ORDER BY id

CREATE TABLE tb_vendedor AS
SELECT DISTINCT
	idVendedor     AS id,
	nomeVendedor   AS nome,
	sexoVendedor   AS sexo,
	estadoVendedor AS estado
FROM tb_geral
ORDER BY id

CREATE TABLE tb_locacao AS
SELECT
	idLocacao AS id,
	idCliente,
	idCarro,
	kmCarro   AS km,
	dataLocacao,
	horaLocacao,
	qtdDiaria AS dias,
	vlrDiaria AS valorDiaria,
	dataEntrega,
	horaEntrega,
	idVendedor
FROM tb_geral
ORDER BY id

SELECT * FROM tb_geral;

SELECT * FROM tb_locacao;

SELECT * FROM tb_cliente;

SELECT * FROM tb_carro;

SELECT * FROM tb_combustivel;

SELECT * FROM tb_vendedor;