import gleam/option
import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/event
import lustre_theme_switch/types.{type Model, type Msg, theme_to_string}

pub fn view(model: Model) -> element.Element(Msg) {
  html.div(
    [
      attribute.class(
        "dark:bg-slate-800 dark:text-slate-100 text-slate-800 select-none",
      ),
      event.on_click(types.UserRequestedThemeChange),
    ],
    [
      html.div(
        [attribute.class("flex flex-col h-screen sm:w-full md:w-4/5 mx-auto")],
        [
          html.div(
            [attribute.class("flex flex-col gap-8 items-center my-auto p-12")],
            [
              html.div([attribute.class("flex flex-col gap-2 items-center")], [
                html.p([attribute.class("text-9xl")], [
                  model.theme |> theme_to_string |> element.text,
                ]),
                case model.theme {
                  types.Auto(option.Some(system_theme_dark)) ->
                    html.p([attribute.class("text-xl")], [
                      case system_theme_dark {
                        False -> "(light)"
                        True -> "(dark)"
                      }
                      |> element.text,
                    ])
                  _ ->
                    html.p([attribute.class("text-xl invisible")], [
                      "hidden" |> element.text,
                    ])
                },
              ]),
              html.p([], ["click anywhere" |> element.text]),
              html.p(
                [attribute.class("text-sm dark:text-slate-200 text-slate-600")],
                [
                  "this is a demonstration of how you can switch themes in "
                    |> element.text,
                  html.a(
                    [
                      attribute.class(
                        "font-semibold border-b-2 dark:border-slate-100 border-slate-800",
                      ),
                      attribute.href("https://github.com/lustre-labs/lustre"),
                      attribute.target("_blank"),
                    ],
                    ["lustre" |> element.text],
                  ),
                  " apps" |> element.text,
                ],
              ),
              html.div([attribute.class("flex flex-col gap-2 items-center")], [
                html.p(
                  [
                    attribute.class(
                      "text-xs dark:text-slate-300 text-slate-800",
                    ),
                  ],
                  [
                    "notice the change in the tab's title and favicon"
                    |> element.text,
                  ],
                ),
                html.p(
                  [
                    attribute.class(
                      "text-xs dark:text-slate-300 text-slate-800",
                    ),
                  ],
                  [
                    "your selection will be remembered the next time this page loads"
                    |> element.text,
                  ],
                ),
              ]),
              html.a(
                [
                  attribute.class("font-mono text-xs"),
                  attribute.href("https://github.com/dhth/lustre-theme-switch"),
                  attribute.target("_blank"),
                ],
                ["repo" |> element.text],
              ),
            ],
          ),
        ],
      ),
    ],
  )
}
