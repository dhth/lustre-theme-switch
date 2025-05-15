import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/event
import types.{type Model, type Msg, theme_to_string}

pub fn view(model: Model) -> element.Element(Msg) {
  html.div(
    [
      attribute.class("dark:bg-slate-600 dark:text-slate-100 text-slate-800"),
      event.on_click(types.UserRequestedThemeChange),
    ],
    [
      html.div(
        [attribute.class("flex flex-col h-screen sm:w-full md:w-4/5 mx-auto")],
        [
          html.div(
            [attribute.class("flex flex-col gap-8 items-center my-auto p-12")],
            [
              html.p([attribute.class("text-9xl")], [
                model.theme |> theme_to_string |> element.text,
              ]),
              html.p([attribute.class("text-sm")], [
                "click anywhere" |> element.text,
              ]),
              html.p([attribute.class("text-xs")], [
                "your selection will be remembered the next time this page loads"
                |> element.text,
              ]),
            ],
          ),
        ],
      ),
    ],
  )
}
