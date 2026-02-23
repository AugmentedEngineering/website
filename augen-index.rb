require 'dry-monads'
include Dry::Monads[:result]
require_relative '../html-canonical/lib/html/canonical.rb'
include Html::Canonical

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1
landing = document(
  doctype(),
  html({ lang: "de" },
    head(
      meta({charset: "UTF-8"}),
      meta({name: "viewport", content: "width=device-width, initial-scale=1"}),
      link({rel: "icon", href: "favicon.ico"}),
      script({src: "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"}),
      title("Augmented Engineering UG - Software Engineering & Research")
    ),
    body(
      header({class: "flex flex-col items-center"},
        img({src: "augen-logo.svg"}),
        h1({class: "font-bold text-5xl tex-gray-800 tagline"}, "Augmented Engineering UG"),
        br,
        p({class: "font-bold text-2xl tex-gray-700 tagline"}, "Software Engineering & Research"),
      ),
      main(
        section({id: "engineering", class: "section"}),
          h2("Mission"),
          p("Develop software systems that are secure, compliant and scalable by design that allow business to focus on growth instead of dealing with technology issues. We apply formal methods and enforce the highest standards to make invalid states impossible to represent."),
        ),

        section({class: "section"},
          h2("Products"),
          ul(
            li(
              a({href: "https://github.com/AugmentedEngineering/html-canonical", target: "_blank"}, b("HTML Canonical")),
              span("A Ruby DSL for developing semantic, standards-compliant HTML")
            )
          )
        ),

        section({id: "contact", class: "section"},
          h2("Contact"),
          p(
            "Julian Vargas,",
            br,
            "Managing Director",
            br,
            "Augmented Engineering UG",
            br,
            br,
            "Ludwig-Erhard-Allee 10, 76131 Karlsruhe, Deutschland",
            br,
            "Email: julian.vargas@augmented-engineering.de"
          )
        )
      ),

      footer(
        "© 2026 Augmented Engineering UG, Geschäftsführer Julian Vargas."
      )
    )
  )

# while true do
landing_result = landing.run(config: config, state: initial_state)
File.open("index.html", "w") { |f| f.write(render_html(landing_result.result.value!)) }
