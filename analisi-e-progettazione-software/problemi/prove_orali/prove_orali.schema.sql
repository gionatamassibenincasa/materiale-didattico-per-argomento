CREATE TABLE IF NOT EXISTS AnnoScolastico (
    annoScolasticoId INTEGER PRIMARY KEY,
    testo TEXT NOT NULL UNIQUE CHECK (length(testo) = 7),
    inizio TEXT NOT NULL UNIQUE,
    fine TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS Classe (
    classeId INTEGER PRIMARY KEY,
    annoScolasticoId INTEGER REFERENCES AnnoScolastico(annoScolasticoId),
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
    sesso TEXT CHECK(sesso in ('F', 'M'),
    email TEXT,
);

CREATE TABLE IF NOT EXISTS Registro (
    studenteId INTEGER REFERENCES Studente(studenteId),
    classeId INTEGER REFERENCES Classe(classeId),
    PRIMARY KEY(studenteId, classeId)
);
CREATE TABLE IF NOT EXISTS Argomento (
    argomentoId INTEGER PRIMARY KEY,
    argomento TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Programmazione (
    classeId INTEGER REFERENCES Classe(classeId),
    argomentoId INTEGER REFERENCES Argomento(argomentoId),
    PRIMARY KEY (classeId, argomentoId)
);
CREATE TABLE IF NOT EXISTS Quesito (
    quesitoId INTEGER PRIMARY KEY,
    argomentoId INTEGER REFERENCES Argomento(argomentoId),
    quesito TEXT
);
CREATE TABLE IF NOT EXISTS Assenza (
    studenteId INTEGER REFERENCES Studente(studenteId),
    data TEXT NOT NULL,
    PRIMARY KEY (studenteId, data)
);
CREATE TABLE IF NOT EXISTS Giustificazione (
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    data TEXT NOT NULL,
    immotivata INTEGER,
    -- 1 immotivata, 0 motivata
    PRIMARY KEY (studenteId, data)
);
CREATE TABLE IF NOT EXISTS Interrogazione (
    interrogazioneId INTEGER PRIMARY KEY,
    studenteId INTEGER NOT NULL REFERENCES Studente(studenteId),
    argomentoId INTEGER NOT NULL REFERENCES Argomento(argomentoId),
    data TEXT NOT NULL,
    voto REAL NOT NULL,
    descrizione TEXT
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
CREATE TABLE IF NOT EXISTS Verbale (
    interrogazioneId INTEGER NOT NULL REFERENCES Interrogazione(interrogazioneId),
    quesitoId INTEGER NOT NULL REFERENCES Quesito(quesitoId),
    PRIMARY KEY (interrogazioneId, quesitoId)
);
CREATE TABLE IF NOT EXISTS Valutazione (
    interrogazioneId INTEGER NOT NULL REFERENCES Interrogazione(interrrogazioneId),
    descrittoreId INTEGER NOT NULL REFERENCES Descrittore(descrittoreId),
    PRIMARY KEY (interrogazioneId, descrittoreId)
);
