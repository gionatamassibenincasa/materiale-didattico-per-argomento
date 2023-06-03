<script lang="ts">
	import { onMount } from 'svelte';
	import type { PageData } from './$types';
	export let data: PageData;

	let now = new Date(),
		month,
		day,
		year;
	let giorno: string;
	let classeId: number | null = null;

	onMount(() => {
		(month = '' + (now.getMonth() + 1)), (day = '' + now.getDate()), (year = now.getFullYear());

		if (month.length < 2) month = '0' + month;
		if (day.length < 2) day = '0' + day;

		giorno = [year, month, day].join('-');
	});

	const appello = () => {
		location.href = `/appello/${classeId}/${giorno}`;
	};
</script>

<div class="grid">
	<div>
		<form method="get" action="appello">
			<label for="giorno"
				>Data:<input type="date" id="giorno" name="giorno" bind:value={giorno} /></label
			>

			<label for="classe"
				>Classe:
				<select id="classe" name="classeId" bind:value={classeId}>
					{#each data.classi as c}
						<option value={c.classeId}>{c.classe}</option>
					{/each}
				</select>
			</label>
			<button type="submit">Appello</button>
		</form>
	</div>
</div>
