import type { PageServerLoad } from './$types';
import { fetch, url } from '@sveltejs/kit';

export const load = async function ({ fetch, url }) {
	const classeId = url.searchParams.get('classeId') || '0';
	const response = await fetch(`/api/prova/predisposizione?classeId=${classeId}`);
	const data = await response.json();

	return {
		data: data
	};
} satisfies PageServerLoad;
