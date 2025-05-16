import gleam/option

pub type Theme {
  Dark
  Light
  Auto(dark: option.Option(Bool))
}

pub fn next_theme(theme: Theme) -> Theme {
  case theme {
    Dark -> Light
    Light -> Auto(dark: option.None)
    Auto(_) -> Dark
  }
}

pub fn theme_to_string(theme: Theme) -> String {
  case theme {
    Dark -> "dark"
    Light -> "light"
    Auto(_) -> "auto"
  }
}

pub type Model {
  Model(theme: Theme)
}

pub fn init_model() -> Model {
  Model(theme: Dark)
}

pub type Msg {
  PreviousThemeFetched(Theme)
  UserRequestedThemeChange
  SystemThemeFetched(Bool)
  SystemThemeChanged(Bool)
}
