# Projetos GDI

Este repositório contém os projetos desenvolvidos durante a disciplina de GDI
(Gerenciamento de Dados e Informação) do curso de Ciência da Computação da
Universidade Federal de Pernambuco (UFPE).

Os SGBDs utilizados foram Oracle (para o projeto de banco de dados relacional
e objeto-relacional) e MongoDB (para o projeto de banco de dados não relacional).

## Equipe

| [![João Marrocos](https://avatars.githubusercontent.com/u/135621408?v=&s=70)](https://github.com/jlsm2) | [![Juliana Talita](https://avatars.githubusercontent.com/u/136332496?v=4&s=70)](https://github.com/julianatalita) | [![Luana Queiroz](https://avatars.githubusercontent.com/u/136331050?v=4&s=70)](https://github.com/luana-queiroz) | [![Lucas Carvalho](https://avatars.githubusercontent.com/u/131834120?v=4&s=70)](https://github.com/LucasSilvaa0) | [![Thomaz Cabral](https://avatars.githubusercontent.com/u/127772709?v=4&s=70)](https://github.com/thomazcabral) | [![Welton Felix](https://avatars.githubusercontent.com/u/52381662?v=4&s=70)](https://github.com/weltonfelix) |
| ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| [João Marrocos](https://github.com/jlsm2)                                                               | [Juliana Talita](https://github.com/julianatalita)                                                                | [Luana Queiroz](https://github.com/luana-queiroz)                                                                | [Lucas Carvalho](https://github.com/LucasSilvaa0)                                                                | [Thomaz Cabral](https://github.com/thomazcabral)                                                                | [Welton Felix](https://github.com/weltonfelix)                                                               |

## Projeto 1 - Banco de Dados Relacional e Objeto-Relacional

Sistema para gerenciamento de usuários, assinaturas, conteúdos (filmes e séries)
e histórico de visualizações de um serviço de streaming.

O sistema será responsável por gerenciar uma plataforma de streaming que conecta
usuários a um catálogo de conteúdos, incluindo filmes e séries. Os usuários podem
assinar um plano de acesso à plataforma e dividir o acesso com seus familiares.
O histórico de exibição é salvo e a plataforma o analisa para recomendar novos conteúdos.

### Objetivos da Aplicação

Criar uma plataforma com oportunidades de multiuso em um só plano para consumo de
diferentes tipos de conteúdo, garantindo uma experiência integrada e personalizada.
O sistema deve oferecer:

1. Catálogo Unificado
   - Agrupar filmes e  séries em um único ambiente de navegação, permitindo que o
     usuário explore e consuma diferentes tipos de mídia sem a necessidade de trocar de plataforma.
   - Disponibilizar ferramentas de busca avançada e filtros que cruzem os tipos de conteúdo

2. Gerenciamento de Perfis Personalizados
   - Permitir que cada perfil dentro de uma conta compartilhe o plano, mas tenha
     suas próprias configurações, preferências e histórico de consumo.

3. Sincronização e Continuidade
   - Salvar o progresso de filmes e episódios para que o usuário possa retomar de
     onde parou em qualquer dispositivo.

## Projeto 2 - Banco de Dados Não Relacional

Sistema de Cinema: Filmes, Sessões e Ingressos

O sistema tem como objetivo gerenciar a exibição de filmes em um cinema, permitindo
o cadastro e gerenciamento de filmes, sessões e ingressos. Os usuários podem consultar
a programação de filmes, verificar horários de exibição e adquirir ingressos para as sessões disponíveis.

### Coleções

- Filmes (titulo, duração, gênero, sinopse, classificação_indicativa, idiomas(array))
- Sessões (data_hora, filme*, sala)
- Ingressos (valor, cadeira, sessão*)

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
