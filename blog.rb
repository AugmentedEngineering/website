require_relative './shared/site_layout.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

JSON_LD = <<~JSON
  {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Blog",
        "@id": "#{SITE_URL}/blog.html",
        "name": "Augmented Engineering Blog",
        "url": "#{SITE_URL}/blog.html",
        "publisher": { "@id": "#{SITE_URL}/#organization" }
      }
    ]
  }
JSON

blog = site_layout do
  [
        article(
          time({ class: "post-date", datetime: "2026-03-22" }, "March 22, 2026"),
          h2("Making Invalid States Impossible: Lessons from html-canonical"),
          p({ class: "post-summary" },
            "Most HTML bugs are not typos — they are content-model violations that slip through " \
            "because nothing in the toolchain prevents them. html-canonical encodes the HTML Living " \
            "Standard's content model directly into Ruby's type system, so placing a block element " \
            "inside a paragraph is a compile-time error, not a runtime surprise."
          ),
          ul({ class: "tags" },
            li("formal-methods"),
            li("ruby"),
            li("html"),
            li("type-safety")
          )
        ),

        article(
          time({ class: "post-date", datetime: "2026-02-14" }, "February 14, 2026"),
          h2("Dry Monads in Practice: Composable Error Handling for Ruby"),
          p({ class: "post-summary" },
            "Exception-driven control flow hides failure paths inside stack traces and rescue clauses " \
            "scattered across the codebase. The Result monad makes every failure an explicit value — " \
            "composable, inspectable, and impossible to silently swallow. This post walks through " \
            "replacing a brittle service object with a clean monadic pipeline."
          ),
          ul({ class: "tags" },
            li("ruby"),
            li("monads"),
            li("functional-programming"),
            li("error-handling")
          )
        ),

        article(
          time({ class: "post-date", datetime: "2026-01-30" }, "January 30, 2026"),
          h2("The Compliance Trap: Why Ad-Hoc Tooling Fails Regulated Industries"),
          p({ class: "post-summary" },
            "Regulated sectors need software that provably meets standards — not software that " \
            "probably does. Ad-hoc tooling accrues informal assumptions that are invisible to auditors " \
            "and dangerous under load. We examine where informal development processes break down " \
            "and how formal specifications close the gap before certification, not after."
          ),
          ul({ class: "tags" },
            li("compliance"),
            li("formal-methods"),
            li("standards"),
            li("architecture")
          )
        ),

        article(
          time({ class: "post-date", datetime: "2025-12-18" }, "December 18, 2025"),
          h2("Static Sites, Dynamic Trust: The Case for Generated HTML"),
          p({ class: "post-summary" },
            "When your HTML is a deterministic build artifact produced by a verified pipeline, " \
            "you gain auditability and reproducibility for free. No runtime renderer, no hidden " \
            "state, no server-side surprises. This post makes the case for treating markup as " \
            "compiled output rather than hand-authored source."
          ),
          ul({ class: "tags" },
            li("architecture"),
            li("static-sites"),
            li("devops"),
            li("ruby")
          )
        ),

        article(
          time({ class: "post-date", datetime: "2025-11-05" }, "November 5, 2025"),
          h2("Specification Before Implementation: A Practical TLA+ Primer"),
          p({ class: "post-summary" },
            "TLA+ lets you specify and model-check the behavior of concurrent systems before writing " \
            "a single line of production code. Race conditions, data-loss scenarios, and protocol " \
            "violations surface in the model checker — not in production at 2 AM. This primer covers " \
            "the notation and workflow we use on every non-trivial distributed component."
          ),
          ul({ class: "tags" },
            li("tla-plus"),
            li("formal-methods"),
            li("concurrency"),
            li("distributed-systems")
          )
        )
      
  ]
end

blog.run(config: config, state: initial_state).result.bind { |vdom|
  raw_html = render_html(vdom)
  File.open("blog.html", "w") { |f| f.write(raw_html) }
  Success(nil)
}.or { |error| abort "#{error.join(", ")}" }
