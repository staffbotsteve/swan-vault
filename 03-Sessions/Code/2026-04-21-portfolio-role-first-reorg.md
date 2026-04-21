---
type: session
date: 2026-04-21
source: claude-code
project: Portfolio (cross-project)
duration: ~2h
status: complete
---

# Portfolio reorganization — role-first template rolled out across 20+ projects

## Task
Replace the earlier 6-bucket project-folder template (`app/ research/ docs/ decks/ assets/ archive/`) with a role-first 7-folder template (`app/ engineering/ marketing/ finance/ legal/ assets/ archive/`) and apply it across Categories A (software), B (entities), and C (real estate).

## Outcome
All 20+ active project folders in `~/project-folders/` now use one consistent organizing axis: the owning role. Software projects ship code from `app/`; entities hold K-1s in `finance/` and contracts in `legal/`; real estate holds loan docs in `finance/` and deeds/lawsuits in `legal/`. Zero empty placeholders — only role folders with actual content exist. Three software sub-projects (`providence-heli-watch`, `blackhawk-rescue-hero`, `incline-glide-transport`) promoted to top-level. Three empty folders deleted (`paperclip`, `personal-assistant`, `swanbill-sis`). New CB Extravaganza project cloned into the fresh structure as the next focus area.

## Decisions
- **Role-first wins over output-type.** Earlier 6-bucket mixed output-type (`docs/`, `decks/`) and had implicit role overlap (a pitch deck → `decks/` or `marketing/`?). One axis removes ambiguity.
- **Only create role folders with content.** Empty folders violate the anxiety-reducing goal of rigid structure; the template is a *shape*, not a *requirement to populate*.
- **Software sub-projects promote to top-level.** Nested software under entity parents fragments discoverability and conflicts with the MOC's flat model. Entities keep their own docs; software siblings move up.
- **GitHub repos unchanged.** All remote URLs preserved. Lovable sync, CI, and deploy wiring undisturbed. Only local folder names were renamed.
- **CB Extravaganza added to MOC** as a Personal → CBHS philanthropic project with new `cbextravaganza` repo cloned to `app/`.

## Files changed

**Memory (ignition layer):**
- `reference-project-folders.md` — rewrote for role-first template
- `feedback-rigid-structure.md` — updated template reference
- `MEMORY.md` — updated pointer

**Vault:**
- New: `05-Reference/templates/project-folder.md` — canonical template doc with mapping guidance for edge cases
- New: `01-Projects/CB-Extravaganza/CONTEXT.md` — stub for next focus session
- New: `03-Sessions/Code/2026-04-21-portfolio-role-first-reorg.md` (this file)
- Updated: `01-Projects/PROJECTS-MOC.md` — folder paths for 3 promoted projects, new CBE row
- Updated: `01-Projects/Project-Falcon/CONTEXT.md` — folder-layout section reflects role-first
- Updated: `00-System/agent-ecosystem.md` + `diagrams/agent-ecosystem.svg` — projects band shows new template

**Filesystem (`~/project-folders/`):**
- **Category A (software)** — `sosfiler`, `permitvantage`, `rampvantage`, `sleepy-storybook`, `swan-command-center`, `swanbill`, `oz-lease-scout`, `openclaw`: `repo/` → `app/` (or `site/` → `app/`)
- **Category B (entities)** — `e2s-hospitality-california`, `e2s-hospitality-nv`, `providence-fire-rescue`, `incline-tahoe-executive-transport`: K-1s, subscription docs, wires → `finance/` or `legal/`; operations manuals → `engineering/`; regulatory submissions → `legal/`; logos/branding → `marketing/`
- **Category C (real estate)** — `7702-n-silvercrest`, `6040-n-camelback`, `mountain-shadows-4120`, `623-tyner-way`, `5909-e-sanna`: contracts/lawsuits/entity docs → `legal/`; loan docs/statements/budgets → `finance/`; plans/renderings/structural → `engineering/`; walkthrough HTML → `marketing/`; zip artifacts → `archive/`; photos → `marketing/photos/`; CAD drawings → `engineering/drawings/`
- **Sub-project promotion** — `providence-heli-watch`, `blackhawk-rescue-hero` (from `providence-fire-rescue/`); `incline-glide-transport` (from `incline-tahoe-executive-transport/`). Each: `repo/` → `app/`.
- **Deletions** — `paperclip/`, `personal-assistant/`, `swanbill-sis/` (empty); MS Office temp files (`~$*`), `.DS_Store` across real estate folders.
- **New project** — `cb-extravaganza/` with repo cloned to `app/`, existing files scattered to `marketing/` and `assets/`.
- **Project Falcon** — redone to match new template: `research/` → `engineering/research/`; `docs/*` split by audience into `engineering/` (PM/technical) and `marketing/` (white paper, stakeholder); `decks/*` → `marketing/decks/`.

## Blocked / Needs input
- **`paperclip/` and `personal-assistant/` MOC rows** — projects still exist (paperclip runs on the droplet) but local folders deleted. Rows left in MOC with existing folder paths; syncing work down later will recreate the folders. Flag for decision: keep rows or remove them.
- **Providence parent folder** — entity docs now split across role folders. The `providence-fire-rescue/` project in the MOC remains as the parent entity; software work lives at the promoted top-level folders.

## Next steps
- **Focus on CB Extravaganza.** Populate `01-Projects/CB-Extravaganza/CONTEXT.md` with event details, stakeholders, website stack, and improvements planned.
- **Write per-project READMEs** for the restructured projects as they become active work (done for Project Falcon + CB Extravaganza).
- **Populate remaining 25+ CONTEXT.md files** in the vault as projects come into focus.
- **Decide MOC cleanup** for deleted-locally projects (paperclip, personal-assistant).

## Related
- [[05-Reference/templates/project-folder]]
- [[01-Projects/PROJECTS-MOC]]
- [[01-Projects/Project-Falcon/CONTEXT]]
- [[01-Projects/CB-Extravaganza/CONTEXT]]
- [[00-System/agent-ecosystem]]
- [[03-Sessions/Code/2026-04-21-project-falcon-context]] — earlier session today
