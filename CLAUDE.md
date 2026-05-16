# Agent Guidelines

## Quick Start

- **Local development:** `bundle exec jekyll serve` (site at http://localhost:4000)
- **Pre-commit:** `npx prettier . --write` (if prettier available)

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
