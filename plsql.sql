-- Imprime no console todos os conteúdos do gênero ação
DECLARE
    TYPE t_conteudos IS TABLE OF Conteudo%ROWTYPE INDEX BY BINARY_INTEGER;
    v_conteudos t_conteudos;
    v_index BINARY_INTEGER := 1;
    v_rec Conteudo%ROWTYPE; -- Record

BEGIN
    FOR r IN (SELECT * FROM Conteudo WHERE genero = 'Ação') LOOP
        v_conteudos(v_index) := r;
        v_index := v_index + 1;
    END LOOP;

    v_index := v_conteudos.FIRST;
    WHILE v_index IS NOT NULL LOOP
        v_rec := v_conteudos(v_index);
        DBMS_OUTPUT.PUT_LINE('Conteúdo: ' || v_rec.nome || ' - Gênero: ' || v_rec.genero);
        v_index := v_conteudos.NEXT(v_index);
    END LOOP;
END;
/


-- Conta o número de avaliações de um conteúdo
CREATE OR REPLACE PROCEDURE contar_avaliacoes (
    p_id_conteudo IN Conteudo.id_conteudo%TYPE,
    p_total OUT NUMBER
) AS
BEGIN
    SELECT COUNT(*) INTO p_total 
    FROM PerfilConsomeConteudo 
    WHERE id_conteudo = p_id_conteudo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_total := 0;
    WHEN OTHERS THEN
        p_total := -1;
END contar_avaliacoes;
/

DECLARE
    v_total NUMBER;
BEGIN
    contar_avaliacoes(8, v_total);
    DBMS_OUTPUT.PUT_LINE('Total de avaliações: ' || v_total);
END;
/


-- Lista os conteúdos, mostra o ID e o Nome
DECLARE
    CURSOR cur_conteudos IS SELECT id_conteudo, nome FROM Conteudo;
    v_conteudo cur_conteudos%ROWTYPE;
BEGIN
    OPEN cur_conteudos;
    LOOP
        FETCH cur_conteudos INTO v_conteudo;
        EXIT WHEN cur_conteudos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_conteudo.id_conteudo || ' - Nome: ' || v_conteudo.nome);
    END LOOP;
    CLOSE cur_conteudos;
END;
/

--  Classifica os planos com base no preço
DECLARE
    v_id NUMBER := 1;
    v_preco Plano.preco%TYPE;
   	v_limiar_barato NUMBER := 20;
	v_limiar_intermediario NUMBER := 39.99;
   	v_max_id Plano.id_plano%TYPE;
BEGIN
	SELECT MAX(id_plano) INTO v_max_id FROM Plano;
	
    WHILE v_id <= v_max_id LOOP
        SELECT preco INTO v_preco FROM Plano WHERE id_plano = v_id;
        IF v_preco < v_limiar_barato THEN
            DBMS_OUTPUT.PUT_LINE('Plano barato: ' || v_preco);
        ELSIF v_preco BETWEEN v_limiar_barato AND v_limiar_intermediario THEN
            DBMS_OUTPUT.PUT_LINE('Plano intermediário: ' || v_preco);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Plano premium: ' || v_preco);
        END IF;

        v_id := v_id + 1;
    END LOOP;
END;
/

-- package para criar perfis após contas
CREATE OR REPLACE PACKAGE perfil_manager AS
    PROCEDURE criar_perfil(p_email IN Perfil.conta_email%TYPE, p_apelido IN Perfil.apelido%TYPE, p_tipo IN Perfil.tipo%TYPE);
	PROCEDURE criar_conta(p_email IN Conta.email%TYPE, p_primeiro_nome IN Conta.primeiro_nome%TYPE, p_sobrenome IN Conta.sobrenome%TYPE,p_senha IN Conta.senha%TYPE);
    FUNCTION contar_perfis(p_email IN Perfil.conta_email%TYPE) RETURN NUMBER;
END perfil_manager;
/

CREATE OR REPLACE PACKAGE BODY perfil_manager AS
    PROCEDURE criar_perfil(p_email IN Perfil.conta_email%TYPE, p_apelido IN Perfil.apelido%TYPE, p_tipo IN Perfil.tipo%TYPE) AS
    BEGIN
        INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
        VALUES ((SELECT NVL(MAX(id_perfil),0) + 1 FROM Perfil WHERE conta_email = p_email), p_email, p_apelido, p_tipo, SYSDATE);
    END criar_perfil;
   
   PROCEDURE criar_conta(p_email IN Conta.email%TYPE, p_primeiro_nome IN Conta.primeiro_nome%TYPE, p_sobrenome IN Conta.sobrenome%TYPE,p_senha IN Conta.senha%TYPE) AS
	BEGIN
	    INSERT INTO Conta
	    VALUES (p_email, p_primeiro_nome, p_sobrenome, p_senha);
	END criar_conta;

    FUNCTION contar_perfis(p_email IN Perfil.conta_email%TYPE) RETURN NUMBER AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Perfil WHERE conta_email = p_email;
        RETURN v_count;
    END contar_perfis;
END perfil_manager;
/

BEGIN
	perfil_manager.criar_conta('email@teste.com', 'Rolando', 'Escadabaixo', '123');
    perfil_manager.criar_perfil('email@teste.com', 'User1', 'Livre');
    
    DBMS_OUTPUT.PUT_LINE('Total de perfis: ' || perfil_manager.contar_perfis('email@teste.com'));
END;
/

-- Cria um perfil para o titular da conta automaticamente

CREATE OR REPLACE TRIGGER NovaConta
AFTER INSERT ON Conta
FOR EACH ROW
BEGIN
    perfil_manager.criar_perfil(:NEW.email, :NEW.primeiro_nome || ' ' || :NEW.sobrenome, 'Livre');
    DBMS_OUTPUT.PUT_LINE('Nova conta criada: ' || :NEW.email);
   	DBMS_OUTPUT.PUT_LINE('Perfil criado para conta: ' || :NEW.primeiro_nome);
   
END NovaConta;
/


-- exibe quantos planos existem após criar plano.

CREATE OR REPLACE TRIGGER trg_registrar_insercao_plano
AFTER INSERT ON Plano
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Plano;

    DBMS_OUTPUT.PUT_LINE('Novo plano inserido. Agora há ' || v_count || ' planos no sistema.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/

-- categoriza um conteúdo em ação ou comédia (curtos ou longos), dramas ou outros

DECLARE
    v_id_conteudo NUMBER := 13;
    v_genero Conteudo.genero%TYPE;
    v_duracao Conteudo.duracao_minutos%TYPE;
    v_categoria VARCHAR2(30);
BEGIN
    SELECT genero, duracao_minutos INTO v_genero, v_duracao 
    FROM Conteudo 
    WHERE id_conteudo = v_id_conteudo;

    CASE
        WHEN v_genero = 'Ação' AND v_duracao < 90 THEN
            v_categoria := 'Ação curta';
        WHEN v_genero = 'Ação' AND v_duracao >= 90 THEN
            v_categoria := 'Ação longa';
        WHEN v_genero = 'Comédia' AND v_duracao < 60 THEN
            v_categoria := 'Comédia curta';
        WHEN v_genero = 'Comédia' AND v_duracao >= 60 THEN
            v_categoria := 'Comédia longa';
        WHEN v_genero = 'Drama' THEN
            v_categoria := 'Drama';
        ELSE
            v_categoria := 'Outro';
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Categoria do conteúdo: ' || v_categoria);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Conteúdo não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/

