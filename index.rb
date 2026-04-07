require 'dry-monads'
include Dry::Monads[:result]
require_relative '../html-canonical/lib/html/canonical.rb'
include Html::Canonical
require_relative './config.rb'
require_relative './styles/main_css.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

landing = document(
  doctype(),
  html({ lang: "en" },
    head(
      meta({ charset: "UTF-8" }),
      meta({ name: "viewport", content: "width=device-width, initial-scale=1" }),

      # SEO: title + description drive search-result click-through
      title("Augmented Engineering UG - Formal Methods & Software Engineering"),
      meta({ name: "description", content: DESCRIPTION }),
      meta({ name: "robots", content: "index, follow" }),
      # SEO: canonical prevents duplicate-content penalties
      link({ rel: "canonical", href: SITE_URL }),

      # GEO / LLMO: Open Graph - used by AI summarisers and social-card generators
      meta({ property: "og:type",        content: "website" }),
      meta({ property: "og:title",       content: "Augmented Engineering UG - Formal Methods & Software Engineering" }),
      meta({ property: "og:description", content: DESCRIPTION }),
      meta({ property: "og:url",         content: SITE_URL }),
      meta({ property: "og:site_name",   content: SITE_NAME }),
      meta({ property: "og:image",       content: "#{SITE_URL}/augen-logo.svg" }),

      # AAO / AEO: JSON-LD structured data - entity graph for answer engines
      script({ type: "application/ld+json" }, JSON_LD),

      link({ rel: "icon", href: "favicon.ico" }),
      style(CSS)
    ),
    body(
      header(
        # Wrap logo in a link so users can always return home - also signals
        # the primary entity to crawlers via the logo href.
        a({ href: SITE_URL },
          img({ src: "augen-logo.svg", alt: "Augmented Engineering UG", width: "160", height: "160" })
        ),
        h1("Augmented Engineering UG"),
        p({ class: "tagline" }, "Formal Methods & Software Engineering"),
        nav(
          a({ href: "/" }, "Home"),
          a({ href: "blog.html" }, "Blog"),
          a({ href: "about-us.html" }, "About Us")
        )
      ),

      main(
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
      ),

      footer(
        span("© 2026 Augmented Engineering UG, Geschäftsführer Julian Vargas"),
        a({ href: "https://www.linkedin.com/company/augmented-engineering-ug/",
            rel: "noopener noreferrer", target: "_blank" },
          "LinkedIn")
      )
    )
  )
)

landing.run(config: config, state: initial_state).result.bind { |vdom|
  raw_html = render_html(vdom)
  File.open("index.html", "w") { |f| f.write(raw_html) }
  Success(nil)
}.or { |error| abort "#{error.join(", ")}" }
