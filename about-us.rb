require_relative './shared/site_layout.rb'

config = HtmlConfig.new(theme: 'dark', auto_id_prefix: 'field')
initial_state = 1

CODE_SAMPLE = <<~TLA
  ---- MODULE TransferFunds ----
  EXTENDS Naturals

  VARIABLES sender, receiver

  TypeInvariant ==
    /\\ sender   \\in Nat
    /\\ receiver \\in Nat

  BalanceInvariant == sender + receiver = 100

  Init ==
    /\\ sender   = 100
    /\\ receiver = 0

  Transfer(amount) ==
    /\\ amount > 0
    /\\ amount <= sender
    /\\ sender'   = sender   - amount
    /\\ receiver' = receiver + amount

  Spec == Init /\\ [][\\E n \\in 1..sender : Transfer(n)]_<<sender, receiver>>

  THEOREM Spec => [](TypeInvariant /\\ BalanceInvariant)
  ====
TLA

about_us = site_layout do
  article(
    h2("Correctness by Construction: How We Build Software"),

    p({ class: "article-summary" },
      "Most software fails not because its authors lacked skill, but because the tools and " \
      "processes around them made failure easy to express. We take the opposite approach: " \
      "every layer of our stack is designed to make incorrect states structurally impossible " \
      "to represent — from the type system down to the markup."
    ),

    ul({ class: "tags" },
      li("formal-methods"),
      li("type-safety"),
      li("standards"),
      li("ruby")
    ),

    # --- Paragraph 1 ---
    p("The cost of informal software development is rarely visible until it is catastrophic. " \
      "Dijkstra observed decades ago that the difficulty of programming is intrinsic to its " \
      "complexity, and that no silver bullet removes it",
      sup(a({ href: "#cite-1" }, "[1]")),
      ". What tooling can do is remove the accidental complexity — the errors that arise not " \
      "from hard problems but from nothing stopping you from writing them. When a type system " \
      "or a DSL enforces the content model of a language, an entire class of defects disappears " \
      "before a test is written. Leveson's analysis of safety-critical failures consistently " \
      "points to informal specifications as the root cause, not individual programmer error",
      sup(a({ href: "#cite-2" }, "[2]")),
      "."
    ),

    # --- Paragraph 2 ---
    p("Formal specification changes the equation by making behaviour a first-class artefact. " \
      "A TLA+ model of a funds-transfer protocol, for instance, can be exhaustively checked " \
      "against invariants — balance conservation, atomicity, absence of negative accounts — " \
      "before a single line of implementation code is written",
      sup(a({ href: "#cite-3" }, "[3]")),
      ". Violations surface in the model checker at design time, not in production at 2 AM. " \
      "This is not academic rigour for its own sake: it is the cheapest possible point at " \
      "which to catch a defect."
    ),

    # --- Paragraph 3 ---
    p("At the implementation level, type safety provides the same guarantee mechanically. " \
      "Pierce's foundational result — that a well-typed programme cannot go wrong — translates " \
      "directly into library design",
      sup(a({ href: "#cite-4" }, "[4]")),
      ". Our html-canonical DSL encodes the HTML Living Standard's content model as Ruby types: " \
      "placing a block element inside a paragraph is rejected at the DSL layer, not discovered " \
      "via browser inspection. The same principle applies across our tooling: if the type " \
      "system can enforce a constraint, it should."
    ),

    # --- Figure ---
    figure(
      img({
        src: "formal-pipeline.svg",
        alt: "Diagram showing the pipeline from TLA+ specification through type-safe " \
             "implementation to generated HTML artefact, with invariant checks at each stage",
        width: "896",
        height: "400"
      }),
      figcaption(
        "Figure 1. The Augmented Engineering development pipeline: specification, " \
        "type-safe implementation, and generated artefacts — each stage mechanically " \
        "constrained by the one before it."
      )
    ),

    # --- Table ---
    table(
      caption("Table 1. Informal vs. formal development across key quality dimensions."),
      thead(
        tr(
          th("Dimension"),
          th("Informal approach"),
          th("Formal approach")
        )
      ),
      tbody(
        tr(
          td("Defect detection"),
          td("Testing — finds defects that were thought to test for"),
          td("Model checking — exhausts the reachable state space")
        ),
        tr(
          td("Specification"),
          td("Natural language, implicitly understood"),
          td("Machine-readable, verifiable against implementation")
        ),
        tr(
          td("Auditability"),
          td("Requires reconstructing intent from code"),
          td("Specification is a deliverable; intent is explicit")
        ),
        tr(
          td("Certification effort"),
          td("High — evidence gathered post-hoc"),
          td("Low — artefacts produced continuously during development")
        ),
        tr(
          td("Invalid-state exposure"),
          td("Runtime — guarded by defensive checks"),
          td("Compile-time or design-time — structurally impossible")
        )
      )
    ),

    # --- Code ---
    figure(
      pre(
        code(CODE_SAMPLE)
      ),
      figcaption(
        "Listing 1. A TLA+ module specifying a funds-transfer invariant. " \
        "The model checker verifies that sender + receiver = 100 holds " \
        "across every reachable state before any implementation is written."
      )
    ),

    # --- References ---
    section({ id: "references", "aria-labelledby": "h-references" },
      h3({ id: "h-references" }, "References"),
      ol(
        li({ id: "cite-1" },
          cite("Dijkstra, E. W."),
          " (1972). \"The Humble Programmer.\" ",
          cite("Communications of the ACM"),
          ", 15(10), 859–866. ACM Turing Award Lecture."
        ),
        li({ id: "cite-2" },
          cite("Leveson, N. G."),
          " (1995). ",
          cite("Safeware: System Safety and Computers"),
          ". Addison-Wesley. ISBN 0-201-11972-2."
        ),
        li({ id: "cite-3" },
          cite("Lamport, L."),
          " (2002). ",
          cite("Specifying Systems: The TLA+ Language and Tools for Hardware and Software Engineers"),
          ". Addison-Wesley. ISBN 0-321-14306-X."
        ),
        li({ id: "cite-4" },
          cite("Pierce, B. C."),
          " (2002). ",
          cite("Types and Programming Languages"),
          ". MIT Press. ISBN 0-262-16209-1."
        )
      )
    )
  )
end

about_us.run(config: config, state: initial_state).result.bind { |vdom|
  raw_html = render_html(vdom)
  File.open("about-us.html", "w") { |f| f.write(raw_html) }
  Success(nil)
}.or { |error| abort "#{error.join(", ")}" }
