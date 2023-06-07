<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import type { PageData } from './$types';
	import DataInspector from '$lib/components/DataInspector.svelte';

	export let data: PageData;

	import {
		Button,
		Table,
		TableContainer,
		TableHeader,
		TableBody,
		TableRow,
		TableHead,
		TableCell,
		ButtonSet,
		Row,
		Column
	} from 'carbon-components-svelte';
	import Add from 'carbon-icons-svelte/lib/Add.svelte';
	import RigaStrutturaProva from './RigaStrutturaProva.svelte';

	let classeId: number;
	let giorno: string;

	$: {
		classeId = parseInt($page.url.searchParams.get('classeId')) || 0;
		giorno = $page.url.searchParams.get('giorno') || '0000-01-01';
		console.log(data);
	}

	function nuovo() {
		goto(`predisposizione/nuova/?classeId=${classeId}`);
	}
</script>

<h1>Scelta della struttura della prova</h1>
<Row>
	<Column><Button icon={Add} iconDescription="Nuova struttura" on:click={nuovo} /></Column>
</Row>
<TableContainer>
	<Table zebra>
		<TableHead>
			<TableRow>
				<TableHeader>Descrizione</TableHeader>
				<TableHeader>Data creazione</TableHeader>
				<TableHeader>Griglia</TableHeader>
				<TableHeader>Numero argomenti</TableHeader>
				<TableHeader>Numero quesiti</TableHeader>
				<TableHeader>Peso</TableHeader>
				<TableHeader>Azioni</TableHeader>
			</TableRow>
		</TableHead>
		<TableBody>
			{#each data.data as p}
				<RigaStrutturaProva
					predisposizioneProvaId={p.predisposizioneProvaId}
					classeId={p.classeId}
					descrizione={p.descrizione}
					giorno={p.giorno}
					griglia={p.griglia}
					numeroArgomenti={p.numeroArgomenti}
					numeroQuesiti={p.numeroQuesiti}
					peso={p.peso}
				/>
			{/each}
		</TableBody>
	</Table>
</TableContainer>
<Button type="submit">Selezione dei candidati</Button>

<DataInspector {data} />
