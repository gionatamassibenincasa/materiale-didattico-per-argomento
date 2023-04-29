**AnnoScolastico** (  **annoScolasticoId**: INTEGER, testo: TEXT, inizio: TEXT, fine: TEXT)

**Classe** (  **classeId**: INTEGER, _annoScolasticoId_: INTEGER -> AnnoScolastico(annoScolasticoId), anno: INTEGER, sezione: TEXT, indirizzo: TEXT, articolazione: TEXT, maxGiustificazioni: INTEGER)

**Studente** (  **studenteId**: INTEGER, nome: TEXT, cognome: TEXT, sesso: TEXT, email: TEXT)

**Registro** (  ***studenteId***: INTEGER -> Studente(studenteId), ***classeId***: INTEGER -> Classe(classeId))

**Argomento** (  **argomentoId**: INTEGER, argomento: TEXT)

**Programmazione** (  ***classeId***: INTEGER -> Classe(classeId), ***argomentoId***: INTEGER -> Argomento(argomentoId))

**Quesito** (  **quesitoId**: INTEGER, _argomentoId_: INTEGER -> Argomento(argomentoId), quesito: TEXT)

**Assenza** (  ***studenteId***: INTEGER -> Studente(studenteId), **data**: TEXT)

**Giustificazione** (  ***studenteId***: INTEGER -> Studente(studenteId), **data**: TEXT, immotivata: INTEGER)

**ArgomentiColloquio** (  **argomentiColloquioId**: INTEGER, _argomentoId_: INTEGER -> Argomento(argomentoId), numeroDomande: INTEGER, probabilita: INTEGER)

**Indicatore** (  **indicatoreId**: INTEGER, indicatore: TEXT, descrizione: TEXT, peso: REAL)

**Descrittore** (  **descrittoreId**: INTEGER, _indicatoreId_: INTEGER -> Indicatore(indicatoreId), descrittore: TEXT, descrizione: TEXT, livello: INTEGER)

**Colloquio** (  **colloquioId**: INTEGER, _studenteId_: INTEGER -> Studente(studenteId), _argomentiColloquioId_: INTEGER -> ArgomentiColloquio(argomentiColloquioId), data: TEXT)

**ValutazioneQuesito** (  ***colloquioId***: INTEGER -> Colloquio(colloquioId), ***descrittoreId***: INTEGER -> Descrittore(descrittoreId))

**Verbale** (  ***colloquioId***: INTEGER -> Colloquio(colloquioId), ***quesitoId***: INTEGER -> Quesito(quesitoId))

