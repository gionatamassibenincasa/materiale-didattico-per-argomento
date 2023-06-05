<script lang="ts">
	import { TableRow, TableHeader, TableCell, Button, ButtonSet } from 'carbon-components-svelte';
	import TrashCan from 'carbon-icons-svelte/lib/TrashCan.svelte';
	import NextFilled from 'carbon-icons-svelte/lib/NextFilled.svelte';
	import Edit from 'carbon-icons-svelte/lib/Edit.svelte';
	import { goto } from '$app/navigation';

	export let predisposizioneProvaId: number,
		classeId: number,
		descrizione: string,
		giorno: string,
		griglia: string,
		numeroArgomenti: number,
		numeroQuesiti: number,
		peso: number;

	function modifica() {
		goto(`predisposizione/modifica/${predisposizioneProvaId}`);
	}
	function elimina() {
		// Chiama API con predisposizioneProvaId
		// /api/predisposizione/[id]
		goto(`predisposizione/elimina/?classeId=${classeId}`);
	}
	function procedi() {
		goto(`predisposizione/modifica/?classeId=${classeId}`);
	}
</script>

<TableRow>
	<td>{descrizione}</td>
	<td>{giorno}</td>
	<td>{griglia}</td>
	<td>{numeroArgomenti}</td>
	<td>{numeroQuesiti}</td>
	<td>{peso}</td>
	<td>
		<ButtonSet stacked>
			<Button kind="secondary" icon={Edit} iconDescription="Modifica" on:click={modifica} /><Button
				kind="danger"
				icon={TrashCan}
				iconDescription="Elimina"
			/><Button icon={NextFilled} iconDescription="Procedi" /></ButtonSet
		></td
	>
</TableRow>
