//seleciona filmes com essa clas. ind.
db.filmes.find({ classificacao_indicativa: "L" }).sort({ titulo: 1 })


//classifica os filmes
db.filmes.aggregate([
  {
    $project: {
      titulo: 1,
      duracaoCategoria: {
        $cond: { 
          if: { $gte: ["$duracao", 120] }, 
          then: "Longo", 
          else: "Curto" 
        }
      }
    }
  }
])
