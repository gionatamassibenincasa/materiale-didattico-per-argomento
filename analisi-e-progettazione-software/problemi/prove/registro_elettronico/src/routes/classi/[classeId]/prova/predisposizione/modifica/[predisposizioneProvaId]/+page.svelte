<script lang="ts">
	import type { PageData } from './$types';
	import {
		Form,
		NumberInput,
		Select,
		SelectItem,
		TextInput,
		DatePicker,
		DatePickerInput,
		MultiSelect
	} from 'carbon-components-svelte';
	import DataInspector from '$lib/components/DataInspector.svelte';
	import type { MultiSelectItem } from 'carbon-components-svelte/types/MultiSelect/MultiSelect.svelte';

	/***/
	export interface DataPippo {
		predisposizioneProva: PredisposizioneProva;
		griglie: Griglie[];
		argomenti: Argomenti[];
		peso: any;
		descrizione: string;
		predisposizioneProvaId: any;
	}

	export interface PredisposizioneProva {
		predisposizioneProvaId: number;
		classeId: number;
		grigliaId: number;
		descrizione: string;
		giorno: string;
		peso: number;
		numeroQuesiti: number;
		griglia: string;
		numeroArgomenti: number;
	}

	export interface Griglie {
		grigliaId: number;
		descrizione: string;
	}

	export interface Argomenti {
		argomentoId: number;
		argomento: string;
	}
	/***/

	export let data: DataPippo; //PageData;
	function zeroPad(number: number, width: number): string {
		var string: string = String(number);
		while (string.length < width) string = '0' + string;
		return string;
	}

	let dt = new Date(data.predisposizioneProva.giorno),
		month: string = zeroPad(dt.getMonth() + 1, 2),
		day: string = zeroPad(dt.getDate(), 2),
		year: string = String(dt.getFullYear()),
		dateFormat: string = 'd/m/Y',
		giornoVisualizzato: string = [day, month, year].join('/');

	let opzioniArgomenti = data.argomenti.map((a: Argomenti): MultiSelectItem => {
		return { id: a.argomentoId, text: a.argomento };
	});
</script>

<h1>Modifica la struttura della prova</h1>

<Form>
	<NumberInput
		label="Id"
		name="predisposizioneProvaId"
		disabled
		bind:value={data.predisposizioneProva.predisposizioneProvaId}
	/>
	<input type="hidden" name="classeId" value={data.predisposizioneProva.classeId} />
	<TextInput
		name="descrizione"
		labelText="Descrizione"
		placeholder="Breve descrizione della prova"
		bind:value={data.predisposizioneProva.descrizione}
	/>
	<input name="giorno" type="hidden" value={data.predisposizioneProva.giorno} />
	<DatePicker bind:value={giornoVisualizzato} locale="it" {dateFormat}>
		<DatePickerInput
			labelText="Data"
			helperText="Esempio: 25/12/1990"
			placeholder="gg/mm/aaaa"
			disabled
		/>
	</DatePicker>
	<NumberInput name="peso" label="Peso" bind:value={data.predisposizioneProva.peso} />
	<Select name="grigliaId" selected={data.predisposizioneProva.grigliaId}>
		{#each data.griglie as g}
			<SelectItem value={g.grigliaId} text={g.descrizione} />
		{/each}
	</Select>
	<MultiSelect
		titleText="Argomenti"
		label="Seleziona gli argomenti della prova"
		items={opzioniArgomenti}
	/>
</Form>

<DataInspector {data} />
