import type { vista_classi } from '@prisma/client';
import type { PageServerLoad } from './$types';

/** @type {import('./$types').PageServerLoad} */
export const load: PageServerLoad = async ({ fetch }) => {
	const response = await fetch('/api/classi');

	return { classi: (await response.json()) as vista_classi[] };
};
