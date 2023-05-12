**AnnoScolastico** (  **annoScolasticoId**: INTEGER, testo: TEXT, inizio: TEXT, fine: TEXT)

**PeriodoValutazione** (  **periodoValutazioneId**: INTEGER, _annoScolasticoId_: INTEGER -> AnnoScolastico(annoScolasticoId), descrizione: TEXT, inizio: TEXT, fine: TEXT)

**Classe** (  **classeId**: INTEGER, _annoScolasticoId_: INTEGER -> AnnoScolastico(annoScolasticoId), anno: INTEGER, sezione: TEXT, indirizzo: TEXT, articolazione: TEXT, maxGiustificazioni: INTEGER)

**Studente** (  **studenteId**: INTEGER, nome: TEXT, cognome: TEXT, sesso: TEXT, email: TEXT)

**Registro** (  ***studenteId***: INTEGER -> Studente(studenteId), ***classeId***: INTEGER -> Classe(classeId))

**Ritirato** (  ***studenteId***: INTEGER -> Registro(studenteId), ***classeId***: INTEGER -> Registro(classeId), **data**: TEXT)

**Argomento** (  **argomentoId**: INTEGER, argomento: TEXT)

**Programmazione** (  ***classeId***: INTEGER -> Classe(classeId), ***argomentoId***: INTEGER -> Argomento(argomentoId))

**Quesito** (  **quesitoId**: INTEGER, _argomentoId_: INTEGER -> Argomento(argomentoId), quesito: TEXT)

**Assenza** (  ***studenteId***: INTEGER -> Studente(studenteId), **data**: TEXT)

**Giustificazione** (  ***studenteId***: INTEGER -> Studente(studenteId), **data**: TEXT, immotivata: INTEGER)

**PredisposizioneColloquio** (  **predisposizioneColloquioId**: INTEGER, descrizione: TEXT, data: TEXT, numeroDomande: INTEGER)

**ArgomentiColloquio** (  ***predisposizioneColloquioId***: INTEGER -> PredisposizioneColloquio(predisposizioneColloquioId), ***argomentoId***: INTEGER -> Argomento(argomentoId), descrizione: TEXT, numeroDomande: INTEGER, probabilita: INTEGER)

**Indicatore** (  **indicatoreId**: INTEGER, indicatore: TEXT, descrizione: TEXT, peso: REAL)

**Descrittore** (  **descrittoreId**: INTEGER, _indicatoreId_: INTEGER -> Indicatore(indicatoreId), descrittore: TEXT, descrizione: TEXT, livello: INTEGER)

**Colloquio** (  **colloquioId**: INTEGER, _studenteId_: INTEGER -> Studente(studenteId), _predisposizioneColloquioId_: INTEGER -> PredisposizioneColloquio(predisposizioneColloquioId), data: TEXT)

**ValutazioneQuesito** (  ***colloquioId***: INTEGER -> Colloquio(colloquioId), ***descrittoreId***: INTEGER -> Descrittore(descrittoreId))

**Verbale** (  ***colloquioId***: INTEGER -> Colloquio(colloquioId), ***quesitoId***: INTEGER -> Quesito(quesitoId))

**Competenza** (  **competenzaId**: INTEGER, competenza: TEXT, cittadinanza: INTEGER)

**Conoscenza** (  **conoscenzaId**: INTEGER, _competenzaId_: INTEGER -> Competenza(competenzaId), conoscenza: TEXT, obiettivoMinino: INTEGER)

**Abilita** (  **abilitaId**: INTEGER, _competenzaId_: INTEGER -> Competenza(competenzaId), abilita: TEXT, obiettivoMinino: INTEGER)

**Traguardo** (  ***argomentoId***: INTEGER -> Argomento(argomentoId), ***competenzaId***: INTEGER -> Competenza(competenzaId))

