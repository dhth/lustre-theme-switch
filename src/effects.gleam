import lustre/effect
import types.{type Msg, type Theme, theme_to_string}

pub fn set_theme(theme: Theme) -> effect.Effect(Msg) {
  fn(_) { theme |> theme_to_string |> set_theme_in_local_storage }
  |> effect.from
}

pub fn remove_theme() -> effect.Effect(Msg) {
  fn(_) { remove_theme_from_local_storage() }
  |> effect.from
}

pub fn previous_theme() -> effect.Effect(Msg) {
  fn(dispatch) {
    let previous_theme_str = get_previously_applied_theme()

    let previous_theme = case previous_theme_str {
      "dark" -> types.Dark
      "light" -> types.Light
      _ -> types.Auto
    }

    previous_theme |> types.PreviousThemeFetched |> dispatch
  }
  |> effect.from
}

@external(javascript, "./ffi/theme_ffi.mjs", "setTheme")
pub fn set_theme_in_local_storage(theme: string) -> Nil

@external(javascript, "./ffi/theme_ffi.mjs", "removeTheme")
pub fn remove_theme_from_local_storage() -> Nil

@external(javascript, "./ffi/theme_ffi.mjs", "getPreviouslyAppliedTheme")
pub fn get_previously_applied_theme() -> String
