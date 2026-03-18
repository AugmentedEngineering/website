# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Build** (generates `index.html`):
```bash
ruby augen-index.rb
```

**Install dependencies:**
```bash
bundle install
```

## Architecture

This is a static website for Augmented Engineering UG. The entire site is defined in a single Ruby file (`augen-index.rb`) using the `html-canonical` DSL — a Ruby library located at `../html-canonical/` (a sibling directory, referenced via `require_relative`).

**How it works:**
1. `*.rb` define web pages using Ruby method calls that map to HTML elements (`html`, `head`, `body`, `section`, etc.)
2. The DSL returns a monadic computation (using `dry-monads`) that is run with an `HtmlConfig` and initial state
3. The result is rendered to a raw HTML string via `render_html(vdom)` and written to `*.html`
4. `*.html` is `.gitignore`d — it is always a generated artifact

**Styling:** Tailwind CSS v4 loaded via CDN (`@tailwindcss/browser`). No build step for CSS.

**Key dependency:** The `html-canonical` gem enforces semantic correctness — invalid HTML states are structurally impossible to represent. When editing markup, follow the HTML content model strictly (e.g., don't place block elements inside `<p>`).

## html-canonical DSL

Use the `hcanonical` skill (`/hcanonical`) when writing or editing HTML with this DSL. Key rules:
1. Structure must be semantic and accessible (screen-reader compatible)
2. Avoid unnecessary nesting
3. Always follow content models as defined in the HTML Living Standard

## Workflows

**Page Creation Loop:**
When asked to generate a new page (e.g., "about-us"):
1. **Create:** Generate `<page-name>.rb` using the `html-canonical` DSL. Follow existing patterns in `augen-index.rb`.
2. **Verify:** Run `bundle exec ruby <page-name>.rb` immediately after creation.
3. **Validate:** Success is defined by the generation of a corresponding `<page-name>.html` file without errors.
4. **Fix & Retry:** If the command fails or returns an error, analyze the error message, correct `<page-name>.rb`, and re-run step 2.
5. **Loop:** Repeat this cycle autonomously until the `.html` artifact is successfully generated.

