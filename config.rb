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
