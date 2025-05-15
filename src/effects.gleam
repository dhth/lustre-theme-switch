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

@external(javascript, "./ffi/theme_ffi.mjs", "setTheme")
pub fn set_theme_in_local_storage(theme: string) -> Nil

@external(javascript, "./ffi/theme_ffi.mjs", "removeTheme")
pub fn remove_theme_from_local_storage() -> Nil
