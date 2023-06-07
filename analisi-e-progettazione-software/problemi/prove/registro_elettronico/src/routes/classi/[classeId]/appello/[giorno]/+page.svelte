<script lang="ts">
	import type { Appello } from '../../../api/appello/+server';
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import type { PageData } from '../../../appello/$types';
	import {
		Form,
		Button,
		Table,
		TableContainer,
		TableHeader,
		TableBody,
		TableRow,
		TableHead
	} from 'carbon-components-svelte';
	import RigaStudente from './RigaStudente.svelte';

	import DataInspector from '$lib/components/DataInspector.svelte';

	export let data: PageData;
	let a: Appello[];
	let classeId: number;
	let giorno: string;
	$: {
		a = data.appello;
		classeId = parseInt($page.params['classeId']);
		giorno = $page.params['giorno'];
	}
</script>

<h1>Appello</h1>
<Form method="get" action="../prova/predisposizione" on:submit>
	<TableContainer>
		<Table zebra>
			<TableHead>
				<TableRow>
					<TableHeader scope="col">Pos.</TableHeader>
					<TableHeader scope="col">Cognome</TableHeader>
					<TableHeader scope="col">Nome</TableHeader>
					<TableHeader scope="col">Assente</TableHeader>
					<TableHeader scope="col">G residue</TableHeader>
					<TableHeader scope="col">Giust. motivata</TableHeader>
					<TableHeader scope="col">Giust.</TableHeader>
				</TableRow>
			</TableHead>
			<TableBody>
				{#each a as s, i}
					<RigaStudente
						studenteId={s.studenteId}
						{classeId}
						{giorno}
						pos={i + 1}
						cognome={s.cognome}
						nome={s.nome}
						assenza={s.assenza}
						giustificazioneDovuta={s.giustificazione !== null && s.giustificazione == 0}
						giustificazioneAccordata={s.giustificazione !== null && s.giustificazione == 1}
						residuoGiustificazioni={s.residuo}
					/>
				{/each}
			</TableBody>
		</Table>
	</TableContainer>
	<Button type="submit">Predisponi la prova</Button>
</Form>

<DataInspector {data} />
