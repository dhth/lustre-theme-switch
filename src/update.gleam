import effects.{remove_theme, set_theme}
import lustre/effect
import types.{type Model, type Msg, Model, next_theme}

pub fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    types.UserRequestedThemeChange -> {
      let next_theme = model.theme |> next_theme

      let effect = case next_theme {
        types.Auto -> remove_theme()
        theme -> theme |> set_theme
      }

      #(Model(theme: next_theme), effect)
    }
  }
}
