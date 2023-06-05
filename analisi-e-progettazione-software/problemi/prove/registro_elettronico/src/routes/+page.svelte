<script lang="ts">
	import { onMount } from 'svelte';
	import type { PageData } from './$types';
	import {
		Row,
		Column,
		Form,
		Button,
		DatePicker,
		DatePickerInput,
		Select,
		SelectItem
	} from 'carbon-components-svelte';
	import { Italian } from 'flatpickr/dist/l10n/it.js';
	import DataInspector from '$lib/components/DataInspector.svelte';
	/**
	 * Specify the locale
	 * @type {import("flatpickr/dist/types/locale").CustomLocale | import("flatpickr/dist/types/locale").key}
	 */

	export let data: PageData;
	let calendarOptions = {};

	function zeroPad(number: number, width: number): string {
		var string: string = String(number);
		while (string.length < width) string = '0' + string;
		return string;
	}

	const now = new Date();

	let month: string = zeroPad(now.getMonth() + 1, 2),
		day: string = zeroPad(now.getDate(), 2),
		year: string = String(now.getFullYear()),
		dateFormat: string = 'd/m/Y',
		giornoVisualizzato: string = [day, month, year].join('/'),
		giorno: string,
		classeId: number | null = null;

	$: {
		try {
			[day, month, year] = giornoVisualizzato.split('/');
			giorno = [year, month, day].join('-');
		} catch (error) {
			console.log(error);
		}
	}
</script>

<Form method="get" action="appello" on:submit>
	<input name="giorno" type="hidden" value={giorno} />
	<DatePicker bind:value={giornoVisualizzato} datePickerType="single" locale="it" {dateFormat}>
		<DatePickerInput labelText="Data" helperText="Esempio: 25/12/1990" placeholder="gg/mm/aaaa" />
	</DatePicker>
	<Select name="classeId" bind:value={classeId} labelText="Classe">
		{#each data.classi as c}
			<SelectItem value={c.classeId} text={c.classe} />
		{/each}
	</Select>
	<Button kind="primary" tabIndex={0} type="submit">Appello</Button>
</Form>

<DataInspector {data} />
