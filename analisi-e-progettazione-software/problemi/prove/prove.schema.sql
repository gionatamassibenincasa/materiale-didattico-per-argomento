CREATE TABLE IF NOT EXISTS AnnoScolastico (
    annoScolasticoId INTEGER PRIMARY KEY AUTOINCREMENT,
    testo TEXT NOT NULL UNIQUE CHECK (length(testo) = 7),
    inizio TEXT NOT NULL UNIQUE CHECK(inizio IS date(inizio, '+0 days')),
    fine TEXT NOT NULL UNIQUE CHECK(fine IS date(fine, '+0 days'))
);
CREATE TABLE IF NOT EXISTS PeriodoValutazione (
    periodoValutazioneId INTEGER PRIMARY KEY AUTOINCREMENT,
    annoScolasticoId INTEGER NOT NULL REFERENCES AnnoScolastico(annoScolasticoId) ON DELETE CASCADE ON UPDATE CASCADE,
    descrizione TEXT NOT NULL,
    inizio TEXT NOT NULL UNIQUE CHECK(inizio IS date(inizio, '+0 days')),
    fine TEXT NOT NULL UNIQUE CHECK(fine IS date(fine, '+0 days'))
);
CREATE TABLE IF NOT EXISTS Classe (
    classeId INTEGER PRIMARY KEY AUTOINCREMENT,
    annoScolasticoId INTEGER NOT NULL REFERENCES AnnoScolastico(annoScolasticoId) ON DELETE CASCADE ON UPDATE CASCADE,
    anno INTEGER CHECK (
        anno BETWEEN 1 AND 5
    ),
    sezione TEXT CHECK (length(sezione) = 1),
    indirizzo TEXT DEFAULT NULL,
    articolazione TEXT DEFAULT NULL,
    maxGiustificazioni INTEGER DEFAULT 2
);
CREATE TABLE IF NOT EXISTS Studente (
    studenteId INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cognome TEXT NOT NULL,
    sesso TEXT CHECK(sesso IN ('F', 'M')),
    email TEXT DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS Registro (
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId) ON DELETE CASCADE ON UPDATE CASCADE,
    classeId INTEGER NOT NULL REFERENCES Classe(classeId) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(studenteId, classeId)
);
CREATE TABLE IF NOT EXISTS Ritirato (
    studenteId INTEGER NOT NULL,
    -- REFERENCES Studente(studenteId),
    classeId INTEGER NOT NULL,
    -- REFERENCES Classe(classeId),
    giorno TEXT NOT NULL CHECK(giorno IS date(giorno, '+0 days')),
    PRIMARY KEY(studenteId, classeId, giorno),
    FOREIGN KEY(studenteId, classeId) REFERENCES Registro(studenteId, classeId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS Argomento (
    argomentoId INTEGER PRIMARY KEY AUTOINCREMENT,
    argomento TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Programmazione (
    classeId INTEGER NOT NULL REFERENCES Classe(classeId) ON DELETE CASCADE ON UPDATE CASCADE,
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (classeId, argomentoId)
);
CREATE TABLE IF NOT EXISTS Quesito (
    quesitoId INTEGER PRIMARY KEY AUTOINCREMENT,
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId) ON DELETE CASCADE ON UPDATE CASCADE,
    quesito TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Assenza (
    studenteId INTEGER NOT NULL,
    classeId INTEGER NOT NULL,
    giorno TEXT NOT NULL CHECK(giorno IS date(giorno, '+0 days')),
    PRIMARY KEY (studenteId, classeId, giorno),
    FOREIGN KEY(studenteId, classeId) REFERENCES Registro(studenteId, classeId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS Giustificazione (
    studenteId INTEGER NOT NULL,
    classeId INTEGER NOT NULL,
    giorno TEXT NOT NULL CHECK(giorno IS date(giorno, '+0 days')),
    immotivata INTEGER,
    -- 1 immotivata, 0 motivata
    PRIMARY KEY (studenteId, classeId, giorno),
    FOREIGN KEY(studenteId, classeId) REFERENCES Registro(studenteId, classeId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS Griglia (
    grigliaId INTEGER PRIMARY KEY AUTOINCREMENT,
    descrizione TEXT
);
CREATE TABLE IF NOT EXISTS PredisposizioneProva (
    predisposizioneProvaId INTEGER PRIMARY KEY AUTOINCREMENT,
    classeId INTEGER NOT NULL REFERENCES Classe(classeId) ON DELETE CASCADE ON UPDATE CASCADE,
    grigliaId INTEGER REFERENCES Griglia(grigliaId) ON DELETE CASCADE ON UPDATE CASCADE,
    descrizione TEXT NOT NULL,
    giorno TEXT NOT NULL CHECK(giorno IS date(giorno, '+0 days')) DEFAULT CURRENT_DATE,
    peso REAL DEFAULT 1 CHECK (peso IN (0.25, 0.33, 0.5, 0.75, 1)),
    numeroQuesiti INTEGER CHECK (
        numeroQuesiti IS NULL
        OR numeroQuesiti BETWEEN 1 AND 10
    )
);
CREATE TABLE IF NOT EXISTS ArgomentiProva (
    predisposizioneProvaId INTEGER NOT NULL REFERENCES PredisposizioneProva(predisposizioneProvaId) ON DELETE CASCADE ON UPDATE CASCADE,
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId) ON DELETE CASCADE ON UPDATE CASCADE,
    numeroQuesiti INTEGER CHECK (
        numeroQuesiti IS NULL
        OR numeroQuesiti BETWEEN 1 AND 10
    ),
    probabilita INTEGER CHECK (
        probabilita IS NULL
        OR probabilita BETWEEN 1 AND 100
    ),
    CHECK(
        (
            numeroQuesiti IS NULL
            AND probabilita IS NOT NULL
        )
        OR (
            numeroQuesiti IS NOT NULL
            AND probabilita IS NULL
        )
    ),
    PRIMARY KEY (predisposizioneProvaId, argomentoId)
);
CREATE TABLE IF NOT EXISTS Indicatore (
    indicatoreId INTEGER PRIMARY KEY AUTOINCREMENT,
    grigliaId INTEGER NOT NULL REFERENCES Griglia(grigliaId) ON DELETE CASCADE ON UPDATE CASCADE,
    indicatore TEXT,
    descrizione TEXT,
    peso REAL
);
CREATE TABLE IF NOT EXISTS Descrittore (
    descrittoreId INTEGER PRIMARY KEY AUTOINCREMENT,
    indicatoreId INTEGER NOT NULL REFERENCES Indicatore(indicatoreId) ON DELETE CASCADE ON UPDATE CASCADE,
    descrittore TEXT NOT NULL,
    descrizione TEXT,
    livello INTEGER CHECK (
        livello BETWEEN 0 AND 10
    )
);
CREATE TABLE Prova (
    provaId INTEGER PRIMARY KEY AUTOINCREMENT,
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId) ON DELETE CASCADE ON UPDATE CASCADE,
    predisposizioneProvaId INTEGER NOT NULL REFERENCES PredisposizioneProva(predisposizioneProvaId) ON DELETE CASCADE ON UPDATE CASCADE,
    giorno TEXT NOT NULL CHECK(giorno IS date(giorno, '+0 days'))
);
CREATE TABLE IF NOT EXISTS ValutazioneQuesito (
    provaId INTEGER NOT NULL REFERENCES Prova(provaId) ON DELETE CASCADE ON UPDATE CASCADE,
    quesitoId INTEGER NOT NULL REFERENCES Quesito(quesitoId) ON DELETE CASCADE ON UPDATE CASCADE,
    descrittoreId INTEGER NOT NULL REFERENCES Descrittore(descrittoreId) ON DELETE CASCADE ON UPDATE CASCADE,
    note TEXT,
    PRIMARY KEY (provaId, quesitoId),
    CHECK (
        descrittoreId IS NOT NULL
        OR (
            descrittoreId ISNULL
            AND note IS NOT NULL
        )
    )
);
CREATE TABLE IF NOT EXISTS ValutazioneProva (
    provaId INTEGER NOT NULL REFERENCES Prova(provaId) ON DELETE CASCADE ON UPDATE CASCADE,
    descrittoreId INTEGER NOT NULL REFERENCES Descrittore(descrittoreId) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (provaId, descrittoreId)
);
CREATE TABLE IF NOT EXISTS Verbale (
    provaId INTEGER NOT NULL REFERENCES Prova(provaId) ON DELETE CASCADE ON UPDATE CASCADE,
    voto REAL NOT NULL CHECK (round(voto * 2) - (voto * 2) < 0.01),
    note TEXT,
    PRIMARY KEY (provaId)
);
CREATE TABLE Competenza (
    competenzaId INTEGER PRIMARY KEY AUTOINCREMENT,
    competenza TEXT NOT NULL,
    cittadinanza INTEGER NOT NULL CHECK (
        cittadinanza BETWEEN 0 AND 1
    )
);
CREATE TABLE Conoscenza (
    conoscenzaId INTEGER PRIMARY KEY AUTOINCREMENT,
    competenzaId INTEGER NOT NULL REFERENCES Competenza(competenzaId) ON DELETE CASCADE ON UPDATE CASCADE,
    conoscenza TEXT NOT NULL,
    obiettivoMinino INTEGER NOT NULL CHECK (
        obiettivoMinino BETWEEN 0 AND 1
    )
);
CREATE TABLE Abilita (
    abilitaId INTEGER PRIMARY KEY AUTOINCREMENT,
    competenzaId INTEGER NOT NULL REFERENCES Competenza(competenzaId) ON DELETE CASCADE ON UPDATE CASCADE,
    abilita TEXT NOT NULL,
    obiettivoMinino INTEGER NOT NULL CHECK (
        obiettivoMinino BETWEEN 0 AND 1
    )
);
CREATE TABLE Traguardo (
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId) ON DELETE CASCADE ON UPDATE CASCADE,
    competenzaId INTEGER NOT NULL REFERENCES Competenza(competenzaId) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (argomentoId, competenzaId)
);
CREATE VIEW vista_classi (classeId, classe) AS
SELECT classeId,
    anno || ' ' || sezione || ' ' || articolazione AS classe
FROM Classe
    INNER JOIN AnnoScolastico USING (annoScolasticoId)
WHERE date() BETWEEN inizio AND fine
ORDER BY anno,
    sezione,
    articolazione;