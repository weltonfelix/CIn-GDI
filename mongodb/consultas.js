// Utiliza o banco de dados 'gdi'
use gdi

// Filmes com classificação indicative livre, ordenados pelo título
db.filmes.find({ classificacao_indicativa: "L" }).sort({ titulo: 1 });

// Classifica os filmes em longos e curtos, de acordo com a duração
db.filmes.aggregate([
  {
    $project: {
      titulo: 1,
      duracaoCategoria: {
        $cond: {
          if: { $gte: ["$duracao", 120] },
          then: "Longo",
          else: "Curto",
        },
      },
    },
  },
]);

// Encontra o filme exibido em uma sessão específica
db["sessoes"].aggregate(
  {
    $lookup: {
      from: "filmes",
      localField: "filme",
      foreignField: "_id",
      as: "filme_data",
    },
  },
  {
    $match: {
      _id: ObjectId("660b1a2c3d4e5f6789012341"),
    },
  }
);

// Encontra sessões cujo filme associado não existe
db["sessoes"].aggregate(
  {
    $lookup: {
      from: "filmes",
      localField: "filme",
      foreignField: "_id",
      as: "filme_data",
    },
  },
  {
    $match: {
      filme_data: {
        $size: 0,
      },
    },
  },
  {
    $unset: "filme_data",
  }
);

// Filme com mais ingressos vendidos, a quantidade de ingressos vendidos e o valor médio dos ingressos
db.sessoes.aggregate([
  {
    $lookup: {
      from: "ingressos",
      localField: "_id",
      foreignField: "sessao",
      as: "ingressos",
    },
  },
  {
    $lookup: {
      from: "filmes",
      localField: "filme",
      foreignField: "_id",
      as: "filme_info",
    },
  },
  { $unwind: "$ingressos" },
  { $unwind: "$filme_info" },
  {
    $group: {
      _id: "$filme_info.titulo",
      totalIngressos: { $sum: 1 },
      valorMedio: { $avg: "$ingressos.valor" },
    },
  },
  { $sort: { totalIngressos: -1 } },
  { $limit: 1 },
]);

// Quantidade de ingressos vendidos e ingresso com maior valor
db.ingressos
  .aggregate([
    {
      $group: {
        _id: null,
        totalIngressos: { $count: {} },
        maxValor: { $max: "$valor" },
      },
    },
  ])
  .pretty();

// Renomeia a coleção filmes para filme e depois renomeia de volta
db.runCommand({ renameCollection: "gdi.filmes", to: "gdi.filme" });
db.runCommand({ renameCollection: "gdi.filme", to: "gdi.filmes" });

// Encontra o filme com o título "Matrix"
db.filmes.findOne({
  titulo: "Matrix",
});

// Consulta textual: Buscar filmes por palavras-chave e calcular receita total
// Cria índice para a busca textual
db.filmes.createIndex(
  { titulo: "text", genero: "text", sinopse: "text" },
  { name: "indice_titulo_text_genero_sinopse_text" }
);
// Função
function consultaFilmesPorPalavraChave(termo) {
  return db.filmes.aggregate([
    {
      $match: {
        $text: { $search: termo },
      },
    },
    {
      $lookup: {
        from: "sessoes",
        localField: "_id",
        foreignField: "filme",
        as: "sessoes",
      },
    },
    {
      $lookup: {
        from: "ingressos",
        localField: "sessoes._id",
        foreignField: "sessao",
        as: "ingressos",
      },
    },
    {
      $group: {
        _id: "$titulo",
        total_ingressos: { $sum: { $size: "$ingressos" } },
        receita_total: { $sum: { $sum: "$ingressos.valor" } },
      },
    },
    {
      $sort: { receita_total: -1 },
    },
  ]);
}

// Busca todos os filmes que estão disponíveis no idioma Italiano
db.filmes.find({ idiomas: { $all: ["Italiano"] } });

// Adiciona o idioma 'Russo' ao filme 'Gladiador'
db.filmes.updateOne(
  { titulo: "Gladiador" },
  { $addToSet: { idiomas: "Russo" } }
);

// Remove o idioma 'Russo' do filme 'Gladiador'
db.filmes.updateOne({ titulo: "Gladiador" }, { $pull: { idiomas: "Russo" } });

// Filtra os id
db.filmes.findOne(
  { titulo: "Gladiador" },
  {
    titulo: 1,
    idiomas_filtrados: {
      $filter: {
        input: "$idiomas",
        as: "idioma",
        cond: { $ne: ["$$idioma", "Inglês"] },
      },
    },
  }
);

/* @deprecated
 MongoServerError[AtlasError]: $where not allowed in this atlas tier
 A partir do MongoDB 8.0, as funções JavaScript do lado do servidor
 ($accumulator, $function, $where) estão obsoletas.
 O MongoDB registra um aviso quando você executa essas funções.
 */
// Encontra os ingressos com valor maior que 30
db.ingressos.find({
  $where: "this.valor > 30",
});

/* @deprecated
 MongoServerError[AtlasError]: CMD_NOT_ALLOWED: mapReduce
 Pipeline de agregação como alternativa
 A partir do MongoDB 5.0, o map-reduce está obsoleto:
 Em vez de map-reduce, é preciso usar um pipeline de agregação.
 Os pipeline de agregaçãos fornecem melhor desempenho e usabilidade do que o map-reduce.
 Você pode reescrever operações de map-reduce utilizando aggregation pipeline stages, como $group, $merge e outros.
 Nas operações de map-reduce que exigem funcionalidade personalizada, você pode usar
 os operadores de agregação $accumulator e $function. Você pode usar esses operadores
 para definir expressões de agregação personalizadas no JavaScript.
 */
db.Sessoes.mapReduce(
  function () {
    emit(this.filme, 1);
  },
  function (key, values) {
    return Array.sum(values);
  },
  {
    out: "SessoesPorFilme",
  }
);
