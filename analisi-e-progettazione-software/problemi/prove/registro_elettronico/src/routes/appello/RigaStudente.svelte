<script lang="ts">
	import { page } from '$app/stores';
	import { TableRow, TableHead, TableCell, Toggle } from 'carbon-components-svelte';

	export let pos: number,
		studenteId: number,
		cognome: string,
		nome: string,
		assenza: boolean,
		giustificazioneDovuta: boolean,
		giustificazioneAccordata: boolean,
		residuoGiustificazioni: number,
		classeId: number,
		giorno: string;
	// gestisce il caso dell'aggiornamento (UPDATE) del tipo di giustificazione
	let aggiornamentoGiaEffettuato = false;

	async function toggleAssenza(evt: CustomEvent) {
		if (evt.detail.toggled) {
			// Togli le eventuali giustificazioni
			giustificazioneDovuta = false;
			giustificazioneAccordata = false;
			// Controlla il db
			console.log(`INSERT - Assenza (${studenteId}, ${classeId}, ${giorno})`);
			const esito = await (
				await fetch(`/api/assenza`, {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({
						studenteId: studenteId,
						classeId: classeId,
						giorno: giorno
					})
				})
			).json();
			console.log(esito);
		} else {
			console.log(`DELETE - Assenza (${studenteId}, ${classeId}, ${giorno})`);
			const esito = await (
				await fetch(`/api/assenza`, {
					method: 'DELETE',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ studenteId: studenteId, classeId: classeId, giorno: giorno })
				})
			).json();
			console.log(esito);
		}
	}

	enum TipoGiustificazione {
		DOVUTA = 0,
		ACCORDATA = 1
	}

	async function toggleGiustificazione(sorgente: TipoGiustificazione, stato: boolean) {
		if (stato === false) {
			if (aggiornamentoGiaEffettuato) {
				aggiornamentoGiaEffettuato = false;
				return;
			}
			// TODO cancella giustificazione
			console.log(
				`DELETE FROM Giustificazione WHEN studenteId = ${studenteId} AND classe = ${classeId} AND giorno = '${giorno}'`
			);
			const esito = await (
				await fetch(`/api/giustificazione`, {
					method: 'DELETE',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ studenteId: studenteId, classeId: classeId, giorno: giorno })
				})
			).json();
			console.log(esito);
			return;
		}
		// Se era registrata una giustificazione, aggiorna il tipo di giustificazione
		if (giustificazioneAccordata && giustificazioneDovuta) {
			aggiornamentoGiaEffettuato = true;
			if (sorgente === TipoGiustificazione.DOVUTA) giustificazioneAccordata = false;
			else giustificazioneDovuta = false;
			console.log(
				`UPDATE Giustificazione SET immotivata = ${sorgente} WHEN studenteId = ${studenteId} AND classe = ${classeId} AND giorno = '${giorno}'`
			);
			const esito = await fetch(`/api/giustificazione`, {
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					studenteId: studenteId,
					classeId: classeId,
					giorno: giorno,
					immotivata: sorgente as number
				})
			});
			console.log(esito);
			return;
		} else {
			// TODO inserisci giustificazione
			console.log(
				`Inserisci. INSERT INTO Giustificazione VALUES (${studenteId}, ${classeId}, ${giorno}, ${sorgente})`
			);
			const esito = await fetch(`/api/giustificazione`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					studenteId: studenteId,
					classeId: classeId,
					giorno: giorno,
					immotivata: sorgente as number
				})
			});
			console.log(esito);
		}
	}

	async function toggleGiustificazioneDovuta(evt: Event): Promise<void> {
		return await toggleGiustificazione(TipoGiustificazione.DOVUTA, evt.detail.toggled);
	}
	async function toggleGiustificazioneAccordata(evt: CustomEvent) {
		return await toggleGiustificazione(TipoGiustificazione.ACCORDATA, evt.detail.toggled);
	}
</script>

<TableRow>
	<TableHead>{pos}</TableHead>
	<TableCell><strong>{cognome}</strong></TableCell>
	<TableCell>{nome}</TableCell>
	<TableCell><Toggle bind:toggled={assenza} on:toggle={toggleAssenza} /></TableCell>
	<TableCell>{residuoGiustificazioni}</TableCell>
	<TableCell
		><Toggle
			bind:toggled={giustificazioneDovuta}
			disabled={assenza}
			on:toggle={toggleGiustificazioneDovuta}
		>
			<span slot="labelA" style="color: red">No</span>
			<span slot="labelB" style="color: green">Yes</span>
		</Toggle></TableCell
	>
	<TableCell
		><Toggle
			bind:toggled={giustificazioneAccordata}
			disabled={assenza || residuoGiustificazioni <= 0}
			on:toggle={toggleGiustificazioneAccordata}
		/></TableCell
	>
</TableRow>
