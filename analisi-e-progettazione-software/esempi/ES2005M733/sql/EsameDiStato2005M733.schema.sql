--! Un partecipante
--  Una persona che frequenta la palestra
CREATE TABLE Partecipante (
   partecipanteId INTEGER -- Chiave surrogata
   NOT NULL PRIMARY KEY,
   nome TEXT NOT NULL,
   -- Nome del cliente
   cognome TEXT NOT NULL -- Cognome del cliente
);
--! Un istruttore
--  Una persona che può impartire uno o più corsi per i quali è specializzato
CREATE TABLE Istruttore (
   istruttoreId INTEGER -- Chiave surrogata
   NOT NULL PRIMARY KEY,
   nome TEXT NOT NULL,
   -- Nome dell'istruttore
   cognome TEXT NOT NULL -- Cognome dell'istruttore
);
--! Un tipo di corso
--  Corso che la palestra può offrire in orari differenti
CREATE TABLE Corso (
   corsoId INTEGER -- Chiave surrogata
   NOT NULL PRIMARY KEY,
   denominazione TEXT NOT NULL,
   -- Nome del corso
   descrizione TEXT NOT NULL -- Descrizione del corso da visualizzare sul sito web
);
--! Un corso offerto ai partecipanti
--  Un corso specifico impartito in un certo orario da un istruttore
CREATE TABLE CorsoOfferto (
   corsoOffertoId INTEGER -- Chiave surrogata
   NOT NULL PRIMARY KEY,
   corsoId INTEGER -- Riferimento al tipo di corso
   NOT NULL REFERENCES Corso(corsoId),
   istruttoreId INTEGER -- Riferimento all'istruttore che impartisce il corso
   REFERENCES Istruttore(istruttoreId),
   numeroMassimoPartecipanti INTEGER -- Numero massimo di partecipanti al corso
   NOT NULL DEFAULT 10,
   descrizione TEXT,
   -- Descrione del corso offerto
   inizio TEXT NOT NULL,
   -- Data della prima lezione del corso in formato ISO 8601
   fine TEXT NOT NULL,
   --   Data dell'ultima lezione del corso in formato ISO 8601
   CHECK (
      inizio LIKE '____-__-__'
      AND julianday(inizio) IS NOT NULL
   ),
   CHECK (
      fine LIKE '____-__-__'
      AND julianday(fine) IS NOT NULL
   ),
   CHECK (
      (fine IS NULL)
      OR (fine > inizio)
   ),
   CHECK (numeroMassimoPartecipanti > 0)
);
--! Un giorno della settimana
--  Enumerazione dei giorni della settimana
CREATE TABLE Giorno (
   giornoId INTEGER -- chiave surrogata
   PRIMARY KEY,
   giorno TEXT NOT NULL,
   -- nome del giorno della settimana
   abbreviazione TEXT NOT NULL -- nome abbreviato del giorno della settimana
);
--! Una fascia oraria
--  Una fascia oraria durante la quale si impartisce un corso
CREATE TABLE FasciaOraria (
   fasciaOrariaId INTEGER --  Chiave surrogata
   NOT NULL PRIMARY KEY,
   giornoId INTEGER -- Giorno della settimana
   NOT NULL REFERENCES Giorno(giornoId),
   inizio TEXT NOT NULL,
   -- Ora di inizio 
   fine TEXT NOT NULL,
   -- Ora di fine
   CHECK (
      inizio LIKE '__:__'
      AND julianday("2022-01-01T" || inizio || ":00") IS NOT NULL
   ),
   CHECK (
      fine LIKE '__:__'
      AND julianday("2022-01-01T" || fine || ":00") IS NOT NULL
   ),
   CHECK (fine > inizio)
);
--! Una sala
--  Luogo in cui viene impartito un corso
CREATE TABLE Sala (
   salaId INTEGER -- Chiave surrogata della sala
   NOT NULL PRIMARY KEY,
   sala TEXT,
   -- Il nome della sala
   capienza INTEGER -- La capienza massima
   DEFAULT 10
);
--! L'orario dei corsi
--  Il legame tra un corso offerto, la fascia oraria e la sala
--
CREATE TABLE Orario
(
   corsoOffertoId INTEGER -- Riferimento al corso offerto
   REFERENCES CorsoOfferto(corsoOffertoId),
   fasciaOrariaId INTEGER -- Riferimento alla fascia oraria
   REFERENCES FasciaOraria(fasciaOrariaId),
   salaId INTEGER -- Riferimento alla sala
   REFERENCES Sala(salaId),
   PRIMARY KEY (corsoOffertoId, fasciaOrariaId)
);
--! Una partecipazione ad un corso
--  La relazione molti a molti tra partecipanti e corsi offerti
--  Include un certificato medico per ogni partecipazione ad un corso
CREATE TABLE Partecipazione (
   partecipanteId INTEGER -- Riferimento al partecipante
   REFERENCES Partecipante(partecipanteId),
   corsoOffertoId INTEGER -- Riferimento al corso offerto
   REFERENCES CorsoOfferto(corsoOffertoId),
   dataRilascioCertificato TEXT NOT NULL,
   -- Data di rilascio del certificato medico
   dataScadenzaCertificato TEXT,
   -- Data di scadenza del certificato medico
   PRIMARY KEY (partecipanteId, corsoOffertoId),
   CHECK (
      dataRilascioCertificato LIKE '____-__-__'
      AND julianday(dataRilascioCertificato) IS NOT NULL
   ),
   CHECK (
      (dataScadenzaCertificato IS NULL)
      OR (
         dataScadenzaCertificato LIKE '____-__-__'
         AND julianday(dataScadenzaCertificato) IS NOT NULL
         AND dataScadenzaCertificato > dataRilascioCertificato
      )
   )
);
--! Una specializzazione
--  Abilitazione di un istruttore per impartire un corso
CREATE TABLE Specializzazione (
   istruttoreId INTEGER -- Riferimento allo istruttore
   REFERENCES Istruttore(IstruttoreId),
   corsoId INTEGER -- Riferimento al corso
   REFERENCES Corso(corsoId),
   titolo TEXT DEFAULT NULL,
   -- Abilitazione conseguita
   PRIMARY KEY (istruttoreId, corsoId, titolo)
);