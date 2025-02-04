-- CRIAÇÃO DAS TABELAS --
-- Plano
CREATE SEQUENCE plano_id_seq;
CREATE TABLE Plano(   
    id_plano INT NOT NULL,   
    nome VARCHAR(20) NOT NULL,   
    preco DECIMAL(5,2) NOT NULL,   
    tempo_fidelidade_meses INTEGER NOT NULL,   
    CONSTRAINT plano_pkey PRIMARY KEY (id_plano)  
);

-- Conta
CREATE TABLE Conta ( 
    email VARCHAR2(255) NOT NULL, 
    primeiro_nome VARCHAR2(30) NOT NULL, 
    sobrenome VARCHAR2(30), 
    senha VARCHAR2(40) NOT NULL, 
    CONSTRAINT conta_pkey PRIMARY KEY (email) 
);

-- Perfil
CREATE SEQUENCE perfil_id_seq;
CREATE TABLE Perfil ( 
    id_perfil NUMBER NOT NULL, 
    conta_email VARCHAR2(255) NOT NULL, 
    apelido VARCHAR2(30), 
    tipo VARCHAR2(50) NOT NULL, 
    data_criacao DATE NOT NULL, 
    CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil, conta_email), 
    CONSTRAINT perfil_conta_fkey FOREIGN KEY (conta_email) REFERENCES Conta(email), 
    CONSTRAINT tipos_possiveis CHECK (tipo IN ('Infantil', 'Livre')) 
);

-- Avaliação
CREATE SEQUENCE id_avaliacao_seq;
CREATE TABLE Avaliacao ( 
    id_avaliacao NUMBER NOT NULL, 
    qualidade NUMBER NOT NULL, 
    data_hora TIMESTAMP NOT NULL, 
    CONSTRAINT avaliacao_pkey PRIMARY KEY (id_avaliacao), 
	CONSTRAINT intervalo_valido_qualidade CHECK (qualidade BETWEEN 1 AND 5) 
);

-- Conteúdo
CREATE SEQUENCE id_conteudo_seq;
CREATE TABLE Conteudo ( 
    id_conteudo NUMBER NOT NULL, 
    nome VARCHAR2(100) NOT NULL, 
    data_lancamento DATE NOT NULL, 
    genero VARCHAR2(30), 
    duracao_minutos NUMBER, 
    roteiro VARCHAR2(255), 
    producao VARCHAR2(255), 
    id_sucessor NUMBER, 
    CONSTRAINT conteudo_pkey PRIMARY KEY (id_conteudo), 
    CONSTRAINT conteudo_sucessor_fkey FOREIGN KEY (id_sucessor) REFERENCES Conteudo(id_conteudo) 
);

-- Filme
CREATE TABLE Filme ( 
    id_conteudo NUMBER NOT NULL, 
    nome_sequencia VARCHAR2(255) NOT NULL, 
    CONSTRAINT filme_pkey PRIMARY KEY (id_conteudo), 
    CONSTRAINT filme_conteudo_fkey FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo) 
);

-- Série
CREATE SEQUENCE id_serie_seq;
CREATE TABLE Serie ( 
    id_serie NUMBER NOT NULL, 
    numero_episodios NUMBER NOT NULL, 
    nome VARCHAR2(255) NOT NULL, 
    CONSTRAINT serie_pkey PRIMARY KEY (id_serie) 
);

-- Episódio
CREATE TABLE Episodio ( 
    id_conteudo NUMBER NOT NULL, 
    temporada NUMBER NOT NULL, 
    serie_pertencente NUMBER NOT NULL, 
    CONSTRAINT episodio_pkey PRIMARY KEY (id_conteudo), 
    CONSTRAINT episodio_conteudo_fkey FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo), 
    CONSTRAINT episodio_serie_fkey FOREIGN KEY (serie_pertencente) REFERENCES Serie(id_serie) 
);

-- Plano Permite Conteúdo (a uma conta)
CREATE TABLE PlanoPermiteConteudo ( 
    id_conteudo NUMBER NOT NULL, 
    id_plano NUMBER NOT NULL, 
    email VARCHAR2(255) NOT NULL, 
    data_inicio DATE NOT NULL, 
    data_fim DATE, 
    desconto_aplicado NUMBER(5,2), 
    CONSTRAINT permite_pkey PRIMARY KEY (id_conteudo, id_plano, email), 
    CONSTRAINT permite_conteudo_fkey FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo), 
    CONSTRAINT permite_plano_fkey FOREIGN KEY (id_plano) REFERENCES Plano(id_plano), 
    CONSTRAINT permite_conta_fkey FOREIGN KEY (email) REFERENCES Conta(email) 
);

-- Perfil Consome Conteúdo
CREATE TABLE PerfilConsomeConteudo ( 
    id_conteudo NUMBER NOT NULL, 
    perfil NUMBER NOT NULL, 
    conta VARCHAR2(255) NOT NULL, 
    data_hora TIMESTAMP NOT NULL, 
    dispositivo_utilizado VARCHAR2(100), 
    progresso_percentual NUMBER, 
    id_avaliacao NUMBER, 
    CONSTRAINT consome_pkey PRIMARY KEY (id_conteudo, perfil, conta, data_hora), 
    CONSTRAINT consome_conteudo_fkey FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo), 
    CONSTRAINT consome_perfil_fkey FOREIGN KEY (perfil, conta) REFERENCES Perfil(id_perfil, conta_email), 
    CONSTRAINT consome_avaliacao_fkey FOREIGN KEY (id_avaliacao) REFERENCES Avaliacao(id_avaliacao) 
);

-- Telefone
CREATE TABLE Telefone ( 
    email VARCHAR2(255) NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, -- "+xxx81912345678" 
    CONSTRAINT telefone_pkey PRIMARY KEY (email, telefone), 
    CONSTRAINT telefone_conta_fkey FOREIGN KEY (email) REFERENCES Conta(email) 
);