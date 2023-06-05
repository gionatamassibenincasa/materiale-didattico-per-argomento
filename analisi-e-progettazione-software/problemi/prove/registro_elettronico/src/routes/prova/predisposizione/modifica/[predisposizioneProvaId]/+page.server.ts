import type { PageServerLoad } from './$types';
import { fetch, url } from '@sveltejs/kit';

export const load = async function ({ fetch, url, params }) {
	const predisposizioneProvaId = params.predisposizioneProvaId || 0;
	const response = await fetch(
		`/api/prova/predisposizione?predisposizioneProvaId=${predisposizioneProvaId}`
	);
	const data = await response.json();

	return data;
} satisfies PageServerLoad;
