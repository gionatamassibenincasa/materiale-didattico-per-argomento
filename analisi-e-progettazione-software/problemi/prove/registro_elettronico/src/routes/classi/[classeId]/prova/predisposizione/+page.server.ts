import type { PageServerLoad } from './$types';
import type { PageData } from './$types';
import { page } from '$app/stores';
import type { RequestHandler } from './$types';

export const load = async function ({ fetch, params }) {
	const classeId = params.classeId;
	const response = await fetch(`/api/classi/${classeId}/prove/predisposizioni`);
	const data = await response.json();
	console.log(
		'src/routes/classi/[classeId]/prova/predisposizione/+page.server.ts Page.server: ',
		data
	);

	return {
		data: data
	};
} satisfies PageServerLoad;
