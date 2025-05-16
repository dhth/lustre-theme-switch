import lustre/effect
import types.{type Msg, type Theme, theme_to_string}

pub fn set_theme(theme: Theme) -> effect.Effect(Msg) {
  use _ <- effect.from
  theme |> theme_to_string |> set_theme_in_local_storage
}

pub fn remove_theme() -> effect.Effect(Msg) {
  use _ <- effect.from
  remove_theme_from_local_storage()
}

pub fn previous_theme() -> effect.Effect(Msg) {
  use dispatch <- effect.from
  let previous_theme_str = get_and_apply_previous_theme()

  let previous_theme = case previous_theme_str {
    "dark" -> types.Dark
    "light" -> types.Light
    _ -> types.Auto
  }

  previous_theme |> types.PreviousThemeFetched |> dispatch
}

@external(javascript, "./ffi/theme_ffi.mjs", "setManualTheme")
pub fn set_theme_in_local_storage(theme: string) -> Nil

@external(javascript, "./ffi/theme_ffi.mjs", "setAutoTheme")
pub fn remove_theme_from_local_storage() -> Nil

@external(javascript, "./ffi/theme_ffi.mjs", "getAndApplyPreviousTheme")
pub fn get_and_apply_previous_theme() -> String
