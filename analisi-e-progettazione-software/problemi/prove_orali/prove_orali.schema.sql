CREATE TABLE IF NOT EXISTS AnnoScolastico (
    annoScolasticoId INTEGER PRIMARY KEY,
    testo TEXT NOT NULL UNIQUE CHECK (length(testo) = 7),
    inizio TEXT NOT NULL UNIQUE CHECK(inizio IS date(inizio, '+0 days')),
    fine TEXT NOT NULL UNIQUE CHECK(fine IS date(fine, '+0 days'))
);
CREATE TABLE IF NOT EXISTS PeriodoValutazione (
    periodoValutazioneId INTEGER PRIMARY KEY,
    annoScolasticoId INTEGER NOT NULL REFERENCES AnnoScolastico(annoScolasticoId),
    descrizione TEXT NOT NULL,
    inizio TEXT NOT NULL UNIQUE CHECK(inizio IS date(inizio, '+0 days')),
    fine TEXT NOT NULL UNIQUE CHECK(fine IS date(fine, '+0 days'))
);
CREATE TABLE IF NOT EXISTS Classe (
    classeId INTEGER PRIMARY KEY,
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
    studenteId INTEGER PRIMARY KEY,
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
CREATE TABLE IF NOT EXISTS Argomento (
    argomentoId INTEGER PRIMARY KEY,
    argomento TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Programmazione (
    classeId INTEGER NOT NULL REFERENCES Classe(classeId),
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    PRIMARY KEY (classeId, argomentoId)
);
CREATE TABLE IF NOT EXISTS Quesito (
    quesitoId INTEGER PRIMARY KEY,
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
CREATE TABLE IF NOT EXISTS ArgomentiColloquio (
    argomentiColloquioId INTEGER PRIMARY KEY,
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    descrizione TEXT NOT NULL,
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days')),
    numeroDomande INTEGER CHECK (
        numeroDomande IS NULL
        OR numeroDomande BETWEEN 1 AND 4
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
    )
);
CREATE TABLE IF NOT EXISTS Indicatore (
    indicatoreId INTEGER PRIMARY KEY,
    indicatore TEXT,
    descrizione TEXT,
    peso REAL
);
CREATE TABLE IF NOT EXISTS Descrittore (
    descrittoreId INTEGER PRIMARY KEY,
    indicatoreId INTEGER NOT NULL REFERENCES Indicatore(indicatoreId),
    descrittore TEXT NOT NULL,
    descrizione TEXT,
    livello INTEGER CHECK (
        livello BETWEEN 0 AND 10
    )
);
CREATE TABLE Colloquio (
    colloquioId INTEGER PRIMARY KEY,
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    argomentiColloquioId INTEGER NOT NULL REFERENCES ArgomentiColloquio(ArgomentiColloquioId),
    data TEXT NOT NULL CHECK(data IS date(data, '+0 days'))
);
CREATE TABLE IF NOT EXISTS ValutazioneQuesito (
    colloquioId INTEGER NOT NULL REFERENCES Colloquio(colloquioId),
    descrittoreId INTEGER NOT NULL REFERENCES Descrittore(descrittoreId),
    PRIMARY KEY (colloquioId, descrittoreId)
);
CREATE TABLE IF NOT EXISTS Verbale (
    colloquioId INTEGER NOT NULL REFERENCES Colloquio(colloquioId),
    quesitoId INTEGER NOT NULL REFERENCES Quesito(quesitoId),
    PRIMARY KEY (colloquioId, quesitoId)
);