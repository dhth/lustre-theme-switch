export function setTheme(theme) {
	localStorage.theme = theme;
	document.documentElement.setAttribute(
		"data-theme", theme
	);
}

export function removeTheme() {
	localStorage.removeItem("theme");

	if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
		document.documentElement.setAttribute(
			"data-theme", "dark"
		);
	} else {
		document.documentElement.setAttribute(
			"data-theme", "light"
		);
	}
}

export function getPreviouslyAppliedTheme() {
	if (("theme" in localStorage)) {
		if (localStorage.theme == "dark") {
			document.documentElement.setAttribute(
				"data-theme", "dark"
			);
			return "dark";
		} else if (localStorage.theme == "light") {
			document.documentElement.setAttribute(
				"data-theme", "light"
			);
			return "light";
		} else {
			localStorage.removeItem("theme");
		}
	}

	if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
		console.log('load: dark mode is enabled');
		document.documentElement.setAttribute(
			"data-theme", "dark"
		);
	} else {
		console.log('load: Light mode is enabled');
		document.documentElement.setAttribute(
			"data-theme", "light"
		);
	}

	return "auto";
}
