<script lang="ts">
	import 'carbon-components-svelte/css/all.css';
	import {
		Button,
		Header,
		HeaderUtilities,
		HeaderAction,
		HeaderGlobalAction,
		HeaderPanelLinks,
		HeaderPanelDivider,
		HeaderPanelLink,
		SideNav,
		SideNavItems,
		SideNavMenu,
		SideNavMenuItem,
		SideNavLink,
		SkipToContent,
		Content,
		Grid,
		Row,
		Column,
		Theme,
		LocalStorage
	} from 'carbon-components-svelte';
	//import SettingsAdjust from 'carbon-icons-svelte/lib/SettingsAdjust.svelte';
	import UserAvatarFilledAlt from 'carbon-icons-svelte/lib/UserAvatarFilledAlt.svelte';
	//import Sun from 'carbon-icons-svelte/lib/Sun.svelte';
	import WatsonHealthWindowBlackSaturation from 'carbon-icons-svelte/lib/WatsonHealthWindowBlackSaturation.svelte';

	import { browser } from '$app/environment';
	//import { theme, nextTheme } from '../stores';

	let theme: string;

	function aggiornaTema() {
		const themeAlternatives = ['white', 'g10', 'g80', 'g90', 'g100'];
		const themes = themeAlternatives.length;
		if (theme === undefined) return;
		const i: number = themeAlternatives.findIndex((t) => t === theme);
		theme = themeAlternatives[(i + 1) % themes];
	}
</script>

<LocalStorage
	key="__carbon-theme"
	bind:value={theme}
	on:save={() => {
		console.log(`Salvataggio LS del tema ${theme}`);
	}}
	on:update={({ detail }) => {
		console.log(`Lettura LS del tema ${theme}`, detail);
	}}
/>

<Theme bind:theme persist persistKey="__carbon-theme" />

<Header company="GM" platformName="Professore Web">
	<svelte:fragment slot="skip-to-content">
		<SkipToContent />
	</svelte:fragment>
	<HeaderUtilities>
		<HeaderGlobalAction
			aria-label="Settings"
			icon={WatsonHealthWindowBlackSaturation}
			on:click={aggiornaTema}
		/>
		<HeaderAction icon={UserAvatarFilledAlt} closeIcon={UserAvatarFilledAlt} />
	</HeaderUtilities>
</Header>

<Content>
	<Grid padding>
		<Row>
			<Column>
				<h3>♨️🍖♨️ Grigliata mista di valutazioni ♨️🍖♨️</h3>
			</Column>
		</Row>
		<Row>
			<Column>
				<slot />
			</Column>
		</Row>
	</Grid>
</Content>
