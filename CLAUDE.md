# Agent Guidelines

## Quick Start

- **Local development:** use Homebrew Ruby, not the macOS system Ruby:
  `PATH=/opt/homebrew/opt/ruby/bin:$PATH bundle exec jekyll serve --host 127.0.0.1 --port 4000`
  (site at http://127.0.0.1:4000)
- **Pre-commit:** `npx prettier . --write` (if prettier available)

### Local Server Notes

- Check whether the preview server is already running with `lsof -nP -iTCP:4000 -sTCP:LISTEN`.
- The macOS system Ruby at `/usr/bin/ruby` is too old for this repository and fails because `Gemfile.lock` expects Bundler `4.0.11`.
- If `--livereload` fails because its port is already in use, start the server without livereload using the local development command above and refresh the browser manually.
- Do not pipe `/favicon.ico` through `bust_file_cache`; the cache-bust plugin tries to read it as an absolute filesystem path and the Jekyll build fails.

## Key Files

| File | Purpose |
|------|---------|
| `_pages/about.md` | Main about page (bio, honors, publications toggle) |
| `_layouts/about.liquid` | About page layout |
| `_layouts/bib.liquid` | Publication card layout |
| `_bibliography/papers.bib` | All publications |
| `_sass/_homepage.scss` | Custom homepage styles |
| `_config.yml` | Site configuration |

## Important Rules

- Do NOT delete or modify files in `_includes/`, `_layouts/`, `_plugins/` unless explicitly asked
- The site uses Jekyll + al-folio theme
- Publication images go in `assets/img/publication_preview/`
- Social links are in `_data/socials.yml`
- CV content is in `_data/cv.yml`
