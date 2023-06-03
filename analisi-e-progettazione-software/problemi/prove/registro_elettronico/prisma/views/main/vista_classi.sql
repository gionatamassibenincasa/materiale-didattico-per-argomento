SELECT
  classeId,
  anno || ' ' || sezione || ' ' || articolazione AS classe
FROM
  Classe
  JOIN AnnoScolastico USING(annoScolasticoId)
WHERE
  date() BETWEEN inizio AND fine
ORDER BY
  anno,
  sezione,
  articolazione;