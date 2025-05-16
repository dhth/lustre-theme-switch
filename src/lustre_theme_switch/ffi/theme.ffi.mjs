const dark = "dark";
const light = "light";

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

    let is_system_theme_dark;

	if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
        setTheme(dark);
        is_system_theme_dark = true;
	} else {
        setTheme(light);
        is_system_theme_dark = false;
	}

	setTitle("auto");

    return is_system_theme_dark;
}

export function getAndApplyPreviousTheme() {
	if (("theme" in localStorage)) {
		if (localStorage.theme == dark) {
            setTheme(dark);
			setTitle(dark);
			return dark;
		} else if (localStorage.theme == light) {
            setTheme(light);
			setTitle(light);
			return light;
		} else {
			localStorage.removeItem("theme");
		}
	}

    let systemTheme;
	if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
        setTheme(dark);
        systemTheme = dark;
	} else {
        setTheme(light);
        systemTheme = light;
	}

	setTitle("auto");
    return `auto-${systemTheme}`;
}

export function trackSystemTheme(cb) {
    window
      .matchMedia("(prefers-color-scheme: dark)")
      .addEventListener("change", (event) => {
        if (!("theme" in localStorage)) { // this ensures we only change the theme when "auto" mode is ON
            if (event.matches) {
                setTheme(dark);
            } else {
                setTheme(light);
            }
            setTitle("auto");
            cb(event.matches);
        }
      });
}

function setTheme(theme) {
    document.documentElement.setAttribute(
        "data-theme", theme
    );
    setFavicon(theme);
}

function setFavicon(theme) {
	let link = document.querySelector("link[rel~='icon']");
	if (link) {
		link.href = `./priv/static/favicon-${theme}.png`;
	}
}

function setTitle(prefix) {
	document.title = `${prefix} | lustre-theme-switch`;
}
