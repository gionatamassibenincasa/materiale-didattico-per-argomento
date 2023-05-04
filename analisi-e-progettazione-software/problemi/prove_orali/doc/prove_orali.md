**AnnoScolastico** (  **annoScolasticoId**: INTEGER, testo: TEXT, inizio: TEXT, fine: TEXT)

**ArgomentiColloquio** (  **argomentiColloquioId**: INTEGER, _argomentoId_: INTEGER -> Argomento(argomentoId), descrizione: TEXT, data: TEXT, numeroDomande: INTEGER, probabilita: INTEGER)

**Argomento** (  **argomentoId**: INTEGER, argomento: TEXT)

**Assenza** (  ***studenteId***: INTEGER -> Studente(studenteId), **data**: TEXT)

**Classe** (  **classeId**: INTEGER, _annoScolasticoId_: INTEGER -> AnnoScolastico(annoScolasticoId), anno: INTEGER, sezione: TEXT, indirizzo: TEXT, articolazione: TEXT, maxGiustificazioni: INTEGER)

**Colloquio** (  **colloquioId**: INTEGER, _studenteId_: INTEGER -> Studente(studenteId), _argomentiColloquioId_: INTEGER -> ArgomentiColloquio(argomentiColloquioId), data: TEXT)

**Descrittore** (  **descrittoreId**: INTEGER, _indicatoreId_: INTEGER -> Indicatore(indicatoreId), descrittore: TEXT, descrizione: TEXT, livello: INTEGER)

**Giustificazione** (  ***studenteId***: INTEGER -> Studente(studenteId), **data**: TEXT, immotivata: INTEGER)

**Indicatore** (  **indicatoreId**: INTEGER, indicatore: TEXT, descrizione: TEXT, peso: REAL)

**PeriodoValutazione** (  **periodoValutazioneId**: INTEGER, _annoScolasticoId_: INTEGER -> AnnoScolastico(annoScolasticoId), descrizione: TEXT, inizio: TEXT, fine: TEXT)

**Programmazione** (  ***classeId***: INTEGER -> Classe(classeId), ***argomentoId***: INTEGER -> Argomento(argomentoId))

**Quesito** (  **quesitoId**: INTEGER, _argomentoId_: INTEGER -> Argomento(argomentoId), quesito: TEXT)

**Registro** (  ***studenteId***: INTEGER -> Studente(studenteId), ***classeId***: INTEGER -> Classe(classeId))

**Ritirato** (  ***studenteId***: INTEGER -> Registro(studenteId), ***classeId***: INTEGER -> Registro(classeId), **data**: TEXT)

**Studente** (  **studenteId**: INTEGER, nome: TEXT, cognome: TEXT, sesso: TEXT, email: TEXT)

**ValutazioneQuesito** (  ***colloquioId***: INTEGER -> Colloquio(colloquioId), ***descrittoreId***: INTEGER -> Descrittore(descrittoreId))

**Verbale** (  ***colloquioId***: INTEGER -> Colloquio(colloquioId), ***quesitoId***: INTEGER -> Quesito(quesitoId))
