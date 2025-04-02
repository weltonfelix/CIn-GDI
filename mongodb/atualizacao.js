db.sessoes.updateMany(
  {},
  [
    { 
      $set: {
        "data_hora": {
          $dateFromString: {
            dateString: {
              $concat: ["$data", "T", "$horario", ".000-03:00"]
            }
          }
        }
      }
    },
    { $unset: ["data", "horario"] }
  ]
);
