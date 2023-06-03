import { writable } from 'svelte/store';
import { browser } from '$app/environment';

let storedTheme: string;
if (browser && typeof localStorage !== 'undefined') {
	const oldTheme = localStorage?.getItem('theme');
	if (oldTheme) {
		storedTheme = oldTheme;
	} else {
		storedTheme = 'auto';
	}
}

export const theme = writable(storedTheme);
theme.subscribe((value) => {
	if (browser && typeof localStorage !== 'undefined') {
		localStorage.setItem('theme', value);
	}
});
