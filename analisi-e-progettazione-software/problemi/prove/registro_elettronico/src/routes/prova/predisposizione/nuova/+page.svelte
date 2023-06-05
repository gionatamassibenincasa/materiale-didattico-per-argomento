<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import type { PageData } from './$types';
	import DataInspector from '$lib/components/DataInspector.svelte';

	export let data: PageData;

	import { Form, Button, ButtonSet, NumberInput, TextArea } from 'carbon-components-svelte';
	import Add from 'carbon-icons-svelte/lib/Add.svelte';
	import TrashCan from 'carbon-icons-svelte/lib/TrashCan.svelte';
	import NextFilled from 'carbon-icons-svelte/lib/NextFilled.svelte';
	import Edit from 'carbon-icons-svelte/lib/Edit.svelte';

	let classeId: number;
	let giorno: string;

	$: {
		classeId = parseInt($page.url.searchParams.get('classeId')) || 0;
		console.log(data);
	}

	/*
	predisposizioneProvaId: number;
	classeId: number;
	grigliaId: number;
	descrizione: string;
	giorno: string;
	peso: number;
	numeroArgomenti: number;
	numeroQuesiti: number;
	descrizioneGriglia: string
	*/
</script>

<h1>Scelta della struttura della prova</h1>

<Form method="get" action="candidati">
	<input type="hidden" name="giorno" value={giorno} />
	<input type="hidden" name="classeId" value={classeId} />
	<TextArea>Descrizione</TextArea>
	<TextArea>Griglia</TextArea>

	<Button type="submit">Selezione dei candidati</Button>
</Form>

<DataInspector {data} />
