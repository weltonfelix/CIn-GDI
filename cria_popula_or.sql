-- 1. Tipo Plano (final, pois não esperamos herança) 
CREATE OR REPLACE TYPE plano_t AS OBJECT (
    id_plano              NUMBER,
    nome                  VARCHAR2(20),
    preco                 NUMBER(5,2),
    tempo_fidelidade_meses NUMBER,
    FINAL MEMBER FUNCTION exibir_detalhes RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY plano_t AS 
    FINAL MEMBER FUNCTION exibir_detalhes RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Plano ' || nome || ' com preço ' || TO_CHAR(preco);
    END;
END;
/


-- 2. Tipo Telefone
CREATE OR REPLACE TYPE telefone_t AS OBJECT (
    telefone VARCHAR2(15)
) FINAL;
/

-- VARRAY para armazenar múltiplos telefones (máximo 10)
CREATE OR REPLACE TYPE telefone_varray AS VARRAY(10) OF telefone_t;
/

    
-- 3. Tipo Conta (com atributo multivalorado para telefones)
CREATE OR REPLACE TYPE conta_t AS OBJECT (
    email         VARCHAR2(255),
    primeiro_nome VARCHAR2(30),
    sobrenome     VARCHAR2(30),
    senha         VARCHAR2(40),
    telefones     telefone_varray,  -- atributo multivalorado
    FINAL MEMBER FUNCTION exibir_nome RETURN VARCHAR2
) NOT FINAL;  
/

CREATE OR REPLACE TYPE BODY conta_t AS 
    FINAL MEMBER FUNCTION exibir_nome RETURN VARCHAR2 IS
    BEGIN
      RETURN primeiro_nome || ' ' || sobrenome;
    END;
END;
/


-- 4. Tipo Perfil
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
    generos_favoritos generos_favoritos_ntt,
    MEMBER FUNCTION get_info RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY perfil_t AS 
    MEMBER FUNCTION get_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Perfil: ' || apelido || ' (' || tipo || ')';
    END;
END;
/


-- 5. Tipo Avaliacao 
CREATE OR REPLACE TYPE avaliacao_t AS OBJECT (
    id_avaliacao NUMBER,
    qualidade    NUMBER,
    data_hora    TIMESTAMP,
    MEMBER FUNCTION status_avaliacao RETURN VARCHAR2,
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
        
        RETURN;
    END;
END;
/


-- 6. Tipo Conteudo (base para Filme e outros; NOT FINAL para permitir herança)
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
) NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE BODY conteudo_t AS 
    MEMBER FUNCTION descricao RETURN VARCHAR2 IS
    BEGIN
       RETURN nome || ' (' || TO_CHAR(data_lancamento, 'YYYY') || ')';
    END;
END;
/


-- 7. Tipo Filme
CREATE OR REPLACE TYPE filme_t UNDER conteudo_t (
    nome_sequencia VARCHAR2(255),
    OVERRIDING MEMBER FUNCTION descricao RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY filme_t AS 
    OVERRIDING MEMBER FUNCTION descricao RETURN VARCHAR2 IS
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

-- 8. Tipo Serie

CREATE OR REPLACE TYPE serie_t AS OBJECT (
    id_serie         NUMBER,
    numero_episodios NUMBER,
    nome             VARCHAR2(255),
    FINAL MEMBER FUNCTION resumo RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY serie_t AS 
    FINAL MEMBER FUNCTION resumo RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Série ' || nome || ' com ' || TO_CHAR(numero_episodios) || ' episódios';
    END;
END;
/

-- 9. Tipo Episodio 
CREATE OR REPLACE TYPE episodio_t UNDER conteudo_t (
    temporada         NUMBER,
    serie_pertencente REF serie_t,
    FINAL MEMBER FUNCTION info RETURN VARCHAR2
) FINAL;

/

CREATE OR REPLACE TYPE BODY episodio_t AS 
    FINAL MEMBER FUNCTION info RETURN VARCHAR2 IS
    v_serie serie_t;
    BEGIN
        SELECT DEREF(serie_pertencente) INTO v_serie FROM DUAL;
        RETURN 'Temporada ' || TO_CHAR(temporada) || ', parte da série ' || v_serie.nome;
    END info;
END;
/
/

-- 10. Tipo plano_permite_filme_obj_tab
CREATE OR REPLACE TYPE plano_permite_filme_t AS OBJECT (
    id_filme          NUMBER, -- com REF não pode ser chave primária
    id_plano          NUMBER, -- com REF não pode ser chave primária
    email             VARCHAR2(255), -- com REF não pode ser chave primária
    data_inicio       DATE,
    data_fim          DATE,
    desconto_aplicado NUMBER(5,2),
    FINAL MEMBER FUNCTION periodo RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY plano_permite_filme_t AS 
    FINAL MEMBER FUNCTION periodo RETURN VARCHAR2 IS
    BEGIN
       RETURN 'De ' || TO_CHAR(data_inicio, 'DD/MM/YYYY') || ' até ' ||
              CASE WHEN data_fim IS NOT NULL THEN TO_CHAR(data_fim, 'DD/MM/YYYY') ELSE 'indeterminado' END;
    END;
END;

CREATE OR REPLACE TYPE plano_permite_episodio_t AS OBJECT (
    id_episodio       NUMBER, -- com REF não pode ser chave primária
    id_plano          NUMBER, -- com REF não pode ser chave primária
    email             VARCHAR2(255), -- com REF não pode ser chave primária
    data_inicio       DATE,
    data_fim          DATE,
    desconto_aplicado NUMBER(5,2),
    FINAL MEMBER FUNCTION periodo RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY plano_permite_episodio_t AS 
    FINAL MEMBER FUNCTION periodo RETURN VARCHAR2 IS
    BEGIN
       RETURN 'De ' || TO_CHAR(data_inicio, 'DD/MM/YYYY') || ' até ' ||
              CASE WHEN data_fim IS NOT NULL THEN TO_CHAR(data_fim, 'DD/MM/YYYY') ELSE 'indeterminado' END;
    END;
END;
/


CREATE OR REPLACE TYPE perfil_consome_filme_t AS OBJECT (
    id_filme            NUMBER, -- com REF não pode ser chave primária
    id_perfil           NUMBER, -- com REF não pode ser chave primária
    email               VARCHAR2(255), -- com REF não pode ser chave primária
    data_hora           TIMESTAMP,
    dispositivo_utilizado VARCHAR2(100),
    progresso_percentual NUMBER,
    avaliacao            REF avaliacao_t,
    FINAL MEMBER FUNCTION consumo_info RETURN VARCHAR2,
    MEMBER PROCEDURE atualizar_progresso(novo_progresso NUMBER),
    ORDER MEMBER FUNCTION comparar_consumo (outro perfil_consome_filme_t) RETURN INTEGER
) FINAL;
    
CREATE OR REPLACE TYPE BODY perfil_consome_filme_t AS 
    FINAL MEMBER FUNCTION consumo_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Consumo registrado em ' || TO_CHAR(self.data_hora, 'DD/MM/YYYY HH24:MI');
    END;

    MEMBER PROCEDURE atualizar_progresso(novo_progresso NUMBER) IS
    BEGIN
        IF novo_progresso < 0 OR novo_progresso > 100 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Progresso deve estar entre 0 e 100.');
        END IF;
        self.progresso_percentual := novo_progresso;
    END;

    ORDER MEMBER FUNCTION comparar_consumo (outro perfil_consome_filme_t) RETURN INTEGER IS
        qualidade_self NUMBER;
        qualidade_outro NUMBER;
    BEGIN
        IF self.progresso_percentual > outro.progresso_percentual THEN
            RETURN 1;
        ELSIF self.progresso_percentual < outro.progresso_percentual THEN
            RETURN -1;
        END IF;

        IF self.avaliacao IS NOT NULL THEN
            SELECT qualidade INTO qualidade_self 
            FROM avaliacao_obj_tab 
            WHERE id_avaliacao = DEREF(self.avaliacao).id_avaliacao;  
        ELSE
            qualidade_self := 0; 
        END IF;

        IF outro.avaliacao IS NOT NULL THEN
            SELECT qualidade INTO qualidade_outro 
            FROM avaliacao_obj_tab 
            WHERE id_avaliacao = DEREF(outro.avaliacao).id_avaliacao; 
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

END;

CREATE OR REPLACE TYPE perfil_consome_episodio_t AS OBJECT (
    id_episodio            NUMBER, -- com REF não pode ser chave primária
    id_perfil           NUMBER, -- com REF não pode ser chave primária
    email               VARCHAR2(255), -- com REF não pode ser chave primária
    data_hora           TIMESTAMP,
    dispositivo_utilizado VARCHAR2(100),
    progresso_percentual NUMBER,
    avaliacao            REF avaliacao_t
) FINAL;


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


CREATE TABLE filme_obj_tab OF filme_t (
    PRIMARY KEY (id_conteudo), 
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

CREATE TABLE plano_permite_filme_obj_tab OF plano_permite_filme_t (
    PRIMARY KEY (id_filme, id_plano, email),
    FOREIGN KEY (id_filme) REFERENCES filme_obj_tab(id_conteudo),
    FOREIGN KEY (id_plano) REFERENCES plano_obj_tab(id_plano),
    FOREIGN KEY (email) REFERENCES conta_obj_tab(email),
    data_inicio NOT NULL
);


CREATE TABLE plano_permite_episodio_obj_tab OF plano_permite_episodio_t (
    PRIMARY KEY (id_episodio, id_plano, email),
    FOREIGN KEY (id_episodio) REFERENCES episodio_obj_tab(id_conteudo),
    FOREIGN KEY (id_plano) REFERENCES plano_obj_tab(id_plano),
    FOREIGN KEY (email) REFERENCES conta_obj_tab(email),
    data_inicio NOT NULL
);

CREATE TABLE perfil_consome_filme_obj_tab OF perfil_consome_filme_t (
    PRIMARY KEY (id_filme, id_perfil, email, data_hora),
    FOREIGN KEY (id_filme) REFERENCES filme_obj_tab(id_conteudo),
    FOREIGN KEY (id_perfil, email) REFERENCES perfil_obj_tab(id_perfil, conta_email),
    avaliacao WITH ROWID REFERENCES avaliacao_obj_tab
);
ALTER TYPE perfil_consome_filme_t ADD MEMBER PROCEDURE imprimir_consumo(id_perfil NUMBER, id_conteudo NUMBER) CASCADE;

CREATE OR REPLACE TYPE BODY perfil_consome_filme_t AS -- repetindo para adicionar o novo procedimento
    FINAL MEMBER FUNCTION consumo_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Consumo registrado em ' || TO_CHAR(self.data_hora, 'DD/MM/YYYY HH24:MI');
    END;

    MEMBER PROCEDURE atualizar_progresso(novo_progresso NUMBER) IS
    BEGIN
        IF novo_progresso < 0 OR novo_progresso > 100 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Progresso deve estar entre 0 e 100.');
        END IF;
        self.progresso_percentual := novo_progresso;
    END;

    ORDER MEMBER FUNCTION comparar_consumo (outro perfil_consome_filme_t) RETURN INTEGER IS
        qualidade_self NUMBER;
        qualidade_outro NUMBER;
    BEGIN
        IF self.progresso_percentual > outro.progresso_percentual THEN
            RETURN 1;
        ELSIF self.progresso_percentual < outro.progresso_percentual THEN
            RETURN -1;
        END IF;

        IF self.avaliacao IS NOT NULL THEN
            SELECT qualidade INTO qualidade_self 
            FROM avaliacao_obj_tab 
            WHERE id_avaliacao = DEREF(self.avaliacao).id_avaliacao;  
        ELSE
            qualidade_self := 0;
        END IF;

        IF outro.avaliacao IS NOT NULL THEN
            SELECT qualidade INTO qualidade_outro 
            FROM avaliacao_obj_tab 
            WHERE id_avaliacao = DEREF(outro.avaliacao).id_avaliacao;  
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
    MEMBER PROCEDURE imprimir_consumo(id_perfil NUMBER, id_conteudo NUMBER) IS
        v_consumo perfil_consome_filme_t;
    BEGIN
        SELECT VALUE(p) INTO v_consumo 
        FROM perfil_consome_filme_obj_tab p
        WHERE p.id_perfil = id_perfil AND p.id_filme = id_conteudo;

        DBMS_OUTPUT.PUT_LINE('Perfil: ' || v_consumo.id_perfil || 
                             ', Conteúdo: ' || v_consumo.id_filme || 
                             ', Progresso: ' || v_consumo.progresso_percentual || '%');
    END;

END;

CREATE TABLE perfil_consome_episodio_obj_tab OF perfil_consome_episodio_t (
    PRIMARY KEY (id_episodio, id_perfil, email, data_hora),
    FOREIGN KEY (id_episodio) REFERENCES episodio_obj_tab(id_conteudo),
    FOREIGN KEY (id_perfil, email) REFERENCES perfil_obj_tab(id_perfil, conta_email),
    avaliacao WITH ROWID REFERENCES avaliacao_obj_tab
);

-- INÍCIO DO POVOAMENTO

INSERT INTO plano_obj_tab VALUES (plano_t(1, 'Básico', 10.00, 6));
INSERT INTO plano_obj_tab VALUES (plano_t(2, 'Premium', 15.00, 3));
INSERT INTO plano_obj_tab VALUES (plano_t(3, 'Ultra', 40.00, 0));


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


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    1, 
    'jose.silva@email.com', 
    'Zé', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Ação'), 
        genero_favorito_t('Aventura')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    2, 
    'jose.silva@email.com', 
    'SilvaZ', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Comédia'), 
        genero_favorito_t('Infantil')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    3, 
    'maria.santos@email.com', 
    'Mari', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Romance'), 
        genero_favorito_t('Drama')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    4, 
    'maria.santos@email.com', 
    'Marinha', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Infantil')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    5, 
    'maria.santos@email.com', 
    'Mariazinha', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Aventura'), 
        genero_favorito_t('Comédia')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    6, 
    'pedro.oliveira@email.com', 
    'Pedrinho', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Terror'), 
        genero_favorito_t('Mistério')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    7, 
    'pedro.oliveira@email.com', 
    'P. Oliveira', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Infantil'), 
        genero_favorito_t('Comédia')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    8, 
    'ana.pereira@email.com', 
    'Aninha', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Drama'), 
        genero_favorito_t('Romance')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    9, 
    'ana.pereira@email.com', 
    'AnaP', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Infantil')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    10, 
    'ana.pereira@email.com', 
    'AnaPer', 
    'Infantil', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Comédia'), 
        genero_favorito_t('Infantil')
    )
));


INSERT INTO perfil_obj_tab 
VALUES (perfil_t(
    11, 
    'lucas.rodrigues@email.com', 
    'Luquinha', 
    'Livre', 
    TO_DATE('05-02-2025', 'DD-MM-YYYY'),
    generos_favoritos_ntt(
        genero_favorito_t('Ação')
    )
));


DECLARE
  c1 filme_t;
  c2 filme_t;
  c3 filme_t;
  c4 filme_t;
  c5 filme_t;
  c6 filme_t;
  c7 filme_t;
  c8 filme_t;
  c9 filme_t;
  c10 filme_t;
  c11 filme_t;
  c12 filme_t;
  c13 filme_t;
  c14 filme_t;
  c15 filme_t;
  c16 filme_t;
  c17 filme_t;
  c18 filme_t;
  c19 filme_t;
  c20 filme_t;
  c21 filme_t;
  c22 filme_t;
  c23 filme_t;
  c24 filme_t;
  c25 filme_t;
  c26 filme_t;
  c27 filme_t;
  c28 filme_t;
BEGIN
  -- criar as referências de sucessor
  c1 := filme_t(1, 'O Senhor dos Anéis: A Sociedade do Anel', TO_DATE('19-12-2001', 'DD-MM-YYYY'), 'Aventura', 178, 'Fran Walsh, Philippa Boyens, Peter Jackson', 'New Line Cinema', NULL, NULL);
  c2 := filme_t(2, 'Piratas do Caribe: A Maldição do Pérola Negra', TO_DATE('09-07-2003', 'DD-MM-YYYY'), 'Aventura', 143, 'Ted Elliott, Terry Rossio', 'Walt Disney Pictures', NULL, NULL);
  c3 := filme_t(3, 'O Rei Leão', TO_DATE('24-06-1994', 'DD-MM-YYYY'), 'Animação', 88, 'Irene Mecchi, Jonathan Roberts, Linda Woolverton', 'Walt Disney Feature Animation', NULL, NULL);
  c4 := filme_t(4, 'Gladiador', TO_DATE('05-05-2000', 'DD-MM-YYYY'), 'Drama', 155, 'David Franzoni, John Logan', 'DreamWorks Pictures', NULL, NULL);
  c5 := filme_t(5, 'Matrix', TO_DATE('31-03-1999', 'DD-MM-YYYY'), 'Ficção Científica', 136, 'Lana Wachowski, Lilly Wachowski', 'Warner Bros. Pictures', NULL, NULL);
  c6 := filme_t(6, 'Titanic', TO_DATE('19-12-1997', 'DD-MM-YYYY'), 'Drama', 195, 'James Cameron', 'Paramount Pictures', NULL, NULL);
  c7 := filme_t(7, 'Jurassic Park', TO_DATE('11-06-1993', 'DD-MM-YYYY'), 'Aventura', 127, 'Michael Crichton', 'Universal Pictures', NULL, NULL);
  c8 := filme_t(8, 'A Origem', TO_DATE('16-07-2010', 'DD-MM-YYYY'), 'Ficção Científica', 148, 'Christopher Nolan', 'Warner Bros. Pictures', NULL, NULL);
  c9 := filme_t(10, 'O Exterminador do Futuro 2: O Julgamento Final', TO_DATE('03-07-1991', 'DD-MM-YYYY'), 'Ação', 137, 'James Cameron, William Wisher Jr.', 'TriStar Pictures', NULL, NULL);
  c10 := filme_t(11, 'The Dark Knight', TO_DATE('18-07-2008', 'DD-MM-YYYY'), 'Ação', 152, 'Jonathan Nolan, Christopher Nolan', 'Warner Bros. Pictures', NULL, NULL);
  c11 := filme_t(12, 'O Hobbit: Uma Jornada Inesperada', TO_DATE('14-12-2012', 'DD-MM-YYYY'), 'Aventura', 169, 'Fran Walsh, Philippa Boyens, Peter Jackson', 'New Line Cinema', NULL, NULL);
  c12 := filme_t(13, 'Homem de Ferro', TO_DATE('02-05-2008', 'DD-MM-YYYY'), 'Ação', 126, 'Mark Fergus, Hawk Ostby, Art Marcum, Matt Holloway', 'Marvel Studios', NULL, NULL);
  c13 := filme_t(14, 'O Incrível Hulk', TO_DATE('13-06-2008', 'DD-MM-YYYY'), 'Ação', 112, 'Zak Penn', 'Marvel Studios', NULL, NULL);
  c14 := filme_t(15, 'Thor', TO_DATE('06-05-2011', 'DD-MM-YYYY'), 'Aventura', 115, 'Ashley Edward Miller, Zack Stentz, Don Payne', 'Marvel Studios', NULL, NULL);
  c15 := filme_t(28, 'Eternos', TO_DATE('05-11-2021', 'DD-MM-YYYY'), 'Aventura', 156, 'Chloé Zhao, Patrick Burleigh, Ryan Firpo', 'Marvel Studios', NULL, 'Vingadores');
  c16 := filme_t(27, 'Homem-Aranha: Longe de Casa', TO_DATE('02-07-2019', 'DD-MM-YYYY'), 'Aventura', 129, 'Chris McKenna, Erik Sommers', 'Marvel Studios', NULL, 'Vingadores');
  c17 := filme_t(26, 'Vingadores: Ultimato', TO_DATE('26-04-2019', 'DD-MM-YYYY'), 'Ação', 181, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL, 'Vingadores');
  c18 := filme_t(25, 'Vingadores: Guerra Infinita', TO_DATE('27-04-2018', 'DD-MM-YYYY'), 'Ação', 149, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL, 'Vingadores');
  c19 := filme_t(24, 'Guardiões da Galáxia Vol. 2', TO_DATE('05-05-2017', 'DD-MM-YYYY'), 'Aventura', 136, 'James Gunn', 'Marvel Studios', NULL, 'Vingadores');
  c20 := filme_t(23, 'Doutor Estranho', TO_DATE('04-11-2016', 'DD-MM-YYYY'), 'Ficção Científica', 115, 'Jon Spaihts, Scott Derrickson, C. Robert Cargill', 'Marvel Studios', NULL, 'Vingadores');
  c21 := filme_t(22, 'Capitão América: Guerra Civil', TO_DATE('06-05-2016', 'DD-MM-YYYY'), 'Ação', 147, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL, 'Vingadores');
  c22 := filme_t(21, 'Vingadores: Era de Ultron', TO_DATE('01-05-2015', 'DD-MM-YYYY'), 'Ação', 141, 'Joss Whedon', 'Marvel Studios', NULL, 'Vingadores');
  c23 := filme_t(20, 'Capitão América: O Soldado Invernal', TO_DATE('04-04-2014', 'DD-MM-YYYY'), 'Aventura', 136, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL, 'Vingadores');
  c24 := filme_t(19, 'Thor: O Mundo Sombrio', TO_DATE('08-11-2013', 'DD-MM-YYYY'), 'Aventura', 112, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL, 'Vingadores');
  c25 := filme_t(18, 'Homem de Ferro 3', TO_DATE('03-05-2013', 'DD-MM-YYYY'), 'Ação', 130, 'Drew Pearce, Shane Black', 'Marvel Studios', NULL, 'Vingadores');
  c26 := filme_t(17, 'Os Vingadores', TO_DATE('04-05-2012', 'DD-MM-YYYY'), 'Ação', 143, 'Joss Whedon', 'Marvel Studios', NULL, 'Vingadores');
  c27 := filme_t(16, 'Capitão América: O Primeiro Vingador', TO_DATE('22-07-2011', 'DD-MM-YYYY'), 'Aventura', 124, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', NULL, NULL);

  -- inserir os filmes na tabela
  INSERT INTO filme_obj_tab VALUES (c1);
  INSERT INTO filme_obj_tab VALUES (c2);
  INSERT INTO filme_obj_tab VALUES (c3);
  INSERT INTO filme_obj_tab VALUES (c4);
  INSERT INTO filme_obj_tab VALUES (c5);
  INSERT INTO filme_obj_tab VALUES (c6);
  INSERT INTO filme_obj_tab VALUES (c7);
  INSERT INTO filme_obj_tab VALUES (c8);
  INSERT INTO filme_obj_tab VALUES (c9);
  INSERT INTO filme_obj_tab VALUES (c10);
  INSERT INTO filme_obj_tab VALUES (c11);
  INSERT INTO filme_obj_tab VALUES (c12);
  INSERT INTO filme_obj_tab VALUES (c13);
  INSERT INTO filme_obj_tab VALUES (c14);
  INSERT INTO filme_obj_tab VALUES (c15);
  INSERT INTO filme_obj_tab VALUES (c16);
  INSERT INTO filme_obj_tab VALUES (c17);
  INSERT INTO filme_obj_tab VALUES (c18);
  INSERT INTO filme_obj_tab VALUES (c19);
  INSERT INTO filme_obj_tab VALUES (c20);
  INSERT INTO filme_obj_tab VALUES (c21);
  INSERT INTO filme_obj_tab VALUES (c22);
  INSERT INTO filme_obj_tab VALUES (c23);
  INSERT INTO filme_obj_tab VALUES (c24);
  INSERT INTO filme_obj_tab VALUES (c25);
  INSERT INTO filme_obj_tab VALUES (c26);
  INSERT INTO filme_obj_tab VALUES (c27);

  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 28) WHERE f.id_conteudo = 27;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 27) WHERE f.id_conteudo = 26;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 26) WHERE f.id_conteudo = 25;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 25) WHERE f.id_conteudo = 24;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 24) WHERE f.id_conteudo = 23;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 23) WHERE f.id_conteudo = 22;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 22) WHERE f.id_conteudo = 21;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 21) WHERE f.id_conteudo = 20;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 20) WHERE f.id_conteudo = 19;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 19) WHERE f.id_conteudo = 18;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 18) WHERE f.id_conteudo = 17;
  UPDATE filme_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM filme_obj_tab f2 WHERE f2.id_conteudo = 17) WHERE f.id_conteudo = 16;

END;

-- SÉRIES

INSERT INTO serie_obj_tab VALUES (serie_t(1, 10, 'Breaking Bad'));
INSERT INTO serie_obj_tab VALUES (serie_t(2, 8, 'Avatar'));
INSERT INTO serie_obj_tab VALUES (serie_t(3, 10, 'Better Call Saul'));
INSERT INTO serie_obj_tab VALUES (serie_t(4, 10, 'Dark'));

-- Episódios

DECLARE
  c66 episodio_t;
  c65 episodio_t;
  c64 episodio_t;
  c63 episodio_t;
  c62 episodio_t;
  c61 episodio_t;
  c60 episodio_t;
  c59 episodio_t;
  c58 episodio_t;
  c57 episodio_t;
  c56 episodio_t;
  c55 episodio_t;
  c54 episodio_t;
  c53 episodio_t;
  c52 episodio_t;
  c51 episodio_t;
  c50 episodio_t;
  c49 episodio_t;
  c48 episodio_t;
  c47 episodio_t;
  c46 episodio_t;
  c45 episodio_t;
  c44 episodio_t;
  c43 episodio_t;
  c42 episodio_t;
  c41 episodio_t;
  c40 episodio_t;
  c39 episodio_t;
  c38 episodio_t;
  c37 episodio_t;
  c36 episodio_t;
  c35 episodio_t;
  c34 episodio_t;
  c33 episodio_t;
  c32 episodio_t;
  c31 episodio_t;
  c30 episodio_t;
  c29 episodio_t;
BEGIN
  -- inserir os episodios
  c66 := episodio_t(66, 'Dark - S01E10 - Alfa e Ômega', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 55, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c65 := episodio_t(65, 'Dark - S01E09 - Tudo é Agora', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 51, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c64 := episodio_t(64, 'Dark - S01E08 - O que se Semeia, se Colhe', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 50, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c63 := episodio_t(63, 'Dark - S01E07 - Cruzando as Linhas', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 50, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c62 := episodio_t(62, 'Dark - S01E06 - Sic Mundus Creatus Est', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 51, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c61 := episodio_t(61, 'Dark - S01E05 - Verdades', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 50, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c60 := episodio_t(60, 'Dark - S01E04 - Duplo Viver', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 48, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c59 := episodio_t(59, 'Dark - S01E03 - Passado e Presente', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 46, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c58 := episodio_t(58, 'Dark - S01E02 - Mentiras', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 45, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c57 := episodio_t(57, 'Dark - S01E01 - Segredos', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 51, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL, 1, NULL);
  c56 := episodio_t(56, 'Better Call Saul - S01E10 - Marco', TO_DATE('06-04-2015', 'DD-MM-YYYY'), 'Drama', 53, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c55 := episodio_t(55, 'Better Call Saul - S01E09 - Pimento', TO_DATE('30-03-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c54 := episodio_t(54, 'Better Call Saul - S01E08 - Rico', TO_DATE('23-03-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c53 := episodio_t(53, 'Better Call Saul - S01E07 - Bingo', TO_DATE('16-03-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c52 := episodio_t(52, 'Better Call Saul - S01E06 - Five-O', TO_DATE('09-03-2015', 'DD-MM-YYYY'), 'Drama', 43, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c51 := episodio_t(51, 'Better Call Saul - S01E05 - Alpine Shepherd Boy', TO_DATE('02-03-2015', 'DD-MM-YYYY'), 'Drama', 43, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c50 := episodio_t(50, 'Better Call Saul - S01E04 - Hero', TO_DATE('23-02-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c49 := episodio_t(49, 'Better Call Saul - S01E03 - Nacho', TO_DATE('16-02-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c48 := episodio_t(48, 'Better Call Saul - S01E02 - Mijo', TO_DATE('09-02-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c47 := episodio_t(47, 'Better Call Saul - S01E01 - Uno', TO_DATE('08-02-2015', 'DD-MM-YYYY'), 'Drama', 53, 'Vince Gilligan, Peter Gould', 'AMC', NULL, 1, NULL);
  c46 := episodio_t(46, 'Avatar - S02E04 - O Pântano', TO_DATE('07-04-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 2, NULL);
  c45 := episodio_t(45, 'Avatar - S02E03 - O Retorno para Omashu', TO_DATE('31-03-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 2, NULL);
  c44 := episodio_t(44, 'Avatar - S02E02 - A Caverna dos Amantes', TO_DATE('24-03-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 2, NULL);
  c43 := episodio_t(43, 'Avatar - S02E01 - O Estado Avatar', TO_DATE('17-03-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 2, NULL);
  c42 := episodio_t(42, 'Avatar - S01E04 - Os Guerreiros de Kyoshi', TO_DATE('04-03-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 1, NULL);
  c41 := episodio_t(41, 'Avatar - S01E03 - O Templo do Ar do Sul', TO_DATE('25-02-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 1, NULL);
  c40 := episodio_t(40, 'Avatar - S01E02 - O Retorno do Avatar', TO_DATE('21-02-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 1, NULL);
  c39 := episodio_t(39, 'Avatar - S01E01 - O Garoto no Iceberg', TO_DATE('21-02-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL, 1, NULL);
  c38 := episodio_t(38, 'Breaking Bad - S02E05 - Breakage', TO_DATE('05-04-2009', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', NULL, 2, NULL);
  c37 := episodio_t(37, 'Breaking Bad - S02E04 - Down', TO_DATE('29-03-2009', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', NULL, 2, NULL);
  c36 := episodio_t(36, 'Breaking Bad - S02E03 - Bit by a Dead Bee', TO_DATE('22-03-2009', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', NULL, 2, NULL);
  c35 := episodio_t(35, 'Breaking Bad - S02E02 - Grilled', TO_DATE('15-03-2009', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', NULL, 2, NULL);
  c34 := episodio_t(34, 'Breaking Bad - S02E01 - Seven Thirty-Seven', TO_DATE('08-03-2009', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', NULL, 2, NULL);
  c33 := episodio_t(33, 'Breaking Bad - S01E05 - Gray Matter', TO_DATE('24-02-2008', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', NULL, 1, NULL);
  c32 := episodio_t(32, 'Breaking Bad - S01E04 - Cancer Man', TO_DATE('17-02-2008', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', NULL, 1, NULL);
  c31 := episodio_t(31, 'Breaking Bad - S01E03 - ...And the Bag''s in the River', TO_DATE('10-02-2008', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', NULL, 1, NULL);
  c30 := episodio_t(30, 'Breaking Bad - S01E02 - Cat''s in the Bag...', TO_DATE('27-01-2008', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', NULL, 1, NULL);
  c29 := episodio_t(29, 'Breaking Bad - S01E01 - Pilot', TO_DATE('20-01-2008', 'DD-MM-YYYY'), 'Drama', 58, 'Vince Gilligan', 'Sony Pictures Television', NULL, 1, NULL);

  -- inserir os episodios na tabela
  INSERT INTO episodio_obj_tab VALUES (c66);
  INSERT INTO episodio_obj_tab VALUES (c65);
  INSERT INTO episodio_obj_tab VALUES (c64);
  INSERT INTO episodio_obj_tab VALUES (c63);
  INSERT INTO episodio_obj_tab VALUES (c62);
  INSERT INTO episodio_obj_tab VALUES (c61);
  INSERT INTO episodio_obj_tab VALUES (c60);
  INSERT INTO episodio_obj_tab VALUES (c59);
  INSERT INTO episodio_obj_tab VALUES (c58);
  INSERT INTO episodio_obj_tab VALUES (c57);
  INSERT INTO episodio_obj_tab VALUES (c56);
  INSERT INTO episodio_obj_tab VALUES (c55);
  INSERT INTO episodio_obj_tab VALUES (c54);
  INSERT INTO episodio_obj_tab VALUES (c53);
  INSERT INTO episodio_obj_tab VALUES (c52);
  INSERT INTO episodio_obj_tab VALUES (c51);
  INSERT INTO episodio_obj_tab VALUES (c50);
  INSERT INTO episodio_obj_tab VALUES (c49);
  INSERT INTO episodio_obj_tab VALUES (c48);
  INSERT INTO episodio_obj_tab VALUES (c47);
  INSERT INTO episodio_obj_tab VALUES (c46);
  INSERT INTO episodio_obj_tab VALUES (c45);
  INSERT INTO episodio_obj_tab VALUES (c44);
  INSERT INTO episodio_obj_tab VALUES (c43);
  INSERT INTO episodio_obj_tab VALUES (c42);
  INSERT INTO episodio_obj_tab VALUES (c41);
  INSERT INTO episodio_obj_tab VALUES (c40);
  INSERT INTO episodio_obj_tab VALUES (c39);
  INSERT INTO episodio_obj_tab VALUES (c38);
  INSERT INTO episodio_obj_tab VALUES (c37);
  INSERT INTO episodio_obj_tab VALUES (c36);
  INSERT INTO episodio_obj_tab VALUES (c35);
  INSERT INTO episodio_obj_tab VALUES (c34);
  INSERT INTO episodio_obj_tab VALUES (c33);
  INSERT INTO episodio_obj_tab VALUES (c32);
  INSERT INTO episodio_obj_tab VALUES (c31);
  INSERT INTO episodio_obj_tab VALUES (c30);
  INSERT INTO episodio_obj_tab VALUES (c29);

  -- inserir sucessores dos episodios

  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 66) WHERE f.id_conteudo = 65;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 65) WHERE f.id_conteudo = 64;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 64) WHERE f.id_conteudo = 63;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 63) WHERE f.id_conteudo = 62;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 62) WHERE f.id_conteudo = 61;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 61) WHERE f.id_conteudo = 60;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 60) WHERE f.id_conteudo = 59;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 59) WHERE f.id_conteudo = 58;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 58) WHERE f.id_conteudo = 57;
  
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 56) WHERE f.id_conteudo = 55;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 55) WHERE f.id_conteudo = 54;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 54) WHERE f.id_conteudo = 53;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 53) WHERE f.id_conteudo = 52;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 52) WHERE f.id_conteudo = 51;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 51) WHERE f.id_conteudo = 50;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 50) WHERE f.id_conteudo = 49;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 49) WHERE f.id_conteudo = 48;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 48) WHERE f.id_conteudo = 47;
  
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 46) WHERE f.id_conteudo = 45;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 45) WHERE f.id_conteudo = 44;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 44) WHERE f.id_conteudo = 43;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 43) WHERE f.id_conteudo = 42;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 42) WHERE f.id_conteudo = 41;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 41) WHERE f.id_conteudo = 40;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 40) WHERE f.id_conteudo = 39;
  
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 38) WHERE f.id_conteudo = 37;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 37) WHERE f.id_conteudo = 36;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 36) WHERE f.id_conteudo = 35;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 35) WHERE f.id_conteudo = 34;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 34) WHERE f.id_conteudo = 33;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 33) WHERE f.id_conteudo = 32;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 32) WHERE f.id_conteudo = 31;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 31) WHERE f.id_conteudo = 30;
  UPDATE episodio_obj_tab f SET f.sucessor = (SELECT REF(f2) FROM episodio_obj_tab f2 WHERE f2.id_conteudo = 30) WHERE f.id_conteudo = 29;


  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 66;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 66;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 65;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 64;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 63;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 62;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 61;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 60;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 59;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 58;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 4) WHERE f.id_conteudo = 57;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 56;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 55;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 54;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 53;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 52;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 51;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 50;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 49;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 48;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 3) WHERE f.id_conteudo = 47;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 46;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 45;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 44;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 43;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 42;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 41;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 40;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 2) WHERE f.id_conteudo = 39;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 38;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 37;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 36;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 35;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 34;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 33;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 32;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 31;
  UPDATE episodio_obj_tab f SET f.serie_pertencente = (SELECT REF(s) FROM serie_obj_tab s WHERE s.id_serie = 1) WHERE f.id_conteudo = 30;
END;


INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(1, 5, TO_TIMESTAMP('01-01-2024 14:30:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(2, 4, TO_TIMESTAMP('02-01-2024 16:45:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(3, 3, TO_TIMESTAMP('03-01-2024 12:15:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(4, 5, TO_TIMESTAMP('04-01-2024 18:20:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(5, 2, TO_TIMESTAMP('05-01-2024 10:00:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(6, 4, TO_TIMESTAMP('06-01-2024 20:10:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(7, 1, TO_TIMESTAMP('07-01-2024 09:30:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(8, 5, TO_TIMESTAMP('08-01-2024 14:50:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(9, 3, TO_TIMESTAMP('09-01-2024 11:40:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(10, 2, TO_TIMESTAMP('10-01-2024 22:05:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(11, 5, TO_TIMESTAMP('11-01-2024 13:25:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(12, 4, TO_TIMESTAMP('12-01-2024 17:35:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(13, 1, TO_TIMESTAMP('13-01-2024 08:20:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(14, 3, TO_TIMESTAMP('14-01-2024 15:45:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(15, 4, TO_TIMESTAMP('15-01-2024 19:55:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(16, 2, TO_TIMESTAMP('16-01-2024 10:10:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(17, 5, TO_TIMESTAMP('17-01-2024 21:20:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(18, 3, TO_TIMESTAMP('18-01-2024 07:45:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(19, 1, TO_TIMESTAMP('19-01-2024 16:30:00', 'DD-MM-YYYY HH24:MI:SS')));
INSERT INTO avaliacao_obj_tab VALUES (avaliacao_t(20, 4, TO_TIMESTAMP('20-01-2024 12:00:00', 'DD-MM-YYYY HH24:MI:SS')));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(1, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));
INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(2, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(3, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(4, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(5, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(6, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(7, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(8, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(10, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(11, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(12, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(13, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(14, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(15, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(16, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(17, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(18, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(19, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(20, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(21, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(22, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(23, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(24, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(25, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(26, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(27, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(28, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));


INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(1, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(2, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(3, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(4, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(5, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(6, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(7, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(8, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(10, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(11, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(12, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(13, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(14, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(15, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(16, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(17, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(18, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(19, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(20, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(21, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(22, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(23, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(24, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(25, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(26, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(27, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(28, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));


INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(1, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(2, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(3, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(4, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(5, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(6, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(7, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(8, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(10, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(11, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(12, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(13, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(14, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(15, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(16, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(17, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(18, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(19, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(20, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(21, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(22, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(23, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(24, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(25, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(26, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(27, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(28, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(1, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(2, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(3, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(4, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(5, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(6, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(7, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(8, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(10, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(11, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(12, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(13, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(14, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(15, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(16, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(17, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(18, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(19, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(20, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(21, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(22, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(23, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(24, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(25, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(26, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(27, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(28, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(1, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(2, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(3, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(4, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(5, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(6, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(7, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(8, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(10, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(11, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(12, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(13, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(14, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(15, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(16, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(17, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(18, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(19, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(20, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(21, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(22, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(23, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(24, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(25, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(26, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(27, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_filme_obj_tab VALUES (plano_permite_filme_t(28, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(29, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(30, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(31, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(32, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(33, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(34, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(35, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(36, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(37, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(38, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(39, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(40, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(41, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(42, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(43, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(44, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(45, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(46, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(47, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(48, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(49, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(50, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(51, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(52, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(53, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(54, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(55, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(56, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(57, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(58, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(59, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(60, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(61, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(62, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(63, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(64, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(65, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(66, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(29, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(30, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(31, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(32, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(33, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(34, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(35, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(36, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(37, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(38, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(39, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(40, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(41, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(42, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(43, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(44, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(45, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(46, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(47, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(48, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(49, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(50, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(51, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(52, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(53, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(54, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(55, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(56, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(57, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(58, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(59, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(60, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(61, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(62, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(63, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(64, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(65, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(66, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(29, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(30, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(31, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(32, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(33, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(34, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(35, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(36, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(37, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(38, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(39, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(40, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(41, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(42, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(43, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(44, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(45, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(46, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(47, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(48, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(49, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(50, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(51, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(52, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(53, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(54, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(55, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(56, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(57, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(58, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(59, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(60, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(61, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(62, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(63, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(64, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(65, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(66, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(29, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(30, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(31, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(32, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(33, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(34, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(35, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(36, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(37, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(38, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(39, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(40, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(41, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(42, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(43, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(44, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(45, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(46, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(47, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(48, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(49, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(50, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(51, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(52, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(53, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(54, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(55, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(56, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(57, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(58, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(59, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(60, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(61, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(62, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(63, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(64, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(65, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(66, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(29, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(30, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(31, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(32, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(33, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(34, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(35, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(36, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(37, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(38, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(39, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(40, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(41, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(42, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(43, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(44, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(45, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(46, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(47, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(48, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(49, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(50, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(51, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(52, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(53, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(54, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(55, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(56, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(57, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(58, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(59, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(60, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(61, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(62, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(63, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(64, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(65, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

INSERT INTO plano_permite_episodio_obj_tab VALUES (plano_permite_episodio_t(66, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL));

    
DECLARE
    v_avaliacao_ref_1 REF avaliacao_t;
    v_avaliacao_ref_2 REF avaliacao_t;
    v_avaliacao_ref_3 REF avaliacao_t;
    v_avaliacao_ref_4 REF avaliacao_t;
    v_avaliacao_ref_5 REF avaliacao_t;
    v_avaliacao_ref_6 REF avaliacao_t;
    v_avaliacao_ref_7 REF avaliacao_t;
    v_avaliacao_ref_8 REF avaliacao_t;
    v_avaliacao_ref_9 REF avaliacao_t;
    v_avaliacao_ref_10 REF avaliacao_t;
    v_avaliacao_ref_11 REF avaliacao_t;
    v_avaliacao_ref_12 REF avaliacao_t;
    v_avaliacao_ref_13 REF avaliacao_t;
    v_avaliacao_ref_14 REF avaliacao_t;
BEGIN
    -- buscar os REFs das avaliações
    SELECT REF(a) INTO v_avaliacao_ref_1 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 5;
    SELECT REF(a) INTO v_avaliacao_ref_2 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 12;
    SELECT REF(a) INTO v_avaliacao_ref_3 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 8;
    SELECT REF(a) INTO v_avaliacao_ref_4 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 3;
    SELECT REF(a) INTO v_avaliacao_ref_5 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 15;
    SELECT REF(a) INTO v_avaliacao_ref_6 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 7;
    SELECT REF(a) INTO v_avaliacao_ref_7 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 18;
    SELECT REF(a) INTO v_avaliacao_ref_8 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 11;
    SELECT REF(a) INTO v_avaliacao_ref_9 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 2;
    SELECT REF(a) INTO v_avaliacao_ref_10 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 20;
    SELECT REF(a) INTO v_avaliacao_ref_11 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 6;
    SELECT REF(a) INTO v_avaliacao_ref_12 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 1;
    SELECT REF(a) INTO v_avaliacao_ref_13 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 14;

    -- inserir os registros na tabela
    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(1, 1, 'jose.silva@email.com', TO_TIMESTAMP('01/02/2025 14:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 75, v_avaliacao_ref_1)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(2, 2, 'jose.silva@email.com', TO_TIMESTAMP('02/02/2025 16:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 50, v_avaliacao_ref_2)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(3, 3, 'maria.santos@email.com', TO_TIMESTAMP('03/02/2025 12:15:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 80, v_avaliacao_ref_3)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(4, 4, 'maria.santos@email.com', TO_TIMESTAMP('04/02/2025 18:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 95, v_avaliacao_ref_4)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(5, 5, 'maria.santos@email.com', TO_TIMESTAMP('05/02/2025 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 60, v_avaliacao_ref_5)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(6, 6, 'pedro.oliveira@email.com', TO_TIMESTAMP('06/02/2025 20:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 40, v_avaliacao_ref_6)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(7, 7, 'pedro.oliveira@email.com', TO_TIMESTAMP('07/02/2025 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 90, v_avaliacao_ref_7)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(8, 8, 'ana.pereira@email.com', TO_TIMESTAMP('08/02/2025 14:50:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 85, v_avaliacao_ref_8)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(10, 9, 'ana.pereira@email.com', TO_TIMESTAMP('09/02/2025 11:40:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 55, v_avaliacao_ref_9)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(12, 10, 'ana.pereira@email.com', TO_TIMESTAMP('10/02/2025 22:05:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 35, v_avaliacao_ref_10)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(15, 11, 'lucas.rodrigues@email.com', TO_TIMESTAMP('11/02/2025 13:25:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 70, v_avaliacao_ref_11)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(25, 1, 'jose.silva@email.com', TO_TIMESTAMP('13/02/2025 08:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 45, v_avaliacao_ref_12)
    );

    INSERT INTO perfil_consome_filme_obj_tab VALUES (
        perfil_consome_filme_t(20, 11, 'lucas.rodrigues@email.com', TO_TIMESTAMP('12/02/2025 17:35:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 80, v_avaliacao_ref_13)
    );

    COMMIT;
END;
/


SELECT p.id_filme FROM perfil_consome_filme_obj_tab p;

DECLARE
    v_avaliacao_ref_15 REF avaliacao_t;
    v_avaliacao_ref_16 REF avaliacao_t;
    v_avaliacao_ref_17 REF avaliacao_t;
    v_avaliacao_ref_18 REF avaliacao_t;
    v_avaliacao_ref_19 REF avaliacao_t;
    v_avaliacao_ref_20 REF avaliacao_t;
    v_avaliacao_ref_21 REF avaliacao_t;
BEGIN
    -- buscar os REFs das avaliações
    SELECT REF(a) INTO v_avaliacao_ref_15 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 9;
    SELECT REF(a) INTO v_avaliacao_ref_16 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 10;
    SELECT REF(a) INTO v_avaliacao_ref_17 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 13;
    SELECT REF(a) INTO v_avaliacao_ref_18 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 4;
    SELECT REF(a) INTO v_avaliacao_ref_19 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 16;
    SELECT REF(a) INTO v_avaliacao_ref_20 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 19;
    SELECT REF(a) INTO v_avaliacao_ref_21 FROM avaliacao_obj_tab a WHERE a.id_avaliacao = 17;

    -- inserir os registros na tabela
    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(30, 2, 'jose.silva@email.com', TO_TIMESTAMP('14/02/2025 15:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 50, v_avaliacao_ref_15)
    );

    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(35, 3, 'maria.santos@email.com', TO_TIMESTAMP('15/02/2025 19:55:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 95, v_avaliacao_ref_16)
    );

    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(40, 4, 'maria.santos@email.com', TO_TIMESTAMP('16/02/2025 10:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 85, v_avaliacao_ref_17)
    );

    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(45, 5, 'maria.santos@email.com', TO_TIMESTAMP('17/02/2025 21:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 20, v_avaliacao_ref_18)
    );

    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(50, 6, 'pedro.oliveira@email.com', TO_TIMESTAMP('18/02/2025 07:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 75, v_avaliacao_ref_19)
    );

    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(55, 7, 'pedro.oliveira@email.com', TO_TIMESTAMP('19/02/2025 16:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 90, v_avaliacao_ref_20)
    );

    INSERT INTO perfil_consome_episodio_obj_tab VALUES (
        perfil_consome_episodio_t(60, 8, 'ana.pereira@email.com', TO_TIMESTAMP('20/02/2025 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 65, v_avaliacao_ref_21)
    );

    COMMIT;
END;
