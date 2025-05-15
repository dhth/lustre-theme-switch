import effects.{set_theme}
import lustre
import lustre/effect
import types.{type Model, type Msg, init_model}
import update
import view

pub fn main() {
  let app = lustre.application(init, update.update, view.view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

fn init(_) -> #(Model, effect.Effect(Msg)) {
  #(init_model(), set_theme(types.Dark))
}
