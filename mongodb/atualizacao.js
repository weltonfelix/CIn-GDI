db.sessoes.updateMany({ data: { $exists: true }, horario: { $exists: true } }, [
  {
    $set: {
      data_hora: {
        $dateFromString: {
          dateString: {
            $concat: ["$data", "T", "$horario", ".000-03:00"],
          },
        },
      },
    },
  },
  { $unset: ["data", "horario"] },
]);
