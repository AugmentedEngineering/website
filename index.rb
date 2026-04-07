require_relative './shared/site_layout.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

open_graph_json(
  # AAO / AEO / GEO: JSON-LD — Organization + WebSite graph
  # Machine-readable entity data consumed by answer engines, AI assistants,
  # and knowledge-graph crawlers independently of page rendering.
  <<~JSON
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
)

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
