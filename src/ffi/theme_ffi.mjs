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
