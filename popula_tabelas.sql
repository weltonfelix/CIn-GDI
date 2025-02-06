-- POVOAMENTO DAS TABELAS ==
-- Plano
INSERT INTO Plano VALUES (1, 'Básico', 10.00, 6);
INSERT INTO Plano VALUES (2, 'Premium', 15.00, 3);
INSERT INTO Plano VALUES (3, 'Ultra', 40.00, 0);

-- Conta
INSERT INTO Conta (email, primeiro_nome, sobrenome, senha) VALUES ('jose.silva@email.com', 'José', 'Silva', 'senha123');
INSERT INTO Conta (email, primeiro_nome, sobrenome, senha) VALUES ('maria.santos@email.com', 'Maria', 'Santos', 'senha456');
INSERT INTO Conta (email, primeiro_nome, sobrenome, senha) VALUES ('pedro.oliveira@email.com', 'Pedro', 'Oliveira', 'senha789');
INSERT INTO Conta (email, primeiro_nome, sobrenome, senha) VALUES ('ana.pereira@email.com', 'Ana', 'Pereira', 'senha101');
INSERT INTO Conta (email, primeiro_nome, sobrenome, senha) VALUES ('lucas.rodrigues@email.com', 'Lucas', 'Rodrigues', 'senha202');

-- Perfil
INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (1, 'jose.silva@email.com', 'Zé', 'Livre', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (2, 'jose.silva@email.com', 'SilvaZ', 'Infantil', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (3, 'maria.santos@email.com', 'Mari', 'Livre', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (4, 'maria.santos@email.com', 'Marinha', 'Infantil', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (5, 'maria.santos@email.com', 'Mariazinha', 'Infantil', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (6, 'pedro.oliveira@email.com', 'Pedrinho', 'Livre', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (7, 'pedro.oliveira@email.com', 'P. Oliveira', 'Infantil', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (8, 'ana.pereira@email.com', 'Aninha', 'Livre', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (9, 'ana.pereira@email.com', 'AnaP', 'Infantil', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (10, 'ana.pereira@email.com', 'AnaPer', 'Infantil', TO_DATE('05-02-2025', 'DD-MM-YYYY'));

INSERT INTO Perfil (id_perfil, conta_email, apelido, tipo, data_criacao)
  VALUES (11, 'lucas.rodrigues@email.com', 'Luquinha', 'Livre', TO_DATE('05-02-2025', 'DD-MM-YYYY'));


-- Conteúdo (Filmes)
INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (1, 'O Senhor dos Anéis: A Sociedade do Anel', TO_DATE('19-12-2001', 'DD-MM-YYYY'), 'Aventura', 178, 'Fran Walsh, Philippa Boyens, Peter Jackson', 'New Line Cinema', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (2, 'Piratas do Caribe: A Maldição do Pérola Negra', TO_DATE('09-07-2003', 'DD-MM-YYYY'), 'Aventura', 143, 'Ted Elliott, Terry Rossio', 'Walt Disney Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (3, 'O Rei Leão', TO_DATE('24-06-1994', 'DD-MM-YYYY'), 'Animação', 88, 'Irene Mecchi, Jonathan Roberts, Linda Woolverton', 'Walt Disney Feature Animation', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (4, 'Gladiador', TO_DATE('05-05-2000', 'DD-MM-YYYY'), 'Drama', 155, 'David Franzoni, John Logan', 'DreamWorks Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (5, 'Matrix', TO_DATE('31-03-1999', 'DD-MM-YYYY'), 'Ficção Científica', 136, 'Lana Wachowski, Lilly Wachowski', 'Warner Bros. Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (6, 'Titanic', TO_DATE('19-12-1997', 'DD-MM-YYYY'), 'Drama', 195, 'James Cameron', 'Paramount Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (7, 'Jurassic Park', TO_DATE('11-06-1993', 'DD-MM-YYYY'), 'Aventura', 127, 'Michael Crichton', 'Universal Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (8, 'A Origem', TO_DATE('16-07-2010', 'DD-MM-YYYY'), 'Ficção Científica', 148, 'Christopher Nolan', 'Warner Bros. Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (10, 'O Exterminador do Futuro 2: O Julgamento Final', TO_DATE('03-07-1991', 'DD-MM-YYYY'), 'Ação', 137, 'James Cameron, William Wisher Jr.', 'TriStar Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (11, 'The Dark Knight', TO_DATE('18-07-2008', 'DD-MM-YYYY'), 'Ação', 152, 'Jonathan Nolan, Christopher Nolan', 'Warner Bros. Pictures', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (12, 'O Hobbit: Uma Jornada Inesperada', TO_DATE('14-12-2012', 'DD-MM-YYYY'), 'Aventura', 169, 'Fran Walsh, Philippa Boyens, Peter Jackson', 'New Line Cinema', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (13, 'Homem de Ferro', TO_DATE('02-05-2008', 'DD-MM-YYYY'), 'Ação', 126, 'Mark Fergus, Hawk Ostby, Art Marcum, Matt Holloway', 'Marvel Studios', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (14, 'O Incrível Hulk', TO_DATE('13-06-2008', 'DD-MM-YYYY'), 'Ação', 112, 'Zak Penn', 'Marvel Studios', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (15, 'Thor', TO_DATE('06-05-2011', 'DD-MM-YYYY'), 'Aventura', 115, 'Ashley Edward Miller, Zack Stentz, Don Payne', 'Marvel Studios', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (28, 'Eternos', TO_DATE('05-11-2021', 'DD-MM-YYYY'), 'Aventura', 156, 'Chloé Zhao, Patrick Burleigh, Ryan Firpo', 'Marvel Studios', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (27, 'Homem-Aranha: Longe de Casa', TO_DATE('02-07-2019', 'DD-MM-YYYY'), 'Aventura', 129, 'Chris McKenna, Erik Sommers', 'Marvel Studios', 28);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (26, 'Vingadores: Ultimato', TO_DATE('26-04-2019', 'DD-MM-YYYY'), 'Ação', 181, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', 27);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (25, 'Vingadores: Guerra Infinita', TO_DATE('27-04-2018', 'DD-MM-YYYY'), 'Ação', 149, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', 26);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (24, 'Guardiões da Galáxia Vol. 2', TO_DATE('05-05-2017', 'DD-MM-YYYY'), 'Aventura', 136, 'James Gunn', 'Marvel Studios', 25);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (23, 'Doutor Estranho', TO_DATE('04-11-2016', 'DD-MM-YYYY'), 'Ficção Científica', 115, 'Jon Spaihts, Scott Derrickson, C. Robert Cargill', 'Marvel Studios', 24);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (22, 'Capitão América: Guerra Civil', TO_DATE('06-05-2016', 'DD-MM-YYYY'), 'Ação', 147, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', 23);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (21, 'Vingadores: Era de Ultron', TO_DATE('01-05-2015', 'DD-MM-YYYY'), 'Ação', 141, 'Joss Whedon', 'Marvel Studios', 22);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (20, 'Capitão América: O Soldado Invernal', TO_DATE('04-04-2014', 'DD-MM-YYYY'), 'Aventura', 136, 'Christopher Markus, Stephen McFeely', 'Marvel Studios',21);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (19, 'Thor: O Mundo Sombrio', TO_DATE('08-11-2013', 'DD-MM-YYYY'), 'Aventura', 112, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', 20);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (18, 'Homem de Ferro 3', TO_DATE('03-05-2013', 'DD-MM-YYYY'), 'Ação', 130, 'Drew Pearce, Shane Black', 'Marvel Studios', 19);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (17, 'Os Vingadores', TO_DATE('04-05-2012', 'DD-MM-YYYY'), 'Ação', 143, 'Joss Whedon', 'Marvel Studios', 18);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (16, 'Capitão América: O Primeiro Vingador', TO_DATE('22-07-2011', 'DD-MM-YYYY'), 'Aventura', 124, 'Christopher Markus, Stephen McFeely', 'Marvel Studios', 17);

--Filmes
INSERT INTO Filme VALUES (1, NULL);
INSERT INTO Filme VALUES (2, NULL);
INSERT INTO Filme VALUES (3, NULL);
INSERT INTO Filme VALUES (4, NULL);
INSERT INTO Filme VALUES (5, NULL);
INSERT INTO Filme VALUES (6, NULL);
INSERT INTO Filme VALUES (7, NULL);
INSERT INTO Filme VALUES (8, NULL);
INSERT INTO Filme VALUES (10, NULL);
INSERT INTO Filme VALUES (11, NULL);
INSERT INTO Filme VALUES (12, NULL);
INSERT INTO Filme VALUES (13, NULL);
INSERT INTO Filme VALUES (14, NULL);
INSERT INTO Filme VALUES (15, NULL);
INSERT INTO Filme VALUES (16, NULL);
INSERT INTO Filme VALUES (17, 'Vingadores');
INSERT INTO Filme VALUES (18, 'Vingadores');
INSERT INTO Filme VALUES (19, 'Vingadores');
INSERT INTO Filme VALUES (20, 'Vingadores');
INSERT INTO Filme VALUES (21, 'Vingadores');
INSERT INTO Filme VALUES (22, 'Vingadores');
INSERT INTO Filme VALUES (23, 'Vingadores');
INSERT INTO Filme VALUES (24, 'Vingadores');
INSERT INTO Filme VALUES (25, 'Vingadores');
INSERT INTO Filme VALUES (26, 'Vingadores');
INSERT INTO Filme VALUES (27, 'Vingadores');
INSERT INTO Filme VALUES (28, 'Vingadores');


-- Conteudo (Séries)
INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (66, 'Dark - S01E10 - Alfa e Ômega', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 55, 'Baran bo Odar, Jantje Friese', 'Netflix', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (65, 'Dark - S01E09 - Tudo é Agora', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 51, 'Baran bo Odar, Jantje Friese', 'Netflix', 66);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (64, 'Dark - S01E08 - O que se Semeia, se Colhe', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 50, 'Baran bo Odar, Jantje Friese', 'Netflix', 65);

 INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (63, 'Dark - S01E07 - Cruzando as Linhas', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 50, 'Baran bo Odar, Jantje Friese', 'Netflix', 64);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (62, 'Dark - S01E06 - Sic Mundus Creatus Est', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 51, 'Baran bo Odar, Jantje Friese', 'Netflix', 63);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (61, 'Dark - S01E05 - Verdades', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 50, 'Baran bo Odar, Jantje Friese', 'Netflix', 62);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (60, 'Dark - S01E04 - Duplo Viver', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 48, 'Baran bo Odar, Jantje Friese', 'Netflix', 61);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (59, 'Dark - S01E03 - Passado e Presente', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 46, 'Baran bo Odar, Jantje Friese', 'Netflix', 60);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (58, 'Dark - S01E02 - Mentiras', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 45, 'Baran bo Odar, Jantje Friese', 'Netflix', 59);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (57, 'Dark - S01E01 - Segredos', TO_DATE('01-12-2017', 'DD-MM-YYYY'), 'Mistério', 51, 'Baran bo Odar, Jantje Friese', 'Netflix', 58);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (56, 'Better Call Saul - S01E10 - Marco', TO_DATE('06-04-2015', 'DD-MM-YYYY'), 'Drama', 53, 'Vince Gilligan, Peter Gould', 'AMC', NULL);

 INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (55, 'Better Call Saul - S01E09 - Pimento', TO_DATE('30-03-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', 56);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (54, 'Better Call Saul - S01E08 - Rico', TO_DATE('23-03-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', 55);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (53, 'Better Call Saul - S01E07 - Bingo', TO_DATE('16-03-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', 54);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (52, 'Better Call Saul - S01E06 - Five-O', TO_DATE('09-03-2015', 'DD-MM-YYYY'), 'Drama', 43, 'Vince Gilligan, Peter Gould', 'AMC', 53);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (51, 'Better Call Saul - S01E05 - Alpine Shepherd Boy', TO_DATE('02-03-2015', 'DD-MM-YYYY'), 'Drama', 43, 'Vince Gilligan, Peter Gould', 'AMC', 52);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (50, 'Better Call Saul - S01E04 - Hero', TO_DATE('23-02-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', 51);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (49, 'Better Call Saul - S01E03 - Nacho', TO_DATE('16-02-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', 50);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (48, 'Better Call Saul - S01E02 - Mijo', TO_DATE('09-02-2015', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan, Peter Gould', 'AMC', 49);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (47, 'Better Call Saul - S01E01 - Uno', TO_DATE('08-02-2015', 'DD-MM-YYYY'), 'Drama', 53, 'Vince Gilligan, Peter Gould', 'AMC', 48);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (46, 'Avatar - S02E04 - O Pântano', TO_DATE('07-04-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (45, 'Avatar - S02E03 - O Retorno para Omashu', TO_DATE('31-03-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 46);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (44, 'Avatar - S02E02 - A Caverna dos Amantes', TO_DATE('24-03-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 45);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (43, 'Avatar - S02E01 - O Estado Avatar', TO_DATE('17-03-2006', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 44);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (42, 'Avatar - S01E04 - Os Guerreiros de Kyoshi', TO_DATE('04-03-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 43);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (41, 'Avatar - S01E03 - O Templo do Ar do Sul', TO_DATE('25-02-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 42);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (40, 'Avatar - S01E02 - O Retorno do Avatar', TO_DATE('21-02-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 41);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (39, 'Avatar - S01E01 - O Garoto no Iceberg', TO_DATE('21-02-2005', 'DD-MM-YYYY'), 'Animação', 23, 'Michael Dante DiMartino, Bryan Konietzko', 'Nickelodeon', 40);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (38, 'Breaking Bad - S02E05 - Breakage', TO_DATE('05-04-2009', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', NULL);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (37, 'Breaking Bad - S02E04 - Down', TO_DATE('29-03-2009', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', 38);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (36, 'Breaking Bad - S02E03 - Bit by a Dead Bee', TO_DATE('22-03-2009', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', 37);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (35, 'Breaking Bad - S02E02 - Grilled', TO_DATE('15-03-2009', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', 36);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (34, 'Breaking Bad - S02E01 - Seven Thirty-Seven', TO_DATE('08-03-2009', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', 35);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (33, 'Breaking Bad - S01E05 - Gray Matter', TO_DATE('24-02-2008', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', 34);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (32, 'Breaking Bad - S01E04 - Cancer Man', TO_DATE('17-02-2008', 'DD-MM-YYYY'), 'Drama', 47, 'Vince Gilligan', 'Sony Pictures Television', 33);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (31, 'Breaking Bad - S01E03 - ...And the Bag''s in the River', TO_DATE('10-02-2008', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', 32);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (30, 'Breaking Bad - S01E02 - Cat''s in the Bag...', TO_DATE('27-01-2008', 'DD-MM-YYYY'), 'Drama', 48, 'Vince Gilligan', 'Sony Pictures Television', 31);

INSERT INTO Conteudo (id_conteudo, nome, data_lancamento, genero, duracao_minutos, roteiro, producao, id_sucessor)
  VALUES (29, 'Breaking Bad - S01E01 - Pilot', TO_DATE('20-01-2008', 'DD-MM-YYYY'), 'Drama', 58, 'Vince Gilligan', 'Sony Pictures Television', 30);

-- Serie
INSERT INTO Serie VALUES (1, 10, 'Breaking Bad');
INSERT INTO Serie VALUES (2, 8, 'Avatar');
INSERT INTO Serie VALUES (3, 10, 'Better Call Saul');
INSERT INTO Serie VALUES (4, 10, 'Dark');

-- Episodio
INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (29, 1, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (30, 1, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (31, 1, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (32, 1, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (33, 1, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (34, 2, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (35, 2, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (36, 2, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (37, 2, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (38, 2, 1);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (39, 1, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (40, 1, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (41, 1, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (42, 1, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (43, 2, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (44, 2, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (45, 2, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (46, 2, 2);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (47, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (48, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (49, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (50, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (51, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (52, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (53, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (54, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (55, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (56, 1, 3);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (57, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (58, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (59, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (60, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (61, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (62, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (63, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (64, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (65, 1, 4);

INSERT INTO Episodio (id_conteudo, temporada, serie_pertencente)
  VALUES (66, 1, 4);


 -- Telefone
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('jose.silva@email.com', '+05511987654321');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('jose.silva@email.com', '+05511912345678');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('maria.santos@email.com', '+05521987654321');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('pedro.oliveira@email.com', '+05531987654321');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('pedro.oliveira@email.com', '+05531912345678');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('ana.pereira@email.com', '+05541987654321');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('lucas.rodrigues@email.com', '+05551987654321');
INSERT INTO Telefone (EMAIL, TELEFONE) VALUES ('lucas.rodrigues@email.com', '+05551912345678');

-- Avaliação
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (1, 5, TO_TIMESTAMP('01-01-2024 14:30:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (2, 4, TO_TIMESTAMP('02-01-2024 16:45:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (3, 3, TO_TIMESTAMP('03-01-2024 12:15:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (4, 5, TO_TIMESTAMP('04-01-2024 18:20:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (5, 2, TO_TIMESTAMP('05-01-2024 10:00:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (6, 4, TO_TIMESTAMP('06-01-2024 20:10:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (7, 1, TO_TIMESTAMP('07-01-2024 09:30:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (8, 5, TO_TIMESTAMP('08-01-2024 14:50:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (9, 3, TO_TIMESTAMP('09-01-2024 11:40:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (10, 2, TO_TIMESTAMP('10-01-2024 22:05:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (11, 5, TO_TIMESTAMP('11-01-2024 13:25:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (12, 4, TO_TIMESTAMP('12-01-2024 17:35:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (13, 1, TO_TIMESTAMP('13-01-2024 08:20:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (14, 3, TO_TIMESTAMP('14-01-2024 15:45:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (15, 4, TO_TIMESTAMP('15-01-2024 19:55:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (16, 2, TO_TIMESTAMP('16-01-2024 10:10:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (17, 5, TO_TIMESTAMP('17-01-2024 21:20:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (18, 3, TO_TIMESTAMP('18-01-2024 07:45:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (19, 1, TO_TIMESTAMP('19-01-2024 16:30:00', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO Avaliacao (ID_AVALIACAO, QUALIDADE, DATA_HORA) VALUES (20, 4, TO_TIMESTAMP('20-01-2024 12:00:00', 'DD-MM-YYYY HH24:MI:SS'));

-- Perfil Consome Conteudo
INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (1, 1, 'jose.silva@email.com', TO_TIMESTAMP('01/02/2025 14:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 75, 5);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (2, 2, 'jose.silva@email.com', TO_TIMESTAMP('02/02/2025 16:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 50, 12);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (3, 3, 'maria.santos@email.com', TO_TIMESTAMP('03/02/2025 12:15:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 80, 8);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (4, 4, 'maria.santos@email.com', TO_TIMESTAMP('04/02/2025 18:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 95, 3);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (5, 5, 'maria.santos@email.com', TO_TIMESTAMP('05/02/2025 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 60, 15);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (6, 6, 'pedro.oliveira@email.com', TO_TIMESTAMP('06/02/2025 20:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 40, 7);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (7, 7, 'pedro.oliveira@email.com', TO_TIMESTAMP('07/02/2025 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 90, 18);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (8, 8, 'ana.pereira@email.com', TO_TIMESTAMP('08/02/2025 14:50:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 85, 11);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (10, 9, 'ana.pereira@email.com', TO_TIMESTAMP('09/02/2025 11:40:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 55, 2);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (12, 10, 'ana.pereira@email.com', TO_TIMESTAMP('10/02/2025 22:05:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 35, 20);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (15, 11, 'lucas.rodrigues@email.com', TO_TIMESTAMP('11/02/2025 13:25:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 70, 6);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (25, 1, 'jose.silva@email.com', TO_TIMESTAMP('13/02/2025 08:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 45, 1);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (30, 2, 'jose.silva@email.com', TO_TIMESTAMP('14/02/2025 15:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 50, 9);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (35, 3, 'maria.santos@email.com', TO_TIMESTAMP('15/02/2025 19:55:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 95, 10);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (40, 4, 'maria.santos@email.com', TO_TIMESTAMP('16/02/2025 10:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 85, 13);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (45, 5, 'maria.santos@email.com', TO_TIMESTAMP('17/02/2025 21:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 20, 4);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (50, 6, 'pedro.oliveira@email.com', TO_TIMESTAMP('18/02/2025 07:45:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 75, 16);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (55, 7, 'pedro.oliveira@email.com', TO_TIMESTAMP('19/02/2025 16:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Celular', 90, 19);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (60, 8, 'ana.pereira@email.com', TO_TIMESTAMP('20/02/2025 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Computador', 65, 17);

INSERT INTO PerfilConsomeConteudo (ID_CONTEUDO, PERFIL, CONTA, DATA_HORA, DISPOSITIVO_UTILIZADO, PROGRESSO_PERCENTUAL, ID_AVALIACAO)
  VALUES (20, 11, 'lucas.rodrigues@email.com', TO_TIMESTAMP('12/02/2025 17:35:00', 'DD/MM/YYYY HH24:MI:SS'), 'Tablet', 80, 14);

-- Plano Permite Conteudo
INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (1, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (2, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (3, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (4, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (5, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (6, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (7, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (8, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (10, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (11, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (12, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (13, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (14, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (15, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (16, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (17, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (18, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (19, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (20, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (21, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (22, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (23, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (24, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (25, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (26, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (27, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (28, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (29, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (30, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (31, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (32, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (33, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (34, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (35, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (36, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (37, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (38, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (39, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (40, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (41, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (42, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (43, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (44, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (45, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (46, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (47, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (48, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (49, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (50, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (51, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (52, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (53, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (54, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (55, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (56, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (57, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (58, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (59, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (60, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (61, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (62, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (63, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (64, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (65, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (66, 1, 'pedro.oliveira@email.com', TO_DATE('20-01-2008', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (1, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (2, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (3, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (4, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (5, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (6, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (7, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (8, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (10, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (11, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (12, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (13, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (14, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (15, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (16, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (17, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (18, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (19, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (20, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (21, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (22, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (23, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (24, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (25, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (26, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (27, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (28, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (29, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (30, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (31, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (32, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (33, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (34, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (35, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (36, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (37, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (38, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (39, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (40, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (41, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (42, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (43, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (44, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (45, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (46, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (47, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (48, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (49, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (50, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (51, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (52, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (53, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (54, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (55, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (56, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (57, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (58, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (59, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (60, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (61, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (62, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (63, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (64, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (65, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (66, 2, 'jose.silva@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (1, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (2, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (3, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (4, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (5, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (6, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (7, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (8, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (10, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (11, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (12, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (13, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (14, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (15, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (16, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (17, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (18, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (19, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (20, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (21, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (22, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (23, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (24, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (25, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (26, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (27, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (28, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (29, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (30, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (31, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (32, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (33, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (34, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (35, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (36, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (37, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (38, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (39, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (40, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (41, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (42, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (43, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (44, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (45, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (46, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (47, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (48, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (49, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (50, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (51, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (52, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (53, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (54, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (55, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (56, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (57, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (58, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (59, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (60, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (61, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (62, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (63, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (64, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (65, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (66, 3, 'maria.santos@email.com', TO_DATE('24-05-2018', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (1, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (2, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (3, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (4, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (5, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (6, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (7, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (8, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (10, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (11, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (12, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (13, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (14, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (15, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (16, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (17, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (18, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (19, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (20, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (21, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (22, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (23, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (24, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (25, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (26, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (27, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (28, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (29, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (30, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (31, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (32, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (33, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (34, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (35, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (36, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (37, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (38, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (39, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (40, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (41, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (42, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (43, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (44, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (45, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (46, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (47, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (48, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (49, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (50, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (51, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (52, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (53, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (54, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (55, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (56, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (57, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (58, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (59, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (60, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (61, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (62, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (63, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (64, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (65, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (66, 3, 'ana.pereira@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (1, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (2, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (3, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (4, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (5, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (6, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (7, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (8, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (10, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (11, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (12, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (13, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (14, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (15, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (16, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (17, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (18, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (19, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (20, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (21, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (22, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (23, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (24, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (25, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (26, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (27, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (28, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (29, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (30, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (31, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (32, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (33, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (34, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (35, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (36, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (37, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (38, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (39, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (40, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (41, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (42, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (43, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (44, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (45, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (46, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (47, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (48, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (49, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (50, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (51, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (52, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (53, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (54, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (55, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (56, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (57, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (58, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (59, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (60, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (61, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (62, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (63, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (64, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (65, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);

INSERT INTO PlanoPermiteConteudo(ID_CONTEUDO, ID_PLANO, EMAIL, DATA_INICIO, DATA_FIM, DESCONTO_APLICADO) VALUES (66, 1, 'lucas.rodrigues@email.com', TO_DATE('31-12-2022', 'DD-MM-YYYY'), NULL, NULL);
