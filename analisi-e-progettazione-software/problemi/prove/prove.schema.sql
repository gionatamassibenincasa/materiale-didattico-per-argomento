CREATE TABLE IF NOT EXISTS AnnoScolastico (
    annoScolasticoId INTEGER PRIMARY KEY AUTOINCREMENT,
    testo TEXT NOT NULL UNIQUE CHECK (length(testo) = 7),
    inizio TEXT NOT NULL UNIQUE CHECK(inizio IS date(inizio, '+0 days')),
    fine TEXT NOT NULL UNIQUE CHECK(fine IS date(fine, '+0 days'))
);
CREATE TABLE IF NOT EXISTS PeriodoValutazione (
    periodoValutazioneId INTEGER PRIMARY KEY AUTOINCREMENT,
    annoScolasticoId INTEGER NOT NULL REFERENCES AnnoScolastico(annoScolasticoId),
    descrizione TEXT NOT NULL,
    inizio TEXT NOT NULL UNIQUE CHECK(inizio IS date(inizio, '+0 days')),
    fine TEXT NOT NULL UNIQUE CHECK(fine IS date(fine, '+0 days'))
);
CREATE TABLE IF NOT EXISTS Classe (
    classeId INTEGER PRIMARY KEY AUTOINCREMENT,
    annoScolasticoId INTEGER NOT NULL REFERENCES AnnoScolastico(annoScolasticoId),
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
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    classeId INTEGER NOT NULL REFERENCES Classe(classeId),
    PRIMARY KEY(studenteId, classeId)
);
CREATE TABLE IF NOT EXISTS Ritirato (
    studenteId INTEGER NOT NULL,
    -- REFERENCES Studente(studenteId),
    classeId INTEGER NOT NULL,
    -- REFERENCES Classe(classeId),
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days')),
    PRIMARY KEY(studenteId, classeId, data),
    FOREIGN KEY(studenteId, classeId) REFERENCES Registro(studenteId, classeId)
);
CREATE TABLE IF NOT EXISTS Argomento (
    argomentoId INTEGER PRIMARY KEY AUTOINCREMENT,
    argomento TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Programmazione (
    classeId INTEGER NOT NULL REFERENCES Classe(classeId),
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    PRIMARY KEY (classeId, argomentoId)
);
CREATE TABLE IF NOT EXISTS Quesito (
    quesitoId INTEGER PRIMARY KEY AUTOINCREMENT,
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    quesito TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Assenza (
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days')),
    PRIMARY KEY (studenteId, data)
);
CREATE TABLE IF NOT EXISTS Giustificazione (
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days')),
    immotivata INTEGER,
    -- 1 immotivata, 0 motivata
    PRIMARY KEY (studenteId, data)
);
CREATE TABLE IF NOT EXISTS Griglia (
    grigliaId INTEGER PRIMARY KEY AUTOINCREMENT,
    descrizione TEXT
);
CREATE TABLE IF NOT EXISTS PredisposizioneProva (
    predisposizioneProvaId INTEGER PRIMARY KEY AUTOINCREMENT,
    classeId INTEGER NOT NULL REFERENCES Classe(classeId),
    grigliaId INTEGER NOT NULL REFERENCES Griglia(grigliaId),
    descrizione TEXT NOT NULL,
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days')) DEFAULT CURRENT_DATE,
    numeroDomande INTEGER CHECK (
        numeroDomande IS NULL
        OR numeroDomande BETWEEN 1 AND 10
    )
);
CREATE TABLE IF NOT EXISTS ArgomentiProva (
    predisposizioneProvaId INTEGER NOT NULL REFERENCES PredisposizioneProva(predisposizioneProvaId),
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    numeroDomande INTEGER CHECK (
        numeroDomande IS NULL
        OR numeroDomande BETWEEN 1 AND 10
    ),
    probabilita INTEGER CHECK (
        probabilita IS NULL
        OR probabilita BETWEEN 1 AND 100
    ),
    CHECK(
        (
            numeroDomande IS NULL
            AND probabilita IS NOT NULL
        )
        OR (
            numeroDomande IS NOT NULL
            AND probabilita IS NULL
        )
    ),
    PRIMARY KEY (predisposizioneProvaId, argomentoId)
);
CREATE TABLE IF NOT EXISTS Indicatore (
    indicatoreId INTEGER PRIMARY KEY AUTOINCREMENT,
    grigliaId INTEGER NOT NULL REFERENCES Griglia(grigliaId),
    indicatore TEXT,
    descrizione TEXT,
    peso REAL
);
CREATE TABLE IF NOT EXISTS Descrittore (
    descrittoreId INTEGER PRIMARY KEY AUTOINCREMENT,
    indicatoreId INTEGER NOT NULL REFERENCES Indicatore(indicatoreId),
    descrittore TEXT NOT NULL,
    descrizione TEXT,
    livello INTEGER CHECK (
        livello BETWEEN 0 AND 10
    )
);
CREATE TABLE Prova (
    provaId INTEGER PRIMARY KEY AUTOINCREMENT,
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    predisposizioneProvaId INTEGER NOT NULL REFERENCES PredisposizioneProva(predisposizioneProvaId),
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days'))
);
CREATE TABLE IF NOT EXISTS ValutazioneQuesito (
    provaId INTEGER NOT NULL REFERENCES Prova(provaId),
    descrittoreId INTEGER NOT NULL REFERENCES Descrittore(descrittoreId),
    PRIMARY KEY (provaId, descrittoreId)
);
CREATE TABLE IF NOT EXISTS Verbale (
    provaId INTEGER NOT NULL REFERENCES Prova(provaId),
    quesitoId INTEGER NOT NULL REFERENCES Quesito(quesitoId),
    PRIMARY KEY (provaId, quesitoId)
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
    competenzaId INTEGER NOT NULL REFERENCES Competenza(competenzaId),
    conoscenza TEXT NOT NULL,
    obiettivoMinino INTEGER NOT NULL CHECK (
        obiettivoMinino BETWEEN 0 AND 1
    )
);
CREATE TABLE Abilita (
    abilitaId INTEGER PRIMARY KEY AUTOINCREMENT,
    competenzaId INTEGER NOT NULL REFERENCES Competenza(competenzaId),
    abilita TEXT NOT NULL,
    obiettivoMinino INTEGER NOT NULL CHECK (
        obiettivoMinino BETWEEN 0 AND 1
    )
);
CREATE TABLE Traguardo (
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    competenzaId INTEGER NOT NULL REFERENCES Competenza(competenzaId),
    PRIMARY KEY (argomentoId, competenzaId)
);