import gleam/option
import lustre/effect
import types.{type Msg, type Theme, theme_to_string}

pub fn set_manual_theme(theme: Theme) -> effect.Effect(Msg) {
  use _ <- effect.from
  theme |> theme_to_string |> set_manual_theme_js
}

pub fn set_auto_theme() -> effect.Effect(Msg) {
  use dispatch <- effect.from
  let is_system_theme_dark = set_auto_theme_js()
  is_system_theme_dark |> types.SystemThemeFetched |> dispatch
}

pub fn apply_previous_theme() -> effect.Effect(Msg) {
  use dispatch <- effect.from
  let previous_theme_str = get_and_apply_previous_theme_js()

  let previous_theme = case previous_theme_str {
    "dark" -> types.Dark
    "light" -> types.Light
    "auto-dark" -> types.Auto(dark: True |> option.Some())
    _ -> types.Auto(dark: False |> option.Some())
  }

  previous_theme |> types.PreviousThemeFetched |> dispatch
}

pub fn start_system_theme_tracking() {
  use dispatch <- effect.from()
  use is_dark <- track_system_theme_js
  is_dark |> types.SystemThemeChanged |> dispatch
}

@external(javascript, "./ffi/theme_ffi.mjs", "setManualTheme")
pub fn set_manual_theme_js(theme: string) -> Nil

@external(javascript, "./ffi/theme_ffi.mjs", "setAutoTheme")
pub fn set_auto_theme_js() -> Bool

@external(javascript, "./ffi/theme_ffi.mjs", "getAndApplyPreviousTheme")
pub fn get_and_apply_previous_theme_js() -> String

@external(javascript, "./ffi/theme_ffi.mjs", "trackSystemTheme")
fn track_system_theme_js(cb: fn(Bool) -> Nil) -> Nil
