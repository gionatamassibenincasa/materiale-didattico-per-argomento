import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';

import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ params }) => {
	console.log('GET ASSENZE');
	const sId = parseInt(params['studenteId']);
	const cId = parseInt(params['classeId']);

	const assenti = await prisma.assenza.findMany({
		where: {
			studenteId: sId,
			classeId: cId
		}
	});

	return json(assenti);
};
