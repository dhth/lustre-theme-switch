import gleam/option
import lustre/effect
import lustre_theme_switch/effects.{set_auto_theme, set_manual_theme}
import lustre_theme_switch/types.{type Model, type Msg, Model, next_theme}

pub fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  let zero = #(model, effect.none())
  case msg {
    types.UserRequestedThemeChange -> {
      let next_theme = model.theme |> next_theme

      let effect = case next_theme {
        types.Auto(_) -> set_auto_theme()
        theme -> theme |> set_manual_theme
      }

      #(Model(theme: next_theme), effect)
    }
    types.PreviousThemeFetched(theme) -> #(Model(theme:), effect.none())
    types.SystemThemeFetched(is_dark) | types.SystemThemeChanged(is_dark) ->
      case model.theme {
        types.Auto(_) -> #(
          Model(theme: types.Auto(dark: is_dark |> option.Some)),
          effect.none(),
        )
        _ -> zero
      }
  }
}
