import lustre
import lustre/effect
import lustre_theme_switch/effects.{
  apply_previous_theme, start_system_theme_tracking,
}
import lustre_theme_switch/types.{type Model, type Msg, init_model}
import lustre_theme_switch/update
import lustre_theme_switch/view

pub fn main() {
  let app = lustre.application(init, update.update, view.view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

fn init(_) -> #(Model, effect.Effect(Msg)) {
  #(
    init_model(),
    effect.batch([apply_previous_theme(), start_system_theme_tracking()]),
  )
}
