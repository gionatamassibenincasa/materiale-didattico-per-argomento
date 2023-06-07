import prisma from '$lib/prisma';
import type { Griglia } from '@prisma/client';
import { error, fail, json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ request, params, url }) => {
	let griglia;
	const grigliaIdz = url.searchParams.get('grigliaId');
	if (grigliaIdz != null) {
		griglia = await prisma.griglia.findUnique({
			select: {
				grigliaId: true,
				descrizione: true
			},
			where: { grigliaId: parseInt(grigliaIdz) }
		});
	} else {
		griglia = await prisma.griglia.findMany({
			select: {
				grigliaId: true,
				descrizione: true
			}
		});
	}
	return json(griglia);
};
