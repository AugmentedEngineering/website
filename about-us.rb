require_relative './shared/site_layout.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

CODE_SAMPLE = ""

resource_path("about-us.html")

about_us = site_layout do
  article(
    h2("About Us"),
    p("Augmented Engineering was founded on the principle that software should be correct by design."),
    p("Our work builds on established disciplines such as Continuous Delivery, Property-based Testing and Formal Methods as operational tools. These methods enable us to construct systems where invalid states are impossible to represent and where correctness is a structural property, not an afterthought."),
    p("We support organisations that require reliable, iterative progress, enabling them to focus on ther objectives rather than the complexities of the technology."),
    p("We deliver software that behaves as specified and evolves without surprises."),
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
