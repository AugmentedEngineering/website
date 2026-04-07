require_relative './shared/site_layout.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

landing = site_layout do
  [
    # SEO / AEO: Answer "what does Augmented Engineering do?" directly.
    section({ id: "mission", "aria-labelledby": "h-mission" },
      h2({ id: "h-mission" }, "Mission"),
      p("Develop software systems that are secure, compliant and scalable by design, " \
        "allowing businesses to focus on growth instead of dealing with technology issues. " \
        "We apply formal methods and enforce the highest standards to make invalid states " \
        "impossible to represent.")
    ),

    section({ id: "projects", "aria-labelledby": "h-projects" },
      h2({ id: "h-projects" }, "Active Projects"),
      ul(
        li(
          a({ href: "https://github.com/AugmentedEngineering/html-canonical",
              rel: "noopener noreferrer", target: "_blank" },
            "HTML Canonical"),
          " Ruby DSL for developing semantic, standards-compliant HTML"
        )
      )
    ),

    # AAO: <address> inside the contact section marks up contact details
    # as a named entity for crawlers and citation tools.
    section({ id: "contact", "aria-labelledby": "h-contact" },
      h2({ id: "h-contact" }, "Contact"),
      address(
        "Julian Vargas", br,
        "Managing Director, Augmented Engineering UG", br,
        br,
        "Ludwig-Erhard-Allee 10, 76131 Karlsruhe, Germany", br,
        a({ href: "mailto:julian.vargas@augmented-engineering.de" },
          "julian.vargas@augmented-engineering.de")
      )
    )
  ]
end

landing.run(config: config, state: initial_state).result.bind { |vdom|
  raw_html = render_html(vdom)
  File.open("index.html", "w") { |f| f.write(raw_html) }
  Success(nil)
}.or { |error| abort "#{error.join(", ")}" }
