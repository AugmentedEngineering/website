require_relative './shared/site_layout.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

CODE_SAMPLE = ""

about_us = site_layout do
  article(
    h2("About Us"),
    p("It was the year 2000 when one of my college professors mentioned during a lecture that there was a company that could demonstrate mathematically that their software works. That simple anecdote sparked my curiosity to learn more about the theory and techniques for developing software that was correct by design. This led me on a long journey through Test‑Driven Development, Functional Programming, Abstract Algebra, Category Theory, Formal Methods, and, most recently, Property‑Based Testing."),
    p("These are the foundations of Augmented Engineering, a space to create software that is secure and correct by design, making invalid states impossible to represent."),
    br(),
    br(),
    p({style: "text-align:center; margin:0;"},
     img({style: "width: 180px; height: 180px; object-fit: cover; border-radius: 50%; display: inline-block;", alt: "Julian Vargas, Managing Director", src: "./Julian-Vargas.jpg"}),
     br(),
     strong("Julian Vargas"),
     span(" | "),
     a({href: "https://www.linkedin.com/in/julian-david-vargas-alvarez-333b0664/"}, "LinkedIn"),
     br(),
     span("Founder and Managing Director")
    )
  )
end

about_us.run(config: config, state: initial_state).result.bind { |vdom|
  raw_html = render_html(vdom)
  File.open("about-us.html", "w") { |f| f.write(raw_html) }
  Success(nil)
}.or { |error| abort "#{error.join(", ")}" }
