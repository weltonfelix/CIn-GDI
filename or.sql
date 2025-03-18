---------------------------------------------------------------------
-- 1. Tipo Plano (final, pois não esperamos herança) 
---------------------------------------------------------------------
CREATE OR REPLACE TYPE plano_t AS OBJECT (
    id_plano              NUMBER,
    nome                  VARCHAR2(20),
    preco                 NUMBER(5,2),
    tempo_fidelidade_meses NUMBER,
    FINAL MEMBER FUNCTION exibir_detalhes RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY plano_t AS 
    MEMBER FUNCTION exibir_detalhes RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Plano ' || nome || ' com preço ' || TO_CHAR(preco);
    END;
END;
/

---------------------------------------------------------------------
-- 2. Tipo Telefone (usado no VARRAY)
---------------------------------------------------------------------
CREATE OR REPLACE TYPE telefone_t AS OBJECT (
    telefone VARCHAR2(15)
) FINAL;
/

-- VARRAY para armazenar múltiplos telefones (máximo 10)
CREATE OR REPLACE TYPE telefone_varray AS VARRAY(10) OF telefone_t;
/

---------------------------------------------------------------------
-- 3. Tipo Conta (com atributo multivalorado para telefones)
---------------------------------------------------------------------
CREATE OR REPLACE TYPE conta_t AS OBJECT (
    email         VARCHAR2(255),
    primeiro_nome VARCHAR2(30),
    sobrenome     VARCHAR2(30),
    senha         VARCHAR2(40),
    telefones     telefone_varray,  -- atributo multivalorado
    FINAL MEMBER FUNCTION exibir_nome RETURN VARCHAR2
) NOT FINAL;  -- Permite herança se necessário
/

CREATE OR REPLACE TYPE BODY conta_t AS 
    MEMBER FUNCTION exibir_nome RETURN VARCHAR2 IS
    BEGIN
      RETURN primeiro_nome || ' ' || sobrenome;
    END;
END;
/

---------------------------------------------------------------------
-- 4. Tipo Perfil (não instanciável, pois será usado como superclasse)
---------------------------------------------------------------------
CREATE OR REPLACE TYPE genero_favorito_t AS OBJECT (
	nome_genero VARCHAR2(50)
) FINAL;
CREATE OR REPLACE TYPE generos_favoritos_ntt AS TABLE OF genero_favorito_t;
/



/

CREATE OR REPLACE TYPE perfil_t AS OBJECT (
    id_perfil    NUMBER,
    conta_email  VARCHAR2(255), -- se botar REF não tem como colocar como chave primária
    apelido      VARCHAR2(30),
    tipo         VARCHAR2(50),
    data_criacao DATE,
    generos_favoritos generos_favoritos_ntt
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY perfil_t AS 
    MEMBER FUNCTION get_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Perfil: ' || apelido || ' (' || tipo || ')';
    END;
END;
/


---------------------------------------------------------------------
-- 5. Tipo Avaliacao 
---------------------------------------------------------------------
CREATE OR REPLACE TYPE avaliacao_t AS OBJECT (
    id_avaliacao NUMBER,
    qualidade    NUMBER,
    data_hora    TIMESTAMP,
    FINAL MEMBER FUNCTION status_avaliacao RETURN VARCHAR2,
    MAP MEMBER FUNCTION ordenar RETURN TIMESTAMP,
    CONSTRUCTOR FUNCTION avaliacao_t (
        id_avaliacao NUMBER,
        qualidade NUMBER,
        data_hora TIMESTAMP DEFAULT SYSTIMESTAMP
	) RETURN SELF AS RESULT
) FINAL;
/

CREATE OR REPLACE TYPE BODY avaliacao_t AS 
    MEMBER FUNCTION status_avaliacao RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Qualidade: ' || TO_CHAR(qualidade);
    END;
	MAP MEMBER FUNCTION ordenar RETURN TIMESTAMP IS
    BEGIN
        RETURN data_hora;
    END;
	CONSTRUCTOR FUNCTION avaliacao_t (
        id_avaliacao NUMBER,
        qualidade NUMBER,
        data_hora TIMESTAMP DEFAULT SYSTIMESTAMP
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.id_avaliacao := id_avaliacao;
        SELF.qualidade := qualidade;
        SELF.data_hora := data_hora;
        
        RETURN SELF;
    END;
END;
/

---------------------------------------------------------------------
-- 6. Tipo Conteudo (base para Filme e outros; NOT FINAL para permitir herança)
---------------------------------------------------------------------
CREATE OR REPLACE TYPE conteudo_t AS OBJECT (
    id_conteudo     NUMBER,
    nome            VARCHAR2(100),
    data_lancamento DATE,
    genero          VARCHAR2(30),
    duracao_minutos NUMBER,
    roteiro         VARCHAR2(255),
    producao        VARCHAR2(255),
    sucessor        REF conteudo_t,
    MEMBER FUNCTION descricao RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY conteudo_t AS 
    MEMBER FUNCTION descricao RETURN VARCHAR2 IS
    BEGIN
       RETURN nome || ' (' || TO_CHAR(data_lancamento, 'YYYY') || ')';
    END;
END;
/

---------------------------------------------------------------------
-- 7. Tipo Filme (herda de conteudo_t; NOT FINAL se houver possibilidade de herdar de Filme)
---------------------------------------------------------------------
CREATE OR REPLACE TYPE filme_t UNDER conteudo_t (
    nome_sequencia VARCHAR2(255),
    OVERRIDING MEMBER FUNCTION descricao RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY filme_t AS 
    MEMBER FUNCTION descricao RETURN VARCHAR2 IS
    BEGIN
        IF nome_sequencia IS NOT NULL THEN
            RETURN 'Filme: ' || nome || 
                   ', Gênero: ' || genero || 
                   ', Duração: ' || duracao_minutos || ' minutos' ||
                   ', Sequência: ' || nome_sequencia;
        ELSE
            RETURN 'Filme: ' || nome || 
                   ', Gênero: ' || genero || 
                   ', Duração: ' || duracao_minutos || ' minutos';
        END IF;
    END;
END;

/

---------------------------------------------------------------------
-- 8. Tipo Serie 
---------------------------------------------------------------------

CREATE OR REPLACE TYPE serie_t AS OBJECT (
    id_serie         NUMBER,
    numero_episodios NUMBER,
    nome             VARCHAR2(255),
    FINAL MEMBER FUNCTION resumo RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY serie_t AS 
    MEMBER FUNCTION resumo RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Série ' || nome || ' com ' || TO_CHAR(numero_episodios) || ' episódios';
    END;
END;
/

---------------------------------------------------------------------
-- 9. Tipo Episodio 
---------------------------------------------------------------------
CREATE OR REPLACE TYPE episodio_t UNDER conteudo_t (
    temporada         NUMBER,
    serie_pertencente REF serie_t,
    FINAL MEMBER FUNCTION info RETURN VARCHAR2
) FINAL;

/

CREATE OR REPLACE TYPE BODY episodio_t AS 
    MEMBER FUNCTION info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Temporada ' || TO_CHAR(temporada) || ', parte da série ' || TO_CHAR(serie_pertencente);
    END;
END;
/

---------------------------------------------------------------------
-- 10. Tipo PlanoPermiteConteudo
---------------------------------------------------------------------
CREATE OR REPLACE TYPE plano_permite_conteudo_t AS OBJECT (
    id_conteudo       NUMBER, -- com REF não pode ser chave primária
    id_plano          NUMBER, -- com REF não pode ser chave primária
    email             VARCHAR2(255), -- com REF não pode ser chave primária
    data_inicio       DATE,
    data_fim          DATE,
    desconto_aplicado NUMBER(5,2),
    FINAL MEMBER FUNCTION periodo RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY plano_permite_conteudo_t AS 
    MEMBER FUNCTION periodo RETURN VARCHAR2 IS
    BEGIN
       RETURN 'De ' || TO_CHAR(data_inicio, 'DD/MM/YYYY') || ' até ' ||
              CASE WHEN data_fim IS NOT NULL THEN TO_CHAR(data_fim, 'DD/MM/YYYY') ELSE 'indeterminado' END;
    END;
END;
/

---------------------------------------------------------------------
-- 11. Tipo PerfilConsomeConteudo
---------------------------------------------------------------------
CREATE OR REPLACE TYPE perfil_consome_conteudo_t AS OBJECT (
    id_conteudo         NUMBER, -- com REF não pode ser chave primária
    id_perfil           NUMBER, -- com REF não pode ser chave primária
    email               VARCHAR2(255), -- com REF não pode ser chave primária
    data_hora           TIMESTAMP,
    dispositivo_utilizado VARCHAR2(100),
    progresso_percentual NUMBER,
    avaliacao            REF avaliacao_t,
    FINAL MEMBER FUNCTION consumo_info RETURN VARCHAR2,
    MEMBER PROCEDURE atualizar_progresso(novo_progresso NUMBER),
    MEMBER FUNCTION resumo RETURN VARCHAR2,
    ORDER MEMBER FUNCTION comparar_consumo (outro perfil_consome_conteudo_t) RETURN INTEGER
);
/
ALTER TYPE perfil_consome_conteudo_t FINAL;
    
CREATE OR REPLACE TYPE BODY perfil_consome_conteudo_t AS 
    MEMBER FUNCTION consumo_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Consumo registrado em ' || TO_CHAR(data_hora, 'DD/MM/YYYY HH24:MI');
    END;
	MEMBER PROCEDURE atualizar_progresso(novo_progresso NUMBER) IS
    BEGIN
        IF novo_progresso < 0 OR novo_progresso > 100 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Progresso deve estar entre 0 e 100.');
        END IF;
        self.progresso_percentual := novo_progresso;
    END;
	ORDER MEMBER FUNCTION comparar_consumo (outro perfil_consome_conteudo_t) RETURN INTEGER IS
    DECLARE
        qualidade_self NUMBER;
        qualidade_outro NUMBER;
    BEGIN
        IF self.progresso_percentual > outro.progresso_percentual THEN
            RETURN 1;
        ELSIF self.progresso_percentual < outro.progresso_percentual THEN
            RETURN -1;
        END IF;

        IF self.avaliacao IS NOT NULL THEN
            SELECT qualidade INTO qualidade_self FROM avaliacao_obj_tab WHERE REF(qualidade_self) = self.avaliacao;
        ELSE
            qualidade_self := 0; -- se não tiver avaliação, consideramos qualidade 0
        END IF;

        IF outro.avaliacao IS NOT NULL THEN
            SELECT qualidade INTO qualidade_outro FROM avaliacao_obj_tab WHERE REF(qualidade_outro) = outro.avaliacao;
        ELSE
            qualidade_outro := 0;
        END IF;

        IF qualidade_self > qualidade_outro THEN
            RETURN 1;
        ELSIF qualidade_self < qualidade_outro THEN
            RETURN -1;
		ELSE
            RETURN 0;
        END IF;

    END;

	MEMBER FUNCTION resumo RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Perfil ' || VALUE(self).id_perfil || 
               ' consumiu conteúdo ' || VALUE(self).id_conteudo || 
               ' em ' || TO_CHAR(VALUE(self).data_hora, 'DD/MM/YYYY HH24:MI');
    END resumo;
END;
	
END;
/

CREATE TABLE plano_obj_tab OF plano_t (
    PRIMARY KEY (id_plano),
    nome NOT NULL,
    preco NOT NULL,
    tempo_fidelidade_meses NOT NULL
);


CREATE TABLE conta_obj_tab OF conta_t (
    PRIMARY KEY (email),
    primeiro_nome NOT NULL,
    senha NOT NULL
);

CREATE TABLE perfil_obj_tab OF perfil_t (
    PRIMARY KEY (id_perfil, conta_email), -- com REF conta não vai
    FOREIGN KEY (conta_email) REFERENCES conta_obj_tab(email),
    tipo NOT NULL,
    data_criacao NOT NULL,
    CONSTRAINT tipos_possiveis CHECK (tipo IN ('Infantil', 'Livre'))
) NESTED TABLE generos_favoritos STORE AS generos_favoritos_tab;


CREATE TABLE avaliacao_obj_tab OF avaliacao_t (
    PRIMARY KEY (id_avaliacao),
    qualidade NOT NULL,
    data_hora NOT NULL,
    CONSTRAINT intervalo_valido_qualidade CHECK (qualidade BETWEEN 1 AND 5)
);


CREATE TABLE conteudo_obj_tab OF conteudo_t (
    PRIMARY KEY (id_conteudo),
    nome NOT NULL,
    data_lancamento NOT NULL
);

CREATE TABLE filme_obj_tab OF filme_t (
    PRIMARY KEY (id_conteudo), -- n sei se precisa repetir
    nome NOT NULL,
    data_lancamento NOT NULL
);

CREATE TABLE serie_obj_tab OF serie_t(
    PRIMARY KEY (id_serie),
    numero_episodios NOT NULL,
    nome NOT NULL
);

CREATE TABLE episodio_obj_tab OF episodio_t (
    PRIMARY KEY (id_conteudo),
    temporada NOT NULL,
    serie_pertencente SCOPE IS serie_obj_tab
);

CREATE TABLE plano_permite_conteudo_obj_tab OF plano_permite_conteudo_t (
    PRIMARY KEY (id_conteudo, id_plano, email),
    FOREIGN KEY (id_conteudo) REFERENCES conteudo_obj_tab(id_conteudo),
    FOREIGN KEY (id_plano) REFERENCES plano_obj_tab(id_plano),
    FOREIGN KEY (email) REFERENCES conta_obj_tab(email),
    data_inicio NOT NULL
);

CREATE TABLE perfil_consome_conteudo_obj_tab OF perfil_consome_conteudo_t (
    PRIMARY KEY (id_conteudo, id_perfil, email, data_hora),
    FOREIGN KEY (id_conteudo) REFERENCES conteudo_obj_tab(id_conteudo),
    FOREIGN KEY (id_perfil, email) REFERENCES perfil_obj_tab(id_perfil, conta_email),
    avaliacao WITH ROWID REFERENCES avaliacao_obj_tab
);

INSERT INTO plano_obj_tab VALUES (plano_t(1, 'Básico', 10.00, 6));
INSERT INTO plano_obj_tab VALUES (plano_t(2, 'Premium', 15.00, 3));
INSERT INTO plano_obj_tab VALUES (plano_t(3, 'Ultra', 40.00, 0));

-- Inserir José Silva com 2 telefones
INSERT INTO conta_obj_tab 
VALUES (
    conta_t(
        'jose.silva@email.com', 
        'José', 
        'Silva', 
        'senha123', 
        telefone_varray(telefone_t('+05511987654321'), telefone_t('+05511912345678'))
    )
);

-- Inserir Maria Santos com 1 telefone
INSERT INTO conta_obj_tab 
VALUES (
    conta_t(
        'maria.santos@email.com', 
        'Maria', 
        'Santos', 
        'senha456', 
        telefone_varray(telefone_t('+05521987654321'))
    )
);

-- Inserir Pedro Oliveira com 2 telefones
INSERT INTO conta_obj_tab 
VALUES (
    conta_t(
        'pedro.oliveira@email.com', 
        'Pedro', 
        'Oliveira', 
        'senha789', 
        telefone_varray(telefone_t('+05531987654321'), telefone_t('+05531912345678'))
    )
);

-- Inserir Ana Pereira com 1 telefone
INSERT INTO conta_obj_tab 
VALUES (
    conta_t(
        'ana.pereira@email.com', 
        'Ana', 
        'Pereira', 
        'senha101', 
        telefone_varray(telefone_t('+05541987654321'))
    )
);

-- Inserir Lucas Rodrigues com 2 telefones
INSERT INTO conta_obj_tab 
VALUES (
    conta_t(
        'lucas.rodrigues@email.com', 
        'Lucas', 
        'Rodrigues', 
        'senha202', 
        telefone_varray(telefone_t('+05551987654321'), telefone_t('+05551912345678'))
    )
);

-- Inserir perfil para José Silva com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    1, 
    'jose.silva@email.com', 
    'Zé', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Ação'), 
        genero_favorito_t('Aventura')
    )
);

-- Inserir perfil para José Silva com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    2, 
    'jose.silva@email.com', 
    'SilvaZ', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Comédia'), 
        genero_favorito_t('Infantil')
    )
);

-- Inserir perfil para Maria Santos com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    3, 
    'maria.santos@email.com', 
    'Mari', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Romance'), 
        genero_favorito_t('Drama')
    )
);

-- Inserir perfil para Maria Santos com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    4, 
    'maria.santos@email.com', 
    'Marinha', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Infantil')
    )
);

-- Inserir perfil para Maria Santos com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    5, 
    'maria.santos@email.com', 
    'Mariazinha', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Aventura'), 
        genero_favorito_t('Comédia')
    )
);

-- Inserir perfil para Pedro Oliveira com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    6, 
    'pedro.oliveira@email.com', 
    'Pedrinho', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Terror'), 
        genero_favorito_t('Mistério')
    )
);

-- Inserir perfil para Pedro Oliveira com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    7, 
    'pedro.oliveira@email.com', 
    'P. Oliveira', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Infantil'), 
        genero_favorito_t('Comédia')
    )
);

-- Inserir perfil para Ana Pereira com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    8, 
    'ana.pereira@email.com', 
    'Aninha', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Drama'), 
        genero_favorito_t('Romance')
    )
);

-- Inserir perfil para Ana Pereira com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    9, 
    'ana.pereira@email.com', 
    'AnaP', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Infantil')
    )
);

-- Inserir perfil para Ana Pereira com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    10, 
    'ana.pereira@email.com', 
    'AnaPer', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Comédia'), 
        genero_favorito_t('Infantil')
    )
);

-- Inserir perfil para Lucas Rodrigues com gêneros favoritos
INSERT INTO perfil_obj_tab 
VALUES (
    11, 
    'lucas.rodrigues@email.com', 
    'Luquinha', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Ação')
    )
);

-- Criar os objetos de Conteúdo
DECLARE
  c1 conteudo_t;
  c2 conteudo_t;
  c3 conteudo_t;
  c4 conteudo_t;
  c5 conteudo_t;
  c6 conteudo_t;
  c7 conteudo_t;
  c8 conteudo_t;
  c9 conteudo_t;
  c10 conteudo_t;
  c11 conteudo_t;
  c12 conteudo_t;
  c13 conteudo_t;
  c14 conteudo_t;
  c15 conteudo_t;
  c16 conteudo_t;
  c17 conteudo_t;
  c18 conteudo_t;
  c19 conteudo_t;
  c20 conteudo_t;
  c21 conteudo_t;
  c22 conteudo_t;
  c23 conteudo_t;
  c24 conteudo_t;
  c25 conteudo_t;
  c26 conteudo_t;
  c27 conteudo_t;
  c28 conteudo_t;
BEGIN
  -- Inserir os conteúdos e criar as referências de sucessor
  c1 := conteudo_t(1, 'O Senhor dos Anéis: A Sociedade do Anel', TO_DATE('19-12-2001', 'DD-MM-YYYY'), 'Aventura', 178, 'Fran Walsh, Philippa Boyens, Peter Jackson', 'New Line Cinema', NULL);
  c2 := conteudo_t(2, 'Piratas do Caribe: A Maldição do Pérola Negra', TO_DATE('09-07-2003', 'DD-MM-YYYY'), 'Aventura', 143, 'Ted Elliott, Terry Rossio', 'Walt Disney Pictures', NULL);
  c3 := conteudo_t(3, 'O Rei Leão', TO_DATE('24-06-1994', 'DD-MM-YYYY'), 'Animação', 88, 'Irene Mecchi, Jonathan Roberts, Linda Woolverton', 'Walt Disney Feature Animation', NULL);
  c4 := conteudo_t(4, 'Gladiador', TO_DATE('05-05-2000', 'DD-MM-YYYY'), 'Drama', 155, 'David Franzoni, John Logan', 'DreamWorks Pictures', NULL);
  c5 := conteudo_t(5, 'Matrix', TO_DATE('31-03-1999', 'DD-MM-YYYY'), 'Ficção Científica', 136, 'Lana Wachowski, Lilly Wachowski', 'Warner Bros. Pictures', NULL);
  c6 := conteudo_t(6, 'Titanic', TO_DATE('19-12-1997', 'DD-MM-YYYY'), 'Drama', 195, 'James Cameron', 'Paramount Pictures', NULL);
  c7 := conteudo_t(7, 'Jurassic Park', TO_DATE('11-06-1993', 'DD-MM-YYYY'), 'Aventura', 127, 'Michael Crichton', 'Universal Pictures', NULL);
  c8 := conteudo_t(8, 'A Origem', TO_DATE('16-07-2010', 'DD-MM-YYYY'), 'Ficção Científica', 148, 'Christopher Nolan', 'Warner Bros. Pictures', NULL);
  c9 := conteudo_t(10, 'O Exterminador do Futuro 2: O Julgamento Final', TO_DATE('03-07-1991', 'DD-MM-YYYY'), 'Ação', 137, 'James Cameron, William Wisher Jr.', 'TriStar Pictures', NULL);
  c10 := conteudo_t(11, 'The Dark Knight', TO_DATE('18-07-2008', 'DD-MM-YYYY'), 'Ação', 152, 'Jonathan Nolan, Christopher Nolan', 'Warner Bros. Pictures', NULL);
  c11 := conteudo_t(12, 'O Hobbit: Uma Jornada Inesperada', TO_DATE('14-12-2012', 'DD-MM-YYYY'), 'Aventura', 169, 'Fran Walsh, Philippa Boyens, Peter Jackson', 'New Line Cinema', NULL);
  c12 := conteudo_t(13, 'Homem de Ferro', TO_DATE('02-05-2008', 'DD-MM-YYYY'), 'Ação', 126, 'Mark Fergus, Hawk Ostby, Art Marcum, Matt Holloway', 'Marvel Studios', NULL);
  c13 := conteudo_t(14, 'O Incrível Hulk', TO_DATE('13-06-2008', 'DD-MM-YYYY'), 'Ação', 112, 'Zak Penn', 'Marvel Studios', NULL);
  c14 := conteudo_t(15, 'Thor', TO_DATE('06-05-2011', 'DD-MM-YYYY'), 'Aventura', 115, 'Ashley Edward Miller, Zack Stentz, Don Payne', 'Marvel Studios', NULL);
  c15 := conteudo_t(28, 'Eternos', TO_DATE('05-11-2021', 'DD-MM-YYYY'), 'Aventura', 156, 'Chloé Zhao, Patrick Burleigh, Ryan Firpo', 'Marvel Studios', NULL);
  c16 := conteudo_t(27, 'Homem-Aranha: Longe de Casa', TO_DATE('02-07-2019', 'DD-MM-YYYY'), 'Aventura', 129, 'Chris McKenna, Erik Sommers', 'Marvel Studios', NULL);
  c17 := conteudo_t(26, 'Vingadores: Ultimato', TO_DATE('26-04-2019', 'DD-MM-YYYY'), 'Ação', 181, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL);
  c18 := conteudo_t(25, 'Vingadores: Guerra Infinita', TO_DATE('27-04-2018', 'DD-MM-YYYY'), 'Ação', 149, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL);
  c19 := conteudo_t(24, 'Guardiões da Galáxia Vol. 2', TO_DATE('05-05-2017', 'DD-MM-YYYY'), 'Aventura', 136, 'James Gunn', 'Marvel Studios', NULL);
  c20 := conteudo_t(23, 'Doutor Estranho', TO_DATE('04-11-2016', 'DD-MM-YYYY'), 'Ficção Científica', 115, 'Jon Spaihts, Scott Derrickson, C. Robert Cargill', 'Marvel Studios', NULL);
  c21 := conteudo_t(22, 'Capitão América: Guerra Civil', TO_DATE('06-05-2016', 'DD-MM-YYYY'), 'Ação', 147, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL);
  c22 := conteudo_t(21, 'Vingadores: Era de Ultron', TO_DATE('01-05-2015', 'DD-MM-YYYY'), 'Ação', 141, 'Joss Whedon', 'Marvel Studios', NULL);
  c23 := conteudo_t(20, 'Capitão América: O Soldado Invernal', TO_DATE('04-04-2014', 'DD-MM-YYYY'), 'Aventura', 136, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL);
  c24 := conteudo_t(19, 'Thor: O Mundo Sombrio', TO_DATE('08-11-2013', 'DD-MM-YYYY'), 'Aventura', 112, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL);
  c25 := conteudo_t(18, 'Homem de Ferro 3', TO_DATE('03-05-2013', 'DD-MM-YYYY'), 'Ação', 130, 'Drew Pearce, Shane Black', 'Marvel Studios', NULL);
  c26 := conteudo_t(17, 'Os Vingadores', TO_DATE('04-05-2012', 'DD-MM-YYYY'), 'Ação', 143, 'Joss Whedon', 'Marvel Studios', NULL);
  c27 := conteudo_t(16, 'Capitão América: O Primeiro Vingador', TO_DATE('22-07-2011', 'DD-MM-YYYY'), 'Aventura', 124, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL);

  -- Inserir os conteúdos na tabela
  INSERT INTO conteudo_obj_tab VALUES (c1);
  INSERT INTO conteudo_obj_tab VALUES (c2);
  INSERT INTO conteudo_obj_tab VALUES (c3);
  INSERT INTO conteudo_obj_tab VALUES (c4);
  INSERT INTO conteudo_obj_tab VALUES (c5);
  INSERT INTO conteudo_obj_tab VALUES (c6);
  INSERT INTO conteudo_obj_tab VALUES (c7);
  INSERT INTO conteudo_obj_tab VALUES (c8);
  INSERT INTO conteudo_obj_tab VALUES (c9);
  INSERT INTO conteudo_obj_tab VALUES (c10);
  INSERT INTO conteudo_obj_tab VALUES (c11);
  INSERT INTO conteudo_obj_tab VALUES (c12);
  INSERT INTO conteudo_obj_tab VALUES (c13);
  INSERT INTO conteudo_obj_tab VALUES (c14);
  INSERT INTO conteudo_obj_tab VALUES (c15);
  INSERT INTO conteudo_obj_tab VALUES (c16);
  INSERT INTO conteudo_obj_tab VALUES (c17);
  INSERT INTO conteudo_obj_tab VALUES (c18);
  INSERT INTO conteudo_obj_tab VALUES (c19);
  INSERT INTO conteudo_obj_tab VALUES (c20);
  INSERT INTO conteudo_obj_tab VALUES (c21);
  INSERT INTO conteudo_obj_tab VALUES (c22);
  INSERT INTO conteudo_obj_tab VALUES (c23);
  INSERT INTO conteudo_obj_tab VALUES (c24);
  INSERT INTO conteudo_obj_tab VALUES (c25);
  INSERT INTO conteudo_obj_tab VALUES (c26);
  INSERT INTO conteudo_obj_tab VALUES (c27);

  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 28) WHERE c.id_conteudo = 27;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 27) WHERE c.id_conteudo = 26;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 26) WHERE c.id_conteudo = 25;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 25) WHERE c.id_conteudo = 24;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 24) WHERE c.id_conteudo = 23;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 23) WHERE c.id_conteudo = 22;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 22) WHERE c.id_conteudo = 21;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 21) WHERE c.id_conteudo = 20;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 20) WHERE c.id_conteudo = 19;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 19) WHERE c.id_conteudo = 18;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 18) WHERE c.id_conteudo = 17;
  UPDATE conteudo_obj_tab c SET c.sucessor = (SELECT REF(c2) FROM conteudo_obj_tab c2 WHERE c2.id_conteudo = 17) WHERE c.id_conteudo = 16;

END;
