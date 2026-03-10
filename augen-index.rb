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
      style(<<~STYLE
      STYLE
      ),
      title("Augmented Engineering UG - Software Engineering & Research")
    ),
    body({class: "bg-white text-gray-900 antialiased"},

      header({class: "max-w-4xl mx-auto px-4 py-12 flex flex-col items-center"},
        img({src: "augen-logo.svg"}),
        h1({class: "font-bold text-5xl tex-gray-800 tagline"}, "Augmented Engineering UG"),
        br,
        p({class: "font-bold text-xl tex-gray-700 tagline"}, "Software Engineering & Research"),
      ),
      main({class: "max-w-4xl mx-auto px-4 space-y-12"},
        section({id: "engineering", class: ""},
          h2({class: "text-2xl font-semibold text-blue-900 mb-4"}, "Mission"),
          p({class: "text-gray-700 mb-4"}, "Develop software systems that are secure, compliant and scalable by design that allow business to focus on growth instead of dealing with technology issues. We apply formal methods and enforce the highest standards to make invalid states impossible to represent."),
        ),

        section({class: ""},
          h2({class: "text-2xl font-semibold text-blue-900 mb-4"}, "Active projects"),
          ul({class: "list-disc pl-6 space-y-1 text-gray-700"},
            li(
              a({href: "https://github.com/AugmentedEngineering/html-canonical", target: "_blank"}, b("HTML Canonical")),
              span("A Ruby DSL for developing semantic, standards-compliant HTML")
            )
          )
        ),

        section({id: "contact", class: ""},
          h2({class: "text-2xl font-semibold text-blue-900 mb-4"}, "Contact"),
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

      footer({class: "max-w-4xl mx-auto space-y-12 px-4 border-t border-gray-200 text-center text-gray-600 sticky bottom-0"},
        "© 2026 Augmented Engineering UG, Geschäftsführer Julian Vargas.",
        span("|"),
        a({href: "https://www.linkedin.com/company/augmented-engineering-ug/", target: "_blank"}, "LinkedIn")
      )
    )
  )
)
# while true do
landing_result = landing.run(config: config, state: initial_state)
File.open("index.html", "w") { |f| f.write(render_html(landing_result.result.value!)) }
