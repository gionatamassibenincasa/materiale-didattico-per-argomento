erDiagram
 AnnoScolastico {
  INTEGER annoScolasticoId PK
  TEXT testo
  TEXT inizio
  TEXT fine
 }

 PeriodoValutazione {
  INTEGER periodoValutazioneId PK
  INTEGER annoScolasticoId FK
  TEXT descrizione
  TEXT inizio
  TEXT fine
 }

 Classe {
  INTEGER classeId PK
  INTEGER annoScolasticoId FK
  INTEGER anno
  TEXT sezione
  TEXT indirizzo
  TEXT articolazione
  INTEGER maxGiustificazioni
 }

 Studente {
  INTEGER studenteId PK
  TEXT nome
  TEXT cognome
  TEXT sesso
  TEXT email
 }

 Registro {
  INTEGER studenteId PK
  INTEGER classeId PK
 }

 Ritirato {
  INTEGER studenteId PK
  INTEGER classeId PK
  TEXT data PK
 }

 Argomento {
  INTEGER argomentoId PK
  TEXT argomento
 }

 Programmazione {
  INTEGER classeId PK
  INTEGER argomentoId PK
 }

 Quesito {
  INTEGER quesitoId PK
  INTEGER argomentoId FK
  TEXT quesito
 }

 Assenza {
  INTEGER studenteId PK
  TEXT data PK
 }

 Giustificazione {
  INTEGER studenteId PK
  TEXT data PK
  INTEGER immotivata
 }

 ArgomentiColloquio {
  INTEGER argomentiColloquioId PK
  INTEGER argomentoId FK
  TEXT descrizione
  TEXT data
  INTEGER numeroDomande
  INTEGER probabilita
 }

 Indicatore {
  INTEGER indicatoreId PK
  TEXT indicatore
  TEXT descrizione
  REAL peso
 }

 Descrittore {
  INTEGER descrittoreId PK
  INTEGER indicatoreId FK
  TEXT descrittore
  TEXT descrizione
  INTEGER livello
 }

 Colloquio {
  INTEGER colloquioId PK
  INTEGER studenteId FK
  INTEGER argomentiColloquioId FK
  TEXT data
 }

 ValutazioneQuesito {
  INTEGER colloquioId PK
  INTEGER descrittoreId PK
 }

 Verbale {
  INTEGER colloquioId PK
  INTEGER quesitoId PK
 }

 PeriodoValutazione }o--|| AnnoScolastico : annoScolasticoId
 Classe }o--|| AnnoScolastico : annoScolasticoId
 Registro }o--|| Classe : classeId
 Registro }o--|| Studente : studenteId
 Ritirato }o--|| Registro : studenteId
 Ritirato }o--|| Registro : classeId
 Programmazione }o--|| Argomento : argomentoId
 Programmazione }o--|| Classe : classeId
 Quesito }o--|| Argomento : argomentoId
 Assenza }o--|| Studente : studenteId
 Giustificazione }o--|| Studente : studenteId
 ArgomentiColloquio }o--|| Argomento : argomentoId
 Descrittore }o--|| Indicatore : indicatoreId
 Colloquio }o--|| ArgomentiColloquio : argomentiColloquioId
 Colloquio }o--|| Studente : studenteId
 ValutazioneQuesito }o--|| Descrittore : descrittoreId
 ValutazioneQuesito }o--|| Colloquio : colloquioId
 Verbale }o--|| Quesito : quesitoId
 Verbale }o--|| Colloquio : colloquioId

