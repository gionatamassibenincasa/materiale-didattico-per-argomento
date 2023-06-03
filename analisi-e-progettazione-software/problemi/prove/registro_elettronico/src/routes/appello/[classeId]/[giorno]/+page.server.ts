import { error } from '@sveltejs/kit';
import type { Appello } from '../../../api/appello/[classeId]/[giorno]/+server';
import type { PageServerLoad } from './$types';
export type { Appello };

export const load: PageServerLoad = async ({ fetch, params: { classeId, giorno } }) => {
	const response = await fetch(`/api/appello/${classeId}/${giorno}`);

	return {
		appello: (await response.json()) as Appello[],
		classeId: classeId,
		giorno: giorno
	};
};
