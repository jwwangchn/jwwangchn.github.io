# Agent Guidelines

## Template Lineage

This site is based on the al-folio template:
https://github.com/alshedivat/al-folio/tree/main

Keep al-folio's Jekyll conventions in mind when editing this repository. Directories such as `_pages`, `_layouts`, `_includes`, `_sass`, `_data`, `_plugins`, and `_bibliography` are framework/theme conventions, not arbitrary clutter. Organize files inside those boundaries unless the project is explicitly migrated away from Jekyll/al-folio.

### al-folio Agent Guidelines Reference

The upstream al-folio v1 starter repo uses the following agent conventions:

- Start with `.github/copilot-instructions.md` for architecture, ownership boundaries, and CI expectations.
- Use `docs/BOUNDARIES.md` as the source of truth for starter-vs-plugin ownership.
- Use `.agents/skills/al-folio-bootstrap/SKILL.md` for new-site setup tasks.
- Use `.agents/skills/al-folio-v1-migration/SKILL.md` for customized fork migrations.
- `.codex/skills` and `.claude/skills` are symlinks to `.agents/skills` for agent-specific discovery.
- The starter owns wiring (`Gemfile`, `_config.yml`), starter content/docs, cross-plugin integration tests, and visual regression tests.
- Runtime/component logic belongs in owning plugin repos such as `al_folio_core`, `al_folio_distill`, `al_search`, `al_icons`, `al_cookie`, and other `al-*` gems.
- If a change is starter wiring/docs/integration/visual testing, edit the starter repo. If it is runtime feature behavior, route it to the owning plugin repo.
- Do not add starter-local npm build scripts for theme/runtime assets.
- Keep docs aligned with pluginized v1 ownership.
- If local overrides of plugin-owned files are created or kept, run `bundle exec al-folio upgrade overrides audit` and commit `.al-folio-overrides.yml` after review.

Note: this personal site is a trimmed/customized fork, so not every upstream al-folio v1 path, plugin repo, skill, or validation command exists here. Prefer the local commands and file layout below for this repository.

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
| `_includes/site/` | Site shell includes (head, header, footer, scripts, metadata) |
| `_includes/publications/` | Publication-related includes |
| `_includes/shared/` | Shared template includes |
| `_sass/site/` | Custom site styles |
| `_sass/vendor/` | Third-party Sass partials |
| `_config.yml` | Site configuration |

## Important Rules

- Do NOT delete or modify files in `_includes/`, `_layouts/`, `_plugins/` unless explicitly asked
- The site uses Jekyll + al-folio theme
- Publication images go in `assets/img/publication_preview/`
- Social links are in `_data/socials.yml`
