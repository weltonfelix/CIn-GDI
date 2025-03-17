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
CREATE OR REPLACE TYPE perfil_t AS OBJECT (
    id_perfil    NUMBER,
    conta_email  VARCHAR2(255), -- se botar REF não tem como colocar como chave primária
    apelido      VARCHAR2(30),
    tipo         VARCHAR2(50),
    data_criacao DATE
) NOT FINAL NOT INSTANTIABLE;
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
    FINAL MEMBER FUNCTION status_avaliacao RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY avaliacao_t AS 
    MEMBER FUNCTION status_avaliacao RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Qualidade: ' || TO_CHAR(qualidade);
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
    FINAL MEMBER FUNCTION descricao RETURN VARCHAR2
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
    MEMBER FUNCTION detalhes RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY filme_t AS 
    MEMBER FUNCTION detalhes RETURN VARCHAR2 IS
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
    avaliacao           REF avaliacao_t,
    FINAL MEMBER FUNCTION consumo_info RETURN VARCHAR2
) FINAL;
/

CREATE OR REPLACE TYPE BODY perfil_consome_conteudo_t AS 
    MEMBER FUNCTION consumo_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Consumo registrado em ' || TO_CHAR(data_hora, 'DD/MM/YYYY HH24:MI');
    END;
END;
/

CREATE TABLE plano_obj_tab OF plano_t (
    PRIMARY KEY id_plano,
    nome NOT NULL,
    preco NOT NULL,
    tempo_fidelidade_meses NOT NULL
);


CREATE TABLE conta_obj_tab OF conta_t (
    PRIMARY KEY email,
    primeiro_nome NOT NULL,
    senha NOT NULL
);


CREATE TABLE perfil_obj_tab OF perfil_t (
    PRIMARY KEY (id_perfil, conta_email), -- com REF conta não vai
    FOREIGN KEY (conta_email) REFERENCES conta_obj_tab(email),
    tipo NOT NULL,
    data_criacao NOT NULL,
    CONSTRAINT tipos_possiveis CHECK (tipo IN ('Infantil', 'Livre'))
);


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

CREATE TABLE serie_obj_tab OF serie_t (
    PRIMARY KEY (id_serie),
    numero_episodios NOT NULL,
    nome NOT NULL
);

CREATE TABLE episodio_obj_tab OF episodio_t (
    PRIMARY KEY (id_conteudo),
    temporada NOT NULL,
    serie_pertencente NOT NULL
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
    FOREIGN KEY (id_perfil) REFERENCES perfil_obj_tab(id_perfil),
    FOREIGN KEY (email) REFERENCES conta_obj_tab(email)
);
