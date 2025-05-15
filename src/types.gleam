pub type Theme {
  Dark
  Light
  Auto
}

pub fn next_theme(theme: Theme) -> Theme {
  case theme {
    Dark -> Light
    Light -> Auto
    Auto -> Dark
  }
}

pub fn theme_to_string(theme: Theme) -> String {
  case theme {
    Dark -> "dark"
    Light -> "light"
    Auto -> "auto"
  }
}

pub type Model {
  Model(theme: Theme)
}

pub fn init_model() -> Model {
  Model(theme: Dark)
}

pub type Msg {
  UserRequestedThemeChange
}
