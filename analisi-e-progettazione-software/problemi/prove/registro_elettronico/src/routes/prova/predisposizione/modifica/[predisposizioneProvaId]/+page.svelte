<script lang="ts">
	import type { PageData } from './$types';
	import { Form, NumberInput, TextArea, TextInput } from 'carbon-components-svelte';
	import DataInspector from '$lib/components/DataInspector.svelte';

	export let data: PageData;

	let {
		predisposizioneProvaId,
		classeId,
		grigliaId,
		griglia,
		descrizione,
		giorno,
		peso,
		numeroQuesiti,
		numeroArgomenti
	} = data;
</script>

<h1>Modifica la struttura della prova</h1>

<Form>
	<NumberInput
		label="Id"
		name="predisposizioneProvaId"
		disabled
		bind:value={data.predisposizioneProvaId}
	/>
	<input type="hidden" name="classeId" value={classeId} />
	<TextInput
		name="descrizione"
		labelText="Descrizione"
		placeholder="Breve descrizione della prova"
		bind:value={descrizione}
	/>
</Form>

<DataInspector {data} />
