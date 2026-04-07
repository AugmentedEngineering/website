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
