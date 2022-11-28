--
-- VISTE
--
 
-- Specifica 1.1
-- Il sistema dovrà visualizzare l'elenco degli iscritti a ogni corso
CREATE view elenco_iscritti AS
SELECT p.nome,
    p.cognome,
    o.descrizione,
    c.denominazione
FROM Partecipante AS p
    INNER JOIN Partecipazione USING (partecipanteId)
    INNER JOIN CorsoOfferto AS o USING (corsoOffertoId)
    INNER JOIN Corso AS c USING (corsoId);
--
-- Specifica 1.2
-- Il sistema dovrà visualizzare i posti liberi per ciascun corso
CREATE view posti_liberi AS
SELECT o.numeroMassimoPartecipanti - COUNT(p.partecipanteId) AS posti_liberi,
    o.descrizione,
    c.denominazione
FROM Partecipante AS p
    INNER JOIN Partecipazione USING (partecipanteId)
    INNER JOIN CorsoOfferto AS o USING (corsoOffertoId)
    INNER JOIN Corso AS c USING (corsoId)
GROUP BY o.corsoOffertoId;
--
-- Specifica 1.3
-- Il sistema dovrà visualizzare l'elenco dei corsi per ciascun istruttore
CREATE view corsi_per_istruttore AS
SELECT i.nome,
    i.cognome,
    o.descrizione,
    c.denominazione
FROM CorsoOfferto AS o
    INNER JOIN Corso AS c USING (corsoId)
    INNER JOIN Istruttore i USING (istruttoreId)
ORDER BY i.cognome,
    i.nome,
    c.denominazione,
    o.descrizione;
--
-- Specifica 1.4
-- Il sistema dovrà visualizzare l'elenco dei clienti con certificato medico scaduto
CREATE VIEW certificati_scaduti AS
SELECT p.cognome,
    p.nome,
    c.denominazione,
    dataRilascioCertificato,
    CASE
        -- se la data di scadenza è nota allora quella
        WHEN dataScadenzaCertificato IS NOT NULL THEN dataScadenzaCertificato
        ELSE -- un anno dopo il rilascio
        date(julianday(dataRilascioCertificato) + 365.25)
    END AS giornoScadenza
FROM Partecipante AS p
    INNER JOIN Partecipazione USING (partecipanteId)
    INNER JOIN CorsoOfferto USING (corsoOffertoId)
    INNER JOIN Corso AS c USING (corsoId)
WHERE date() > giornoScadenza;
--
-- Specifica 2.1
-- Il sito web dovrà mostrare i corsi
CREATE VIEW w_elenco_corsi AS
SELECT corsoId,
    denominazione
FROM Corso;
--
-- Specifica 2.2.1
-- Il sito web, selezionato un corso offerto ,dovrà visualizzare la descrizione del corso selezionato
-- SELECT corsoOffertoId,
--     descrizione
-- FROM CorsoOfferto
--     INNER JOIN Corso USING (corsoId)
-- WHERE corsoId = ?;
--
-- Specifica 2.2.1.1
-- Il sito web, selezionato un corso offerto, dovrà visualizzare il nome e le specializzazioni dell'istruttore del corso offerto selezionato
-- SELECT nome,
--     cognome
-- FROM Istruttore
-- WHERE istruttoreId = ?;
--
-- Specifica 2.2.1.1.1
-- Il sito web, selezionato un corso offerto, dovrà visualizzare le specializzazioni dell 'istruttore selezionato
-- SELECT denominazione
-- FROM Istruttore
--     INNER JOIN Specializzazione USING (istruttoreId)
--     INNER JOIN Corso USING (corsoId)
-- WHERE istruttoreId = ?;
--
-- Specifica 2.2.3
-- Il sito web, selezionato un corso offerto, dovrà visualizzare l 'orario e la sala del corso selezionato
-- SELECT giorno,
--     f.inizio,
--     f.fine,
--     sala
-- FROM CorsoOfferto
--     INNER JOIN Orario USING (corsoOffertoId)
--     INNER JOIN FasciaOraria AS f USING (fasciaOrariaId)
--     INNER JOIN Giorno USING (giornoId)
--     INNER JOIN Sala USING (salaId)
-- WHERE corsoOffertoId = ?;