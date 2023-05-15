CREATE VIEW fato_locacao AS
SELECT idLocacao,
	   idCliente,
	   idCarro,
	   idVendedor,
	   dataLocacao,
	   horaLocacao,
	   dataEntrega,
	   horaEntrega,
	   qtdDiaria,
	   vlrDiaria
	FROM tb_locacao;

CREATE VIEW dim_data AS
SELECT DISTINCT 
	   dataLocacao,
	   STRFTIME('%Y', dataLocacao) AS ano,
	   STRFTIME('%m', dataLocacao) AS mes,
	   STRFTIME('%d', dataLocacao) AS dia
	FROM tb_locacao
UNION
SELECT DISTINCT
	   dataEntrega,
	   STRFTIME('%Y', dataEntrega) AS ano,
	   STRFTIME('%m', dataEntrega) AS mes,
	   STRFTIME('%d', dataEntrega) AS dia
	FROM tb_locacao;

CREATE VIEW dim_cliente AS
SELECT tcli.idCliente,
	   tcli.nomeCliente,
	   tcli.cidadeCliente,
	   tcid.estado AS estadoCliente,
	   test.pais AS paisCliente
	FROM tb_cliente tcli 
	JOIN tb_cidade tcid 
	ON tcli.cidadeCliente = tcid.cidade
	join tb_estado test
	ON tcid.estado = test.estado;

CREATE VIEW dim_carro AS
SELECT tcar.idCarro,
	   tcar.classiCarro,
	   tcar.modeloCarro,
	   tmod.marca AS marcaCarro,
	   tcar.anoCarro,
	   tcom.tipoCombustivel
	FROM tb_carro tcar
	JOIN tb_modelo tmod
	ON tcar.modeloCarro = tmod.modelo
	JOIN tb_combustivel tcom
	ON tcar.idCombustivel = tcom.idCombustivel;

CREATE VIEW dim_vendedor AS
SELECT tven.idVendedor,
	   tven.nomeVendedor,
	   tven.sexoVendedor,
	   tven.estadoVendedor,
	   test.pais AS paisVendedor
	FROM tb_vendedor tven
	JOIN tb_estado test
	ON tven.estadoVendedor = test.estado;

SELECT * FROM fato_locacao;

SELECT * FROM dim_data;

SELECT * FROM dim_cliente;

SELECT * FROM dim_carro;

SELECT * FROM dim_vendedor;