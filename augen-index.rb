require 'dry-monads'
include Dry::Monads[:result]
require_relative '../html-canonical/lib/html/canonical.rb'
include Html::Canonical

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

SITE_URL    = "https://augmented-engineering.de"
SITE_NAME   = "Augmented Engineering UG"
DESCRIPTION = "Software engineering firm specialising in formal methods, type-safe systems, " \
              "and standards-compliant tooling."

# AAO / AEO / GEO: JSON-LD — Organization + WebSite graph
# Machine-readable entity data consumed by answer engines, AI assistants,
# and knowledge-graph crawlers independently of page rendering.
JSON_LD = <<~JSON
  {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Organization",
        "@id": "#{SITE_URL}/#organization",
        "name": "#{SITE_NAME}",
        "url": "#{SITE_URL}",
        "logo": "#{SITE_URL}/augen-logo.svg",
        "description": "#{DESCRIPTION}",
        "address": {
          "@type": "PostalAddress",
          "streetAddress": "Ludwig-Erhard-Allee 10",
          "addressLocality": "Karlsruhe",
          "postalCode": "76131",
          "addressCountry": "DE"
        },
        "contactPoint": {
          "@type": "ContactPoint",
          "email": "julian.vargas@augmented-engineering.de",
          "contactType": "General Enquiries"
        },
        "founder": {
          "@type": "Person",
          "name": "Julian Vargas",
          "jobTitle": "Managing Director"
        },
        "sameAs": [
          "https://www.linkedin.com/company/augmented-engineering-ug/",
          "https://github.com/AugmentedEngineering"
        ]
      },
      {
        "@type": "WebSite",
        "@id": "#{SITE_URL}/#website",
        "name": "#{SITE_NAME}",
        "url": "#{SITE_URL}",
        "publisher": { "@id": "#{SITE_URL}/#organization" }
      }
    ]
  }
JSON

CSS = <<~CSS
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: #ffffff;
    color: #111827;
    -webkit-font-smoothing: antialiased;
    line-height: 1.6;
  }

  header, main, body > footer {
    max-width: 56rem;
    margin-inline: auto;
    padding-inline: 1rem;
  }

  /* Header */
  header {
    padding-block: 3rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 0.75rem;
  }

  header a { display: contents; }
  header img { max-width: 10rem; height: auto; }

  h1 {
    font-size: clamp(2rem, 5vw, 3rem);
    font-weight: 700;
    color: #1f2937;
  }

  .tagline {
    font-size: 1.125rem;
    font-weight: 600;
    color: #374151;
  }

  /* Main */
  main {
    padding-block: 3rem;
    display: flex;
    flex-direction: column;
    gap: 3rem;
  }

  h2 {
    font-size: 1.375rem;
    font-weight: 600;
    color: #1e3a8a;
    margin-bottom: 0.75rem;
  }

  p { color: #374151; }
  p + p { margin-top: 0.75rem; }

  address {
    font-style: normal;
    color: #374151;
    line-height: 1.8;
  }

  ul {
    list-style: disc;
    padding-left: 1.5rem;
    color: #374151;
  }

  li + li { margin-top: 0.25rem; }

  a { color: #1d4ed8; }
  a:hover { color: #1e3a8a; }

  /* Nav */
  header nav {
    display: flex;
    gap: 1.25rem;
    margin-top: 1rem;
  }

  header nav a {
    display: inline-block;
    padding: 0.5rem 1.25rem;
    border-radius: 0.375rem;

    font-size: 0.9375rem;
    font-weight: 600;
    color: #1d4ed8;
    text-decoration: none;
    transition: background 0.15s, color 0.15s;
  }

  header nav a:hover {
    background: #1d4ed8;
    color: #ffffff;
  }

  /* Footer */
  body > footer {
    margin-top: 3rem;
    border-top: 1px solid #e5e7eb;
    padding-block: 1.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 1rem;
    flex-wrap: wrap;
    text-align: center;
    color: #6b7280;
    font-size: 0.875rem;
  }
CSS

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

      # GEO / LLMO: Open Graph — used by AI summarisers and social-card generators
      meta({ property: "og:type",        content: "website" }),
      meta({ property: "og:title",       content: "Augmented Engineering UG - Formal Methods & Software Engineering" }),
      meta({ property: "og:description", content: DESCRIPTION }),
      meta({ property: "og:url",         content: SITE_URL }),
      meta({ property: "og:site_name",   content: SITE_NAME }),
      meta({ property: "og:image",       content: "#{SITE_URL}/augen-logo.svg" }),

      # AAO / AEO: JSON-LD structured data — entity graph for answer engines
      script({ type: "application/ld+json" }, JSON_LD),

      link({ rel: "icon", href: "favicon.ico" }),
      style(CSS)
    ),
    body(
      header(
        # Wrap logo in a link so users can always return home — also signals
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
