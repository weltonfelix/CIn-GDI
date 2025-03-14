---------------------------------------------------------------------
-- 1. Tipo Plano (final, pois não esperamos herança) 
---------------------------------------------------------------------
CREATE OR REPLACE TYPE plano_t AS OBJECT (
    id_plano              NUMBER,
    nome                  VARCHAR2(20),
    preco                 NUMBER(5,2),
    tempo_fidelidade_meses NUMBER,
    FINAL MEMBER FUNCTION exibir_detalhes RETURN VARCHAR2
)
FINAL;
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
)
FINAL;
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
)
NOT FINAL;  -- Permite herança se necessário
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
CREATE OR REPLACE TYPE perfil_t AS OBJECT ( -- UNDER OBJECT
    id_perfil    NUMBER,
    conta        REF conta_t,
    apelido      VARCHAR2(30),
    tipo         VARCHAR2(50),
    data_criacao DATE
)
NOT FINAL NOT INSTANTIABLE
;
/

/*CREATE OR REPLACE TYPE BODY perfil_t AS 
    MEMBER FUNCTION get_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Perfil: ' || apelido || ' (' || tipo || ')';
    END;
END;
/
*/

---------------------------------------------------------------------
-- 5. Tipo Avaliacao 
---------------------------------------------------------------------
CREATE OR REPLACE TYPE avaliacao_t AS OBJECT (
    id_avaliacao NUMBER,
    qualidade    NUMBER,
    data_hora    TIMESTAMP,
    FINAL MEMBER FUNCTION status_avaliacao RETURN VARCHAR2
)
FINAL;
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
)
NOT FINAL;
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
    FINAL MEMBER FUNCTION get_categoria RETURN VARCHAR2
)
NOT FINAL;
/

CREATE OR REPLACE TYPE BODY filme_t AS 
    MEMBER FUNCTION get_categoria RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Filme';
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
)
FINAL;
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
)
FINAL;
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
    conteudo          REF conteudo_t,
    plano             REF plano_t,
    conta             REF conta_t,
    data_inicio       DATE,
    data_fim          DATE,
    desconto_aplicado NUMBER(5,2),
    FINAL MEMBER FUNCTION periodo RETURN VARCHAR2
)
FINAL;
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
CREATE OR REPLACE TYPE perfil_consume_conteudo_t AS OBJECT (
    conteudo            REF conteudo_t,
    perfil              REF perfil_t,
    conta               REF conta_t, -- talvez tirar conta
    data_hora           TIMESTAMP,
    dispositivo_utilizado VARCHAR2(100),
    progresso_percentual NUMBER,
    avaliacao           REF avaliacao_t,
    FINAL MEMBER FUNCTION consumo_info RETURN VARCHAR2
)
FINAL;
/

CREATE OR REPLACE TYPE BODY perfil_consume_conteudo_t AS 
    MEMBER FUNCTION consumo_info RETURN VARCHAR2 IS
    BEGIN
       RETURN 'Consumo registrado em ' || TO_CHAR(data_hora, 'DD/MM/YYYY HH24:MI');
    END;
END;
/

CREATE TABLE plano_obj_tab OF plano_t
  (id_plano PRIMARY KEY);


CREATE TABLE conta_obj_tab OF conta_t
  (PRIMARY KEY (email));


CREATE TABLE perfil_obj_tab OF perfil_t
  (PRIMARY KEY (id_perfil, conta_email));


CREATE TABLE avaliacao_obj_tab OF avaliacao_t
  (PRIMARY KEY (id_avaliacao));


CREATE TABLE conteudo_obj_tab OF conteudo_t
  (PRIMARY KEY (id_conteudo));

CREATE TABLE filme_obj_tab OF filme_t
  (PRIMARY KEY (id_conteudo));

CREATE TABLE serie_obj_tab OF serie_t
  (PRIMARY KEY (id_serie));


CREATE TABLE episodio_obj_tab OF episodio_t
  (PRIMARY KEY (id_conteudo));

CREATE TABLE plano_permite_conteudo_obj_tab OF plano_permite_conteudo_t
  (PRIMARY KEY (id_conteudo, id_plano, email));

CREATE TABLE perfil_consume_conteudo_obj_tab OF perfil_consume_conteudo_t
  (PRIMARY KEY (id_conteudo, perfil, conta, data_hora));
