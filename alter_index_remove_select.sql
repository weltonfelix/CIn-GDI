-- Adiciona coluna descrição
ALTER TABLE Plano ADD descricao VARCHAR2(255);

ALTER TABLE Plano DROP COLUMN descricao;
-- Cria índices
CREATE INDEX idx_conteudo_duracao ON
Conteudo(duracao_minutos);

CREATE INDEX idx_perfil_data_criacao ON
Perfil(data_criacao);

CREATE INDEX idx_avaliacao_qualidade ON
Avaliacao(qualidade);
-- Insere e remove tuplas
INSERT
	INTO
	Plano (id_plano,
	nome,
	preco,
	tempo_fidelidade_meses)
VALUES (999,
'Plano Teste',
29.99,
6);

DELETE
FROM
	Plano
WHERE
	id_plano = 999;
-- Atualiza estrutura da tabela
UPDATE
	Plano
SET
	preco = 19.99
WHERE
	id_plano = 1;

UPDATE
	Plano
SET
	preco = 25.99
WHERE
	id_plano = 1;
---
-- 1. SELECT com INNER JOIN e agregação
-- Obtém a quantidade de perfis associados a cada conta
SELECT
	Conta.email,
	COUNT(Perfil.id_perfil) AS total_perfis
FROM
	Conta
INNER JOIN Perfil ON
	Conta.email = Perfil.conta_email
GROUP BY
	Conta.email
HAVING
	COUNT(Perfil.id_perfil) > 1;
-- 2. SELECT com múltiplos JOINs e agregação
-- Obtém a média de qualidade das avaliações feitas por perfis com maior média de avaliação 
SELECT
	Perfil.apelido,
	AVG(Avaliacao.qualidade) AS media_qualidade
FROM
	Perfil
INNER JOIN PerfilConsomeConteudo ON
	Perfil.id_perfil = PerfilConsomeConteudo.perfil
	AND Perfil.conta_email = PerfilConsomeConteudo.conta
INNER JOIN Avaliacao ON
	PerfilConsomeConteudo.id_avaliacao = Avaliacao.id_avaliacao
GROUP BY
	Perfil.apelido
HAVING
	AVG(QUALIDADE) > 3.5;
-- 3. SUBCONSULTA CORRELACIONADA
-- Lista os conteúdos mais bem avaliados em relação à média geral
SELECT
	nome,
	qualidade
FROM
	Conteudo
JOIN Avaliacao ON
	Conteudo.id_conteudo = Avaliacao.id_avaliacao
WHERE
	qualidade > (
	SELECT
		AVG(qualidade)
	FROM
		Avaliacao);
-- 4. SELECT com LEFT JOIN
-- Lista todas as contas e seus respectivos números de telefone, atribuindo "Sem telefone" quando não houver
SELECT
	Conta.email,
	Telefone.telefone
FROM
	Conta
LEFT JOIN Telefone ON
	Conta.email = Telefone.email;
-- 8. UNION para consolidar dados de filmes e séries
-- Retorna todos os conteúdos, indicando se é um filme ou uma série
SELECT
	F.id_conteudo,
	C.nome,
	'Filme' AS tipo
FROM
	Filme F
JOIN CONTEUDO C ON
	C.ID_CONTEUDO = F.ID_CONTEUDO
UNION
SELECT
	id_serie AS id_conteudo,
	nome,
	'Serie' AS tipo
FROM
	Serie;
-- 9. VIEW para facilitar consultas frequentes
-- Criação de uma View que junta informações de perfis e seus consumos de conteúdo
CREATE VIEW Vw_PerfisConsumo AS 
SELECT
	Perfil.apelido,
	Conteudo.nome AS conteudo_assistido,
	PerfilConsomeConteudo.data_hora
FROM
	Perfil
JOIN PerfilConsomeConteudo ON
	Perfil.id_perfil = PerfilConsomeConteudo.perfil
	AND Perfil.conta_email = PerfilConsomeConteudo.conta
JOIN Conteudo ON
	PerfilConsomeConteudo.id_conteudo = Conteudo.id_conteudo
ORDER BY
	PerfilConsomeConteudo.DATA_HORA DESC;
-- 7. SELECT com BETWEEN
-- Seleciona avaliações com qualidade entre 3 e 5
SELECT
	P.APELIDO,
	C.NOME,
	A.DATA_HORA,
	A.QUALIDADE
FROM
	Avaliacao A
JOIN PerfilConsomeConteudo PC ON
	PC.id_avaliacao = A.ID_AVALIACAO
JOIN Perfil P ON
	P.ID_PERFIL = PC.PERFIL
JOIN Conteudo C ON
	C.ID_CONTEUDO = PC.ID_CONTEUDO
WHERE
	qualidade BETWEEN 3 AND 5;
-- 8. SELECT com IN 
-- Obtém os conteúdos cujos gêneros aparecem mais de 2 vezes na base
SELECT
	*
FROM
	Conteudo
WHERE
	genero IN (
	SELECT
		genero
	FROM
		Conteudo
	GROUP BY
		genero
	HAVING
		COUNT(*) > 2);
-- 9. SELECT com LIKE
-- Busca perfis cujo apelido começa com a letra 'A' ou contém 'ed' 
SELECT
	*
FROM
	Perfil
WHERE
	apelido LIKE 'A%'
	OR apelido LIKE '%ed%';
-- 10. SELECT com MAX
-- Obtém o conteúdo mais longo da base e seus detalhes
SELECT
	*
FROM
	Conteudo
WHERE
	duracao_minutos = (
	SELECT
		MAX(duracao_minutos)
	FROM
		Conteudo);
-- 11. SELECT com MIN
-- Obtém o(s) perfi(s) mais antigo(s) na plataforma
SELECT
	*
FROM
	Perfil
WHERE
	data_criacao = (
	SELECT
		MIN(data_criacao)
	FROM
		Perfil);
-- 12. SUBCONSULTA COM OPERADOR RELACIONAL
-- Obtém os planos que custam mais que 10% acima da média dos preços
SELECT
	*
FROM
	Plano
WHERE
	preco > (
	SELECT
		AVG(preco) * 1.1
	FROM
		Plano);
-- 13. SUBCONSULTA COM IN 
-- Seleciona conteúdos consumidos por contas com menos de três perfis
SELECT
	*
FROM
	Avaliacao
WHERE
	id_avaliacao IN (
	SELECT
		pcc.id_avaliacao
	FROM
		PerfilConsomeConteudo pcc
	JOIN Perfil p ON
		pcc.perfil = p.id_perfil
		AND pcc.conta = p.conta_email
	WHERE
		p.conta_email IN (
		SELECT
			conta_email
		FROM
			Perfil
		GROUP BY
			conta_email
		HAVING
			COUNT(id_perfil) < 3
    )
);
-- 14. SUBCONSULTA COM ANY 
-- Seleciona conteúdos que possuem avaliações superiores a qualquer avaliação feita nos últimos dois anos
SELECT
	*
FROM
	Conteudo
WHERE
	id_conteudo = ANY (
	SELECT
		pcc.id_conteudo
	FROM
		PerfilConsomeConteudo pcc
	JOIN Avaliacao a ON
		pcc.id_avaliacao = a.id_avaliacao
	WHERE
		a.qualidade > ANY (
		SELECT
			qualidade
		FROM
			Avaliacao
		WHERE
			data_hora > ADD_MONTHS(SYSDATE, -24)));
-- 15. SUBCONSULTA COM ALL
-- Obtém os perfis que deram avaliações superiores a todas as avaliações feitas na média geral
SELECT
	*
FROM
	Perfil
WHERE
	id_perfil = ANY (
	SELECT
		pcc.perfil
	FROM
		PerfilConsomeConteudo pcc
	JOIN Avaliacao a ON
		pcc.id_avaliacao = a.id_avaliacao
	WHERE
		a.qualidade > ALL (
		SELECT
			AVG(qualidade)
		FROM
			Avaliacao));
-- 16.
-- Seleciona filmes que não possuem sucessores e têm avaliação maior ou igual a 4
SELECT
	f.id_conteudo,
	c.nome,
	AVG(a.qualidade) AS media_avaliacoes
FROM
	Filme f
JOIN Conteudo c ON
	f.id_conteudo = c.id_conteudo
LEFT JOIN PerfilConsomeConteudo pcc ON
	c.id_conteudo = pcc.id_conteudo
LEFT JOIN Avaliacao a ON
	pcc.id_avaliacao = a.id_avaliacao
WHERE
	c.id_sucessor IS NULL
GROUP BY
	f.id_conteudo,
	c.nome
HAVING
	AVG(a.qualidade) IS NOT NULL
	AND AVG(a.qualidade) >= 4;

