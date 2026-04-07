require 'dry-monads'
include Dry::Monads[:result]
require '~/html-canonical/lib/html/canonical.rb'
include Html::Canonical
require_relative '../config.rb'
require_relative '../styles/main_css.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

def open_graph_json(json)
  $graph = json
end

def site_layout(&block)
document(
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
      link({ rel: "canonical", href: "#{SITE_URL}/#{__FILE__.gsub("rb", "html")}" }),

      # GEO / LLMO: Open Graph - used by AI summarisers and social-card generators
      meta({ property: "og:type",        content: "website" }),
      meta({ property: "og:title",       content: "Augmented Engineering UG - Formal Methods & Software Engineering" }),
      meta({ property: "og:description", content: DESCRIPTION }),
      meta({ property: "og:url",         content: "#{SITE_URL}/#{__FILE__.gsub("rb", "html")}" }),
      meta({ property: "og:site_name",   content: SITE_NAME }),
      meta({ property: "og:image",       content: "#{SITE_URL}/augen-logo.svg" }),

      # AAO / AEO: JSON-LD structured data - entity graph for answer engines
      $graph ? script({ type: "application/ld+json" }, $graph) : '',

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

      main(block.call),

      footer(
        span("© 2026 Augmented Engineering UG, Geschäftsführer Julian Vargas"),
        a({ href: "https://www.linkedin.com/company/augmented-engineering-ug/",
            rel: "noopener noreferrer", target: "_blank" },
          "LinkedIn")
      )
    )
  )
)
end
