<script lang="ts">
	import { Toggle, TableRow, TableCell, NumberInput, TextInput } from 'carbon-components-svelte';
	export let argomentoId: number,
		argomento: string,
		quesitiDisponibili: number,
		selezionato: boolean;
	let quesiti: number;
</script>

<TableRow>
	<TableCell><Toggle bind:toggled={selezionato} /></TableCell>
	<TableCell><TextInput bind:value={argomento} /></TableCell>
	<TableCell><NumberInput bind:value={quesiti} /></TableCell>
	<TableCell><NumberInput bind:value={quesitiDisponibili} disabled /></TableCell>
</TableRow>
