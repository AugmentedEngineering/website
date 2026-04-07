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

  h3 {
    font-size: 1.0625rem;
    font-weight: 600;
    color: #1e3a8a;
    margin-bottom: 0.5rem;
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

  /* Blog posts */
  article {
    padding-bottom: 2.5rem;
    border-bottom: 1px solid #e5e7eb;
  }

  article:last-child {
    border-bottom: none;
    padding-bottom: 0;
  }

  .post-date {
    display: block;
    font-size: 0.8125rem;
    font-weight: 500;
    color: #6b7280;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    margin-bottom: 0.5rem;
  }

  article h2 {
    margin-bottom: 0.5rem;
  }

  .post-summary {
    margin-top: 0.5rem;
  }

  .tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.375rem;
    list-style: none;
    padding-left: 0;
    margin-top: 1rem;
  }

  .tags li {
    font-size: 0.8125rem;
    font-weight: 500;
    color: #1d4ed8;
    background: #eff6ff;
    padding: 0.2rem 0.65rem;
    border-radius: 9999px;
    margin-top: 0;
  }

  sup a {
    font-size: 0.75em;
    font-weight: 600;
    text-decoration: none;
  }

  /* Figure / image */
  figure { margin: 0; }

  figure img {
    display: block;
    width: 100%;
    height: auto;
    border-radius: 0.375rem;
    border: 1px solid #e5e7eb;
  }

  figcaption {
    margin-top: 0.5rem;
    font-size: 0.875rem;
    color: #6b7280;
    text-align: center;
  }

  /* Table */
  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.9375rem;
  }

  caption {
    font-size: 0.875rem;
    color: #6b7280;
    text-align: left;
    margin-bottom: 0.5rem;
    caption-side: top;
  }

  th {
    background: #f9fafb;
    font-weight: 600;
    color: #1f2937;
    padding: 0.625rem 0.875rem;
    text-align: left;
    border-bottom: 2px solid #e5e7eb;
  }

  td {
    padding: 0.625rem 0.875rem;
    color: #374151;
    border-bottom: 1px solid #f3f4f6;
    vertical-align: top;
  }

  tr:last-child td { border-bottom: none; }

  /* Code */
  pre {
    background: #f8fafc;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    padding: 1.25rem 1.5rem;
    overflow-x: auto;
    line-height: 1.7;
  }

  code {
    font-family: 'Cascadia Code', 'Fira Code', Consolas, 'Courier New', monospace;
    font-size: 0.875rem;
    color: #1e3a8a;
  }

  /* References */
  #references { border-top: 1px solid #e5e7eb; padding-top: 1.5rem; }

  #references ol {
    list-style: decimal;
    padding-left: 1.5rem;
  }

  #references li {
    font-size: 0.9375rem;
    color: #374151;
  }

  #references li + li { margin-top: 0.5rem; }

  #references cite { font-style: italic; }

  /* Article */
  article > * + * { margin-top: 1.75rem; }

  .article-summary {
    font-size: 1.0625rem;
    line-height: 1.75;
    color: #374151;
    border-left: 3px solid #1d4ed8;
    padding-left: 1rem;
CSS
