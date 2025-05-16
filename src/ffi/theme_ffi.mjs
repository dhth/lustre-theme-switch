export function setManualTheme(theme) {
	localStorage.theme = theme;
	document.documentElement.setAttribute(
		"data-theme", theme
	);

	setFavicon(theme);
	setTitle(theme);
}

export function setAutoTheme() {
	localStorage.removeItem("theme");

	if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
		document.documentElement.setAttribute(
			"data-theme", "dark"
		);
		setFavicon("dark");
	} else {
		document.documentElement.setAttribute(
			"data-theme", "light"
		);
		setFavicon("light");
	}

	setTitle("auto");
}

export function getAndApplyPreviousTheme() {
	if (("theme" in localStorage)) {
		if (localStorage.theme == "dark") {
			document.documentElement.setAttribute(
				"data-theme", "dark"
			);
			setFavicon("dark");
			setTitle("dark");
			return "dark";
		} else if (localStorage.theme == "light") {
			document.documentElement.setAttribute(
				"data-theme", "light"
			);
			setTitle("light");
			setFavicon("light");
			return "light";
		} else {
			localStorage.removeItem("theme");
		}
	}

	if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
		document.documentElement.setAttribute(
			"data-theme", "dark"
		);
		setFavicon("dark");
	} else {
		document.documentElement.setAttribute(
			"data-theme", "light"
		);
		setFavicon("light");
	}

	setTitle("auto");
	return "auto";
}

function setFavicon(theme) {
	let link = document.querySelector("link[rel~='icon']");
	if (link) {
		link.href = `./priv/static/favicon-${theme}.png`;
	}
}

function setTitle(theme) {
	document.title = `${theme} | lustre-theme-switch`;
}
