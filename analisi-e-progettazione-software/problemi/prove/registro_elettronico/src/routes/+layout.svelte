<script lang="ts">
	import '@picocss/pico';
	import { browser } from '$app/environment';
	import { theme } from '../stores';

	function toggleTheme() {
		if ($theme === 'dark') theme.set('light');
		else theme.set('dark');
	}

	$: {
		if (browser) document.documentElement.setAttribute('data-theme', $theme);
	}
</script>

<div class="container">
	<hgroup>
		<h1>
			<a href="/">Professore Web</a>
		</h1>

		<h2>♨️🍖♨️ Grigliata mista di valutazioni ♨️🍖♨️</h2>
	</hgroup>
	<slot />

	<button class="switcher" on:click={toggleTheme}
		><i>Turn on {$theme === 'dark' ? 'light' : 'dark'} mode</i></button
	>
</div>

<style>
	.switcher {
		position: fixed;
		right: calc(var(--spacing) / 2 + var(--scrollbar-width, 0px));
		bottom: var(--spacing);
		width: auto;
		margin-bottom: 0;
		padding: 0.75rem;
		border-radius: 2rem;
		box-shadow: var(--card-box-shadow);
		line-height: 1;
		text-align: right;
		color: var(--color);
		font-weight: var(--font-weight);
		font-size: 1rem;
		line-height: var(--line-height);
		text-align: center;
		cursor: pointer;
		transition: background-color var(--transition), border-color var(--transition),
			color var(--transition), box-shadow var(--transition);
	}
</style>
